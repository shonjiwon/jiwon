<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-15
  Time: 오후 7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function () {
        var select_yn = '${hopeStudyVo.select_yn}';
        if(select_yn === 'Y') {
            $("#select_program").show();
        } else {
            $("#select_program").hide();
        }

        // 전화번호 검색어
        var mob_no = '${searchVal8}';
        if(mob_no !== '') {
            var jbSplit = mob_no.split('-');
            $("#mob_1").val(jbSplit[0]);
            $("#mob_2").val(jbSplit[1]);
            $("#mob_3").val(jbSplit[2]);
        }

        $("#btn_update").click(function(){
            var frm = document.frm;

            var select_yn = frm.select_yn.value;
            if(select_yn === 'Y') {
                if(frm.lecture_idx.value === '') {
                    modalMsg("[프로그램검색]을 눌러 프로그램을 등록해 주세요.", "notice", "");
                    return false;
                }
            }

            $("#frm").submit();
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });

        $("input[name=select_yn]").change(function() {
            var radio_val = $(this).val();
            if(radio_val === 'Y') {
                $("#select_program").show();
            } else {
                $("#select_program").hide();
            }
        });

        $("#list_type").change(function() {
            var type = $(this).val();
            if(type === 'A') {
                location.href="/ssemadmin/cont/magnet/hope_study_join_list.do?hope_study_idx=${hopeStudyVo.hope_study_idx}";
            } else {
                location.href="/ssemadmin/cont/magnet/hope_study_teach_list.do?hope_study_idx=${hopeStudyVo.hope_study_idx}";
            }
        });

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
                        var param = $("#frm_list").serialize();
                        document.location.href="/ssemadmin/cont/excel/hope_study_join_list_excel.do?" + param;
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

    function delete_frm() {
        document.delfrm.submit();
    }

    function pop_program() {
        var url = "/ssemadmin/popup/magnet/program_list.do";
        window.open(url, 'popup_program', 'width=1200, height=690, scrollbars=0, toolbar=0, menubar=no');
    }

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
        $("#frm_list").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>배우고싶어요</h2>
        <p class="depth">HOME<span class="arrow">></span>마그넷스쿨관리<span class="arrow">></span>배우고싶어요<span class="arrow">></span>상세</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>신청자 정보</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>이름</th>
                <td>${hopeStudyVo.apy_name}</td>
                <th>신청자ID</th>
                <td>${hopeStudyVo.apy_id}</td>
                <th>휴대폰번호</th>
                <td>${hopeStudyVo.apy_mob_no}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">(${hopeStudyVo.postcode}) ${hopeStudyVo.apy_addr1} ${hopeStudyVo.apy_addr2}</td>
                <th>단체명/인원</th>
                <td>
                    <span class="co_red">${hopeStudyVo.grp_name}</span> / <span class="co_red">${hopeStudyVo.grp_cnt}</span>명
                </td>
            </tr>
            </tbody>
        </table>
    </article>
    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/magnet/hope_study_delete.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="hope_study_idx" value="${hopeStudyVo.hope_study_idx}" />
    </form>
    <form name="frm" id="frm" action="/ssemadmin/cont/magnet/hope_study_view.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="hope_study_idx" value="${hopeStudyVo.hope_study_idx}"/>
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>청원정보</h3>
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
                    <th>등록일</th>
                    <td>${fn:substring(hopeStudyVo.reg_dt, 0, 10)}</td>
                    <th>정원마감일</th>
                    <td>${hopeStudyVo.close_dt}</td>
                </tr>
                <tr>
                    <th>희망강의명</th>
                    <td colspan="3">${hopeStudyVo.name}</td>
                </tr>
                <tr>
                    <th>희망요일</th>
                    <td colspan="3">${hopeStudyVo.week}</td>
                </tr>
                <tr>
                    <th>상세내용</th>
                    <td colspan="3">
                        ${hopeStudyVo.cont}
                    </td>
                </tr>
                <tr>
                    <th>청원선정여부</th>
                    <td colspan="3">
                        <input type="radio" name="select_yn" id="select_n" value="N" <c:if test="${hopeStudyVo.select_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="select_n">미선정</label>
                        <input type="radio" name="select_yn" id="select_y" value="Y" <c:if test="${hopeStudyVo.select_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="select_y">선정</label>
                        <div class="btnArea" id="select_program">
                            <input type="hidden" id="lecture_idx" name="lecture_idx" value="${hopeStudyVo.lecture_idx}">
                            <a href="#none" class="btn grey sml" onclick="pop_program()">프로그램 검색</a>
                            <input type="text" class="wid450" id="lecture_name" value="${hopeStudyVo.program_name}" disabled><br/>
                            <%--<span class="co_red mgl20">홍길동 쉐프와 함께하는 XX만들기</span>--%>
                            <p class="mgt10">* 청원게시물 선정 시, [프로그램검색]을 눌러 개설된 청원강좌를 등록(연결)해 주세요.</p>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <div class="left">
                    <a href="/ssemadmin/cont/magnet/hope_study_list.do" class="btn">목록</a>
                </div>
                <div class="right">
                    <a href="#none" class="btn red" id="btn_update">저장</a>
                    <a href="#none" class="btn grey" id="btn_delete">삭제</a>
                </div>
            </div>
        </article>
    </form>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>참여자 리스트 (함께 참여하기/가르칠 수 있어요)</h3>
            </div>
            <div class="right">
            </div>
        </div>

        <form name="frm_list" id="frm_list" action="/ssemadmin/cont/magnet/hope_study_join_list.do?hope_study_idx=${hopeStudyVo.hope_study_idx}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <input type="hidden" name="searchVal2" id="searchVal2" value="${hopeStudyVo.hope_study_idx}"/> <%-- 배우고싶어요 --%>
            <input type="hidden" name="searchVal8" id="searchVal8" value="${searchVal8}"/> <%-- 휴대폰번호 --%>
            <input type="hidden" name="hope_study_idx" value="${hopeStudyVo.hope_study_idx}"/>
            <input type="hidden" name="searchVal10" id="searchVal10" />
        <article class="contUnit sch_area">
            <div class="line">
                <div class="formCont">
                    <label for="list_type">참여형태</label>
                    <select id="list_type" class="wid150">
                        <option value="A" selected="selected">함께해요</option>
                        <option value="B">가르칠 수 있어요</option>
                    </select>
                </div>
            </div>
            <div class="line">
                <div class="formCont">
                    <label for="mob_1">휴대폰번호</label>
                    <input type="text" id="mob_1" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_2" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" id="mob_3" title="휴대폰번호" class="wid80" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </div>
                <div class="formCont">
                    <label for="searchKind">검색</label>
                    <select id="searchKind" name="searchKind" class="wid150">
                        <option value="ALL" <c:if test="${searchKind eq 'ALL'}">selected="selected"</c:if>>전체</option>
                        <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>이름</option>
                        <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>아이디</option>
                    </select>
                    <input type="text" id="searchVal" name="searchVal" placeholder="검색어 입력" class="wid200" value="${searchVal}">
                    <a href="#none" class="btn orange" id="btn_search">검색</a>
                </div>
            </div>
        </article>
        </form>

        <div class="btnArea mgt30 mgb10 of_h">
            <div class="left">
                <div class="totalNum">
                    총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
                </div>
            </div>
            <div class="right">
                <a href="#none" class="btn sml green popExcel" id="pop_exelDown">엑셀다운로드</a>
            </div>
        </div>

        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:8%">
                <col style="width:8%">
                <col style="width:10%">
                <col>
                <col style="width:10%">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>휴대폰번호</th>
                <th>주소</th>
                <th>등록일</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="6">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.apy_name}</td>
                    <td>${item.apy_id}</td>
                    <td>${item.apy_mob_no}</td>
                    <td>(${item.postcode}) ${item.apy_addr1} ${item.apy_addr2}</td>
                    <td>${fn:substring(item.reg_dt, 0, 10)}</td>
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
                    <input type="hidden" name="level2" id="level2" value="배우고싶어요"/>
                    <input type="hidden" name="level3" id="level3" value="함께해요"/>
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
