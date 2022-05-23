<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-10
  Time: 오후 8:58
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
        $(document).prop('title', '통합프로그램신청 > 평생교육 > 송파쌤');

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

        if(frm.searchSDate.value > frm.searchEDate.value) {
            modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
            return false;
        }

        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_9"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    통합프로그램신청
                </h2>

                <p class="tit_sub">
                    청소년의 적성과 재능에 맞는 길을 찾아주는<br>
                    열린교육 송파쌤, 청소년 교육
                </p>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">통합프로그램신청</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
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
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">통합프로그램신청</h3>
                </div>
                <div class="col_2 t_right pt_100">
                    <!-- <button type="button" data-popup-id="#popup1" class="act_popup_map_open mt_10">
                        <span class="font_nsk fs_20 fs_md_20 mr_10">이용안내</span> <i class="icon_q2">질문</i>
                    </button> -->
                </div>
            </div>
        </div>
        <form name="frm" id="frm" method="post" action="/ssem/senior/program/lecture_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <div class="wrap_1250">
                <div class="row row_p_10">
                    <div class="col_3 col_md_6 pr_md_10">
                        <div class="sel_box sel_full sel_md_short">
                            <select name="searchKind4" id="searchKind4" title="교육기관" class="placeholder">
                                <option value="">교육기관 선택</option>
                                <c:forEach items="${groupList}" var="group" varStatus="status">
                                    <option value="${group.group_idx}" <c:if test="${searchKind4 eq group.group_idx}">selected="selected"</c:if>>${group.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col_3 col_md_6 pr_md_10">
                        <div class="sel_box sel_full sel_md_short">
                            <select name="searchVal8" id="searchVal8" title="교육대상" class="placeholder">
                                <option value="">교육대상 선택</option>
                                <c:forEach items="${tgtList}" var="tgt" varStatus="status">
                                    <option value="${tgt.code_idx}" <c:if test="${searchVal8 eq tgt.code_idx}">selected="selected"</c:if>>${tgt.cd_val}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col_3 col_md_6 mt_md_20 pr_md_10">
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchVal2" name="searchVal2" title="수강료" class="placeholder">
                                <option value="">수강료 선택</option>
                                <option value="S" <c:if test="${searchVal2 eq 'S'}">selected="selected"</c:if>>유료</option>
                                <option value="F" <c:if test="${searchVal2 eq 'F'}">selected="selected"</c:if>>무료</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_3 col_md_6 mt_md_20 pl_md_10">
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchVal5" name="searchVal5" title="정보화 교육 여부" class="placeholder">
                                <option value="">정보화 교육 여부 선택</option>
                                <option value="Y" <c:if test="${searchVal5 eq 'Y'}">selected="selected"</c:if>>예</option>
                                <option value="N" <c:if test="${searchVal5 eq 'N'}">selected="selected"</c:if>>아니오</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row_24 row_p_10">
                    <div class="col_5 col_md_12">
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchVal6" name="searchVal6" title="교육분야" class="placeholder">
                                <option value="">교육분야 선택</option>
                                <c:forEach items="${codeList}" var="code" varStatus="status">
                                    <option value="${code.code_idx}" <c:if test="${searchVal6 eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col_5 col_md_12 ">
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchVal7" name="searchVal7" title="접수상태" class="placeholder">
                                <option value="">접수상태 선택</option>
                                <option value="1" <c:if test="${searchVal7 eq '1'}">selected="selected"</c:if>>접수대기</option>
                                <option value="2" <c:if test="${searchVal7 eq '2'}">selected="selected"</c:if>>신청가능</option>
                                <option value="8" <c:if test="${searchVal7 eq '8'}">selected="selected"</c:if>>대기신청</option>
                                <option value="3" <c:if test="${searchVal7 eq '3'}">selected="selected"</c:if>>신청마감</option>
                                <option value="4" <c:if test="${searchVal7 eq '4'}">selected="selected"</c:if>>교육전</option>
                                <option value="5" <c:if test="${searchVal7 eq '5'}">selected="selected"</c:if>>교육중</option>
                                <option value="6" <c:if test="${searchVal7 eq '6'}">selected="selected"</c:if>>교육종료</option>
                                <option value="7" <c:if test="${searchVal7 eq '7'}">selected="selected"</c:if>>외부홈페이지</option>
                            </select>
                        </div>
                    </div>

                    <div class="col_14 col_md_24 mt_md_20">
                        <div class="row_24 row_p_10">

                            <div class="col_7  offset_md_0">
                                <div class="sel_box sel_full sel_md_short">
                                    <select id="searchKind2" name="searchKind2" title="기간" class="placeholder">
                                        <option value="">기간 선택</option>
                                        <option value="ALL" <c:if test="${searchKind2 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                        <option value="1" <c:if test="${searchKind2 eq '1'}">selected="selected"</c:if>>교육기간</option>
                                        <option value="2" <c:if test="${searchKind2 eq '2'}">selected="selected"</c:if>>접수기간</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col_8 col_md_8">
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
                            <div class="col_8 col_md_8">
                                <div class="fm_cal">
                                    <div class="fm_inp fm_date mr_10">
                                        <input type="text" class="inp" id="searchEDate" name="searchEDate" title="종료일" value="${searchEDate}">
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row row_p_10">
                    <div class="col_12 mt_md_25 data_search_word_box">
                        <div class="fm_inp inp_full">
                            <input class="inp" title="검색어" placeholder="프로그램명 또는 강사명으로 검색하세요." id="searchVal" name="searchVal" value="${searchVal}">
                        </div>
                        <button type="button" class="data_search_btn" id="btn_search">
                            <i class="icon_search">검색</i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <div class="wrap">
            <ul class="program_info_list st_2">
                <c:if test="${fn:length(itemList) == 0}">
                    <li>
                        <section>
                            <!--data : s-->
                            <div class="noDate t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘통합프로그램신청’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </section>
                    </li>
                </c:if>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                <!--list_item-->
                <li>
                    <a href="/ssem/senior/program/lecture_view.do?lecture_idx=${item.lecture_idx}">
                        <section>
                            <div class="program_info_box st_2">
                                <div class="top clearfix mb_20 mb_md_40">
                                    <p class="title fs_30 fw_600 float_left float_md_none">${item.name}</p>
                                    <div class="float_right float_md_none fs_20 fs_md_22 mt_5 t_right t_md_left mt_md_10 clearfix_after">
                                        <c:choose>
                                            <c:when test="${fn:contains(item.reg_method, '4')}">
                                                <span class="btn link_btn va_m mr_10">외부홈페이지</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${item.status_code eq '1'}"><span class="btn link_btn va_m mr_10">접수대기</span></c:when>
                                                    <c:when test="${item.status_code eq '2'}">
                                                        <c:if test="${fn:contains(item.reg_method, '1')}"><span class="btn link_btn va_m mr_10">온라인신청가능</span></c:if>
                                                        <c:choose>
                                                            <c:when test="${item.tel_can_qty + item.visit_can_qty eq 0}">
                                                                <c:if test="${fn:contains(item.reg_method, '2') || fn:contains(item.reg_method, '3')}">
                                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                                </c:if>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${item.status_code eq '3'}">
                                                        <span class="btn link_btn va_m mr_10">대기신청</span>
                                                        <c:choose>
                                                            <c:when test="${item.tel_can_qty + item.visit_can_qty eq 0}">
                                                                <c:if test="${fn:contains(item.reg_method, '2') || fn:contains(item.reg_method, '3')}">
                                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                                </c:if>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${item.status_code eq '4'}">
                                                        <c:if test="${fn:contains(item.reg_method, '1')}"><span class="btn link_btn va_m mr_10">온라인신청마감</span></c:if>
                                                        <c:choose>
                                                            <c:when test="${item.tel_can_qty + item.visit_can_qty eq 0}">
                                                                <c:if test="${fn:contains(item.reg_method, '2') || fn:contains(item.reg_method, '3')}">
                                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                                </c:if>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${item.status_code eq '5'}"><span class="btn link_btn va_m mr_10">교육전</span></c:when>
                                                    <c:when test="${item.status_code eq '6'}"><span class="btn link_btn va_m mr_10">교육중</span></c:when>
                                                    <c:when test="${item.status_code eq '7'}"><span class="btn link_btn va_m mr_10">교육종료</span></c:when>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${item.qty_open_yn ne 'N'}">
                                            <span class="va_m">신청인원 및 정원</span>
                                            <span class="va_m tc_1 fw_600"><c:out value="${item.online_qty - item.online_can_qty}" /></span>
                                            <span class="va_m fw_600">/<c:out value="${item.online_qty + item.tel_qty + item.visit_qty}" /></span>
                                            <span class="va_m">명 (대기자 ${item.wait_qty - item.wait_can_qty}/${item.wait_qty}명)</span>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${item.love_self_yn eq 'Y'}">
                                                <span class="btn like_btn va_m ml_10 float_md_right"><i class="icon_heart_line on" title="활성화">하트</i> <span class="count">${item.love_cnt}</span></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="btn like_btn va_m ml_10 float_md_right"><i class="icon_heart_line" title="비활성화">하트</i> <span class="count">${item.love_cnt}</span></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div>
                                    <div class="catalogue_box">
                                        <span class="item">교육기관</span>
                                        <span class="item">${item.group.name}</span>
                                    </div>
                                    <div class="catalogue_box">
                                        <span class="item">교육분야</span>
                                        <span class="item">${item.part_name}</span>
                                    </div>
                                    <br>
                                    <div class="catalogue_box">
                                        <span class="item">교육대상</span>
                                        <c:forEach items="${item.array_tgt}" var="tgt" varStatus="status">
                                            <span class="item">${tgt}</span>
                                        </c:forEach>
                                    </div>
                                </div>

                                <ul class="row mt_40">
                                    <li class="col_4 col_md_6"><span><b class="fw_400">교육기간 :</b> ${fn:substring(item.start_dt, 2, 10)} ~ ${fn:substring(item.end_dt, 2, 10)}</span></li>
                                    <li class="col_4 col_md_6"><span><b class="fw_400">교육시간 :</b> ${item.dt_str}  ${item.start_time}~${item.end_time}</span></li>
                                    <li class="col_4 col_md_6"><span><b class="fw_400">수강료 :</b> <fmt:formatNumber value="${item.fee}" pattern="##,###"/>원</span></li>
                                    <li class="col_4 col_md_6">
                                        <span><b class="fw_400">접수기간 :</b><br>
                                            ${fn:substring(item.reg_start_st, 2, 16)} ~ ${fn:substring(item.reg_end_dt, 2, 16)}
                                        </span>
                                    </li>
                                    <li class="col_4 col_md_6"><span><b class="fw_400">접수방법 :</b> ${item.reg_method_str}</span></li>
                                    <li class="col_4 col_md_6"><span><b class="fw_400">문의 :</b> ${item.group.tel_no}</span></li>
                                </ul>

                            </div>
                        </section>
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
        <common:pageLink name="pageholder"/>
    </div>

    <div class="popup_wrap_st3" id="popup1">
        <div class="popup_box">
            <div class="popup_top">
                <p>이용안내</p>
            </div>
            <div class="popup_con">
                이용안내 내용
            </div>
            <div class="popup_btn clearfix">
                <button type="button" data-popup-id="#popup1" class="btn float_right btn_short close_btn"><span class="fs_20 fs_md_26">닫기</span></button>
            </div>
            <button class="close_btn" data-popup-id="#popup1"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>

</div>
