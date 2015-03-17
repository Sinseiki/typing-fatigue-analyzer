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

require_relative './key.rb'
require_relative './hand.rb'
require_relative './parameters.rb'

class Keyboard
  def initialize(keys)
    @keys = keys
    @keys.each_value do |key|
      key.polar_coord = polar_coord(key)
      key.penalty     = penalty(key)
    end
  end
  attr_accessor :keys

  def key(symbol)
    return @keys[symbol]
  end

  def home_key(finger: nil, key: nil)
    return nil if finger.nil? && key.nil?
    finger = key.finger if finger.nil?

    if finger.hand == $left_hand
      return case finger.number
        when 2
          key('f')
        when 3
          key('d')
        when 4
          key('s')
        when 5
          key('a')
        end
    else
      return case finger.number
        when 2
          key('j')
        when 3
          key('k')
        when 4
          key('l')
        when 5
          key(';')
        end
    end
  end

  def polar_coord(key)
    home = home_key(key: key).coordinate
    #if key.hand == 'left'
    if key.hand == $left_hand
      #puts "hell yeah"
      center_x = key('f').x - $center_dx
      center_y = key('f').y - $center_dy
    else
      center_x = key('j').x + $center_dx
      center_y = key('j').y - $center_dy
    end
    center = [center_x, center_y]

    home_radius, home_angle = cart_to_polar(home[0] - center[0], home[1] - center[1])
    key_radius,  key_angle  = cart_to_polar(key.x - center[0],   key.y - center[1])

    radius = key_radius - home_radius
    angle  = key_angle  - home_angle

    if angle < -1.5
      angle += 3.1416
    elsif angle > 1.5
      angle -= 3.1416
    end

    angle *= ($center_dx**2 + $center_dy**2)**0.5

    # for convenience, plus if inward
    #angle *= key.hand == 'left' ? -1 : 1
    angle *= key.hand == $left_hand ? -1 : 1

    return [radius, angle]
  end

  def penalty(key)
    radius, angle = polar_coord(key)

    #index = key.hand == 'left' ? 5 - key.finger.number : 2 + key.finger.number
    index = key.hand == $left_hand ? 5 - key.finger.number : 2 + key.finger.number

    radial_burden  = [radius, $stretch_max[index]].min**2
    radial_burden *= $curling_weight if radius < 0

    hand_burden = radius > $stretch_max[index] ? radius - $stretch_max[index] : 0

    angular_burden  = angle**2
    angular_burden *= $outward_weight if angle < 0

    finger_burden = $finger_burdens[index]

    radial_burden  *= $radial_weight
    hand_burden    *= $hand_weight
    angular_burden *= $angular_weight
    finger_burden  *= $finger_weight

    #return [radial_burden, hand_burden, angular_burden, finger_burden]
    return radial_burden + hand_burden + angular_burden + finger_burden
  end

  def radial_diff(key1, key2)
    if key1.finger == key2.finger
      return key2.r - key1.r
    else
      return key2.r
    end
  end

  def angular_diff(key1, key2)
    if key1.hand == key2.hand
      return key2.a - key1.a
    else
      return key2.a
    end
  end
      
  def dist(key1, key2)
    dx = key2.x - key1.x
    dy = key2.y - key1.y

    return Math.sqrt(dx**2 + dy**2)
  end
end

def cart_to_polar(dx, dy)
  radius = Math.sqrt(dx**2 + dy**2)
  angle  = Math.atan(dy / dx)

  return [radius, angle]
end

row_offsets = [0.0, 0.5, 0.75, 1.25]
row_ycoords = [3.0, 2.0, 1.0, 0.0]
yaxis_scale_factor = 1

keys = {
  '1'  => Key.new('1',  1,  $left_hand.finger(4), [0  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '2'  => Key.new('2',  1,  $left_hand.finger(4), [1  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '3'  => Key.new('3',  1,  $left_hand.finger(3), [2  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '4'  => Key.new('4',  1,  $left_hand.finger(3), [3  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '5'  => Key.new('5',  1,  $left_hand.finger(2), [4  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '6'  => Key.new('6',  1,  $left_hand.finger(2), [5  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '7'  => Key.new('7',  1, $right_hand.finger(2), [6  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '8'  => Key.new('8',  1, $right_hand.finger(3), [7  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '9'  => Key.new('9',  1, $right_hand.finger(3), [8  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '0'  => Key.new('0',  1, $right_hand.finger(4), [9  + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '-'  => Key.new('-',  1, $right_hand.finger(4), [10 + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '='  => Key.new('=',  1, $right_hand.finger(4), [11 + row_offsets[0], row_ycoords[0] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'q'  => Key.new('q',  2,  $left_hand.finger(5), [0  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'w'  => Key.new('w',  2,  $left_hand.finger(4), [1  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'e'  => Key.new('e',  2,  $left_hand.finger(3), [2  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'r'  => Key.new('r',  2,  $left_hand.finger(2), [3  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  't'  => Key.new('t',  2,  $left_hand.finger(2), [4  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'y'  => Key.new('y',  2, $right_hand.finger(2), [5  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'u'  => Key.new('u',  2, $right_hand.finger(2), [6  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'i'  => Key.new('i',  2, $right_hand.finger(3), [7  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'o'  => Key.new('o',  2, $right_hand.finger(4), [8  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'p'  => Key.new('p',  2, $right_hand.finger(5), [9  + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '['  => Key.new('[',  2, $right_hand.finger(5), [10 + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  ']'  => Key.new(']',  2, $right_hand.finger(5), [11 + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '\\' => Key.new('\\', 2, $right_hand.finger(5), [12 + row_offsets[1], row_ycoords[1] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'a'  => Key.new('a',  3,  $left_hand.finger(5), [0  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  's'  => Key.new('s',  3,  $left_hand.finger(4), [1  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'd'  => Key.new('d',  3,  $left_hand.finger(3), [2  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'f'  => Key.new('f',  3,  $left_hand.finger(2), [3  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'g'  => Key.new('g',  3,  $left_hand.finger(2), [4  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'h'  => Key.new('h',  3, $right_hand.finger(2), [5  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'j'  => Key.new('j',  3, $right_hand.finger(2), [6  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'k'  => Key.new('k',  3, $right_hand.finger(3), [7  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'l'  => Key.new('l',  3, $right_hand.finger(4), [8  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  ';'  => Key.new(';',  3, $right_hand.finger(5), [9  + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  "'"  => Key.new("'",  3, $right_hand.finger(5), [10 + row_offsets[2], row_ycoords[2] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'z'  => Key.new('z',  4,  $left_hand.finger(5), [0  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'x'  => Key.new('x',  4,  $left_hand.finger(4), [1  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'c'  => Key.new('c',  4,  $left_hand.finger(3), [2  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'v'  => Key.new('v',  4,  $left_hand.finger(2), [3  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'b'  => Key.new('b',  4,  $left_hand.finger(2), [4  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'n'  => Key.new('n',  4, $right_hand.finger(2), [5  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  'm'  => Key.new('m',  4, $right_hand.finger(3), [6  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  ','  => Key.new(',',  4, $right_hand.finger(4), [7  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '.'  => Key.new('.',  4, $right_hand.finger(5), [8  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0),
  '/'  => Key.new('/',  4, $right_hand.finger(5), [9  + row_offsets[3], row_ycoords[3] * yaxis_scale_factor], [0.0, 0.0], 0.0)
}

@standard_keyboard = Keyboard.new(keys)
