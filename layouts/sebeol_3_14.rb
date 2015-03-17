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
  'ㄱ' => 'k',
  'ㄴ' => 'h',
  'ㄷ' => 'u',
  'ㄹ' => 'y',
  'ㅁ' => 'i',
  'ㅂ' => ';',
  'ㅅ' => 'n',
  'ㅇ' => 'j',
  'ㅈ' => 'l',
  'ㅊ' => 'o',
  'ㅋ' => '0',
  'ㅌ' => '\'',
  'ㅍ' => 'p',
  'ㅎ' => 'm'
}

jungseong = {
  'ㅏ' => 'f',
  'ㅐ' => 'r',
  'ㅑ' => '6',
  'ㅒ' => 'NgF',
  'ㅓ' => 't',
  'ㅔ' => 'c',
  'ㅕ' => 'e',
  'ㅖ' => '7',
  'ㅗ' => 'v',
  'ㅛ' => '4',
  'ㅜ' => 'b',
  'ㅠ' => '5',
  'ㅡ' => 'g',
  'ㅢ' => '8',
  'ㅣ' => 'd',
  '*ㅗ' => '/',
  '*ㅜ' => '9'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄴ' => 's',
  'ㄵ' => 'r',
  'ㄶ' => 'NsF',
  'ㄷ' => 'NaF',
  'ㄹ' => 'w',
  'ㄺ' => 'wx',
  'ㄻ' => 'wz',
  'ㄼ' => 'w3',
  'ㄽ' => 'wq',
  'ㄾ' => 'f',
  'ㄿ' => 'c',
  'ㅀ' => 'w1',
  'ㅁ' => 'z',
  'ㅂ' => '3',
  'ㅄ' => 'NxF',
  'ㅅ' => 'q',
  'ㅆ' => '2',
  'ㅇ' => 'a',
  'ㅈ' => 'e',
  'ㅊ' => 'NzF',
  'ㅋ' => 'v',
  'ㅌ' => 'NwF',
  'ㅍ' => 'NqF',
  'ㅎ' => '1'
}

updater = Proc.new do |cho, jung, jong|
  digraph(cho, 'ㄲ', 'ㄱ')
  digraph(cho, 'ㄸ', 'ㄷ')
  digraph(cho, 'ㅃ', 'ㅂ')
  digraph(cho, 'ㅆ', 'ㅅ')
  digraph(cho, 'ㅉ', 'ㅈ')
  combine(jung, 'ㅘ', '*ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', '*ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', '*ㅗ', 'ㅣ')
  combine(jung, 'ㅝ', '*ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', '*ㅜ', 'ㅔ')
  combine(jung, 'ㅟ', '*ㅜ', 'ㅣ')
  digraph(jong, 'ㄲ', 'ㄱ')
  combine(jong, 'ㄳ', 'ㄱ', 'ㅅ')
  combine(jong, 'ㄾ', 'ㄹ', 'ㅌ')
  combine(jong, 'ㄿ', 'ㄹ', 'ㅍ')
  combine(jong, 'ㅀ', 'ㄹ', 'ㅎ')
end

updater.call(choseong, jungseong, jongseong)

@sebeol_3_14 = KeyboardLayout.new('한글문화원 세벌식 314', choseong, jungseong, jongseong, updater)
