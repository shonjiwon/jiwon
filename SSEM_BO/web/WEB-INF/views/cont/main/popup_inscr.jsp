<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:40
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
        $('#start_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": true,
            "timePicker24Hour": true,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD HH:mm",
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

        /* Date Picker Settings */
        $('#end_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": true,
            "timePicker24Hour": true,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD HH:mm",
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

            if(!fnIsValidRequired(frm.kind, "노출위치")){return false;}
            if(!fnIsValidRequired(frm.name, "팝업명")){return false;}
            if(!fnIsValidRequired(frm.start_dt, "노출기간 시작일")){return false;}
            if(!fnIsValidRequired(frm.end_dt, "노출기간 종료일")){return false;}
            if(!fnIsValidRequired(frm.attfile, "이미지")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}

            if(frm.start_dt.value > frm.end_dt.value) {
                modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
                return false;
            }

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
        <div class="tblMsg">
            <span class="co_red">*</span> 필수입력
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/main/popup_inscr.do" method="post" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width:15rem">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">노출위치</th>
                    <td>
                        <select id="gubun" name="kind" class="kind">
                            <option value="">선택</option>
                            <option value="A">공통</option>
                            <option value="J">미래교육</option>
                            <option value="S">평생교육</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">팝업명</th>
                    <td>
                        <input type="text" class="wid100per" name="name" id="name">
                    </td>
                </tr>
                <tr>
                    <th class="required">노출상태</th>
                    <td>
                        <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N">
                        <label for="use_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>노출순서</th>
                    <td>
                        <input type="text" class="wid100" name="ord" id="ord" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    </td>
                </tr>
                <tr>
                    <th class="required">노출기간</th>
                    <td>
                        <input type="text" id="start_dt" name="start_dt" class="wid150" value="${searchEDate}">
                        <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="end_dt" name="end_dt" class="wid150" value="${searchEDate} 23:59">
                        <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지</th>
                    <td>
                        <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                        <span>(파일형식 : jpg, jpeg, png, gif / 사이즈 : <span class="co_red">400*500</span>)</span>
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지대체텍스트 </th>
                    <td>
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt">
                    </td>
                </tr>
                <tr>
                    <th>링크URL</th>
                    <td>
                        <input type="text" class="wid500" name="link" id="link">
                        <select id="link_tgt" name="link_tgt" class="wid150">
                            <option value="C">현재창</option>
                            <option value="N">새창</option>
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/main/popup_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
