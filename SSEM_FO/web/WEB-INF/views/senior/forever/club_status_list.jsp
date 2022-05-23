<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:22
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
        $(document).prop('title', '활동 현황 > 평생학습동아리 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
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
        $("#page").val("1");
        $("#frm").submit();
    }
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
                        <a href="#" class="deapth_tit" title="선택">평생학습도시 송파</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습동아리</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">연혁</a></li>
                            <li><a href="/ssem/senior/forever/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                            <li><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                            <li><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                            <li><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
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
        <h3 class="mt_80 tit font_sc mb_50">평생학습도시 송파</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">평생학습동아리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">평생학습동아리</h4>
        <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_4">
                <li class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">소개</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/circle_insert.do">등록 및 신청</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/club_status_list.do">활동 현황</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_news_list.do">활동 소식</a></li>
            </ul>
        </div>
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/senior/forever/club_status_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <div class="wrap_1250 plr_40">
                    <div class="row">
                        <div class="col_2 col_md_12">
                            <div class="sel_box">
                                <select title="분야" id="searchKind" name="searchKind">
                                    <option value="">분야 선택</option>
                                    <c:forEach items="${codeList}" var="code" varStatus="status">
                                        <option value="${code.code_idx}" <c:if test="${searchKind eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col_10 col_md_12 pl_20 pl_md_0 pt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" title="검색어" placeholder="동아리 명을 입력해주세요." id="searchVal" name="searchVal" value="${searchVal}">
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
                            <div class="col wid_250">분야</div>
                            <div class="col">제목</div>
                            <div class="col wid_250">회원수</div>
                            <div class="col wid_250">창립일</div>
                        </section>
                    </li>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li>
                            <section>
                                <!--data : s-->
                                <div class="noDate t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘활동 현황’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                                <!--data : e-->
                            </section>
                        </li>
                    </c:if>
                    <c:set var="lno" value="0"/>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <c:set var="lno">${lno + 1}</c:set>
                        <li class="wa_ba">
                            <a href="/ssem/senior/forever/club_status_view.do?club_status_idx=${item.club_status_idx}">
                                <section class="table">
                                    <div class="col wid_60 screen_md_hide"><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></div>
                                    <div class="col wid_250">${item.code_nm}</div>
                                    <div class="col"><p class="ellip_1">${item.name}</p></div>
                                    <div class="col wid_250">${item.mem_cnt}명</div>
                                    <div class="col wid_250">${fn:substring(item.stand_dt, 0, 10)}</div>
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
