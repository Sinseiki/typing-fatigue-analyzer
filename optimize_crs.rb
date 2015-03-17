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

require_relative './keyboard.rb'
require_relative './keyboard_layout.rb'
require_relative './layouts.rb'
require_relative './analysis.rb'
require_relative './print_keyboard.rb'
require_relative './parameters.rb'
require_relative './optimize.rb'

def optimize_crs(initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
  perm_set = layout_to_perm_set(initial_layout, initial_layout, cho_opt, jung_opt, jong_opt)
  be, pe, se, fatigue = func(perm_set, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
  puts "최초 배열의 피로도: %.4f/%.4f/%.4f/%.4f" % [be, pe, se, fatigue]

  set_size = 10 + 7 * (cho_opt.length + jung_opt.length + jong_opt.length)

  t1 = Time.now
  data_set = DataSet.new

  layout_cp = initial_layout.deep_copy
  initial_perm_set = layout_to_perm_set(layout_cp, layout_cp, cho_opt, jung_opt, jong_opt)
  data_set.add_data(initial_perm_set, [be, pe, se, fatigue])

  while data_set.length < set_size
    random_perm_set = Marshal.load(Marshal.dump(perm_set)).each { |perm| perm.shuffle! }
    vals = func(random_perm_set, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
    data_set.add_data(random_perm_set, vals)
  end

  worst_set = data_set.worst.perm_set
  counter = 0

  puts "초기화에 걸린 시간: %d초" % (Time.now - t1).to_i

  t1 = Time.now

  (0...$max_cycle * set_size).each do |i|
    last_worst_set = Marshal.load(Marshal.dump(worst_set))
    break if counter == set_size

    trial_1 = reflection_trial(data_set)
    trial_1_vals = func(trial_1, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
    if trial_1_vals[-1] > data_set.worst.vals[-1]
      data_set.remove_perm_set(data_set.worst.perm_set)

      trial_2 = mutated_trial(data_set, trial_1)
      trial_2_vals = func(trial_2, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)

      if trial_1_vals[-1] > trial_2_vals[-1]
        data_set.add_data(trial_2, trial_2_vals)
      else
        data_set.add_data(trial_1, trial_1_vals)
      end
    else
      data_set.remove_perm_set(data_set.worst.perm_set)
      data_set.add_data(trial_1, trial_1_vals)
    end

    worst_set = data_set.worst.perm_set
    if last_worst_set == worst_set
      counter += 1
    else
      counter = 0
    end

    if (i % 10 == 0) && (i > 0)
      best = data_set.best
      puts "#{i}th cycle: #{best.perm_set}/%.4f/%.4f/%.4f/%.4f, 경과 시간: %d초" % [best.vals[0],
                                                                                    best.vals[1],
                                                                                    best.vals[2], 
                                                                                    best.vals[3], 
                                                                                    (Time.now - t1).to_i]
    end

    puts "Difference between the best and the worst value: #{data_set.val_diff}"
    break if data_set.val_diff < $convergence_thresh
  end

  puts "걸린 시간: #{"%d" % (Time.now - t1).to_i}초"
  #puts "최종 배열의 피로도: %.4f" % $best_in_history[1][-1]
  #puts "각 피로도 항목: %.4f/%.4f/%.4f" % [$best_in_history[1][0],
                                           #$best_in_history[1][1],
                                           #$best_in_history[1][2]]
  #layout = perm_set_to_layout(initial_layout, $best_in_history[0], cho_opt, jung_opt, jong_opt)

  #print_keyboard(@standard_keyboard, layout)

  return perm_set_to_layout(initial_layout, $best_in_history[0], cho_opt, jung_opt, jong_opt)
end
