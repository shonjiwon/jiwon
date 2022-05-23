<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:17
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
        $('#btn_add_isnert').click(function() {
            let frm = document.frm_add;

            if(!fnIsValidRequired(frm.addr, "주소")){return false;}
            /*if(!fnIsValidRequired(frm.addr2, "주소")){return false;}*/
            if(!fnIsValidRequired(frm.name, "교육시설명")){return false;}

            $("#frm_add").submit();
        });

        $('#btn_add_pop').click(function() {
            $("#name").val("");
            $("#addr1").val("");
            $("#addr2").val("");
            $(".pop_add").addClass('on');
        });

        // 팝업 수정
        var popUpdateSubmit = $(".btn_item_update_submit");
        popUpdateSubmit.click(function() {
            var study_place_idx = $(this).attr('id').replaceAll("item_", "");
            var selector = "#frm_update_" + study_place_idx;

            var selector_tgt_name = "#tgt_name_" + study_place_idx;
            var selector_rate = "#rate_" + study_place_idx;

            $(selector).submit();
        });

        // 팝업 열기
        var popUpdate = $(".btn_item_update");
        popUpdate.click(function() {
            var discount_idx = $(this).attr('id');
            var selector = "#pop_update_" + discount_idx;

            $(selector).addClass('on')
        });

        // 팝업닫기
        $('.btnClose').click(function() {
            $('.popArea').removeClass('on');
        });

        $('.btn_pop_close').click(function() {
            $('.popArea').removeClass('on');
        });

        $("#check_same_addr").change(function(){
            if($("#check_same_addr").is(":checked")){
                var addr1 = $('#origin_addr1').val();
                var addr2 = $('#origin_addr2').val();

                $('#sub_addr1').val(addr1);
                $('#sub_addr2').val(addr2);
            }else{
                $('#sub_addr1').val("");
                $('#sub_addr2').val("");
            }
        });

        $(".check_same_addr").click(function(){
            if($(".check_same_addr").is(":checked")){
                var study_place_idx = $(this).attr('id').replaceAll("check_same_addr_", "");

                var addr1 = $('#origin_addr1').val();
                var addr2 = $('#origin_addr2').val();

                var select_addr1 = "#sub_addr1_" + study_place_idx;
                var select_addr2 = "#sub_addr2_" + study_place_idx;
                $(select_addr1).val(addr1);
                $(select_addr2).val(addr2);
            }else{
                /*$('#sub_addr1').val("");
                $('#sub_addr2').val("");*/
            }
        });

        // 삭제
        var popDeleteSubmit = $(".btn_item_delete");
        popDeleteSubmit.click(function() {
            var study_place_idx = $(this).attr('id').replaceAll("delete_", "");

            let frm = document.frm_delete;
            frm.study_place_idx.value = study_place_idx;

            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);

        });
    });

    function delete_frm() {
        document.frm_delete.submit();
    }
</script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }

                document.getElementById('sub_addr1').value = fullRoadAddr;
            }
        }).open();
    }

    function sample3_execDaumPostcode(idx) {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }

                var id = 'sub_addr1_' + idx;

                document.getElementById(id).value = fullRoadAddr;
            }
        }).open();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>${groupVo.p_name} - ${groupVo.name}</h3>
                </div>
            </div>
        </div>
        <table>
            <colgroup>
                <col>
                <col style="width:15%">
                <col style="width:15%">
            </colgroup>
            <thead>
            <tr>
                <th>주소</th>
                <th>연락처</th>
                <th>공간</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${groupVo.addr1} ${groupVo.addr2}</td>
                <td>${groupVo.tel_no}</td>
                <td>${totalCount}</td>
            </tr>
            </tbody>
        </table>
        <br/><br/>
        <form name="frm_delete" id="frm_delete" method="post" action="/ssemadmin/cont/lecture/room_delete.do" enctype="multipart/form-data">
            <input type="hidden" name="study_place_idx"/>
            <input type="hidden" name="group_idx" value="${groupVo.group_idx}"/>
        </form>
        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:20%">
                <col>
                <col style="width:20%">
                <col style="width:10%">
            </colgroup>
            <thead>
            <tr>
                <th>NO</th>
                <th>교육시설명</th>
                <th>교육시설주소</th>
                <th>최대수용인원</th>
                <th>적정사용인원</th>
                <th>수정/삭제</th>
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
                    <td>${item.name}</td>
                    <td>${item.addr} ${item.addr2}</td>
                    <td>${item.max_qty}</td>
                    <td>${item.gd_qty}</td>
                    <td>
                        <a href="#none" class="btn sml blue btn_item_update" id="${item.study_place_idx}">수정</a>
                        <a href="#none" class="btn sml blue btn_item_delete" id="delete_${item.study_place_idx}">삭제</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/lecture/room_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_add_pop">시설등록</a>
            </div>
        </div>
    </article>
</div>

<section class="popArea pop_add">
    <div class="popBody" style="width: 100rem !important;">
        <div class="tit">
            <h2>교육시설등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_add" id="frm_add" method="post" action="/ssemadmin/cont/lecture/room_inscr.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" id="group_idx" value="${groupVo.group_idx}"/>
                    <table>
                        <colgroup>
                            <col style="width:20rem">
                            <col>
                        </colgroup>
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <th class="required">소속</th>
                            <td class="ta_l">
                                ${groupVo.p_name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육기관</th>
                            <td class="ta_l">
                                ${groupVo.name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육시설장소</th>
                            <td class="ta_l">
                                <input type="text" class="wid350" name="addr" id="sub_addr1" placeholder="주소">&nbsp;&nbsp;<a href="#none" onclick="sample4_execDaumPostcode();" class="popMainOpen btn sml blue">주소찾기</a>
                                <input type="checkbox" class="mgl20" id="check_same_addr" /> 등록된 주소와 동일
                                <br/>
                                <input type="text" class="wid100per mgt10" name="addr2" id="sub_addr2" placeholder="상세주소">
                                <input type="hidden" id="origin_addr1" value="${groupVo.addr1}" />
                                <input type="hidden" id="origin_addr2" value="${groupVo.addr2}" />
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육시설명</th>
                            <td class="ta_l">
                                <input type="text" class="wid100per" name="name" placeholder="교육시설명">
                            </td>
                        </tr>
                        <tr>
                            <th>설명</th>
                            <td class="ta_l">
                                <textarea rows="2" class="wid100per" name="cont" id="cont" placeholder="설명"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>최대 수용인원</th>
                            <td class="ta_l">
                                <input type="text" class="wid120" name="max_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 명
                            </td>
                        </tr>
                        <tr>
                            <th>적정 수용인원</th>
                            <td class="ta_l">
                                <input type="text" class="wid120" name="gd_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 명
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey" id="btn_add_isnert">저장</a>
                        <a href="#none" class="btn red btn_pop_close">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>

<c:forEach items="${itemList}" var="item" varStatus="status">
<section class="popArea pop_update" id="pop_update_${item.study_place_idx}">
    <div class="popBody" style="width: 100rem !important;height: 110rem !important;">
        <div class="tit">
            <h2>교육시설등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont" style="max-height: 120rem !important;">
            <article class="contUnit tbl_area">
                <form name="frm_update_${item.study_place_idx}" id="frm_update_${item.study_place_idx}" method="post" action="/ssemadmin/cont/lecture/room_upscr.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" value="${item.group_idx}"/>
                    <input type="hidden" name="study_place_idx" value="${item.study_place_idx}"/>
                    <table>
                        <colgroup>
                            <col style="width:15%">
                            <col style="width:35%">
                            <col style="width:15%">
                            <col>
                        </colgroup>
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <th class="required">소속</th>
                            <td class="ta_l" colspan="3">
                                ${groupVo.p_name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육기관</th>
                            <td class="ta_l" colspan="3">
                                ${groupVo.name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육시설장소</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid350" name="addr" id="sub_addr1_${item.study_place_idx}" placeholder="주소" value="${item.addr}">&nbsp;&nbsp;<a href="#none" onclick="sample3_execDaumPostcode('${item.study_place_idx}');" class="popMainOpen btn sml blue">주소찾기</a>
                                <input type="checkbox" class="mgl20 check_same_addr" id="check_same_addr_${item.study_place_idx}"/> 등록된 주소와 동일
                                <br/>
                                <input type="text" class="wid100per mgt10" name="addr2" id="sub_addr2_${item.study_place_idx}" placeholder="상세주소" value="${item.addr2}">
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육시설명</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid100per" name="name" id="name_${item.study_place_idx}" placeholder="교육시설명" value="${item.name}">
                            </td>
                        </tr>
                        <tr>
                            <th>설명</th>
                            <td class="ta_l" colspan="3">
                                <textarea rows="4" class="wid100per" name="cont">${item.cont}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>최대 수용인원</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid120" name="max_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${item.max_qty}"> 명
                            </td>
                        </tr>
                        <tr>
                            <th>적정 수용인원</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid120" name="gd_qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${item.gd_qty}"> 명
                            </td>
                        </tr>
                        <tr>
                            <th>등록자</th>
                            <td class="ta_l">${item.reg_id}</td>
                            <th>등록일</th>
                            <td class="ta_l">${item.reg_dt}</td>
                        </tr>
                        <tr>
                            <th>최종수정자</th>
                            <td class="ta_l">${item.up_id}</td>
                            <th>최종수정일</th>
                            <td class="ta_l">${item.up_dt}</td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey btn_item_update_submit" id="item_${item.study_place_idx}">저장</a>
                        <a href="#none" class="btn red btn_pop_close">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>
</c:forEach>
