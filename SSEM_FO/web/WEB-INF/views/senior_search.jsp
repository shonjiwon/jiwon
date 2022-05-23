<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-06
  Time: 오전 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<html lang="ko">
<head>
    <title> 송파쌤 : 검색페이지 </title>
    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <meta property="og:title" content="송파쌤 : 검색페이지">
    <meta property="og:url" content="">
    <meta property="og:image" content="">
    <meta property="og:description" content="세상에서 가장큰 학교 송파쌤(SSEM)">

    <meta property="title" content="송파쌤 : 검색페이지">
    <meta property="url" content="">
    <meta property="image" content="">
    <meta property="description" content="세상에서 가장큰 학교 송파쌤(SSEM)">

    <link rel="shortcut icon" href="/ssem/resources/img/favicon.png">
    <link rel="shortcut icon" type="image/x-icon" href="/ssem/resources/img/favicon.ico">
    <link rel="icon" type="image/x-icon" href="/ssem/resources/img/favicon.ico">

    <!--style -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/layout.css"/>

    <!-- style: main page -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/main.css"/>

    <!-- style: sub page -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/sub.css" />

    <!-- style: color -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/color.css" />

    <!--js -->
    <script src="/ssem/resources/js/jquery-3.4.1.min.js"></script>
    <script src="/ssem/resources/js/common.js"></script>
    <script src="/ssem/resources/js/jquery.ellipsis.min.js"></script>
    <script src="/ssem/resources/js/ui.js"></script>
    <script src="/ssem/resources/js/main.js"></script>

    <!--lib / slick-->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/lib/slick/slick.css"/>
    <script src="/ssem/resources/lib/slick/slick.min.js"></script>

    <!--lib / aos-->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/lib/aos/aos.css"/>
    <script src="/ssem/resources/lib/aos/aos.js"></script>

    <!--lib / aniNum-->
    <script src="/ssem/resources/lib/aniNum/jquery.animateNumber.js"></script>



    <!-- style: sub page -->
    <link rel="stylesheet" href="/ssem/resources/lib/jquery-ui/jquery-ui.css">
    <script src="/ssem/resources/lib/jquery-ui/jquery-ui.js"></script>
    <script src="/ssem/resources/lib/jquery-ui/datepicker-ko.js"></script>
    <script src="/ssem/resources/js/sub.js"></script>
    <!--[if lt IE 10]>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/ie_9.css"/>
    <![endif]-->
    <script>
        $(function(){
            commonInit(); //common.js
            mainInit();   //main.js
            uiInti();       //ui.js
            subInit()       //sub.js

            $(document).prop('title', '송파쌤 > 프로그램 검색 > 평생교육');
        });
    </script>
</head>
<body class="_load">
<script type="text/javascript">
    $(document).ready(function() {
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
        $("#frm").submit();
    }
</script>
<div id="skipNav">
    <a href="#nav">메뉴 바로가기</a>
    <a href="#contents">본문 바로가기</a>
</div>
<!--

#container      : 청소년 교육
#container.st_5 : 평생교육

-->
<div id="container"><!-- container - container -->
    <div id="header">
        <div class="h_area_top">
            <div class="wrap">
                <h1 class="logo">
                    <a href="/ssem"><img src="/ssem/resources/img/common/logo.png" alt="송파쌤 SSEM"></a>
                </h1>
                <h2 class="text_hide">상단메뉴</h2>
                <c:choose>
                    <c:when test="${loginVo eq null}">
                        <ul class="h_top_left">
                            <li><a href="/ssem/youth/login/login.do">로그인</a></li>
                            <li><a href="https://www.songpa.go.kr/user.kdf?a=songpa.login.LoginApp&return_url=&cate_id=BG0000000000&c=4001">회원가입</a></li>
                            <li><a href="/ssem/youth/main/teacher_reg.do">강사신청</a></li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <ul class="h_top_left">
                            <li><a href="/ssem/youth/login/logout.do">로그아웃</a></li>
                            <li><a href="/ssem/youth/mypage/pwd_confirm.do">나의송파쌤</a></li>
                            <li><a href="/ssem/youth/main/teacher_reg.do">강사신청</a></li>
                        </ul>
                    </c:otherwise>
                </c:choose>
                <ul class="h_top_right">
                    <li><a href="/ssem/youth/main/main.do">미래교육</a></li>
                    <li><a href="/ssem/senior/main/main.do">평생교육</a></li>
                </ul>
            </div>
        </div>
        <div class="h_area_bottom"></div>
    </div>
    <div class="contents" id="contents">
        <div class="sub_visual st_12"><!-- sub_visual -->
            <div class="wrap por">
                <div class="sv_text_box">
                    <h2 class="tit font_sc">
                        프로그램 검색
                    </h2>
                </div>
            </div>
        </div><!-- sub_visual : e -->
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
                        <h3 class="mt_100 mb_50 tit font_sc dp_ind">프로그램 검색</h3>
                    </div>
                </div>
            </div>
            <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
                <h4 class="text_hide">탭</h4>
                <a href="#" class="tab_m act">평생교육<i class="icon_arrow_down_w ml_60">다운</i></a>
                <ul class="tab tab_2"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                    <li class="tab_item"><a href="/ssem/intro/search/youth_search.do?searchVal10=${searchVal10}">미래교육 (<fmt:formatNumber value="${youth_cnt}" pattern="##,###"/>)</a></li>
                    <li class="tab_item on"><a href="#">평생교육 (<fmt:formatNumber value="${totalCount}" pattern="##,###"/>)</a></li>
                </ul>
            </div>
            <h4 class="tit2 mt_100 mb_50">평생교육</h4>
            <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
                <div class="wrap_1250">
                    <div class="row row_p_10">
                        <div class="col_12 mt_md_25 data_search_word_box">
                            <form id="frm" name="frm" action="/ssem/intro/search/senior_search.do" method="post">
                                <input type="hidden" name="page" id="page" value="${page}"/>
                            <div class="fm_inp inp_full">
                                <input class="inp" title="프로그램 제목을 입력해주세요" placeholder="프로그램 제목을 입력해주세요" name="searchVal10" id="searchVal10" value="${searchVal10}">
                            </div>
                            <button type="submit" class="data_search_btn" id="btn_search">
                                <i class="icon_search">검색</i>
                            </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="wrap text_con fs_20 fs_md_26 mb_15 mt_60">
                <!--평생교육 : s-->
                <div class="st_search_more st_2 mt_20">
				<span class="ssm_title">
					평생교육 프로그램  <span class="tc_5"><fmt:formatNumber value="${totalCount}" pattern="##,###"/></span>건
				</span>

                    <a href="/ssem/senior/program/lecture_list.do" class="ssm_more">
                        평생교육 프로그램 <span class="fw_600 tc_5">더보기</span>
                    </a>
                </div>
                <!--
                    .program_info_list : 기본 스타일
                    .st_2              : a 링크 형태 스타일
                    .st_search1        : 인트로 검색 미래교육
                -->
                <ul class="program_info_list st_2 st_search2">
                    <c:if test="${fn:length(itemList) == 0}">
                        <li>
                            <section>
                                <!--data : s-->
                                <div class="noDate t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘통합검색’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                                <!--data : e-->
                            </section>
                        </li>
                    </c:if>
                    <!--list_item-->
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <li>
                            <a href="/ssem/senior/program/lecture_view.do?lecture_idx=${item.lecture_idx}">
                                <section>
                                    <div class="program_info_box st_2">
                                        <div class="top clearfix mb_20 mb_md_40">
                                            <p class="title fs_30 fw_600 float_left float_md_none">${item.name}</p>
                                            <div class="float_right float_md_none fs_20 fs_md_22 mt_5 t_right t_md_left mt_md_10 clearfix_after">
                                        <span class="btn link_btn va_m mr_10">
                                            <c:choose>
                                                <c:when test="${fn:contains(item.reg_method, '4')}">
                                                    외부홈페이지
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${item.status_code eq '1'}">접수대기</c:when>
                                                        <c:when test="${item.status_code eq '2'}">신청가능</c:when>
                                                        <c:when test="${item.status_code eq '3'}">대기신청</c:when>
                                                        <c:when test="${item.status_code eq '4'}">신청마감</c:when>
                                                        <c:when test="${item.status_code eq '5'}">교육전</c:when>
                                                        <c:when test="${item.status_code eq '6'}">교육중</c:when>
                                                        <c:when test="${item.status_code eq '7'}">교육종료</c:when>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
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
                                            <li class="col_4 col_md_6"><span><b class="fw_400">교육시간 :</b> ${item.dt_str}</span></li>
                                            <li class="col_4 col_md_6"><span><b class="fw_400">수강료 :</b> <fmt:formatNumber value="${item.fee}" pattern="##,###"/>원</span></li>
                                            <li class="col_4 col_md_6"><span><b class="fw_400">접수기간 :</b> ${fn:substring(item.reg_start_st, 2, 10)} ~ ${fn:substring(item.reg_end_dt, 2, 10)}</span></li>
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
        </div><!-- sub_con : e -->
    </div>
</div><!-- container: e-->

<div class="footer_wrap">
	<div id="footer" class="wd_ka">
		<div class="f_top">
			<div class="wrap">
				<div class="family_site_box">
					<div class="family_site">
						<a class="fs_btn" href="#familySite">동 주민센터</a>
						<ul id="familySite_1">
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2380&" class="export_link" target="_blank">가락1동</a></li>
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2393&" class="export_link" target="_blank">가락2동</a></li>
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2406&" class="export_link" target="_blank">가락본동</a></li>
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2419&" class="export_link" target="_blank">거여1동</a></li>
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2432&" class="export_link" target="_blank">거여2동</a></li>
							<li><a href="https://www.songpa.go.kr/www/contents.do?key=2445&" class="export_link" target="_blank">  마천1동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2458&" class="export_link" target="_blank">  마천2동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2471&" class="export_link" target="_blank">  문정1동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2484&" class="export_link" target="_blank">  문정2동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2497&" class="export_link" target="_blank">  방이1동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2510&" class="export_link" target="_blank">  방이2동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2523&" class="export_link" target="_blank">  삼전동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2536&" class="export_link" target="_blank">  석촌동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2549&" class="export_link" target="_blank">  송파1동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2562&" class="export_link" target="_blank">  송파2동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2575&" class="export_link" target="_blank">  오금동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2588&" class="export_link" target="_blank">  오륜동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2601&" class="export_link" target="_blank">  위례동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2614&" class="export_link" target="_blank">  잠실2동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2627&" class="export_link" target="_blank">  잠실3동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2640&" class="export_link" target="_blank">  잠실4동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2653&" class="export_link" target="_blank">  잠실6동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2666&" class="export_link" target="_blank">  잠실7동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2679&" class="export_link" target="_blank">  잠실본동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2692&" class="export_link" target="_blank">  장지동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2705&" class="export_link" target="_blank">  풍납1동</a></li>
                            <li><a href="https://www.songpa.go.kr/www/contents.do?key=2718&" class="export_link" target="_blank">  풍납2동</a></li>
						</ul>
					</div>
					<div class="family_site">
						<a class="fs_btn" href="#familySite">주요 사이트 </a>
						<ul id="familySite_2">
							<li><a href="https://www.songpa.go.kr/www/index.do?pni_token=${pni_token}" class="export_link" target="_blank">송파구청</a></li>
							<li><a href="https://www.songpa.go.kr/hanseong/index.do" class="export_link" target="_blank">한성백제</a></li>
							<li><a href="https://www.songpa.go.kr/culture/index.do" class="export_link" target="_blank">문화관광</a></li>
							<li><a href="http://www.songpa.tv" class="export_link" target="_blank">송파TV</a></li>
							<li><a href="http://job.seoul.go.kr/songpa/Main.do?method=getMain" class="export_link" target="_blank">일자리센터</a></li>
							<li><a href="https://www.songpa.go.kr/child/index.do" class="export_link" target="_blank">송파꿈나무</a></li>
							<li><a href="http://land.songpa.go.kr" class="export_link" target="_blank">부동산포털</a></li>
							<li><a href="https://www.songpa.go.kr/culture/contents.do?key=3775&" class="export_link" target="_blank">송파둘레길</a></li>
							<li><a href="http://www.spenglish.kr" class="export_link" target="_blank">원어민화상영어(예일이러닝)</a></li>
							<li><a href="http://www.spenglish.co.kr" class="export_link" target="_blank">원어민화상영어(건우애듀)</a></li>
							<li><a href="http://cafe.songpa.go.kr" class="export_link" target="_blank">커뮤니티</a></li>
							<li><a href="http://u-work.songpa.go.kr/uconst/" class="export_link" target="_blank">공사장현장관리</a></li>
							<li><a href="http://u-work.songpa.go.kr/uconst/findFlawMendngMainList.do" class="export_link" target="_blank">하자보증보험증권 열람</a></li>
							<li><a href="http://etax.seoul.go.kr/" class="export_link" target="_blank">서울시Etax</a></li>
							<li><a href="http://songpa.rtms.seoul.go.kr/" class="export_link" target="_blank">부동산거래관리시스템</a></li>
							<li><a href="https://www.laiis.go.kr/lips/nya/lrn/localRegulationList.do" class="export_link" target="_blank">중앙부처 법령유권해석</a></li>
							<li><a href="http://traffic.songpa.go.kr/" class="export_link" target="_blank">주정차 단속조회 민원시스템</a></li>
							<li><a href="http://bid.songpa.go.kr/" class="export_link" target="_blank">계약정보공개시스템</a></li>
							<li><a href="http://www.minwon.go.kr" class="export_link" target="_blank">민원24</a></li>
							<li><a href="http://www.songpa.go.kr/map/index.jsp" class="export_link" target="_blank">송파지도</a></li>
							<li><a href="https://yeyak.seoul.go.kr/main.web"  class="export_link" target="_blank">서울시 공공서비스 예약</a></li>
						</ul>
					</div>
					<div class="family_site">
						<a class="fs_btn" href="#familySite">관내 주요기관</a>
						<ul id="familySite_3">
							<li><a href="http://council.songpa.go.kr" class="export_link" target="_blank">송파구의회</a></li>
							<li><a href="http://ehealth.songpa.go.kr/" class="export_link" target="_blank">송파구보건소</a></li>
							<li><a href="https://www.songpa.go.kr/gumin/index.do" class="export_link" target="_blank">송파구 구민회관</a></li>
							<li><a href="http://www.acrc.go.kr/acrc/index.jsp?menuID=010501" class="export_link" target="_blank">국민권익위원회</a></li>
							<li><a href="http://su.nec.go.kr/su/sp/sub1.jsp" class="export_link" target="_blank">송파구선거관리위원회</a></li>
							<li><a href="http://www.songpagongdan.or.kr" class="export_link" target="_blank">송파구시설관리공단</a></li>
							<li><a href="http://www.esongpa.or.kr" class="export_link" target="_blank">송파구체육문화회관</a></li>
							<li><a href="http://www.songpawoman.org" class="export_link" target="_blank">송파구여성문화회관</a></li>
							<li><a href="http://songpakids.com/" class="export_link" target="_blank">송파구어린이문화회관</a></li>
							<li><a href="http://www.spcc.or.kr" class="export_link" target="_blank">송파구문화원</a></li>
							<li><a href="http://songpa-gu.seoulcci.korcham.net" class="export_link" target="_blank">송파구상공회</a></li>
							<li><a href="http://s.nts.go.kr/sp/" class="export_link" target="_blank">송파구세무서</a></li>
							<li><a href="http://www.smpa.go.kr/sp/" class="export_link" target="_blank">송파구경찰서</a></li>
							<li><a href="http://fire.seoul.go.kr/songpa/" class="export_link" target="_blank">송파소방서</a></li>
							<li><a href="http://songpa.seoulwomanup.or.kr/" class="export_link" target="_blank">송파여성인력개발센터</a></li>
							<li><a href="http://www.splib.or.kr" class="export_link" target="_blank">송파구통합도서관</a></li>
							<li><a href="http://splib.sen.go.kr" class="export_link" target="_blank">송파도서관</a></li>
							<li><a href="http://www.songpavc.or.kr" class="export_link" target="_blank">송파구자원봉사센터</a></li>
							<li><a href="http://www.song-pa.or.kr" class="export_link" target="_blank">송파노인종합복지관</a></li>
							<li><a href="https://www.bookmuseum.go.kr/" class="export_link" target="_blank">송파책박물관</a></li>
						</ul>
					</div>
					<div class="family_site">
						<a class="fs_btn" href="#familySite">서울시 자치구</a>
						<ul id="familySite_4">
							<li><a href="http://www.seoul.go.kr" class="export_link"  target="_blank">서울시청</a></li>
							<li><a href="http://www.jongno.go.kr/portalMain.do" class="export_link"  target="_blank">종로구</a></li>
							<li><a href="http://www.junggu.seoul.kr/index.jsp" class="export_link"  target="_blank">중구</a></li>
							<li><a href="http://www.yongsan.go.kr/site/kr/index.jsp" class="export_link"  target="_blank">용산구</a></li>
							<li><a href="https://www.sd.go.kr/main/index.do" class="export_link"  target="_blank">성동구</a></li>
							<li><a href="https://www.gwangjin.go.kr/portal/main/main.do" class="export_link"  target="_blank">광진구</a></li>
							<li><a href="http://www.ddm.go.kr/" class="export_link"  target="_blank">동대문구</a></li>
							<li><a href="https://www.jungnang.go.kr/" class="export_link"  target="_blank">중랑구</a></li>
							<li><a href="http://www.sb.go.kr/" class="export_link"  target="_blank">성북구</a></li>
							<li><a href="http://www.gangbuk.go.kr/" class="export_link"  target="_blank">강북구</a></li>
							<li><a href="http://www.dobong.go.kr/" class="export_link"  target="_blank">도봉구</a></li>
							<li><a href="http://www.nowon.kr/index.jsp" class="export_link"  target="_blank">노원구</a></li>
							<li><a href="http://www.ep.go.kr/" class="export_link"  target="_blank">은평구</a></li>
							<li><a href="http://www.sdm.go.kr/index.do" class="export_link"  target="_blank">서대문구</a></li>
							<li><a href="http://www.mapo.go.kr/" class="export_link"  target="_blank">마포구</a></li>
							<li><a href="http://www.yangcheon.go.kr/" class="export_link"  target="_blank">양천구</a></li>
							<li><a href="http://www.gangseo.seoul.kr/new_portal/index.jsp" class="export_link"  target="_blank">강서구</a></li>
							<li><a href="http://www.guro.go.kr" class="export_link"  target="_blank">구로구</a></li>
							<li><a href="http://www.geumcheon.go.kr/main/index/index001.jsp" class="export_link"  target="_blank">금천구</a></li>
							<li><a href="https://www.ydp.go.kr/" class="export_link"  target="_blank">영등포구</a></li>
							<li><a href="http://www.dongjak.go.kr/portal/main/main.do" class="export_link"  target="_blank">동작구</a></li>
							<li><a href="http://www.gwanak.go.kr" class="export_link"  target="_blank">관악구</a></li>
							<li><a href="http://www.seocho.go.kr/site/sd/index.jsp" class="export_link"  target="_blank">서초구</a></li>
							<li><a href="http://www.gangnam.go.kr" class="export_link"  target="_blank">강남구</a></li>
							<li><a href="http://www.gangdong.go.kr" class="export_link"  target="_blank">강동구</a></li>
						</ul>
					</div>
				</div>
				<div class="top_btn">
					<button type="button">
						<img src="/ssem/resources/img/common/top_bg.png" alt="top"><br>
					</button>
				</div>
			</div>
		</div>
		<div class="wrap">
			<div class="f_table">
				<h1 class="f_logo">
					<a href="/ssem/youth/main/main.do"><img src="/ssem/resources/img/common/logo_footer.png" alt="송파쌤"></a>
				</h1>

				<div class="f_info_box">
					<div class="f_link">
						<div><a href="/ssem/youth/main/privacy.do">개인정보 처리방침</a></div>
						<div class="line_md_none"><a href="/ssem/youth/main/terms.do">이용약관</a></div><br class="screen_hide screen_md_show ">
						<div><a href="/ssem/youth/main/mail.do">이메일주소무단수집거부</a></div>
						<div><a href="/ssem/youth/main/copyright.do">저작권정책</a></div>
					</div>
					<div class="f_info">
						<span class="line_none mb_10">[05552] 서울특별시 송파구 올림픽로 326 (신천동)</span><br>
						<span>이용문의 : 02-2147-2375 </span><span>프로그램 : 프로그램별 상세페이지의 문의처</span>
					</div>
					<p class="copy">
						COPYRIGHT @ Songpa-gu ALL RIGHT RESRVED.
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
