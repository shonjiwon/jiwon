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
<script type="text/javascript">
    $(document).ready(function() {
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

        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.pic_atch_file_id, "이미지")){return false;}
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
    });

    function pop_user() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;

        var url = "/ssemadmin/popup/user/user_list.do";
        window.open(url, 'popup_room', 'width=1200, height=530, scrollbars=0, toolbar=0, menubar=no');
    }

</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" action="/ssemadmin/cont/lecture/teacher_inscr.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="mob_no" id="mob_no" />
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
                    <input type="file" class="wid350" name="pic_atch_file_id" id="pic_atch_file_id">
                    <span>(파일형식 : jpg, jpeg, png, gif, bmp / 사이즈 : 300*350)</span>
                </td>
            </tr>
            <tr>
                <th class="required">이미지 대체텍스트</th>
                <td colspan="3">
                    <input type="text" class="wid100per" name="alt_txt" id="alt_txt">
                </td>
            </tr>
            <tr>
                <th class="required">이름</th>
                <td>
                    <input type="text" class="wid250" name="name" id="name">
                </td>
                <th class="required">성별</th>
                <td>
                    <input type="radio" name="gender" id="gender_m" value="M"><label for="gender_m">남</label>
                    <input type="radio" name="gender" id="gender_f" value="F"><label for="gender_f">여</label>
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
                    <input type="text" id="birth" name="birth" class="wid100">
                    <a href="javascript:showCalendar('birth');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th class="required">이메일</th>
                <td colspan="3">
                    <input type="text" class="wid300" name="email" id="email">
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
                        <option value="">선택</option>
                        <option value="N">일반</option>
                        <option value="S">자원봉사자</option>
                    </select>
                </td>
                <th class="required">상태</th>
                <td>
                    <select id="status" name="status" class="wid200">
                        <option value="">선택</option>
                        <option value="A">승인</option>
                        <option value="N">미승인</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th class="required">교육분야</th>
                <td colspan="3">
                    <select id="code_idx" name="code_idx" class="wid150">
                        <option value="">전체</option>
                        <c:forEach items="${codeList}" var="code" varStatus="status">
                            <option value="${code.code_idx}">${code.cd_val}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th class="required">협약기간</th>
                <td colspan="3">
                    <input type="text" id="start_dt" name="start_dt" class="wid100">
                    <a href="javascript:showCalendar('start_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="end_dt" name="end_dt" class="wid100">
                    <a href="javascript:showCalendar('end_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>전문분야</th>
                <td colspan="3">
                    <input type="text" class="wid100per" name="prof_field" id="prof_field">
                </td>
            </tr>
            <tr>
                <th>학력 및 주요경력</th>
                <td colspan="3">
                    <textarea rows="5" class="wid100per" name="career" id="career"></textarea>
                </td>
            </tr>
            <tr>
                <th>취득자격</th>
                <td colspan="3">
                    <textarea rows="5" class="wid100per" name="cert" id="cert"></textarea>
                </td>
            </tr>
            <tr>
                <th>강사료</th>
                <td colspan="3">
                    <input type="text" class="wid300" name="pay" id="pay">
                </td>
            </tr>
            <tr>
                <th>송파구청회원ID</th>
                <td colspan="3">
                    <input type="text" class="wid300" name="user_id" id="user_id" readonly>
                    <a href="#none" class="btn sml blue" onclick="pop_user()">ID조회 및 입력</a> <br/><br/>
                    <div>
                        * 송파구청 회원ID가 등록되어야 강사회원이 마이페이지에서 강의이력을 조회 할 수 있습니다.<br/>
                        (개별 프로그램(강좌)에 회원ID가 등록된 강사정보가 일치한 강의에 한함)
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/lecture/teacher_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
    </form>
</div>
