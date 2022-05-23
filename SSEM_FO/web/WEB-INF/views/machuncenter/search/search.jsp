<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-06
  Time: 오전 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
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
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '프로그램 검색 > 마천청소년센터 > 송파쌤');

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
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<!-- 검색 시작 -->
<div id="s_header">
	<form name="search" id="search" action="/ssem/machuncenter/search/search.do" method="POST" accept-charset="UTF-8">
	
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
			<%@ include file="../../search/result/result_MN.jsp"%>
			
			<!--통합프로그램-->
			<%@ include file="../../search/result/result_LEC.jsp"%>

			<!--게시판-->
			<%@ include file="../../search/result/result_BBS.jsp"%>

			<!--웹페이지-->
			<%@ include file="../../search/result/result_WEB.jsp"%>

			<!--첨부파일-->
			<%@ include file="../../search/result/result_ATC.jsp"%>
			
			<!--멀티미디어-->
			<%@ include file="../../search/result/result_MUL.jsp"%>

			<!--직원 및 담당업무 -->
			<%@ include file="../../search/result/result_TSK.jsp"%>
			
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