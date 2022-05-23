<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 6:43
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
        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${searchVal2}';
        let group_idx = '${searchVal3}';
        if(p_idx !== '' && group_idx !== '') {
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
                        html += '<option value="">전체</option>';
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
                        html += '<option value="">전체</option>';
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
                        html += '<option value="">전체</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
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

        // 전체선택
        $('#allCheck').click(function(){
            if ($("#allCheck").is(":checked")) {
                $('input:checkbox[name=main_id]').prop("checked", true);
            } else {
                $('input:checkbox[name=main_id]').prop("checked", false);
            }
        });

        $('input:checkbox[name=main_id]').on("click", function(){
            let chk = true;
            $('input:checkbox[name=main_id]').each(function(){
                if (!$(this).is(":checked")) {
                    chk = false;
                }
            });
            $('#allCheck').prop("checked", chk);
        });

        // 메인노출 버튼 클릭시
        $("#btn_main").click(function(){
            let checkCnt = $("input[name=main_id]:checked").size();
            if(checkCnt == 0){
                alert("게시물을 선택해 주세요.");
                return false;
            } else if(checkCnt > 4) {
                alert("메인노출 게시물의 개수는 최대 4개 입니다.");
                return false;
            }
            if(confirm("선택한 데이터를 메인에 노출시겠습니까?.")) {
                let data = $("#mainfrm").serialize();
                $.ajax({
                    url: '/ssemadmin/ajax/main_use_setting.do',
                    type: 'POST',
                    dataType: 'json',
                    data: data,
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("저장에 실패하였습니다.");
                        } else {
                            alert("저장하였습니다.");
                            location.href = "?page=1";
                        }
                    }
                });
            }
        });

        $('#allCheck_Y').click(function(){
            if ($("#allCheck_Y").is(":checked")) {
                $('input:checkbox[name=main_y_id]').prop("checked", true);
            } else {
                $('input:checkbox[name=main_y_id]').prop("checked", false);
            }
        });

        $('input:checkbox[name=main_y_id]').on("click", function(){
            let chk = true;
            $('input:checkbox[name=main_y_id]').each(function(){
                if (!$(this).is(":checked")) {
                    chk = false;
                }
            });
            $('#allCheck_Y').prop("checked", chk);
        });

        // 메인노출 취소 버튼 클릭시
        $("#btn_main_cancel").click(function(){
            let checkCnt = $("input[name=main_y_id]:checked").size();
            if(checkCnt == 0){
                alert("게시물을 선택해 주세요.");
                return false;
            }
            if(confirm("선택한 데이터를 메인 노출 취소시겠습니까?.")) {
                let data = $("#mainNfrm").serialize();
                $.ajax({
                    url: '/ssemadmin/ajax/main_cancel_setting.do',
                    type: 'POST',
                    dataType: 'json',
                    data: data,
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("저장에 실패하였습니다.");
                        } else {
                            alert("저장하였습니다.");
                            location.href = "?page=1";
                        }
                    }
                });
            }
        });

        $("#btn_ord").click(function(){
            $("#mainNfrm").submit();
        });

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            if (event.keyCode === 13) {
                goSearch();
            }
        });

        $("select[id=p_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            $("#page").val("1");
        });

        $("select[id=group_idx]").change(function() {
            // 소속 검색 조건 정리
            let p_idx = $('#p_idx').val();
            $('#searchVal2').val(p_idx);
            // 부서 검색 조건 정리
            let group_idx = $('#group_idx').val();
            $('#searchVal3').val(group_idx);

            $("#page").val("1");
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>메인화면 노출관리</h3>
            </div>
            <div class="right">
                <a href="#none" class="btn grey" id="btn_main_cancel">메인 노출 선택 취소</a>
                <a href="#none" class="btn blue" id="btn_ord">순서변경</a>
            </div>
        </div>
        <ul class="list star">
            <li>메인노출 설정 게시물은  송파쌤 교육포털 메인화면에 노출됩니다. (최대 4개)</li>
            <li>우측 ‘순서’ 항목에서 숫자(1~4)를 입력하고, [순서변경]버튼을 클릭하면 노출순서가 변경 됩니다.</li>
            <li>설정 된 메인공지가 없거나 4개 미만인  경우, 메인화면 공지영역에는 일반공지 중 최신게시물이 채워져 노출 됩니다.</li>
        </ul>
        <form id="mainNfrm" name="mainNfrm" method="post" action="/ssemadmin/cont/site/notice_ord.do" enctype="multipart/form-data">
        <table>
            <colgroup>
                <col style="width:5%">
                <col style="width:8%">
                <col style="width:12%">
                <col style="width:15%">
                <col>
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:5%">
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" name="allCheck_Y" id="allCheck_Y"></th>
                <th>번호</th>
                <th>소속</th>
                <th>기관(교육장)</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>노출순서</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${mainList}" var="item" varStatus="status">
                <tr>
                    <td><input type="checkbox" name="main_y_id" id="main_y_id_${item.bbs_detail_idx}" value="${item.bbs_detail_idx}"></td>
                    <td><fmt:formatNumber value="${status.count}" pattern="##,###"/></td>
                    <td>${item.p_name}</td>
                    <td>${item.grp_name}</td>
                    <td class="ta_l">${item.title}</td>
                    <td>${item.reg_id}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                    <td>
                        <input type="hidden" class="wid100per ta_c" name="ordList[${status.index}].idx" id="ordList[${status.index}].idx" value="${item.bbs_detail_idx}">
                        <input type="text" class="wid100per ta_c" name="ordList[${status.index}].val" id="ordList[${status.index}].val" value="${item.pt_ord}" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
    </article>

    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/site/notice_list.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
        <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>공지사항 목록 (전체)</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="p_idx">소속</label>
                <select id="p_idx" name="p_idx">
                    <option value="">전체</option>
                    <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                        <option value="${item.group_idx}" <c:if test="${item.group_idx eq searchVal2}">selected="selected"</c:if>>${item.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="formCont">
                <label for="group_idx">기관/교육장</label>
                <select id="group_idx" name="group_idx">
                    <option value="">전체</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchKind2">메인노출여부</label>
                <select id="searchKind2" name="searchKind2" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchKind2 eq 'Y'}">selected="selected"</c:if>>Y</option>
                    <option value="N" <c:if test="${searchKind2 eq 'N'}">selected="selected"</c:if>>N</option>
                </select>
            </div>
        </div>
        <div class="line">
            <div class="formCont">
                <label for="searchKind3">상단고정노출여부</label>
                <select id="searchKind3" name="searchKind3" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchKind3 eq 'Y'}">selected="selected"</c:if>>상단고정</option>
                    <option value="N" <c:if test="${searchKind3 eq 'N'}">selected="selected"</c:if>>일반</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchKind2">노출상태</label>
                <select id="searchKind4" name="searchKind4" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchKind4 eq 'Y'}">selected="selected"</c:if>>노출</option>
                    <option value="N" <c:if test="${searchKind4 eq 'N'}">selected="selected"</c:if>>미노출</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal">제목검색</label>
                <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid300" value="${searchVal}">
                <a href="#none" class="btn orange" id="btn_search">검색</a>
            </div>
        </div>
    </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <div class="totalNum">
                    총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                </div>
            </div>
            <div class="right">
                <a href="#none" class="btn grey" id="btn_main">메인 노출 선택</a>
                <a href="/ssemadmin/cont/site/notice_inscr.do" class="btn red">등록</a>
            </div>
        </div>
        <ul class="list star">
            <li>공지사항을 선택(좌측 체크박스)하고 [메인노출] 버튼을 누르면 선택된 공지사항이 메인화면에 노출 됩니다. <span class="co_red">(최대 4개)</span> </li>
        </ul>
        <form id="mainfrm" name="mainfrm">
        <table>
            <colgroup>
                <col style="width:5%">
                <col style="width:5%">
                <col style="width:8%">
                <col style="width:12%">
                <col>
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:5%">
                <col style="width:8%">
                <col style="width:5%">
                <col style="width:5%">
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" name="allCheck" id="allCheck"></th>
                <th>번호</th>
                <th>소속</th>
                <th>기관(교육장)</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>메인화면 노출여부</th>
                <th>상단고정 노출여부</th>
                <th>노출상태</th>
                <th>조회수</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="11">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><input type="checkbox" name="main_id" id="main_id_${item.bbs_detail_idx}" value="${item.bbs_detail_idx}"></td>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.p_name}</td>
                    <td>${item.grp_name}</td>
                    <td class="ta_l"><a href="/ssemadmin/cont/site/notice_view.do?bbs_detail_idx=${item.bbs_detail_idx}">${item.title}</a></td>
                    <td>${item.reg_id}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.main_use_yn eq 'Y'}">Y</c:when>
                            <c:when test="${item.main_use_yn eq 'N'}">N</c:when>
                            <c:otherwise>N</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.p_top_yn eq 'Y'}">상단고정</c:when>
                            <c:when test="${item.p_top_yn eq 'N'}">일반</c:when>
                            <c:otherwise>일반</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.use_yn eq 'Y'}">노출</c:when>
                            <c:when test="${item.use_yn eq 'N'}">미노출</c:when>
                            <c:otherwise>미노출</c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${item.cnt}" pattern="##,###"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <common:pageLinkAdmin name="pageholder"/>
    </article>
</div>
