<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    .ck-editor__editable {
        min-height: 250px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function() {

        add_file();

        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${adminLoginVo.p_idx}';
        let group_idx = '${adminLoginVo.group_idx}';
        if(p_idx !== '' && group_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        } else if(p_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async: false,
                    success: function (data) {
                        $('#group_idx').children().remove();
                        $.each(data, function (key, v) {
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        }

        $('#p_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            } else {
                $('#group_idx').children().remove();
                $('#group_idx').append(html);
            }
        });

        ClassicEditor
            .create( document.querySelector( '#cont' ), {
                /*plugins: [ CKFinder ],*/
                ckfinder: { uploadUrl: '/ssemadmin/editor/imgUpload.do' },
                /*plugins: [ SimpleUploadAdapter ],
                simpleUpload: { uploadUrl: '/editor/imgUpload.do' },*/
                toolbar: {
                    items: [
                        'heading',
                        '|',
                        'Source',
                        'code',
                        '|',
                        'bold',
                        'italic',
                        'fontColor',
                        'fontSize',
                        'underline',
                        'link',
                        'bulletedList',
                        'numberedList',
                        '|',
                        'alignment:left',
                        'alignment:right',
                        'alignment:center',
                        'alignment:justify',
                        '|',
                        'indent',
                        'outdent',
                        '|',
                        'imageUpload',
                        'mediaEmbed',
                        'blockQuote',
                        'insertTable',
                        'undo',
                        'redo',
                        '|',
                        'htmlEmbed',

                    ]
                },
                language: 'ko',
                image: {
                    toolbar: [
                        'imageTextAlternative',
                        'imageStyle:alignLeft',
                        'imageStyle:full',
                        'imageStyle:side'
                    ],
                    styles: [ 'full','alignLeft','alignRight','side' ]
                },
                table: {
                    contentToolbar: [
                        'tableColumn',
                        'tableRow',
                        'mergeTableCells',
                        'tableCellProperties',
                        'tableProperties'
                    ]
                },
                licenseKey: ''
            } )
            .then( editor => {
                window.editor = editor;
            } )
            .catch( error => {
                console.error( error );
            } );

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

        /* Date Picker Settings */
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

        /* Date Picker Settings */
        $('#reg_start_st').daterangepicker({
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
        $('#reg_end_dt').daterangepicker({
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
        $('#refund_start_dt').daterangepicker({
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

        /* Date Picker Settings */
        $('#refund_end_dt').daterangepicker({
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

        // 50자 체크 //////////////////////////////////////////////////////
        $('#name').keyup(function (event) {
            if($(this).val().length > 50) {
                if(event.keyCode !== 8) {
                    alert("50자까지만 입력이 가능합니다.");
                }
                $('#name').val($('#name').val().substr(0, $('#name').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        $('#name').keydown(function (event) {
            if($(this).val().length > 50) {
                if(event.keyCode !== 8) {
                    alert("50자까지만 입력이 가능합니다.");
                }
                $('#name').val($('#name').val().substr(0, $('#name').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        let name = $('#name').val();
        if(!isEmpty(name) && name !== '') {
            $('#txt_length').text(name.length);
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        $("#dt_txt_check").change(function(){
            if($("#dt_txt_check").is(":checked")){
                $("#dt_txt").attr("disabled", false);
            }else{
                $("#dt_txt").attr("disabled", true);
            }
        });

        $("#reg_method_4").change(function(){
            if($("#reg_method_4").is(":checked")){
                $("#reg_method_url").attr("disabled", false);
            }else{
                $("#reg_method_url").attr("disabled", true);
            }
        });


        //초기화
        if(frm.fee_type.value === 'F') {
            $("#pay_type_hide").hide();
            $("#discount_yn_hide").hide();
            $("#refund_txt_hide").hide();
            $("#refund_dt_hide").hide();
        }

        $("#fee_type_s").change(function(){
            if($("#fee_type_s").is(":checked")){
                $("#fee").attr("disabled", false);
            }

            $("#pay_type_hide").show();
            $("#discount_yn_hide").show();
            $("#refund_txt_hide").show();
            $("#refund_dt_hide").show();
        });
        $("#fee_type_f").change(function(){
            if($("#fee_type_f").is(":checked")){
                $("#fee").attr("disabled", true);
                $("#fee").val("");
            }

            $("#pay_type_hide").hide();
            $("#discount_yn_hide").hide();
            $("#refund_txt_hide").hide();
            $("#refund_dt_hide").hide();
        });

        $("#teacher_y").change(function(){
            if($("#teacher_y").is(":checked")){
                $("#teacher_idx").val("");
                $("#teacher_nm").val("");

                $("#teacher_nm").attr("disabled", false);
            }
        });
        $("#teacher_n").change(function(){
            if($("#teacher_n").is(":checked")){
                $("#teacher_idx").val("");
                $("#teacher_nm").val("");

                $("#teacher_nm").attr("disabled", true);
            }
        });

        //대상 선택 내용 확인
        let tgt_select = '${lectureVo.tgt_code}';
        $('input[name=tgt_select]').change(function() {
            let searchTxt = $(this).val();
            if(tgt_select.indexOf(searchTxt) === -1) {
                tgt_select = tgt_select + " " + searchTxt;
            } else {
                tgt_select = tgt_select.replace(searchTxt, '');
            }
        });

        //교육요일 선택 내용 확인
        let dt_week_select = '${lectureVo.dt_week}';
        $('input[name=dt_week_select]').change(function() {
            let searchTxt = $(this).val();
            if(dt_week_select.indexOf(searchTxt) === -1) {
                dt_week_select = dt_week_select + " " + searchTxt;
            } else {
                dt_week_select = dt_week_select.replace(searchTxt, '');
            }
        });

        //신청방법 선택 내용 확인
        let reg_method_select = '${lectureVo.reg_method}';
        $('input[name=reg_method_select]').change(function() {
            let searchTxt = $(this).val();
            if(reg_method_select.indexOf(searchTxt) === -1) {
                reg_method_select = reg_method_select + " " + searchTxt;
            } else {
                reg_method_select = reg_method_select.replace(searchTxt, '');
                $("#reg_method_url").val("");
            }
        });

        $("#btn_update").click(function(){
            var frm = document.frm;

            if(frm.gubun.value == '') {
                modalMsg("[홈페이지]을(를) 선택해 주세요.", 'notice', goFocus('gubun'));
                return false;
            }
            if(!fnIsValidRequired(frm.name, "프로그램명")){return false;}
            if(frm.part_code_idx.value == '') {
                modalMsg("[교육분야]을(를) 선택해 주세요.", 'notice', goFocus('part_code_idx'));
                return false;
            }

            tgt_select = tgt_select.trim();
            if(tgt_select === '') {
                modalMsg("[대상]을(를) 선택해 주세요.", 'notice', goFocus('tgt_select'));
                return false;
            } else {
                frm.tgt_code.value = tgt_select.replaceAll(' ', ',');
            }

            if(!fnIsValidRequired(frm.start_dt, "교육기간")){return false;}
            if(!fnIsValidRequired(frm.end_dt, "교육기간")){return false;}
            if(!fnIsValidRequired(frm.dt_type, "교육요일")){return false;}

            dt_week_select = dt_week_select.trim();
            if(dt_week_select === '') {
                modalMsg("[교육요일]을(를) 선택해 주세요.", 'notice', goFocus('dt_week_select'));
                return false;
            } else {
                frm.dt_week.value = dt_week_select.replaceAll(' ', ',');
            }

            var start_time =  frm.start_hour.value + ":" + frm.start_min.value;
            var end_time =  frm.end_hour.value + ":" + frm.end_min.value;

            frm.start_time.value = start_time;
            frm.end_time.value = end_time;

            reg_method_select = reg_method_select.trim();
            if(reg_method_select === '') {
                modalMsg("[신청방법]을(를) 선택해 주세요.", 'notice', goFocus('reg_method_select'));
                return false;
            } else {
                frm.reg_method.value = reg_method_select.replaceAll(' ', ',');
            }
            if(!fnIsValidRequired(frm.student_qty, "교육인원")){return false;}
            if(!fnIsValidRequired(frm.online_qty, "모집인원")){return false;}

            if(frm.fee_type.value === '') {
                modalMsg("[수강료]을(를) 선택해 주세요.", 'notice', goFocus('fee_type'));
                return false;
            }

            if(frm.fee_type.value === 'S') {
                if (frm.pay_type.value === '') {
                    modalMsg("[결제방법]을(를) 선택해 주세요.", 'notice', goFocus('pay_type'));
                    return false;
                }

                if (frm.discount_yn.value === '') {
                    modalMsg("[감대여부]을(를) 선택해 주세요.", 'notice', goFocus('discount_yn'));
                    return false;
                }

                if (frm.discount_yn.value === "Y") {
                    if (!fnIsValidRequired(frm.discount_str, "감대대상")) {
                        return false;
                    }
                }
            } else {
                frm.discount_yn.value = "N";
            }

            if(!fnIsValidRequired(frm.study_place_idx, "교육장소")){return false;}

            frm.cont.value = window.editor.getData();

            if(!fnIsValidRequired(frm.cont, "프로그램소개")){return false;}

            $("#frm").submit();
        });

        $("#discount_yn_n").change(function() {
            if ($("#discount_yn_n").is(":checked")) {
                $("#discount_idx").val("");
                $("#discount_str").val("");
            }
        });

        $("#discount_yn_y").change(function(){
            if($("#discount_yn_y").is(":checked")){
                $("#discount_idx").val("");
            }
        });

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssemadmin/file/file_delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: "atch_file_id=" + del_id_arr[0] + "&file_num=" + del_id_arr[1],
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("삭제에 실패하였습니다.");
                        } else {
                            alert("삭제하였습니다.");
                            location.href = "?lecture_idx=${lectureVo.lecture_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });

        function delete_frm() {
            document.delfrm.submit();
        }
    });

    function pop_discount() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;
        var discount_yn = frm.discount_yn.value;

        if(discount_yn === 'N' || discount_yn === '') {
            modalMsg("감면여부를 '감면대상'으로 선택해 주세요.", "notice", "");
        } else {
            var url = "/ssemadmin/popup/discount/discount_list.do?group_idx=" + group_idx;
            window.open(url, 'popup_discount', 'width=1200, height=510, scrollbars=0, toolbar=0, menubar=no');
        }
    }

    function pop_teacher() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;
        var p_idx = frm.p_idx.value;
        var teacher_yn = frm.teacher_yn.value;

        if(teacher_yn === 'N' || teacher_yn === '') {
            modalMsg("강사를 '확정'으로 선택해 주세요.", "notice", "");
        } else {
            var url = "/ssemadmin/popup/teacher/teacher_list.do?group_idx=" + group_idx + "&p_idx=" + p_idx;
            window.open(url, 'popup_teacher', 'width=1200, height=690, scrollbars=0, toolbar=0, menubar=no');
        }
    }

    function pop_room() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;

        var url = "/ssemadmin/popup/room/room_list.do?group_idx=" + group_idx + "";
        window.open(url, 'popup_room', 'width=1200, height=530, scrollbars=0, toolbar=0, menubar=no');
    }

    function goFocus(name) {
        //var selector = '#' + id;
        //$(selector).focus();
        document.getElementsByName(name)[0].focus();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/lecture/lecture_delete.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}" />
    </form>
    <form name="frm" id="frm" action="/ssemadmin/cont/lecture/lecture_view.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}" />
        <input type="hidden" name="start_time" id="start_time" />
        <input type="hidden" name="end_time" id="end_time" />
        <input type="hidden" name="tgt_code" id="tgt_code"/>
        <input type="hidden" name="dt_week" id="dt_week"/>
        <input type="hidden" name="reg_method" id="reg_method"/>
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>교육기관</h3>
                </div>
                <div class="right">
                    <div class="tblMsg ta_r">
                        <span class="co_red">*</span> 필수입력
                    </div>
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15rem">
                    <col>
                    <col style="width:15rem">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">소속</th>
                    <td colspan="3">
                        <select id="p_idx" name="p_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                            <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                                <option value="${item.group_idx}" <c:if test="${item.group_idx eq adminLoginVo.p_idx}">selected="selected"</c:if>>${item.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">교육기관</th>
                    <td colspan="3">
                        <select id="group_idx" name="group_idx" class="wid200" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">홈페이지</th>
                    <td>
                        <input type="radio" name="gubun" id="gubun_j" value="J" <c:if test="${lectureVo.gubun eq 'J'}">checked</c:if>><label for="gubun_j">미래교육</label>
                        <input type="radio" name="gubun" id="gubun_s" value="S" <c:if test="${lectureVo.gubun eq 'S'}">checked</c:if>><label for="gubun_s">평생교육</label>
                    </td>
                    <th class="required">노출여부</th>
                    <td>
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${lectureVo.use_yn eq 'Y'}">checked</c:if>><label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${lectureVo.use_yn eq 'N'}">checked</c:if>><label for="use_n">비노출</label>
                    </td>
                </tr>
                </tbody>
            </table>
        </article>
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>기본정보</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15rem">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">프로그램명</th>
                    <td>
                        <input type="text" class="wid750" name="name" id="name" value="${lectureVo.name}"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일</th>
                    <td>
                        <input type="file" class="wid350" name="thumb_atch_file_id" id="thumb_atch_file_id">
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">330 * 240</span> )
                        <c:forEach items="${lectureVo.thumbFileList}" var="thumb" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${thumb.atch_file_id}&amp;fileNum=${thumb.file_num}">${thumb.file_ori_nm}</a>
                            </span>
                                <a href="#" id="btn_file_del_${thumb.atch_file_id}_${thumb.file_num}" class="btn_del">x</a><br/>
                                <img src="${thumb.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지 대체텍스트</th>
                    <td>
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt" value="${lectureVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">교육분야</th>
                    <td>
                        <c:forEach items="${codeList}" var="code" varStatus="status">
                            <input type="radio" name="part_code_idx" id="part_code_idx_${code.code_idx}" value="${code.code_idx}" <c:if test="${lectureVo.part_code_idx eq code.code_idx}">checked="checked"</c:if>><label for="part_code_idx_${code.code_idx}">${code.cd_val}</label>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">정보화교육여부</th>
                    <td>
                        <input type="radio" name="ict_yn" id="ict_y" value="N" <c:if test="${lectureVo.ict_yn eq 'N'}">checked="checked"</c:if>><label for="ict_y">아니오</label>
                        <input type="radio" name="ict_yn" id="ict_n" value="Y" <c:if test="${lectureVo.ict_yn eq 'Y'}">checked="checked"</c:if>><label for="ict_n">예</label>
                    </td>
                </tr>
                <tr>
                    <th class="required" id="tgt_select">대상</th>
                    <td>
                        <c:forEach items="${tgtList}" var="tgt" varStatus="status">
                            <input type="checkbox" name="tgt_select" id="tgt_select_${tgt.code_idx}" value="${tgt.code_idx}" <c:if test="${fn:contains(lectureVo.tgt_code, tgt.code_idx)}">checked="checked"</c:if>><label for="tgt_select_${tgt.code_idx}">${tgt.cd_val}</label>
                        </c:forEach>
                        <p class="mgt20 mgb10"><b>상세조건</b> <small>(예: 5~7세, 미취학아동, 55세이상 관내거주 등…)</small></p>
                        <input type="text" class="wid100per" name="tgt_detail" id="tgt_detail" value="${lectureVo.tgt_detail}">
                    </td>
                </tr>
                <tr>
                    <th class="required">교육기간</th>
                    <td>
                        <input type="text" id="start_dt" name="start_dt" class="wid100" value="${lectureVo.start_dt}">
                        <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="end_dt" name="end_dt" class="wid100" value="${lectureVo.end_dt}">
                        <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>

                        <input type="checkbox" id="dt_txt_check" class="mgl30" <c:if test="${lectureVo.dt_txt ne null}">checked="checked"</c:if>><label for="dt_txt_check">추가정보입력</label>
                        <input type="text" class="wid450" name="dt_txt" id="dt_txt" <c:if test="${lectureVo.dt_txt eq null}">disabled</c:if> value="${lectureVo.dt_txt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">교육요일</th>
                    <td>
                        <select class="mgr30" name="dt_type" id="dt_type">
                            <option value="W" <c:if test="${lectureVo.dt_type eq 'W'}">selected="selected"</c:if>>매주</option>
                            <option value="T" <c:if test="${lectureVo.dt_type eq 'T'}">selected="selected"</c:if>>격주</option>
                            <option value="Z" <c:if test="${lectureVo.dt_type eq 'Z'}">selected="selected"</c:if>>기타</option>
                        </select>
                        <input type="checkbox" name="dt_week_select" id="dt_week_1" value="1" <c:if test="${fn:contains(lectureVo.dt_week, '1')}">checked="checked"</c:if>><label for="dt_week_1">월</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_2" value="2" <c:if test="${fn:contains(lectureVo.dt_week, '2')}">checked="checked"</c:if>><label for="dt_week_2">화</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_3" value="3" <c:if test="${fn:contains(lectureVo.dt_week, '3')}">checked="checked"</c:if>><label for="dt_week_3">수</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_4" value="4" <c:if test="${fn:contains(lectureVo.dt_week, '4')}">checked="checked"</c:if>><label for="dt_week_4">목</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_5" value="5" <c:if test="${fn:contains(lectureVo.dt_week, '5')}">checked="checked"</c:if>><label for="dt_week_5">금</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_6" value="6" <c:if test="${fn:contains(lectureVo.dt_week, '6')}">checked="checked"</c:if>><label for="dt_week_6">토</label>
                        <input type="checkbox" name="dt_week_select" id="dt_week_7" value="7" <c:if test="${fn:contains(lectureVo.dt_week, '7')}">checked="checked"</c:if>><label for="dt_week_7">일</label>
                    </td>
                </tr>
                <tr>
                    <th class="required">교육시간</th>
                    <td>
                        <select id="start_hour" name="start_hour">
                            <c:forEach items="${hourList}" var="hour" varStatus="status">
                                <option value="${hour}" <c:if test="${lectureVo.start_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                            </c:forEach>
                        </select>시
                        <select id="start_min" name="start_min">
                            <c:forEach items="${minList}" var="min" varStatus="status">
                                <option value="${min}" <c:if test="${lectureVo.start_min eq min}">selected="selected"</c:if>>${min}</option>
                            </c:forEach>
                        </select>분
                        ~
                        <select id="end_hour" name="end_hour">
                            <c:forEach items="${hourList}" var="hour" varStatus="status">
                                <option value="${hour}" <c:if test="${lectureVo.end_hour eq hour}">selected="selected"</c:if>>${hour}</option>
                            </c:forEach>
                        </select>시
                        <select id="end_min" name="end_min">
                            <c:forEach items="${minList}" var="min" varStatus="status">
                                <option value="${min}" <c:if test="${lectureVo.end_min eq min}">selected="selected"</c:if>>${min}</option>
                            </c:forEach>
                        </select>분
                        <input type="checkbox" name="time_type" id="time_type" class="mgl30" value="K" <c:if test="${lectureVo.time_type eq 'K'}">checked="checked"</c:if>><label for="time_type">요일마다 다름</label>
                    </td>
                </tr>
                <tr>
                    <th class="required">접수기간</th>
                    <td>
                        <input type="text" id="reg_start_st" name="reg_start_st" class="wid200" value="${fn:substring(lectureVo.reg_start_st, 0, 16)}">
                        <a href="javascript:showCalendar('reg_start_st');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="reg_end_dt" name="reg_end_dt" class="wid200" value="${fn:substring(lectureVo.reg_end_dt, 0, 16)}">
                        <a href="javascript:showCalendar('reg_end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>

                        <input type="checkbox" name="reg_type" id="reg_type" class="mgl30" value="Y" <c:if test="${lectureVo.reg_type eq 'Y'}">checked="checked"</c:if>><label for="reg_type">마감시 까지</label>
                    </td>
                </tr>
                <tr>
                    <th class="required">신청방법</th>
                    <td>
                        <input type="checkbox" name="reg_method_select" id="reg_method_1" value="1" class="mgl30" <c:if test="${fn:contains(lectureVo.reg_method, '1')}">checked="checked"</c:if>><label for="reg_method_1">온라인</label>
                        <input type="checkbox" name="reg_method_select" id="reg_method_2" value="2" class="mgl30" <c:if test="${fn:contains(lectureVo.reg_method, '2')}">checked="checked"</c:if>><label for="reg_method_2">방문</label>
                        <input type="checkbox" name="reg_method_select" id="reg_method_3" value="3" class="mgl30" <c:if test="${fn:contains(lectureVo.reg_method, '3')}">checked="checked"</c:if>><label for="reg_method_3">전화</label>
                        <input type="checkbox" name="reg_method_select" id="reg_method_4" value="4" class="mgl30" <c:if test="${fn:contains(lectureVo.reg_method, '4')}">checked="checked"</c:if>><label for="reg_method_4">외부홈페이지</label>

                        <input type="text" class="wid450" name="reg_method_url" id="reg_method_url" <c:if test="${!fn:contains(lectureVo.reg_method, '4')}">disabled</c:if> value="${lectureVo.reg_method_url}">
                    </td>
                </tr>
                <tr>
                    <th class="required">교육인원</th>
                    <td>
                        정원 <input type="text" class="wid70 mgl10" name="student_qty" id="student_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.student_qty}"> 명
                    </td>
                </tr>
                <tr>
                    <th class="required">모집인원</th>
                    <td>
                        인터넷 <input type="text" class="wid70 mgl10" name="online_qty" id="online_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.online_qty}"> 명
                        (대기 <input type="text" class="wid70 mgl10" name="wait_qty" id="wait_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.wait_qty}"> 명)
                        | 방문 <input type="text" class="wid70 mgl10" name="visit_qty" id="visit_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.visit_qty}"> 명
                        | 전화 <input type="text" class="wid70 mgl10" name="tel_qty" id="tel_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.tel_qty}"> 명
                        <div class="mgt10">
                            <input type="checkbox" name="qty_open_yn" id="qty_open_yn" value="N" <c:if test="${lectureVo.qty_open_yn eq 'N'}">checked="checked"</c:if>>
                            <label for="qty_open_yn">접수인원 사용자 화면에 공개하지 않음(값을 체크하시면 사용자화면에 접수인원이 표시되지 않습니다.)</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>모집가능인원</th>
                    <td>
                        인터넷 <input type="text" class="wid70 mgl10" name="online_can_qty" id="online_can_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.online_can_qty}"> 명
                        (대기 <input type="text" class="wid70 mgl10" name="wait_can_qty" id="wait_can_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.wait_can_qty}"> 명)
                        | 방문 <input type="text" class="wid70 mgl10" name="visit_can_qty" id="visit_can_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.visit_can_qty}"> 명
                        | 전화 <input type="text" class="wid70 mgl10" name="tel_can_qty" id="tel_can_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${lectureVo.tel_can_qty}"> 명
                        <div class="mgt10">
                            <span class="co_red">* 모집인원 수정 시 모집가능인원을 수정하셔야 합니다.</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>연령제한</th>
                    <td>
                        <input type="radio" name="age_type" id="age_type_u" value="U" <c:if test="${lectureVo.age_type eq 'U'}">checked="checked"</c:if>><label for="age_type_u">제한없음</label>
                        <input type="radio" name="age_type" id="age_type_l" value="L" <c:if test="${lectureVo.age_type eq 'L'}">checked="checked"</c:if>><label for="age_type_l">14세이상</label>
                        <span class="co_red">(* 14세이상을 선택하시면 14세이상만 수강신청이 가능합니다.)</span>
                    </td>
                </tr>
                <tr>
                    <th class="required">수강료</th>
                    <td>
                        <input type="radio" name="fee_type" id="fee_type_f" value="F" <c:if test="${lectureVo.fee_type eq 'F'}">checked="checked"</c:if>><label for="fee_type_f">무료</label>
                        <input type="radio" name="fee_type" id="fee_type_s" value="S" <c:if test="${lectureVo.fee_type eq 'S'}">checked="checked"</c:if>><label for="fee_type_s">유료</label>
                        <input type="text" class="wid100 mgl10" name="fee" id="fee" oninput="this.value = this.value.replace(/[^0-9]/g, '');" <c:if test="${lectureVo.fee_type eq 'F'}">disabled</c:if> value="${lectureVo.fee}"> 원
                        <div class="mgt10">
                            상세조건 <input type="text" class="wid700 mgl10" name="fee_detail" id="fee_detail" value="${lectureVo.fee_detail}">
                        </div>
                    </td>
                </tr>
                <tr id="pay_type_hide">
                    <th class="required">결제방법</th>
                    <td>
                        <input type="radio" name="pay_type" id="pay_type_i" value="I" <c:if test="${lectureVo.pay_type eq 'I'}">checked="checked"</c:if>><label for="pay_type_i">온라인결제</label>
                        <input type="radio" name="pay_type" id="pay_type_c" value="C" <c:if test="${lectureVo.pay_type eq 'C'}">checked="checked"</c:if>><label for="pay_type_c">현장결제</label>
                        <span class="co_red">(* 현장결제를 선택하시면, 홈페이지에서 카드 및 무통장결제 화면이 뜨지 않습니다.)</span>
                    </td>
                </tr>
                <tr id="discount_yn_hide">
                    <th class="required">감면여부</th>
                    <td>
                        <input type="radio" name="discount_yn" id="discount_yn_n" value="N" <c:if test="${lectureVo.discount_yn eq 'N'}">checked="checked"</c:if>><label for="discount_yn_n">해당없음</label>
                        <input type="radio" name="discount_yn" id="discount_yn_y" value="Y" <c:if test="${lectureVo.discount_yn eq 'Y'}">checked="checked"</c:if>><label for="discount_yn_y">감면대상</label>
                        <a href="#none" class="btn sml blue" onclick="pop_discount()" >선택</a>
                        <input type="hidden" name="discount_str" id="discount_str" value="${lectureVo.discount_str}"/>
                        <ul class="list dash">
                            <c:forEach items="${discountList}" var="discount" varStatus="status">
                            <li>${discount.rate}%, ${discount.tgt_name}
                                <c:if test="${discount.dtl_txt ne null}">(${discount.dtl_txt})</c:if>
                            </li>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
                <tr id="refund_txt_hide">
                    <th>환불정책</th>
                    <td>
                        <textarea rows="5" class="wid100per" name="refund_txt" id="refund_txt">${lectureVo.refund_txt}</textarea>
                    </td>
                </tr>
                <tr id="refund_dt_hide">
                    <th>환불기간</th>
                    <td>
                        <input type="text" id="refund_start_dt" name="refund_start_dt" class="wid100" value="${lectureVo.refund_start_dt}">
                        <a href="javascript:showCalendar('refund_start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="refund_end_dt" name="refund_end_dt" class="wid100" value="${lectureVo.refund_end_dt}">
                        <a href="javascript:showCalendar('refund_end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th>특이사항</th>
                    <td>
                        <textarea rows="5" class="wid100per" name="desc_txt" id="desc_txt">${lectureVo.desc_txt}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </article>
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>프로그램정보</h3>
                </div>
                <div class="right">
                    <div class="tblMsg ta_r">
                        <span class="co_red">*</span> 필수입력
                    </div>
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15rem">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>강사</th>
                    <td>
                        <input type="radio" name="teacher_yn" id="teacher_y" value="Y" <c:if test="${lectureVo.teacher_yn eq 'Y'}">checked="checked"</c:if>><label for="teacher_y">확정</label>
                        <input type="text" class="wid100" id="teacher_nm" <c:if test="${lectureVo.teacher_yn eq 'N'}">disabled</c:if> value="${lectureVo.teacher_nm}">
                        <input type="hidden" id="teacher_idx" name="teacher_idx" value="${lectureVo.teacher_idx}">
                        <a href="#none" class="btn sml blue" onclick="pop_teacher()">선택</a>
                        <input type="radio" name="teacher_yn" id="teacher_n" value="N" class="mgl20" <c:if test="${lectureVo.teacher_yn eq 'N'}">checked="checked"</c:if>><label for="teacher_n">미정</label>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                        <ul id="file_ul">
                            <li class="mb5" style="display:none">
                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                            </li>
                        </ul>
                        <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                        <c:forEach items="${lectureVo.fileList}" var="item" varStatus="status">
                            <c:if test="${item != null}">
                                <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                    <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">교육장소</th>
                    <td>
                        <input type="text" class="wid350" id="room_name" value="${lectureVo.study_place_name}">
                        <input type="hidden" id="study_place_idx" name="study_place_idx" value="${lectureVo.study_place_idx}">
                        <a href="#none" class="btn sml blue popOpen" onclick="pop_room()">선택</a>
                    </td>
                </tr>
                <tr>
                    <th class="required">프로그램소개</th>
                    <td>
                        <textarea rows="5" id="cont" name="cont" class="wid100per">${lectureVo.cont}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <div class="left">
                    <%--<a href="/ssemadmin/cont/lecture/lecture_list.do" class="btn">목록</a>--%>
                    <a href="javascript:history.back();" class="btn">목록</a>
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_update">저장</a>
                    <a href="#none" class="btn grey" id="btn_delete">삭제</a>
                </div>
            </div>
        </article>
    </form>
</div>
