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
        /* Date Picker Settings */
        $('#resi_no').daterangepicker({
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

        $('#btn_insert').click(function() {
            var frm = document.frm;

            if(!fnIsValidRequired(frm.group_idx, "동별")){return false;}
            if(!fnIsValidRequired(frm.div_cd, "구분")){return false;}
            if(!fnIsValidRequired(frm.nm, "이름")){return false;}
            if(!fnIsValidRequired(frm.work_cnt, "근무일수")){return false;}
            if(!fnIsValidRequired(frm.amount, "금액")){return false;}

            $("#frm").submit();
        });

        $('#div_cd').change(function() {
            let select_val = $(this).val();
            if(select_val === '1') {
                $('#div_cd_cost').val("10000");
            } else if(select_val === '2') {
                $('#div_cd_cost').val("5000");
            } else if(select_val === '3') {
                $('#div_cd_cost').val("0");
            }

            var amount = $('#work_cnt').val() * $('#div_cd_cost').val();
            $('#amount').val(amount);
        });

        $("#work_cnt").on("change keyup paste", function() {
            var amount = $(this).val() * $('#div_cd_cost').val();
            $('#amount').val(amount);
        });

        $("#div_cd_cost").on("change keyup paste", function() {
            var amount = $(this).val() * $('#work_cnt').val();
            $('#amount').val(amount);
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
        <form name="frm" id="frm" action="/ssemadmin/cont/self/new_volunteer_pay_inscr.do" method="post" enctype="multipart/form-data">
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
                        <option value="1">회계지원</option>
                        <option value="2">야간개방</option>
                        <option value="3">주말개방</option>
                    </select>
                    <input type="text" class="wid150" id="div_cd_cost" name="div_cd_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 원
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    <input type="text" id="resi_no" name="resi_no" class="wid100">
                    <a href="javascript:showCalendar('resi_no');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
                <th class="required">이름</th>
                <td>
                    <input type="text" class="wid150" id="nm" name="nm">
                </td>
            </tr>
            <tr>
                <th class="required">근무일수</th>
                <td>
                    <input type="text" class="wid150" oninput="this.value = this.value.replace(/[^0-9]/g, '');" id="work_cnt" name="work_cnt"> 일
                </td>
                <th class="required">금액</th>
                <td>
                    <input type="text" class="wid150" oninput="this.value = this.value.replace(/[^0-9]/g, '');" id="amount" name="amount"> 원
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
                <a href="/ssemadmin/cont/self/new_volunteer_pay_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
