<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:18
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
        $('#searchKind').change(function() {
            let select_val = $(this).val();
            $("#searchVal").val("1");
            $("#frm").submit();
        });

        $("input[id*='ch_']").change(function() {
            let select_val = $(this).val();
            let selector = "#ch_" + select_val;
            let selector_str = fn_selector_str(select_val);
            if($(selector).is(":checked")) {
                $("[id*='_" + selector_str + "']").prop('checked', true);
            } else {
                $("[id*='_" + selector_str + "']").prop('checked', false);
            }
        });

        $("input[id*='date_']").change(function() {
            let select_val = $(this).val();
            let selector = "#date_" + select_val;
            let selector_str = "item_" + select_val;

            if($(selector).is(":checked")) {
                $("[id^='" + selector_str + "']").prop('checked', true);
            } else {
                $("[id^='" + selector_str + "']").prop('checked', false);
            }
        });


        $("input[id='all_check']").change(function() {
            let select_val = $(this).val();
            let selector = "#ch_date_" + select_val;
            let selector_str = "item_" + select_val;

            if($('#all_check').is(":checked")) {
                $("input[type=checkbox]").prop('checked', true);
            } else {
                $("input[type=checkbox]").prop('checked', false);
            }
        });

        $("#btn_insert").click(function(){
            var frm = document.frm_insert;

            if(frm.rental_fty_idx.value === '') {
                return;
            }

            if(frm.group_idx.value === '') {
                return;
            }

            $("#frm_insert").submit();
        });
    });

    function goSearch() {
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }

    function selectMonth(month) {
        $("#searchVal").val(month);
        $("#frm").submit();
    }

    function fn_selector_str(str) {
        if(str === "a") { return "9"; }
        else if (str === "b") { return "10"; }
        else if (str === "c") { return "11"; }
        else if (str === "d") { return "12"; }
        else if (str === "e") { return "13"; }
        else if (str === "f") { return "14"; }
        else if (str === "g") { return "15"; }
        else if (str === "h") { return "16"; }
        else if (str === "i") { return "17"; }
        else if (str === "j") { return "18"; }
        else if (str === "k") { return "19"; }
        else if (str === "l") { return "20"; }
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/instrum_rental_schedule.do?rental_fty_idx=${rentalFtyVo.rental_fty_idx}">
        <input type="hidden" name="searchVal" id="searchVal"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label>시설명 : ${rentalFtyVo.name}</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <c:forEach items="${yearList}" var="year" varStatus="status">
                            <option value="${year}" <c:if test="${searchKind eq year}">selected="selected"</c:if>>${year}</option>
                        </c:forEach>
                    </select>
                    <a href="#none" onclick="selectMonth('1')" class="btn sml <c:if test="${searchVal eq '1'}">on</c:if>">1월</a>
                    <a href="#none" onclick="selectMonth('2')" class="btn sml <c:if test="${searchVal eq '2'}">on</c:if>">2월</a>
                    <a href="#none" onclick="selectMonth('3')" class="btn sml <c:if test="${searchVal eq '3'}">on</c:if>">3월</a>
                    <a href="#none" onclick="selectMonth('4')" class="btn sml <c:if test="${searchVal eq '4'}">on</c:if>">4월</a>
                    <a href="#none" onclick="selectMonth('5')" class="btn sml <c:if test="${searchVal eq '5'}">on</c:if>">5월</a>
                    <a href="#none" onclick="selectMonth('6')" class="btn sml <c:if test="${searchVal eq '6'}">on</c:if>">6월</a>
                    <a href="#none" onclick="selectMonth('7')" class="btn sml <c:if test="${searchVal eq '7'}">on</c:if>">7월</a>
                    <a href="#none" onclick="selectMonth('8')" class="btn sml <c:if test="${searchVal eq '8'}">on</c:if>">8월</a>
                    <a href="#none" onclick="selectMonth('9')" class="btn sml <c:if test="${searchVal eq '9'}">on</c:if>">9월</a>
                    <a href="#none" onclick="selectMonth('10')" class="btn sml <c:if test="${searchVal eq '10'}">on</c:if>">10월</a>
                    <a href="#none" onclick="selectMonth('11')" class="btn sml <c:if test="${searchVal eq '11'}">on</c:if>">11월</a>
                    <a href="#none" onclick="selectMonth('12')" class="btn sml <c:if test="${searchVal eq '12'}">on</c:if>">12월</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <form name="frm_insert" id="frm_insert" method="post" action="/ssemadmin/cont/campus/instrum_rental_schedule_insert.do" enctype="multipart/form-data">
            <input type="hidden" name="rental_fty_idx" id="rental_fty_idx" value="${rentalFtyVo.rental_fty_idx}"/>
            <input type="hidden" name="group_idx" id="group_idx" value="${rentalFtyVo.group_idx}"/>
            <input type="hidden" name="date" value="${searchKind}-${searchVal}"/>
        <table>
            <colgroup>
                <col style="width:15%">
                <col>
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <col style="width:6.5%;">
                <%--<col style="width:6.5%;">--%>
            </colgroup>
            <thead>
            <tr>
                <th>
                    일자<br>
                    <input type="checkbox" id="all_check">
                </th>
                <th>
                    요일
                    <%--<input type="checkbox" id="chechboxH01_02">--%>
                </th>
                <th>
                    09:00<br>
                    <input type="checkbox" id="ch_a" value="a">
                </th>
                <th>
                    10:00<br>
                    <input type="checkbox" id="ch_b" value="b">
                </th>
                <th>
                    11:00<br>
                    <input type="checkbox" id="ch_c" value="c">
                </th>
                <th>
                    12:00<br>
                    <input type="checkbox" id="ch_d" value="d">
                </th>
                <th>
                    13:00<br>
                    <input type="checkbox" id="ch_e" value="e">
                </th>
                <th>
                    14:00<br>
                    <input type="checkbox" id="ch_f" value="f">
                </th>
                <th>
                    15:00<br>
                    <input type="checkbox" id="ch_g" value="g">
                </th>
                <th>
                    16:00<br>
                    <input type="checkbox" id="ch_h" value="h">
                </th>
                <th>
                    17:00<br>
                    <input type="checkbox" id="ch_i" value="i">
                </th>
                <th>
                    18:00<br>
                    <input type="checkbox" id="ch_j" value="j">
                </th>
                <th>
                    19:00<br>
                    <input type="checkbox" id="ch_k" value="k">
                </th>
                <th>
                    20:00<br>
                    <input type="checkbox" id="ch_l" value="l">
                </th>
                <%--<th>
                    21:00<br>
                    <input type="checkbox" id="chechboxH01_15">
                </th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${dateList}" var="date" varStatus="status_date">
                <input type="hidden" name="dateList[${status_date.index}].date" value="${date.date}"/>
                <tr>
                    <td>
                        <b>${date.date}</b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="date_${date.date}" value="${date.date}">
                    </td>
                    <td>${date.week_str}</td>
                    <input type="hidden" name="dateList[${status_date.index}].week" value="${date.week_str}"/>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h9" id="item_${date.date}_9" value="${date.date}" <c:if test="${saveList[status_date.index].h9 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h10" id="item_${date.date}_10" value="${date.date}" <c:if test="${saveList[status_date.index].h10 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h11" id="item_${date.date}_11" value="${date.date}" <c:if test="${saveList[status_date.index].h11 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h12" id="item_${date.date}_12" value="${date.date}" <c:if test="${saveList[status_date.index].h12 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h13" id="item_${date.date}_13" value="${date.date}" <c:if test="${saveList[status_date.index].h13 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h14" id="item_${date.date}_14" value="${date.date}" <c:if test="${saveList[status_date.index].h14 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h15" id="item_${date.date}_15" value="${date.date}" <c:if test="${saveList[status_date.index].h15 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h16" id="item_${date.date}_16" value="${date.date}" <c:if test="${saveList[status_date.index].h16 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h17" id="item_${date.date}_17" value="${date.date}" <c:if test="${saveList[status_date.index].h17 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h18" id="item_${date.date}_18" value="${date.date}" <c:if test="${saveList[status_date.index].h18 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h19" id="item_${date.date}_19" value="${date.date}" <c:if test="${saveList[status_date.index].h19 eq 'Y'}">checked="checked"</c:if>></td>
                    <td><input type="checkbox" name="dateList[${status_date.index}].h20" id="item_${date.date}_20" value="${date.date}" <c:if test="${saveList[status_date.index].h20 eq 'Y'}">checked="checked"</c:if>></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/instrum_rental_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
