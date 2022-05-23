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
        var study_place_idx = "";
        var room_name = "";

        $("input[type=radio]").change(function() {
            study_place_idx = $(this).attr('id');
            room_name = $(this).val();
        });

        $("#btn_select").click(function(){
            if(study_place_idx !== "") {
                $(opener.document).find("#study_place_idx").val(study_place_idx);
                $(opener.document).find("#room_name").val(room_name);
                window.close();
            } else {
                alert("시설정보를 선택해 주세요.");
            }
        });
    });
</script>
<section class="wrap pop">
    <div class="container">
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/room/room_list.do?group_idx=${groupVo.group_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
        </form>
        <article class="contUnit tbl_area">
            <div class="btnArea mgt0 mgb10">
                <div class="btnArea mgt0 mgb10">
                    <div class="left">
                        <h3>${groupVo.p_name} - ${groupVo.name}</h3>
                    </div>
                </div>
            </div>
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:8%">
                    <col style="width:20%">
                    <col>
                    <col style="width:20%">
                </colgroup>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>교육시설명</th>
                    <th>설명</th>
                    <th>최대수용인원</th>
                    <th>적정사용인원</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="6">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:set var="lno" value="0"/>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <c:set var="lno">${lno + 1}</c:set>
                    <tr>
                        <td><input type="radio" name="study_place" id="${item.study_place_idx}" value="${item.name}" /></td>
                        <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                        <td>${item.name}</td>
                        <td>${item.cont}</td>
                        <td>${item.max_qty}</td>
                        <td>${item.gd_qty}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택</a>
                </div>
            </div>
        </article>
    </div>
</section>
