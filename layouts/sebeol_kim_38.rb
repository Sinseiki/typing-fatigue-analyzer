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
  'ㅑ' => '6',
  'ㅓ' => 't',
  'ㅕ' => 'r',
  'ㅗ' => 'v',
  'ㅛ' => 'x',
  'ㅜ' => 'b',
  'ㅠ' => '5',
  'ㅡ' => 'g',
  'ㅣ' => 'd'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄴ' => 's',
  'ㄷ' => '9',
  'ㄹ' => 'w',
  'ㅁ' => 'z',
  'ㅂ' => 'e',
  'ㅅ' => 'q',
  'ㅇ' => 'a',
  'ㅈ' => '8',
  'ㅊ' => '2',
  'ㅋ' => '1',
  'ㅌ' => '7',
  'ㅍ' => '3',
  'ㅎ' => 'c'
}

updater = Proc.new do |cho, jung, jong|
  digraph(cho, 'ㄲ', 'ㄱ')
  digraph(cho, 'ㄸ', 'ㄷ')
  digraph(cho, 'ㅃ', 'ㅂ')
  digraph(cho, 'ㅆ', 'ㅅ')
  digraph(cho, 'ㅉ', 'ㅈ')
  combine(jung, 'ㅐ', 'ㅏ', 'ㅣ')
  combine(jung, 'ㅒ', 'ㅑ', 'ㅣ')
  combine(jung, 'ㅔ', 'ㅓ', 'ㅣ')
  combine(jung, 'ㅖ', 'ㅕ', 'ㅣ')
  combine(jung, 'ㅘ', 'ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', 'ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', 'ㅗ', 'ㅣ')
  combine(jung, 'ㅝ', 'ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', 'ㅜ', 'ㅔ')
  combine(jung, 'ㅟ', 'ㅜ', 'ㅣ')
  combine(jung, 'ㅢ', 'ㅡ', 'ㅣ')
  digraph(jong, 'ㄲ', 'ㄱ')
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
  digraph(jong, 'ㅆ', 'ㅅ')
end

updater.call(choseong, jungseong, jongseong)

@sebeol_kim_38 = KeyboardLayout.new('김국 38 자판', choseong, jungseong, jongseong, updater)
