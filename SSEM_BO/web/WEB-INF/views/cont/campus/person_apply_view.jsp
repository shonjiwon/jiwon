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
        $('#confirm_dt').daterangepicker({
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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/person_apply_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="person_book_apy_idx" id="person_book_apy_idx" value="${personBookApyVo.person_book_apy_idx}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>상태</th>
                    <td colspan="3">
                        <select id="status" name="status" class="kind">
                            <option value="A" <c:if test="${personBookApyVo.status eq 'A'}">selected="selected"</c:if>>신청대기</option>
                            <option value="P" <c:if test="${personBookApyVo.status eq 'P'}">selected="selected"</c:if>>신청조율</option>
                            <option value="O" <c:if test="${personBookApyVo.status eq 'O'}">selected="selected"</c:if>>열람확정</option>
                            <option value="C" <c:if test="${personBookApyVo.status eq 'C'}">selected="selected"</c:if>>신청취소</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>신청경로</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${personBookApyVo.gubun eq 'N'}">인물도서</c:when>
                            <c:when test="${personBookApyVo.gubun eq 'S'}">찾아가는 인물도서</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>분류</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${personBookApyVo.cate_cd eq 'J'}">진로직업</c:when>
                            <c:when test="${personBookApyVo.cate_cd eq 'C'}">문화예술</c:when>
                            <c:when test="${personBookApyVo.cate_cd eq 'H'}">인문교양</c:when>
                            <c:when test="${personBookApyVo.cate_cd eq 'P'}">인성심리</c:when>
                            <c:when test="${personBookApyVo.cate_cd eq 'E'}">전문인</c:when>
                            <c:when test="${personBookApyVo.cate_cd eq 'Z'}">기타</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>인물도서 제목</th>
                    <td>${personBookApyVo.title}</td>
                    <th>인물도서</th>
                    <td>${personBookApyVo.person}</td>
                </tr>
                <tr>
                    <th>신청자 ID</th>
                    <td colspan="3">${personBookApyVo.reg_id}</td>
                </tr>
                <tr>
                    <th>신청자</th>
                    <td>${personBookApyVo.apy_name}</td>
                    <th>휴대폰 번호</th>
                    <td>${personBookApyVo.apy_mob_no}</td>
                </tr>
                <tr>
                    <th>신청인원</th>
                    <td colspan="3">${personBookApyVo.apy_cnt}명</td>
                </tr>
                <tr>
                    <th>신청기관(단체)명</th>
                    <td colspan="3">${personBookApyVo.grp_name}</td>
                </tr>
                <tr>
                    <th>열람희망 일시</th>
                    <td colspan="3">${personBookApyVo.view_dt}</td>
                </tr>
                <tr>
                    <th>확정일시</th>
                    <td colspan="3">
                        <input type="text" id="confirm_dt" name="confirm_dt" class="wid150" value="${personBookApyVo.confirm_dt}">
                        <a href="javascript:showCalendar('confirm_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                <tr>
                    <th>열람희망 장소</th>
                    <td colspan="3">${personBookApyVo.plc}</td>
                </tr>
                <tr>
                    <th>신청일</th>
                    <td colspan="3">${personBookApyVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종 수정자</th>
                    <td colspan="3">${personBookApyVo.up_id}</td>
                </tr>
                <tr>
                    <th>최종 수정일</th>
                    <td colspan="3">${personBookApyVo.up_dt}</td>
                </tr>
                <tr>
                    <th>인물도서를 신청한 이유와 질문</th>
                    <td colspan="3">${personBookApyVo.reason}</td>
                </tr>
                <tr>
                    <th>업무 메모</th>
                    <td colspan="3">
                        <textarea name="memo" id="memo" class="textarea" cols="100%" rows="6" title="업무 메모">${personBookApyVo.memo}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/person_apply_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
