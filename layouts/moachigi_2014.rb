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
  'ㅂ' => 'o',
  'ㅅ' => 'n',
  'ㅇ' => 'j',
  'ㅈ' => 'l',
  'ㅎ' => 'm'
}

jungseong = {
  'ㅏ' => 'f',
  'ㅑ' => '5',
  'ㅓ' => 'r',
  'ㅕ' => 't',
  'ㅔ' => 'b',
  'ㅗ' => 'v',
  'ㅛ' => '4',
  'ㅜ' => 'c',
  'ㅡ' => 'g',
  'ㅣ' => 'd',
  '*ㅗ' => "'",
  '*ㅜ' => 'p',
}

jongseong = {
  'ㄱ' => 'x',
  'ㄴ' => 's',
  'ㄷ' => '2',
  'ㄹ' => 'e',
  'ㅁ' => 'z',
  'ㅂ' => '3',
  'ㅅ' => 'w',
  'ㅆ' => ';',
  'ㅇ' => 'a',
  'ㅈ' => ";e",
  'ㅎ' => "q",
  'ㄶ' => ';s',
  'ㄽ' => ';1',
  '*s' => ";",
}


updater = Proc.new do |cho, jung, jong|
  combine(cho, 'ㄲ', 'ㄱ', 'ㅇ')
  combine(cho, 'ㄸ', 'ㄷ', 'ㅇ')
  combine(cho, 'ㅃ', 'ㅂ', 'ㅇ')
  combine(cho, 'ㅆ', 'ㅅ', 'ㅇ')
  combine(cho, 'ㅉ', 'ㅈ', 'ㅇ')
  combine(cho, 'ㅊ', 'ㅅ', 'ㅎ')
  combine(cho, 'ㅋ', 'ㄱ', 'ㅎ')
  combine(cho, 'ㅌ', 'ㄷ', 'ㅎ')
  combine(cho, 'ㅍ', 'ㅂ', 'ㅎ')
  combine(jung, 'ㅐ', 'ㅏ', 'ㅣ')
  combine(jung, 'ㅒ', 'ㅓ', 'ㅕ')
  combine(jung, 'ㅖ', 'ㅣ', 'ㅔ')
  combine(jung, 'ㅛ', 'ㅣ', 'ㅗ')
  combine(jung, 'ㅠ', 'ㅏ', 'ㅜ')
  combine(jung, 'ㅘ', '*ㅗ', 'ㅏ')
  combine(jung, 'ㅙ', '*ㅗ', 'ㅐ')
  combine(jung, 'ㅚ', '*ㅗ', 'ㅣ')
  combine(jung, 'ㅝ', '*ㅜ', 'ㅓ')
  combine(jung, 'ㅞ', '*ㅜ', 'ㅔ')
  combine(jung, 'ㅟ', '*ㅜ', 'ㅣ')
  combine(jung, 'ㅢ', 'ㅡ', 'ㅣ')
  combine(jong, 'ㄲ', 'ㄱ', 'ㅇ')
  combine(jong, 'ㅊ', '*s', 'ㅅ')
  combine(jong, 'ㅋ', '*s', 'ㄱ')
  combine(jong, 'ㅌ', '*s', 'ㄷ')
  combine(jong, 'ㅍ', '*s', 'ㅂ')
  combine(jong, 'ㄳ', 'ㄱ', 'ㅅ')
  combine(jong, 'ㄵ', 'ㄴ', 'ㄹ')
  combine(jong, 'ㄺ', 'ㄹ', 'ㄱ')
  combine(jong, 'ㄻ', 'ㄹ', 'ㅁ')
  combine(jong, 'ㄼ', 'ㄹ', 'ㅇ')
  combine(jong, 'ㄾ', 'ㄹ', 'ㄷ')
  combine(jong, 'ㄿ', 'ㄹ', 'ㅂ')
  combine(jong, 'ㅀ', '*s', 'ㅎ')
  combine(jong, 'ㅄ', 'ㅂ', 'ㅅ')
end

updater.call(choseong, jungseong, jongseong)

@moachigi_2014 = KeyboardLayout.new('모아치기 2014', choseong, jungseong, jongseong, updater)
