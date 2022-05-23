<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '기관소개 > 마천청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual macheon_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    기관소개
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">기관소개</a>
                        <ul>
                            <li><a href="/ssem/machuncenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/machuncenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/machuncenter/biz/major.do">주요사업</a></li>
                            <li><a href="/ssem/machuncenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/machuncenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <!--

			sub_con st_1 color - #3f78d4
			sub_con st_2 color - #e08c34
			sub_con st_3 color - #9e61e4
			sub_con st_4 color - #f05484
			sub_con st_5 color - #1fb593

    -->
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_90 mb_20 tit font_sc">기관소개</h3>
        <section class="text_con fs_18 fs_md_26 pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_50">인사말</h2>
                <div class="mt_15">
                    <img src="/ssem/resources/img/sub/macheon/introduce_img_01.jpg" alt="색싹 손 이미지" class="screen_show screen_sm_hide">
                    <img src="/ssem/resources/img/sub/macheon/introduce_img_01_m.jpg" alt="색싹 손 이미지" class="screen_hide screen_sm_show">
                </div>
                <div class="row">
                    <div class="col_3 col_md_12">
                        <p class="fs_28 fs_md_36 tc_1 pt_40 pb_40 plr_30 plr_md_20 pb_md_20">
                            청소년 문화소통공간,<br> 스스로 성장하는 청소년
                        </p>
                    </div>
                    <div class="col_9 col_md_12">
                        <div class="ptb_40 pl_20 pr_100 pr_md_20 ptb_md_0 fw_300">
                            <p>마천청소년센터 홈페이지를 방문해 주셔서 감사합니다.</p>
                            <p class="mt_15 mt_md_25 lh_16">
                                마천청소년센터는 1997년 11월 개관이래 지역사회 청소년들의 건강한 성장을 도모하고자 대상에 특화된 체험거리 및 관련 복지서비스를
                                제공하고 있습니다. 마천청소년센터의 지도자들은 항상 연구하고 준비하는 자세로 청소년의 재미거리를 찾아 도전하고 있습니다.<br>
                                청소년의 전문역량을 갖춘 청소년센터로 나아갈 수 있도록 많은 응원 부탁드립니다.<br>
                                우리의 도전으로 이 시대 청소년들이 부디 건강하게 성장하기를 소망합니다.
                            </p>
                            <p class="mt_15 mt_md_25">마천청소년센터 직원일동</p>
                        </div>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_80">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_box">
                        <div id="daumRoughmapContainer1605683544205" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1605683544205",
                                "key" : "23zhg",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                    </div>
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location">주소</i>주소</strong>
                                서울시 송파구 성내천로 319 <br class="screen_hide screen_md_show"> 마천청소년센터
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_phon">전화</i>대표번호</strong>
                                02)443-0100(안내 0번)
                            </p></li>
                        </ul>
                        <%--<p class="btn_box screen_md_hide">
                            <button type="button" class="btn">지도크게보기</button>
                            <button type="button" class="btn">길찾기</button>
                        </p>--%>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
