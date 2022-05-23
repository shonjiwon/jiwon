<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-28
  Time: 오전 4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/main.js'></script>
<script src='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/locales-all.js'></script>

<link rel='stylesheet' href='/ssemadmin/resources/plugins/fullcalendar-5.4.0/lib/main.css' />
<script type="text/javascript">
    $(document).ready(function() {
        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${searchVal2}';
        let group_idx = '${searchVal3}';
        let study_place_idx = '${searchVal4}';
        if(p_idx !== '' && group_idx !== '' && study_place_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">교육기관선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx').append(html);
                    }
                });

                html = '';
                $.ajax({
                    url: "/ssemadmin/ajax/room_list.do?group_idx=" + group_idx,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#study_place_idx').children().remove();
                        html += '<option value="">강의실 선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['study_place_idx'];
                            if (idx === Number(study_place_idx)) {
                                html += '<option value="' + v['study_place_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['study_place_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#study_place_idx').append(html);
                    }
                });
            }
        } else if(p_idx !== '' && group_idx !== '' && study_place_idx === '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">교육기관선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx').append(html);
                    }
                });

                html = '';
                $.ajax({
                    url: "/ssemadmin/ajax/room_list.do?group_idx=" + group_idx,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#study_place_idx').children().remove();
                        html += '<option value="">강의실 선택</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['study_place_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#study_place_idx').append(html);
                    }
                });
            }
        } else if(p_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async: false,
                    success: function (data) {
                        $('#group_idx').children().remove();
                        html += '<option value="">교육기관선택</option>';
                        $.each(data, function (key, v) {
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        }

        $('#p_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">교육기관선택</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            } else {
                $('#group_idx').children().remove();
                html += '<option value="">전체</option>';
                $('#group_idx').append(html);
            }
        });

        $('#group_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/room_list.do?group_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#study_place_idx').children().remove();
                        html += '<option value="">강의실 선택</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['study_place_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#study_place_idx').append(html);
                    }
                });
            } else {
                $('#study_place_idx').children().remove();
                html += '<option value="">강의실 선택</option>';
                $('#study_place_idx').append(html);
            }
        });

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
                    window.open(info.event.url, 'popup_room', 'width=900, height=380, scrollbars=0, toolbar=0, menubar=no');
                } else {
                    location.href = info.event.url;
                }
            }
        });
        calendar.render();

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);
            // 강의실 선택
            let study_place_idx = $('#study_place_idx').val();
            $('#searchVal4').val(study_place_idx);

            if(study_place_idx === '') {
                modalMsg("강의실을 선택해 주세요.", "notice", "");
                return;
            }
            goSearch();
        });

        $("select[id=p_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);
            // 강의실 선택
            let study_place_idx = $('#study_place_idx').val();
            $('#searchVal4').val(study_place_idx);
        });

        $("select[id=group_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);
            // 강의실 선택
            let study_place_idx = $('#study_place_idx').val();
            $('#searchVal4').val(study_place_idx);
        });

        $("select[id=study_place_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);
            // 강의실 선택
            let study_place_idx = $('#study_place_idx').val();
            $('#searchVal4').val(study_place_idx);
        });
        /////////////////////////////////////////////////////////////////

        // 입력 문자열 계산 //////////////////////////////////////////////////////////////////////////////////////////
        $('#name').keyup(function (event) {
            if($(this).val().length > 50) {
                if(event.keyCode !== 8) {
                    alert("50자까지만 입력이 가능합니다.");
                }
                $('#name').val($('#title').val().substr(0, $('#name').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        $('#name').keydown(function (event) {
            if($(this).val().length > 50) {
                if(event.keyCode !== 8) {
                    alert("50자까지만 입력이 가능합니다.");
                }
                $('#name').val($('#title').val().substr(0, $('#name').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        let name = $('#name').val();
        if(!isEmpty(name) && name !== '') {
            $('#txt_length').text(name.length);
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        $("#frm").submit();
    }

    function pop_room_insert() {
        let study_place_idx = '${searchVal4}';
        if(study_place_idx === '') {
            modalMsg("강의실을 선택하여 검색해 주세요.", 'notice', '');
            return;
        }

        var url = "/ssemadmin/popup/lecture/reg_room_insert.do?study_place_idx=" + study_place_idx;
        window.open(url, 'popup_room', 'width=900, height=500, scrollbars=0, toolbar=0, menubar=no');
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/lecture/room_status.do">
        <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
        <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
        <input type="hidden" name="searchVal4" id="searchVal4" value="${searchVal4}"/> <%-- 강의실 --%>
        <article class="contUnit sch_area">
            <h3>
                <span class="material-icons">search</span> Search <small>검색</small>
            </h3>
            <div class="line">
                <div class="formCont">
                    <label for="p_idx">소속</label>
                    <select id="p_idx" name="p_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                        <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                            <option value="${item.group_idx}" <c:if test="${item.group_idx eq searchVal2}">selected="selected"</c:if>>${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <label for="group_idx">교육기관</label>
                    <select id="group_idx" name="group_idx" class="wid200" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                    </select>
                </div>
                <div class="formCont">
                    <label>강의실 선택</label>
                    <select id="study_place_idx" name="study_place_idx" class="wid200">
                        <option value="">강의실 선택</option>
                    </select>
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="mgl20">
                <h2>
                    <c:if test="${studyPlaceVo ne null}">
                        ${studyPlaceVo.name} (최대수용인원 : ${studyPlaceVo.max_qty})
                    </c:if>
                </h2>
            </div>
            <div class="right">
                <a href="#none" class="btn sml red" onclick="pop_room_insert()">일정추가</a>
            </div>
        </div>
    </article>
    <article class="contUnit">
        <div>
            <div id="calendar"></div>
        </div>
    </article>
</div>
