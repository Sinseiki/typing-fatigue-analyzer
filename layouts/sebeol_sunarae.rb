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
  'ㅋ' => '9',
  'ㅌ' => '\'',
  'ㅍ' => 'p',
  'ㅎ' => 'm'
}

jungseong = {
  'ㅏ' => 'f',
  'ㅐ' => 'r',
  'ㅑ' => '6',
  'ㅒ' => '0',
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
  'ㅣ' => 'd'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄴ' => 's',
  'ㄷ' => '/',
  'ㄹ' => 'w',
  'ㅁ' => 'z',
  'ㅂ' => '3',
  'ㅅ' => 'q',
  'ㅆ' => '2',
  'ㅇ' => 'a',
  'ㅈ' => '-',
  'ㅊ' => '=',
  'ㅋ' => '\\',
  'ㅌ' => '[',
  'ㅍ' => ']',
  'ㅎ' => '1'
}

updater = Proc.new do |cho, jung, jong|
  digraph(cho, 'ㄲ', 'ㄱ')
  digraph(cho, 'ㄸ', 'ㄷ')
  digraph(cho, 'ㅃ', 'ㅂ')
  digraph(cho, 'ㅆ', 'ㅅ')
  digraph(cho, 'ㅉ', 'ㅈ')
  combine(jung, 'ㅘ', 'ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', 'ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', 'ㅗ', 'ㅣ')
  combine(jung, 'ㅝ', 'ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', 'ㅜ', 'ㅔ')
  combine(jung, 'ㅟ', 'ㅜ', 'ㅣ')
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
end

updater.call(choseong, jungseong, jongseong)

@sebeol_sunarae = KeyboardLayout.new('세벌식 순아래', choseong, jungseong, jongseong, updater)
