//  Pingus - A free Lemmings clone
//  Copyright (C) 1998-2011 Ingo Ruhnke <grumbel@gmx.de>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "pingus/prefab_file.hpp"

#include <stdexcept>

#include "util/file_reader.hpp"
#include "util/log.hpp"
#include "util/raise_exception.hpp"
#include "util/system.hpp"

PrefabFile
PrefabFile::from_path(const Pathname& filename)
{
  FileReader reader = FileReader::parse(filename);

  if (reader.get_name() != "pingus-prefab")
  {
    raise_exception(std::runtime_error, "Error: " << filename.str() << ": not a 'pingus-prefab' file");
  }
  else
  {
    FileReader overrides;
    reader.read_section("overrides", overrides);

    FileReader objects;
    if (!reader.read_section("objects", objects) || objects.get_sections().empty())
    {
      raise_exception(std::runtime_error, "Error: " << filename.str() << ": empty prefab file");
    }
    else
    {
      // FIXME: Hacky way to get the Prefab name
      PrefabFile prefab(System::cut_file_extension(filename.get_raw_path()),
                        objects.get_sections(), overrides);
      return prefab;
    }
  }
}

PrefabFile
PrefabFile::from_resource(const std::string& name)
{
  Pathname filename(name + ".prefab", Pathname::DATA_PATH);
  return from_path(filename);
}

PrefabFile::PrefabFile(const std::string& name, const std::vector<FileReader>& objects,
                       const FileReader& overrides) :
  m_name(name),
  m_objects(objects),
  m_overrides(overrides)
{
}

const std::vector<FileReader>&
PrefabFile::get_objects() const
{
  return m_objects;
}

FileReader
PrefabFile::get_overrides() const
{
  return m_overrides; 
}

/* EOF */
