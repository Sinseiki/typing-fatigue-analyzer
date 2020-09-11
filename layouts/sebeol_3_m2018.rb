require_relative '../keyboard_layout.rb'

choseong = {
  'ㄱ' => 'k',
  'ㄲ' => 'kj',
  'ㄴ' => 'u',
  'ㄷ' => 'i',
  'ㄸ' => 'ij',
  'ㄹ' => 'm',
  'ㅁ' => 'y',
  'ㅂ' => 'o',
  'ㅃ' => 'oj',
  'ㅅ' => 'n',
  'ㅆ' => ',n',
  # ,은 keyboard_semoe2018.rb에서 j를 중지로 눌렀을 때로 설정되어 있습니다.
  'ㅇ' => 'j',
  'ㅈ' => 'l',
  'ㅉ' => 'lj',
  'ㅊ' => 'lh',
  'ㅋ' => 'kh',
  'ㅌ' => 'ih',
  'ㅍ' => 'oh',
  'ㅎ' => 'h' 
}

jungseong = {
  'ㅏ' => 'f',
  'ㅐ' => 'fd',
  'ㅑ' => '.g',
  'ㅒ' => '.t',
  'ㅓ' => 'r',
  'ㅔ' => 'c',
  'ㅕ' => 't',
  'ㅖ' => 'vc',
  'ㅗ' => 'v',
  'ㅘ' => '.f',
  'ㅙ' => '.fd',
  'ㅚ' => 'vd',
  'ㅛ' => 'f/',
  # /는 keyboard_semoe2018.rb에서 r을 중지로 눌렀을 때로 설정되어 있습니다.
  'ㅜ' => 'b',
  'ㅝ' => ".r",
  'ㅞ' => "pc",
  # p는 keyboard_semoe2018.rb에서 b를 오른손 검지로 눌렀을 때로 설정되어 있습니다.
  'ㅟ' => "'d",
  'ㅠ' => "pv",
  # p는 keyboard_semoe2018.rb에서 b를 오른손 검지로 눌렀을 때로 설정되어 있습니다.
  'ㅡ' => 'g',
  'ㅢ' => 'gd',
  'ㅣ' => 'd'
}

jongseong = {
  'ㄱ' => 'x',
  'ㄲ' => 'xa',
  'ㄳ' => 'xq',
  'ㄴ' => 's',
  'ㄵ' => 'se',
  'ㄶ' => 'sa',
  'ㄷ' => 'z;',
  'ㄹ' => 'e',
  'ㄺ' => 'xz',
  'ㄻ' => 'ez',
  'ㄼ' => 'ew',
  'ㄽ' => 'eq',
  'ㄾ' => '-a',
    # -는 keyboard_semoe2018.rb에서 z를 약지로 눌렀을 때로 설정되어 있습니다.
  'ㄿ' => 'wa',
  'ㅀ' => 'a;',
  'ㅁ' => 'z',
  'ㅂ' => 'w',
  'ㅄ' => 'wq',
  'ㅅ' => 'q',
  'ㅆ' => ';',
  'ㅇ' => 'a',
  'ㅈ' => 'e;',
  'ㅊ' => 'q;',
  'ㅋ' => 'x;',
  'ㅌ' => 'sz',
  'ㅍ' => 'w;',
  'ㅎ' => 's;'
}

updater = Proc.new do |cho, jung, jong|
end

updater.call(choseong, jungseong, jongseong)

@sebeol_3_m2018 = KeyboardLayout.new('세벌식 모아치기 e-2018', choseong, jungseong, jongseong, updater)
