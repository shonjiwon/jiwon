<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-25
  Time: 오전 1:36
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
        $(document).prop('title', '강의이력 조회 > 프로그램 확인 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

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

        if(frm.searchSDate.value > frm.searchEDate.value) {
            modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
            return false;
        }

        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_mypage"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    나의 송파쌤
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">프로그램 확인</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/youth/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/youth/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/youth/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">강사 만족도 평가</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/mypage/attend_list.do">교육이수 현황</a></li>
                            <li><a href="/ssem/youth/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                            <li><a href="/ssem/youth/mypage/teacher_history_list.do">강의이력 조회</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">프로그램확인<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">강의이력 조회</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <ul class="tab tab_4 on">
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/attend_list.do">교육이수 현황</a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/teacher_history_list.do">강의이력 조회</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/youth/mypage/teacher_history_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap_1250 plr_40">
                    <!--
                        sel_box select class="placeholder"
                        [option value= ""] placeholder 컬러
                    -->
                    <div class="row_24 mt_10 ">
                        <div class="col_5 col_md_24 offset_4 offset_md_0 pr_20 pr_md_0">
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchKind" name="searchKind" title="교육기관" class="placeholder">
                                    <option value="">교육기관 선택</option>
                                    <c:forEach items="${groupList}" var="group" varStatus="status">
                                        <option value="${group.group_idx}" <c:if test="${searchKind eq group.group_idx}">selected="selected"</c:if>>${group.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col_14 col_md_24 pr_20 pr_md_0 line_md_top">
                            <div class="row_15">
                                <div class="col_6">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchSDate" name="searchSDate" title="시작일" value="${searchSDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col_1">
                                    <div class="dash">~</div>
                                </div>
                                <div class="col_6">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchEDate" name="searchEDate" title="종료일" value="${searchEDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col_2 t_center data_search_word_box">
                                    <button type="button" class="data_search_btn" id="btn_search">
                                        <i class="icon_search">검색</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div><!--Data Search-->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <p class="t_right"><span class="fw_500 tc">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건</p>
                <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24" id="moTable">
                    <ul>
                        <li class="t_head fs_20">
                            <div class="table">
                                <div class="col wid_60 screen_md_hide">NO</div>
                                <div class="col wid_220">교육기관</div>
                                <div class="col ">프로그램명</div>
                                <div class="col wid_220">교육기간</div>
                                <div class="col wid_150">수강인원</div>
                                <div class="col wid_150">프로그램 상태</div>
                            </div>
                        </li>
                        <c:if test="${fn:length(itemList) == 0}">
                            <li class="_moInit noDate">
                                <div class="t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘강의이력 조회’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                            </li>
                        </c:if>
                        <c:set var="lno" value="0"/>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <c:set var="lno">${lno + 1}</c:set>
                            <li class="wa_ba">
                                <div class="table">
                                    <div class="col wid_60 screen_md_hide"><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></div>
                                    <div class="col wid_220">${item.grp_name}</div>
                                    <div class="col"><p class="ellip_1 t_left">${item.name}</p></div>
                                    <div class="col wid_220">${item.start_dt} ~ ${item.end_dt}</div>
                                    <div class="col wid_150">${item.student_qty}</div>
                                    <div class="col wid_150">
                                        <c:choose>
                                            <c:when test="${item.status_code eq '1'}"><span class="my_tc_3">접수대기</span></c:when>
                                            <c:when test="${item.status_code eq '2'}"><span class="my_tc_2">신청가능</span></c:when>
                                            <c:when test="${item.status_code eq '3'}"><span class="my_tc_4">대기신청</span></c:when>
                                            <c:when test="${item.status_code eq '4'}"><span class="my_tc_3">신청마감</span></c:when>
                                            <c:when test="${item.status_code eq '5'}"><span class="my_tc_1">교육전</span></c:when>
                                            <c:when test="${item.status_code eq '6'}"><span class="my_tc_2">교육중</span></c:when>
                                            <c:when test="${item.status_code eq '7'}"><span class="my_tc_4">교육종료</span></c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <%--<div class="btn_box mt_30 t_right">
                    <button type="button" class="btn btn_long btn_big btn_md_auto mr_10">강의이력 확인서 출력</button>
                </div>--%>
                <common:pageLink name="pageholder"/>
            </div>
        </section>
    </div>
</div>
