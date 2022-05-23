<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '비전 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">비전</a>
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
            <a href="#" class="tab_m">비전<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li  class="tab_item on"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26 mb_15 ">
            <div class="foreverEdu_vision_wrap pt_50 por">
                <h4 class="tit2 mt_100 mb_50">비전</h4>
                <div class="wrap t_center">
                    <div class="fv_grap_wrap">
                        <div class="fv_grap">
                            <p class="fv_text_box fs_30 fs_md_28">
                                <strong class="bg font_mts fw_900">VISION</strong>
                                <span>배움으로 미래를 여는 글로벌 평생학습도시 송파</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="fv_text_line_box_wrap">
                <div class="fv_text_line_box">
                    <span class="fs_26">배움에 <b class="tc_5">온(ON)</b>하는 평생학습 활성화</span>
                </div>
            </div>
            <div class="wrap fv_box mb_100 por">
                <div class="row plr_30 pb_30 pb_md_0">
                    <div class="col_4 col_md_12 plr_md_0 plr_30">
                        <div class="item_box st_1 ">
                            <strong>송파 평생학습 생태계 구축</strong>
                            <ul>
                                <li>글로벌 평생학습도시 조성</li>
                                <li>유네스코 글로벌학습도시 네트워크</li>
                                <li>송파쌤 교육포털 운영</li>
                                <li>송파구 평생학습원 운영</li>
                                <li>평생교육 네트워크 구축</li>
                                <li>외부기관 공모사업 추진</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col_4 col_md_12 plr_md_0 plr_30 mt_md_50">
                        <div class="item_box st_2">
                            <strong>생애주기별 맞춤형 프로그램 운영</strong>
                            <ul>
                                <li>생애주기별 맞춤형 평생교육 <br>프로그램 운영</li>
                                <li>새로운 배움이 시작되는 인생학교 운영</li>
                                <li>자녀의 미래를 열어주는 학부모 특강</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col_4 col_md_12 plr_md_0 plr_30 mt_md_50">
                        <div class="item_box st_3">
                            <strong>배움과 실천의 평생학습공동체 지원</strong>
                            <ul>
                                <li>평생학습동아리 지원 및 활성화 <br>(학습활동, 공간 등)</li>
                                <li>이야기 할머니 할아버지활동 지원<br>(동화 구연 등)</li>
                                <li>평생학습축제 참여  <br>(대한민국 평생학습박람회)</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
