<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:33
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
        $(document).prop('title', '설문조사 > 송파쌤 > 평생교육 > 송파쌤');

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
    <div class="sub_visual st_11"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    송파쌤(SSEM)
                </h2>
                <p class="tit_sub">
                    <strong>“세상에서 가장 큰 학교”</strong>
                    송파에서 나고 자라고 완성되는 <br>창의적 인재육성
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤</a>
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
                        <a href="#" class="deapth_tit" title="선택">설문조사</a>
                        <ul>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/senior/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/senior/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/senior/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">설문조사</h3>
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/senior/ssem/survey_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap plr_40">
                    <div class="row">
                        <div class="col_2 col_md_6 pr_10">
                            <div class="sel_box">
                                <select id="searchKind2" name="searchKind2" title="구분선택">
                                    <option value="">구분선택</option>
                                    <option value="1" <c:if test="${searchKind2 eq '1'}">selected="selected"</c:if>>예정</option>
                                    <option value="2" <c:if test="${searchKind2 eq '2'}">selected="selected"</c:if>>진행 중</option>
                                    <option value="3" <c:if test="${searchKind2 eq '3'}">selected="selected"</c:if>>종료</option>
                                </select>
                            </div>
                        </div>
                        <%--<div class="col_2 col_md_6 pl_10">
                            <div class="sel_box">
                                <select title="검색 구분" id="sel1">
                                    <option value="">전체</option>
                                    <option value="제목">제목</option>
                                    <option value="기관">기관</option>
                                    <option value="작성자">작성자</option>
                                </select>
                            </div>
                        </div>--%>
                        <div class="col_8 col_md_12 pl_20 pl_md_0 pt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" id="searchVal" name="searchVal" value="${searchVal}" title="검색어" placeholder="제목을 입력해주세요.">
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
        <div class="wrap text_con fs_20 fs_md_26 mt_50 mb_15 mb_100">
            <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24" id="moTable"> <!--table_list_ul-->
                <ul>
                    <li class="t_head fs_20">
                        <section class="table">
                            <div class="col wid_150">구분</div>
                            <div class="col">제목</div>
                            <div class="col wid_400">설문기간</div>
                        </section>
                    </li>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li class="_moInit noDate">
                            <div class="t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘설문조사’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                        </li>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <c:choose>
                            <c:when test="${item.srv_yn eq '예정'}">
                                <li class="wa_ba">
                                    <a href="#none">
                                        <section class="table">
                                            <div class="col wid_150"><span class="tc_3">${item.srv_yn}</span></div>
                                            <div class="col"><p class="ellip_1 t_left">${item.title}</p></div>
                                            <div class="col wid_400">${fn:substring(item.start_dt, 0, 10)} ~ ${fn:substring(item.end_dt, 0, 10)}</div>
                                        </section>
                                    </a>
                                </li>
                            </c:when>
                            <c:when test="${item.srv_yn eq '종료'}">
                                <li class="wa_ba">
                                    <a href=#none">
                                        <section class="table">
                                            <div class="col wid_150"><span class="tc_point">${item.srv_yn}</span></div>
                                            <div class="col"><p class="ellip_1 t_left">${item.title}</p></div>
                                            <div class="col wid_400">${fn:substring(item.start_dt, 0, 10)} ~ ${fn:substring(item.end_dt, 0, 10)}</div>
                                        </section>
                                    </a>
                                </li>
                            </c:when>
                            <c:when test="${item.srv_yn eq '진행 중'}">
                                <li class="wa_ba">
                                    <a href="/ssem/senior/ssem/survey_insert.do?svy_idx=${item.svy_idx}">
                                        <section class="table">
                                            <div class="col wid_150"><span class="tc_1">${item.srv_yn}</span></div>
                                            <div class="col"><p class="ellip_1 t_left">${item.title}</p></div>
                                            <div class="col wid_400">${fn:substring(item.start_dt, 0, 10)} ~ ${fn:substring(item.end_dt, 0, 10)}</div>
                                        </section>
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </ul>
            </div><!--table_list_ul//-->
            <common:pageLink name="pageholder"/>
        </div>
    </div>
</div>
