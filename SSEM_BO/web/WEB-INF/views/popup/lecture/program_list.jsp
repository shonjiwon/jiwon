<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-15
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function(){
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
        /////////////////////////////////////////////////////////////////

        var lecture_idx = "";

        $("input[type=radio]").change(function() {
            lecture_idx = $(this).val();
        });

        $("#btn_select").click(function(){
            if(lecture_idx !== "") {
                $("#lecture_idx").val(lecture_idx);
                $("#frm_update").submit();
            } else {
                alert("프로그램을 선택해 주세요.");
            }
        });
    });

    function goSearch() {
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<form name="frm_update" id="frm_update" action="/ssemadmin/cont/lecture/teacher_program_update.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="lecture_idx" id="lecture_idx"/>
    <input type="hidden" name="teacher_idx" id="teacher_idx" value="${searchVal9}"/>
</form>
<section class="wrap pop">
    <div class="container">
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/lecture/program_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
            <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
            <input type="hidden" name="searchVal9" id="searchVal9" value="${searchVal9}"/> <%-- 부서 --%>
        <article class="contUnit sch_area">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>프로그램검색</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="p_idx">소속</label>
                    <select id="p_idx" name="p_idx" class="wid150" disabled>
                        <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                            <option value="${item.group_idx}" <c:if test="${item.group_idx eq searchVal2}">selected="selected"</c:if>>${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <label for="group_idx">교육기관</label>
                    <select id="group_idx" name="group_idx" class="wid200" disabled>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchSDate">교육기간</label>
                    <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                    <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                    <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="searchKind">프로그램 상태</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <option value="">전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>접수대기</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>접수중</option>
                        <option value="3" <c:if test="${searchKind eq '3'}">selected="selected"</c:if>>접수마감</option>
                        <option value="4" <c:if test="${searchKind eq '4'}">selected="selected"</c:if>>교육전</option>
                        <option value="5" <c:if test="${searchKind eq '5'}">selected="selected"</c:if>>교육중</option>
                        <option value="6" <c:if test="${searchKind eq '6'}">selected="selected"</c:if>>교육종료</option>
                        <option value="7" <c:if test="${searchKind eq '7'}">selected="selected"</c:if>>외부홈페이지</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal">프로그램명 검색</label>
                    <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid250" value="${searchVal}">
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
        </form>

        <article class="contUnit tbl_area">
            <table>
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>소속</th>
                    <th>교육기관</th>
                    <th>프로그램명</th>
                    <th>교육기간</th>
                    <th>교육인원</th>
                    <th>프로그램 상태</th>
                </tr>
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
                        <td>
                            <input type="radio" name="program" id="${item.lecture_idx}" value="${item.lecture_idx}" />
                        </td>
                        <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                        <td>${item.p_name}</td>
                        <td>${item.grp_name}</td>
                        <td class="ta_l">${item.name}</td>
                        <td>${item.start_dt} ~ ${item.end_dt}</td>
                        <td>${item.student_qty}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:contains(item.reg_method, '4')}">
                                    외부홈페이지
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${item.status_code eq '1'}">접수대기</c:when>
                                        <c:when test="${item.status_code eq '2'}">신청가능</c:when>
                                        <c:when test="${item.status_code eq '3'}">대기신청</c:when>
                                        <c:when test="${item.status_code eq '4'}">신청마감</c:when>
                                        <c:when test="${item.status_code eq '5'}">교육전</c:when>
                                        <c:when test="${item.status_code eq '6'}">교육중</c:when>
                                        <c:when test="${item.status_code eq '7'}">교육종료</c:when>
                                    </c:choose>
                                </c:otherwise>
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
                    <a href="#none" class="btn red" id="btn_select">프로그램 등록</a>
                    <a href="#none" class="btn grey" onclick="window.close();">닫기</a>
                </div>
            </div>
        </article>
    </div>
</section>
