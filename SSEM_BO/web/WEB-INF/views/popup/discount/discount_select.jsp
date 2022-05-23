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
        $("#btn_select").click(function(){

            var discount_select = $("input:radio[name=discount_select]:checked").val();
            if(discount_select !== "") {
                var token = discount_select.split("_")

                var discount_idx = token[0];
                var rate = Number(token[1]);
                var fee = Number(${pay_sum});
                var real_fee = fee - (fee * (rate / 100));

                $(opener.document).find("#discount_idx").val(discount_idx);  // discount_idx
                $(opener.document).find("#discount_rate").val(rate); // rate
                $(opener.document).find("#real_pay").text(real_fee + "원");
                $(opener.document).find("#pay_sum").val(real_fee);

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
                        <td><input type="radio" name="discount_select" id="${item.discount_idx}" value="${item.discount_idx}_${item.rate}" <c:if test="${selected_discount_idx eq item.discount_idx}">checked="checked"</c:if>/></td>
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
