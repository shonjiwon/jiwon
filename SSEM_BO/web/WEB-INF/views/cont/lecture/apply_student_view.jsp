<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:12
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

        $("input:radio[name=vaccine_yn]").click(function(){
            if($("input:radio[name=vaccine_yn]:checked").val()=='Y'){
                $("#vaccine_dt").attr("disabled", false);
            }else{
                $("#vaccine_dt").attr("disabled", true);
            }
        });

        var vaccine_yn = '${lectureApyVo.vaccine_yn}';
        if(vaccine_yn === 'N' || vaccine_yn === '') {
            $("#vaccine_dt").attr("disabled", true);
            $("#vaccine_n").attr("checked", true);
        }

        $('#btn_update').click(function() {
            $("#frm_update").submit();
        });

        var student_type = '${lectureApyVo.student_type}';
        var student_grade = '${lectureApyVo.student_grade}';

        if(student_type === '초등학생') {
            $('#student_grade').children().remove();
            var html = '';
            html +='<option value="">선택</option>';
            if(student_grade === '1학년') { html +='<option value="1학년" selected>1학년</option>'; } else { html +='<option value="1학년">1학년</option>'; }
            if(student_grade === '2학년') { html +='<option value="2학년" selected>2학년</option>'; } else { html +='<option value="2학년">2학년</option>'; }
            if(student_grade === '3학년') { html +='<option value="3학년" selected>3학년</option>'; } else { html +='<option value="3학년">3학년</option>'; }
            if(student_grade === '4학년') { html +='<option value="4학년" selected>4학년</option>'; } else { html +='<option value="4학년">4학년</option>'; }
            if(student_grade === '5학년') { html +='<option value="5학년" selected>5학년</option>'; } else { html +='<option value="5학년">5학년</option>'; }
            if(student_grade === '6학년') { html +='<option value="6학년" selected>6학년</option>'; } else { html +='<option value="6학년">6학년</option>'; }
            $('#student_grade').append(html); //항목 추가

        } else if(student_type === '중학생' || student_type === '고등학생') {
            $('#student_grade').children().remove();
            var html = '';
            html +='<option value="">선택</option>';
            if(student_grade === '1학년') { html +='<option value="1학년" selected>1학년</option>'; } else { html +='<option value="1학년">1학년</option>'; }
            if(student_grade === '2학년') { html +='<option value="2학년" selected>2학년</option>'; } else { html +='<option value="2학년">2학년</option>'; }
            if(student_grade === '3학년') { html +='<option value="3학년" selected>3학년</option>'; } else { html +='<option value="3학년">3학년</option>'; }
            $('#student_grade').append(html); //항목 추가
        } else {
            $('#student_grade').children().remove();
            var html = '';
            html +='<option value="">선택</option>';
            $('#student_grade').append(html); //항목 추가
        }

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
    <form name="frm_update" id="frm_update" method="post" action="/ssemadmin/cont/lecture/apply_student_update.do" enctype="multipart/form-data">
        <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
        <input type="hidden" name="lecture_idx" value="${lectureApyVo.lecture_idx}"/>
        <input type="hidden" name="group_idx" value="${lectureApyVo.group_idx}"/>
        <input type="hidden" name="apy_id" value="${lectureApyVo.apy_id}"/>
        <input type="hidden" name="apy_name" value="${lectureApyVo.apy_name}"/>
        <input type="hidden" name="apy_mob_no" value="${lectureApyVo.apy_mob_no}"/>
        <input type="hidden" name="apy_gender" value="${lectureApyVo.apy_gender}"/>
        <input type="hidden" name="apy_birth" value="${lectureApyVo.apy_birth}"/>
        <input type="hidden" name="apy_ref" value="${lectureApyVo.apy_ref}"/>
        <input type="hidden" name="apy_real_name" value="${lectureApyVo.apy_real_name}"/>
        <input type="hidden" name="apy_ref_mob_no" value="${lectureApyVo.apy_ref_mob_no}"/>
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
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>신청번호</th>
                <td colspan="3">SSEM-${lectureApyVo.lecture_apy_idx}</td>
            </tr>
            <tr>
                <th>성명/대리신청자</th>
                <td>${lectureApyVo.apy_name}
                    <c:if test="${lectureApyVo.apy_id ne null}">(${lectureApyVo.apy_id})</c:if>
                </td>
                <th>생년월일</th>
                <td>${lectureApyVo.apy_birth}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureApyVo.apy_gender eq 'M'}">남</c:when>
                        <c:when test="${lectureApyVo.apy_gender eq 'F'}">여</c:when>
                    </c:choose>
                </td>
                <th>휴대폰번호</th>
                <td>${lectureApyVo.apy_mob_no}</td>
            </tr>
            <tr>
                <th>코로나19<br/>백신접종여부</th>
                <td colspan="3">
                    <input type="radio" name="vaccine_yn" id="vaccine_n" value="N" <c:if test="${lectureApyVo.vaccine_yn eq 'N'}">checked</c:if>><label for="vaccine_n">미접종</label>
                    <input type="radio" name="vaccine_yn" id="vaccine_y" value="Y" <c:if test="${lectureApyVo.vaccine_yn eq 'Y'}">checked</c:if>><label for="vaccine_y">접종</label>
                    <input type="text" id="vaccine_dt" name="vaccine_dt" class="wid100" value="${lectureApyVo.vaccine_dt}">
                    <a href="javascript:showCalendar('vaccine_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </td>
            </tr>
            <tr>
                <th>학생</th>
                <td>
                    <select id="student_type" name="student_type" title="학생타입">
                        <option value="">선택</option>
                        <option value="유치원" <c:if test="${lectureApyVo.student_type eq '유치원'}">selected="selected"</c:if>>유치원</option>
                        <option value="초등학생" <c:if test="${lectureApyVo.student_type eq '초등학생'}">selected="selected"</c:if>>초등학생</option>
                        <option value="중학생" <c:if test="${lectureApyVo.student_type eq '중학생'}">selected="selected"</c:if>>중학생</option>
                        <option value="고등학생" <c:if test="${lectureApyVo.student_type eq '고등학생'}">selected="selected"</c:if>>고등학생</option>
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
                    <input type="text" id="postcode" name="postcode" value="${lectureApyVo.postcode}"><a href="#none" class="btn sml grey" onclick="sample4_execDaumPostcode();">우편번호</a><br>
                    <input type="text" class="wid350 mgt10" value="${lectureApyVo.apy_addr1}" id="apy_addr1" name="apy_addr1">
                    <input type="text" class="wid350 mgt10" value="${lectureApyVo.apy_addr2}" id="apy_addr2" name="apy_addr2">
                </td>
            </tr>
            <tr>
                <th>관심회원</th>
                <td colspan="3">없음 <a href="#none" class="btn sml orange">등록</a></td>
            </tr>
            <c:if test="${lectureApyVo.apy_ref ne null && lectureApyVo.apy_ref ne ''}">
            <tr>
                <th>대리여부</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${lectureApyVo.apy_ref ne null}">Y</c:when>
                        <c:otherwise>N</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>신청자와의관계</th>
                <td colspan="3">${lectureApyVo.apy_ref}</td>
            </tr>
            <tr>
                <th>교육대상자 이름</th>
                <td>${lectureApyVo.apy_real_name}</td>
                <th>신청자 휴대폰번호</th>
                <td>
                        ${lectureApyVo.apy_ref_mob_no}
                    <c:if test="${lectureApyVo.apy_ref_mob_no eq lectureApyVo.apy_mob_no}">(신청자와 동일)</c:if>
                </td>
            </tr>
            </c:if>
            </tbody>
        </table>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>접수정보</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>신청방법</th>
                <td>
                    <c:choose>
                        <c:when test="${lectureApyVo.apy_method eq '1'}">온라인</c:when>
                        <c:when test="${lectureApyVo.apy_method eq '2'}">방문</c:when>
                        <c:when test="${lectureApyVo.apy_method eq '3'}">전화</c:when>
                    </c:choose>
                </td>
                <th>신청일</th>
                <td>${lectureApyVo.reg_dt}</td>
            </tr>
            <tr>
                <th>신청상태</th>
                <td>
                    <select id="apy_status" name="apy_status" title="신청상태">
                        <option value="1" <c:if test="${lectureApyVo.apy_status eq '1'}">selected="selected"</c:if>>신청</option>
                        <option value="2" <c:if test="${lectureApyVo.apy_status eq '2'}">selected="selected"</c:if>>대기신청</option>
                        <option value="3" <c:if test="${lectureApyVo.apy_status eq '3'}">selected="selected"</c:if>>신청취소</option>
                    </select>
                </td>
                <th>승인여부</th>
                <td>
                    <select id="appv_cd" name="appv_cd" title="승인여부">
                        <option value="1" <c:if test="${lectureApyVo.appv_cd eq '1'}">selected="selected"</c:if>>승인</option>
                        <option value="2" <c:if test="${lectureApyVo.appv_cd eq '2'}">selected="selected"</c:if>>미승인</option>
                        <option value="3" <c:if test="${lectureApyVo.appv_cd eq '3'}">selected="selected"</c:if>>승인취소</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>결제금액</th>
                <td><fmt:formatNumber value="${lectureApyVo.pay_sum}" pattern="##,###"/>원</td>
                <th>감면여부</th>
                <td>
                    ${discountVo.rate}%<br />${discountVo.tgt_name}
                        <c:if test="${discountVo.dtl_txt ne null}">(${discountVo.dtl_txt})</c:if>
                </td>
            </tr>
            <tr>
                <c:choose>
                    <c:when test="${lectureApyVo.pay_status ne '6'}">
                        <th>결제일자</th>
                        <td>${fn:substring(lectureApyVo.pay_dt, 0, 16)}</td>
                    </c:when>
                    <c:otherwise>
                        <th>신청취소일자</th>
                        <td>${fn:substring(lectureApyVo.up_dt, 0, 16)}</td>
                    </c:otherwise>
                </c:choose>
                <th>결제상태</th>
                <td>
                    <select id="pay_status" name="pay_status" title="결제상태">
                        <option value="1" <c:if test="${lectureApyVo.pay_status eq '1'}">selected="selected"</c:if>>입금대기</option>
                        <option value="2" <c:if test="${lectureApyVo.pay_status eq '2'}">selected="selected"</c:if>>결제완료</option>
                        <option value="3" <c:if test="${lectureApyVo.pay_status eq '3'}">selected="selected"</c:if>>결제취소</option>
                        <option value="4" <c:if test="${lectureApyVo.pay_status eq '4'}">selected="selected"</c:if>>환불신청</option>
                        <option value="5" <c:if test="${lectureApyVo.pay_status eq '5'}">selected="selected"</c:if>>환불처리</option>
                        <option value="6" <c:if test="${lectureApyVo.pay_status eq '6'}">selected="selected"</c:if>>무료</option>
                    </select>
                </td>
            </tr>
            <c:if test="${lectureApyVo.pay_cancel_dt ne null}">
            <tr>
                <th class="co_red">결제취소일자</th>
                <td class="co_red" colspan="3">${fn:substring(lectureApyVo.pay_cancel_dt, 0, 16)}</td>
            </tr>
            </c:if>
            <c:if test="${lectureApyVo.pay_status eq '4' || lectureApyVo.pay_status eq '5'}">
            <tr>
                <th class="co_red">환불정보</th>
                <td class="co_red" colspan="3">${lectureApyVo.refund_cont}</td>
            </tr>
            <tr>
                <th>환불신청일자</th>
                <td>${fn:substring(lectureApyVo.refund_dt, 0, 16)}</td>
                <th>환불처리일자</th>
                <td>${fn:substring(lectureApyVo.refund_ok_dt, 0, 16)}</td>
            </tr>
            </c:if>
            </tbody>
        </table>
    </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>수강이력</h3>
            </div>
            <div class="right">

            </div>
        </div>
        <%--<div class="btnArea mgt0 mgb10">
            <div class="left">
                총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>--%>
        <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/apply_student_view.do?lecture_apy_idx=${lectureApyVo.lecture_apy_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal7" id="searchVal7" value="${lectureApyVo.lecture_apy_idx}"/> <%-- 프로그램신청 일련번호 --%>
        <table>
            <colgroup>
                <col style="width:5rem">
                <col style="width:10rem">
                <col style="width:13rem">
                <col>
                <col style="width:17rem">
                <col style="width:10rem">
                <col style="width:8rem">
                <col style="width:10rem">
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>홈페이지</th>
                <th>교육기관</th>
                <th>프로그램명</th>
                <th>교육기간</th>
                <th>신청방법</th>
                <th>강좌상태</th>
                <th>결제금액</th>
                <th>감면여부</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="13">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.lectureVo.gubun eq 'J'}">미래교육</c:when>
                            <c:when test="${item.lectureVo.gubun eq 'S'}">평생교육</c:when>
                        </c:choose>
                    </td>
                    <td>${item.grp_name}</td>
                    <td class="ta_l">${item.lectureVo.name}</td>
                    <td>${item.lectureVo.start_dt} ~ ${item.lectureVo.end_dt}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.apy_method eq '1'}">온라인</c:when>
                            <c:when test="${item.apy_method eq '2'}">방문</c:when>
                            <c:when test="${item.apy_method eq '3'}">전화</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.lectureVo.status_code eq '1'}">접수대기</c:when>
                            <c:when test="${item.lectureVo.status_code eq '2'}">신청가능</c:when>
                            <c:when test="${item.lectureVo.status_code eq '3'}">대기신청</c:when>
                            <c:when test="${item.lectureVo.status_code eq '4'}">신청마감</c:when>
                            <c:when test="${item.lectureVo.status_code eq '5'}">교육전</c:when>
                            <c:when test="${item.lectureVo.status_code eq '6'}">교육중</c:when>
                            <c:when test="${item.lectureVo.status_code eq '7'}">교육종료</c:when>
                        </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${item.pay_sum}" pattern="##,###"/>원</td>
                    <td>
                        <c:if test="${item.discountVo ne null}">${item.discountVo.rate}%</c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/lecture/apply_view.do?lecture_idx=${lectureApyVo.lecture_idx}" class="btn">접수현황목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
