<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script src='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/main.js'></script>
<script src='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/locales-all.js'></script>

<link rel='stylesheet' href='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/main.css' />
<script type="text/javascript">
    $(document).ready(function() {

        var initialLocaleCode = 'ko';
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            themeSystem: 'standard',
            expandRows: true,
            initialView: 'timeGridWeek',
            headerToolbar: {
                left: 'prev next',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek today'
            },
            slotLabelFormat: {
                hour: '2-digit',
                minute: '2-digit',
                meridiem: 'short',
                hour12: false
            },
            slotDuration: '00:30:00',
            slotMinTime: '09:00:00',
            slotMaxTime: '21:00:00',
            locale: initialLocaleCode,
            buttonIcons: true,
            events: [
                <c:forEach items="${calList}" var="cal" varStatus="status">
                {
                    groupId: '${cal.groupId}',
                    title: '${cal.title}',
                    start: '${cal.start}',
                    end: '${cal.end}',
                    url: '${cal.url}',
                    color: '${cal.color}',
                    textColor: '${cal.textColor}',
                    /*textColor: '${cal.textColor}',*/
                    extendedProps : {
                        popup : '${cal.popup_yn}'
                    }
                },
                </c:forEach>
            ],
            eventClick: function(info) {
                info.jsEvent.preventDefault(); // don't let the browser navigate

                console.log(info.event.extendedProps.popup);
                if (info.event.extendedProps.popup === 'Y') {
                    window.open(info.event.url, 'popup_room', 'width=900, height=480, scrollbars=0, toolbar=0, menubar=no');
                } else {
                    location.href = info.event.url;
                }
            }
        });
        calendar.render();

        $(document).on("change","#select_view",function(){
            var val = $(this).val();
            if(val === 'C') {
                location.href="/ssemadmin/cont/campus/instrum_rental_calendar.do?rental_fty_idx=" + ${searchKind};
            } else {
                location.href="/ssemadmin/cont/campus/instrum_rental_itemlist.do?rental_fty_idx=" + ${searchKind};
            }
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
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/campus/instrum_rental_calendar.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="select_view" class="widAuto">형태</label>
                    <select id="select_view" class="wid150">
                        <option value="C">캘린더</option>
                        <option value="L">목록</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchKind" class="widAuto">시설</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <c:forEach items="${ftyList}" var="fty" varStatus="status">
                            <option value="${fty.rental_fty_idx}" <c:if test="${fty.rental_fty_idx eq searchKind}">selected="selected"</c:if>>${fty.name}</option>
                        </c:forEach>
                    </select>
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea">
            <div class="right">
                <a href="/ssemadmin/cont/campus/instrum_rental_list.do" class="btn grey">목록</a>
            </div>
        </div>
    </article>
    <article class="contUnit">
        <div>
            <div id="calendar"></div>
        </div>
    </article>
</div>
