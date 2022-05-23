<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:00
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/main/popup_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="searchKind">노출위치</label>
                <select id="searchKind" name="searchKind" class="wid150">
                    <option value="">전체</option>
                    <option value="A" <c:if test="${searchKind eq 'A'}">selected="selected"</c:if>>공통</option>
                    <option value="J" <c:if test="${searchKind eq 'J'}">selected="selected"</c:if>>미래교육</option>
                    <option value="S" <c:if test="${searchKind eq 'S'}">selected="selected"</c:if>>평생교육</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchKind2">노출여부</label>
                <select id="searchKind2" name="searchKind2" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchKind2 eq 'Y'}">selected="selected"</c:if>>노출</option>
                    <option value="N" <c:if test="${searchKind2 eq 'N'}">selected="selected"</c:if>>미노출</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal">팝업명 검색</label>
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
                <col style="width:8rem">
                <col style="width:12rem">
                <col>
                <col style="width:30rem">
                <col style="width:10rem">
                <col style="width:10rem">
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>노출순서</th>
                <th>홈페이지</th>
                <th>제목</th>
                <th>노출기간</th>
                <th>등록자</th>
                <th>등록일</th>
                <th>노출상태</th>
            </tr>
            </thead>
            <tbody>
            <form name="ordfrm" id="ordfrm" method="post" action="/ssemadmin/cont/main/popup_ord.do" enctype="multipart/form-data">
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="7">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <tr>
                        <td>
                            <c:if test="${item.use_yn eq 'Y'}">
                                <input type="hidden" class="wid100per ta_c" name="ordList[${status.index}].idx" id="ordList[${status.index}].idx" value="${item.popup_idx}">
                                <input type="text" class="wid100per ta_c" name="ordList[${status.index}].val" id="ordList[${status.index}].val" value="${item.ord}" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.kind eq 'A'}">공통</c:when>
                                <c:when test="${item.kind eq 'J'}">미래교육</c:when>
                                <c:when test="${item.kind eq 'S'}">평생교육</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="ta_l"><a href="/ssemadmin/cont/main/popup_view.do?popup_idx=${item.popup_idx}">${item.name}</a></td>
                        <td>
                                ${item.start_dt} ~ ${item.end_dt}
                        </td>
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
                <a href="#none" class="btn blue" id="btn_ord">노출순서 저장</a>
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/main/popup_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
