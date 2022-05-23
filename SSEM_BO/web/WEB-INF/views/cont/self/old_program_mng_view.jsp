<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오전 11:56
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
                    <%--<span class="co_red">*</span> 필수입력--%>
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
                    ${tracProgramVo.dong_cd}
                </td>
                <th class="required">분야</th>
                <td>
                    <c:choose>
                        <c:when test="${tracProgramVo.div_cd eq '10100001'}">어학</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100002'}">전통</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100003'}">공예</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100004'}">댄스</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100005'}">체조/체육</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100006'}">미술/음악</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100007'}">어린이/청소년</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100008'}">기타</c:when>
                        <c:when test="${tracProgramVo.div_cd eq '10100009'}">주민자치교육</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th class="required">프로그램명</th>
                <td colspan="3">
                    ${tracProgramVo.prog_nm}
                </td>
            </tr>
            <tr>
                <th class="required">수강기간</th>
                <td colspan="3">
                    ${tracProgramVo.course_sdate} ~ ${tracProgramVo.course_edate}
                </td>
            </tr>
            <tr>
                <th class="required">운영일시</th>
                <td colspan="3">
                    ${tracProgramVo.operate_date}
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3">
                    ${tracProgramVo.note}
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_program_mng.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
