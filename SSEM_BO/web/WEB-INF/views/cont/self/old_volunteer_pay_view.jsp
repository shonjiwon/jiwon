<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:44
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
                <th class="required">기준년도</th>
                <td colspan="3">
                    ${fn:substring(tracServiceCostVo.standard_yymm, 0, 4)}년 ${fn:substring(tracServiceCostVo.standard_yymm, 4, 6)}월
                </td>
            </tr>
            <tr>
                <th class="required">동별</th>
                <td>
                    ${tracServiceCostVo.dong_cd}
                </td>
                <th class="required">구분</th>
                <td>
                    <c:choose>
                        <c:when test="${tracServiceCostVo.div_cd eq '10500001'}">회계담당</c:when>
                        <c:when test="${tracServiceCostVo.div_cd eq '10500002'}">야간개방등</c:when>
                        <c:when test="${tracServiceCostVo.div_cd eq '10500003'}">주말개방자 등</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    ${tracServiceCostVo.resi_no}
                </td>
                <th class="required">이름</th>
                <td>
                    ${tracServiceCostVo.nm}
                </td>
            </tr>
            <tr>
                <th class="required">근무일수</th>
                <td>
                    ${tracServiceCostVo.work_cnt} 일
                </td>
                <th class="required">금액</th>
                <td>
                    <fmt:formatNumber value="${tracServiceCostVo.amount}" pattern="##,###"/> 원
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3">
                    ${tracServiceCostVo.note}
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_volunteer_pay_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
