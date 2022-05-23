<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:05
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
        // 전화번호 검색어
        var mob_no = '${searchVal8}';
        if(mob_no !== '') {
            var jbSplit = mob_no.split('-');
            $("#mob_1").val(jbSplit[0]);
            $("#mob_2").val(jbSplit[1]);
            $("#mob_3").val(jbSplit[2]);
        }

        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${searchVal2}';
        let group_idx = '${searchVal3}';
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
                        document.location.href="/ssemadmin/cont/excel/teacher_list_excel.do?" + param;
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

        $("select[id=p_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            $("#page").val("1");
        });

        $("select[id=group_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            $("#page").val("1");
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        var mob_no = '';

        var mob_1 = $("#mob_1").val();
        var mob_2 = $("#mob_2").val();
        var mob_3 = $("#mob_3").val();

        if(mob_1 !== '') {
            mob_no += mob_1 + "-";
        }

        if(mob_2 !== '') {
            mob_no += mob_2 + "-";
        }

        if(mob_3 !== '') {
            mob_no += mob_3;
        }

        $('#searchVal8').val(mob_no);

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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/teacher_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
        <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
        <input type="hidden" name="searchVal8" id="searchVal8" value="${searchVal8}"/> <%-- 휴대폰번호 --%>
        <input type="hidden" name="searchVal10" id="searchVal10" /> <%-- 휴대폰번호 --%>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="p_idx">소속</label>
                    <select id="p_idx" name="p_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                        <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                            <option value="${item.group_idx}" <c:if test="${item.group_idx eq searchVal2}">selected="selected"</c:if>>${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <label for="group_idx">교육기관</label>
                    <select id="group_idx" name="group_idx" class="wid200" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal4">교육분야</label>
                    <select id="searchVal4" name="searchVal4" class="wid150">
                        <option value="">전체</option>
                        <c:forEach items="${codeList}" var="code" varStatus="status">
                            <option value="${code.code_idx}" <c:if test="${searchVal4 eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal5">구분</label>
                    <select id="searchVal5" name="searchVal5" class="wid150">
                        <option value="">전체</option>
                        <option value="N" <c:if test="${searchVal5 eq 'N'}">selected="selected"</c:if>>일반</option>
                        <option value="S" <c:if test="${searchVal5 eq 'S'}">selected="selected"</c:if>>자원봉사자</option>
                    </select>
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="searchVal6">상태</label>
                    <select id="searchVal6" name="searchVal6" class="wid150">
                        <option value="">전체</option>
                        <option value="A" <c:if test="${searchVal6 eq 'A'}">selected="selected"</c:if>>승인</option>
                        <option value="N" <c:if test="${searchVal6 eq 'N'}">selected="selected"</c:if>>미승인</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal7">성별</label>
                    <select id="searchVal7" name="searchVal7" class="wid200">
                        <option value="">전체</option>
                        <option value="M" <c:if test="${searchVal7 eq 'M'}">selected="selected"</c:if>>남</option>
                        <option value="F" <c:if test="${searchVal7 eq 'F'}">selected="selected"</c:if>>여</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="mob_1">휴대폰</label>
                    <input type="text" id="mob_1" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_2" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_3" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="searchKind">기간</label>
                    <select id="searchKind" name="searchKind" class="wid100">
                        <option value="ALL">전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>협약기간</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>등록일</option>
                    </select>
                    <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                    <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                    <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </div>
                <div class="formCont">
                    <label for="searchVal">이름검색</label>
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
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <table>
            <colgroup>
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>소속</th>
                <th>교육기관</th>
                <th>이름</th>
                <th>성별</th>
                <th>휴대폰</th>
                <th>교육분야</th>
                <th>구분</th>
                <th>협약기간</th>
                <th>등록일</th>
                <th>상태</th>
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
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.p_name}</td>
                    <td>${item.grp_name}</td>
                    <td class="ta_l"><a href="/ssemadmin/cont/lecture/teacher_view.do?teacher_idx=${item.teacher_idx}">${item.name}</a></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.gender eq 'M'}">남</c:when>
                            <c:when test="${item.gender eq 'F'}">여</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.mob_no}</td>
                    <td>${item.code_name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.gubun eq 'N'}">일반</c:when>
                            <c:when test="${item.gubun eq 'S'}">자원봉사자</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.start_dt} ~ ${item.end_dt}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status eq 'A'}">승인</c:when>
                            <c:when test="${item.status eq 'N'}">미승인</c:when>
                            <c:otherwise>N</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/lecture/teacher_inscr.do" class="btn grey">등록</a>
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
