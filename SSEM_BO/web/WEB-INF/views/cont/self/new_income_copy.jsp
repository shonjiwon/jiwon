<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:56
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
        /* Date Picker Settings */
        $('#standard_date').daterangepicker({
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
        $('#sdate').daterangepicker({
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

        $('#edate').daterangepicker({
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

        // 동 정보 셋팅
        let group_idx = '${newTracInoutVo.group_idx}';
        let lecture_idx = '${newTracInoutVo.lecture_idx}';
        if(lecture_idx === '0') {
            lecture_idx = '';
        }
        if(group_idx !== '' && lecture_idx !== '') {
            let select_val = group_idx;
            let html = '';
            let sdate = '${newTracInoutVo.standard_date}';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_list.do?group_idx=" + select_val + "&sdate=" + sdate.substring(0, 7),
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#lecture_idx').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['lecture_idx'];
                            if (idx === Number(lecture_idx)) {
                                html += '<option value="' + v['lecture_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['lecture_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#lecture_idx').append(html);
                    }
                });
            }
        } else {
            let html = '';
            $('#lecture_idx').children().remove();
            html += '<option value="">선택하세요</option>';
            $('#lecture_idx').append(html);
        }

        // 동선택시 기준년월에 따른 프로그램 리스트 표시
        $('#group_idx').change(function() {
            let sdate = $('#standard_date').val();
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_list.do?group_idx=" + select_val + "&sdate=" + sdate.substring(0, 7),
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#lecture_idx').children().remove();
                        html += '<option value="">선택하세요</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['lecture_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#lecture_idx').append(html);
                    }
                });
            } else {
                $('#lecture_idx').children().remove();
                html += '<option value="">선택하세요</option>';
                $('#lecture_idx').append(html);
            }
        });

        $('#lecture_idx').change(function() {
            let select_val = $(this).val();
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_info.do?lecture_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#lecture_nm').val(data.name);
                        $('#sdate').val(data.start_dt);
                        $('#edate').val(data.end_dt);
                    }
                });
            } else {
                $('#lecture_nm').val("");
            }
        });

        $('#btn_insert').click(function() {
            var frm = document.frm;

            if(!fnIsValidRequired(frm.group_idx, "동별")){return false;}
            if(!fnIsValidRequired(frm.standard_date, "수입일자")){return false;}
            if(!fnIsValidRequired(frm.inout_cd, "구분")){return false;}
            if(!fnIsValidRequired(frm.inout_nm, "이름")){return false;}
            if(!fnIsValidRequired(frm.inout_cost, "수입액")){return false;}
            if(!fnIsValidRequired(frm.adj_yn, "정산구분")){return false;}

            $("#frm").submit();
        });
    });

    function pop_student() {
        if($('#group_idx').val() === '') {
            alert("동을 선택해 주세요.");
            return;
        }

        if($('#lecture_idx').val() === '') {
            alert("프로그램을 선택해 주세요.");
            return;
        }

        var url = "/ssemadmin/popup/self/student_list.do?group_idx=" + $('#group_idx').val() + "&lecture_idx=" + $('#lecture_idx').val();
        window.open(url, 'popup_student', 'width=1200, height=690, scrollbars=0, toolbar=0, menubar=no');
    }

    function pop_discount() {
        if($('#group_idx').val() === '') {
            alert("동을 선택해 주세요.");
            return;
        }

        var url = "/ssemadmin/popup/self/discount_list.do?group_idx=" + $('#group_idx').val();
        window.open(url, 'popup_student', 'width=800, height=500, scrollbars=0, toolbar=0, menubar=no');
    }
</script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post_no').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullRoadAddr;
            }
        }).open();
    }
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
        <form name="frm" id="frm" action="/ssemadmin/cont/self/new_income_inscr.do" method="post" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">동별</th>
                    <td>
                        <select id="group_idx" name="group_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                            <option value="">선택하세요</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.group_idx}" <c:if test="${newTracInoutVo.group_idx eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th class="required">수입일자</th>
                    <td>
                        <input type="text" id="standard_date" name="standard_date" class="wid100" value="${newTracInoutVo.standard_date}">
                        <a href="javascript:showCalendar('standard_date');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th class="required">구분</th>
                    <td>
                        <select class="wid150" id="inout_cd" name="inout_cd">
                            <option value="">선택하세요</option>
                            <c:forEach items="${codeList}" var="code" varStatus="status">
                                <option value="${code.code_idx}" <c:if test="${newTracInoutVo.inout_cd eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>프로그램명</th>
                    <td>
                        <select class="wid150" id="lecture_idx" name="lecture_idx">
                            <option value="">선택하세요</option>
                        </select>
                        <input type="hidden" id="lecture_nm" name="lecture_nm" value="${newTracInoutVo.lecture_nm}">
                    </td>
                </tr>
                <tr>
                    <th class="required">이름</th>
                    <td>
                        <input type="text" class="wid150" id="inout_nm" name="inout_nm" value="${newTracInoutVo.inout_nm}"> <a href="#none" class="btn sml grey" onclick="pop_student()">수강자 조회</a>
                        <input type="hidden" id="student_idx" name="student_idx" value="${newTracInoutVo.student_idx}">
                    </td>
                    <th>생년월일</th>
                    <td>
                        <input type="text" id="birth" name="birth" class="wid150" readonly value="${newTracInoutVo.birth}">
                    </td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <input type="text" class="wid150" id="gender" name="gender" value="${newTracInoutVo.gender}">
                    </td>
                    <th>핸드폰번호</th>
                    <td>
                        <input type="text" class="wid150" id="mob_no" name="mob_no" value="${newTracInoutVo.mob_no}">
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3">
                        <input type="text" id="post_no" name="post_no" value="${newTracInoutVo.post_no}"> <a href="#none" class="btn sml grey" onclick="sample4_execDaumPostcode();">우편번호</a><br/>
                        <input type="text" class="wid350 mgt10" id="addr" name="addr" value="${newTracInoutVo.addr}">
                        <input type="text" class="wid350 mgt10" id="addr_detail" name="addr_detail" value="${newTracInoutVo.addr_detail}">
                    </td>
                </tr>
                <tr>
                    <th>수강기간(이용기간)</th>
                    <td colspan="3">
                        <input type="text" id="sdate" name="sdate" class="wid100" value="${newTracInoutVo.sdate}">
                        <a href="javascript:showCalendar('sdate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="edate" name="edate" class="wid100" value="${newTracInoutVo.edate}">
                        <a href="javascript:showCalendar('edate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr class="required">
                    <th class="required">수입액</th>
                    <td colspan="3">
                        <input type="text" class="wid200" oninput="this.value = this.value.replace(/[^0-9]/g, '');" id="inout_cost" name="inout_cost" value="${newTracInoutVo.inout_cost}"> 원
                    </td>
                </tr>
                <tr>
                    <th>감면자 정보</th>
                    <td>
                        <input type="text" class="wid50" id="discount_rate" name="discount_rate" value="${newTracInoutVo.discount_rate}" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> % <a href="#none" class="btn sml grey" onclick="pop_discount()">감면정보수정</a>
                        <input type="hidden" class="wid200" id="discount_idx" name="discount_idx" value="${newTracInoutVo.discount_idx}">
                    </td>
                    <th>감면사항</th>
                    <td>
                        <input type="text" class="wid250" id="discount_info" name="discount_info" value="${newTracInoutVo.discount_info}" readonly>
                    </td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" id="note" name="note" value="${newTracInoutVo.note}">
                    </td>
                </tr>
                <tr>
                    <th class="required">정산구분</th>
                    <td>
                        <input type="radio" name="adj_yn" id="adj_y" value="Y" <c:if test="${newTracInoutVo.adj_yn eq 'Y'}">checked</c:if>>
                        <label for="adj_y">완료</label>
                        <input type="radio" name="adj_yn" id="adj_n" value="N" <c:if test="${newTracInoutVo.adj_yn eq 'N'}">checked</c:if>>
                        <label for="adj_n">미완료</label>
                    </td>
                    <th>감면제외여부 확인</th>
                    <td>
                        <input type="radio" name="discount_yn" id="discount_n" value="N" <c:if test="${newTracInoutVo.discount_yn eq 'N'}">checked</c:if>>
                        <label for="discount_n">제외</label>
                        <input type="radio" name="discount_yn" id="discount_y" value="Y" <c:if test="${newTracInoutVo.discount_yn eq 'Y'}">checked</c:if>>
                        <label for="discount_y">감면</label>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn grey" id="btn_insert">저장</a>
                <a href="/ssemadmin/cont/self/new_income_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
