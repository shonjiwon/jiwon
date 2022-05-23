<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
                <th class="required">지출일자</th>
                <td>
                    ${tracInoutVo.standard_date}
                </td>
            </tr>
            <tr>
                <th class="required">구분</th>
                <td>
                    <c:choose>
                        <c:when test="${tracInoutVo.kind_cd eq '10900001'}">강사료</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10900002'}">장비구입/유지비</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10900003'}">시설비/보수비</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10900004'}">환불</c:when>
                        <c:when test="${tracInoutVo.kind_cd eq '10900005'}">기타</c:when>
                    </c:choose>
                </td>
                <th class="required">지출액</th>
                <td>
                    <fmt:formatNumber value="${tracInoutVo.amount}" pattern="##,###"/> 원
                </td>
            </tr>
            <tr>
                <th class="required">내역</th>
                <td colspan="3">
                    ${tracInoutVo.break_down}
                </td>
            </tr>
            <tr>
                <th class="required">이름</th>
                <td>
                    ${tracInoutVo.inout_nm}
                </td>
                <th>환불프로그램</th>
                <td>
                    ${tracInoutVo.prog_nm}
                </td>
            </tr>
            <tr>
                <th class="required">주소</th>
                <td colspan="3">
                    (${tracInoutVo.post_no}) ${tracInoutVo.addr} ${tracInoutVo.addr_detail}
                </td>
            </tr>
            <tr>
                <th class="required">지출방법</th>
                <td>
                    ${tracInoutVo.method_cd}
                </td>
                <th>은행명</th>
                <td>
                    <c:choose>
                        <c:when test="${tracInoutVo.bank_cd eq '10920001'}">농협</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920002'}">수협</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920003'}">신한은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920004'}">외환은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920005'}">우리은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920006'}">우체국</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920008'}">하나은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920009'}">제일은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920010'}">한국시티은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920011'}">부산은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920012'}">국민은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920014'}">기업은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920016'}">새마을금고</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920017'}">경남은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920018'}">광주은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920019'}">대구은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920020'}">상호저축은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920021'}">신협</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920022'}">전북은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920023'}">제주은행</c:when>
                        <c:when test="${tracInoutVo.bank_cd eq '10920024'}">한국산업은행</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>계좌번호</th>
                <td colspan="3">
                    ${tracInoutVo.account_no}
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">

            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_expend_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
