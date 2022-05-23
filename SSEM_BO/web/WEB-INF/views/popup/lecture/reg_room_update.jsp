<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-29
  Time: 오전 6:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function(){

        /* Date Picker Settings */
        $('#start_dt').daterangepicker({
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

        $('#end_dt').daterangepicker({
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

        //교육요일 선택 내용 확인
        let dt_week_select = '${regStudyPlaceVo.dt_week}';
        $('input[name=dt_week_select]').change(function() {
            let searchTxt = $(this).val();
            if(dt_week_select.indexOf(searchTxt) === -1) {
                dt_week_select = dt_week_select + " " + searchTxt;
            } else {
                dt_week_select = dt_week_select.replace(searchTxt, '');
            }
        });

        $("#btn_add_update").click(function(){

            var frm = document.frm_add;

            if(!fnIsValidRequired(frm.name, "예약명")){return false;}

            dt_week_select = dt_week_select.trim();
            if(dt_week_select === '') {
                modalMsg("[예약요일]을(를) 선택해 주세요.", 'notice', goFocus('dt_week_select'));
                return false;
            } else {
                frm.dt_week.value = dt_week_select.replaceAll(' ', ',');
            }

            var start_time =  frm.start_hour.value + ":" + frm.start_min.value;
            var end_time =  frm.end_hour.value + ":" + frm.end_min.value;

            frm.start_time.value = start_time;
            frm.end_time.value = end_time;

            $("#frm_add").submit();
        });
    });

    function goFocus(name) {
        //var selector = '#' + id;
        //$(selector).focus();
        document.getElementsByName(name)[0].focus();
    }
</script>
<section class="wrap pop">
    <div class="container">
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>교육시설운영현황 등록</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <form name="frm_add" id="frm_add" method="post" action="/ssemadmin/popup/lecture/reg_room_update.do" enctype="multipart/form-data">
                <input type="hidden" name="group_idx" value="${regStudyPlaceVo.group_idx}"/>
                <input type="hidden" name="study_place_idx" value="${regStudyPlaceVo.study_place_idx}"/>
                <input type="hidden" name="reg_study_place_idx" value="${regStudyPlaceVo.reg_study_place_idx}"/>
                <input type="hidden" name="start_time" id="start_time" />
                <input type="hidden" name="end_time" id="end_time" />
                <input type="hidden" name="dt_week" id="dt_week"/>
                <table>
                    <colgroup>
                        <col style="width:15%">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>소속</th>
                        <td class="ta_l">
                            ${regStudyPlaceVo.p_name}
                        </td>
                    </tr>
                    <tr>
                        <th>교육기관</th>
                        <td class="ta_l">
                            ${regStudyPlaceVo.grp_name}
                        </td>
                    </tr>
                    <tr>
                        <th>교육시설명</th>
                        <td class="ta_l">
                            ${regStudyPlaceVo.study_place_name}
                        </td>
                    </tr>
                    <tr>
                        <th class="required">예약일</th>
                        <td class="ta_l">
                            <input type="text" id="start_dt" name="start_dt" class="wid150" value="${regStudyPlaceVo.start_dt}">
                            <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                            ~
                            <input type="text" id="end_dt" name="end_dt" class="wid150" value="${regStudyPlaceVo.end_dt}">
                            <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        </td>
                    </tr>
                    <tr>
                        <th class="required">예약명</th>
                        <td class="ta_l">
                            <input type="text" class="wid350" name="name" id="name" placeholder="예약명" value="${regStudyPlaceVo.name}"> <span class="co_red" id="txt_length">0</span>/50
                        </td>
                    </tr>
                    <tr>
                        <th class="required">예약요일</th>
                        <td class="ta_l">
                            <input type="checkbox" name="dt_week_select" id="dt_week_1" value="1" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '1')}">checked="checked"</c:if>><label for="dt_week_1">월</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_2" value="2" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '2')}">checked="checked"</c:if>><label for="dt_week_2">화</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_3" value="3" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '3')}">checked="checked"</c:if>><label for="dt_week_3">수</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_4" value="4" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '4')}">checked="checked"</c:if>><label for="dt_week_4">목</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_5" value="5" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '5')}">checked="checked"</c:if>><label for="dt_week_5">금</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_6" value="6" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '6')}">checked="checked"</c:if>><label for="dt_week_6">토</label>
                            <input type="checkbox" name="dt_week_select" id="dt_week_7" value="7" <c:if test="${fn:contains(regStudyPlaceVo.dt_week, '7')}">checked="checked"</c:if>><label for="dt_week_7">일</label>
                        </td>
                    </tr>
                    <tr>
                        <th class="required">예약시간</th>
                        <td class="ta_l">
                            <select id="start_hour" name="start_hour">
                                <c:forEach items="${hourList}" var="hour" varStatus="status">
                                    <option value="${hour}" <c:if test="${regStudyPlaceVo.start_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                                </c:forEach>
                            </select>시
                            <select id="start_min" name="start_min">
                                <c:forEach items="${minList}" var="min" varStatus="status">
                                    <option value="${min}" <c:if test="${regStudyPlaceVo.start_min eq min}">selected="selected"</c:if>>${min}</option>
                                </c:forEach>
                            </select>분
                            ~
                            <select id="end_hour" name="end_hour">
                                <c:forEach items="${hourList}" var="hour" varStatus="status">
                                    <option value="${hour}" <c:if test="${regStudyPlaceVo.end_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                                </c:forEach>
                            </select>시
                            <select id="end_min" name="end_min">
                                <c:forEach items="${minList}" var="min" varStatus="status">
                                    <option value="${min}" <c:if test="${regStudyPlaceVo.end_min eq min}">selected="selected"</c:if>>${min}</option>
                                </c:forEach>
                            </select>분
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_add_update">수정</a>
                    <a href="#none" class="btn grey" onclick="window.close();">목록</a>
                </div>
            </div>
        </article>
    </div>
</section>
