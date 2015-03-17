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
  'ㄱ' => 'h',
  'ㄴ' => 'j',
  'ㄷ' => 'n',
  'ㄹ' => 'm',
  'ㅁ' => 'o',
  'ㅂ' => ';',
  'ㅅ' => 'u',
  'ㅇ' => 'y',
  'ㅈ' => 'i',
  'ㅊ' => 'p',
  'ㅋ' => "'",
  'ㅌ' => "/",
  'ㅍ' => ';',
  'ㅎ' => 'k'
}

jungseong = {
  'ㅏ' => 'b',
  'ㅐ' => 'c',
  'ㅑ' => 's',
  'ㅒ' => 'q',
  'ㅓ' => 't',
  'ㅔ' => 'e',
  'ㅕ' => 'd',
  'ㅖ' => 'w',
  'ㅗ' => 'v',
  'ㅛ' => 'a',
  'ㅜ' => 'r',
  'ㅠ' => 'z',
  'ㅡ' => 'f',
  'ㅢ' => 'x',
  'ㅣ' => 'g',
  '*ㅗ' => 'h',
  '*ㅜ' => 'y'
}

jongseong = {
  'ㄱ' => 't',
  'ㄴ' => 'g',
  'ㄷ' => 'w',
  'ㄹ' => 'f',
  'ㅁ' => 'v',
  'ㅂ' => 'd',
  'ㅅ' => 'r',
  'ㅆ' => 'c',
  'ㅇ' => 'b',
  'ㅈ' => 's',
  'ㅊ' => 'a',
  'ㅋ' => 'q',
  'ㅌ' => 'x',
  'ㅍ' => 'z',
  'ㅎ' => 'e'
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

@shinsebeol_onefinger = KeyboardLayout.new('신세벌식 한 손가락', choseong, jungseong, jongseong, updater)
