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
        $('#btn_insert').click(function() {
            var frm = document.frm;

            if(!fnIsValidRequired(frm.group_idx, "동별")){return false;}
            if(!fnIsValidRequired(frm.div_cd, "구분")){return false;}
            if(!fnIsValidRequired(frm.amount, "기금잔액")){return false;}

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
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/self/new_fund_inscr.do" method="post" enctype="multipart/form-data">
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
                        ${sdate}
                        <input type="hidden" class="wid150" id="standard_yymm" name="standard_yymm" value="${sdate}">
                    </td>
                </tr>
                <tr>
                    <th class="required">동별</th>
                    <td>
                        <select id="group_idx" name="group_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                            <option value="">선택하세요</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.group_idx}" <c:if test="${adminLoginVo.group_idx eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th class="required">구분</th>
                    <td>
                        <select class="wid150" id="div_cd" name="div_cd">
                            <option value="">선택하세요</option>
                            <option value="1">일반</option>
                            <option value="2">헬스장</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">기금잔액</th>
                    <td colspan="3">
                        <input type="text" id="amount" name="amount" class="wid150" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 원
                    </td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" id="note" name="note">
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
                <a href="/ssemadmin/cont/self/new_fund_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
