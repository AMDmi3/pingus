//  $Id: Cloud.hh,v 1.1 2000/02/11 21:22:11 grumbel Exp $
//
//  Pingus - A free Lemmings clone
//  Copyright (C) 1999 Ingo Ruhnke <grumbel@gmx.de>
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

#ifndef CLOUD_HH
#define CLOUD_HH

#include "../GameCounter.hh"
#include "../Entrance.hh"

class Cloud : public Entrance
{
private:
public:
  Cloud(entrance_data);

  void let_move(void);
  void draw_offset(int x, int y, float s = 1.0);
};

#endif

/* EOF */

