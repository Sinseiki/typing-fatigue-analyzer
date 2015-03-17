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
require_relative './key.rb'
require_relative './keyboard.rb'
require_relative './keyboard_layout.rb'
require_relative './analysis.rb'
require_relative './jamo_analysis.rb'
require_relative './layouts.rb'
require_relative './print_keyboard.rb'
require_relative './optimize.rb'

def str(val)
  return "%.4f" % val
end

def percentage_str(val)
  return "#{str(val * 100)}\%"
end

total_layouts = [
  @dubeol, 
  @dubeol_opt2,
  #@sebeol_3_90, 
  @sebeol_3_91, 
  #@sebeol_sunarae,
  #@shinsebeol_park_2003, 
  @shinsebeol_2012,
  @shinsebeol_2015,
  #@sebeol_3_91_sunarae,
  #@sebeol_kim_38, 
  #@sebeol_3_2011, 
  #@sebeol_3_2012, 
  #@sebeol_3_14, 
  #@sebeol_sae_sunarae,
  #@sebeol_3_2015, 
  #@sebeol_3_2015_basic, 
  @sebeol_3_2015_sunarae,
]

sunarae_layouts = [
  @sebeol_sunarae,
  @sebeol_3_91_sunarae,
  @sebeol_sae_sunarae,
  @sebeol_3_2015_v3_sunarae,
  @shinsebeol_2012,
  @shinsebeol_2015,
]

shinsebeol_layouts = [
  @shinsebeol_park_2003, 
  @shinsebeol_2012,
  @shinsebeol_2015_basic,
  @shinsebeol_2015,
]

dubeol_layouts = [
  @dubeol,
  @dubeol_parksong,
  @dubeol_northkorea,
  @dubeol_united,
  @dubeol_kim,
  @dubeol_patal,
  @dubeol_opt1,
  @dubeol_opt2,
  @dubeol_worst,
]

moachigi_layouts = [
  @ahnmatae,
  @moachigi_2014,
]

layouts = total_layouts
#layouts = sunarae_layouts
#layouts = shinsebeol_layouts
#layouts = dubeol_layouts
#layouts = moachigi_layouts

# 원하는 파일의 경로를 선택하세요.
#file = "texts/novels.txt"

str = File.open(file, "r:UTF-8", &:read)

puts "분석에 사용할 파일: #{file}"

t1 = Time.now
jamo_data = str_to_jamo(str)
puts "파일 -> 자모 데이터 변환: #{str((Time.now - t1).to_f)}초"

@total_jamo = jamo_data.inject(0) { |sum, jamos| sum + jamos.count { |jamo| !jamo.nil? } }
puts "총 자모 수: #{@total_jamo}"

#jamo_frequency(jamo_data)

def print_entries(analysis) 
  be, pe, se = analysis.efforts

  return [
    ["이름", analysis.layout.name],
    #["총 타수", analysis.count_strokes],
    ["자모 당 타수", str(analysis.count_strokes.to_f / @total_jamo)],
    #["윗글쇠 누른 횟수", analysis.count_shift],
    #["윗글쇠 누른 비율", percentage_str(analysis.shift_ratio)],
    ["1열\t2열\t3열\t4열", analysis.row_distribution_ratio.map { |val| percentage_str(val) }.join("\t")],
    ["왼손 소지\t왼손 약지\t왼손 중지\t왼손 검지\t오른손 검지\t오른손 중지\t오른손 약지\t오른손 소지", analysis.finger_distribution_ratio.map { |val| percentage_str(val) }.join("\t")],
    ["왼손 비율", percentage_str(analysis.hand_distribution_ratio[0])],
    ["글쇠 연타 비율", percentage_str(analysis.same_finger_digraphs_ratio)],
    #["손가락 연타 비율", percentage_str(analysis.same_finger_ratio)],
    ["손가락 연타 비율(글쇠 연타 제외)", percentage_str(analysis.same_finger_ratio - analysis.same_finger_digraphs_ratio)],
    #["손 연타 비율", percentage_str(analysis.same_hand_ratio)],
    #["손가락 이동 거리", analysis.mean_distance],
    #["radial\tangular", analysis.base_efforts.map { |val| str(val) }.join("\t")],
    ["평균 피로(손 이동)", str(be)],
    ["평균 피로(글쇠)", str(pe)],
    ["평균 피로(손 꼬임)", str(se)],
    ["총 피로(자모에 대한 평균)", str((be + pe + se) * analysis.count_strokes / @total_jamo)],
  ]
end

temp_analysis = Analysis.new([['ㅎ', 'ㅏ', 'ㄴ']], @standard_keyboard, @sebeol_3_2015_sunarae)
puts print_entries(temp_analysis).map { |entry| entry[0] }.join("\t")

layouts.each do |layout|
  analysis = Analysis.new(jamo_data, @standard_keyboard, layout)
  #puts analysis.lh_digraph_distribution.map { |row| row.join(" ") }.join(" ")
  puts print_entries(analysis).map { |entry| entry[1] }.join("\t")
end

#====== optimisation
#initial_layout = @dubeol_expt.deep_copy
#initial_layout = @dubeol_opt2.deep_copy
#initial_layout = @dubeol_worst.deep_copy
#initial_layout = @sebeol_expt.deep_copy
#initial_layout = @shinsebeol_expt.deep_copy
#initial_layout = @shinsebeol_2015_basic.deep_copy

#optimize(initial_layout, jamo_data, "local")
