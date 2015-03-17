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
require_relative './optimize_crs.rb'
require_relative './optimize_sa.rb'
require_relative './optimize_local.rb'
require_relative './optimize_dist.rb'

class DataPoint
  def initialize(perm_set, vals)
    @perm_set = perm_set
    @vals = vals
  end
  attr_accessor :perm_set, :vals
end

class DataSet < Array
  def find_data(perm_set)
    return self.find { |point| point.perm_set == perm_set }
  end

  def find_index(perm_set)
    return self.index { |point| point.perm_set == perm_set }
  end

  def add_data(perm_set, vals)
    self << DataPoint.new(perm_set, vals)

    self.sort_data!
  end

  def remove_perm_set(perm_set)
    self.reject! { |point| point.perm_set == perm_set }
  end

  def sort_data!
    self.sort! { |a, b| a.vals[-1] <=> b.vals[-1] }
  end

  def perm_sets
    return self.map { |point| point.perm_set }
  end
  
  def best
    return self[0]
  end

  def worst
    return self[-1]
  end

  def val_diff
    return worst.vals[-1] - best.vals[-1]
  end
end

$stored_data_points = []
$best_in_history = [[], [33.0, 33.0, 33.0, 99.0]]

def jamo_set_to_perm(orig_hash, hash, jamos_to_opt)
  orig_hash_filtered = orig_hash.select { |key, _val| jamos_to_opt.include?(key) }
  hash_filtered = hash.select { |key, _val| jamos_to_opt.include?(key) }
  orig_arr, arr = orig_hash_filtered.values, hash_filtered.values

  return arr.map { |elem| orig_arr.index(elem) }
end

def perm_to_jamo_set(orig_hash, perm, jamos_to_opt)
  hash = orig_hash.dup

  (0...perm.length).each do |i|
    hash[jamos_to_opt[i]] = orig_hash[jamos_to_opt[perm[i]]]
  end

  return hash
end

def layout_to_perm_set(orig_layout, layout, cho_opt, jung_opt, jong_opt)
  cho_perm = jamo_set_to_perm(orig_layout.choseong_hash, layout.choseong_hash, cho_opt)
  jung_perm = jamo_set_to_perm(orig_layout.jungseong_hash, layout.jungseong_hash, jung_opt)
  jong_perm = jamo_set_to_perm(orig_layout.jongseong_hash, layout.jongseong_hash, jong_opt)

  return [cho_perm, jung_perm, jong_perm]
end

def perm_set_to_layout(orig_layout, perm_set, cho_opt, jung_opt, jong_opt)
  layout = orig_layout.dup

  layout.choseong_hash = perm_to_jamo_set(orig_layout.choseong_hash, perm_set[0], cho_opt)
  layout.jungseong_hash = perm_to_jamo_set(orig_layout.jungseong_hash, perm_set[1], jung_opt)
  layout.jongseong_hash = perm_to_jamo_set(orig_layout.jongseong_hash, perm_set[2], jong_opt)
  
  layout.update!

  return layout
end

def dist(perm1, perm2)
  n = perm1.length
  dist = 0

  perm2_cp = Marshal.load(Marshal.dump(perm2))
  
  (0...n).each do |i|
    if perm1[i] != perm2_cp[i]
      j = perm2_cp.index(perm1[i])
      perm2_cp[i], perm2_cp[j] = perm2_cp[j], perm2_cp[i]
      dist += 1
    end
  end

  return dist
end

def combine_perm(p1, p2, w1, w2)
  n = perm1.length

  mask = (0...n).map { |i| rand < w1.to_f / (w1 + w2) ? 0 : 1 }

  perm1 = Marshal.load(Marshal.dump(p1))
  perm2 = Marshal.load(Marshal.dump(p2))

  (0...n).each do |i|
    if perm1_cp[i] != perm2_cp[i]
      if mask[i] == 0
        j = perm2.index(perm1[i])
        perm2[i], perm2[j] = perm2[j], perm2[i]
      else
        j = perm1.index(perm2[i])
        perm1[i], perm1[j] = perm1[j], perm1[i]
      end
    end
  end

  return perm1
end

def extension_ray(perm1, perm2, w12, w23)
  n = perm1.length

  dist = dist(perm1, perm2)
  new_dist = dist * w12 / w23.to_f
  prob = new_dist / (n - 1 - dist)

  perm3 = Marshal.load(Marshal.dump(perm2))

  (0...n).each do |i|
    if (perm3[i] == perm1[i]) && (rand < prob)
      j = (rand * n).to_i
      perm3[i], perm3[j] = perm3[j], perm3[i]
    end
  end

  return perm3
end

def center_of_mass(ps)
  n = ps[0].length

  perms = Marshal.load(Marshal.dump(ps))

  most_freq_elems = perms.transpose.map { |elem_list| elem_list.max_by { |elem| elem_list.count(elem) } }
  freqs = (0...n).map { |i| perms.transpose[i].count(most_freq_elems[i]) }

  considered = [false] * n

  while considered.count(false) > 0
    mfe_tmp = []
    (0...n).each { |i| mfe_tmp << most_freq_elems[i] unless considered[i] }

    elem_max = mfe_tmp.max_by { |elem| mfe_tmp.count(elem) }
    pos_max = most_freq_elems.index(elem_max)

    perms.each do |perm|
      local_pos_max = perm.index(elem_max)
      perm[pos_max], perm[local_pos_max] = perm[local_pos_max], perm[pos_max]
    end

    most_freq_elems = perms.transpose.map { |elem_list| elem_list.max_by { |elem| elem_list.count(elem) } }
    freqs = (0...n).map { |i| perms.transpose[i].count(most_freq_elems[i]) }

    considered[pos_max] = true
  end

  return perms[0]
end

def perm_random_swap(perm_orig)
  perm = Marshal.load(Marshal.dump(perm_orig))

  rand_indices = (0...perm.length).to_a.shuffle
  i, j = rand_indices[0], rand_indices[1]
  perm[i], perm[j] = perm[j], perm[i]

  return perm
end

def random_mutate(perm_set_orig, cho, jung, jong)
  perm_set = Marshal.load(Marshal.dump(perm_set_orig))

  total_length = cho.length + jung.length + jong.length

  rand_num = rand

  if rand_num < cho.length.to_f / total_length
    perm_set[0] = perm_random_swap(perm_set[0])
  elsif rand_num < (cho.length + jung.length).to_f / total_length
    perm_set[1] = perm_random_swap(perm_set[1])
  else
    perm_set[2] = perm_random_swap(perm_set[2])
  end

  return perm_set
end


def reflection_trial(data_set) # We assume that all the permutations are sorted
  worst_perm_set = data_set.worst.perm_set

  perm_sets = data_set.perm_sets
  perms_set = perm_sets.transpose
  c_o_ms = perms_set.map { |perms| center_of_mass(perms) }

  return (0..2).map { |i| extension_ray(worst_perm_set[i], c_o_ms[i], 0.5, 0.5) }
end

#def reflection_trial(perms) # We assume that all the permutations are sorted
  #c_o_m = center_of_mass(perms)

  #return extension_ray(perms[-1], c_o_m, 0.5, 0.5)
#end

def mutated_trial(data_set, old_trial_perm_set)
  rand_num = rand

  best_perm_set = data_set.best.perm_set

  return (0..2).map { |i| extension_ray(old_trial_perm_set[i],
                                        best_perm_set[i],
                                        1 / (1 + rand_num),
                                        rand_num / (1 + rand_num)) }
end

#def mutated_trial(best_point, perm)
  #rand_num = rand
  
  #return extension_ray(perm, best_point, 1 / (1 + rand_num), rand_num / (1 + rand_num))
#end

def func(perm_set, initial_layout, cho_opt, jung_opt, jong_opt, jamo_data)
  $stored_data_points.each do |data_point|
    if data_point[0] == perm_set
      puts "#{perm_set}: %.4f/%.4f/%.4f/%.4f" % [data_point[1][0],
                                                 data_point[1][1],
                                                 data_point[1][2],
                                                 data_point[1][3]]
      return data_point[1] 
    end
  end

  layout = perm_set_to_layout(initial_layout, perm_set, cho_opt, jung_opt, jong_opt)

  total_jamo = jamo_data.inject(0) { |sum, jamos| sum + jamos.count { |jamo| !jamo.nil? } }

  analysis = Analysis.new(jamo_data, @standard_keyboard, layout)
  be, pe, se = analysis.efforts
  fatigue = (be + pe + se) * analysis.count_strokes / total_jamo

  #print perm_set
  puts "#{perm_set}: %.4f/%.4f/%.4f/%.4f" % [be, pe, se, fatigue]

  $stored_data_points << [perm_set, [be, pe, se, fatigue]]

  if fatigue < $best_in_history[1][-1]
    $best_in_history = [perm_set, [be, pe, se, fatigue]]
  end

  return [be, pe, se, fatigue]
end

def optimize(initial_layout, jamo_data, scheme)
  if scheme == "SA"
    new_layout = optimize_sa(initial_layout, $cho_opt, $jung_opt, $jong_opt, jamo_data)
  elsif scheme == "CRS"
    new_layout = optimize_crs(initial_layout, $cho_opt, $jung_opt, $jong_opt, jamo_data)
  elsif scheme == "local"
    new_layout = optimize_local(initial_layout, $cho_opt, $jung_opt, $jong_opt, jamo_data)
  elsif scheme == "hybrid"
    tmp_layout = optimize_crs(initial_layout, $cho_opt, $jung_opt, $jong_opt, jamo_data)
    new_layout = optimize_local(tmp_layout, $cho_opt, $jung_opt, $jong_opt, jamo_data)
  else
    puts "Unknown optimization algorithm #{scheme}. Aborting..."
  end

  analysis = Analysis.new(jamo_data, @standard_keyboard, new_layout)
  be, pe, se = analysis.efforts
  fatigue = (be + pe + se) * analysis.count_strokes / @total_jamo

  puts "최종 배열의 피로도: %.4f" % fatigue
  puts "각 피로도 항목: %.4f/%.4f/%.4f" % [be, pe, se, fatigue]
  print_keyboard(@standard_keyboard, new_layout)
end
