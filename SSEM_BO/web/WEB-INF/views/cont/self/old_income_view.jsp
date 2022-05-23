<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:56
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
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
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
                <th class="required">동별</th>
                <td>
                    ${tracInoutVo.dong_cd}
                </td>
                <th class="required">수입일자</th>
                <td>
                    ${tracInoutVo.standard_date}
                </td>
            </tr>
            <tr>
                <th class="required">구분</th>
                <td>
                    <c:choose>
                        <c:when test="${tracInoutVo.kind_cd eq '10800001'}">수강료</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10800002'}">사용료</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10800003'}">이자수입</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10800004'}">기타</c:when>
                    </c:choose>
                </td>
                <th class="required">프로그램명</th>
                <td>
                    ${tracInoutVo.prog_nm}
                </td>
            </tr>
            <tr>
                <th class="required">이름</th>
                <td>
                    ${tracInoutVo.inout_nm}
                </td>
                <th>생년월일</th>
                <td>
                    ${tracInoutVo.tracStudentVo.student_resino}
                </td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    ${tracInoutVo.tracStudentVo.tel_no}
                </td>
                <th>핸드폰번호</th>
                <td>
                    ${tracInoutVo.tracStudentVo.mobile_no}
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td colspan="3">
                    ${tracInoutVo.tracStudentVo.email}
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    (${tracInoutVo.post_no}) ${tracInoutVo.addr} ${tracInoutVo.addr_detail}
                </td>
            </tr>
            <tr>
                <th>수강기간(이용기간)</th>
                <td colspan="3">
                    ${tracInoutVo.sdate} ~ ${tracInoutVo.edate}
                </td>
            </tr>
            <tr class="required">
                <th>수입액</th>
                <td colspan="3">
                    <fmt:formatNumber value="${tracInoutVo.amount}" pattern="##,###"/> 원
                </td>
            </tr>
            <tr>
                <th>감면자 정보</th>
                <td>
                    <c:choose>
                        <c:when test="${tracInoutVo.exemption eq '0'}">없음</c:when>
                        <c:when test="${tracInoutVo.exemption eq '1'}">50%</c:when>
                        <c:when test="${tracInoutVo.exemption eq '2'}">100%</c:when>
                    </c:choose>
                </td>
                <th class="required">감면사항</th>
                <td>
                    ${tracInoutVo.exemption_info}
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3">
                    ${tracInoutVo.comments}
                </td>
            </tr>
            <tr>
                <th>정산구분</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${tracInoutVo.adj_yn eq 'Y'}">완료</c:when>
                        <c:when test="${tracInoutVo.adj_yn eq 'N'}">미완료</c:when>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_income_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>

    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>수강내역</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:6%">
                <col>
                <col style="width:20%">
                <col style="width:12%">
                <col style="width:10%">
                <col style="width:4%">
                <%--<col style="width:10%">--%>
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>프로그램명</th>
                <th>수강기간</th>
                <th>납부일</th>
                <th>납부금액</th>
                <th>정산</th>
                <%--<th>금액</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="6">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td>${item.prog_nm}</td>
                    <td>${item.sdate} ~ ${item.edate}</td>
                    <td>${item.standard_date}</td>
                    <td><fmt:formatNumber value="${item.amount}" pattern="##,###"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.adj_yn eq 'Y'}">완료</c:when>
                            <c:when test="${item.adj_yn eq 'N'}">미완료</c:when>
                        </c:choose>
                    </td>
                    <%--<td><fmt:formatNumber value="${item.amount}" pattern="##,###"/></td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </article>
</div>
