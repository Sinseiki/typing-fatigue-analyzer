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
  'ㅐ' => 't',
  'ㅑ' => '6',
  'ㅒ' => 'NtF',
  'ㅓ' => 'r',
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
  'ㄲ' => 'NqF',
  'ㄳ' => 'NvF',
  'ㄴ' => 's',
  'ㄵ' => 'NeF',
  'ㄶ' => 'NsF',
  'ㄷ' => '1',
  'ㄹ' => 'w',
  'ㄺ' => 'NwF',
  'ㄻ' => 'NfF',
  'ㄼ' => 'NdF',
  'ㄽ' => 'NzF',
  'ㄾ' => 'NaF',
  'ㄿ' => 'NcF',
  'ㅀ' => 'NrF',
  'ㅁ' => 'z',
  'ㅂ' => '3',
  'ㅄ' => 'NxF',
  'ㅅ' => 'q',
  'ㅆ' => '2',
  'ㅇ' => 'a',
  'ㅈ' => 'e',
  'ㅊ' => 'r',
  'ㅋ' => 'v',
  'ㅌ' => 'c',
  'ㅍ' => 'f',
  'ㅎ' => 'd'
}

updater = Proc.new do |cho, jung, jong|
  combine(jung, 'ㅘ', '*ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', '*ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', '*ㅗ', 'ㅣ')
  combine(jung, 'ㅝ', '*ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', '*ㅜ', 'ㅔ')
  combine(jung, 'ㅟ', '*ㅜ', 'ㅣ')
end

updater.call(choseong, jungseong, jongseong)

@sebeol_3_2015 = KeyboardLayout.new('세벌식 3-2015', choseong, jungseong, jongseong, updater)
