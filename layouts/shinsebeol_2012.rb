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
  'ㅋ' => '/',
  'ㅌ' => "'",
  'ㅍ' => 'p',
  'ㅎ' => 'm'
}

jungseong = {
  'ㅏ' => 'f',
  'ㅐ' => 't',
  'ㅑ' => 'w',
  'ㅒ' => 'q',
  'ㅓ' => 'r',
  'ㅔ' => 'c',
  'ㅕ' => 'e',
  'ㅖ' => 's',
  'ㅗ' => 'v',
  'ㅛ' => 'x',
  'ㅜ' => 'b',
  'ㅠ' => 'a',
  'ㅡ' => 'g',
  'ㅢ' => 'i',
  'ㅣ' => 'd',
  '*ㅗ' => 'p',
  '*ㅜ' => 'o'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄴ' => 's',
  'ㄷ' => 't',
  'ㄹ' => 'w',
  'ㅁ' => 'z',
  'ㅂ' => 'e',
  'ㅅ' => 'q',
  'ㅆ' => 'd',
  'ㅇ' => 'a',
  'ㅈ' => 'g',
  'ㅊ' => 'f',
  'ㅋ' => 'b',
  'ㅌ' => 'r',
  'ㅍ' => 'v',
  'ㅎ' => 'c'
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

@shinsebeol_2012 = KeyboardLayout.new('신세벌식 2012', choseong, jungseong, jongseong, updater)
