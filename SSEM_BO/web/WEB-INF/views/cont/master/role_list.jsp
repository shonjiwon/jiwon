<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-13
  Time: 오전 5:03
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
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/master/role_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="searchKind">관리자유형</label>
                <select id="searchKind" name="searchKind" class="wid150">
                    <option value="">전체</option>
                    <option value="S" <c:if test="${searchKind eq 'S'}">selected="selected"</c:if>>마스터관리자</option>
                    <option value="G" <c:if test="${searchKind eq 'G'}">selected="selected"</c:if>>기관관리자</option>
                    <option value="N" <c:if test="${searchKind eq 'N'}">selected="selected"</c:if>>일반관리자</option>
                    <option value="B" <c:if test="${searchKind eq 'B'}">selected="selected"</c:if>>게시판관리자</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchKind2">사용여부</label>
                <select id="searchKind2" name="searchKind2" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchKind2 eq 'Y'}">selected="selected"</c:if>>사용</option>
                    <option value="N" <c:if test="${searchKind2 eq 'N'}">selected="selected"</c:if>>미사용</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal">그룹명</label>
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
                <col style="width:30rem">
                <col>
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>유형</th>
                <th>그룹명</th>
                <th>권한설명</th>
                <th>사용여부</th>
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
                    <td>
                        <c:choose>
                            <c:when test="${item.type eq 'S'}">마스터관리자</c:when>
                            <c:when test="${item.type eq 'G'}">기관관리자</c:when>
                            <c:when test="${item.type eq 'N'}">일반관리자</c:when>
                            <c:when test="${item.type eq 'B'}">게시판관리자</c:when>
                        </c:choose>
                    </td>
                    <td><a href="/ssemadmin/cont/master/role_view.do?admin_rule_idx=${item.admin_rule_idx}">${item.name}</a></td>
                    <td>${item.explain}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.use_yn eq 'Y'}">사용</c:when>
                            <c:when test="${item.use_yn eq 'N'}">미사용</c:when>
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
                <a href="/ssemadmin/cont/master/role_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
