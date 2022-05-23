<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-20
  Time: 오전 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function () {
        /* Date Picker Settings */
        $('#stand_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": false,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD",
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": ["일","월","화","수","목","금","토"],
                "monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
                "firstDay": 0
            }
        }, function(start, end, label) {
            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });

        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.name, "동아리명")){return false;}
            if(!fnIsValidRequired(frm.code_idx, "분야")){return false;}
            if(!fnIsValidRequired(frm.intro, "동아리소개")){return false;}
            if(!fnIsValidRequired(frm.action, "주요활동")){return false;}

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
        <form name="frm" id="frm" action="/ssemadmin/cont/club/club_status_inscr.do" method="post" enctype="multipart/form-data">
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>소속</th>
                <td>${adminLoginVo.p_name}</td>
                <th>교육기관</th>
                <td>${adminLoginVo.grp_name}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td colspan="3">${adminLoginVo.admin_id}</td>
            </tr>
            <tr>
                <th class="required">동아리명</th>
                <td colspan="3">
                    <input type="text" class="wid750" name="name" id="name">
                </td>
            </tr>
            <tr>
                <th class="required">분야</th>
                <td colspan="3">
                    <select id="code_idx" name="code_idx">
                        <option value="">선택</option>
                        <c:forEach items="${codeList}" var="item" varStatus="status">
                            <option value="${item.code_idx}">${item.cd_val}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>창립일</th>
                <td colspan="3">
                    <input type="text" id="stand_dt" name="stand_dt" class="wid150">
                    <a href="javascript:showCalendar('stand_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>소속기관</th>
                <td colspan="3">
                    <input type="text" class="wid150" name="org_name" id="org_name">
                </td>
            </tr>
            <tr>
                <th>회원수</th>
                <td colspan="3">
                    <input type="text" class="wid150" name="mem_cnt" id="mem_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 명
                </td>
            </tr>
            <tr>
                <th>모임주기 및 요일</th>
                <td colspan="3">
                    <input type="text" class="wid150" name="meet_dt" id="meet_dt"> ex)주 1회, 겨주모임
                </td>
            </tr>
            <tr>
                <th class="required">동아리소개</th>
                <td colspan="3">
                    <textarea rows="10" class="wid100per" name="intro" id="intro"></textarea>
                </td>
            </tr>
            <tr>
                <th class="required">주요활동</th>
                <td colspan="3">
                    <textarea rows="10" class="wid100per" name="action" id="action"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/club/club_status_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
