//  Pingus - A free Lemmings clone
//  Copyright (C) 1999 Ingo Ruhnke <grumbel@gmx.de>
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

#ifndef HEADER_PINGUS_PINGUS_ACTIONS_FLOATER_HPP
#define HEADER_PINGUS_PINGUS_ACTIONS_FLOATER_HPP

#include "engine/display/sprite.hpp"
#include "pingus/pingu_action.hpp"

namespace Actions {

class Floater : public PinguAction
{
private:
  int falling_depth;
  int step;
  Sprite sprite;

public:
  Floater(Pingu* p);

  ActionName::Enum get_type() const { return ActionName::FLOATER; }

  void init(void);

  void draw (SceneContext& gc);
  void update();

  char get_persistent_char () { return 'f'; }
  bool change_allowed (ActionName::Enum new_action);

private:
  Floater (const Floater&);
  Floater& operator= (const Floater&);
};

} // namespace Actions

#endif

/* EOF */
