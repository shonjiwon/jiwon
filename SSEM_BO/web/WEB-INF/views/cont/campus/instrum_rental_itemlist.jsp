<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).on("change","#select_view",function(){
            var val = $(this).val();
            if(val === 'C') {
                location.href="/ssemadmin/cont/campus/instrum_rental_calendar.do?rental_fty_idx=" + ${searchKind};
            } else {
                location.href="/ssemadmin/cont/campus/instrum_rental_itemlist.do?rental_fty_idx=" + ${searchKind};
            }
        });

        /* Date Picker Settings */
        $('#searchSDate').daterangepicker({
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
        $('#searchEDate').daterangepicker({
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

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }

    function pop_fty_apply(rental_fty_apy_idx) {
        var url = "/ssemadmin/popup/campus/instrum_rental_view.do?rental_fty_apy_idx=" + rental_fty_apy_idx;
        window.open(url, 'pop_fty_apply', 'width=900, height=450, scrollbars=0, toolbar=0, menubar=no');
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/instrum_rental_itemlist.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="select_view" class="widAuto">형태</label>
                    <select id="select_view" class="wid150">
                        <option value="L">목록</option>
                        <option value="C">캘린더</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchKind" class="widAuto">시설</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <c:forEach items="${ftyList}" var="fty" varStatus="status">
                            <option value="${fty.rental_fty_idx}" <c:if test="${fty.rental_fty_idx eq searchKind}">selected="selected"</c:if>>${fty.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <div class="formCont">
                        <label for="searchKind2" class="widAuto">결제상태</label>
                        <select id="searchKind2" name="searchKind2" class="wid150">
                            <option value="">전체</option>
                            <option value="O" <c:if test="${searchKind2 eq 'O'}">selected="selected"</c:if>>결제완료</option>
                            <option value="C" <c:if test="${searchKind2 eq 'C'}">selected="selected"</c:if>>결제취소</option>
                        </select>
                    </div>
                </div>
                <div class="formCont">
                    <div class="formCont">
                        <label for="searchKind3" class="widAuto">결제수단</label>
                        <select id="searchKind3" name="searchKind3" class="wid150">
                            <option value="">전체</option>
                            <option value="A" <c:if test="${searchKind3 eq 'A'}">selected="selected"</c:if>>카드</option>
                            <option value="B" <c:if test="${searchKind3 eq 'B'}">selected="selected"</c:if>>현금</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--<div class="line">
                <div class="formCont">
                    <label for="searchKind" class="widAuto">시설</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <c:forEach items="${ftyList}" var="fty" varStatus="status">
                            <option value="${fty.rental_fty_idx}" <c:if test="${fty.rental_fty_idx eq searchKind}">selected="selected"</c:if>>${fty.name}</option>
                        </c:forEach>
                    </select>
                    &lt;%&ndash;<select id="sel02" class="wid150">
                        <option>2020</option>
                    </select>

                    <a href="#none" class="btn sml on">1월</a>
                    <a href="#none" class="btn sml">2월</a>
                    <a href="#none" class="btn sml">3월</a>
                    <a href="#none" class="btn sml">4월</a>
                    <a href="#none" class="btn sml">5월</a>
                    <a href="#none" class="btn sml">6월</a>
                    <a href="#none" class="btn sml">7월</a>
                    <a href="#none" class="btn sml">8월</a>
                    <a href="#none" class="btn sml">9월</a>
                    <a href="#none" class="btn sml">10월</a>
                    <a href="#none" class="btn sml">11월</a>
                    <a href="#none" class="btn sml">12월</a>&ndash;%&gt;

                </div>
            </div>--%>
            <%--<div class="line">
                <div class="formCont">
                    <div class="formCont">
                        <label for="searchKind2" class="widAuto">결제상태</label>
                        <select id="searchKind2" name="searchKind2" class="wid150">
                            <option value="">전체</option>
                            <option value="O" <c:if test="${searchKind2 eq 'O'}">selected="selected"</c:if>>결제완료</option>
                            <option value="C" <c:if test="${searchKind2 eq 'C'}">selected="selected"</c:if>>결제취소</option>
                        </select>
                    </div>
                </div>
                <div class="formCont">
                    <div class="formCont">
                        <label for="searchKind3" class="widAuto">결제수단</label>
                        <select id="searchKind3" name="searchKind3" class="wid150">
                            <option value="">전체</option>
                            <option value="A" <c:if test="${searchKind3 eq 'A'}">selected="selected"</c:if>>카드</option>
                            <option value="B" <c:if test="${searchKind3 eq 'B'}">selected="selected"</c:if>>현금</option>
                        </select>
                    </div>
                </div>
            </div>--%>
            <div class="line">
                <div class="formCont">
                    <label for="searchVal2">기간</label>
                    <select id="searchVal2" name="searchVal2" class="wid150">
                        <option value="">기간선택</option>
                        <option value="1" <c:if test="${searchVal2 eq '1'}">selected="selected"</c:if>>예약일</option>
                        <option value="2" <c:if test="${searchVal2 eq '2'}">selected="selected"</c:if>>결제완료 일시</option>
                        <option value="3" <c:if test="${searchVal2 eq '3'}">selected="selected"</c:if>>결제취소 일시</option>
                    </select>
                    <input type="text" id="searchSDate" name="searchSDate" class="wid100" value="${searchSDate}">
                    <a href="javascript:showCalendar('searchSDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                    ~
                    <input type="text" id="searchEDate" name="searchEDate" class="wid100" value="${searchEDate}">
                    <a href="javascript:showCalendar('searchEDate');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                </div>
                <div class="formCont">
                    <label for="searchKind4">검색</label>
                    <select id="searchKind4" name="searchKind4" class="wid150">
                        <option value="ALL" <c:if test="${searchKind4 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                        <option value="1" <c:if test="${searchKind4 eq '1'}">selected="selected"</c:if>>예약자</option>
                        <option value="2" <c:if test="${searchKind4 eq '2'}">selected="selected"</c:if>>거래번호</option>
                    </select>
                    <input type="text" placeholder="검색어 입력" class="wid200" id="searchVal" name="searchVal" value="${searchVal}">
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popOpen" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <table>
            <colgroup>
                <col>
                <col style="width:100px;">
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>시설</th>
                <th>예약일</th>
                <th>예약시간</th>
                <th>예약자</th>
                <th>휴대폰번호</th>
                <th>등록일시</th>
                <th>결제금액</th>
                <th>결제상태</th>
                <th>결제수단</th>
                <th>결제완료 일시</th>
                <th>결제최소 일시</th>
                <th>거래번호</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="13">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.fty_name}</td>
                    <td>${fn:substring(item.resv_dt, 0, 10)}</td>
                    <td>
                        <c:if test="${item.h9 eq 'Y'}">[09:00 ~ 10:00]</c:if>
                        <c:if test="${item.h10 eq 'Y'}"> [10:00 ~ 11:00]</c:if>
                        <c:if test="${item.h11 eq 'Y'}"> [11:00 ~ 12:00]</c:if>
                        <c:if test="${item.h12 eq 'Y'}"> [12:00 ~ 13:00]</c:if>
                        <c:if test="${item.h13 eq 'Y'}"> [13:00 ~ 14:00]</c:if>
                        <c:if test="${item.h14 eq 'Y'}"> [14:00 ~ 15:00]</c:if>
                        <c:if test="${item.h15 eq 'Y'}"> [15:00 ~ 16:00]</c:if>
                        <c:if test="${item.h16 eq 'Y'}"> [16:00 ~ 17:00]</c:if>
                        <c:if test="${item.h17 eq 'Y'}"> [17:00 ~ 18:00]</c:if>
                        <c:if test="${item.h18 eq 'Y'}"> [18:00 ~ 19:00]</c:if>
                        <c:if test="${item.h19 eq 'Y'}"> [19:00 ~ 20:00]</c:if>
                        <c:if test="${item.h20 eq 'Y'}"> [20:00 ~ 21:00]</c:if>
                    </td>
                    <td>
                        <a href="#none" class="popOpen" onclick="pop_fty_apply('${item.rental_fty_apy_idx}')">${item.apy_name}</a>
                    </td>
                    <td>${item.apy_mob_no}</td>
                    <td>${item.reg_dt}</td>
                    <td><fmt:formatNumber value="${item.pay_sum}" pattern="##,###"/>원</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.pay_status eq 'O'}">결제완료</c:when>
                            <c:when test="${item.pay_status eq 'C'}">결제취소</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.pay_method eq 'A'}">신용카드</c:when>
                            <c:when test="${item.pay_method eq 'B'}">현금결제</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.pay_dt}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.pay_cancel_dt ne null}">${item.pay_cancel_dt}</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.trade_code}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/campus/instrum_rental_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>

<section class="popArea pop_exelDown">
    <div class="popBody">
        <div class="tit">
            <h2>엑셀파일 다운로드 사유등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont mgt-40">
            <article class="contUnit tbl_area leftType">
                <div class="btnArea mgb10">
                    <div class="left">
                    </div>
                    <div class="right">
                        <div class="tblMsg ta_r">
                            <span class="co_red">*</span> 필수입력
                        </div>
                    </div>
                </div>
                <table>
                    <colgroup>
                        <col style="width:5rem">
                        <col style="width:5rem">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th class="required">다운로드 사유</th>
                        <td>
                            <input type="radio" name="radio01" id="radio01_01">
                            <label for="radio01_01">교육 프로그램 관련 업무</label><br>
                            <input type="radio" name="radio01" id="radio01_02">
                            <label for="radio01_02">시설 및 장비 대여 관련 업무</label><br>
                            <input type="radio" name="radio01" id="radio01_03">
                            <label for="radio01_03">온라인 상담 예약 관련 업무</label><br>
                            <input type="radio" name="radio01" id="radio01_04">
                            <label for="radio01_04">구민(회원) 민원처리</label><br>
                            <input type="radio" name="radio01" id="radio01_05">
                            <label for="radio01_05">기타(직접입력)</label><br>
                            <input type="text" class="wid300 mgt10" disabled> <span class="co_red">0</span>/30
                        </td>
                    </tr>
                    <tr>
                        <th class="required">엑셀파일 비밀번호 생성</th>
                        <td>
                            <input type="password">
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div>
                    <ul class="list bili">
                        <li>비밀번호 는 <span class="co_red">숫자로만 입력 가능하며, 최대 4자리까지</span> 생성하실 수 있습니다.</li>
                    </ul>
                </div>
                <div class="btnArea ta_c">
                    <a href="#none" class="btn red">등록</a>
                    <a href="#none" class="btn grey">취소</a>
                </div>
            </article>
        </div>
    </div>
</section>
