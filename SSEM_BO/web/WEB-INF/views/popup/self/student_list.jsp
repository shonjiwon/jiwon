<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-28
  Time: 오전 12:09
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
        var selected_data = "";

        $("input[type=radio]").change(function() {
            selected_data = $(this).val();
        });

        $("#btn_select").click(function(){
            if(selected_data !== "") {
                var jbSplit = selected_data.split('@');

                $(opener.document).find("#student_idx").val(jbSplit[0]);
                $(opener.document).find("#inout_nm").val(jbSplit[1]);
                $(opener.document).find("#birth").val(jbSplit[2]);
                if(jbSplit[3] === 'M') {
                    $(opener.document).find("#gender").val("남");
                } else {
                    $(opener.document).find("#gender").val("여");
                }
                $(opener.document).find("#mob_no").val(jbSplit[4]);
                $(opener.document).find("#post_no").val(jbSplit[5]);
                $(opener.document).find("#addr").val(jbSplit[6]);
                $(opener.document).find("#addr_detail").val(jbSplit[7]);
                $(opener.document).find("#inout_cost").val(jbSplit[8]);
                $(opener.document).find("#discount_rate").val(jbSplit[9]);
                $(opener.document).find("#discount_idx").val(jbSplit[10]);
                $(opener.document).find("#discount_info").val(jbSplit[11]);

                window.close();
            } else {
                alert("수강자정보를 선택해 주세요.");
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
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/self/student_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 프로그램정보 --%>
            <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 조직정보 --%>
            <article class="contUnit sch_area">
                <div class="btnArea mgt0 mgb10 of_h">
                    <div class="left">
                        <h3>수강생조회</h3>
                    </div>
                    <div class="right">
                    </div>
                </div>
                <div class="line">
                    <div class="formCont">
                        <label>소속</label>
                        <input type="text" class="wid100" value="자치회관" disabled>
                    </div>
                    <div class="formCont">
                        <label>교육기관</label>
                        <input type="text" class="wid150" value="${dong_nm}" disabled>
                    </div>
                    <div class="formCont">
                        <label>프로그램명</label>
                        <input type="text" class="wid250" value="${lecture_nm}" disabled>
                    </div>
                    <div class="formCont">
                        <label>이름</label>
                        <input type="text" class="wid100" name="searchVal" id="searchVal" value="${searchVal}">
                        <a href="#none" class="btn orange" id="btn_search">검색</a>
                    </div>
                </div>
            </article>
        </form>
        <article class="contUnit tbl_area">
            <div class="btnArea mgt0 mgb10">
                <div class="right">
                </div>
            </div>
            <table>
                <colgroup>
                </colgroup>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>교육기관</th>
                    <th>회원이름</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>휴대폰번호</th>
                    <th>감면여부</th>
                    <th>감면상세</th>
                    <th>결제금액</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="9">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <tr>
                        <td><input type="radio" id="${item.student_idx}" value="${item.student_idx}@${item.name}@${item.birth}@${item.gender}@${item.mob_no}@${item.postcode}@${item.addr1}@${item.addr2}@${item.pay_sum}@${item.discountVo.rate}@${item.discountVo.discount_idx}@${item.discountVo.tgt_name}" /></td>
                        <td>${dong_nm}</td>
                        <td>${item.name}</td>
                        <td>${item.birth}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.gender eq 'M'}">남</c:when>
                                <c:when test="${item.gender eq 'F'}">여</c:when>
                            </c:choose>
                        </td>
                        <td>${item.mob_no}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.discountVo.rate ne null && item.discountVo.rate ne ''}">
                                    ${item.discountVo.rate}
                                </c:when>
                                <c:otherwise>해당없음</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.discountVo.rate ne null && item.discountVo.rate ne ''}">
                                    ${item.discountVo.tgt_name}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="ta_r">
                            ${item.pay_sum}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택회원입력</a>
                    <a href="#none" class="btn" id="btn_cancel">취소</a>
                </div>
            </div>
        </article>
    </div>
</section>
