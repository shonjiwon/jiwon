<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-20
  Time: 오전 5:30
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/club/club_status_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="searchKind">분야 선택</label>
                <select id="searchKind" name="searchKind">
                    <option value="">전체</option>
                    <c:forEach items="${codeList}" var="item" varStatus="status">
                        <option value="${item.code_idx}" <c:if test="${item.code_idx eq searchKind}">selected="selected"</c:if>>${item.cd_val}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal">동아리명</label>
                <input type="text" name="searchVal" id="searchVal" value="${searchVal}" title="동아리명 입력" placeholder="동아리명 입력" class="wid350">
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
        </div>
        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:15%">
                <col>
                <col style="width:10%">
                <col style="width:10%">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>분야</th>
                <th>동아리명</th>
                <th>등록자</th>
                <th>등록일</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="5">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.code_nm}</td>
                    <td class="ta_l"><a href="/ssemadmin/cont/club/club_status_view.do?club_status_idx=${item.club_status_idx}">${item.name}</a></td>
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
                <a href="/ssemadmin/cont/club/club_status_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
