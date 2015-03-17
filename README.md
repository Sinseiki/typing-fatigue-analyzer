# 타이핑 피로도 분석기

타이핑 피로도 분석기는 한글 이어치기 자판의 피로도를 계산하고 분석하기 위한 소프트웨어입니다. 사용한 모델은 링크 [\#0][model_link_0] [\#1][model_link_1] [\#2][model_link_2] [\#3][model_link_3] [\#4][model_link_4] [\#5][model_link_5] [\#6][model_link_6]을 참고하세요.

# 사용법

## 피로도 분석
 
피로도를 분석하기 위해서는 배열과 텍스트가 필요합니다. 

배열은 layouts/ 디렉토리에 있는 것을 참고하셔서 만드시면 됩니다. 

텍스트는 라이센스 문제로 따로 배포하지는 않고 있으며, 적절히 맞는 것을 구해서 쓰시기 바랍니다. UTF-8로 인코딩한 적당한 텍스트 파일을 구하셨다면 해당 파일의 경로를 main.rb의 file 편수에 집어넣으시면 됩니다.

## 자판 최적화

자판 배열에 따른 피로도가 비교적 부드러운 함수이므로, 전역 최적화(global optimization)가 필요하지는 않습니다. 따라서 국소적 돌연변이(local mutation)를 통한 탐욕 알고리즘(greedy algorithm)을 통해 국소적 최적화(local optimization)를 하는 것으로 충분합니다. 

모든 자모를 최적화할 수도 있고, 일부 자모만을 최적화할 수도 있습니다. parameters.rb에서 $cho_opt, $jung_opt, $jong_opt를 알맞게 수정하세요. 이 경우, 새로운 배열을 만드셨다면 해당 파일의 updater를 제대로 만들었는지 점검하세요. 예를 들어, 두벌식에서 updater를 통하지 않고 ㅃ에 Shift+q를 배정했을 경우, 배열이 바뀌면 ㅂ는 w인데 ㅃ는 Shift+q 그대로 남아 있을 수도 있습니다. 각각 배열 파일의 updater 블록은 알맞게 글쇠 사이의 관계를 정의해야 합니다.

최적화에는 보통 상당한 시간을 소모하게 됩니다. 최적화 도중 나온 배열을 눈으로 볼 수 있도록 출력하려면, 출력된 permutation을 print_layout.rb의 perm_set 변수에 넣고 print_layout.rb를 실행하는 것이 제일 편리합니다.

# 주의사항

* 텍스트에 있는 한글이 아닌 모든 문자는 무시합니다. 즉, 숫자, 특수문자, 공백 등을 모두 무시한다는 뜻입니다.
* 피로도의 절대량은 의미가 없고, 상대적인 차이만 유의미합니다. 즉, 자판 A, B, C의 피로도가 2, 1.5, 1일 때, 자판 C가 A의 절반만 피로하다고 말할 수는 없습니다. 다만, B가 A보다 덜 피로한 만큼 C가 B보다 덜 피로하다고는 말할 수 있습니다.

# 라이센스

타이핑 피로도 분석기는 GNU 일반 공중 사용 허가서(GPL)를 따릅니다. COPYING 파일을 참고하세요.

[model_link_0]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=1
[model_link_1]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=2
[model_link_2]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=3
[model_link_3]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=6
[model_link_4]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=13
[model_link_5]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=14
[model_link_6]: http://sebeol.org/gnuboard/bbs/board.php?bo_table=lab&wr_id=15
