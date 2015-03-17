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

def find_key(layout, key_symbol)
  cho = layout.choseong_hash.select { |key, value| value == key_symbol }
  jung = layout.jungseong_hash.select { |key, value| value == key_symbol }
  jong = layout.jongseong_hash.select { |key, value| value == key_symbol }
  cho_up = layout.choseong_hash.select { |key, value| value == 'N' + key_symbol + 'F' }
  jung_up = layout.jungseong_hash.select { |key, value| value == 'N' + key_symbol + 'F' }
  jong_up = layout.jongseong_hash.select { |key, value| value == 'N' + key_symbol + 'F' }

  arr = []

  [cho, cho_up, jung, jung_up, jong, jong_up].each do |hash|
    hash.each_key do |val|
      arr << val unless arr.include?(val)
    end
  end

  return arr
end

def print_keyboard(keyboard, layout)
  keys = (1..4).map { |i| keyboard.keys.select { |key, value| value.row == i } }
  (0..3).each do |i|
    print "     " if i == 1
    print "        " if i == 2
    print "            " if i == 3
    print_arr = []
    keys[i].each_value do |key|
      chrs = find_key(layout, key.symbol)
      #print_arr << "%*s" % [8 - chrs.length, chrs.join("/")]
      print_arr << '[' + chrs.join("/").center(8 - chrs.length) + ']'
    end
    puts print_arr.join(" ")
  end
end
