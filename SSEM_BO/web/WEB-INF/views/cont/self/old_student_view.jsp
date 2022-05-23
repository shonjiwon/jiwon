<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
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
                        var param = $("#frm").serialize();
                        document.location.href="/ssemadmin/cont/excel/old_student_view.do?" + param;
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
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/self/old_teacher_mng.do">
        <input type="hidden" name="student_seq" id="student_seq" value="${tracStudentVo.student_seq}"/>
        <input type="hidden" name="searchVal10" id="searchVal10" />
    </form>
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
                <td colspan="3">
                    ${tracStudentVo.dong_cd}
                </td>
            </tr>
            <tr>
                <th class="required">이름</th>
                <td>
                    ${tracStudentVo.student_nm}
                </td>
                <th class="required">성별</th>
                <td>
                    <c:choose>
                        <c:when test="${tracStudentVo.sex eq 'M'}">남</c:when>
                        <c:otherwise>여</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    ${tracStudentVo.student_resino}
                </td>
                <th>이메일</th>
                <td>
                    ${tracStudentVo.email}
                </td>
            </tr>
            <tr>
                <th>휴대폰번호</th>
                <td>
                    ${tracStudentVo.mobile_no}
                </td>
                <th>전화번호</th>
                <td>
                    ${tracStudentVo.tel_no}
                </td>
            </tr>
            <tr>
                <th>감면자 정보</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${tracStudentVo.exemption eq '0'}">없음</c:when>
                        <c:when test="${tracStudentVo.exemption eq '1'}">50%</c:when>
                        <c:when test="${tracStudentVo.exemption eq '2'}">100%</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    (${tracStudentVo.post_no}) ${tracStudentVo.addr} ${tracStudentVo.addr_detail}
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3">
                    ${tracStudentVo.note}
                </td>
            </tr>
            <tr>
                <th>
                    수강이력<br>
                    <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀</a>
                </th>
                <td colspan="3">
                    <table>
                        <colgroup>
                            <col style="width:4%">
                            <col>
                            <col style="width:25%">
                            <col style="width:15%">
                            <col style="width:10%">
                            <col style="width:6%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="ta_c" style="background:#f1f1f1">번호</th>
                            <th class="ta_c" style="background:#f1f1f1">프로그램명</th>
                            <th class="ta_c" style="background:#f1f1f1">수강기간</th>
                            <th class="ta_c" style="background:#f1f1f1">납부일</th>
                            <th class="ta_c" style="background:#f1f1f1">납부금액</th>
                            <th class="ta_c" style="background:#f1f1f1">정산</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${fn:length(itemList) == 0}">
                            <tr>
                                <td colspan="6" class="ta_c">데이터가 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <tr>
                                <td class="ta_c">${status.count}</td>
                                <td class="ta_c">${item.prog_nm}</td>
                                <td class="ta_c">${item.sdate} ~ ${item.edate}</td>
                                <td class="ta_c">${item.standard_date}</td>
                                <td class="ta_r"><fmt:formatNumber value="${item.amount}" pattern="##,###"/></td>
                                <td class="ta_c">
                                    <c:choose>
                                        <c:when test="${item.adj_yn eq 'Y'}">완료</c:when>
                                        <c:when test="${item.adj_yn eq 'N'}">미완료</c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_student_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>

<!-- popup -->
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
                    <input type="hidden" name="level3" id="level3" value="${currentMenu.name}"/>
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
