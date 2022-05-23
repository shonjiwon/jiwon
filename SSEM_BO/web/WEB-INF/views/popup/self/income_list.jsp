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

            //${item.inout_seq}@${item.inout_nm}@${item.lecture_nm}@${item.post_no}@${item.addr}@${item.addr_detail}@${item.lecture_idx}

                $(opener.document).find("#ref_seq").val(jbSplit[0]);
                $(opener.document).find("#inout_nm").val(jbSplit[1]);
                $(opener.document).find("#lecture_nm").val(jbSplit[2]);
                $(opener.document).find("#post_no").val(jbSplit[3]);
                $(opener.document).find("#addr").val(jbSplit[4]);
                $(opener.document).find("#addr_detail").val(jbSplit[5]);
                $(opener.document).find("#lecture_idx").val(jbSplit[6]);
                $(opener.document).find("#student_idx").val(jbSplit[7]);

                window.close();
            } else {
                alert("수입 목록을 선택해 주세요.");
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
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/self/income_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchKind" id="searchKind" value="${searchKind}"/>
            <article class="contUnit sch_area">
                <div class="btnArea mgt0 mgb10 of_h">
                    <div class="left">
                        <h3>수입 목록</h3>
                    </div>
                    <div class="left">
                        * 환불대상 수입항목을 선택해 주세요 (지출목록에 환불이력이 있는 수입목록은 조회 되지 않습니다.)
                    </div>
                </div>
                <div class="line">
                    <div class="formCont">
                        <label>일자</label>
                        <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                        <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ~
                        <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                        <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </div>
                    <div class="formCont">
                        <label>소속</label>
                        <input type="text" class="wid100" value="자치회관" disabled>
                    </div>
                    <div class="formCont">
                        <label>교육기관</label>
                        <input type="text" class="wid150" value="${groupVo.name}" disabled>
                    </div>
                    <div class="formCont">
                        <label>성명</label>
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
                    <th>수입일자</th>
                    <th>구분</th>
                    <th>수입액</th>
                    <th>프로그램명</th>
                    <th>이름</th>
                    <th>휴대폰번호</th>
                    <th>주소</th>
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
                        <td><input type="radio" id="${item.inout_seq}" value="${item.inout_seq}@${item.inout_nm}@${item.lecture_nm}@${item.post_no}@${item.addr}@${item.addr_detail}@${item.lecture_idx}@${item.student_idx}" /></td>
                        <td>${groupVo.name}</td>
                        <td>${item.standard_date}</td>
                        <td>${item.inout_cd_nm}</td>
                        <td><fmt:formatNumber value="${item.inout_cost}" pattern="##,###"/></td>
                        <td>${item.lecture_nm}</td>
                        <td>${item.inout_nm}</td>
                        <td>${item.mob_no}</td>
                        <td>${item.addr} ${item.addr_detail}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택수입입력</a>
                    <a href="#none" class="btn" id="btn_cancel">취소</a>
                </div>
            </div>
        </article>
    </div>
</section>
