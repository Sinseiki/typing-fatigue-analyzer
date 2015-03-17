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

initial_layout = @shinsebeol_2015

#print_keyboard(@standard_keyboard, initial_layout)

perm_set = [[], [], []]
new_layout = perm_set_to_layout(initial_layout, perm_set, $cho_opt, $jung_opt, $jong_opt)
print_keyboard(@standard_keyboard, new_layout)
