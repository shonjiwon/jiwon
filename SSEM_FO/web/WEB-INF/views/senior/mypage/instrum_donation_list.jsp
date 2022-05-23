<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 6:22
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
        $(document).prop('title', '악기기증 > 악기도서관 > 나의 송파쌤 > 평생교육 > 송파쌤');

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
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
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
                        <a href="#" class="deapth_tit" title="선택">악기기증</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
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
            <a href="#" class="tab_m act">악기도서관<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">악기도서관</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/senior/mypage/instrum_donation_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap_1250 plr_40">
                    <div class="row_24">
                        <div class="col_6 col_md_12 pr_20">
                            <!--
                                sel_box select class="placeholder"
                                [option value= ""] placeholder 컬러
                            -->
                            <div class="sel_box sel_full">
                                <select name="searchKind2" id="searchKind2" title="악기유형" class="placeholder">
                                    <option value="">악기유형 선택</option>
                                    <option value="A" <c:if test="${searchKind2 eq 'A'}">selected="selected"</c:if>>건반악기</option>
                                    <option value="B" <c:if test="${searchKind2 eq 'B'}">selected="selected"</c:if>>관악기</option>
                                    <option value="C" <c:if test="${searchKind2 eq 'C'}">selected="selected"</c:if>>타악기</option>
                                    <option value="D" <c:if test="${searchKind2 eq 'D'}">selected="selected"</c:if>>현악기</option>
                                    <option value="E" <c:if test="${searchKind2 eq 'E'}">selected="selected"</c:if>>MIDI장비</option>
                                    <option value="K" <c:if test="${searchKind2 eq 'K'}">selected="selected"</c:if>>국악기</option>
                                    <option value="Z" <c:if test="${searchKind2 eq 'Z'}">selected="selected"</c:if>>기타</option>
                                </select>
                            </div>
                        </div>

                        <div class="col_6 col_md_12 pr_20">
                            <div class="sel_box sel_full">
                                <select name="searchKind3" id="searchKind3" title="기증상태" class="placeholder">
                                    <option value="">기증상태 선택</option>
                                    <option value="A" <c:if test="${searchKind3 eq 'A'}">selected="selected"</c:if>>기증신청</option>
                                    <option value="R" <c:if test="${searchKind3 eq 'R'}">selected="selected"</c:if>>기증확인</option>
                                    <option value="O" <c:if test="${searchKind3 eq 'O'}">selected="selected"</c:if>>기증완료</option>
                                    <option value="C" <c:if test="${searchKind3 eq 'C'}">selected="selected"</c:if>>기증취소</option>
                                </select>

                            </div>
                        </div>

                        <div class="col_12 col_md_18 line_md_top">
                            <div class="row_15">
                                <div class="col_7">
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
                                <div class="col_7">
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
                    <div class="row mt_10">
                        <div class="col_12">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" title="검색어" id="searchVal" name="searchVal" placeholder="악기명 또는 악기구입년도로 검색하세요." value="${searchVal}">
                                </div>
                                <button type="button" class="data_search_btn" id="btn_search">
                                    <i class="icon_search">검색</i>
                                </button>
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
                            <section class="table">
                                <div class="col wid_60 screen_md_hide">NO</div>
                                <div class="col wid_150">악기유형</div>
                                <div class="col">악기명</div>
                                <div class="col wid_200">악기구입 년도</div>
                                <div class="col wid_200">신청일</div>
                                <div class="col wid_200">기증상태</div>
                            </section>
                        </li>
                        <!-- item_box :s -->
                        <c:if test="${fn:length(itemList) == 0}">
                            <li class="_moInit noDate">
                                <div class="t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘악기기증’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                            </li>
                        </c:if>
                        <c:set var="lno" value="0"/>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <c:set var="lno">${lno + 1}</c:set>
                            <li class="wa_ba">
                                <a href="/ssem/senior/mypage/instrum_donation_insert.do?instrum_dnt_idx=${item.instrum_dnt_idx}">
                                    <section class="table">
                                        <div class="col wid_60 screen_md_hide"><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></div>
                                        <div class="col wid_150">
                                            <c:choose>
                                                <c:when test="${item.gubun eq 'A'}">건반악기</c:when>
                                                <c:when test="${item.gubun eq 'B'}">관악기</c:when>
                                                <c:when test="${item.gubun eq 'C'}">타악기</c:when>
                                                <c:when test="${item.gubun eq 'D'}">현악기</c:when>
                                                <c:when test="${item.gubun eq 'E'}">MIDI장비</c:when>
                                                <c:when test="${item.gubun eq 'K'}">국악기</c:when>
                                                <c:when test="${item.gubun eq 'Z'}">기타</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col"><p class="ellip_1">${item.instrum_name}</p></div>
                                        <div class="col wid_200">${item.pc_year}</div>
                                        <div class="col wid_200">${fn:substring(item.reg_dt, 0, 10)}</div>
                                        <div class="col wid_200">
                                            <c:choose>
                                                <c:when test="${item.status eq 'A'}"><span class="my_tc_2">기증신청</span></c:when>
                                                <c:when test="${item.status eq 'R'}"><span class="my_tc_1">기증확인</span></c:when>
                                                <c:when test="${item.status eq 'O'}"><span class="my_tc_4">기증완료</span></c:when>
                                                <c:when test="${item.status eq 'C'}"><span class="my_tc_3">기증취소</span></c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
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
