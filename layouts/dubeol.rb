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

require_relative '../keyboard_layout.rb'

choseong = {
  'ㄱ' => 'r',
  'ㄴ' => 's',
  'ㄷ' => 'e',
  'ㄹ' => 'f',
  'ㅁ' => 'a',
  'ㅂ' => 'q',
  'ㅅ' => 't',
  'ㅇ' => 'd',
  'ㅈ' => 'w',
  'ㅊ' => 'c',
  'ㅋ' => 'z',
  'ㅌ' => 'x',
  'ㅍ' => 'v',
  'ㅎ' => 'g'
}

jungseong = {
  'ㅏ' => 'k',
  'ㅐ' => 'o',
  'ㅑ' => 'i',
  'ㅓ' => 'j',
  'ㅔ' => 'p',
  'ㅕ' => 'u',
  'ㅗ' => 'h',
  'ㅛ' => 'y',
  'ㅜ' => 'n',
  'ㅠ' => 'b',
  'ㅡ' => 'm',
  'ㅣ' => 'l'
}

jongseong = {} 

updater = Proc.new do |cho, jung, jong|
  cho.each { |key, val| jong[key] = val unless val.include?("N") }
  shift(cho, 'ㄲ', 'ㄱ')
  shift(cho, 'ㄸ', 'ㄷ')
  shift(cho, 'ㅃ', 'ㅂ')
  shift(cho, 'ㅆ', 'ㅅ')
  shift(cho, 'ㅉ', 'ㅈ')
  shift(jung, 'ㅒ', 'ㅐ')
  shift(jung, 'ㅖ', 'ㅔ')
  combine(jung, 'ㅘ', 'ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', 'ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', 'ㅗ', 'ㅣ')
  combine(jung, 'ㅟ', 'ㅜ', 'ㅣ')
  combine(jung, 'ㅝ', 'ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', 'ㅜ', 'ㅔ')
  combine(jung, 'ㅢ', 'ㅡ', 'ㅣ')
  shift(jong, 'ㄲ', 'ㄱ')
  shift(jong, 'ㅆ', 'ㅅ')
  combine(jong, 'ㄳ', 'ㄱ', 'ㅅ')
  combine(jong, 'ㄵ', 'ㄴ', 'ㅈ')
  combine(jong, 'ㄶ', 'ㄴ', 'ㅎ')
  combine(jong, 'ㄺ', 'ㄹ', 'ㄱ')
  combine(jong, 'ㄻ', 'ㄹ', 'ㅁ')
  combine(jong, 'ㄼ', 'ㄹ', 'ㅂ')
  combine(jong, 'ㄽ', 'ㄹ', 'ㅅ')
  combine(jong, 'ㄾ', 'ㄹ', 'ㅌ')
  combine(jong, 'ㄿ', 'ㄹ', 'ㅍ')
  combine(jong, 'ㅀ', 'ㄹ', 'ㅎ')
  combine(jong, 'ㅄ', 'ㅂ', 'ㅅ')
end

updater.call(choseong, jungseong, jongseong)

@dubeol = KeyboardLayout.new('표준 두벌식', choseong, jungseong, jongseong, updater)
