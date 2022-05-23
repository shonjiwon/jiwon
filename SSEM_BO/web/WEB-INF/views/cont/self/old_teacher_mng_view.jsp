<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:06
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
                    ${tracLecturerVo.dong_cd}
                </td>
                <th class="required">분야</th>
                <td>
                    <c:choose>
                        <c:when test="${tracLecturerVo.div_cd eq '10100001'}">어학</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100002'}">전통</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100003'}">공예</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100004'}">댄스</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100005'}">체조/체육</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100006'}">미술/음악</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100007'}">어린이/청소년</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100008'}">기타</c:when>
                        <c:when test="${tracLecturerVo.div_cd eq '10100009'}">주민자치교육</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th class="required">구분</th>
                <td>
                    <c:choose>
                        <c:when test="${tracLecturerVo.field_cd eq '10200001'}">일반</c:when>
                        <c:otherwise>자원봉사자</c:otherwise>
                    </c:choose>
                </td>
                <th class="required">프로그램명</th>
                <td>
                    ${tracLecturerVo.prog_nm}
                </td>
            </tr>
            <tr>
                <th class="required">강사명</th>
                <td>
                    ${tracLecturerVo.lecturer_nm}
                </td>
                <th class="required">성별</th>
                <td>
                    <c:choose>
                        <c:when test="${tracLecturerVo.sex eq 'M'}">남</c:when>
                        <c:otherwise>여</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th class="required">생년월일</th>
                <td colspan="3">
                    ${tracLecturerVo.birthday}
                </td>
            </tr>
            <tr>
                <th class="required">협약기간</th>
                <td colspan="3">
                    ${tracLecturerVo.agree_sdate} ~ ${tracLecturerVo.agree_edate}
                </td>
            </tr>
            <tr>
                <th class="required">학력및경력</th>
                <td colspan="3">
                    ${tracLecturerVo.career}
                </td>
            </tr>
            <tr>
                <th class="required">취득자격</th>
                <td colspan="3">
                    ${tracLecturerVo.right}
                </td>
            </tr>
            <tr>
                <th class="required">주소</th>
                <td colspan="3">
                    (${tracLecturerVo.post_no}) ${tracLecturerVo.addr} ${tracLecturerVo.addr_detail}
                </td>
            </tr>
            <tr>
                <th>휴대폰번호</th>
                <td>
                    ${tracLecturerVo.mobile_no}
                </td>
                <th>전화번호</th>
                <td>
                    ${tracLecturerVo.tel_no}
                </td>
            </tr>
            <tr>
                <th>강사료</th>
                <td colspan="3">
                    <fmt:formatNumber value="${tracLecturerVo.lecturer_cost}" pattern="##,###"/>원
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3">
                    ${tracLecturerVo.note}
                </td>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_teacher_mng.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
