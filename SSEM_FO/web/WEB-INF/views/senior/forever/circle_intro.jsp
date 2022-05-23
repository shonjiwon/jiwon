<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '소개 > 평생학습동아리 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">평생학습동아리</a>
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
        <h3 class="mt_80 tit font_sc mb_50">평생학습도시 송파</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">평생학습동아리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">평생학습동아리</h4>
        <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_4">
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_intro.do">소개</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/circle_insert.do">등록 및 신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_status_list.do">활동 현황</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_news_list.do">활동 소식</a></li>
            </ul>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h2 class="c_tit_1 mt_85">학습동아리란</h2>
            <div class="bg_color_4">
                <div class="fs_26 fs_md_32 ptb_40 ptb_md_60 mt_20 t_center fw_500">
                    송파구 평생학습 학습동아리는<br>
                    <span class="tc_5">같은 주제에 관심있는 구민들이 자발적</span>으로 함께 모여 <br>
                    <span class="tc_5">행복한 삶의 질을 한단계 높이는 </span> 학습공동체 사회를 지향합니다.
                </div>
            </div>
            <h2 class="c_tit_2 mt_85">학습동아리 활동의 이점</h2>
            <div class="row row_p_10 mt_20 fe_box">
                <div class="col_6 col_md_12">
                    <div class="line_box">
                        <div class="row_table">
                            <div class="col t_center">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_01.jpg" alt="개인적 측면" />
                            </div>
                            <div class="col">
                                <strong class="fs_30 fs_md_32">개인적 측면</strong>
                                <ul class="ul_list_dot mt_15">
                                    <li>안정적으로 다양한 정보 습득 </li>
                                    <li>민주적인 의사소통 훈련으로 의사결정능력 향상 </li>
                                    <li>실천 활동을 통해 개인과 집단 함께 성장 </li>
                                    <li>집단에 대한 신뢰와 자긍심 고취 </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col_6 col_md_12 mt_md_20">
                    <div class="line_box">
                        <div class="row_table">
                            <div class="col t_center">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_02.jpg" alt="사회적 측면" />
                            </div>
                            <div class="col">
                                <strong class="fs_30 fs_md_32">사회적 측면</strong>
                                <ul class="ul_list_dot mt_15">
                                    <li>지속적인 학습으로 지역 평생학습문화 정착 </li>
                                    <li>지역사회 구성원이 삶의 주체로 변화 </li>
                                    <li>새로운 인적자원을 발굴하고, 전문화된 인력 확보 </li>
                                    <li>변화를 주도할 수 있는 풀뿌리 시민조직 형성 </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
