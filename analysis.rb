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

require_relative './parse.rb'
require_relative './parameters.rb'
require_relative './key.rb'
require_relative './keyboard.rb'
require_relative './keyboard_layout.rb'
require 'rubygems'

class Analysis
  def initialize(jamo_data, keyboard, layout)
    @keyboard    = keyboard
    @layout      = layout
    t1 = Time.now
    @symbols     = jamo_data.inject('') { |sum, jamos| sum << layout.convert(jamos) }.gsub('FN', '')
    @symbols_arr = @symbols.gsub('N', '').gsub('F', '').split('')
    #puts "init: #{Time.now - t1}"
  end
  attr_accessor :keyboard, :layout, :symbols, :symbols_arr

  def key(symbol)
    return @keyboard.keys[symbol]
  end

  def home_key(symbol: nil, key: nil)
    key = key(symbol) if key.nil?
    return @keyboard.home_key(key: key)
  end

  def count_strokes
    return @symbols_arr.length + @symbols.count('N')
  end

  def count_shift
    return @symbols.count('N')
  end

  def shift_ratio
    return count_shift / count_strokes.to_f
  end

  def row_distribution
    row_counter = [0, 0, 0, 0]

    @symbols_arr.each do |symbol|
      key = key(symbol)
      row_counter[key.row - 1] += 1
    end

    return row_counter
  end

  def row_distribution_ratio
    row_d = row_distribution
    
    return row_d.map { |count| count.to_f / row_d.inject(:+) }
  end

  def finger_distribution
    finger_counter = [0] * 8

    @symbols_arr.each do |symbol|
      key = key(symbol)
      #if key.hand == 'left'
      if key.hand == $left_hand
        finger_index = 5 - key.finger.number
        finger_counter[finger_index] += 1
      else
        finger_index = 2 + key.finger.number
        finger_counter[finger_index] += 1
      end
    end

    return finger_counter
  end

  def finger_distribution_ratio
    finger_d = finger_distribution
    
    return finger_d.map { |count| count.to_f / finger_d.inject(:+) }
  end

  def hand_distribution
    hand_counter = [0, 0]

    @symbols_arr.each do |symbol|
      key = key(symbol)
      #index = key.hand == 'left' ? 0 : 1
      index = key.hand == $left_hand ? 0 : 1
      hand_counter[index] += 1
    end

    return hand_counter
  end

  def hand_distribution_ratio
    hand_d = hand_distribution
    
    return hand_d.map { |count| count.to_f / hand_d.inject(:+) }
  end

  def count_same_finger_digraphs
    counter = 0

    (1..@symbols_arr.length - 1).each do |i|
      counter += 1 if @symbols_arr[i] == @symbols_arr[i - 1]
    end

    return counter
  end

  def same_finger_digraphs_ratio
    return count_same_finger_digraphs.to_f / (@symbols_arr.length - 1)
  end

  def count_same_finger
    counter = 0

    (1..@symbols_arr.length - 1).each do |i|
      key1 = key(@symbols_arr[i - 1])
      key2 = key(@symbols_arr[i])
      counter += 1 if key1.finger == key2.finger
    end

    return counter
  end

  def same_finger_ratio
    return count_same_finger.to_f / (@symbols_arr.length - 1)
  end

  def count_same_hand
    counter = 0

    (1..@symbols_arr.length - 1).each do |i|
      key1 = key(@symbols_arr[i - 1])
      key2 = key(@symbols_arr[i])
      counter += 1 if key1.hand == key2.hand
    end

    return counter
  end

  def same_hand_ratio
    return count_same_hand.to_f / (@symbols_arr.length - 1)
  end

  def same_hand_duration
    counter = 0
    survival_duration = []

    (1..@symbols_arr.length - 1).each do |i|
      key1 = key(@symbols_arr[i - 1])
      key2 = key(@symbols_arr[i])
      counter += 1
      if (key1.hand != key2.hand) || (i == @symbols_arr.length)
        survival_duration << counter
        counter = 0
      end
    end

    return (1..survival_duration.max).map { |i| survival_duration.count(i) }
  end

  def mean_distance
    dist = 0.0

    (1..@symbols_arr.length - 1).each do |i|
      key1 = key(@symbols_arr[i - 1])
      key2 = key(@symbols_arr[i])

      dist += @keyboard.dist(key1, key2)
    end

    return dist / (@symbols_arr.length - 1)
  end

  def lh_digraph_distribution
    distribution = Array.new(4) { |_i| Array.new(4, 0.0) }

    (1..@symbols_arr.length - 1).each do |i|
      key1 = key(@symbols_arr[i - 1])
      key2 = key(@symbols_arr[i])

      if (key1.hand == key2.hand) && (key1.hand == $left_hand)
        distribution[key1.finger.number - 2][key2.finger.number - 2] += 1
      end
    end

    total_stroke = distribution.inject(0) { |sum, row| sum += row.inject(:+) }

    (0..3).each do |i|
      (0..3).each do |j|
        distribution[i][j] /= total_stroke
      end
    end

    return distribution
  end

  def pair_base_effort(x1, x2, weight)
    if x1 * x2 < 0
      if x1 > 0
        return x1 * x1 + weight * x2 * x2
      else
        return x1 * x1 + x2 * x2
      end
    else
      dx = x2 - x1
      if (dx < 0) && (x2 < 0)
        return weight * dx * dx
      else
        return dx * dx
      end
    end
  end

  def radial_base_effort(key1, key2)
    if key1.finger == key2.finger
      r1, r2 = key1.r, key2.r

      return pair_base_effort(r1, r2, $curling_weight)
    else
      return 0.0
    end

    return effort
  end

  def angular_base_effort(key1, key2)
    if key1.hand == key2.hand
      a1, a2 = key1.a, key2.a

      return pair_base_effort(a1, a2, $outward_weight)
    else
      return 0.0
    end

    return effort
  end

  def triad_radial_base_effort(symbol1, symbol2, symbol3)
    key1, key2, key3 = key(symbol1), key(symbol2), key(symbol3)

    if key1.hand == key2.hand
      if key2.hand == key3.hand # 1 = 2 = 3
        effort = radial_base_effort(key1, key2) + radial_base_effort(key2, key3)

        dr1, dr2 = key2.r - key1.r, key3.r - key2.r

        effort *= $inversion_penalty if dr1 * dr2 < 0
      else                      # 1 = 2
        effort = radial_base_effort(key1, key2) + radial_base_effort(home_key(key: key3), key3)
      end
    else
      if key2.hand == key3.hand # 2 = 3
        effort = radial_base_effort(key2, key3) + radial_base_effort(home_key(key: key1), key1)
      else                      # 1 = 3
        effort = radial_base_effort(key1, key3) + radial_base_effort(home_key(key: key2), key2)
      end
    end

    return effort
  end

  def triad_angular_base_effort(symbol1, symbol2, symbol3)
    key1, key2, key3 = key(symbol1), key(symbol2), key(symbol3)

    if key1.hand == key2.hand
      if key2.hand == key3.hand # 1 = 2 = 3
        effort = angular_base_effort(key1, key2) + angular_base_effort(key2, key3)

        da1, da2 = key2.a - key1.a, key3.a - key2.a

        effort *= $inversion_penalty if da1 * da2 < 0
      else                      # 1 = 2
        effort = angular_base_effort(key1, key2) + angular_base_effort(home_key(key: key3), key3)
      end
    else
      if key2.hand == key3.hand # 2 = 3
        effort = angular_base_effort(key2, key3) + angular_base_effort(home_key(key: key1), key1)
      else                      # 1 = 3
        effort = angular_base_effort(key1, key3) + angular_base_effort(home_key(key: key2), key2)
      end
    end

    return effort
  end

  def base_efforts
    radial_efforts, angular_efforts = [], []

    t1 = Time.now

    (2...@symbols_arr.length).each do |i|
      radial_effort = triad_radial_base_effort(@symbols_arr[i - 2], @symbols_arr[i - 1], @symbols_arr[i])
      radial_efforts << radial_effort
    end

    mean_radial_effort = radial_efforts.inject(:+) / radial_efforts.length
    #puts "radial time: #{Time.now - t1}"

    t2 = Time.now
    (2...@symbols_arr.length).each do |i|
      angular_effort = triad_angular_base_effort(@symbols_arr[i - 2], @symbols_arr[i - 1], @symbols_arr[i])
      angular_efforts << angular_effort
    end

    mean_angular_effort = angular_efforts.inject(:+) / angular_efforts.length
    #puts "angular time: #{Time.now - t2}"

    return [mean_radial_effort, mean_angular_effort]
  end

  def base_effort
    radial_effort, angular_effort = base_efforts

    return $radial_weight * radial_effort + $angular_weight * angular_effort
  end

  def triad_penalty_effort(symbol1, symbol2, symbol3)
    key1, key2, key3 = key(symbol1), key(symbol2), key(symbol3)

    return (key1.penalty + key2.penalty + key3.penalty) / 3
  end

  def penalty_effort
    effort = 0.0

    t1 = Time.now
    (2...@symbols_arr.length).each do |i|
      effort += triad_penalty_effort(@symbols_arr[i - 2], @symbols_arr[i - 1], @symbols_arr[i])
    end

    effort += $shift_penalty * count_shift
    #puts "penalty time: #{Time.now - t1}"

    return effort / (@symbols_arr.length - 2)
  end

  def digraph_stroke_effort(key1, key2)
    finger_stroke = 
      if key1 == key2 
        2
      elsif key1.finger != key2.finger
        0
      elsif @keyboard.radial_diff(key1, key2) < $radial_threshold
        2.5
      else
        3
      end
    finger_stroke /= 6.0
    
    return finger_stroke
  end

  def triad_stroke_effort(symbol1, symbol2, symbol3)
    key1, key2, key3 = key(symbol1), key(symbol2), key(symbol3)
    
    hand_stroke = 
      if key1.hand != key3.hand
        0
      elsif key1.hand != key2.hand
        1
      else
        2
      end
    hand_stroke /= 2.0

    if key1.hand != key2.hand
      if key2.hand == key3.hand
        finger_stroke = digraph_stroke_effort(key2, key3)
      else
        finger_stroke = digraph_stroke_effort(key1, key3) * 0.5
      end
    else
      if key2.hand != key3.hand
        finger_stroke = digraph_stroke_effort(key1, key2)
      else
        finger_stroke_1 = digraph_stroke_effort(key1, key2)
        finger_stroke_2 = digraph_stroke_effort(key2, key3)
        finger_stroke = finger_stroke_1 + finger_stroke_2

        if finger_stroke_1 == finger_stroke_2
          if (finger_stroke_1 - 2.5/6.0).abs < 1e-6
            da1 = @keyboard.angular_diff(key1, key2)
            da2 = @keyboard.angular_diff(key2, key3)
            finger_stroke -= $monotonicity_bonus if da1 * da2 > 0
          elsif (finger_stroke_1 - 3/6.0).abs < 1e-6
            dr1 = @keyboard.radial_diff(key1, key2)
            dr2 = @keyboard.radial_diff(key2, key3)
            finger_stroke -= $monotonicity_bonus if dr1 * dr2 > 0
          else
            finger_stroke -= $monotonicity_bonus if (key1.finger != key2.finger) || (key1.finger != key3.finger)
          end
        end
      end
    end

    #return [hand_stroke, finger_stroke]
    return $hand_stroke_weight * hand_stroke + $finger_stroke_weight * finger_stroke
  end

  def stroke_effort
    effort = 0.0

    t1 = Time.now

    (2...@symbols_arr.length).each do |i|
      effort += triad_stroke_effort(@symbols_arr[i - 2], @symbols_arr[i - 1], @symbols_arr[i])
    end

    #puts "stroke time: #{Time.now - t1}"

    return effort / (@symbols_arr.length - 2)
  end

  def efforts
    return [base_effort, penalty_effort, stroke_effort]
  end
end
