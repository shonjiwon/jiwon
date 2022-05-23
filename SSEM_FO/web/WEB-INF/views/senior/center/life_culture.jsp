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
        $(document).prop('title', '송파생활문화대학 > 교육지원 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">송파생활문화대학</a>
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
        <h3 class="mt_100 tit font_sc mb_50">송파생활문화대학</h3>
        <div class="sub_info_visual foreverEdu_st_5 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">송파생활문화대학</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_2 mt_85 mb_25">기관소개</h4>
            <p class="fw_300 ls_50">2003년 1월부터 송파구 시설관리공단에서 '서울특별시 송파구 체육 진흥 및 시설 설치&middot;운영 조례에 따라 위탁운영하고 있는 송파생활문화대학은 수강생 개별 욕구 다양화에 부응하고자
                문화복지 인프라  구축을 위하여 언제나 노력하고 있으며 향후에도 구민들의 생산적인 삶의 구현을 도와드릴 수 있도록 평생교육 차원의 열린 문화 공간 제공을 위해 최선을 다하겠습니다.
                나아가, 강좌를 통해 얻은 지식과 체험을 지역사회 발전 및 협력 공동체 형성에 기여할 수 있는 Dynamic Group Culture가 지속 발전될 수 있도록 노력하겠으니 많은 성원과 참여를 부탁드립니다.</p>
            <h4 class="c_tit_2 mt_85 mb_25">모집안내</h4>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">분기별 접수</span></h5>
            <div class="table_box mt_15 fs_18 fs_md_26 t_center screen_md_hide">
                <table class="st_2">
                    <caption class="text_hide">분기별 접수의 1분기, 2분기, 3분기, 4분기 안내</caption>
                    <colgroup>
                        <col style="width:20%">
                        <col style="width:20%">
                        <col style="width:20%">
                        <col style="width:20%">
                        <col style="width:20%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="backslash t_right"><span>분기</span></th>
                        <th>1분기</th>
                        <th>2분기</th>
                        <th>3분기</th>
                        <th>4분기</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>개강월</td>
                        <td>1월</td>
                        <td>4월</td>
                        <td>7월</td>
                        <td>10월</td>
                    </tr>
                    <tr>
                        <td>교육기간</td>
                        <td>1.4.∼3.26</td>
                        <td>4.1.∼6.23</td>
                        <td>7.1.∼9.22</td>
                        <td>10.1.∼12.23</td>
                    </tr>
                    <tr>
                        <td>접수기간</td>
                        <td>2020.12.21.~12.31</td>
                        <td>2021.3.23.~3.31</td>
                        <td>2021.6.22.∼6.30</td>
                        <td>2021.9.23.∼9.30</td>
                    </tr>
                    <tr>
                        <td>수업진행</td>
                        <td colspan="4">3개월 ( 12주 )</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--모바일-->
            <div class="table_box mt_15 fs_18 fs_md_26 t_center screen_hide screen_md_show">
                <table class="st_2">
                    <caption class="text_hide">분기별 접수 1분기 2분기</caption>
                    <colgroup>
                        <col style="width:24%">
                        <col style="width:38%">
                        <col style="width:38%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="backslash t_right"><span>분기</span></th>
                        <th>1분기</th>
                        <th>2분기</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>개강월</td>
                        <td>1월</td>
                        <td>4월</td>
                    </tr>
                    <tr>
                        <td>교육기간</td>
                        <td>1.4.∼3.26</td>
                        <td>4.1.∼6.23</td>
                    </tr>
                    <tr>
                        <td>접수기간</td>
                        <td>2020.12.21.~12.31</td>
                        <td>2021.3.23.~3.31</td>
                    </tr>
                    <tr>
                        <td>수업진행</td>
                        <td colspan="2">3개월 ( 12주 )</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="table_box mt_30 fs_18 fs_md_26 t_center screen_hide screen_md_show">
                <table class="st_2">
                    <caption class="text_hide">분기별 접수 3분기 4분기</caption>
                    <colgroup>
                        <col style="width:24%">
                        <col style="width:38%">
                        <col style="width:38%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="backslash t_right"><span>분기</span></th>
                        <th>3분기</th>
                        <th>4분기</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>개강월</td>
                        <td>7월</td>
                        <td>10월</td>
                    </tr>
                    <tr>
                        <td>교육기간</td>
                        <td>7.1.∼9.22</td>
                        <td>10.1.∼12.23</td>
                    </tr>
                    <tr>
                        <td>접수기간</td>
                        <td>2021.6.22.∼6.30</td>
                        <td>2021.9.23.∼9.30</td>
                    </tr>
                    <tr>
                        <td>수업진행</td>
                        <td colspan="2">3개월 ( 12주 )</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--모바일 : e-->
            <p class="t_right mt_10">※ 현재 수업은 코로나로 인해 휴관 중 입니다.</p>
            <h5 class="middot mt_55"><span class="tc_b fs_22 fs_md_28">접수시간 : 방문 09:30 ~ 18:30 /  <b>인터넷 09:30 ~ 23:30</b></span></h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">접수방법 : 방문 및 인터넷 접수(<a class="link_blank2" href="/ssem/senior/program/lecture_list.do" target="_blank">통합프로그램신청</a>)</span></h5>
            <h4 class="c_tit_2 mt_85 mb_25">위치 및 문의처 안내</h4>
            <ul class="ul_list_span st_2">
                <li><span class="fw_600"><i class="icon_location mr_10">주소</i>주소</span><span class="va_m">서울특별시 송파구 백제고분로 242 송파구민회관 2층 생활문화대학 사무실 (삼전동)</span></li>
                <li><span class="fw_600"><i class="icon_tel mr_10">문의처</i>문의처</span><span class="va_m">02)2203-8270</span></li>
            </ul>
        </div>
    </div>
</div>
