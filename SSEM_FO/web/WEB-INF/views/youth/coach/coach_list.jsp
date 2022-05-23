<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '공지사항 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        tableMoHtmlInit('#moTable') //sub.js ul 태그만 모바일용 태그 생성;

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_17"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    온라인 코칭쌤
                </h2>
                <p class="tit_sub">
                    <strong>“송파쌤 질문있어요!”</strong>
                    온라인 코칭쌤은 수준별 맞춤 학습을 제공하는 실시간 온라인 화상교육입니다.<br>언제 어디서나 편안한 나만의 장소에서 실시간 질문 답변을 경험해 보세요.
                </p>
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
                        <a href="#" class="deapth_tit" title="선택">온라인 코칭쌤</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">온라인 코칭쌤</h3>
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24" id="moTable"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/youth/coach/coach_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap plr_40">
                    <div class="row">
                        <div class="coach_col">
                            <div class="cate_item_box">
                                <img src="/ssem/resources/img/sub/youth/icon_notice_blue.png" alt="알림">
                                운영시간&nbsp;&nbsp;|&nbsp;&nbsp;${coachRoomVo.start_time} ~ ${coachRoomVo.end_time}
                            </div>
                            <div class="white_item">&nbsp;</div>
                            <div class="cate_item_box_blue">
                                <a href="${coachRoomVo.url}" target="_blank">질문대기방 입장하기</a>
                            </div>
                        </div>
                        <div class="col_7 col_md_12 pl_20 pl_md_0 pt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" name="searchVal" id="searchVal" value="${searchVal}" title="검색어" placeholder="과목 또는 제목을 검색해주세요.">
                                </div>
                                <button type="submit" class="data_search_btn" id="btn_search">
                                    <i class="icon_search">검색</i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div><!--Data Search-->
        <div class="wrap plr_40">
            <div class="row">
                <div class="coach_info_box">
                    <img class="coach_info" src="/ssem/resources/img/sub/youth/icon_coaching_info.png" alt="온라인코칭쌤사용설명">
                    <img class="coach_info_m" src="/ssem/resources/img/sub/youth/icon_m_coaching_info.png" alt="온라인코칭쌤사용설명">
                    <div class="dp_inb ml_30 mt_55 va_t m_coach_text">
                        <p class="fw_600 fs_26 mb_10 m_coach_center">
                            <%--<span class="fw_500">오시는 길 : </span>송파구청 사거리앞 지하보도--%>
                            질문대기방으로 우선 입장바랍니다.
                        </p>
                        <p class="t_bef_middot c1 fs_20">질문대기방 운영시간 : <span class="fw_600" style="color:#3f78d4;">상단 운영시간 참고</span> (주말과 공휴일은 미운영)</p>
                        <p class="t_bef_middot c1 fs_20">미운영시간에 질문대기방 입장하기 버튼을 누르시면 "종료된 멀티룸입니다."라는 문구가 나옵니다.</p>
                        <p class="t_bef_middot c1 fs_20">운영시간에 다시 입장하여 주시기 바랍니다.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mt_50 mb_15 mb_100">
            <p class="t_right"><span class="fw_500 tc">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건</p>
            <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24"> <!--table_list_ul-->
                <ul>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li class="_moInit noDate">
                            <div class="t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘온라인 코칭쌤’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                        </li>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <li>
                            <a href="#none">
                                <section class="table_2">
                                    <div class="col wid_200 screen_md_hide">
                                        <div class="cate_item">${item.subject}</div>
                                    </div>
                                    <div class="col wid_500 screen_md_hide">${item.title}</div>
                                    <div class="col wid_10 t_right screen_md_hide" style="padding-right: 0 !important;">
                                        <span><i class="icon_time_blue">시간</i></span>
                                    </div>
                                    <div class="col wid_300 t_left screen_md_hide" style="padding-left: 0 !important;">
                                        <c:choose>
                                            <c:when test="${item.week_type eq '1'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 월요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '2'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 화요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '3'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 수요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '4'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 목요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '5'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 금요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '6'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 토요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '7'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 일요일 ${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="col wid_200 screen_md_hide">
                                        <div class="box_item"><a href="${item.url}" target="_blank">입장하기</a></div>
                                    </div>
                                </section>
                                <section class="table_2 screen_hide screen_md_show">
                                    <div class="col wid_200">
                                        <div class="cate_item">${item.subject}</div>
                                    </div>
                                    <div class="col wid_500">${item.title}</div>
                                </section>
                                <section class="table_2 screen_hide screen_md_show">
                                    <div class="col wid_10 t_right" style="padding-right: 0 !important;">
                                        <span><i class="icon_time_blue">시간</i></span>
                                    </div>
                                    <div class="col wid_300 t_left" style="padding-left: 0 !important;width: 70% !important;">
                                        <c:choose>
                                            <c:when test="${item.week_type eq '1'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 월요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '2'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 화요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '3'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 수요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '4'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 목요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '5'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 금요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '6'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 토요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                            <c:when test="${item.week_type eq '7'}">
                                                <span>운영 &nbsp;&nbsp;|&nbsp;&nbsp; 일요일 &nbsp;&nbsp;&nbsp;${item.start_time} ~ ${item.end_time}</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="col wid_200">
                                        <div class="box_item"><a href="${item.url}" target="_blank">입장하기</a></div>
                                    </div>
                                </section>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div><!--table_list_ul//-->
            <common:pageLink name="pageholder"/>
        </div>
    </div>
</div>
