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

# keyboard dependent and individual values
$center_dx = 2.5 / 1.905
$center_dy = 9.0 / 1.905

# finger dependent values
$stretch_max    = [1, 2, 2, 1.5, 1.5, 2, 2, 1]
$finger_burdens = [2.26, 1.39, 0.53, 0.00, 0.00, 0.53, 1.39, 2.26]

# penalty weight parameters
$radial_weight  = 0.2
$curling_weight = 1.5

$hand_weight    = 2.0

$angular_weight = 0.3
$outward_weight = 1.5

$finger_weight  = 1.0

# parameters for base effort
$inversion_penalty = 2.0

# parameters for penalty effort
$shift_penalty = 5.0

# parameters for stroke effort
$radial_threshold = 0.75
$monotonicity_bonus = 0.1
$hand_stroke_weight = 2.0
$finger_stroke_weight = 6.0

# jaso to opt

$cho_opt  = []
$jung_opt = []
$jong_opt = []

# dubeol
#$cho_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅊ', 
             #'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
#$cho_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 
             #'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅗ', 'ㅛ', 'ㅜ', 'ㅠ', 
             #'ㅡ', 'ㅣ']
# sebeol
#$cho_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅊ', 
             #'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
#$jung_opt = ['ㅐ', 'ㅑ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 'ㅜ', 'ㅠ', 'ㅡ']
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 'ㅜ', 
             #'ㅠ', 'ㅡ', 'ㅣ']
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 'ㅜ', 
             #'ㅠ', 'ㅡ', 'ㅣ', 'ㅢ']
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 
             #'ㅜ', 'ㅠ', 'ㅡ', 'ㅣ', 'ㅢ']
#$jong_opt = [ 'ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 
              #'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']
#$jong_opt = [ 'ㄲ', 'ㄳ', 'ㄵ', 'ㄶ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ',
              #'ㅀ', 'ㅄ' ]

# shinsebeol
#$cho_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅊ', 
             #'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ]
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 
             #'ㅜ', 'ㅠ', 'ㅡ', 'ㅣ']
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅛ', 
             #'ㅜ', 'ㅠ', 'ㅡ', 'ㅣ', 'ㅢ']
#$jong_opt = [ 'ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 
              #'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']
#$jung_opt = ['ㅑ', 'ㅒ', 'ㅖ', 'ㅛ', 'ㅠ', 'ㅢ']
#$jong_opt = ['ㄷ', 'ㅂ', 'ㅆ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']

# moachigi
#$cho_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅎ' ]
#$cho_opt  = ['ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅈ', 'ㅎ' ]
#$jung_opt = ['ㅏ', 'ㅐ', 'ㅓ', 'ㅔ', 'ㅗ', 'ㅜ', 'ㅡ', 'ㅣ']
#$jong_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅎ' ]
#$jong_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ']
#$jong_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㅁ', 'ㅂ', 'ㅇ', 'ㅈ']
#$jong_opt  = ['ㄱ', 'ㄴ', 'ㄷ', 'ㅂ', 'ㅈ']
#$jong_opt  = ['ㄱ', 'ㄷ', 'ㅂ', 'ㅈ']
#$jong_opt  = ['ㄹ', 'ㅁ', 'ㅅ', 'ㅇ', 'ㅎ' ]
#$jong_opt  = ['ㅁ', 'ㅅ', 'ㅇ']

# parameters for optimization
$convergence_thresh = 0.00001

# parameters for simulated annealing
$n   = 3000
$t_0 = 0.5
$k   = 10.0
$p_0 = 1.0

# parameters for controlled random search
$max_cycle = 100
