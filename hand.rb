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

require_relative './parameters.rb'

class Finger
  def initialize(hand, number, burden, stretch_max, stroke, effort)
    @hand = hand
    @number = number
    @burden = burden
    @stretch_max = stretch_max
    @stroke = stroke
    @effort = effort
  end
  attr_accessor :hand, :number, :burden, :stretch_max, :stroke, :effort
end

class Hand
  def initialize(which_hand, fingers)
    @which_hand = which_hand
    @fingers = fingers
  end
  attr_accessor :which_hand, :fingers

  def finger(num)
    return fingers[num - 2]
  end

  def effort
    counter = 0.0

    fingers.each_value do |finger|
      counter += finger.effort
    end

    return counter
  end

  def stroke
    counter = 0

    fingers.each_value do |finger|
      counter += finger.stroke
    end

    return counter
  end
end

$left_hand  = Hand.new('left', [])
$right_hand = Hand.new('right', [])

$left_hand.fingers << Finger.new($left_hand, 2, $finger_burdens[3], $stretch_max[3], 0, 0.0)
$left_hand.fingers << Finger.new($left_hand, 3, $finger_burdens[2], $stretch_max[2], 0, 0.0)
$left_hand.fingers << Finger.new($left_hand, 4, $finger_burdens[1], $stretch_max[1], 0, 0.0)
$left_hand.fingers << Finger.new($left_hand, 5, $finger_burdens[0], $stretch_max[0], 0, 0.0)

$right_hand.fingers << Finger.new($right_hand, 2, $finger_burdens[4], $stretch_max[4], 0, 0.0)
$right_hand.fingers << Finger.new($right_hand, 3, $finger_burdens[5], $stretch_max[5], 0, 0.0)
$right_hand.fingers << Finger.new($right_hand, 4, $finger_burdens[6], $stretch_max[6], 0, 0.0)
$right_hand.fingers << Finger.new($right_hand, 5, $finger_burdens[7], $stretch_max[7], 0, 0.0)

$hands = [$left_hand, $right_hand]
