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
<script type="text/javascript">
    $(document).ready(function(){
        //감면대상 선택 내용 확인
        let discount_select = '';
        $('input[name=discount_select]').change(function() {
            let searchTxt = $(this).val();
            if(discount_select.indexOf(searchTxt) === -1) {
                discount_select = discount_select + " " + searchTxt;
            } else {
                discount_select = discount_select.replace(searchTxt, '');
            }
        });

        $("#btn_select").click(function(){
            if(discount_select !== "") {
                discount_select = discount_select.trim();
                discount_select = discount_select.replaceAll(' ', ',');
                $(opener.document).find("#discount_str").val(discount_select);
                window.close();
            } else {
                alert("감면정보를 선택해 주세요.");
            }
        });
    });
</script>
<section class="wrap pop">
    <div class="container">
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/discount/discount_list.do?group_idx=${groupVo.group_idx}">
            <input type="hidden" name="page" id="page" value="${page}"/>
        </form>
        <article class="contUnit tbl_area">
            <div class="btnArea mgt0 mgb10">
                <div class="btnArea mgt0 mgb10">
                    <div class="left">
                        <h3>${groupVo.p_name} - ${groupVo.name}</h3>
                    </div>
                    <div class="right">

                    </div>
                </div>
                <%--<div class="left">
                    총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                </div>--%>
                <div class="right">
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
                    <th>감면대상</th>
                    <th>상세조건</th>
                    <th>감면율(%)</th>
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
                        <td><input type="checkbox" name="discount_select" id="${item.discount_idx}" value="${item.discount_idx}" /></td>
                        <td>${item.tgt_name}</td>
                        <td>${item.dtl_txt}</td>
                        <td>${item.rate}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="btnArea">
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택</a>
                </div>
            </div>
        </article>
    </div>
</section>
