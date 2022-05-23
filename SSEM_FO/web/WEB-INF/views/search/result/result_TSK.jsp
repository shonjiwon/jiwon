<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var = "thisCollection" value="ssem_task"/>
<c:set var = "thisTotalCount" value="${search._TSK[0].COUNT}"/>

<c:if test="${search.collection == 'ALL' || search.collection == thisCollection}">

	<c:if test="${thisTotalCount gt 0 }">
		<div class="s_item">
			<h2 class="s_tit">직원 및 담당업무 (총 <span class="tc_p"><c:if test="${search._TSK[0].COUNT eq null}">
				0
			</c:if>
			<c:if test="${search._TSK[0].COUNT ne null}">
				${search._TSK[0].COUNT}
			</c:if></span>건)</h2>
			<div class="s_table_box">
					<table>
						<caption class="text_hide">직원 및 담당업무 의 부서명, 성명/작성, 전화번호, 업무내용 안내</caption>
						<colgroup>
							<col style="width: 260px;">
							<col style="width: 170px;">
							<col style="width: 200px;">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>부서명</th>
								<th>성명/작성</th>
								<th>전화번호</th>
								<th>업무내용</th>
							</tr>
						</thead>
						
						<c:forEach items="${search._TSK}" var="idx" begin="1">
							<tr>
								<td class="t_center">
									<div class="s_mo_th">부서명</div> 
									<div>${idx.CHRG_DEPT_NM }</div>
								</td>
								<td class="t_center">
									<div class="s_mo_th">성명/작성</div> 
									<div> <a href="#">${idx.EMPL_NM }</a></div>
								</td>
								<td class="t_center">
									<div class="s_mo_th">전화번호</div> 
									<div> ${idx.EMPL_TELNO }</div>
								</td>
								<td>
									<div class="s_mo_th">업무내용</div> 
									<div> ${idx.EMPL_JOB }</div>
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
				<h2 class="s_tit">직원 및 담당업무 (총 <span class="tc_p">0</span>건)</h2>

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