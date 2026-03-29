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
  'ㄱ' => 'f',
  'ㄴ' => 's',
  'ㄷ' => 'e',
  'ㄹ' => 'g',
  'ㅁ' => 'a',
  'ㅂ' => 'q',
  'ㅅ' => 't',
  'ㅆ' => 'v',
  'ㅇ' => 'd',
  'ㅈ' => 'w',
  'ㅊ' => 'c',
  'ㅋ' => 'z',
  'ㅌ' => 'x',
  'ㅍ' => 'b',
  'ㅎ' => 'r'
}

jungseong = {
  'ㅏ' => 'k',
  'ㅐ' => 'n',
  'ㅑ' => 'o',
  'ㅓ' => 'u',
  'ㅔ' => 'm',
  'ㅕ' => 'i',
  'ㅗ' => 'h',
  'ㅛ' => 'y',
  'ㅜ' => ';',
  'ㅠ' => 'p',
  'ㅡ' => 'j',
  # 'ㅢ' => 'y',
  'ㅣ' => 'l'
}

jongseong = {} 

updater = Proc.new do |cho, jung, jong|
  cho.each { |key, val| jong[key] = val unless val.include?("N") }
  shift(cho, 'ㄲ', 'ㄱ')
  shift(cho, 'ㄸ', 'ㄷ')
  shift(cho, 'ㅃ', 'ㅂ')
  shift(cho, 'ㅉ', 'ㅈ')
  # shift(cho, 'ㅋ', 'ㅎ')
  shift(jung, 'ㅒ', 'ㅐ')
  shift(jung, 'ㅖ', 'ㅔ')
  # shift(jung, 'ㅠ', 'ㅜ')
  combine(jung, 'ㅘ', 'ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', 'ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', 'ㅗ', 'ㅣ')
  combine(jung, 'ㅟ', 'ㅜ', 'ㅣ')
  combine(jung, 'ㅝ', 'ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', 'ㅜ', 'ㅔ')
  combine(jung, 'ㅢ', 'ㅡ', 'ㅣ')
  shift(jong, 'ㄲ', 'ㄱ')
  # shift(jong, 'ㅋ', 'ㅎ')
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

@dubeol_jul_e = KeyboardLayout.new('두벌식 줄맞춤 e', choseong, jungseong, jongseong, updater)
