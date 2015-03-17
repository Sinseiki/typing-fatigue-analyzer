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

def unicode_of(a)
  a.unpack('U*').pop
end

class String
  def succ
    head = self.unpack('U*')
    tail = head.pop
    return head.pack('U*') + [tail + 1].pack('U*')
  end
end

def ch_to_jamo(ch)
  choseong_list = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 
                   'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
  jungseong_list = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 
                    'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ']
  jongseong_list = [ nil, 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 
                    'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 
                    'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']

  unicode = unicode_of(ch)

  if (0xac00 <= unicode) && (unicode <= 0xd7a3)
    #offset = unicode_of('가')
    offset = 0xac00
    #choseong  =  choseong_list[  (unicode - offset) / (jungseong_list.length * jongseong_list.length) ]
    #jungseong = jungseong_list[ ((unicode - offset) % (jungseong_list.length * jongseong_list.length)) / jongseong_list.length ]
    #jongseong = jongseong_list[  (unicode - offset) %  jongseong_list.length ]
    choseong  =  choseong_list[  (unicode - offset) / (21 * 28) ]
    jungseong = jungseong_list[ ((unicode - offset) % (21 * 28)) / 28 ]
    jongseong = jongseong_list[  (unicode - offset) % 28 ]
    return [choseong,  jungseong,  jongseong]
  elsif (0x3131 <= unicode) && (unicode <= 0x314e) # i.e., choseong
    #offset = unicode_of('ㄱ')
    #offset = 0x3131
    return [ch, nil, nil]
  elsif (0x314f <= unicode) && (unicode <= 0x3163) # i.e., jungseong
    #offset = unicode_of('ㅏ')
    #offset = 0x314f
    return [nil, ch, nil]
  end
end

def is_hangul?(ch)
  unicode = unicode_of(ch)
  if (0x1100 <= unicode) && (unicode <= 0x11f9)
    return true
  elsif (0x3131 <= unicode) && (unicode <= 0x318e)
    return true
  elsif (0xac00 <= unicode) && (unicode <= 0xd7a3)
    return true
  else
    return false
  end
end

def pick_hangul(str)
  return str.split('').select { |ch| is_hangul?(ch) }.join ''
end

def str_to_jamo(str)
  t1 = Time.now
  str = pick_hangul(str)
  jamo_arr = []
  str.split('').each do |ch|
    jamos = ch_to_jamo(ch)
    jamo_arr << jamos unless jamos.nil?
  end
  #puts "str_to_jamo: #{Time.now - t1}"
  return jamo_arr
end
