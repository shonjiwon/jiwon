<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-25
  Time: 오전 1:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파가 송파하리 프로젝트 > 교육지원 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_2"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    교육지원
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
                        <a href="#" class="deapth_tit" title="선택">교육지원</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파가 송파하리 프로젝트</a>
                        <ul>
                            <li><a href="/ssem/senior/center/woman_culture.do">송파여성문화회관</a></li>
                            <li><a href="/ssem/senior/center/life_culture.do">송파생활문화대학</a></li>
                            <li><a href="/ssem/senior/center/songpaga_info.do">송파가 송파하리 프로젝트</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_100 tit font_sc mb_50">송파가 송파하리<br class="screen_hide screen_sm_show">(Hi 리터러시, High 송파) 프로젝트</h3>
        <div class="foreverEdu_st_5 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">송파가 송파하리(Hi 리터러시, High 송파) 프로젝트</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <div class="img_row_list st_b fs_20 mb_90">
                <div class="table">
                    <div class="col_5">
                        <div class="img_box">
                            <img src="/ssem/resources/img/sub/senior/songpaga.jpg" alt="송파가 송파하리">
                        </div>
                    </div>
                    <div class="col_7 por txt_wrap m_songpaga_txt">
                        <h4 class="c_tit_2 ml_25 pt_md_40">송파가 송파하리(Hish 리터러시, High 송파) 프로젝트란?</h4>
                        <img class="songpaga_info" src="/ssem/resources/img/sub/senior/songpaga_item.png" alt="송파가송파하리 아이템">
                        <img class="songpaga_info_m" src="/ssem/resources/img/sub/senior/songpaga_item.png" alt="송파가송파하리 아이템">
                        <div class="ml_200 pl_40 m_coach_text">
                            <p class="mt_50 mb_15 middot m_coach_center">
                                <span class="fw_600">리터러시(Literacy)란?</span>
                            </p>
                            <p class="fs_18 tc_sub">글을 읽고 해석하는 능력인 문해력을 말하며, 더 넓은 의미로는 글을 읽고 자기만의 생각으로 해석ㆍ창작ㆍ소통할 수 있는 능력을 뜻합니다.</p>
                            <p class="fs_18 tc_sub">리터러시는 타인의 생각과 감정을 이해하고, 공감하고, 소통하는 것이 목적입니다.</p>
                            <p class="fs_18 tc_sub">이는 모든 교육의 바탕이자, 세상을 이해하는 열쇠입니다.</p>
                        </div>
                        <ul class="bef_middot ml_25 mt_50 fs_20 fs_md_26 lh_30 ">
                            <li class="mt_30">하리해 프로젝트는 구민 누구나 일상에서 리터러시 역량을 기를 수 있는 다양한 활동으로 구성되어 있습니다.</li>
                            <li class="mt_30">초등학생은 기초 문해력을, 청소년은 유튜브ㆍ미디어 리터러시를, 성인은 문화ㆍ뉴스 리터리시 양성을 위한 연령별 교육 콘텐츠를 선보일 예정입니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <h4 class="c_tit_2 mt_85 mb_25">참여하고 싶어요</h4>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">도서관, 학교, 미래교육센터, 문화실험공간 호수 등 다양한 장소에서 그림책 시민 문화 살롱, 그림책 리터러시 특강, 그림책 오픈 스튜디오 등 쉽고 재밌는 리터러시 교육 프로그램을 만날 수 있습니다.</span></h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">더 많은 정보를 원하시면 하단을 클릭해 주세요.</span></h5>
            <ul class="ul_list_span st_2 mt_15">
                <li><span class="fw_600"><i class="icon_tel mr_10">문의처</i>문의처</span><span class="va_m">송파구청 교육협력과 : 02)2147-2377</span></li>
            </ul>
            <div class="btn_box t_center mt_50">
                <a href="https://www.splib.or.kr" class="btn btn_long" target="_blank" title="새창">송파구통합도서관</a>
            </div>
        </div>
    </div>
</div>
