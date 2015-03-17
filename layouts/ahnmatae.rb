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
  'ㄲ' => 'fg',
  'ㄴ' => 'e',
  'ㄷ' => 'd',
  'ㄸ' => 'df',
  'ㄹ' => 'r',
  'ㅁ' => 'q',
  'ㅂ' => 'a',
  'ㅃ' => 'as',
  'ㅅ' => 'w',
  'ㅆ' => 'we',
  'ㅇ' => 'g',
  'ㅈ' => 's',
  'ㅉ' => 'sd',
  'ㅎ' => 't'
}

jungseong = {
  'ㅏ' => 'j',
  'ㅑ' => 'u',
  'ㅓ' => 'h',
  'ㅕ' => 'y',
  'ㅗ' => 'l',
  'ㅛ' => 'o',
  'ㅜ' => ';',
  'ㅠ' => 'p',
  'ㅡ' => 'i',
  'ㅣ' => 'k',
}

jongseong = {
  'ㄱ' => 'v',
  'ㄲ' => 'vb',
  'ㄴ' => 'm',
  'ㄷ' => 'x',
  'ㄹ' => '.',
  'ㅁ' => ',',
  'ㅂ' => 'c',
  'ㅅ' => 'n',
  'ㅆ' => 'nm',
  'ㅇ' => 'b',
  'ㅈ' => 'z',
  'ㅎ' => "/"
}


updater = Proc.new do |cho, jung, jong|
  digraph(cho, 'ㄲ', 'ㄱ')
  digraph(cho, 'ㄸ', 'ㄷ')
  digraph(cho, 'ㅃ', 'ㅂ')
  digraph(cho, 'ㅆ', 'ㅅ')
  digraph(cho, 'ㅉ', 'ㅈ')
  combine(cho, 'ㅊ', 'ㅈ', 'ㅎ')
  combine(cho, 'ㅋ', 'ㄱ', 'ㅎ')
  combine(cho, 'ㅌ', 'ㄷ', 'ㅎ')
  combine(cho, 'ㅍ', 'ㅂ', 'ㅎ')
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
  combine(jong, 'ㅊ', 'ㅈ', 'ㅎ')
  combine(jong, 'ㅋ', 'ㄱ', 'ㅎ')
  combine(jong, 'ㅌ', 'ㄷ', 'ㅎ')
  combine(jong, 'ㅍ', 'ㅂ', 'ㅎ')
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

@ahnmatae = KeyboardLayout.new('안마태 소리 글판', choseong, jungseong, jongseong, updater)
