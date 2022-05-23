<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:25
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
                        document.location.href="/ssemadmin/cont/excel/instrum_donation_list_excel.do?" + param;
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

    function goSearch() {
        let frm = document.frm;

        if(frm.searchSDate.value > frm.searchEDate.value) {
            modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
            return false;
        }

        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/instrum_donation_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal10" id="searchVal10" />
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="searchKind2">악기유형</label>
                    <select id="searchKind2" name="searchKind2" class="wid150">
                        <option value="">전체</option>
                        <option value="A" <c:if test="${searchKind2 eq 'A'}">selected="selected"</c:if>>건반악기</option>
                        <option value="B" <c:if test="${searchKind2 eq 'B'}">selected="selected"</c:if>>관악기</option>
                        <option value="C" <c:if test="${searchKind2 eq 'C'}">selected="selected"</c:if>>타악기</option>
                        <option value="D" <c:if test="${searchKind2 eq 'D'}">selected="selected"</c:if>>현악기</option>
                        <option value="E" <c:if test="${searchKind2 eq 'E'}">selected="selected"</c:if>>MIDI장비</option>
                        <option value="K" <c:if test="${searchKind2 eq 'K'}">selected="selected"</c:if>>국악기</option>
                        <option value="Z" <c:if test="${searchKind2 eq 'Z'}">selected="selected"</c:if>>기타</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchKind3">상태</label>
                    <select id="searchKind3" name="searchKind3" class="wid150">
                        <option value="">전체</option>
                        <option value="A" <c:if test="${searchKind3 eq 'A'}">selected="selected"</c:if>>기증신청</option>
                        <option value="R" <c:if test="${searchKind3 eq 'R'}">selected="selected"</c:if>>기증확인</option>
                        <option value="O" <c:if test="${searchKind3 eq 'O'}">selected="selected"</c:if>>기증완료</option>
                        <option value="C" <c:if test="${searchKind3 eq 'C'}">selected="selected"</c:if>>기증취소</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal2">일자검색</label>
                    <select id="searchVal2" name="searchVal2" class="wid150">
                        <option value="ALL">전체</option>
                        <option value="1" <c:if test="${searchVal2 eq '1'}">selected="selected"</c:if>>신청일</option>
                        <option value="2" <c:if test="${searchVal2 eq '2'}">selected="selected"</c:if>>최종수정일</option>
                    </select>
                    <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                    <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                    <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <select id="searchKind" name="searchKind" class="wid150">
                        <option value="ALL">전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>악기명</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>아이디</option>
                        <option value="3" <c:if test="${searchKind eq '3'}">selected="selected"</c:if>>이름</option>
                    </select>
                    <input type="text" name="searchVal" id="searchVal" value="${searchVal}" title="검색어 입력" class="wid350">
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <div class="totalNum">
                    총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                </div>
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:10%">
                <col>
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:8%">
                <col style="width:10%">
                <col style="width:8%">
            </colgroup>
            <thead>
            <th>번호</th>
            <th>악기유형</th>
            <th>악기명</th>
            <th>아이디</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>신청일</th>
            <th>상태</th>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="8">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.gubun eq 'A'}">건반악기</c:when>
                            <c:when test="${item.gubun eq 'B'}">관악기</c:when>
                            <c:when test="${item.gubun eq 'C'}">타악기</c:when>
                            <c:when test="${item.gubun eq 'D'}">현악기</c:when>
                            <c:when test="${item.gubun eq 'E'}">MIDI장비</c:when>
                            <c:when test="${item.gubun eq 'K'}">국악기</c:when>
                            <c:when test="${item.gubun eq 'Z'}">기타</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="ta_l">${item.instrum_name}</td>
                    <td>${item.dnt_id}</td>
                    <td><a href="/ssemadmin/cont/campus/instrum_donation_view.do?instrum_dnt_idx=${item.instrum_dnt_idx}">${item.dnt_name}</a></td>
                    <td>${item.dnt_mob_no}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status eq 'A'}">기증신청</c:when>
                            <c:when test="${item.status eq 'R'}">기증확인</c:when>
                            <c:when test="${item.status eq 'O'}">기증완료</c:when>
                            <c:when test="${item.status eq 'S'}">기증취소</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="right">
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
