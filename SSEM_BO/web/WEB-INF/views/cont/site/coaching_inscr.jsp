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
        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.subject, "과목")){return false;}
            if(!fnIsValidRequired(frm.title, "제목")){return false;}
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
        <form name="frm" id="frm" action="/ssemadmin/cont/site/coaching_inscr.do" method="post" enctype="multipart/form-data">
        <table>
            <colgroup>
                <col style="width:15%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th class="required">과목</th>
                <td><input type="text" class="wid100" name="subject" id="subject" maxlength="5">&nbsp;<span class="co_red">5글자 이하 입력</span></td>
            </tr>
            <tr>
                <th class="required">제목</th>
                <td><input type="text" class="wid750" name="title" id="title">&nbsp;<span class="co_red" id="txt_length">0</span>/50</td>
            </tr>
            <tr>
                <th class="required">운영 요일</th>
                <td>
                    <input type="radio" name="week_type" id="week_type_1" value="1" checked>
                    <label for="week_type_1">월</label>
                    <input type="radio" name="week_type" id="week_type_2" value="2">
                    <label for="week_type_2">화</label>
                    <input type="radio" name="week_type" id="week_type_3" value="3">
                    <label for="week_type_3">수</label>
                    <input type="radio" name="week_type" id="week_type_4" value="4">
                    <label for="week_type_4">목</label>
                    <input type="radio" name="week_type" id="week_type_5" value="5">
                    <label for="week_type_5">금</label>
                    <input type="radio" name="week_type" id="week_type_6" value="6">
                    <label for="week_type_6">토</label>
                    <input type="radio" name="week_type" id="week_type_7" value="7">
                    <label for="week_type_7">일</label>
                </td>
            </tr>
            <tr>
                <th class="required">운영시간</th>
                <td>
                    <select id="start_hour" name="start_hour">
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <option value="${hour}">${hour}</option>
                        </c:forEach>
                    </select>시
                    <select id="start_min" name="start_min">
                        <c:forEach items="${minList}" var="min" varStatus="status">
                            <option value="${min}">${min}</option>
                        </c:forEach>
                    </select>분
                    ~
                    <select id="end_hour" name="end_hour">
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <option value="${hour}">${hour}</option>
                        </c:forEach>
                    </select>시
                    <select id="end_min" name="end_min">
                        <c:forEach items="${minList}" var="min" varStatus="status">
                            <option value="${min}">${min}</option>
                        </c:forEach>
                    </select>분
                </td>
            </tr>
            <tr>
                <th class="required">입장 URL</th>
                <td><input type="text" class="wid750" name="url" id="url"> <span class="co_red">http:// 또는 https:// 가 포함된 url을 입력해 주세요.</span></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${adminLoginVo.admin_id}</td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/site/coaching_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
