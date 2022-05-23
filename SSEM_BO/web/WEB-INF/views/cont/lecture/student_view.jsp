<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 8:20
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
        $('#btn_update').click(function() {
            $("#frm_update").submit();
        });

        // 관심회원 팝업 처리 /////////////////////////////////////////////////////////////////////////////////////
        var popLike = $(".popLike");
        popLike.click(function() {
            $(".pop_like").addClass('on')
        });

        $('.btnClose').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_pop_close_like').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_like_insert').click(function() {
            var frm = document.frm_like;

            if(!fnIsValidRequired(frm.memo, "관심회원 메모")){return false;}

            $("#frm_like").submit();

            $('.popArea').removeClass('on')
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
                        var param = $("#frm").serialize();
                        document.location.href="/ssemadmin/cont/excel/student_view_excel.do?" + param;
                    } else {
                        alert("등록에 실패하였습니다.");
                    }
                }
            });

            $('.popArea').removeClass('on');
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
            <c:choose>
                <c:when test="${studentVo.ref_yn eq 'Y'}">
                    <tr>
                        <th>대리신청자</th>
                        <td>
                            ${studentVo.ref_name}
                        </td>
                        <th>생년월일</th>
                        <td>${studentVo.birth}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>
                            <c:choose>
                                <c:when test="${studentVo.gender eq 'M'}">남</c:when>
                                <c:when test="${studentVo.gender eq 'F'}">여</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <th>휴대폰</th>
                        <td>${studentVo.ref_mob_no}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <th>이름(아이디)</th>
                        <td>
                                ${studentVo.name}
                            <c:if test="${studentVo.user_id ne null}">
                                (${studentVo.user_id})
                            </c:if>
                        </td>
                        <th>생년월일</th>
                        <td>${studentVo.birth}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>
                            <c:choose>
                                <c:when test="${studentVo.gender eq 'M'}">남</c:when>
                                <c:when test="${studentVo.gender eq 'F'}">여</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <th>휴대폰</th>
                        <td>${studentVo.mob_no}</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <c:if test="${studentVo.postcode ne '' && studentVo.postcode ne null}">
                        (${studentVo.postcode}) ${studentVo.addr1} ${studentVo.addr2}
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>관심회원</th>
                <td colspan="3">
                    <a href="#none" class="btn sml grey popLike" id="pop_like">관심회원등록</a> <br/><br/>
                    ${studentVo.memo_html}
                </td>
            </tr>
            <c:if test="${studentVo.ref_yn eq 'Y'}">
                <tr>
                    <th>대리여부</th>
                    <td colspan="3">
                        Y
                    </td>
                </tr>
                <tr>
                    <th>신청대리인 관계</th>
                    <td colspan="3">
                            ${studentVo.ref_rel}
                    </td>
                </tr>
                <tr>
                    <th>교육대상자 이름</th>
                    <td>${studentVo.name}</td>
                    <th>교육대상자 휴대폰</th>
                    <td>
                            ${studentVo.mob_no}
                        <c:if test="${studentVo.ref_mob_no eq studentVo.mob_no}">
                            (신청자와 동일)
                        </c:if>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </article>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>수강이력</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <div class="btnArea mgt0 mgb10">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/student_view.do?student_idx=${studentVo.student_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="student_idx" value="${studentVo.student_idx}"/>
            <input type="hidden" name="searchVal10" id="searchVal10"/>
            <table>
                <colgroup>
                    <col style="width:8rem">
                    <col style="width:20rem">
                    <col>
                    <col style="width:30rem">
                    <col style="width:10rem">
                    <col style="width:8rem">
                    <col style="width:10rem">
                </colgroup>
                <thead>
                <tr>
                    <th>번호</th>
                    <th>교육기관</th>
                    <th>프로그램명</th>
                    <th>교육기간</th>
                    <th>신청방법</th>
                    <th>프로그램상태</th>
                    <th>수료여부</th>
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
                        <td>
                            <c:choose>
                                <c:when test="${item.cpl_yn eq 'Y'}">수료</c:when>
                                <c:when test="${item.cpl_yn eq 'N'}">미수료</c:when>
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
                <a href="/ssemadmin/cont/lecture/student_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>

<section class="popArea pop_like">
    <div class="popBody">
        <div class="tit">
            <h2>관심회원등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_like" id="frm_like" method="post" action="/ssemadmin/cont/lecture/student_like_insert.do" enctype="multipart/form-data">
                    <input type="hidden" name="student_idx" id="student_idx" value="${studentVo.student_idx}"/>
                <table>
                    <colgroup>
                        <col style="width:10rem">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>이름(아이디)</th>
                        <td class="ta_l">
                            ${studentVo.name}
                            <c:if test="${studentVo.user_id ne null}">
                                (${studentVo.user_id})
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td class="ta_l">${studentVo.birth}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td class="ta_l">
                            <c:choose>
                                <c:when test="${studentVo.gender eq 'M'}">남</c:when>
                                <c:when test="${studentVo.gender eq 'F'}">여</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>휴대폰</th>
                        <td class="ta_l">${studentVo.mob_no}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td class="ta_l">
                            <c:if test="${studentVo.postcode ne '' && studentVo.postcode ne null}">
                                (${studentVo.postcode}) ${studentVo.addr1} ${studentVo.addr2}
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>관심회원메모</th>
                        <td>
                            <textarea rows="5" class="wid100per" name="memo" id="memo">${studentVo.memo}</textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                        <a href="#none" class="btn" id="btn_pop_close_like">취소</a>
                    </div>
                    <div class="right">
                        <a href="#none" class="btn red" id="btn_like_insert">등록</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>

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
                    <input type="hidden" name="level2" id="level2" value="${currentMenu.name}"/>
                    <input type="hidden" name="level3" id="level3" value="수강이력"/>
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
