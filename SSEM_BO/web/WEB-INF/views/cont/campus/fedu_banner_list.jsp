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
        $("#btn_ord").click(function(){
            $("#ordfrm").submit();
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
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/fedu_banner_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="searchKind2">노출상태</label>
                    <select id="searchKind2" name="searchKind2" class="wid150">
                        <option value="">전체</option>
                        <option value="Y" <c:if test="${searchKind2 eq 'Y'}">selected="selected"</c:if>>노출</option>
                        <option value="N" <c:if test="${searchKind2 eq 'N'}">selected="selected"</c:if>>미노출</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal">배너명 검색</label>
                    <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid300" value="${searchVal}">
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
                <col style="width:10%;">
                <col>
                <col style="width:10%;">
                <col style="width:10%;">
                <col style="width:8%;">
            </colgroup>
            <thead>
            <th>노출순서</th>
            <th>배너명</th>
            <th>등록자</th>
            <th>등록일</th>
            <th>노출상태</th>
            </thead>
            <tbody>
            <form name="ordfrm" id="ordfrm" method="post" action="/ssemadmin/cont/campus/fedu_banner_ord.do" enctype="multipart/form-data">
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="5">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <tr>
                        <td>
                            <c:if test="${item.use_yn eq 'Y'}">
                                <input type="hidden" class="wid100per ta_c" name="ordList[${status.index}].idx" id="ordList[${status.index}].idx" value="${item.banner_idx}">
                                <input type="text" class="wid100per ta_c" name="ordList[${status.index}].val" id="ordList[${status.index}].val" value="${item.ord}" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            </c:if>
                        </td>
                        <td class="ta_l"><a href="/ssemadmin/cont/campus/fedu_banner_view.do?banner_idx=${item.banner_idx}">${item.name}</a></td>
                        <td>${item.reg_id}</td>
                        <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.use_yn eq 'Y'}">노출</c:when>
                                <c:when test="${item.use_yn eq 'N'}">미노출</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </form>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
                <a href="#none" class="btn" id="btn_ord">노출순서 저장</a>
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/campus/fedu_banner_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
