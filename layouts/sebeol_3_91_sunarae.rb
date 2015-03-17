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
  'ㄲ' => 'kj',
  'ㄴ' => 'h',
  'ㄷ' => 'u',
  'ㄸ' => 'ui',
  'ㄹ' => 'y',
  'ㅁ' => 'i',
  'ㅂ' => ';',
  'ㅃ' => ';l',
  'ㅅ' => 'n',
  'ㅆ' => 'nm',
  'ㅇ' => 'j',
  'ㅈ' => 'l',
  'ㅉ' => 'lk',
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
  'ㅒ' => 'vg',
  'ㅓ' => 't',
  'ㅔ' => 'c',
  'ㅕ' => 'e',
  'ㅖ' => '7',
  'ㅗ' => 'v',
  'ㅛ' => '4',
  'ㅚ' => '/',
  'ㅜ' => 'b',
  'ㅟ' => '9',
  'ㅠ' => '5',
  'ㅡ' => 'g',
  'ㅢ' => '8',
  'ㅣ' => 'd'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄲ' => '[1',
  'ㄳ' => '[v',
  'ㄴ' => 's',
  'ㄵ' => '[e',
  'ㄶ' => '[s',
  'ㄷ' => '[a',
  'ㄹ' => 'w',
  'ㄺ' => '[2',
  'ㄻ' => '[f',
  'ㄼ' => '[d',
  'ㄽ' => '[t',
  'ㄾ' => '[5',
  'ㄿ' => '[4',
  'ㅀ' => '[r',
  'ㅁ' => 'z',
  'ㅂ' => '3',
  'ㅄ' => '[x',
  'ㅅ' => 'q',
  'ㅆ' => '2',
  'ㅇ' => 'a',
  'ㅈ' => '[3',
  'ㅊ' => '[z',
  'ㅋ' => '[c',
  'ㅌ' => '[w',
  'ㅍ' => '[q',
  'ㅎ' => '1'
}

updater = Proc.new do |cho, jung, jong|
  combine(jung, 'ㅘ', 'ㅚ', 'ㅏ')
  combine(jung, 'ㅙ', 'ㅚ', 'ㅐ')
  combine(jung, 'ㅝ', 'ㅚ', 'ㅓ')
  combine(jung, 'ㅞ', 'ㅚ', 'ㅔ')
end

updater.call(choseong, jungseong, jongseong)

@sebeol_3_91_sunarae = KeyboardLayout.new('세벌식 최종 순아래', choseong, jungseong, jongseong, updater)
