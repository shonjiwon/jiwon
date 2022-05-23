<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-10
  Time: 오전 3:11
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
    // 전화번호 검색어
    var mob_no = '${searchVal8}';
    if(mob_no !== '') {
        var jbSplit = mob_no.split('-');
        $("#mob_1").val(jbSplit[0]);
        $("#mob_2").val(jbSplit[1]);
        $("#mob_3").val(jbSplit[2]);
    }

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
            $('input:checkbox[name=del_id]').prop("checked", true);
        } else {
            $('input:checkbox[name=del_id]').prop("checked", false);
        }
    });

    $('input:checkbox[name=del_id]').on("click", function(){
        let chk = true;
        $('input:checkbox[name=del_id]').each(function(){
            if (!$(this).is(":checked")) {
                chk = false;
            }
        });
        $('#allCheck').prop("checked", chk);
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
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/master/admin_list.do">
    <input type="hidden" name="page" id="page" value="${page}"/>
    <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
    <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
    <input type="hidden" name="searchVal8" id="searchVal8" value="${searchVal8}"/> <%-- 휴대폰번호 --%>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
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
                <label for="searchVal4">관리자유형</label>
                <select id="searchVal4" name="searchVal4" class="wid150">
                    <option value="">전체</option>
                    <option value="S" <c:if test="${searchVal4 eq 'S'}">selected="selected"</c:if>>마스터관리자</option>
                    <option value="G" <c:if test="${searchVal4 eq 'G'}">selected="selected"</c:if>>기관관리자</option>
                    <option value="N" <c:if test="${searchVal4 eq 'N'}">selected="selected"</c:if>>일반관리자</option>
                    <option value="B" <c:if test="${searchVal4 eq 'B'}">selected="selected"</c:if>>게시판관리자</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal5">가입경로</label>
                <select id="searchVal5" name="searchVal5" class="wid150">
                    <option value="">전체</option>
                    <option value="M" <c:if test="${searchVal5 eq 'M'}">selected="selected"</c:if>>마스터관리자</option>
                    <option value="U" <c:if test="${searchVal5 eq 'U'}">selected="selected"</c:if>>가입요청</option>
                </select>
            </div>
            <div class="formCont">
                <label for="searchVal6">생성여부</label>
                <select id="searchVal6" name="searchVal6" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchVal6 eq 'Y'}">selected="selected"</c:if>>Y</option>
                    <option value="N" <c:if test="${searchVal6 eq 'N'}">selected="selected"</c:if>>N</option>
                </select>
            </div>
        </div>
        <div class="line">
            <div class="formCont">
                <label for="searchVal7">사용여부</label>
                <select id="searchVal7" name="searchVal7" class="wid150">
                    <option value="">전체</option>
                    <option value="Y" <c:if test="${searchVal7 eq 'Y'}">selected="selected"</c:if>>사용</option>
                    <option value="N" <c:if test="${searchVal7 eq 'N'}">selected="selected"</c:if>>미사용</option>
                </select>
            </div>
            <div class="formCont">
                <label for="mob_1">휴대폰번호</label>
                <input type="text" id="mob_1" title="휴대폰번호" class="wid50" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                -
                <input type="text" id="mob_2" title="휴대폰번호" class="wid50" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                -
                <input type="text" id="mob_3" title="휴대폰번호" class="wid50" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
            </div>
            <div class="formCont">
                <label for="searchKind">검색</label>
                <select id="searchKind" name="searchKind" class="wid150">
                    <option value="ALL">전체</option>
                    <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>이름</option>
                    <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>아이디</option>
                </select>
                <input type="text" name="searchVal" id="searchVal" value="${searchVal}" title="검색어 입력" class="wid350">
                <a href="#none" class="btn orange" id="btn_search">검색</a>
            </div>
        </div>
    </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="totalNum">
            총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
        </div>
        <table>
            <colgroup>
                <col style="width:5rem">
                <col>
                <col style="width:10rem">
                <col style="width:12rem">
                <col style="width:15rem">
                <col style="width:20rem">
                <col style="width:12rem">
                <col style="width:12rem">
                <col style="width:12rem">
                <col style="width:10rem">
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>휴대폰번호</th>
                <th>소속</th>
                <th>부서/교육장/기관</th>
                <th>관리자유형</th>
                <th>가입경로</th>
                <th>생성여부</th>
                <th>사용여부</th>
                <th>최근접속일자</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="11">등록된 데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
            <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td><a href="/ssemadmin/cont/master/admin_view.do?admin_id=${item.admin_id}">${item.name}</a> </td>
                    <td>${item.admin_id}</td>
                    <td>${item.mob_no}</td>
                    <td>${item.p_name}</td>
                    <td>${item.grp_name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.type eq 'S'}">마스터관리자</c:when>
                            <c:when test="${item.type eq 'G'}">기관관리자</c:when>
                            <c:when test="${item.type eq 'N'}">일반관리자</c:when>
                            <c:when test="${item.type eq 'B'}">게시판관리자</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.apy_path eq 'M'}">마스터관리자</c:when>
                            <c:when test="${item.apy_path eq 'U'}">가입요청</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.app_yn eq 'Y'}">Y</c:when>
                            <c:when test="${item.app_yn eq 'N'}">N</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status eq 'Y'}">사용</c:when>
                            <c:when test="${item.status eq 'N'}">미사용</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${fn:substring(item.last_login_dt, 0, 10)}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="right">
                <a href="/ssemadmin/cont/master/admin_inscr.do" class="btn red" id="btn_insert">등록</a>
            </div>
        </div>
    </article>
</div>
