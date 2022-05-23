<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-13
  Time: 오전 5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $('#btn_main_update').click(function() {
            let frm = document.frm_main;

            if(!fnIsValidRequired(frm.name, "소속명")){return false;}

            $("#frm_main").submit();
        });

        $('#btn_sub_update').click(function() {
            let frm = document.frm_sub;

            if(!fnIsValidRequired(frm.name, "기관/교육장")){return false;}

            $("#frm_sub").submit();
        });

        $('#btn_new_isnert').click(function() {
            let frm = document.frm_new;

            if(!fnIsValidRequired(frm.p_name, "소속")){return false;}
            if(!fnIsValidRequired(frm.name, "기관/교육장")){return false;}

            $("#frm_new").submit();
        });

        $('#btn_add_isnert').click(function() {
            let frm = document.frm_add;

            if(!fnIsValidRequired(frm.name, "기관/교육장")){return false;}

            $("#frm_add").submit();
        });

        // 팝업 열기
        var popMain = $(".popMainOpen");
        popMain.click(function() {
            var group_idx = $(this).attr('id');
            var group_name = $("#grp_main_txt_" + group_idx).text();
            $("#group_main_name").val(group_name);
            $("#group_main_idx").val(group_idx);

            $(".pop_main").addClass('on')
        });

        var popSub = $(".popSubOpen");
        popSub.click(function() {
            var group_idx = $(this).attr('id');
            var group_name = $("#grp_sub_txt_" + group_idx).text();
            $("#group_sub_name").val(group_name);
            $("#group_sub_idx").val(group_idx);

            var addr1 = $("#sub_addr1_" + group_idx).text();
            $("#sub_addr1").val(addr1);
            var addr2 = $("#sub_addr2_" + group_idx).text();
            $("#sub_addr2").val(addr2);

            var tel_no = $("#sub_tel_no_" + group_idx).text();
            if(tel_no !== '') {
                var jbSplit = tel_no.split('-');
                $("#sub_tel_1").val(jbSplit[0]);
                $("#sub_tel_2").val(jbSplit[1]);
                $("#sub_tel_3").val(jbSplit[2]);
            } else {
                $("#sub_tel_1").val("");
                $("#sub_tel_2").val("");
                $("#sub_tel_3").val("");
            }

            $(".pop_sub").addClass('on')
        });

        var popAddNew = $(".popAddNew");
        popAddNew.click(function() {

            $("#p_name_new").val("");
            $("#name_new").val("");
            $("#new_addr1").val("");
            $("#new_addr2").val("");
            $("#new_tel_1").val("");
            $("#new_tel_2").val("");
            $("#new_tel_3").val("");

            $(".pop_add_new").addClass('on')
        });

        var popAdd = $(".pop_add");
        popAdd.click(function() {

            var group_idx = $(this).attr('id');
            group_idx = group_idx.substr(4, group_idx.length - 1);
            var group_name = $("#grp_main_txt_" + group_idx).text();

            $("#p_name_add").val(group_name);
            $("#name_add").val("");
            $("#add_addr1").val("");
            $("#add_addr2").val("");
            $("#add_tel_1").val("");
            $("#add_tel_2").val("");
            $("#add_tel_3").val("");
            $("#group_add_idx").val(group_idx);

            $(".pop_add").addClass('on')
        });

        // 팝업닫기
        $('.btnClose').click(function() {
            $('.popArea').removeClass('on')
        });

        $('.btn_pop_close').click(function() {
            $('.popArea').removeClass('on')
        });
    });
</script>
<%--<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js?autoload=false"></script>--%>
<%--<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>--%>
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

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    //document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                    document.getElementById('sub_addr1').value = fullRoadAddr;
                    //document.getElementById('addr_dtl').value = data.jibunAddress;

                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    /*  if(data.autoRoadAddress) {
                         //예상되는 도로명 주소에 조합형 주소를 추가한다.
                         var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                         document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                     } else if(data.autoJibunAddress) {
                         var expJibunAddr = data.autoJibunAddress;
                         document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                     } else {
                         document.getElementById('guide').innerHTML = '';
                     } */
                }
            }).open();
    }

    function sample1_execDaumPostcode() {
        daum.postcode.load(function() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }

                    document.getElementById('new_addr1').value = fullRoadAddr;
                }
            }).open();
        });
    }

    function sample2_execDaumPostcode() {
        daum.postcode.load(function() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }

                    document.getElementById('add_addr1').value = fullRoadAddr;
                }
            }).open();
        });
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area">
        <div class="btnArea mgb10">
            <div class="right">
                <a href="#none" class="btn blue popAddNew">신규 소속 등록</a>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:30rem">
                <col style="width:30rem">
                <col>
                <col style="width:30rem">
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>소속</th>
                <th>기관/교육장</th>
                <th>주소</th>
                <th>연락처</th>
                <th>추가</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${groupList}" var="item">
                <c:forEach items="${item.subGroupList}" var="sub" varStatus="status">
                    <tr>
                    <c:if test="${status.count eq 1}">
                        <td rowspan="${fn:length(item.subGroupList)}">
                            <span id="grp_main_txt_${item.group_idx}">${item.name}</span>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#none" class="popMainOpen btn sml" id="${item.group_idx}">수정</a>
                        </td>
                    </c:if>
                    <td>
                        <span id="grp_sub_txt_${sub.group_idx}">${sub.name}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;<a href="#none" class="popSubOpen btn sml" id="${sub.group_idx}">수정</a>
                    </td>
                    <td>
                        <span style="display: none" id="sub_addr1_${sub.group_idx}">${sub.addr1}</span>
                        <span style="display: none" id="sub_addr2_${sub.group_idx}">${sub.addr2}</span>
                        ${sub.addr1} ${sub.addr2}
                    </td>
                    <td>
                        <span style="display: none" id="sub_tel_no_${sub.group_idx}">${sub.tel_no}</span>
                        ${sub.tel_no}
                    </td>
                    <c:if test="${status.count eq 1}">
                        <td rowspan="${fn:length(item.subGroupList)}">
                            <a href="#none" class="btn sml red pop_add" id="add_${item.group_idx}">추가</a>
                        </td>
                    </c:if>
                    </tr>
                </c:forEach>
            </c:forEach>
            </tbody>
        </table>
    </article>
</div>

<section class="popArea pop_main">
    <div class="popBody">
        <div class="tit">
            <h2>소속 수정</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_main" id="frm_main" method="post" action="/ssemadmin/cont/master/group_main_update.do" enctype="multipart/form-data">
                <input type="hidden" name="group_idx" id="group_main_idx"/>
                <table>
                    <colgroup>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>소속</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <input type="text" class="wid100per ta_c" name="name" id="group_min_name" placeholder="소속명">
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey" id="btn_main_update">저장</a>
                        <a href="#none" class="btn red" id="btn_pop_close">취소</a>
                    </div>
                </div>
                </form>
            </article>
        </div>
    </div>
</section>

<section class="popArea pop_sub">
    <div class="popBody" style="width: 120rem !important;">
        <div class="tit">
            <h2>기관/교육장 수정</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_sub" id="frm_sub" method="post" action="/ssemadmin/cont/master/group_sub_update.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" id="group_sub_idx"/>
                    <table>
                        <colgroup>
                            <col style="width:30rem">
                            <col>
                            <col style="width:30rem">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>기관/교육장</th>
                            <th>주소</th>
                            <th>연락처</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input type="text" class="wid100per ta_c" name="name" id="group_sub_name" placeholder="소속명">
                            </td>
                            <td class="ta_l">
                                <input type="text" class="wid350" name="addr1" id="sub_addr1" placeholder="주소">&nbsp;&nbsp;<a href="#none" onclick="sample4_execDaumPostcode();" class="popMainOpen btn sml blue">주소찾기</a><br/>
                                <input type="text" class="wid100per mgt10" name="addr2" id="sub_addr2" placeholder="상세주소">
                            </td>
                            <td>
                                <input type="text" class="wid70 ta_c" name="tel_1" id="sub_tel_1" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                -
                                <input type="text" class="wid70 ta_c" name="tel_2" id="sub_tel_2" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                -
                                <input type="text" class="wid70 ta_c" name="tel_3" id="sub_tel_3" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btnArea">
                        <div class="left">
                        </div>
                        <div class="right">
                            <a href="#none" class="btn grey" id="btn_sub_update">저장</a>
                            <a href="#none" class="btn red btn_pop_close">취소</a>
                        </div>
                    </div>
                </form>
            </article>
        </div>
    </div>
</section>

<section class="popArea pop_add_new">
    <div class="popBody" style="width: 120rem !important;">
        <div class="tit">
            <h2>신규소속 등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_new" id="frm_new" method="post" action="/ssemadmin/cont/master/group_new_insert.do" enctype="multipart/form-data">
                <table>
                    <colgroup>
                        <col style="width:20rem">
                        <%--<col style="width:5rem">--%>
                        <col style="width:20rem">
                        <col>
                        <col style="width:30rem">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="required">소속</th>
                        <%--<th>사용</th>--%>
                        <th class="required">기관/교육장</th>
                        <th>주소</th>
                        <th>연락처</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td rowspan="2">
                            <input type="text" class="wid100per ta_c" name="p_name" id="p_name_new" placeholder="소속명">
                        </td>
                        <%--<td>
                            <input type="checkbox">
                        </td>--%>
                        <td>
                            <input type="text" class="wid100per ta_c" name="name" id="name_new" placeholder="기관/교육장명">
                        </td>
                        <td class="ta_l">
                            <input type="text" class="wid250" name="addr1" id="new_addr1" placeholder="주소">&nbsp;&nbsp;<a href="#none" onclick="sample1_execDaumPostcode();" class="popMainOpen btn sml blue">주소찾기</a><br/>
                            <input type="text" class="wid100per mgt10" name="addr2" id="new_addr2" placeholder="상세주소">
                        </td>
                        <td>
                            <input type="text" class="wid70 ta_c" name="tel_1" id="new_tel_1" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            -
                            <input type="text" class="wid70 ta_c" name="tel_2" id="new_tel_2" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            -
                            <input type="text" class="wid70 ta_c" name="tel_3" id="new_tel_3" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="4">
                            <a href="#none" class="btn blue">추가</a>
                        </td>
                    </tr>--%>
                    </tbody>
                </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey" id="btn_new_isnert">저장</a>
                        <a href="#none" class="btn red btn_pop_close">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>

<section class="popArea pop_add">
    <div class="popBody" style="width: 120rem !important;">
        <div class="tit">
            <h2>기관/교욱장 추가</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_add" id="frm_add" method="post" action="/ssemadmin/cont/master/group_add_insert.do" enctype="multipart/form-data">
                    <input type="hidden" name="p_idx" id="group_add_idx"/>
                    <table>
                        <colgroup>
                            <col style="width:20rem">
                            <%--<col style="width:5rem">--%>
                            <col style="width:20rem">
                            <col>
                            <col style="width:30rem">
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="required">소속</th>
                            <%--<th>사용</th>--%>
                            <th class="required">기관/교육장</th>
                            <th>주소</th>
                            <th>연락처</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td rowspan="2">
                                <input type="text" class="wid100per ta_c" name="p_name" id="p_name_add" placeholder="소속명" readonly>
                            </td>
                            <%--<td>
                                <input type="checkbox">
                            </td>--%>
                            <td>
                                <input type="text" class="wid100per ta_c" name="name" id="name_add" placeholder="기관/교육장명">
                            </td>
                            <td class="ta_l">
                                <input type="text" class="wid250" name="addr1" id="add_addr1" placeholder="주소">&nbsp;&nbsp;<a href="#none" onclick="sample2_execDaumPostcode();" class="popMainOpen btn sml blue">주소찾기</a><br/>
                                <input type="text" class="wid100per mgt10" name="addr2" id="add_addr2" placeholder="상세주소">
                            </td>
                            <td>
                                <input type="text" class="wid70 ta_c" name="tel_1" id="add_tel_1" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                -
                                <input type="text" class="wid70 ta_c" name="tel_2" id="add_tel_2" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                -
                                <input type="text" class="wid70 ta_c" name="tel_3" id="add_tel_3" placeholder="연락처" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                            </td>
                        </tr>
                        <%--<tr>
                            <td colspan="4">
                                <a href="#none" class="btn blue">추가</a>
                            </td>
                        </tr>--%>
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
