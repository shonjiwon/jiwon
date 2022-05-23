<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:06
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

        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.start_dt, "설문기간")){return false;}
            if(!fnIsValidRequired(frm.end_dt, "설문기간")){return false;}

            $("#frm").submit();
        });
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" action="/ssemadmin/cont/site/survey_inscr.do" method="post" enctype="multipart/form-data">
    <article class="contUnit tbl_area leftType">
        <table>
            <colgroup>
                <col style="width:15%;">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>노출상태</th>
                <td>
                    <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                    <label for="use_y">노출</label>
                    <input type="radio" name="use_yn" id="use_n" value="N">
                    <label for="use_n">미노출</label>
                </td>
            </tr>
            <tr>
                <th class="required">제목</th>
                <td><input type="text" id="title" name="title" class="wid100per"></td>
            </tr>
            <tr>
                <th>설문기간</th>
                <td>
                    <input type="text" id="start_dt" name="start_dt" class="wid250">
                    <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="end_dt" name="end_dt" class="wid250">
                    <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
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
        <table id="tbl_0">
            <colgroup>
                <col style="width:15%;">
                <col>
                <col style="width:15%;">
            </colgroup>
            <tbody>
            <tr>
                <th rowspan="4"><input type="hidden" name="questList[0].no" id="questList[0].no" value="1" />1</th>
                <td colspan="2">
                    유형&nbsp;&nbsp;
                    <select name="questList[0].type" class="select_type" id="select_type_0">
                        <option value="S">단일선택형</option>
                        <option value="M">복수선택형</option>
                        <option value="L">주관식형</option>
                    </select>
                </td>
                <%--<td rowspan="3" class="ta_c">
                    <a href="#none" class="noBorder co_black"> <span class="material-icons co_red">delete_forever</span> 문항제거</a>
                </td>--%>
            </tr>
            <tr>
                <td>
                    질문&nbsp;&nbsp;
                    <input type="text" name="questList[0].title" id="questList[0].title" class="wid650">
                </td>
            </tr>
            <tr id="item_list_0">
                <td id="item_0">
                    <div>
                        <input type="hidden" name="questList[0].itemList[0].no" id="questList[0].itemList[0].no" value="1" />1.
                        <input type="text" name="questList[0].itemList[0].cont" id="questList[0].itemList[0].cont" class="wid650" placeholder="항목">
                    </div>
                    <div class="mgt10">
                        <input type="hidden" name="questList[0].itemList[1].no" id="questList[0].itemList[1].no" value="2" />2.
                        <input type="text" name="questList[0].itemList[1].cont" id="questList[0].itemList[1].cont" class="wid650" placeholder="항목">
                    </div>
                    <div class="mgt10" id="tr_0_2">
                        <input type="hidden" name="questList[0].itemList[2].no" id="questList[0].itemList[2].no" value="3" />3.
                        <input type="text" name="questList[0].itemList[2].cont" id="questList[0].itemList[2].cont" placeholder="항목" class="wid650">
                        <span id="txt_del_0_2" class="mgl20">
                            <a href="#none" class="del_item" id="del_item_0_2">삭제</a>
                        </span>
                    </div>
                </td>
            </tr>
            <tr id="item_add_0">
                <td colspan="2" class="ta_c">
                    <div class="mgt10">
                        <a href="#none" class="co_blue noBorder add_item" id="add_item_0_2">
                            <span class="material-icons">control_point</span> 항목 추가
                        </a>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        </div>
        <table>
            <tbody>
                <tr>
                    <td class="ta_c">
                        <a href="#none" class="co_blue noBorder add_quest" id="add_quest_0">
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
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
    </form>
</div>
