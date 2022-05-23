<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 5:36
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
        $(document).prop('title', '배우고 싶어요 > 마그넷스쿨 > 나의 송파쌤 > 평생교육 > 송파쌤');

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
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">마그넷스쿨</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/senior/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/senior/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/senior/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/senior/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">배우고 싶어요</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/senior/mypage/teach_apply_list.do">가르칠 수 있어요</a></li>
                            <li><a href="/ssem/senior/mypage/together_study_list.do">함께배워요</a></li>
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
    <div class="sub_con st_5 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">마그넷스쿨<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">마그넷스쿨</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <ul class="tab tab_3">
                <li class="tab_item on"><a href="/ssem/senior/mypage/hope_study_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/teach_apply_list.do">가르칠 수 있어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/together_study_list.do">함께 배워요</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <div class="data_search ptb_30 fs_20 fs_md_26"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/senior/mypage/hope_study_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap plr_20">
                    <div class="row_15">
                        <div class="col_3 col_md_15">
                            <!--
                                sel_box select class="placeholder"
                                [option value= ""] placeholder 컬러
                            -->
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchKind" name="searchKind" title="검색 구분" class="placeholder">
                                    <option value="ALL" <c:if test="${searchKind eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                    <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>희망강의명</option>
                                    <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>내용</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_12 col_md_15 pl_20 pl_md_0 mt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" name="searchVal" id="searchVal" title="검색어" value="${searchVal}">
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
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_60">
            <div class="wrap">
                <p class="t_right"><span class="fw_500 tc_b">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건</p>
                <div class="table_img_ul st_2 fs_18 mt_15"> <!--table_img_ul-->
                    <ul>
                        <c:if test="${fn:length(itemList) == 0}">
                            <li>
                                <section>
                                    <!--data : s-->
                                    <div class="noDate t_center">
                                        <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                        <p  class="mt_30 fs_30"><span class="fw_600">‘배우고 싶어요’</span> 에 대한 검색결과가 없습니다.</p>
                                    </div>
                                    <!--data : e-->
                                </section>
                            </li>
                        </c:if>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <li>
                                <a href="/ssem/senior/mypage/hope_study_insert.do?hope_study_idx=${item.hope_study_idx}">
                                    <section class="row">
                                        <div class="text_box col_12 fs_20 fs_md_26">
                                            <div class="text_top">
                                                <div class="plr_20 clearfix">
                                                    <ul class="category_list float_left">
                                                        <li>
                                                            <c:choose>
                                                                <c:when test="${item.close_yn eq 'Y'}">
                                                                    <b>종료</b>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <b>진행중</b>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <c:if test="${item.select_yn eq 'Y'}">
                                                            <li><b class="st_2">청원성공</b></li>
                                                        </c:if>
                                                    </ul>
                                                    <!--2020.11.04 : s-->
                                                    <div class="dp_inb float_right">
                                                        <b class="dp_inb mr_20">청원기간</b>
                                                        <span class="tc_sub">${fn:substring(item.reg_dt, 0, 10)} ~ ${item.close_dt}</span>
                                                    </div>
                                                    <!--2020.11.04 : e-->
                                                </div>
                                            </div>
                                            <div class="text_con">
                                                <div class="plr_40 plr_md_20 pt_20 pt_md_40">
                                                    <div class="title ellip_1 fs_26 fs_md_30">${item.name}</div>
                                                    <p class="ellip_1 tc_sub fw_200 mt_md_40">${item.cont}</p>
                                                </div>
                                            </div>
                                            <div class="text_bottom">
                                                <div class="plr_40 plr_md_20 clearfix ">
                                                    <ul class="info_list float_left">
                                                        <li><b>작성자</b> ${item.apy_name}</li>
                                                        <!--2020.11.04 : s-->
                                                        <!--2020.11.04 : e-->
                                                    </ul>
                                                    <div class="float_right">
                                                        <i class="icon_heart_line mr_5 va_m">하트</i>
                                                        <!--2020.11.04 : s-->
                                                        <span class="dp_inb va_m mr_5">함께배워요</span>
                                                        <!--2020.11.04 : e-->
                                                        <span class="dp_inb va_m">${item.join_cnt}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <common:pageLink name="pageholder"/>
            </div>
        </section>
    </div>
</div>
