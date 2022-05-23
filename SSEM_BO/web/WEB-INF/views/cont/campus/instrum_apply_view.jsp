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
<style>
    .hidden {
        display : none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {

        <c:if test="${instrumApyVo.pay_status eq 'D'}">
            numberWithCommas($('#refund').val(), 'refund');
        </c:if>

        /* Date Picker Settings */
        $('#pay_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": false,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD",
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

        /* Date Picker Settings */
        $('#refund_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": false,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD",
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

        /* Date Picker Settings */
        $('#return_dt').daterangepicker({
            "singleDatePicker": true,
            "timePicker": false,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM-DD",
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

        add_file();

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssemadmin/file/file_delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: "atch_file_id=" + del_id_arr[0] + "&file_num=" + del_id_arr[1],
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("삭제에 실패하였습니다.");
                        } else {
                            alert("삭제하였습니다.");
                            location.href = "?instrum_apy_idx=${instrumApyVo.instrum_apy_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });

        $("input[name=return_yn]").change(function() {
            var radio_val = $(this).val();
            if(radio_val === 'Y') {
                $('#return_dt').removeClass("hidden");
                $('#return_dt').attr("type", "text");
                $('#cal_icon').removeClass("hidden");
            } else {
                $('#return_dt').addClass("hidden");
                $('#return_dt').attr("type", "hidden");
                $('#cal_icon').addClass("hidden");
            }
        });

        $("#btn_update").click(function(){
            var frm = document.frm;
            var return_yn = frm.return_yn.value;
            if(return_yn === 'Y') {
                if(!fnIsValidRequired(frm.return_dt, "반납완료일")){return false;}
            }

            <c:if test="${instrumApyVo.pay_status eq 'D'}">
                frm.refund.value = replaceAll(frm.refund.value, ",", "");
            </c:if>

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
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>악기정보</h3>
                </div>
                <div class="right">

                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>악기유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'A'}">건반악기</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'B'}">관악기</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'C'}">타악기</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'D'}">현악기</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'E'}">MIDI장비</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'K'}">국악기</c:when>
                            <c:when test="${instrumApyVo.instrum_gubun eq 'Z'}">기타</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>악기명</th>
                    <td>
                        ${instrumApyVo.instrum_name}
                    </td>
                </tr>
                <tr>
                    <th>대여료</th>
                    <td>
                        <fmt:formatNumber value="${instrumApyVo.instrum_fee}" pattern="##,###"/> 원/월
                    </td>
                </tr>
                </tbody>
            </table>
        </article>

        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>개인정보</h3>
                </div>
                <div class="right">

                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>신청자 ID</th>
                    <td>${instrumApyVo.apy_id}</td>
                    <th>신청자</th>
                    <td>${instrumApyVo.apy_nm}</td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td>${instrumApyVo.apy_birth}</td>
                    <th>휴대폰번호</th>
                    <td>${instrumApyVo.apy_mob_no}</td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>${instrumApyVo.apy_tel_no}</td>
                    <th>이메일</th>
                    <td>${instrumApyVo.apy_email}</td>
                </tr>
                <tr>
                    <th>부모이름</th>
                    <td>${instrumApyVo.apy_parent_name}</td>
                    <th>부모연락처</th>
                    <td>${instrumApyVo.apy_parent_mob_no}</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3">${instrumApyVo.apy_addr}</td>
                </tr>
                </tbody>
            </table>
        </article>

        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>신청정보</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <form name="frm" id="frm" action="/ssemadmin/cont/campus/instrum_apply_view.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="instrum_apy_idx" value="${instrumApyVo.instrum_apy_idx}" />
                <input type="hidden" name="instrum_idx" value="${instrumApyVo.instrum_idx}" />
                <input type="hidden" name="group_idx" value="${instrumApyVo.group_idx}" />
                <input type="hidden" name="rental_qty" value="${instrumApyVo.rental_qty}" />
                <input type="hidden" name="return_flag" value="${instrumApyVo.return_flag}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>신청상태</th>
                    <td>
                        <select id="status" name="status" class="kind" <c:if test="${instrumApyVo.pay_status ne 'A' && instrumApyVo.pay_status ne null}">disabled</c:if>>
                            <option value="A" <c:if test="${instrumApyVo.status eq 'A'}">selected="selected"</c:if>>신청</option>
                            <option value="R" <c:if test="${instrumApyVo.status eq 'R'}">selected="selected"</c:if>>신청취소</option>
                            <option value="O" <c:if test="${instrumApyVo.status eq 'O'}">selected="selected"</c:if>>승인</option>
                            <option value="C" <c:if test="${instrumApyVo.status eq 'C'}">selected="selected"</c:if>>승인취소</option>
                        </select>
                    </td>
                    <th>신청구분</th>
                    <td>
                        <c:choose>
                            <c:when test="${instrumApyVo.gubun eq 'P'}">개인</c:when>
                            <c:when test="${instrumApyVo.gubun eq 'G'}">단체</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>단체명</th>
                    <td>${instrumApyVo.grp_name}</td>
                    <th>인원수</th>
                    <td>${instrumApyVo.mem_cnt}명</td>
                </tr>
                <tr>
                    <th>대여기간</th>
                    <td>
                        ${instrumApyVo.rental_start_dt} ~ ${instrumApyVo.rental_end_dt} / ${instrumApyVo.rental_month}개월
                    </td>
                    <th>반납예정일/연체일</th>
                    <td>${instrumApyVo.return_due_dt} / <span class="co_red">연체 : +${instrumApyVo.late_day}</span></td>
                </tr>
                <tr>
                    <th>대여수량</th>
                    <td>${instrumApyVo.rental_qty}개</td>
                    <th>신청일</th>
                    <td>${fn:substring(instrumApyVo.reg_dt, 0, 10)}</td>
                </tr>
                <tr>
                    <th>대역목적</th>
                    <td colspan="3">${instrumApyVo.purpose}</td>
                </tr>
                <tr>
                    <th>결제대금</th>
                    <td colspan="3"><fmt:formatNumber value="${instrumApyVo.pay}" pattern="##,###"/>원</td>
                </tr>
                <c:if test="${instrumApyVo.status eq 'O'}">
                <tr>
                    <th>결제상태</th>
                    <td>
                        <select id="pay_status" name="pay_status" class="kind">
                            <option value="A" <c:if test="${instrumApyVo.pay_status eq 'A'}">selected="selected"</c:if>>결제대기</option>
                            <option value="B" <c:if test="${instrumApyVo.pay_status eq 'B'}">selected="selected"</c:if>>결제완료</option>
                            <option value="C" <c:if test="${instrumApyVo.pay_status eq 'C'}">selected="selected"</c:if>>환불신청</option>
                            <option value="D" <c:if test="${instrumApyVo.pay_status eq 'D'}">selected="selected"</c:if>>환불처리</option>
                        </select>
                    </td>
                    <th>결제일</th>
                    <td>
                        <input type="text" id="pay_dt" name="pay_dt" class="wid100" value="${instrumApyVo.pay_dt}">
                        <a href="javascript:showCalendar('pay_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                </c:if>
                <c:if test="${instrumApyVo.pay_status eq 'D'}">
                <tr>
                    <th>환불방식</th>
                    <td>
                        <select id="refund_method" name="refund_method" class="kind">
                            <option value="A" <c:if test="${instrumApyVo.refund_method eq 'A'}">selected="selected"</c:if>>현금</option>
                            <option value="B" <c:if test="${instrumApyVo.refund_method eq 'B'}">selected="selected"</c:if>>계좌입력</option>
                            <option value="C" <c:if test="${instrumApyVo.refund_method eq 'C'}">selected="selected"</c:if>>카드취소</option>
                        </select>
                    </td>
                    <th>환불금액</th>
                    <td>
                        <input type="text" class="wid100" name="refund" id="refund" onkeyup="numberWithCommas(this.value, 'refund');" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${instrumApyVo.refund}">원
                    </td>
                </tr>
                <tr>
                    <th>환불처리일</th>
                    <td colspan="3">
                        <input type="text" id="refund_dt" name="refund_dt" class="wid100" value="${instrumApyVo.refund_dt}">
                        <a href="javascript:showCalendar('refund_dt');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </td>
                </tr>
                </c:if>
                <tr>
                    <th>반납완료</th>
                    <td>
                        <c:choose>
                            <c:when test="${instrumApyVo.status eq 'O' && instrumApyVo.pay_status eq 'B'}">
                                <input type="radio" name="return_yn" id="return_n" value="N" <c:if test="${instrumApyVo.return_yn eq 'N'}">checked="checked"</c:if>>
                                <label for="return_n">N</label>
                                <input type="radio" name="return_yn" id="return_y" value="Y" <c:if test="${instrumApyVo.return_yn eq 'Y'}">checked="checked"</c:if>>
                                <label for="return_y">Y</label>
                            </c:when>
                            <c:otherwise>
                                <input type="radio" name="return_yn" id="return_n" value="N" <c:if test="${instrumApyVo.return_yn eq 'N'}">checked="checked"</c:if> disabled>
                                <label for="return_n">N</label>
                                <input type="radio" name="return_yn" id="return_y" value="Y" <c:if test="${instrumApyVo.return_yn eq 'Y'}">checked="checked"</c:if> disabled>
                                <label for="return_y">Y</label>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <th>반납완료일</th>
                    <td>
                        <c:choose>
                            <c:when test="${instrumApyVo.return_yn eq 'N'}">
                                <input type="hidden" id="return_dt" name="return_dt" class="wid100" value="${instrumApyVo.return_dt}" class="hidden">
                                <a href="javascript:showCalendar('return_dt');" style="border-bottom: 0px solid #000; !important;"><img id="cal_icon" src="/ssemadmin/resources/img/icon_cal.png" class="hidden"></a>
                            </c:when>
                            <c:when test="${instrumApyVo.return_yn eq 'Y'}">
                                <input type="text" id="return_dt" name="return_dt" class="wid100" value="${instrumApyVo.return_dt}">
                                <a href="javascript:showCalendar('return_dt');" style="border-bottom: 0px solid #000; !important;"><img id="cal_icon" src="/ssemadmin/resources/img/icon_cal.png" title="캘런더이미지"/></a>
                            </c:when>
                            <c:otherwise>
                                ${fn:substring(instrumApyVo.return_dt, 0, 10)}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>최종 수정자</th>
                    <td>${instrumApyVo.up_id}</td>
                    <th>최종 수정일</th>
                    <td>${instrumApyVo.up_dt}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                        <ul id="file_ul">
                            <li class="mb5" style="display:none">
                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                            </li>
                        </ul>
                        <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                        <c:forEach items="${instrumApyVo.fileList}" var="item" varStatus="status">
                            <c:if test="${item != null}">
                                <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                    <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>업무메모</th>
                    <td colspan="3">
                        <textarea name="memo" id="memo" class="textarea" cols="100%" rows="5" title="업무메모">${instrumApyVo.memo}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
            </form>
            <div class="btnArea">
                <div class="left">
                    <a href="/ssemadmin/cont/campus/instrum_apply_list.do" class="btn">목록</a>
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_update">저장</a>
                </div>
            </div>
        </article>
</div>
