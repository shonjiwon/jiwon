<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '여성교실 > 평생교육 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">여성교실</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
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
        <h3 class="mt_100 tit font_sc mb_50">여성교실
        </h3>
        <div class="sub_info_visual foreverEdu_st_3 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">여성교실</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_2 mt_85">기관소개</h4>
            <p class="mt_15 tc_sub"> 여가선용을 위한 취미&middot;건강강좌 및 능력개발과 취&middot;창업을 위한 강좌를 통해 여성의 사회참여 기회를 확대 지원하려고 합니다.</p>
            <h4 class="c_tit_2 mt_85">기관위치</h4>
            <div class="table_box mt_25 fs_18 fs_md_26 t_center">
                <table class="st_2">
                    <caption class="text_hide">기관소개의 문정 위치, 솔바람, 오륜의 안내 </caption>
                    <colgroup>
                        <col style="width:33.333%">
                        <col style="width:33.333%">
                        <col style="width:33.333%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>문정</th>
                        <th>솔바람</th>
                        <th>오륜</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>송파구 동남로6나길 3-6, 지층, 2층 ( 문정동 )</td>
                        <td>송파구 풍성로20길 3, 5층 (풍납동)</td>
                        <td>송파구 양재대로 1222 올림픽선수촌A상가, 지층(방이동)</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h4 class="c_tit_2 mt_85">이용안내 및 유의사항</h4>
            <div class="img_row_list st_b2 fs_20 mb_90">
                <div class="table">
                    <div class="col_6">
                        <div class="img_box">
                            <img src="/ssem/resources/img/sub/foreverEdu/womanClass_img_01.jpg" alt="여성 두분 노트북 이용 모습">
                        </div>
                    </div>
                    <div class="col_6 por txt_wrap">
                        <ul class="bef_middot ptb_60 ptb_lg_40 ptb_md_60 pl_60 pr_20 pl_lg_20 pl_md_60 pr_md_60  fs_20 fs_md_26 lh_30 ">
                            <li>정원의 2/3 미만인 경우 폐강 될 수 있습니다</li>
                            <li class="mt_35 mt_lg_10">송파구 거주 만 18세 이상 여성은(남성반 또는 혼용반 예외 운영 가능, 별도공지) 수강 가능합니다.</li>
                            <li class="mt_35 mt_lg_10">송파구민 아닐 경우, 수강 접수 제한합니다.</li>
                            <li class="mt_35 mt_lg_10">회원가입 시 주민등록등본상 생년월일과 주소기재 필수입니다.</li>
                            <li class="mt_35 mt_lg_10">타인명의로 수강신청 및 양도를 금지합니다.(확인 시 수강제한)</li>
                            <li class="mt_35 mt_lg_10">강의계획서대로 운영되며, 강의 방해 시 다음 분기 접수에 제한이 있을 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <h4 class="c_tit_2 mt_85">감면 및 환불 규정</h4>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">수강료 감면 대상 : 접수 승인 완료된 자에 한해 증빙, 서류 확인 후 감면 금액 환급</span></h5>
            <div class="table_box mt_25 fs_18 fs_md_26 t_center">
                <table class="st_2">
                    <caption class="text_hide">수강료 감면의 대상, 감면율 안내</caption>
                    <colgroup>
                        <col>
                        <col style="width:20%; min-width: 260px;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>대 상</th>
                        <th>감면율</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>「국민기초생활보장법」에 따른 수급자</td>
                        <td>100%</td>
                    </tr>
                    <tr>
                        <td>「한부모가족복지법」에 따른 보호대상</td>
                        <td rowspan="3">50%</td>
                    </tr>
                    <tr>
                        <td>「장애인복지법」에 따른 장애인</td>
                    </tr>
                    <tr>
                        <td>「국가유공자 등 예우 및 지원에 관한 법률」에 따른 국가유공자와 그 배우자 또는 국가유공자의 유족 중 선순위자 1명</td>
                    </tr>
                    <tr>
                        <td>다둥이 행복카드 소지자 중 막내가 만 13세 미만인 세자녀 이상의 세대주 및 세대원</td>
                        <td>30%</td>
                    </tr>
                    <tr>
                        <td>「다문화가족지원법」에 따른 다문화가족</td>
                        <td>20%</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h5 class="middot mt_50"><span class="tc_b fs_22 fs_md_28">수강료 감면 대상 : 접수 승인 완료된 자에 한해 증빙, 서류 확인 후 감면 금액 환급</span></h5>
            <div class="table_box mt_25 mb_50 fs_18 fs_md_26 t_center">
                <table class="st_2">
                    <caption class="text_hide">환불 규정의 신청일, 반환 금액 안내</caption>
                    <colgroup>
                        <col style="width:20%; min-width: 260px;">
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>환불 신청일</th>
                        <th>반환 금액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>개강 전</td>
                        <td>납부한 수강료 전액 (카드수수료 'LG 유플러스 부담')</td>
                    </tr>
                    <tr>
                        <td>수업 1/2 경과 전 </td>
                        <td>교육 잔여일수 금액 (카드수수료 '본인 부담')</td>
                    </tr>
                    <tr>
                        <td>수업 1/2 경과 후</td>
                        <td>반환하지 아니함</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
