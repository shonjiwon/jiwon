<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-19
  Time: 오후 3:35
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
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            } else {
                $('#group_idx').children().remove();
                $('#group_idx').append(html);
            }
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

        var teacher_idx = "";
        var teacher_name = "";

        $("input[type=radio]").change(function() {
            teacher_idx = $(this).attr('id');
            teacher_name = $(this).val();
        });

        $("#btn_select").click(function(){
            if(teacher_idx !== "") {
                $(opener.document).find("#teacher_idx").val(teacher_idx);
                $(opener.document).find("#teacher_nm").val(teacher_name);
                window.close();
            } else {
                alert("강사정보를 선택해 주세요.");
            }
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
        <form name="frm" id="frm" method="post" action="/ssemadmin/popup/teacher/teacher_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/> <%-- 소속 --%>
            <input type="hidden" name="searchVal3" id="searchVal3" value="${searchVal3}"/> <%-- 부서 --%>
            <input type="hidden" name="searchVal8" id="searchVal8" value="${searchVal8}"/> <%-- 휴대폰번호 --%>
        <article class="contUnit sch_area">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>강사선택</h3>
                </div>
                <div class="right">
                </div>
            </div>
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
                    <label for="searchVal4">교육분야</label>
                    <select id="searchVal4" name="searchVal4" class="wid150">
                        <option value="">전체</option>
                        <c:forEach items="${codeList}" var="code" varStatus="status">
                            <option value="${code.code_idx}" <c:if test="${searchVal4 eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="formCont">
                    <label for="searchVal5">강의만족도</label>
                    <select id="searchVal5" name="searchVal5" class="wid150">
                        <option value="">전체</option>
                        <option value="G" <c:if test="${searchVal5 eq 'G'}">selected="selected"</c:if>>금</option>
                        <option value="S" <c:if test="${searchVal5 eq 'S'}">selected="selected"</c:if>>은</option>
                        <option value="B" <c:if test="${searchVal5 eq 'B'}">selected="selected"</c:if>>동</option>
                    </select>
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="searchVal7">성별</label>
                    <select id="searchVal7" name="searchVal7" class="wid200">
                        <option value="">전체</option>
                        <option value="M" <c:if test="${searchVal7 eq 'M'}">selected="selected"</c:if>>남</option>
                        <option value="F" <c:if test="${searchVal7 eq 'F'}">selected="selected"</c:if>>여</option>
                    </select>
                </div>
                <div class="formCont">
                    <label for="mob_1">휴대폰</label>
                    <input type="text" id="mob_1" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_2" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_3" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </div>
                <div class="formCont">
                    <label for="searchKind">검색</label>
                    <select id="searchKind" name="searchKind" class="wid100">
                        <option value="ALL">전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>이름</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>전문분야</option>
                    </select>
                    <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid250" value="${searchVal}">
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
                    <th>소속</th>
                    <th>교육기관</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>휴대폰</th>
                    <th>교육분야</th>
                    <th>전문분야</th>
                    <th>강의만족도</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(itemList) == 0}">
                    <tr>
                        <td colspan="10">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:set var="lno" value="0"/>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <c:set var="lno">${lno + 1}</c:set>
                    <tr>
                        <td><input type="radio" name="discount" id="${item.teacher_idx}" value="${item.name}" /></td>
                        <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                        <td>${item.p_name}</td>
                        <td>${item.grp_name}</td>
                        <td class="ta_l">${item.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.gender eq 'M'}">남</c:when>
                                <c:when test="${item.gender eq 'F'}">여</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${item.mob_no}</td>
                        <td>${item.code_name}</td>
                        <td>${item.prof_field}</td>
                        <td>
                            <img src="/ssemadmin/resources/img/icon_medal_03.png" style="vertical-align:middle;"> (동메달)
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <common:pageLinkAdmin name="pageholder"/>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_select">선택</a>
                </div>
            </div>
        </article>
    </div>
</section>
