<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:08
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
        $('#apy_birth').daterangepicker({
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

        $('#reg_dt').daterangepicker({
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

        $('#pay_dt').daterangepicker({
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

        $('#vaccine_dt').daterangepicker({
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
            insert_frm();
        });

        $(document).on('change', '#same_mob_no', function(){
            if($(this).is(':checked')){
                $("#ref_mob_1").val($("#mob_1").val());
                $("#ref_mob_2").val($("#mob_2").val());
                $("#ref_mob_3").val($("#mob_3").val());
            }else{
                $("#ref_mob_1").val("");
                $("#ref_mob_2").val("");
                $("#ref_mob_3").val("");
            }
        });

        $("input:radio[name=ref_check]").click(function(){
            if($("input:radio[name=ref_check]:checked").val()=='Y'){
                $("#hide_1").show();
                $("#hide_2").show();
            }else{
                $("#hide_1").hide();
                $("#hide_2").hide();
            }
        });

        $("input:radio[name=discount_yn]").click(function(){
            if($("input:radio[name=discount_yn]:checked").val()=='N'){
                $("#discount_idx").val("");
                $("#discount_rate").val("");
                $("#real_pay").text(${lectureVo.fee} + "원");
                $("#pay_sum").val("${lectureVo.fee}");
            }
        });

        $("input:radio[name=vaccine_yn]").click(function(){
            if($("input:radio[name=vaccine_yn]:checked").val()=='Y'){
                $("#vaccine_dt").attr("disabled", false);
            }else{
                $("#vaccine_dt").attr("disabled", true);
            }
        });

        $('#student_type').change(function() {
            let select_val = $(this).val();

            if(select_val === '초등학생') {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                html +='<option value="1학년">1학년</option>';
                html +='<option value="2학년">2학년</option>';
                html +='<option value="3학년">3학년</option>';
                html +='<option value="4학년">4학년</option>';
                html +='<option value="5학년">5학년</option>';
                html +='<option value="6학년">6학년</option>';
                $('#student_grade').append(html); //항목 추가

            } else if(select_val === '중학생' || select_val === '고등학생') {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                html +='<option value="1학년">1학년</option>';
                html +='<option value="2학년">2학년</option>';
                html +='<option value="3학년">3학년</option>';
                $('#student_grade').append(html); //항목 추가
            } else {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                $('#student_grade').append(html); //항목 추가
            }
        });
    });

    function insert_frm() {
        let frm = document.frm;

        if(!fnIsValidRequired(frm.apy_name, "성명")){return false;}
        if(!fnIsValidRequired(frm.apy_birth, "생년월일")){return false;}
        if(!fnIsValidRequired(frm.apy_gender, "성별")){return false;}
        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}
        if($("input:radio[name=ref_check]:checked").val()=='Y') {
            if(!fnIsValidRequired(frm.apy_ref, "신청자와의 관계")){return false;}

            if (!fnIsValidRequired(frm.apy_real_name, "교육대상자 이름")) {
                return false;
            }
            if (!fnIsValidRequired(frm.ref_mob_1, "휴대폰번호")) {
                return false;
            }
            if (!fnIsValidRequired(frm.ref_mob_2, "휴대폰번호")) {
                return false;
            }
            if (!fnIsValidRequired(frm.ref_mob_3, "휴대폰번호")) {
                return false;
            }

            $("#apy_ref_mob_no").val(frm.ref_mob_1.value + '-' + frm.ref_mob_2.value + '-' + frm.ref_mob_3.value);
        }

        if(!fnIsValidRequired(frm.apy_method, "신청방법")){return false;}
        if(!fnIsValidRequired(frm.reg_dt, "신청일")){return false;}
        if(!fnIsValidRequired(frm.apy_status, "신청상태")){return false;}
        if(!fnIsValidRequired(frm.appv_cd, "승인여부")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        $("#frm").submit();
    }

    function pop_discount_select() {
        var frm = document.frm;
        var group_idx = frm.group_idx.value;
        var discount_yn = frm.discount_yn.value;

        if(discount_yn === 'N' || discount_yn === '') {
            modalMsg("감면여부를 '감면대상'으로 선택해 주세요.", "notice", "");
        } else {
            var url = "/ssemadmin/popup/discount/discount_select.do?group_idx=" + group_idx + "&discount_idx=" + $("#discount_idx").val() + "&pay_sum=" + ${lectureVo.fee};
            window.open(url, 'popup_discount', 'width=1200, height=510, scrollbars=0, toolbar=0, menubar=no');
        }
    }

    function pop_student() {
        var url = "/ssemadmin/popup/student/student_list.do";
        window.open(url, 'popup_teacher', 'width=1200, height=690, scrollbars=0, toolbar=0, menubar=no');
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
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('apy_addr1').value = fullRoadAddr;
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
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>프로그램정보</h3>
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
                <th>소속</th>
                <td>${lectureVo.p_name}</td>
                <th>교육기관</th>
                <td>${lectureVo.grp_name}</td>
            </tr>
            <tr>
                <th>홈페이지</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.gubun eq 'J'}">미래교육</c:when>
                        <c:when test="${lectureVo.gubun eq 'S'}">평생교육</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <th>노출여부</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.use_yn eq 'Y'}">노출</c:when>
                        <c:when test="${lectureVo.use_yn eq 'N'}">미노출</c:when>
                        <c:otherwise>미노출</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>프로그램명</th>
                <td colspan="3">${lectureVo.name}</td>
            </tr>
            <tr>
                <th>대상</th>
                <td>
                    <c:forEach items="${lectureVo.array_tgt}" var="tgt" varStatus="status">
                        <span class="item">${tgt}</span>
                    </c:forEach>
                </td>
                <th>상태</th>
                <td>
                    <c:choose>
                        <c:when test="${fn:contains(lectureVo.reg_method, '4')}">
                            외부홈페이지
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${lectureVo.status_code eq '1'}">접수대기</c:when>
                                <c:when test="${lectureVo.status_code eq '2'}">신청가능</c:when>
                                <c:when test="${lectureVo.status_code eq '3'}">대기신청</c:when>
                                <c:when test="${lectureVo.status_code eq '4'}">신청마감</c:when>
                                <c:when test="${lectureVo.status_code eq '5'}">교육전</c:when>
                                <c:when test="${lectureVo.status_code eq '6'}">교육중</c:when>
                                <c:when test="${lectureVo.status_code eq '7'}">교육종료</c:when>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>수강료</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.fee_type eq 'F'}">무료</c:when>
                        <c:when test="${lectureVo.fee_type eq 'S'}">
                            유료 / <fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                        </c:when>
                    </c:choose>
                </td>
                <th>결제방법</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureVo.pay_type eq 'I'}">온라인</c:when>
                        <c:when test="${lectureVo.pay_type eq 'C'}">현장결제</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>교육기관</th>
                <td>${lectureVo.start_dt} ~ ${lectureVo.end_dt}<br> ${lectureVo.dt_str} / ${lectureVo.start_time} ~ ${lectureVo.end_time}</td>
                <th>접수기간</th>
                <td>${fn:substring(lectureVo.reg_start_st, 0, 16)} ~ ${fn:substring(lectureVo.reg_end_dt, 0, 16)}</td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>수강생정보</h3>
            </div>
            <div class="right">
                <a href="#none" class="btn blue popOpen" onclick="pop_student()">기존수강생 조회</a>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/lecture/apply_student_inscr.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="apy_mob_no" id="apy_mob_no"/>
            <input type="hidden" name="apy_ref_mob_no" id="apy_ref_mob_no"/>
            <input type="hidden" name="lecture_idx" id="lecture_idx" value="${lectureVo.lecture_idx}"/>
            <input type="hidden" name="group_idx" id="group_idx" value="${lectureVo.group_idx}"/>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th class="required">성명</th>
                <td><input type="text" class="wid250" id="apy_name" name="apy_name"></td>
                <th class="required">생년월일</th>
                <td>
                    <input type="text" id="apy_birth" name="apy_birth" class="wid100">
                    <a href="javascript:showCalendar('apy_birth');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th class="required">성별</th>
                <td>
                    <input type="radio" name="apy_gender" id="apy_gender_m" value="M"><label for="apy_gender_m">남</label>
                    <input type="radio" name="apy_gender" id="apy_gender_f" value="F"><label for="apy_gender_f">여</label>
                </td>
                <th class="required">휴대폰번호</th>
                <td>
                    <input type="text" name="mob_1" id="mob_1" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" name="mob_2" id="mob_2" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" name="mob_3" id="mob_3" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                </td>
            </tr>
            <tr>
                <th>대리여부</th>
                <td colspan="3">
                    <input type="radio" name="ref_check" id="ref_check_y" value="Y"><label for="ref_check_y">Y</label>
                    <input type="radio" name="ref_check" id="ref_check_n" value="N" checked><label for="ref_check_n">N</label>
                </td>
            </tr>
            <tr style="display: none;" id="hide_1">
                <th class="required">신청자와의 관계</th>
                <td colspan="3">
                    <input type="text" class="wid250" id="apy_ref" name="apy_ref">
                </td>
            </tr>
            <tr style="display: none;" id="hide_2">
                <th class="required">교육대상자 이름</th>
                <td>
                    <input type="text" class="wid250" id="apy_real_name" name="apy_real_name">
                </td>
                <th class="required">교육대상자 휴대폰번호</th>
                <td>
                    <input type="text" id="ref_mob_1" name="ref_mob_1" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" id="ref_mob_2" name="ref_mob_2" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" id="ref_mob_3" name="ref_mob_3" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    <br/><br/>
                    <input type="checkbox" id="same_mob_no"><label for="same_mob_no" class="mgb20">신청자와 동일</label>
                </td>
            </tr>
            <tr>
                <th>코로나19<br/>백신접종여부</th>
                <td colspan="3">
                    <input type="radio" name="vaccine_yn" id="vaccine_n" value="N" checked><label for="vaccine_n">미접종</label>
                    <input type="radio" name="vaccine_yn" id="vaccine_y" value="Y"><label for="vaccine_y">접종 / 접종일</label>
                    <input type="text" id="vaccine_dt" name="vaccine_dt" class="wid100" disabled>
                    <a href="javascript:showCalendar('vaccine_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>학생</th>
                <td>
                    <select id="student_type" name="student_type" title="학생타입">
                        <option value="">선택</option>
                        <option value="유치원">유치원</option>
                        <option value="초등학생">초등학생</option>
                        <option value="중학생">중학생</option>
                        <option value="고등학생">고등학생</option>
                    </select>
                </td>
                <th>학년</th>
                <td>
                    <select id="student_grade" name="student_grade" title="학년">
                        <option value="">선택</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <input type="text" id="postcode" name="postcode"><a href="#none" class="btn sml grey" onclick="sample4_execDaumPostcode();">우편번호</a><br>
                    <input type="text" class="wid350 mgt10" id="apy_addr1" name="apy_addr1">
                    <input type="text" class="wid350 mgt10" id="apy_addr2" name="apy_addr2">
                </td>
            </tr>
            <tr>
                <th class="required">신청방법</th>
                <td>
                    <input type="radio" name="apy_method" id="apy_method_2" value="2"><label for="apy_method_2">방문</label>
                    <input type="radio" name="apy_method" id="apy_method_3" value="3"><label for="apy_method_3">전화</label>
                </td>
                <th>신청일</th>
                <td>
                    <input type="text" id="reg_dt" name="reg_dt" class="wid100">
                    <a href="javascript:showCalendar('reg_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>신청상태</th>
                <td>
                    <select id="apy_status" name="apy_status" title="신청상태">
                        <option value="1">신청</option>
                        <option value="2">대기신청</option>
                        <option value="3">신청취소</option>
                    </select>
                </td>
                <th class="required">승인여부</th>
                <td>
                    <select id="appv_cd" name="appv_cd" title="승인여부">
                        <option value="1">승인</option>
                        <option value="2">미승인</option>
                        <option value="3">승인취소</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>결제금액</th>
                <td colspan="3" id="real_pay">
                    ${lectureVo.fee}원
                </td>
                <input type="hidden" name="pay_sum" id="pay_sum" />
            </tr>
            <tr>
                <th>감면여부</th>
                <td colspan="3">
                    <input type="radio" name="discount_yn" id="discount_yn_n" value="N" checked><label for="discount_yn_n">해당없음</label>
                    <input type="radio" name="discount_yn" id="discount_yn_y" value="Y"><label for="discount_yn_y">감면대상</label>
                    <a href="#none" class="btn sml blue" onclick="pop_discount_select()" >선택</a>
                    <input type="hidden" name="discount_idx" id="discount_idx" />
                    <input type="hidden" name="discount_rate" id="discount_rate" />
                </td>
            </tr>
            <tr>
                <th>결제일자</th>
                <td>
                    <input type="text" id="pay_dt" name="pay_dt" class="wid100">
                    <a href="javascript:showCalendar('pay_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
                <th>결제상태</th>
                <td>
                    <select id="pay_status" name="pay_status" title="결제상태">
                        <option value="1">입금대기</option>
                        <option value="2">결제완료</option>
                        <option value="3">결제취소</option>
                        <option value="4">환불신청</option>
                        <option value="5">환불처리</option>
                    </select>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/lecture/apply_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">등록</a>
            </div>
        </div>
    </article>
</div>
