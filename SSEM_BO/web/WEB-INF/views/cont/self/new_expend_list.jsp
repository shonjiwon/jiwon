<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-14
  Time: 오전 11:28
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
        $('#searchSDate').daterangepicker({
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
        $('#searchEDate').daterangepicker({
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
                        document.location.href="/ssemadmin/cont/excel/new_expend_list.do?" + param;
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
        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////

        // 엑셀 업로드 /////////////////////////////////////////////////
        var popUpload = $(".popUpload");
        popUpload.click(function() {

            if($('#searchKind2').val() === '') {
                alert('동을 선택해 주세요');
            } else {
                $('#group_idx_upload').val($('#searchKind2').val());
                $(".pop_upload").addClass('on')
            }
        });

        $('#btn_pop_close_upload').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_add_isnert').click(function() {
            if($('#attfile').val() !== '') {
                $("#frm_excel").submit();
            } else {
                alert("파일을 선택해 주세요.");
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/self/new_expend_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal10" id="searchVal10" />
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="searchSDate">지출일자</label>
                <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                ~
                <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                <select id="searchKind" name="searchKind" class="wid150">
                    <option value="">구분전체</option>
                    <c:forEach items="${codeList}" var="code" varStatus="status">
                        <option value="${code.code_idx}" <c:if test="${code.code_idx eq searchKind}">selected="selected"</c:if>>${code.cd_val}</option>
                    </c:forEach>
                </select>
                <c:choose>
                    <c:when test="${adminLoginVo.type eq 'S'}">
                        <select id="searchKind2" name="searchKind2" class="wid150">
                            <option value="">전체</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.group_idx}" <c:if test="${searchKind2 eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select id="searchKind2" name="searchKind2" class="wid150" disabled>
                            <option value="">전체</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.group_idx}" <c:if test="${adminLoginVo.group_idx eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="formCont">
                <label for="searchSDate">이름</label>
                <input type="text" placeholder="검색어 입력" class="wid200" id="searchVal" name="searchVal" value="${searchVal}">
                <a href="#none" class="btn orange" id="btn_search">검색</a>
            </div>
        </div>
    </article>
    </form>

    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn sml grey popUpload" id="pop_upload">일괄 엑셀업로드</a>
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
                <a href="/ssemadmin/cont/self/new_expend_inscr.do" class="btn sml red">등록</a>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:4%">
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:10%">
                <col>
                <col style="width:12%">
                <col style="width:12%">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>동별</th>
                <th>지출일자</th>
                <th>구분</th>
                <th>지출액</th>
                <th>이름</th>
                <th>내역</th>
                <th>지출결의서</th>
                <th>수정/신규</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="9">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.dong_nm}</td>
                    <td>${item.standard_date}</td>
                    <td>${item.inout_cd_nm}</td>
                    <td><fmt:formatNumber value="${item.inout_cost}" pattern="##,###"/></td>
                    <td>${item.inout_nm}</td>
                    <td><a href="/ssemadmin/cont/self/new_expend_view.do?inout_seq=${item.inout_seq}">${item.e_note}</a></td>
                    <td><a href="/ssemadmin/cont/excel/new_expend_report.do?inout_seq=${item.inout_seq}" class="btn sml grey">지출결의서</a></td>
                    <td>
                        <a href="/ssemadmin/cont/self/new_expend_view.do?inout_seq=${item.inout_seq}" class="btn sml grey">수정</a>
                        <a href="/ssemadmin/cont/self/new_expend_copy.do?inout_seq=${item.inout_seq}" class="btn sml grey">신규</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
    </article>
</div>

<section class="popArea pop_upload">
    <div class="popBody" style="width: 100rem !important;">
        <div class="tit">
            <h2>지출 등록 정보 일괄 업로드</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_excel" id="frm_excel" method="post" action="/ssemadmin/cont/excel/new_expend_excel_upload.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" id="group_idx_upload"/>
                    <div>
                        <span class="co_red">*정보를 엑셀파일을 이용하여 업로드 합니다.</span>
                        <a href="/ssemadmin/resources/download/expend_upload.xls" class="btn grey">양식다운로드</a>
                    </div>
                    <div>
                        <span class="co_blue">* 프로그램 일련번호 확인 방법 : 통합프로그램관리 > 프로그램관리 메뉴에서 프로그램 조회 > 일련번호 확인</span>
                        <a href="/ssemadmin/cont/lecture/lecture_list.do" class="btn grey">바로가기</a>
                    </div>
                    <br/>
                    <table>
                        <colgroup>
                            <col style="width:20rem">
                            <col>
                        </colgroup>
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <th class="required">업로드 파일 선택</th>
                            <td class="ta_l">
                                <input type="file" name="attfile" id="attfile" class="wid350" />
                                (파일형식: xls, xlsx )
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey" id="btn_add_isnert">등록</a>
                        <a href="#none" class="btn red" id="btn_pop_close_upload">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>

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
