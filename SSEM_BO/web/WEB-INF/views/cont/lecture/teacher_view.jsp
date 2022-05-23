<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        // 휴대폰번호
        var mob_no = '${teacherVo.mob_no}';
        if(mob_no !== '') {
            var jbSplit = mob_no.split('-');
            $("#mob_1").val(jbSplit[0]);
            $("#mob_2").val(jbSplit[1]);
            $("#mob_3").val(jbSplit[2]);
        }

        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${teacherVo.p_idx}';
        let group_idx = '${teacherVo.group_idx}';
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

        /* Date Picker Settings */
        $('#birth').daterangepicker({
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
                            location.href = "?teacher_idx=${teacherVo.teacher_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });

        $("#btn_update").click(function(){
            var frm = document.frm;

            /*if(!fnIsValidRequired(frm.pic_atch_file_id, "이미지")){return false;}*/
            if(!fnIsValidRequired(frm.alt_txt, "이미지 대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.name, "이름")){return false;}
            if(!fnIsValidRequired(frm.gender, "성별")){return false;}
            if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.birth, "생년월일")){return false;}
            if(!fnIsValidRequired(frm.email, "이메일")){return false;}
            if(!fnIsEmailAddr(frm.email)) {
                modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'focus', '');
                return false;
            }
            if(!fnIsValidRequired(frm.gubun, "구분")){return false;}
            if(!fnIsValidRequired(frm.status, "상태")){return false;}
            if(!fnIsValidRequired(frm.code_idx, "교육분야")){return false;}
            if(!fnIsValidRequired(frm.start_dt, "협약기간")){return false;}
            if(!fnIsValidRequired(frm.end_dt, "협약기간")){return false;}

            $("#mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

            $("#frm").submit();
        });

        // 검색 조건중 소속 정보가 있는 경우
        let p_idx_list = '${teacherVo.p_idx}';
        let group_idx_list = '${teacherVo.group_idx}';
        if(p_idx_list !== '' && group_idx_list !== '') {
            let select_val = p_idx_list;
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
                        $('#group_idx_list').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx_list').append(html);
                    }
                });
            }
        } else if(p_idx_list !== '') {
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
                        $('#group_idx_list').children().remove();
                        $.each(data, function (key, v) {
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx_list').append(html);
                    }
                });
            }
        }

        $('#p_idx_list').change(function() {
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
                        $('#group_idx_list').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx_list').append(html);
                    }
                });
            } else {
                $('#group_idx_list').children().remove();
                $('#group_idx_list').append(html);
            }
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////

        // 엑셀 팝업 처리 /////////////////////////////////////////////////////////////////////////////////////
        var popExcel = $(".popExcel");
        popExcel.click(function() {
            $('#reason_txt').val("");
            $('#excel_pwd').val("");

            $("input:radio[name='reason']").removeAttr("checked");

            $(".pop_exelDown").addClass('on')
        });

        $('.btnClose').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_pop_close').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_excel_insert').click(function() {

            var frm = document.excel_frm;

            if(!fnIsValidRequired(frm.reason, "다운로드 사유")){return false;}

            if(frm.reason.value === '5') {
                if (!fnIsValidRequired(frm.reason_txt, "다운로드 사유")) {
                    return false;
                }
            }
            if(!fnIsValidRequired(frm.excel_pwd, "엑셀파일 비밀번호")){return false;}

            $.ajax({
                url: '/ssemadmin/cont/excel/private_insert.do',
                type: 'POST',
                dataType: 'json',
                data: $("#excel_frm").serialize(),
                xhrFields: {
                    withCredentials: true
                },
                async: false,
                success: function (data) {
                    if (data !== 0) {
                        alert("등록되었습니다");
                        // 엑셀 다운로드
                        $("#searchVal10").val($("#excel_pwd").val());
                        var param = $("#frm_program").serialize();
                        document.location.href="/ssemadmin/cont/excel/teacher_view_excel.do?" + param;
                    } else {
                        alert("등록에 실패하였습니다.");
                    }
                }
            });

            $('.popArea').removeClass('on')
        });

        $("input[name=reason]").change(function() {
            var radio_val = $(this).val();
            if(radio_val === '5') {
                $('#reason_txt').removeAttr("disabled");
                $('#reason_txt').focus();
            } else {
                $('#reason_txt').attr("disabled", true);
            }
        });

        $('#reason_txt').keyup(function (event) {
            if($(this).val().length > 30) {
                if(event.keyCode !== 8) {
                    alert("30자까지만 입력이 가능합니다.");
                }
                $('#reason_txt').val($('#reason_txt').val().substr(0, $('#reason_txt').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        $('#reason_txt').keydown(function (event) {
            if($(this).val().length > 30) {
                if(event.keyCode !== 8) {
                    alert("30자까지만 입력이 가능합니다.");
                }
                $('#reason_txt').val($('#reason_txt').val().substr(0, $('#reason_txt').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function delete_frm() {
        document.delfrm.submit();
    }

    function pop_user() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;

        var url = "/ssemadmin/popup/user/user_list.do";
        window.open(url, 'popup_room', 'width=1200, height=530, scrollbars=0, toolbar=0, menubar=no');
    }

    function pop_program() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;

        var url = "/ssemadmin/popup/lecture/program_list.do?teacher_idx=${teacherVo.teacher_idx}";
        window.open(url, 'popup_program', 'width=1200, height=820, scrollbars=0, toolbar=0, menubar=no');
    }

    function goSearch() {
        $("#page").val("1");
        $("#frm_program").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" action="/ssemadmin/cont/lecture/teacher_update.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="mob_no" id="mob_no" value="${teacherVo.mob_no}" />
        <input type="hidden" name="teacher_idx" id="teacher_idx" value="${teacherVo.teacher_idx}" />
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
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">소속</th>
                    <td colspan="3">
                        <select id="p_idx" name="p_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                            <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                                <option value="${item.group_idx}" <c:if test="${item.group_idx eq teacherVo.p_idx}">selected="selected"</c:if>>${item.name}</option>
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
                </tbody>
            </table>
        </article>

        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>개인정보</h3>
                </div>
                <div class="right">
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
                    <th class="required">이미지</th>
                    <td colspan="3">
                        <input type="file" name="pic_atch_file_id" id="pic_atch_file_id" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">000 * 000</span> )
                        <c:forEach items="${teacherVo.picFileList}" var="thumb" varStatus="status">
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
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt" value="${teacherVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">이름</th>
                    <td>
                        <input type="text" class="wid250" name="name" id="name" value="${teacherVo.name}">
                    </td>
                    <th class="required">성별</th>
                    <td>
                        <input type="radio" name="gender" id="gender_m" value="M" <c:if test="${teacherVo.gender eq 'M'}">checked="checked"</c:if>><label for="gender_m">남</label>
                        <input type="radio" name="gender" id="gender_f" value="F" <c:if test="${teacherVo.gender eq 'F'}">checked="checked"</c:if>><label for="gender_f">여</label>
                    </td>
                </tr>
                <tr>
                    <th class="required">휴대폰</th>
                    <td>
                        <input type="text" name="mob_1" id="mob_1" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="mob_2" id="mob_2" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="mob_3" id="mob_3" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    </td>
                    <th class="required">생년월일</th>
                    <td>
                        <input type="text" id="birth" name="birth" class="wid100" value="${teacherVo.birth}">
                        <a href="javascript:showCalendar('birth');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th class="required">이메일</th>
                    <td colspan="3">
                        <input type="text" class="wid300" name="email" id="email" value="${teacherVo.email}">
                    </td>
                </tr>
                </tbody>
            </table>
        </article>

        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>강사정보</h3>
                </div>
                <div class="right">
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
                    <th class="required">구분</th>
                    <td>
                        <select id="gubun" name="gubun" class="wid200">
                            <option value="N" <c:if test="${teacherVo.gubun eq 'N'}">selected="selected"</c:if>>일반</option>
                            <option value="S" <c:if test="${teacherVo.gubun eq 'S'}">selected="selected"</c:if>>자원봉사자</option>
                        </select>
                    </td>
                    <th class="required">상태</th>
                    <td>
                        <select id="status" name="status" class="wid200">
                            <option value="A" <c:if test="${teacherVo.status eq 'A'}">selected="selected"</c:if>>승인</option>
                            <option value="N" <c:if test="${teacherVo.status eq 'N'}">selected="selected"</c:if>>미승인</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">교육분야</th>
                    <td colspan="3">
                        <select id="code_idx" name="code_idx" class="wid150">
                            <c:forEach items="${codeList}" var="code" varStatus="status">
                                <option value="${code.code_idx}" <c:if test="${teacherVo.code_idx eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">협약기간</th>
                    <td colspan="3">
                        <input type="text" id="start_dt" name="start_dt" class="wid100" value="${teacherVo.start_dt}">
                        <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="end_dt" name="end_dt" class="wid100" value="${teacherVo.end_dt}">
                        <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th>전문분야</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="prof_field" id="prof_field" value="${teacherVo.prof_field}">
                    </td>
                </tr>
                <tr>
                    <th>학력 및 주요경력</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="career" id="career">${teacherVo.career}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>취득자격</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="cert" id="cert">${teacherVo.cert}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>강사료</th>
                    <td colspan="3">
                        <input type="text" class="wid300" name="pay" id="pay" value="${teacherVo.pay}">
                    </td>
                </tr>
                <tr>
                    <th>송파구청회원ID</th>
                    <td colspan="3">
                        <input type="text" class="wid300" name="user_id" id="user_id" value="${teacherVo.user_id}" readonly>
                        <a href="#none" class="btn sml blue" onclick="pop_user()">ID조회 및 입력</a> <br/><br/>
                        <div>
                            * 송파구청 회원ID가 등록되어야 강사회원이 마이페이지에서 강의이력을 조회 할 수 있습니다.<br/>
                            (개별 프로그램(강좌)에 회원ID가 등록된 강사정보가 일치한 강의에 한함)
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>강사만족도</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${teacherVo.score eq '1'}">
                                금
                            </c:when>
                            <c:when test="${teacherVo.score eq '2'}">
                                은
                            </c:when>
                            <c:when test="${teacherVo.score eq '3'}">
                                동
                            </c:when>
                            <c:otherwise>
                                평가없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td>${teacherVo.reg_id}</td>
                    <th>등록일</th>
                    <td>${teacherVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td>${teacherVo.up_id}</td>
                    <th>최종수정일</th>
                    <td>${teacherVo.up_dt}</td>
                </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <%--<div class="left">
                    <a href="/ssemadmin/cont/lecture/teacher_list.do" class="btn">목록</a>
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_update">저장</a>
                </div>--%>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>프로그램진행현황</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <article class="tabUnit">
            <div class="cont tab01 on">
                <form name="frm_program" id="frm_program" method="post" action="/ssemadmin/cont/lecture/teacher_view.do">
                    <input type="hidden" name="page" id="page" value="${page}"/>
                    <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
                    <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
                    <input type="hidden" name="searchVal4" id="searchVal4" value="${teacherVo.teacher_idx}"/> <%-- 강사일련번호 --%>
                    <input type="hidden" name="teacher_idx" value="${teacherVo.teacher_idx}"/> <%-- 강사일련번호 --%>
                    <input type="hidden" name="searchVal10" id="searchVal10" /> <%-- 강사일련번호 --%>
                <article class="contUnit sch_area">
                    <h3>
                        <span class="material-icons">search</span> Search <small>검색</small>
                    </h3>
                    <div class="line">
                        <div class="formCont">
                            <label for="p_idx_list">소속</label>
                            <select id="p_idx_list" name="p_idx" class="wid150" disabled>
                                <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                                    <option value="${item.group_idx}" <c:if test="${item.group_idx eq teacherVo.p_idx}">selected="selected"</c:if>>${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="formCont">
                            <label for="group_idx_list">교육기관</label>
                            <select id="group_idx_list" name="group_idx" class="wid200" disabled>
                            </select>
                        </div>
                        <div class="formCont">
                            <label for="searchSDate">교육기간</label>
                            <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                            <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                            ~
                            <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                            <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        </div>
                    </div>
                    <div class="line">
                        <div class="formCont">
                            <label for="searchKind">프로그램 상태</label>
                            <select id="searchKind" name="searchKind" class="wid150">
                                <option value="">전체</option>
                                <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>접수대기</option>
                                <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>접수중</option>
                                <option value="3" <c:if test="${searchKind eq '3'}">selected="selected"</c:if>>접수마감</option>
                                <option value="4" <c:if test="${searchKind eq '4'}">selected="selected"</c:if>>교육전</option>
                                <option value="5" <c:if test="${searchKind eq '5'}">selected="selected"</c:if>>교육중</option>
                                <option value="6" <c:if test="${searchKind eq '6'}">selected="selected"</c:if>>교육종료</option>
                                <option value="7" <c:if test="${searchKind eq '7'}">selected="selected"</c:if>>외부홈페이지</option>
                            </select>
                        </div>
                        <div class="formCont">
                            <label for="searchVal">프로그램명 검색</label>
                            <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid250" value="${searchVal}">
                            <a href="#none" class="btn orange" id="btn_search">검색</a>
                        </div>
                    </div>
                </article>
                </form>
                <article class="contUnit tbl_area">
                    <div class="btnArea mgt0 mgb10">
                        <div class="left">
                            총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                        </div>
                        <div class="right">
                            <a href="#none" class="btn sml grey" onclick="pop_program()">프로그램등록</a>
                            <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
                        </div>
                    </div>
                    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/lecture/teacher_delete.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="teacher_idx" value="${teacherVo.teacher_idx}" />
                    </form>
                    <table>
                        <colgroup>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>소속</th>
                            <th>교육기관</th>
                            <th>프로그램명</th>
                            <th>교육기간</th>
                            <th>교육인원</th>
                            <th>프로그램상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${fn:length(itemList) == 0}">
                            <tr>
                                <td colspan="7">데이터가 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:set var="lno" value="0"/>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <c:set var="lno">${lno + 1}</c:set>
                            <tr>
                                <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                                <td>${item.p_name}</td>
                                <td>${item.grp_name}</td>
                                <td class="ta_l">${item.name}</td>
                                <td>${item.start_dt} ~ ${item.end_dt}</td>
                                <td>${item.student_qty}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:contains(item.reg_method, '4')}">
                                            외부홈페이지
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${item.status_code eq '1'}">접수대기</c:when>
                                                <c:when test="${item.status_code eq '2'}">신청가능</c:when>
                                                <c:when test="${item.status_code eq '3'}">대기신청</c:when>
                                                <c:when test="${item.status_code eq '4'}">신청마감</c:when>
                                                <c:when test="${item.status_code eq '5'}">교육전</c:when>
                                                <c:when test="${item.status_code eq '6'}">교육중</c:when>
                                                <c:when test="${item.status_code eq '7'}">교육종료</c:when>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <common:pageLinkAdmin name="pageholder"/>
                    <div class="btnArea">
                        <div class="left">
                            <a href="/ssemadmin/cont/lecture/teacher_list.do" class="btn">목록</a>
                        </div>
                        <div class="right">
                            <a href="#none" class="btn red" id="btn_update">저장</a>
                            <a href="#none" class="btn grey" id="btn_delete">삭제</a>
                        </div>
                    </div>
                </article>
            </div>
        </article>
    </article>
</div>

<section class="popArea pop_exelDown">
    <div class="popBody">
        <div class="tit">
            <h2>엑셀파일 다운로드 사유등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area leftType">
                <div class="btnArea mgb10">
                    <div class="left">
                    </div>
                    <div class="right">
                        <div class="tblMsg ta_r">
                            <span class="co_red">*</span> 필수입력
                        </div>
                    </div>
                </div>
                <form name="excel_frm" id="excel_frm" method="post" action="/ssemadmin/cont/excel/private_insert.do">
                    <input type="hidden" name="level1" id="level1" value="${topMenu.name}"/>
                    <input type="hidden" name="level2" id="level2" value="${currentMenu.name}"/>
                    <input type="hidden" name="level3" id="level3" value="프로그램 진행현황"/>
                    <table>
                        <colgroup>
                            <col style="width:5rem">
                            <col style="width:5rem">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="required">다운로드 사유</th>
                            <td style="line-height: 3.0rem !important;">
                                <input type="radio" name="reason" id="reason_1" value="1">
                                <label for="reason_1">교육 프로그램 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_2" value="2">
                                <label for="reason_2">시설 및 장비 대여 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_3" value="3">
                                <label for="reason_3">온라인 상담 예약 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_4" value="4">
                                <label for="reason_4">구민(회원) 민원처리</label><br>
                                <input type="radio" name="reason" id="reason_5" value="5">
                                <label for="reason_5">기타(직접입력)</label><br>
                                <input type="text" class="wid300" name="reason_txt" id="reason_txt" disabled> <span class="co_red" id="txt_length">0</span>/30
                            </td>
                        </tr>
                        <tr>
                            <th class="required">엑셀파일 비밀번호 생성</th>
                            <td>
                                <input type="text" name="excel_pwd" id="excel_pwd" onkeyup="fnIsValidNumPwd(this);" onkeydown="fnIsValidNumPwd(this);">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div>
                    <ul class="list bili">
                        <li>비밀번호 는 <span class="co_red">숫자로만 입력 가능하며, 최대 4자리까지</span> 생성하실 수 있습니다.</li>
                    </ul>
                </div>
                <div class="btnArea ta_c">
                    <a href="#none" class="btn red" id="btn_excel_insert">등록</a>
                    <a href="#none" class="btn grey" id="btn_pop_close">취소</a>
                </div>
            </article>
        </div>
    </div>
</section>
