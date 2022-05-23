<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function () {

        /* Date Picker Settings */
        $('#resv_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": true,
            "timePicker24Hour": true,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD HH:mm",
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": ["일","월","화","수","목","금","토"],
                "monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
                "firstDay": 0
            }
        }, function(start, end, label) {
            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });

        $("#btn_update").click(function(){
            var frm = document.frm;

            $("#frm").submit();
        });
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">

            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/self_counsel_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="self_counsel_idx" id="self_counsel_idx" value="${selfCounselVo.self_counsel_idx}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>신청(점수)일</th>
                    <td>${fn:substring(selfCounselVo.reg_dt, 0, 10)}</td>
                    <th>접수상태</th>
                    <td>
                        <select class="wid150" name="status" id="status">
                            <option value="A" <c:if test="${selfCounselVo.status eq 'A'}">selected="selected"</c:if>>예약접수</option>
                            <option value="R" <c:if test="${selfCounselVo.status eq 'R'}">selected="selected"</c:if>>예약완료</option>
                            <option value="O" <c:if test="${selfCounselVo.status eq 'O'}">selected="selected"</c:if>>상담완료</option>
                            <option value="C" <c:if test="${selfCounselVo.status eq 'C'}">selected="selected"</c:if>>예약취소</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>신정자ID</th>
                    <td>${selfCounselVo.reg_id}</td>
                    <th>신청자 이름</th>
                    <td>${selfCounselVo.apy_name}</td>
                </tr>
                <tr>
                    <th>신청자 휴대폰</th>
                    <td>${selfCounselVo.apy_mob_no}</td>
                    <th>희망 상담유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${selfCounselVo.gubun eq 'J'}">진로</c:when>
                            <c:when test="${selfCounselVo.gubun eq 'S'}">자기주도학습</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>희망상담일</th>
                    <td>${selfCounselVo.meet_dt}</td>
                    <th>통화 가능시간</th>
                    <td>평일 ${selfCounselVo.able_phone_time}</td>
                </tr>
                <tr>
                    <th>신청자 메모</th>
                    <td colspan="3">
                        ${selfCounselVo.apy_memo}
                    </td>
                </tr>
                <tr>
                    <th>개인자료업로드</th>
                    <td colspan="3">
                        <c:forEach items="${selfCounselVo.fileList}" var="item" varStatus="status">
                            <c:if test="${item != null}">
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>상담예약일시</th>
                    <td colspan="3">
                        <input type="text" id="resv_dt" name="resv_dt" class="wid150" value="${selfCounselVo.resv_dt}">
                        <a href="javascript:showCalendar('resv_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th>관리자 메모</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="mng_memo" id="mng_memo">${selfCounselVo.mng_memo}</textarea>
                    </td>
                </tr>
                <c:if test="${selfCounselVo.up_id ne null}">
                <tr>
                    <th>최종수정일</th>
                    <td>${selfCounselVo.up_dt}</td>
                    <th>최종수정자</th>
                    <td>${selfCounselVo.up_id}</td>
                </tr>
                </c:if>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/self_counsel_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
