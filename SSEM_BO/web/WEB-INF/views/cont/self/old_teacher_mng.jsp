<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-14
  Time: 오전 11:28
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
        // 엑셀 팝업 처리 /////////////////////////////////////////////////////////////////////////////////////
        var popExcel = $(".popExcel");
        popExcel.click(function() {
            $('#reason_txt').val("");
            $('#excel_pwd').val("");

            $("input:radio[name='reason']").removeAttr("checked");

            $(".pop_exelDown").addClass('on')
        });

        $('.btnClose').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_pop_close').click(function() {
            $('.popArea').removeClass('on')
        });

        $('#btn_excel_insert').click(function() {

            var frm = document.excel_frm;

            if(!fnIsValidRequired(frm.reason, "다운로드 사유")){return false;}

            if(frm.reason.value === '5') {
                if (!fnIsValidRequired(frm.reason_txt, "다운로드 사유")) {
                    return false;
                }
            }
            if(!fnIsValidRequired(frm.excel_pwd, "엑셀파일 비밀번호")){return false;}

            $.ajax({
                url: '/ssemadmin/cont/excel/private_insert.do',
                type: 'POST',
                dataType: 'json',
                data: $("#excel_frm").serialize(),
                xhrFields: {
                    withCredentials: true
                },
                async: false,
                success: function (data) {
                    if (data !== 0) {
                        alert("등록되었습니다");
                        // 엑셀 다운로드
                        $("#searchVal10").val($("#excel_pwd").val());
                        var param = $("#frm").serialize();
                        document.location.href="/ssemadmin/cont/excel/old_teacher_mng.do?" + param;
                    } else {
                        alert("등록에 실패하였습니다.");
                    }
                }
            });

            $('.popArea').removeClass('on')
        });

        $("input[name=reason]").change(function() {
            var radio_val = $(this).val();
            if(radio_val === '5') {
                $('#reason_txt').removeAttr("disabled");
                $('#reason_txt').focus();
            } else {
                $('#reason_txt').attr("disabled", true);
            }
        });

        $('#reason_txt').keyup(function (event) {
            if($(this).val().length > 30) {
                if(event.keyCode !== 8) {
                    alert("30자까지만 입력이 가능합니다.");
                }
                $('#reason_txt').val($('#reason_txt').val().substr(0, $('#reason_txt').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });

        $('#reason_txt').keydown(function (event) {
            if($(this).val().length > 30) {
                if(event.keyCode !== 8) {
                    alert("30자까지만 입력이 가능합니다.");
                }
                $('#reason_txt').val($('#reason_txt').val().substr(0, $('#reason_txt').val().length -1));
            } else {
                $('#txt_length').text($(this).val().length);
            }
        });
        /////////////////////////////////////////////////////////////////

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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" method="post" action="/ssemadmin/cont/self/old_teacher_mng.do">
        <input type="hidden" name="page" id="page" value="${page}"/>
        <input type="hidden" name="searchVal10" id="searchVal10" />
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
            <span class="mgl10 co_red" style="font-size:12px;">*(구)자치회관 관리 메뉴는 조회만 가능합니다. (생성, 수정, 삭제 불가)</span>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="searchKind">동별</label>
                <c:choose>
                    <c:when test="${adminLoginVo.type eq 'S'}">
                        <select id="searchKind" name="searchKind" class="wid150">
                            <option value="">전체</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.code}" <c:if test="${searchKind eq dong.code}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select id="searchKind" name="searchKind" class="wid150" disabled>
                            <option value="">전체</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.code}" <c:if test="${fn:contains(adminLoginVo.grp_name, dong.name)}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
                <select id="searchKind2" name="searchKind2" class="wid150">
                    <option value="">::분야::</option>
                    <option value="10100001" <c:if test="${searchKind2 eq '10100001'}">selected="selected"</c:if>>어학</option>
                    <option value="10100002" <c:if test="${searchKind2 eq '10100002'}">selected="selected"</c:if>>전통</option>
                    <option value="10100003" <c:if test="${searchKind2 eq '10100003'}">selected="selected"</c:if>>공예</option>
                    <option value="10100004" <c:if test="${searchKind2 eq '10100004'}">selected="selected"</c:if>>댄스</option>
                    <option value="10100005" <c:if test="${searchKind2 eq '10100005'}">selected="selected"</c:if>>체조/체육</option>
                    <option value="10100006" <c:if test="${searchKind2 eq '10100006'}">selected="selected"</c:if>>미술/음악</option>
                    <option value="10100007" <c:if test="${searchKind2 eq '10100007'}">selected="selected"</c:if>>어린이/청소년</option>
                    <option value="10100008" <c:if test="${searchKind2 eq '10100008'}">selected="selected"</c:if>>기타</option>
                    <option value="10100009" <c:if test="${searchKind2 eq '10100009'}">selected="selected"</c:if>>주민자치교육</option>
                </select>
                <select id="searchKind3" name="searchKind3" class="wid150">
                    <option value="">구분</option>
                    <option value="10200001" <c:if test="${searchKind3 eq '10200001'}">selected="selected"</c:if>>일반</option>
                    <option value="10200002" <c:if test="${searchKind3 eq '10200002'}">selected="selected"</c:if>>자원봉사자</option>
                </select>
            </div>
            <div class="formCont">
                <select id="searchKind4" name="searchKind4" class="wid150">
                    <option value="1" <c:if test="${searchKind4 eq '1'}">selected="selected"</c:if>>강사명</option>
                    <option value="2" <c:if test="${searchKind4 eq '2'}">selected="selected"</c:if>>프로그램명</option>
                </select>
                <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid200" value="${searchVal}">
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
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:4%">
                <col style="width:8%">
                <col style="width:8%">
                <col style="width:8%">
                <col>
                <col style="width:8%">
                <col style="width:8%">
                <col style="width:15%">
                <col style="width:15%">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>동별</th>
                <th>분야</th>
                <th>구분</th>
                <th>프로그램명</th>
                <th>강사명</th>
                <th>성별</th>
                <th>생년월일<br>연락처</th>
                <th>협약일<br>만료일</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="9">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.dong_cd}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.div_cd eq '10100001'}">어학</c:when>
                            <c:when test="${item.div_cd eq '10100002'}">전통</c:when>
                            <c:when test="${item.div_cd eq '10100003'}">공예</c:when>
                            <c:when test="${item.div_cd eq '10100004'}">댄스</c:when>
                            <c:when test="${item.div_cd eq '10100005'}">체조/체육</c:when>
                            <c:when test="${item.div_cd eq '10100006'}">미술/음악</c:when>
                            <c:when test="${item.div_cd eq '10100007'}">어린이/청소년</c:when>
                            <c:when test="${item.div_cd eq '10100008'}">기타</c:when>
                            <c:when test="${item.div_cd eq '10100009'}">주민자치교육</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.field_cd eq '10200001'}">일반</c:when>
                            <c:otherwise>자원봉사자</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.prog_nm}</td>
                    <td><a href="/ssemadmin/cont/self/old_teacher_mng_view.do?lecturer_seq=${item.lecturer_seq}">${item.lecturer_nm}</a></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.sex eq 'M'}">남</c:when>
                            <c:otherwise>여</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.birthday}<br/>${item.mobile_no}</td>
                    <td>${item.agree_sdate}<br/>${item.agree_edate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
    </article>
</div>

<!-- popup -->
<section class="popArea pop_exelDown">
    <div class="popBody">
        <div class="tit">
            <h2>엑셀파일 다운로드 사유등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
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
                <form name="excel_frm" id="excel_frm" method="post" action="/ssemadmin/cont/excel/private_insert.do">
                    <input type="hidden" name="level1" id="level1" value="${topMenu.name}"/>
                    <input type="hidden" name="level3" id="level3" value="${currentMenu.name}"/>
                    <table>
                        <colgroup>
                            <col style="width:5rem">
                            <col style="width:5rem">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="required">다운로드 사유</th>
                            <td style="line-height: 3.0rem !important;">
                                <input type="radio" name="reason" id="reason_1" value="1">
                                <label for="reason_1">교육 프로그램 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_2" value="2">
                                <label for="reason_2">시설 및 장비 대여 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_3" value="3">
                                <label for="reason_3">온라인 상담 예약 관련 업무</label><br>
                                <input type="radio" name="reason" id="reason_4" value="4">
                                <label for="reason_4">구민(회원) 민원처리</label><br>
                                <input type="radio" name="reason" id="reason_5" value="5">
                                <label for="reason_5">기타(직접입력)</label><br>
                                <input type="text" class="wid300" name="reason_txt" id="reason_txt" disabled> <span class="co_red" id="txt_length">0</span>/30
                            </td>
                        </tr>
                        <tr>
                            <th class="required">엑셀파일 비밀번호 생성</th>
                            <td>
                                <input type="text" name="excel_pwd" id="excel_pwd" onkeyup="fnIsValidNumPwd(this);" onkeydown="fnIsValidNumPwd(this);">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div>
                    <ul class="list bili">
                        <li>비밀번호 는 <span class="co_red">숫자로만 입력 가능하며, 최대 4자리까지</span> 생성하실 수 있습니다.</li>
                    </ul>
                </div>
                <div class="btnArea ta_c">
                    <a href="#none" class="btn red" id="btn_excel_insert">등록</a>
                    <a href="#none" class="btn grey" id="btn_pop_close">취소</a>
                </div>
            </article>
        </div>
    </div>
</section>
