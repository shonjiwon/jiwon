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

            $(document).prop('title', '송파쌤 > 프로그램 검색 > 미래교육');
        });
    </script>
    
    	<link rel="stylesheet" type="text/css" href="/ssem/resources/css/search.css" />
	<script type="text/javascript" src="/ssem/resources/sch/ark/js/beta.fix.js"></script>
	<script type="text/javascript" src="/ssem/resources/sch/js/search.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {

		getPopkeywordTop()
		// 인기 검색어
	    getPopkeyword();
		// 내가 찾은 검색어
		getMyKeyword("${search.query}", "${search.totalCount}");
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
 	

<!-- 검색 시작 -->
<div id="s_header">
	<form name="search" id="search" action="/ssem/intro/search/youth_search.do" method="POST" accept-charset="UTF-8">
	
				<input type="hidden" name="startCount" value="0">
				<input type="hidden" name="sort" value="${search.sort}">
				<input type="hidden" name="collection" value="${search.collection}">
				<input type="hidden" id="range" name="range" value="${search.range}">
				
				<input type="hidden" id="orFlag" name="orFlag" value="${search.orFlag}">
				<input type="hidden" id="excludeFlag" name="excludeFlag" value="${search.excludeFlag}">
				
				
				<input type="hidden" name="searchField" value="${search.searchField}">
				<input type="hidden" name="reQuery" />
				
				<input type="hidden" name="schDtlField" value="${search.schDtlField}"/>			
				<input type="hidden" name="realQuery" value="${search.realQuery}" />			
				
		<div class="wrap">
			<div>
				<div class="s_logo">
					<img src="/ssem/resources/img/search/logo_search.png" alt="송파쌤 ssem 통합검색">
				</div>

				<div class="s_search_wrap">
					<div class="s_search_box">
						<div class="fm_inp">
							<input type="text" name="query" id="query" title="검색어" class="inp" value="${search.query}" onKeypress="javascript:pressCheck((event),this);">
						</div>
						<button type="submit" class="search_btn"><i class="icon_search_w">검색</i></button>
					</div>
					<button type="button" class="search_detail_btn" onclick="$('#sDetail').fadeIn(200);">상세검색</button>

					<div class="s_ch_box">
						<label class="fm_ch act_uiRdCh"> 
							<input type="checkbox" name="ch1" id="reChk" name="reChk" onClick="checkReSearch();">
							<span for="_icon">결과 내 재검색</span>
						</label>
					</div>

					<div class="recommend_box">
						<strong class="recommend_tit">추천검색어</strong>
						<div>
							<div id ="recQry"></div>

						</div>
					</div>
					
				</div>

			
			</div>

			<div class="s_detail_form" id="sDetail">
				<div class="s_wrap">
					<div class="s_detail_tit"><span>검색기간</span></div>
					<div class="s_detail_item">
					
						<c:if test="${search.range eq 'A'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('A')" checked>
									<span for="_icon">전체기간</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.range ne 'A'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('A')">
									<span for="_icon">전체기간</span>
								</label>
							</div>
						</c:if>

						<div>
							<div class="fm_cal_box">
								<div class="fm_cal">
									<div class="fm_inp fm_date mr_10">
										<input type="text" class="inp" title="시작일" id="startDate" name="startDate" value="${search.startDate}">
										<button type="button" class="fm_date_btn">
											<i class="icon_cal">달력</i>
										</button>
									</div>
								</div>
								<div class="dash">~</div>
								<div class="fm_cal">
									<div class="fm_inp fm_date mr_10">
										<input type="text" class="inp" title="종료일" id="endDate" name="endDate" value="${search.endDate}">
										<button type="button" class="fm_date_btn">
											<i class="icon_cal">달력</i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<br class="screen_hide screen_lg_show"> 
						<c:if test="${search.range eq 'W'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('W')" checked>
									<span for="_icon">1주</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.range ne 'W'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('W')">
									<span for="_icon">1주</span>
								</label>
							</div>
						</c:if>
						
						<c:if test="${search.range eq 'M'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('M')" checked>
									<span for="_icon">1개월</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.range ne 'M'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('M')">
									<span for="_icon">1개월</span>
								</label>
							</div>
						</c:if>
						
						<c:if test="${search.range eq 'Y'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('Y')" checked>
									<span for="_icon">1년</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.range ne 'Y'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch2" onClick="javascript:setDate('Y')">
									<span for="_icon">1년</span>
								</label>
							</div>
						</c:if>
						
					</div>
				</div>

				<div class="s_wrap">
					<div class="s_detail_tit"><span>검색방법</span></div>
					<div class="s_detail_item">

						<div>
							<label class="fm_ch act_uiRdCh"> 
								<input type="radio" name="ch3" onClick="javascript:setOrFlag('1');">
								<span for="_icon">하나라도 포함된 결과(OR)</span>
							</label>
						</div>
						
						<div>
							<label class="fm_ch act_uiRdCh"> 
								<input type="radio" name="ch3" onClick="javascript:setOrFlag('2');">
								<span for="_icon">제외하는 단어</span>
							</label>
						</div>
						<div>
							<div class="fm_inp">
								<input type="text" name="excludeStr" id="excludeStr" class="inp"  title="제외하는 단어명" value="${search.excludeFlag }"> 
							</div>
						</div>
					</div>
				</div>

				<div class="s_wrap">
					<div class="s_detail_tit"><span>검색범위</span></div>
					<div class="s_detail_item">

						<c:if test="${search.searchField eq 'ALL'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('ALL');" checked>
									<span for="_icon">전체</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.searchField ne 'ALL'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('ALL');">
									<span for="_icon">전체</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.searchField eq 'TITLE'}">	
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('TITLE');" checked>
									<span for="_icon">제목</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.searchField ne 'TITLE'}">	
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('TITLE');">
									<span for="_icon">제목</span>
								</label>
							</div>
						</c:if>
						<c:if test="${search.searchField eq 'CONTENT'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('CONTENT');" checked>
									<span for="_icon">내용</span>
								</label>
							</div>
						</c:if>	
						<c:if test="${search.searchField ne 'CONTENT'}">
							<div>
								<label class="fm_ch act_uiRdCh"> 
									<input type="radio" name="ch4" onClick="setSearchField('CONTENT');">
									<span for="_icon">내용</span>
								</label>
							</div>
						</c:if>	
					</div>
				</div>

				<button type="button" class="s_detail_close" onclick="$('#sDetail').hide();">
					<i class="icon_plus_b">닫기</i>
				</button>
			</div>
		</div>
			
	</form>


</div>

<div class="s_tab">
	<div class="wrap">
		<ul>
			<c:set var = "totalCountView" value="${search._MN[0].COUNT+search._LEC[0].COUNT+search._BBS[0].COUNT+search._WEB[0].COUNT+search._ATC[0].COUNT+search._MUL[0].COUNT+search._TSK[0].COUNT}"/>
 		
			<c:if test="${search.collection eq 'ALL'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ALL');">통합검색<c:if test="${totalCountView ne '0' && totalCountView ne null}">(${totalCountView })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ALL'}"> <li><a href="#none" onClick="javascript:doCollection('ALL');">통합검색<c:if test="${totalCountView ne '0' && totalCountView ne null}">(${totalCountView })</c:if></a></li></c:if>
			
			<c:if test="${search.collection eq 'ssem_menusch'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_menusch');">메뉴검색<c:if test="${search._MN[0].COUNT ne '0' && search._MN[0].COUNT ne null}">(${search._MN[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_menusch'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_menusch');">메뉴검색<c:if test="${search._MN[0].COUNT ne '0' && search._MN[0].COUNT ne null}">(${search._MN[0].COUNT })</c:if></a></li></c:if>
			
			<c:if test="${search.collection eq 'ssem_lecture'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_lecture');">통합프로그램<c:if test="${search._LEC[0].COUNT ne '0' && search._LEC[0].COUNT ne null}">(${search._LEC[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_lecture'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_lecture');">통합프로그램<c:if test="${search._LEC[0].COUNT ne '0' && search._LEC[0].COUNT ne null}">(${search._LEC[0].COUNT })</c:if></a></li></c:if>

			<c:if test="${search.collection eq 'ssem_bbs'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_bbs');">게시판<c:if test="${search._BBS[0].COUNT ne '0' && search._BBS[0].COUNT ne null}">(${search._BBS[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_bbs'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_bbs');">게시판<c:if test="${search._BBS[0].COUNT ne '0' && search._BBS[0].COUNT ne null}">(${search._BBS[0].COUNT })</c:if></a></li></c:if>

			<c:if test="${search.collection eq 'ssem_webpage'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_webpage');">웹페이지<c:if test="${search._WEB[0].COUNT ne '0' && search._WEB[0].COUNT ne null}">(${search._WEB[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_webpage'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_webpage');">웹페이지<c:if test="${search._WEB[0].COUNT ne '0' && search._WEB[0].COUNT ne null}">(${search._WEB[0].COUNT })</c:if></a></li></c:if>

			<c:if test="${search.collection eq 'ssem_attach'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_attach');">첨부파일<c:if test="${search._ATC[0].COUNT ne '0' && search._ATC[0].COUNT ne null}">(${search._ATC[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_attach'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_attach');">첨부파일<c:if test="${search._ATC[0].COUNT ne '0' && search._ATC[0].COUNT ne null}">(${search._ATC[0].COUNT })</c:if></a></li></c:if>

			<c:if test="${search.collection eq 'ssem_multimedia'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_multimedia');">멀티미디어<c:if test="${search._MUL[0].COUNT ne '0' && search._MUL[0].COUNT ne null}">(${search._MUL[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_multimedia'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_multimedia');">멀티미디어<c:if test="${search._MUL[0].COUNT ne '0' && search._MUL[0].COUNT ne null}">(${search._MUL[0].COUNT })</c:if></a></li></c:if>

			<c:if test="${search.collection eq 'ssem_task'}"> <li class="on"><a href="#none" onClick="javascript:doCollection('ssem_task');">직원 및 담당업무<c:if test="${search._TSK[0].COUNT ne '0' && search._TSK[0].COUNT ne null}">(${search._TSK[0].COUNT })</c:if></a></li></c:if>
			<c:if test="${search.collection ne 'ssem_task'}"> <li><a href="#none" onClick="javascript:doCollection('ssem_task');">직원 및 담당업무<c:if test="${search._TSK[0].COUNT ne '0' && search._TSK[0].COUNT ne null}">(${search._TSK[0].COUNT })</c:if></a></li></c:if>

		</ul>
	</div>
</div>


<div class="contents s_con" id="contents">
	<div class="wrap st_2">

		<!--검색 내용-->
		<section class="s_left_box">

			<!--검색어-->
			<div class="s_item">
				<h1 class="s_tit">검색어 <span class="tc_p">“${search.query }”</span>에 대한 통합검색결과는 <span class="tc_p">“${totalCountView }”</span>건입니다.</h1>
			</div>

			<!--데이터 없음-->
			<c:if test="${search.collection eq 'ALL'}">
				<c:if test="${totalCountView eq '0' || totalCountView eq null}">
					<div class="s_item">
						<div class="noDate t_center">
							<div class="mtb_40">
								<img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음">
								<p class="mt_30 fs_30"><span class="fw_600 tc_p">“”</span> 에 대한 검색결과가 없습니다.</p>
							</div>
						</div>
					</div>
					
					<div class="s_item">
						<ul class="ul_list_star">
							<li>단어의 철자가 정확한지 확인해 보세요</li>
							<li>한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요</li>
							<li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요</li>
							<li>두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.</li>
						</ul>
					</div>
				
				</c:if>
			</c:if>

			<!--메뉴검색-->			
			<%@ include file="./search/result/result_MN.jsp"%>
			
			<!--통합프로그램-->
			<%@ include file="./search/result/result_LEC.jsp"%>

			<!--게시판-->
			<%@ include file="./search/result/result_BBS.jsp"%>

			<!--웹페이지-->
			<%@ include file="./search/result/result_WEB.jsp"%>

			<!--첨부파일-->
			<%@ include file="./search/result/result_ATC.jsp"%>
			
			<!--멀티미디어-->
			<%@ include file="./search/result/result_MUL.jsp"%>

			<!--직원 및 담당업무 -->
			<%@ include file="./search/result/result_TSK.jsp"%>
			
		</section>

		<!--인기검색어, 내가 찾은 검색어-->
		<section class="s_right_box">
		

			<!-- 인기검색어 -->
			<div id="popword"></div>
			<!-- 내가 찾은 검색어 -->
			<div id="mykeyword">
			</div>
		</section>

	</div>
</div>
<!-- 검색E -->
        
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
