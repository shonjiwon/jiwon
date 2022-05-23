<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-19
  Time: 오후 3:35
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
        var user_id = "";

        $("input[type=radio]").change(function() {
            user_id = $(this).val();
        });

        $("#btn_select").click(function(){
            if(user_id !== "") {
                $(opener.document).find("#user_id").val(user_id);
                window.close();
            } else {
                alert("회원정보를 선택해 주세요.");
            }
        });

        $("#btn_cancel").click(function(){
            $(opener.document).find("#user_id").val("");
            window.close();
        });
    });

    function goSearch() {
        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<section class="wrap pop">
    <div class="container">
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/user/user_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <article class="contUnit sch_area">
                <div class="btnArea mgt0 mgb10 of_h">
                    <div class="left">
                        <h3>강사선택</h3>
                    </div>
                    <div class="right">
                    </div>
                </div>
                <div class="line">
                    <div class="formCont">
                        <label for="searchKind">검색조건</label>
                        <select id="searchKind" name="searchKind" class="wid150">
                            <option value="">전체</option>
                            <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>회원ID</option>
                            <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>회원이름</option>
                        </select>
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
                </div>
            </div>
            <table>
                <colgroup>
                </colgroup>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>회원이름</th>
                    <th>휴대폰번호</th>
                    <th>회원ID</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="4">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:set var="lno" value="0"/>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <c:set var="lno">${lno + 1}</c:set>
                    <tr>
                        <td><input type="radio" id="${item.user_id}" value="${item.user_id}" /></td>
                        <td>${item.user_nm}</td>
                        <td>${item.moblphon}</td>
                        <td class="ta_l">${item.user_id}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택</a>
                    <a href="#none" class="btn" id="btn_cancel">닫기</a>
                </div>
            </div>
        </article>
    </div>
</section>
