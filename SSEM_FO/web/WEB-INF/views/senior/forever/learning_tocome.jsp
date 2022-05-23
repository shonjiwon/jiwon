<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '오시는 길 > 평생학습원 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    평생교육
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생교육</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습도시 송파</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습원</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">연혁</a></li>
                            <li><a href="/ssem/senior/forever/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                            <li><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                            <li><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                            <li><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
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
    <div class="sub_con st_5"><!-- sub_con -->
        <section class="text_con pb_100 mb_15">
            <h3 class="mt_80 mb_50 tit font_sc">평생학습도시 송파</h3>
            <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
                <h4 class="text_hide">탭</h4>
                <a href="#" class="tab_m">평생학습원<i class="icon_arrow_down_w ml_60">다운</i></a>
                <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                    <li  class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                    <li  class="tab_item on"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
                </ul>
            </div><!-- tab_box //-->
            <h4 class="tit2 mt_100 mb_50">평생학습원</h4>
            <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
                <h4 class="text_hide">3뎁스 탭</h4>
                <ul class="tab tab_2">
                    <li class="tab_item"><a href="/ssem/senior/forever/learning_status.do">현황</a></li>
                    <li class="tab_item on"><a href="/ssem/senior/forever/learning_tocome.do">오시는 길</a></li>
                </ul>
            </div>
            <div class="wrap">
                <h2 class="fs_30 mt_80">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_box">
                        <div id="daumRoughmapContainer1606226837305" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1606226837305",
                                "key" : "234qm",
                                "mapHeight" : "450"
                            }).render();
                        </script>
                        <%--<!-- 네이버 지도 API 삽입 부분 -->
                        <img src="/ssem/resources/img/sub/smp_map_img_01.jpg" alt="네이버 지도">
                        <!-- map_marker.png -->
                        <i class="icon_map_marker">송파쌤</i>--%>
                    </div>
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location">주소</i>주소</strong>
                                서울특별시 송파구 마천로 35길 12(마천동)
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_tel">전화</i>연락처</strong>
                                02)2147-2454
                            </p></li>
                            <li>
                                <div class="por">
                                    <strong class="s_loc_tit top tc_b"><i class="icon_bus">대중교통</i>대중교통</strong>
                                    <ul class="ul_list_dash">
                                        <li>버  스 : 3214, 3314, 3315, 3316, 3317 이용 마천2동 윤진빌딩 하차, 도보3분</li>
                                        <li>지하철 : 5호선 개롱역 3번 출구, 버스 3315 환승 후 마천2동 윤진빌딩 하차, 도보3분</li>
                                    </ul>
                                </div>
                            </li>
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
