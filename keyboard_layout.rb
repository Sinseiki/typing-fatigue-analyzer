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

class KeyboardLayout
  def initialize(name, choseong_hash, jungseong_hash, jongseong_hash, updater)
    @name = name
    @choseong_hash = choseong_hash
    @jungseong_hash = jungseong_hash
    @jongseong_hash = jongseong_hash
    @updater = updater
  end
  attr_accessor :name, :choseong_hash, :jungseong_hash, :jongseong_hash, :updater

  def deep_copy
    new_layout = KeyboardLayout.new(@name,
                                    @choseong_hash.dup,
                                    @jungseong_hash.dup,
                                    @jongseong_hash.dup,
                                    @updater)

    return new_layout
  end

  def update!
    updater.call(@choseong_hash, @jungseong_hash, @jongseong_hash)
  end

  def convert(hangul_arr)
    choseong, jungseong, jongseong = hangul_arr

    symbol_str = ''

    symbol_str << choseong_hash[choseong] unless choseong.nil?
    symbol_str << jungseong_hash[jungseong] unless jungseong.nil?
    symbol_str << jongseong_hash[jongseong] unless jongseong.nil?

    return symbol_str
  end

  def swap_keys!(symbol1, symbol2, beol)
    hash =
      if beol == 1
        @choseong_hash
      elsif beol == 2
        @jungseong_hash
      elsif beol == 3
        @jongseong_hash
      end

    hash[symbol1], hash[symbol2] = hash[symbol2], hash[symbol1]
    #updater.call(@choseong_hash, @jungseong_hash, @jongseong_hash)
    update!

    return self
  end

  def swap_keys(symbol1, symbol2, beol)
    new_layout = deep_copy

    return new_layout.swap_keys!(symbol1, symbol2, beol)
  end

  def random_swap(cho, jung, jong)
    total_length = cho.length + jung.length + jong.length

    rand_num = rand

    arr, beol = 
      if rand_num < cho.length.to_f / total_length
        [cho,  1]
      elsif rand_num < (cho.length + jung.length).to_f / total_length
        [jung, 2]
      else
        [jong, 3]
      end

    rand_num = rand
    symbol1 = arr[rand * arr.length]

    while true
      rand_num = rand
      symbol2 = arr[(rand * arr.length).to_i]
      break if symbol1 != symbol2
    end

    return swap_keys(symbol1, symbol2, beol)
  end
end

# N. B. 'N' stands for shift_on, and 'F' stands for shift_off.
@shift_on, @shift_off = 'N', 'F'

def shift(hash, a, b)
  hash[a] = @shift_on + hash[b] + @shift_off
end

def combine(hash, a, b, c)
  hash[a] = hash[b] + hash[c]
end

def digraph(hash, a, b)
  hash[a] = hash[b] + hash[b]
end
