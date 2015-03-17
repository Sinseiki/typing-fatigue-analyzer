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
require_relative './analysis.rb'
require_relative './print_keyboard.rb'
require_relative './parameters.rb'
require_relative './optimize.rb'

def optimize_sa(initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
  perm_set = layout_to_perm_set(initial_layout, initial_layout, cho_opt, jung_opt, jong_opt)
  min_be, min_pe, min_se, min_fatigue = func(perm_set, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
  puts "최초 배열의 피로도: %.4f/%.4f/%.4f/%.4f" % [min_be, min_pe, min_se, min_fatigue]

  min_perm_set = Marshal.load(Marshal.dump(perm_set))

  t1 = Time.now

  (0...$n).each do |i|
    #t = $t_0 * Math.exp(-1.0 * i * $k / $n)
    t = $t_0 * (1 - i / $n)

    new_perm_set = random_mutate(min_perm_set, cho_opt, jung_opt, jong_opt)
    new_perm_set = random_mutate(new_perm_set, cho_opt, jung_opt, jong_opt) if (t > $t_0 / 2) || (rand < 0.5)
    new_perm_set = random_mutate(new_perm_set, cho_opt, jung_opt, jong_opt) if rand < 0.25

    be, pe, se, fatigue = func(new_perm_set, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)

    df = fatigue - min_fatigue

    p = $p_0 * Math.exp(-1.0 * df / t)

    if rand < p
      min_perm_set = new_perm_set
      min_fatigue = fatigue
      min_be, min_pe, min_se = be, pe, se
    end

    puts "#{i}th cycle: #{min_perm_set}/%.4f/%.4f/%.4f/%.4f, 경과 시간: %d초" % [min_be, 
                                                                                 min_pe,
                                                                                 min_se, 
                                                                                 min_fatigue, 
                                                                                 (Time.now - t1).to_i] if (i % 100 == 0) && (i > 0)
  end

  #p layout

  puts "걸린 시간: #{Time.now - t1}"

  return perm_set_to_layout(initial_layout, $best_in_history[0], cho_opt, jung_opt, jong_opt)
end
