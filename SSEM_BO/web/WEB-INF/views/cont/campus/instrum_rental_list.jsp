<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:05
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/instrum_rental_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="searchKind2">대관여부</label>
                    <select id="searchKind2" name="searchKind2" class="wid150">
                        <option value="">전체</option>
                        <option value="Y" <c:if test="${searchKind2 eq 'Y'}">selected="selected"</c:if>>Y</option>
                        <option value="N" <c:if test="${searchKind2 eq 'N'}">selected="selected"</c:if>>N</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchKind">검색</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <option value="ALL">전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>시설명</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>이용안내</option>
                    </select>
                    <input type="text" placeholder="검색어 입력" class="wid200" id="searchVal" name="searchVal" value="${searchVal}">
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
                <col style="width:8%;">
                <col style="width:15%;">
                <col>
                <col style="width:10%;">
                <col style="width:10%;">
                <col style="width:8%;">
                <col style="width:20%;">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>시설명</th>
                <th>이용안내</th>
                <th>사이즈 (수용인원)</th>
                <th>대관료</th>
                <th>대관여부</th>
                <th>관리</th>
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
                    <td class="ta_l">
                        <a href="/ssemadmin/cont/campus/instrum_rental_view.do?rental_fty_idx=${item.rental_fty_idx}">${item.name}</a>
                    </td>
                    <td class="ta_l">${item.intro}</td>
                    <td>${item.capacity}</td>
                    <td><fmt:formatNumber value="${item.fee}" pattern="##,###"/></td>
                    <td>${item.use_yn}</td>
                    <td>
                        <a href="/ssemadmin/cont/campus/instrum_rental_calendar.do?rental_fty_idx=${item.rental_fty_idx}" class="btn sml">신청관리</a>
                        <a href="/ssemadmin/cont/campus/instrum_rental_schedule.do?rental_fty_idx=${item.rental_fty_idx}" class="btn sml">일정관리</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="right">
                <a href="/ssemadmin/cont/campus/instrum_rental_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
