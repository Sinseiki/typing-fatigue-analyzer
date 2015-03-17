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

require_relative './parse.rb'

def jamo_frequency(jamo_data)
  choseong_list = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 
                   'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
  jungseong_list = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 
                    'ㅛ', 'ㅙ', 'ㅚ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 
                    'ㅣ']
  jongseong_list = [ 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 
                     'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 
                     'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']

  choseong_hash, jungseong_hash, jongseong_hash = {}, {}, {}

  choseong_list.each { |jamo| choseong_hash[jamo] = 0 }
  jungseong_list.each { |jamo| jungseong_hash[jamo] = 0 }
  jongseong_list.each { |jamo| jongseong_hash[jamo] = 0 }

  jamo_data.each do |syllable|
    choseong_hash[syllable[0]] += 1 unless syllable[0].nil?
    jungseong_hash[syllable[1]] += 1 unless syllable[1].nil?
    jongseong_hash[syllable[2]] += 1 unless syllable[2].nil?
  end

  [choseong_hash, jungseong_hash, jongseong_hash].each do |hash|
    hash.each do |key, val|
      print "초성 " if hash == choseong_hash
      print "중성 " if hash == jungseong_hash
      print "종성 " if hash == jongseong_hash
      puts "#{key}\t#{val}"
    end
  end
end
