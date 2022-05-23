<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 10:04
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
        $(document).prop('title', '배움 공유채널 > 마그넷스쿨 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

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
    <div class="sub_visual st_7"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    마그넷스쿨
                </h2>

                <p class="tit_sub">
                    <strong>“마그넷스쿨 이란?”</strong>
                    송파마그넷 스쿨은 학습자가 원하는 강좌를 신청하면 <br class="screen_hide screen_sm_show"> 강사 학습자 학습공간을 연결해주는 학교로 자석처럼 학생을<br>
                    끌어당기는 맞춤교육입니다. 배우고 싶던 교육이 있으셨나요? <br class="screen_hide screen_sm_show"> 기다리지 말고 지금 신청해보세요.
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
                        <a href="#" class="deapth_tit" title="선택">마그넷스쿨</a>
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
                        <a href="#" class="deapth_tit" title="선택">배움 공유채널</a>
                        <ul>
                            <li><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                            <li><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
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
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">마그넷스쿨</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">배움 공유채널<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_3"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                <li class="tab_item on"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">배움 공유채널</h4>
        <div class="info_tit wrap t_right fs_22">총 게시물 : <strong><fmt:formatNumber value="${totalCount}" pattern="##,###"/></strong>건</div>
        <form name="frm" id="frm" method="post" action="/ssem/youth/magnet/study_share_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <div class="wrap">
                <div class="row">
                    <div class="col_2 col_md_12 pl_20 pl_md_0 col_half t_md_right">
                        <!--
                            sel_box select class="placeholder"
                            [option value= ""] placeholder 컬러
                        -->
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchKind" name="searchKind" title="분류" class="placeholder">
                                <option value="ALL" <c:if test="${searchKind eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>제목</option>
                                <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>내용</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_10 col_md_12 pl_20 pl_md_0 mt_md_25 data_search_word_box">
                        <div class="fm_inp inp_full">
                            <input class="inp" name="searchVal" id="searchVal" title="검색어" placeholder="검색어를 입력해주세요." value="${searchVal}">
                        </div>
                        <button type="submit" class="data_search_btn" id="btn_search">
                            <i class="icon_search">검색</i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <div class="img_list_wrap st_3"><!--img_list_wrap-->
            <div class="wrap">
                <div class="img_list_box row mt_45 mt_md_30 pt_10">
                    <c:if test="${fn:length(itemList) == 0}">
                        <div class="img_list_item color_1 col_12">
                            <!--data : s-->
                            <div class="noDate t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘배움공유’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </div>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <div class="img_list_item color_1 col_3 col_lg_4 col_sm_6">
                            <a href="/ssem/youth/magnet/study_share_view.do?channel_study_idx=${item.channel_study_idx}">
                                <section>
                                    <div class="img_box">
                                        <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit lh_14">
                                            <span class="ellip_2">${item.title}</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <div class="clearfix plr_5 plr_lg_0">
                                                <span class="float_left">${fn:substring(item.reg_dt, 0, 10)}</span>
                                                <span class="float_right fw_400"><i class="icon_view_bk mr_5">보기</i>${item.cnt}</span>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div><!--img_list_wrap : e-->
        <common:pageLink name="pageholder"/>
    </div>
</div>
