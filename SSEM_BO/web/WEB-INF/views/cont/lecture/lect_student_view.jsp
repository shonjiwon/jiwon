<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:17
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
        $('#allCheck_Y').click(function(){
            if ($("#allCheck_Y").is(":checked")) {
                $('input:checkbox[name=apply_id]').prop("checked", true);
            } else {
                $('input:checkbox[name=apply_id]').prop("checked", false);
            }
        });

        $('input:checkbox[name=apply_id]').on("click", function(){
            let chk = true;
            $('input:checkbox[name=apply_id]').each(function(){
                if (!$(this).is(":checked")) {
                    chk = false;
                }
            });
            $('#allCheck_Y').prop("checked", chk);
        });

        $("#btn_complete").click(function(){
            let checkCnt = $("input[name=apply_id]:checked").size();
            if(checkCnt == 0){
                alert("교육생을 선택해 주세요.");
                return false;
            }

            if(confirm("선택한 데이터를 수료처리 하시겠습니까?.")) {
                let data = $("#mainfrm").serialize();
                $.ajax({
                    url: '/ssemadmin/ajax/completed_setting.do',
                    type: 'POST',
                    dataType: 'json',
                    data: data,
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("수료 처리에 실패하였습니다.");
                        } else {
                            alert("수료 처리하였습니다.");
                            location.href = "?lecture_idx=${lectureVo.lecture_idx}&page=1";
                        }
                    }
                });
            }
        });

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
                        document.location.href="/ssemadmin/cont/excel/lect_student_view_excel.do?" + param;
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
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>교육생현황</h3>
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
                <a href="#none" class="btn sml blue" id="btn_complete">수료</a>
            </div>
        </div>
        <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/lect_student_view.do?lecture_idx=${lectureVo.lecture_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal7" id="searchVal7" value="${lectureVo.lecture_idx}"/> <%-- 프로그램 일련번호 --%>
            <input type="hidden" name="searchVal10" id="searchVal10"/> <%-- 프로그램 일련번호 --%>
            <input type="hidden" name="lecture_idx" id="lecture_idx" value="${lectureVo.lecture_idx}"/> <%-- 프로그램 일련번호 --%>
        </form>
        <form id="mainfrm" name="mainfrm">
        <table>
            <colgroup>
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" name="allCheck_Y" id="allCheck_Y"></th>
                <th>번호</th>
                <th>신청번호</th>
                <th>이름</th>
                <th>대리여부</th>
                <th>생년월일</th>
                <th>성별</th>
                <th>휴대폰번호</th>
                <th>신청방법</th>
                <th>등록일</th>
                <th>수료여부</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="11">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><input type="checkbox" name="apply_id" id="apply_id_${item.lecture_apy_idx}" value="${item.lecture_apy_idx}"></td>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>SSEM-${item.lecture_apy_idx}</td>
                    <c:choose>
                        <c:when test="${item.apy_ref ne null && item.apy_ref ne ''}">
                            <td><a href="/ssemadmin/cont/lecture/lect_student_detail.do?lecture_apy_idx=${item.lecture_apy_idx}">${item.apy_real_name}</a></td>
                            <td>Y</td>
                        </c:when>
                        <c:otherwise>
                            <td><a href="/ssemadmin/cont/lecture/lect_student_detail.do?lecture_apy_idx=${item.lecture_apy_idx}">${item.apy_name}</a></td>
                            <td>N</td>
                        </c:otherwise>
                    </c:choose>
                    <td>${item.apy_birth}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.apy_gender eq 'M'}">남</c:when>
                            <c:when test="${item.apy_gender eq 'F'}">여</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.apy_mob_no}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.apy_method eq '1'}">온라인</c:when>
                            <c:when test="${item.apy_method eq '2'}">방문</c:when>
                            <c:when test="${item.apy_method eq '3'}">전화</c:when>
                        </c:choose>
                    </td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.cpl_yn eq 'Y'}">수료</c:when>
                            <c:otherwise>미수료</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">

            </div>
            <div class="right">
                <%--<a href="/ssemadmin/cont/lecture/lect_student_list.do" class="btn">목록</a>--%>
            </div>
        </div>
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
                    <input type="hidden" name="level3" id="level3" value="교육생현황"/>
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
