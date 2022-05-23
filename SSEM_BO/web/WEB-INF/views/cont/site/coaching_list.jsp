<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 6:43
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
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/site/coaching_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label>설문기간</label>
                    <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                    <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                    <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </div>
                <div class="formCont">
                    <label for="searchVal">과목 또는 제목 입력</label>
                    <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid300" value="${searchVal}">
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
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:10%">
                <col>
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:8%">
                <col style="width:8%">
                <col style="width:8%">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>과목</th>
                <th>제목</th>
                <th>운영요일</th>
                <th>운영시간</th>
                <th>입장</th>
                <th>작성자</th>
                <th>등록일</th>
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
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.subject}</td>
                    <td class="ta_l"><a href="/ssemadmin/cont/site/coaching_view.do?coach_idx=${item.coach_idx}">${item.title}</a></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.week_type eq '1'}">월요일</c:when>
                            <c:when test="${item.week_type eq '2'}">화요일</c:when>
                            <c:when test="${item.week_type eq '3'}">수요일</c:when>
                            <c:when test="${item.week_type eq '4'}">목요일</c:when>
                            <c:when test="${item.week_type eq '5'}">금요일</c:when>
                            <c:when test="${item.week_type eq '6'}">토요일</c:when>
                            <c:when test="${item.week_type eq '7'}">일요일</c:when>
                        </c:choose>
                    </td>
                    <td>${item.start_time} ~ ${item.end_time}</td>
                    <td>
                        <a href="${item.url}" target="_blank">입장하기</a>
                    </td>
                    <td>${item.reg_id}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/site/coaching_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
