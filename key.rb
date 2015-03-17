=begin
Copyright (c) 2015 isty2e

This file is part of Typing fatigue analyzer.

Typing fatigue analyzer is free software: you can redistribute it and/or 
modify it under the terms of the GNU General Public License as published 
by the Free Software Foundation; either version 3 of the License, or 
(at your option) any later version.

Typing fatigue analyzer is distributed in the hope that it will be 
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
General Public License for more details.

You should have received a copy of the GNU General Public License along 
with Typing fatigue analyzer; if not, see <http://www.gnu.org/licenses/>.
=end

require_relative './hand.rb'

class Key
  def initialize(symbol, row, finger, coordinate, polar_coord, penalty)
    @symbol      = symbol
    @row         = row
    @finger      = finger
    @coordinate  = coordinate
    @polar_coord = polar_coord
    @penalty     = penalty
  end
  attr_accessor :symbol, :row, :finger, :coordinate, :polar_coord, :penalty

  def hand
    return @finger.hand
  end

  def x
    return coordinate[0]
  end

  def y
    return coordinate[1]
  end

  def r
    return polar_coord[0]
  end
  
  def a
    return polar_coord[1]
  end
end
