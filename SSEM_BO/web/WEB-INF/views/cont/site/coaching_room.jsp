<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 6:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $("#btn_update").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.url, "입장 URL")){return false;}

            $("#frm").submit();
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
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/site/coaching_room.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="coach_room_idx" value="${coachRoomVo.coach_room_idx}" />
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th class="required">입장 URL</th>
                <td colspan="3"><input type="text" class="wid750" name="url" id="url" value="${coachRoomVo.url}"> <span class="co_red">http:// 또는 https:// 가 포함된 url을 입력해 주세요.</span></td>
            </tr>
            <tr>
                <th class="required">운영시간</th>
                <td colspan="3">
                    <select id="start_hour" name="start_hour">
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <option value="${hour}" <c:if test="${coachRoomVo.start_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                        </c:forEach>
                    </select>시
                    <select id="start_min" name="start_min">
                        <c:forEach items="${minList}" var="min" varStatus="status">
                            <option value="${min}" <c:if test="${coachRoomVo.start_min eq min}">selected="selected"</c:if>>${min}</option>
                        </c:forEach>
                    </select>분
                    ~
                    <select id="end_hour" name="end_hour">
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <option value="${hour}" <c:if test="${coachRoomVo.end_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                        </c:forEach>
                    </select>시
                    <select id="end_min" name="end_min">
                        <c:forEach items="${minList}" var="min" varStatus="status">
                            <option value="${min}" <c:if test="${coachRoomVo.end_min eq min}">selected="selected"</c:if>>${min}</option>
                        </c:forEach>
                    </select>분
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${coachRoomVo.reg_id}</td>
                <th>작성일</th>
                <td>${coachRoomVo.reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${coachRoomVo.up_id}</td>
                <th>최종수정일</th>
                <td>${coachRoomVo.up_dt}</td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
