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
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">공지사항</a>
                        <ul>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/youth/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/youth/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/youth/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">공지사항</h3>
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/youth/ssem/notice_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap plr_40">
                    <div class="row">
                        <div class="col_2 col_md_12">
                            <div class="sel_box">
                                <select name="searchKind4" id="searchKind4" title="검색조건" class="placeholder">
                                    <option value="ALL" <c:if test="${searchKind4 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                    <option value="1" <c:if test="${searchKind4 eq '1'}">selected="selected"</c:if>>제목</option>
                                    <option value="2" <c:if test="${searchKind4 eq '2'}">selected="selected"</c:if>>기관</option>
                                    <option value="3" <c:if test="${searchKind4 eq '3'}">selected="selected"</c:if>>내용</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_10 col_md_12 pl_20 pl_md_0 pt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" name="searchVal" id="searchVal" value="${searchVal}" title="검색어" placeholder="검색어를 입력하세요.">
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
            <p class="t_right"><span class="fw_500 tc">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건</p>
            <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24" id="moTable"> <!--table_list_ul-->
                <ul>
                    <li class="t_head fs_20">
                        <section class="table">
                            <div class="col wid_60 screen_md_hide">NO</div>
                            <div class="col wid_200">기관</div>
                            <div class="col">제목</div>
                            <div class="col wid_150">작성자</div>
                            <div class="col wid_150">날짜</div>
                            <div class="col wid_150">조회</div>
                        </section>
                    </li>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li class="_moInit noDate">
                            <div class="t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘공지사항’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                        </li>
                    </c:if>
                    <c:set var="lno" value="0"/>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <c:set var="lno">${lno + 1}</c:set>
                        <li>
                            <a href="/ssem/youth/ssem/notice_view.do?bbs_detail_idx=${item.bbs_detail_idx}">
                                <section class="table">
                                    <div class="col wid_60 screen_md_hide">
                                        <c:choose>
                                            <c:when test="${item.p_top_yn eq 'Y'}">공지</c:when>
                                            <c:otherwise><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col wid_200">${item.grp_name}</div>
                                    <div class="col t_left"><p class="ellip_1">${item.title}</p></div>
                                    <div class="col wid_150">${item.reg_nm}</div>
                                    <div class="col wid_150">${fn:substring(item.reg_dt, 0, 10)}</div>
                                    <div class="col wid_150"><fmt:formatNumber value="${item.cnt}" pattern="##,###"/></div>
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
