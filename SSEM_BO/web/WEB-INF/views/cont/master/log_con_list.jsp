<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-13
  Time: 오전 5:11
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
                        html += '<option value="">전체</option>';
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
                        html += '<option value="">전체</option>';
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
                        html += '<option value="">전체</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            } else {
                $('#group_idx').children().remove();
                html += '<option value="">전체</option>';
                $('#group_idx').append(html);
            }
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
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/master/log_con_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
        <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="p_idx">소속</label>
                <select id="p_idx" name="p_idx">
                    <option value="">전체</option>
                    <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                        <option value="${item.group_idx}" <c:if test="${item.group_idx eq searchVal2}">selected="selected"</c:if>>${item.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="formCont">
                <label for="group_idx">기관/교육장</label>
                <select id="group_idx" name="group_idx">
                    <option value="">전체</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal4">관리자유형</label>
                <select id="searchVal4" name="searchVal4" class="wid150">
                    <option value="">전체</option>
                    <option value="S" <c:if test="${searchVal4 eq 'S'}">selected="selected"</c:if>>마스터관리자</option>
                    <option value="G" <c:if test="${searchVal4 eq 'G'}">selected="selected"</c:if>>기관관리자</option>
                    <option value="N" <c:if test="${searchVal4 eq 'N'}">selected="selected"</c:if>>일반관리자</option>
                    <option value="B" <c:if test="${searchVal4 eq 'B'}">selected="selected"</c:if>>게시판관리자</option>
                </select>
            </div>
        </div>
        <div class="line">
            <div class="formCont">
                <label>접속일</label>
                <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                ~
                <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
            </div>
            <div class="formCont">
                <label for="searchKind">검색</label>
                <select id="searchKind" name="searchKind" class="wid150">
                    <option value="ALL">전체</option>
                    <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>이름</option>
                    <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>아이디</option>
                </select>
                <input type="text" placeholder="검색어 입력" class="wid350" id="searchVal" name="searchVal" value="${searchVal}">
                <a href="#none" class="btn orange" id="btn_search">검색</a>
            </div>
        </div>
    </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="totalNum">
            총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
        </div>
        <table>
            <colgroup>
                <col style="width:5rem">
                <col style="width:15rem">
                <col style="width:15rem">
                <col style="width:15rem">
                <col>
                <col style="width:15rem">
                <col style="width:15rem">
                <col style="width:15rem">
                <col style="width:15rem">
                <col style="width:15rem">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>소속</th>
                <th>기관/교육장</th>
                <th>관리자유형</th>
                <th>운영체제</th>
                <th>브라우저</th>
                <th>로그인 IP</th>
                <th>접속일시</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="10">등록된 데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.name}</td>
                    <td>${item.admin_id}</td>
                    <td>${item.p_name}</td>
                    <td>${item.grp_name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.type eq 'S'}">마스터관리자</c:when>
                            <c:when test="${item.type eq 'G'}">기관관리자</c:when>
                            <c:when test="${item.type eq 'N'}">일반관리자</c:when>
                            <c:when test="${item.type eq 'B'}">게시판관리자</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        ${item.os}
                    </td>
                    <td>
                        ${item.browser}
                    </td>
                    <td>
                        ${item.ip}
                    </td>
                    <td>${item.login_dt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
    </article>
</div>
