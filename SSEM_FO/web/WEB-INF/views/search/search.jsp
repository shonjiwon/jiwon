<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ page
	contentType="text/html; charset=UTF-8"%><% request.setCharacterEncoding("UTF-8");%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE HTML>
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

	<link rel="stylesheet" type="text/css" href="/ssem/resources/css/search.css" />
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
	
	<!-- 통합검색js -->
<!-- 
<script type="text/javascript" src="/ssem/resources/sch/js/jquery.min.js"></script>
<script type="text/javascript" src="/ssem/resources/sch/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/ssem/resources/sch/ark/js/beta.fix.js"></script>
<script type="text/javascript" src="/ssem/resources/sch/ark/js/ark.js"></script>
<script type="text/javascript" src="/ssem/resources/sch/js/datepicker.js"></script>
 -->
 
	<link rel="stylesheet" type="text/css" href="/ssem/resources/sch/ark/css/ark.css" media="screen" >
	<script type="text/javascript" src="/ssem/resources/sch/ark/js/beta.fix.js"></script>
	<script type="text/javascript" src="/ssem/resources/sch/ark/js/ark.js"></script>
	<script type="text/javascript" src="/ssem/resources/sch/js/search.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
	
		// 인기 검색어
	    getPopkeyword();
		// 내가 찾은 검색어
		getMyKeyword("${search.query}", "${search.totalCount}");
	});
	</script>
	<!--[if lt IE 10]>
		<link rel="stylesheet" type="text/css" href="/ssem/resources/css/ie_9.css"/>
	<![endif]-->
	
	<script>
		$(function(){
			commonInit(); //common.js
			mainInit();   //main.js
			uiInti();       //ui.js
			subInit()       //sub.js
		});
	</script>




</head>
<body class="_load">











	
	
	

	



<!-- 검색 시작 -->


<div id="s_header">
	<form name="search" id="search" action="/ssem/search.do" method="POST" accept-charset="UTF-8">
	
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
							<a href="###" class="recommend">인물,</a>
							<a href="###" class="recommend">도서,</a>
							<a href="###" class="recommend">구청,</a>
							<a href="###" class="recommend">송파쌤</a>
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

			<!--메뉴검색-->			
			<%@ include file="./result/result_MN.jsp"%>
			
			<!--통합프로그램-->
			<%@ include file="./result/result_LEC.jsp"%>

			<!--게시판-->
			<%@ include file="./result/result_BBS.jsp"%>

			<!--웹페이지-->
			<%@ include file="./result/result_WEB.jsp"%>

			<!--첨부파일-->
			<%@ include file="./result/result_ATC.jsp"%>
			
			<!--멀티미디어-->
			<%@ include file="./result/result_MUL.jsp"%>

			<!--직원 및 담당업무 -->
			<%@ include file="./result/result_TSK.jsp"%>
			
			<!-- 페이징 자바스크립트 경고창 살리기 -->
			<!-- paginate -->
				<div class="paginate">
					<c:if test="${search.collection ne 'ALL'}">
						${search.schPaginate}
					</c:if>
				</div>
			<!-- //paginate -->
		</section>

		<!--인기검색어, 내가 찾은 검색어-->
		<section class="s_right_box">
		
		<!-- 
			<div class="rank_area">
				<h1 class="rank_tit">인기검색어</h1>
				<div class="rank">
					<ol>
						<li class="up" data-rank="1"><a href="#"><span>인물도서관</span></a></li>
						<li class="up" data-rank="2"><a href="#"><span>인물도서관</span></a></li>
						<li class="up" data-rank="3"><a href="#"><span>인물도서관</span></a></li>
						<li class="down" data-rank="4"><a href="#"><span>인물도서관</span></a></li>
						<li class="down" data-rank="5"><a href="#"><span>인물도서관</span></a></li>
						<li class="up" data-rank="1"><a href="#"><span>인물도서관</span></a></li>
						<li class="down" data-rank="7"><a href="#"><span>인물도서관</span></a></li>
						<li class="up" data-rank="1"><a href="#"><span>인물도서관</span></a></li>
						<li class="down" data-rank="10"><a href="#"><span>인물도서관</span></a></li>
						<li class="same" data-rank="1"><a href="#"><span>인물도서관</span></a></li>
					</ol>
				</div>
			</div>
		-->
			<!-- 인기검색어 -->
			<div id="popword"></div>
			<!-- 내가 찾은 검색어 -->
			<div id="mykeyword">
			</div>
		</section>

	</div>
</div>


</body>
</html>
