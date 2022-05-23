<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 3:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '꿈마루 소개 > 꿈마루 > 송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual mr_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    꿈마루
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">꿈마루</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루</a></li>
                            <li><a href="/ssem/dream/together/experience.do">가치, 같이 함께 해주세요</a></li>
                            <li><a href="/ssem/dream/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/dream/news/notice_list.do">꿈마루 소식</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">꿈마루 소개</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루 소개</a></li>
                            <li><a href="/ssem/dream/dream/program_info.do">프로그램 안내</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div><!--sub_nav_wrap//-->
    <!--
        sub_con st_1 color - #3f78d4
        sub_con st_2 color - #e08c34
        sub_con st_3 color - #9e61e4
        sub_con st_4 color - #f05484
        sub_con st_5 color - #1fb593
    -->
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">꿈마루 소개<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item on"><a href="/ssem/dream/dream/program_info.do">꿈마루 소개</a></li>
                <li  class="tab_item"><a href="/ssem/dream/dream/program_info.do">프로그램 안내</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">꿈마루 소개</h3>
        <div class="sub_info_visual mr_st_1 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <h5 class="fs_28 fw_400">송파진로직업체험지원센터<br class="screen_hide screen_md_show"> “꿈마루” 를 소개합니다.</h5>
                    <p class="fs_18 fs_md_24 mt_40">
                        꿈마루는‘꿈의 정상’이라는 순 우리말으로써 꿈의 정상에서 마음껏 꿈꾸고 펼치는 송파의 청소년들이 마음껏 뛰노는 공간을 의미합니다. <br class="screen_md_hide">
                        송파 꿈마루 진로직업체험지원센터는 교육부 자유학년제 정책으로 송파구청이 송파 관내 초, 중, 고등학교 및 청소년을 대상으로 직업을 통한 참된 행복을 <br class="screen_md_hide">
                        느낄 수 있도록 진로에 대한 내적동기를 찾고, 미래 4차 산업혁명에 따른 직업세계의 변화 등 직업세계를 탐색하며 이를 바탕으로 <br class="screen_md_hide">
                        직업체험을 진행하는 진로교육의 허브(Hub)역할을 하고 있습니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_25 mt_md_80">구성원 안내</h2>
                <h3 class="js_tit_3 t_bef_middot c1 sub_tit_2 sub_tit_1 mt_25 fw_400">송파 꿈마루 운영진</h3>

                <div class="ggoom_master_wrap mt_25">
                    <div class="row_15 row_p_10">
                        <div class="col_3">
                            <div class="in_box">
                                <p class="img_box">
                                    <img src="/ssem/resources/img/sub/maru/maru_profile_01.png" alt="김다정 연구원">
                                </p>
                                <p class="txt_box">
                                    <strong class="sub_txt_tit">김다정 연구원</strong>
                                    <span>센터프로그램</span>
                                    <span>학과특강</span>
                                    <span>홍보, SNS관리</span>
                                    <span>진로프로그램기획</span>
                                </p>
                            </div>
                        </div>
                        <div class="col_3">
                            <div class="in_box">
                                <p class="img_box">
                                    <img src="/ssem/resources/img/sub/maru/maru_profile_02.png" alt="오시은 팀장">
                                </p>
                                <p class="txt_box">
                                    <strong class="sub_txt_tit">오시은 팀장</strong>
                                    <span>예산관리</span>
                                    <span>특별프로그램</span>
                                    <span>기획 및 운영관리</span>
                                    <span>학부모진로교육</span>
                                    <span>지원단 운영관리</span>
                                </p>
                            </div>
                        </div>
                        <div class="col_3">
                            <div class="in_box">
                                <p class="img_box">
                                    <img src="/ssem/resources/img/sub/maru/maru_profile_03.png" alt="김범준 센터장">
                                </p>
                                <p class="txt_box">
                                    <strong class="sub_txt_tit">김범준 센터장</strong>
                                    <span>센터운영총괄</span>
                                    <span>청진기운영총괄</span>
                                    <span>지역사회네트워크</span>
                                    <span>프로그램총괄</span>
                                </p>
                            </div>
                        </div>
                        <div class="col_3">
                            <div class="in_box">
                                <p class="img_box">
                                    <img src="/ssem/resources/img/sub/maru/maru_profile_04.png" alt="김수호 연구원">
                                </p>
                                <p class="txt_box">
                                    <strong class="sub_txt_tit">김수호 연구원</strong>
                                    <span>청진기운영</span>
                                    <span>꿈길 운영 및 관리</span>
                                    <span>교육부인증제 관리</span>
                                    <span>일터 발굴 및 관리</span>
                                    <span>지역네트워크</span>
                                </p>
                            </div>
                        </div>
                        <div class="col_3">
                            <div class="in_box">
                                <p class="img_box">
                                    <img src="/ssem/resources/img/sub/maru/maru_profile_05.png" alt="신경현 연구원">
                                </p>
                                <p class="txt_box">
                                    <strong class="sub_txt_tit">신경현 연구원</strong>
                                    <span>직업인 특강</span>
                                    <span>진로콘서트 운영 및 관리</span>
                                    <span>진로프로그램 기획</span>
                                    <span>내부 프로그램 운영</span>
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- ggoom master : e -->
                <h2 class="c_tit_2 mt_100">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_box">
                        <div id="daumRoughmapContainer1605493474619" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1605493474619",
                                "key" : "22xoz",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                        <!-- 네이버 지도 API 삽입 부분 -->
                        <%--<img src="/ssem/resources/img/sub/smp_map_img_01.jpg" alt="네이버 지도">--%>
                        <!-- map_marker.png -->
                        <%--<i class="icon_map_marker">송파쌤</i>--%>
                    </div>
                    <div class="drct_txt_box location_info">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_location"></i>주소</strong>
                                서울시 송파구 마천로35길 12.<br class="screen_hide screen_md_show"> 송파구 평생학습원 1층
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_subway"></i>지하철 이용시</strong>
                                5호선 개롱역 3번 출구, 버스 3315 환승 후<br class="screen_hide screen_md_show"> 마천2동 윤진빌딩 하차, 도보 3분
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_bus"></i>버스 이용시</strong>
                                3214, 3314, 3315, 3316, 3317<br class="screen_hide screen_md_show"> 이용 마천2동 윤진빌딩 하차, 도보 3분
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
    </div><!-- sub_con : e -->
</div>
