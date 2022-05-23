<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:20
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
        $('#btn_update').click(function() {
            $("#frm_update").submit();
        });
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>개인정보</h3>
            </div>
            <div class="right">

            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>이름(아이디)</th>
                <td>
                    ${lectureApyVo.apy_name}
                    <c:if test="${lectureApyVo.apy_id ne null}">
                        (${lectureApyVo.apy_id})
                    </c:if>
                </td>
                <th>생년월일</th>
                <td>${lectureApyVo.apy_birth}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureApyVo.apy_gender eq 'M'}">남</c:when>
                        <c:when test="${lectureApyVo.apy_gender eq 'F'}">여</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <th>휴대폰</th>
                <td>${lectureApyVo.apy_mob_no}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    (${lectureApyVo.postcode}) ${lectureApyVo.apy_addr1} ${lectureApyVo.apy_addr2}
                </td>
            </tr>
            <c:if test="${lectureApyVo.apy_ref ne null && lectureApyVo.apy_ref ne ''}">
            <tr>
                <th>대리여부</th>
                <td colspan="3">
                    Y
                </td>
            </tr>
            <tr>
                <th>신청대리인 관계</th>
                <td colspan="3">
                    ${lectureApyVo.apy_ref}
                </td>
            </tr>
            <tr>
                <th>교육대상자 이름</th>
                <td>${lectureApyVo.apy_real_name}</td>
                <th>교육대상자 휴대폰</th>
                <td>
                        ${lectureApyVo.apy_ref_mob_no}
                    <c:if test="${lectureApyVo.apy_ref_mob_no eq lectureApyVo.apy_mob_no}">
                        (신청자와 동일)
                    </c:if>
                </td>
            </tr>
            </c:if>
            </tbody>
        </table>
    </article>
    <form name="frm_update" id="frm_update" method="post" action="/ssemadmin/cont/lecture/lect_student_update.do" enctype="multipart/form-data">
        <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>프로그램정보</h3>
            </div>
            <div class="right">

            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15rem">
                <col>
                <col style="width:15rem">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>소속</th>
                <td>${lectureVo.p_name}</td>
                <th>교육기관</th>
                <td>${lectureVo.grp_name}</td>
            </tr>
            <tr>
                <th>프로그램명</th>
                <td colspan="3">${lectureVo.name}</td>
            </tr>
            <tr>
                <th>프로그램상태</th>
                <td>
                    <c:choose>
                        <c:when test="${fn:contains(lectureVo.reg_method, '4')}">
                            외부홈페이지
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${lectureVo.status_code eq '1'}">접수대기</c:when>
                                <c:when test="${lectureVo.status_code eq '2'}">신청가능</c:when>
                                <c:when test="${lectureVo.status_code eq '3'}">대기신청</c:when>
                                <c:when test="${lectureVo.status_code eq '4'}">신청마감</c:when>
                                <c:when test="${lectureVo.status_code eq '5'}">교육전</c:when>
                                <c:when test="${lectureVo.status_code eq '6'}">교육중</c:when>
                                <c:when test="${lectureVo.status_code eq '7'}">교육종료</c:when>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </td>
                <th>수강료</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.fee_type eq 'F'}">무료</c:when>
                        <c:when test="${lectureVo.fee_type eq 'S'}">
                            유료 / <fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                        </c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>결재금액</th>
                <td>
                    ${lectureApyVo.pay_sum}
                </td>
                <th>감면여부</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.pay_type eq 'I'}">온라인</c:when>
                        <c:when test="${lectureVo.pay_type eq 'C'}">현장결제</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>교육기간</th>
                <td>
                    ${lectureVo.start_dt} ~ ${lectureVo.end_dt}<br /> ${lectureVo.dt_str} / ${lectureVo.start_time} ~ ${lectureVo.end_time}
                </td>
                <th>수료여부</th>
                <td>
                    <input type="radio" name="cpl_yn" id="cpl_y" value="Y" <c:if test="${lectureApyVo.cpl_yn eq 'Y'}">checked="checked"</c:if>>
                    <label for="cpl_y">수료</label>
                    <input type="radio" name="cpl_yn" id="cpl_n" value="N" <c:if test="${lectureApyVo.cpl_yn eq 'N' || lectureApyVo.cpl_yn eq ''}">checked="checked"</c:if>>
                    <label for="cpl_n">미수료</label>
                </td>
            </tr>
            </tbody>
        </table>
    </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>수강이력</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <div class="btnArea mgt0 mgb10">
            <div class="left">

            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/lect_student_view.do?lecture_apy_idx=${lectureApyVo.lecture_apy_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal7" id="searchVal7" value="${lectureApyVo.lecture_apy_idx}"/> <%-- 프로그램신청 일련번호 --%>
            <table>
                <colgroup>
                    <col style="width:5rem">
                    <col style="width:10rem">
                    <col style="width:13rem">
                    <col>
                    <col style="width:17rem">
                    <col style="width:10rem">
                    <col style="width:8rem">
                    <col style="width:10rem">
                    <col style="width:10rem">
                </colgroup>
                <thead>
                <tr>
                    <th>번호</th>
                    <th>홈페이지</th>
                    <th>교육기관</th>
                    <th>프로그램명</th>
                    <th>교육기간</th>
                    <th>신청방법</th>
                    <th>강좌상태</th>
                    <th>결제금액</th>
                    <th>감면여부</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="13">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:set var="lno" value="0"/>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <c:set var="lno">${lno + 1}</c:set>
                    <tr>
                        <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${item.lectureVo.gubun eq 'J'}">미래교육</c:when>
                                <c:when test="${item.lectureVo.gubun eq 'S'}">평생교육</c:when>
                            </c:choose>
                        </td>
                        <td>${item.grp_name}</td>
                        <td class="ta_l">${item.lectureVo.name}</td>
                        <td>${item.lectureVo.start_dt} ~ ${item.lectureVo.end_dt}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.apy_method eq '1'}">온라인</c:when>
                                <c:when test="${item.apy_method eq '2'}">방문</c:when>
                                <c:when test="${item.apy_method eq '3'}">전화</c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.lectureVo.status_code eq '1'}">접수대기</c:when>
                                <c:when test="${item.lectureVo.status_code eq '2'}">신청가능</c:when>
                                <c:when test="${item.lectureVo.status_code eq '3'}">대기신청</c:when>
                                <c:when test="${item.lectureVo.status_code eq '4'}">신청마감</c:when>
                                <c:when test="${item.lectureVo.status_code eq '5'}">교육전</c:when>
                                <c:when test="${item.lectureVo.status_code eq '6'}">교육중</c:when>
                                <c:when test="${item.lectureVo.status_code eq '7'}">교육종료</c:when>
                            </c:choose>
                        </td>
                        <td><fmt:formatNumber value="${item.pay_sum}" pattern="##,###"/>원</td>
                        <td>
                            <c:if test="${item.discountVo ne null}">${item.discountVo.rate}%</c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </form>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
                <%--<a href="/ssemadmin/cont/lecture/lect_student_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn">목록</a>--%>
                <a href="javascript:history.back();" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
