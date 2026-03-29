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
  'ㄲ' => 'jk',
  'ㄴ' => 'm',
  'ㄷ' => 'i',
  'ㄸ' => 'ji',
  'ㄹ' => 'o',
  'ㅁ' => 'u',
  'ㅂ' => ';',
  'ㅃ' => 'j;',
  'ㅅ' => 'l',
  'ㅆ' => 'jl',
  'ㅇ' => 'j',
  'ㅈ' => 'n',
  'ㅉ' => 'nj',
  'ㅊ' => 'y',
  'ㅋ' => 'b',
  'ㅌ' => 'p',
  'ㅍ' => '/',
  'ㅎ' => 'h'
}

jungseong = {
  'ㅏ' => 'f',
  'ㅐ' => 's',
  'ㅑ' => 'b',
  'ㅒ' => 'x',
  'ㅓ' => 'v',
  'ㅔ' => 'e',
  'ㅕ' => 't',
  'ㅖ' => 'z',
  'ㅗ' => 'g',
  'ㅘ' => 'of',
  'ㅙ' => 'os',
  'ㅚ' => 'od',
  'ㅛ' => 'a',
  'ㅜ' => 'r',
  'ㅝ' => '.v',
  'ㅞ' => '.e',
  'ㅟ' => '.d',
  'ㅠ' => 'q',
  'ㅡ' => 'c',
  'ㅢ' => 'w',
  'ㅣ' => 'd',
}

jongseong = {
  'ㄱ' => 'e',
  'ㄲ' => 'ea',
  'ㄳ' => 'eq',
  'ㄴ' => 's',
  'ㄵ' => 'es',
  'ㄶ' => 'ds',
  'ㄷ' => '3',
  'ㄹ' => 'w',
  'ㄺ' => 'ew',
  'ㄻ' => 'wa',
  'ㄼ' => 'sa',
  'ㄽ' => 'wq',
  'ㄾ' => 'rw',
  'ㄿ' => '4w',
  'ㅀ' => 'dw',
  'ㅁ' => 'a',
  'ㅂ' => 'z',
  'ㅄ' => 'xz',
  'ㅅ' => 'x',
  'ㅆ' => 'q',
  'ㅇ' => 'd',
  'ㅈ' => '2',
  'ㅊ' => 't',
  'ㅋ' => 'f',
  'ㅌ' => 'r',
  'ㅍ' => '4',
  'ㅎ' => 'c'
}


updater = Proc.new do |cho, jung, jong|
end
updater.call(choseong, jungseong, jongseong)

@chamshin_d = KeyboardLayout.new('참신세벌식D', choseong, jungseong, jongseong, updater)
