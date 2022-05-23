<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
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

        $(document).on("click",".del_item",function(){
            var id = $(this).prop('id');
            var tokens = id.split('_');
            var quest_no = tokens[2];
            var item_no = tokens[3];
            var selector = 	'#tr_' + quest_no + '_' + item_no;

            $(selector).remove();

            var select_id = '#add_item_' + quest_no + '_' + item_no;
            var create_id = 'add_item_' + quest_no + '_' + (item_no - 1);

            $(select_id).attr('id', create_id);

            var select_td = '#txt_del_' + quest_no + '_' + (item_no - 1);
            var html = '<a href="#none" class="button del_item" id="del_item_' + quest_no + '_' + (item_no - 1) + '"><span>삭제</span></a>';
            $(select_td).append(html);
        });

        $(document).on("click",".add_item",function(){
            var id = $(this).prop('id');
            var tokens = id.split('_');
            var quest_no = tokens[2];
            var item_no = tokens[3];
            var item = Number(item_no) + 1;

            if (item_no == 9) { alert('더이상 추가하실 수 없습니다.'); return false;}

            var html = '<div class="mgt10" id="tr_' + quest_no + '_' + item + '">';
            html += '	<input type="hidden" name="questList[' + quest_no + '].itemList[' + item + '].no" id="questList[' + quest_no + '].itemList[' + item + '].no" value="' + (item + 1) + '" />' + (item + 1) + '. ';
            html += '	<input type="text" style="width:60%;" name="questList[' + quest_no + '].itemList[' + item + '].cont" id="questList[' + quest_no + '].itemList[' + item + '].cont" placeholder="항목" >';
            html += '	<span id="txt_del_' + quest_no + '_' + item + '" class="mgl20"><a href="#none" class="del_item" id="del_item_' + quest_no + '_' + item + '">삭제</a></span>';
            html += '</div>';

            var selector = 	'#item_' + quest_no;
            $(selector).append(html);

            var selector_prev = '#del_item_' + quest_no + '_' + item_no;
            $(selector_prev).remove();

            var selector_add = '#add_item_' + quest_no + '_' + item_no;
            $(selector_add).attr('id', 'add_item_' + quest_no + '_' + item);
        });

        $(document).on("click",".add_quest",function(){
            var id = $(this).prop('id');
            var tokens = id.split('_');
            var quest_no = tokens[2];
            var quest = Number(quest_no) + 1;

            var html = '<table id="tbl_'+ quest +'">';
            html += '<colgroup>';
            html += ' <col style="width:15%;">';
            html += ' <col>';
            html += ' <col style="width:15%;">';
            html += '</colgroup>';
            html += '<tbody>';
            html += '<tr>';
            html += ' <th rowspan="4"><input type="hidden" name="questList['+ quest +'].no" id="questList['+ quest +'].no" value="'+ (quest+1) +'" />'+ (quest+1) +'</th>';
            html += ' <td>';
            html += ' 유형&nbsp;&nbsp;';
            html += ' <select name="questList['+ quest +'].type" class="select_type" id="select_type_'+ quest +'">';
            html += '  <option value="S">단일선택형</option>';
            html += '  <option value="M">복수선택형</option>';
            html += '  <option value="L">주관식형</option>';
            html += ' </select>';
            html += ' </td>';
            html += ' <td rowspan="3" class="ta_c" id="quest_del_' + quest + '">';
            html += '  <a href="#none" class="noBorder co_black del_quest" id="del_quest_' + quest + '"> <span class="material-icons co_red">delete_forever</span> 문항제거</a>';
            html += ' </td>';
            html += '</tr>';
            html += '<tr>';
            html += ' <td>';
            html += ' 질문&nbsp;&nbsp;';
            html += ' <input type="text" name="questList['+ quest +'].title" id="questList['+ quest +'].title" class="wid650">';
            html += ' </td>';
            html += '</tr>';
            html += '<tr id="item_list_'+ quest +'">';
            html += ' <td id="item_'+ quest +'">';
            html += ' <div>';
            html += ' <input type="hidden" name="questList['+ quest +'].itemList[0].no" id="questList['+ quest +'].itemList[0].no" value="1" />1.';
            html += ' <input type="text" name="questList['+ quest +'].itemList[0].cont" id="questList['+ quest +'].itemList[0].cont" class="wid650" placeholder="항목">';
            html += ' </div>';
            html += ' <div class="mgt10">';
            html += ' <input type="hidden" name="questList['+ quest +'].itemList[1].no" id="questList['+ quest +'].itemList[1].no" value="2" />2.';
            html += ' <input type="text" name="questList['+ quest +'].itemList[1].cont" id="questList['+ quest +'].itemList[1].cont" class="wid650" placeholder="항목">';
            html += ' </div>';
            html += ' <div class="mgt10" id="tr_'+ quest +'_2">';
            html += ' <input type="hidden" name="questList['+ quest +'].itemList[2].no" id="questList[0].itemList['+ quest +'].no" value="3" />3.';
            html += ' <input type="text" name="questList['+ quest +'].itemList[2].cont" id="questList['+ quest +'].itemList[2].cont" placeholder="항목" class="wid650">';
            html += ' <span id="txt_del_'+ quest +'_2" class="mgl20">';
            html += ' <a href="#none" class="del_item" id="del_item_'+ quest +'_2">삭제</a>';
            html += ' </span>';
            html += ' </div>';
            html += ' </td>';
            html += '<tr id="item_add_'+ quest +'">';
            html += ' <td colspan="2" class="ta_c">';
            html += '  <div class="mgt10">';
            html += '   <a href="#none" class="co_blue noBorder add_item" id="add_item_'+ quest +'_2">';
            html += '   <span class="material-icons">control_point</span> 항목 추가';
            html += '   </a>';
            html += '  </div>';
            html += ' </td>';
            html += '</tr>';
            html += '</tbody>';
            html += '</table>';

            var selector = 	'#survey_frm';
            $(selector).append(html);

            var selector_prev = '#del_quest_' + quest_no;
            $(selector_prev).remove();

            var selector_add = '#add_quest_' + quest_no;
            $(selector_add).attr('id', 'add_quest_' + quest);
        });

        $(document).on("click",".del_quest",function(){
            var id = $(this).prop('id');
            var tokens = id.split('_');
            var quest_no = tokens[2];

            var selector = 	'#tbl_' + quest_no;

            $(selector).remove();

            var select_id = '#add_quest_' + quest_no;
            var create_id = 'add_quest_' + (quest_no - 1);

            $(select_id).attr('id', create_id);

            var select_td = '#quest_del_' + (quest_no -1);
            var html = '  <a href="#none" class="noBorder co_black del_quest" id="del_quest_'+ (quest_no - 1) +'"> <span class="material-icons co_red">delete_forever</span> 문항제거</a>';
            $(select_td).append(html);
        });

        $(document).on("change",".select_type",function(){
            var id = $(this).prop('id');
            var val = $(this).val();
            var tokens = id.split('_');
            var quest = tokens[2];

            if("L" == val) {
                var select = '#item_list_' + quest;
                var select_add = '#item_add_' + quest;
                $(select).remove();
                $(select_add).remove();
            } else {
                var select = '#item_list_' + quest;
                if($(select).prop('id') == null) {
                    var select_tbody = "#tbl_" + quest + " tbody";
                    var html = "";
                    html += '<tr id="item_list_'+ quest +'">';
                    html += ' <td id="item_'+ quest +'">';
                    html += ' <div>';
                    html += ' <input type="hidden" name="questList['+ quest +'].itemList[0].no" id="questList['+ quest +'].itemList[0].no" value="1" />1.';
                    html += ' <input type="text" name="questList['+ quest +'].itemList[0].cont" id="questList['+ quest +'].itemList[0].cont" class="wid650" placeholder="항목">';
                    html += ' </div>';
                    html += ' <div class="mgt10">';
                    html += ' <input type="hidden" name="questList['+ quest +'].itemList[1].no" id="questList['+ quest +'].itemList[1].no" value="2" />2.';
                    html += ' <input type="text" name="questList['+ quest +'].itemList[1].cont" id="questList['+ quest +'].itemList[1].cont" class="wid650" placeholder="항목">';
                    html += ' </div>';
                    html += ' <div class="mgt10" id="tr_'+ quest +'_2">';
                    html += ' <input type="hidden" name="questList['+ quest +'].itemList[2].no" id="questList[0].itemList['+ quest +'].no" value="3" />3.';
                    html += ' <input type="text" name="questList['+ quest +'].itemList[2].cont" id="questList['+ quest +'].itemList[2].cont" placeholder="항목" class="wid650">';
                    html += ' <span id="txt_del_'+ quest +'_2" class="mgl20">';
                    html += ' <a href="#none" class="del_item" id="del_item_'+ quest +'_2">삭제</a>';
                    html += ' </span>';
                    html += ' </div>';
                    html += ' </td>';
                    html += '<tr>';
                    html += '<tr id="item_add_'+ quest +'">';
                    html += ' <td colspan="2" class="ta_c">';
                    html += ' <div class="mgt10">';
                    html += ' <a href="#none" class="co_blue noBorder add_item" id="add_item_'+ quest +'_2">';
                    html += '  <span class="material-icons">control_point</span> 항목 추가';
                    html += ' </a>';
                    html += ' </div>';
                    html += ' </td>';
                    html += '</tr>';
                    $(select_tbody).append(html);
                }
            }
        });

        $("#btn_update").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.start_dt, "설문기간")){return false;}
            if(!fnIsValidRequired(frm.end_dt, "설문기간")){return false;}

            $("#frm").submit();
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });

        // 팝업 처리 /////////////////////////////////////////////////////////////////////////////////////
        var popResult = $(".popResult");
        popResult.click(function() {
            $(".pop_survey_result").addClass('on')
        });

        $('.btnClose').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_pop_close').click(function() {
            $('.popArea').removeClass('on')
        });
        ///////////////////////////////////////////////////////////////////////////////////////////////
    });

    function delete_frm() {
        document.delfrm.submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/site/survey_delete.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="svy_idx" value="${svyMstVo.svy_idx}" />
    </form>
    <form name="frm" id="frm" action="/ssemadmin/cont/site/survey_view.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="svy_idx" value="${svyMstVo.svy_idx}" />
    <article class="contUnit tbl_area leftType">
        <table>
            <colgroup>
                <col style="width:15%;">
                <col style="width:35%;">
                <col style="width:15%;">
                <col style="width:35%;">
            </colgroup>
            <tbody>
            <tr>
                <th>최초등록일</th>
                <td>${svyMstVo.reg_dt}</td>
                <th>최조작성자</th>
                <td>${svyMstVo.reg_id}</td>
            </tr>
            <tr>
                <th>최종수정일</th>
                <td>${svyMstVo.up_dt}</td>
                <th>최종수정자</th>
                <td>${svyMstVo.up_id}</td>
            </tr>
            <tr>
                <th>노출상태</th>
                <td colspan="3">
                    <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${svyMstVo.use_yn == 'Y'}">checked="checked"</c:if>>
                    <label for="use_y">노출</label>
                    <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${svyMstVo.use_yn == 'N'}">checked="checked"</c:if>>
                    <label for="use_n">미노출</label>
                </td>
            </tr>
            <tr>
                <th class="required">제목</th>
                <td colspan="3"><input type="text" id="title" name="title" class="wid100per" value="${svyMstVo.title}"></td>
            </tr>
            <tr>
                <th>설문기간</th>
                <td colspan="3">
                    <input type="text" id="start_dt" name="start_dt" class="wid250" value="${svyMstVo.start_dt}">
                    <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="end_dt" name="end_dt" class="wid250" value="${svyMstVo.end_dt}">
                    <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>상태구분</th>
                <td>${svyMstVo.srv_yn}</td>
                <th>참여자 수</th>
                <td>
                    <c:choose>
                        <c:when test="${svyMstVo.srv_yn eq '예정'}">-</c:when>
                        <c:otherwise>${svyMstVo.reply_cnt} 명 <a href="#none" class="btn sml grey mgl20 popResult">결과보기</a></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>문항</h3>
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                </div>
            </div>
        </div>
        <div id="survey_frm">
            <c:set var="quest_count" value="0" />
            <c:forEach items="${svyMstVo.questList}" var="quest" varStatus="status">
            <c:set var="quest_count">${quest_count + 1}</c:set>
            <table id="tbl_${status.index}">
                <colgroup>
                    <col style="width:15%;">
                    <col>
                    <col style="width:15%;">
                </colgroup>
                <tbody>
                <tr>
                    <th rowspan="4"><input type="hidden" name="questList[${status.index}].no" id="questList[${status.index}].no" value="${quest.no}" />${quest.no}</th>
                    <td colspan="2">
                        유형&nbsp;&nbsp;
                        <select name="questList[${status.index}].type" class="select_type" id="select_type_${status.index}">
                            <option value="S" <c:if test="${quest.type == 'S'}">selected="selected"</c:if>>단일선택형</option>
                            <option value="M" <c:if test="${quest.type == 'M'}">selected="selected"</c:if>>복수선택형</option>
                            <option value="L" <c:if test="${quest.type == 'L'}">selected="selected"</c:if>>주관식형</option>
                        </select>
                    </td>
                <c:choose>
                    <c:when test="${status.last}">
                        <td rowspan="3" class="ta_c" id="quest_del_${status.index}">
                            <a href="#none" class="noBorder co_black del_quest" id="del_quest_${status.index}"><span class="material-icons co_red">delete_forever</span> 문항제거</a>
                        </td>
                    </c:when>
                </c:choose>
                </tr>
                <tr>
                    <td colspan="2">
                        질문&nbsp;&nbsp;
                        <input type="text" name="questList[${status.index}].title" id="questList[${status.index}].title" class="wid650" value="${quest.title}">
                    </td>
                </tr>
                <c:if test="${quest.type ne 'L'}">
                    <tr id="item_list_${status.index}">
                    <td id="item_${status.index}">
                        <c:set var="item_count" value="0" />
                        <c:forEach items="${quest.itemList}" var="item" varStatus="status_item">
                        <c:set var="item_count">${item_count + 1}</c:set>
                        <div class="mgt10" id="tr_${status.index}_${status_item.index}">
                            <input type="hidden" name="questList[${status.index}].itemList[${status_item.index}].no" id="questList[${status.index}].itemList[${status_item.index}].no" value="${item.no}" />${item.no}.
                            <input type="text" name="questList[${status.index}].itemList[${status_item.index}].cont" id="questList[${status.index}].itemList[${status_item.index}].cont" class="wid650" placeholder="항목" value="${item.cont}">
                            <c:choose>
                                <c:when test="${fn:length(quest.itemList) == status_item.count}">
                                    <span id="txt_del_${status.index}_${status_item.index}" class="mgl20">
                                        <a href="#none" class="del_item" id="del_item_${status.index}_${status_item.index}">삭제</a>
                                    </span>
                                </c:when>
                            </c:choose>
                        </div>
                        </c:forEach>
                    </td>
                    </tr>
                </c:if>
                <c:if test="${quest.type ne 'L'}">
                <tr id="item_add_${status.index}">
                    <td colspan="2" class="ta_c">
                        <div class="mgt10">
                            <a href="#none" class="co_blue noBorder add_item" id="add_item_${status.index}_${item_count}">
                                <span class="material-icons">control_point</span> 항목 추가
                            </a>
                        </div>
                    </td>
                </tr>
                </c:if>
                </tbody>
            </table>
            </c:forEach>
        </div>
        <table>
            <tbody>
            <tr>
                <td class="ta_c">
                    <a href="#none" class="co_blue noBorder add_quest" id="add_quest_${quest_count - 1}">
                        <span class="material-icons">control_point</span>문항 추가
                    </a>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/site/survey_list.do" class="btn grey">목록</a>
            </div>
            <div class="right">
                <a href="https://www.songpa.go.kr/ssem/youth/ssem/survey_preview.do?svy_idx=${svyMstVo.svy_idx}" class="btn blue" id="btn_preview" target="_blank">미리보기</a>
                <c:choose>
                    <c:when test="${svyMstVo.srv_yn eq '예정'}">
                        <a href="#none" class="btn red" id="btn_update">저장</a>
                        <a href="#none" class="btn grey" id="btn_delete">삭제</a>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </article>
    </form>
</div>

<!-- popup -->
<section class="popArea pop_survey_result">
    <div class="popBody" style="width: 100rem !important;">
        <div class="tit">
            <h2>${svyMstVo.title}</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <div class="btnArea mgb10">
                    <div class="left">
                        참여자 수: ${svyMstVo.reply_cnt} 명
                    </div>
                    <div class="right">
                        <%--<a href="#none" class="btn sml green">엑셀다운로드</a>--%>
                    </div>
                </div>
                <table>
                    <colgroup>
                        <col style="width:5rem">
                        <col style="width:5rem">
                        <col>
                        <col style="width:10rem">
                        <col style="width:10rem">
                    </colgroup>
                    <tbody>
                    <c:forEach items="${svyMstVo.questList}" var="quest" varStatus="status">
                    <tr>
                        <c:choose>
                            <c:when test="${quest.type ne 'L'}">
                                <th rowspan="${fn:length(quest.itemList) + 2}">${quest.no}</th>
                            </c:when>
                            <c:otherwise>
                                <c:set var="reply_cnt" value="0"/>
                                <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                                    <c:set var="reply_cnt" value="${fn:length(item.replyList)}"/>
                                </c:forEach>
                                <th rowspan="${reply_cnt + 2}">${quest.no}</th>
                            </c:otherwise>
                        </c:choose>
                        <td>유형</td>
                        <td class="ta_l">
                            <c:choose>
                                <c:when test="${quest.type eq 'S'}">단일선택형</c:when>
                                <c:when test="${quest.type eq 'M'}">복수선택형</c:when>
                                <c:when test="${quest.type eq 'L'}">주관식형</c:when>
                            </c:choose>
                        </td>
                        <c:if test="${quest.type ne 'L'}">
                            <th rowspan="2">선택 수(개)</th>
                            <th rowspan="2">선택률(%)</th>
                        </c:if>
                    </tr>
                    <tr>
                        <td>질문</td>
                        <td class="ta_l">${quest.title}</td>
                        <c:if test="${quest.type eq 'L'}">
                            <td style="background: #f5f5f5;">답변 수(개)</td>
                            <td>${quest.itemList[0].tot_reply_cnt}</td>
                        </c:if>
                    </tr>
                    <c:choose>
                        <c:when test="${quest.type ne 'L'}">
                            <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                            <tr>
                                <td></td>
                                <td class="ta_l">${item.no}. ${item.cont}</td>
                                <td><b>${item.tot_reply_cnt}</b></td>
                                <td><b>${item.reply_percent}</b></td>
                            </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                                <c:forEach items="${item.replyList}" var="reply" varStatus="status_reply">
                                    <tr>
                                        <td>답변</td>
                                        <td class="ta_l" colspan="3"><%--${status_reply.count}. --%>${reply.answer}</td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="btnArea ta_c">
                    <a href="#none" class="btn red" id="btn_pop_close">닫기</a>
                </div>
            </article>
        </div>
    </div>
</section>
