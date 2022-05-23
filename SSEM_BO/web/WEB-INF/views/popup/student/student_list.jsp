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
        // 전화번호 검색어
        var mob_no = '${searchVal8}';
        if(mob_no !== '') {
            var jbSplit = mob_no.split('-');
            $("#mob_1").val(jbSplit[0]);
            $("#mob_2").val(jbSplit[1]);
            $("#mob_3").val(jbSplit[2]);
        }

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

                $(opener.document).find("#apy_name").val(jbSplit[1]);
                $(opener.document).find("#apy_birth").val(jbSplit[2]);
                if(jbSplit[3] === 'M') {
                    $(opener.document).find("#apy_gender_m").prop("checked", true);
                } else {
                    $(opener.document).find("#apy_gender_f").prop("checked", true);
                }
                var jbSplitMobNo = jbSplit[4].split('-');
                $(opener.document).find("#mob_1").val(jbSplitMobNo[0]);
                $(opener.document).find("#mob_2").val(jbSplitMobNo[1]);
                $(opener.document).find("#mob_3").val(jbSplitMobNo[2]);
                $(opener.document).find("#postcode").val(jbSplit[5]);
                $(opener.document).find("#apy_addr1").val(jbSplit[6]);
                $(opener.document).find("#apy_addr2").val(jbSplit[7]);

                window.close();
            } else {
                alert("수강생정보를 선택해 주세요.");
            }
        });

        $("#btn_cancel").click(function(){
            $(opener.document).find("#user_id").val("");
            window.close();
        });

        /* Date Picker Settings */
        $('#searchVal5').daterangepicker({
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
    });

    function goSearch() {
        var mob_no = '';

        var mob_1 = $("#mob_1").val();
        var mob_2 = $("#mob_2").val();
        var mob_3 = $("#mob_3").val();

        if(mob_1 !== '') {
            mob_no += mob_1 + "-";
        }

        if(mob_2 !== '') {
            mob_no += mob_2 + "-";
        }

        if(mob_3 !== '') {
            mob_no += mob_3;
        }

        $('#searchVal8').val(mob_no);

        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<section class="wrap pop">
    <div class="container">
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/student/student_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal8" id="searchVal8" value="${searchVal8}"/> <%-- 휴대폰번호 --%>
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
                        <label>이름</label>
                        <input type="text" class="wid200" id="searchVal" name="searchVal" value="${searchVal}">
                    </div>
                    <div class="formCont">
                        <label>성별</label>
                        <input type="radio" name="searchVal4" id="searchVal4_M" value="M" <c:if test="${searchVal4 eq 'M'}">checked="checked"</c:if>>
                        <label for="searchVal4_M">남</label>
                        <input type="radio" name="searchVal4" id="searchVal4_F" value="F" <c:if test="${searchVal4 eq 'F'}">checked="checked"</c:if>>
                        <label for="searchVal4_F">여</label>
                    </div>
                </div>
                <div class="line">
                    <div class="formCont">
                        <label for="searchKind">일자검색</label>
                        <select id="searchKind" name="searchKind" class="wid200">
                            <option value="">일자선택</option>
                            <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>생년월일</option>
                            <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>등록일</option>
                        </select>
                    </div>
                    <div class="formCont">
                        <input type="text" id="searchVal5" name="searchVal5" class="wid100" value="${searchVal5}">
                        <a href="javascript:showCalendar('searchVal5');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    </div>
                    <div class="formCont">
                        <label>휴대폰</label>
                        <input type="text" id="mob_1" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                        -
                        <input type="text" id="mob_2" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                        -
                        <input type="text" id="mob_3" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
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
                    <th>번호</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>생년월일</th>
                    <th>휴대폰번호</th>
                    <th>주소</th>
                    <th>등록일</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="8">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:set var="lno" value="0"/>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <c:set var="lno">${lno + 1}</c:set>
                    <tr>
                        <td><input type="radio" id="${item.student_idx}" value="${item.student_idx}@${item.name}@${item.birth}@${item.gender}@${item.mob_no}@${item.postcode}@${item.addr1}@${item.addr2}" /></td>
                        <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                        <td>${item.name}
                            <c:if test="${item.like_yn eq 'Y'}">
                                <img src="/ssemadmin/resources/img/icon_file.png" class="wid20" id="tooltip_${item.student_idx}">
                                <script>
                                    new jBox('Tooltip', {
                                        attach: '#tooltip_${item.student_idx}',
                                        target: '#tooltip_${item.student_idx}',
                                        theme: 'TooltipBorder',
                                        trigger: 'click',
                                        adjustTracker: true,
                                        closeOnClick: 'body',
                                        /* closeButton: 'box', */
                                        animation: 'move',
                                        position: {
                                            x: 'left',
                                            y: 'bottom'
                                        },
                                        outside: 'y',
                                        pointer: 'left:10',
                                        // 크롬
                                        offset: {
                                            x: 10,
                                            y: 0
                                        },
                                        // IE
                                        /* offset: {
                                          x: 10,
                                          y: 5
                                        }, */
                                        content: (
                                            '${item.memo_html}'
                                        ),
                                        onOpen: function () {
                                            //this.source.addClass('active').html('Now scroll');
                                        },
                                        onClose: function () {
                                            //this.source.removeClass('active').html('Click me');
                                        }
                                    });
                                </script>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.gender eq 'M'}">남</c:when>
                                <c:when test="${item.gender eq 'F'}">여</c:when>
                            </c:choose>
                        </td>
                        <td>${item.birth}</td>
                        <td>${item.mob_no}</td>
                        <td>
                            <c:if test="${item.postcode ne '' && item.postcode ne null}">
                                (${item.postcode}) ${item.addr1} ${item.addr2}
                            </c:if>
                        </td>
                        <td class="ta_l">${fn:substring(item.reg_dt, 0, 10)}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">수강생선택</a>
                    <a href="#none" class="btn" id="btn_cancel">닫기</a>
                </div>
            </div>
        </article>
    </div>
</section>
