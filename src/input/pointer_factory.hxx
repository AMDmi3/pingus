//  $Id: pointer_factory.hxx,v 1.3 2002/08/24 11:37:30 torangan Exp $
// 
//  Pingus - A free Lemmings clone
//  Copyright (C) 2000 Ingo Ruhnke <grumbel@gmx.de>
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
// 
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

#ifndef HEADER_PINGUS_INPUT_POINTER_FACTORY_HXX
#define HEADER_PINGUS_INPUT_POINTER_FACTORY_HXX

#include "../libxmlfwd.hxx"

namespace Input {

  namespace Pointers {
    class Pointer;
  }

  class PointerFactory 
  {
    private:
      static inline Pointers::Pointer* axis_pointer     (xmlNodePtr cur);
      static inline Pointers::Pointer* mouse_pointer    ();
      static inline Pointers::Pointer* multiple_pointer (xmlNodePtr cur);
    
    public:
      static Pointers::Pointer* create (xmlNodePtr cur);
      
    private:
      PointerFactory ();
      PointerFactory (const PointerFactory&);
      PointerFactory operator= (const PointerFactory&);
  };
}

#endif

/* EOF */
