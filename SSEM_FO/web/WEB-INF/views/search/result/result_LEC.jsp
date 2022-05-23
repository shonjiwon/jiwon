<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var = "thisCollection" value="ssem_lecture"/>
<c:set var = "thisTotalCount" value="${search._LEC[0].COUNT}"/>

<c:if test="${search.collection == 'ALL' || search.collection == thisCollection}">

	<c:if test="${thisTotalCount gt 0 }">
	
		<div class="s_item">
		
				<h2 class="s_tit">통합프로그램 (총 <span class="tc_p"><c:if test="${search._LEC[0].COUNT eq null}">
							0
						</c:if>
						<c:if test="${search._LEC[0].COUNT ne null}">
							${search._LEC[0].COUNT}
						</c:if></span>건)</h2>
						
						<div class="s_table_box">
								<table>
									<caption class="text_hide">통합프로그램의 구분, 접수상태, 강좌명, 접수교육기간, 수강료, 교육장소, 모집방법 안내</caption>
									<colgroup>
										<col style="width: 100px;">
										<col style="width: 145px;">
										<col style="width: 260px;">
										<col style="width: 260px;">
										<col style="width: 100px;">
										<col>
										<col style="width: 100px;">
									</colgroup>
									<thead>
										<tr>
											<th>구분</th>
											<th>접수상태</th>
											<th>강좌명</th>
											<th>접수/교육기간</th>
											<th>수강료</th>
											<th>교육장소</th>
											<th>모집방법</th>
										</tr>
									</thead>
									
									
			
									<c:forEach items="${search._LEC}" var="idx" begin="1">					
										<tr>
											<td>
												<div class="s_mo_th">구분</div> 
												<div>${idx.GUBUN }</div>
											</td>
											<td class="t_center">
												<div class="s_mo_th">접수상태</div> 
												<div>	<c:if test="${idx.LECT_STATUS ne '교육종료' }"><span class="marker_line">${idx.LECT_STATUS }</span></c:if>
														<c:if test="${idx.LECT_STATUS eq '교육종료' }"><span class="marker">${idx.LECT_STATUS }</span></c:if>
												</div>
											</td>
											<td>
												<div class="s_mo_th">강좌명</div> 
												<div> <a href="${idx.LEC_URL }" target="_blank"> ${idx.TITLE }</a></div>
											</td>
											<td>
												<div class="s_mo_th">접수교육기간</div> 
												<div> 
													<!-- 날짜포맷 trim 해야함 -->
													<p>접수 : ${idx.REG_START_ST }~${idx.REG_END_ST }</p>
													<p>교육 : ${idx.START_DT }~${idx.START_DT1 }</p>
												</div>
											</td>
											<td>
												<div class="s_mo_th">수강료</div> 
												<!-- 원단위 trim -->
												<div> ${idx.FEE }</div>
											</td>
											<td>
												<div class="s_mo_th">교육장소</div> 
												<div>${idx.GRP_NAME }</div>
											</td>
											<td>
												<div class="s_mo_th">모집방법</div> 
												<div>${idx.REG_METHOD }</div>
											</td>
										</tr>			
						        	</c:forEach>	
								</table>
						
						</div>
					
			
				<c:if test="${search.collection ne thisCollection}">
					<a class="more_btn" href="#" onClick="javascript:doCollection('${thisCollection}');"><i class="icon_plus_b">더하기</i>더 보기</a>
				</c:if>
		    
		</div>
								<!-- paginate -->
				<div class="paginate">
					<c:if test="${search.collection ne 'ALL'}">
						${search.schPaginate}
					</c:if>
				</div>
			<!-- //paginate -->
	</c:if>
	<c:if test="${search.collection eq 'ALL'}">
		<c:if test="${thisTotalCount eq 0 || thisTotalCount eq null}">
			<div class="s_item s_list_box">
				<h2 class="s_tit">통합프로그램 (총 <span class="tc_p">0</span>건)</h2>

			</div>
		</c:if>
	</c:if>	
	<c:if test="${search.collection ne 'ALL'}">
		<c:if test="${thisTotalCount eq 0 || thisTotalCount eq null}">
					<div class="s_item">
						<div class="noDate t_center">
							<div class="mtb_40">
								<img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음">
								<p class="mt_30 fs_30"><span class="fw_600 tc_p">“${search.query}”</span> 에 대한 검색결과가 없습니다.</p>
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
</c:if>