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
<script type="text/javascript">
$(document).ready(function () {

    var mob = '${adminVo.mob_no}';
    var mobList = mob.split('-');
    $("#mob_1").val(mobList[0]);
    $("#mob_2").val(mobList[1]);
    $("#mob_3").val(mobList[2]);

    var tel = '${adminVo.tel_no}';
    var telList = tel.split('-');
    $("#tel_1").val(telList[0]);
    $("#tel_2").val(telList[1]);
    $("#tel_3").val(telList[2]);

    $("#btn_update").click(function(){
        let frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.tel_1, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.tel_2, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.tel_3, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.email, "이메일")){return false;}
        if(!fnIsValidRequired(frm.cur_pwd, "현재비밀번호")){return false;}
        if(!fnIsValidRequired(frm.pwd, "신규비밀번호")){return false;}
        if(!fnIsValidRequired(frm.pwd_c, "신규비밀번호 재확인")){return false;}


        if(!fnIsEmailAddr(frm.email)) {
            modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'focus', '');
            return false;
        }

        if(!fnPasswdCheck(frm.pwd)) {
            return false;
        }

        if(frm.pwd.value !== frm.pwd_c.value) {
            modalMsg("변경할 비밀번호와 재확인 비밀번호가 일치하지 않습니다.<br/>확인 후 다시 입력해 주세요.", 'focus', '');
            return false;
        }

        if(frm.cur_pwd.value === frm.pwd.value) {
            modalMsg("현재비밀번호와 신규비밀번호가 일치합니다..<br/>확인 후 다시 입력해 주세요.", 'focus', '');
            return false;
        }

        $("#mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
        $("#tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);

        $("#frm").submit();
    });

    $('#pwd').keyup(function () {
        if($(this).val().length > 15) {
            alert("15자까지만 입력이 가능합니다.");
            frm.pwd.value = frm.pwd.value.substr(0, frm.pwd.value.length -1);
        }
    });

    $('#pwd').keydown(function () {
        if($(this).val().length > 15) {
            alert("15자까지만 입력이 가능합니다.");
            frm.pwd.value = frm.pwd.value.substr(0, frm.pwd.value.length -1);
        }
    });

    $('#pwd_c').keyup(function () {
        if($(this).val().length > 15) {
            alert("15자까지만 입력이 가능합니다.");
            frm.pwd_c.value = frm.pwd_c.value.substr(0, frm.pwd_c.value.length -1);
        }
    });

    $('#pwd_c').keydown(function () {
        if($(this).val().length > 15) {
            alert("15자까지만 입력이 가능합니다.");
            frm.pwd_c.value = frm.pwd_c.value.substr(0, frm.pwd_c.value.length -1);
        }
    });
});
</script>
<div class="container">
    <article class="tit">
        <h2>마이페이지</h2>
        <p class="depth">HOME<span class="arrow">></span>마이페이지</p>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>비밀번호 변경</h3>
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/admin/mypage.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="admin_id" id="admin_id" value="${adminVo.admin_id}" />
            <input type="hidden" name="mob_no" id="mob_no" value="${adminVo.mob_no}" />
            <input type="hidden" name="tel_no" id="tel_no" value="${adminVo.tel_no}" />
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>소속</th>
                <td>${adminVo.p_name}</td>
                <th>기관/교육장</th>
                <td>${adminVo.grp_name}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${adminVo.name}</td>
                <th>등록일(승인일)</th>
                <td>
                    <c:choose>
                        <c:when test="${adminVo.up_dt eq null}">${adminVo.reg_dt}</c:when>
                        <c:otherwise>${adminVo.up_dt}</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>아이디</th>
                <td>${adminVo.admin_id}</td>
                <th>휴대폰번호</th>
                <td>
                    <input type="text" class="wid150" name="mob_1" id="mob_1" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" class="wid150" name="mob_2" id="mob_2" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" class="wid150" name="mob_3" id="mob_3" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th class="required">전화번호</th>
                <td>
                    <input type="text" class="wid150" name="tel_1" id="tel_1" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" class="wid150" name="tel_2" id="tel_2" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    -
                    <input type="text" class="wid150" name="tel_3" id="tel_3" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>이메일</th>
                <td><input type="text" class="wid350" value="${adminVo.email}" name="email" id="email"></td>
            </tr>
            <tr>
                <th class="required">현재비밀번호</th>
                <td colspan="3">
                    <input type="password" class="wid350" name="cur_pwd" id="cur_pwd">
                </td>
            </tr>
            <tr>
                <th class="required">신규비밀번호</th>
                <td>
                    <input type="password" class="wid350" placeholder="신규비밀번호(8~15자 영문,숫자,특수문자 조합)" name="pwd" id="pwd">
                </td>
                <th class="required">신규비밀번호 재확인</th>
                <td>
                    <input type="password" class="wid350" placeholder="신규비밀번호(8~15자 영문,숫자,특수문자 조합)" name="pwd_c" id="pwd_c">
                </td>
            </tr>
            <tr>
                <th>관리자유형</th>
                <td>
                    <c:choose>
                        <c:when test="${adminVo.type eq 'S'}">마스터관리자</c:when>
                        <c:when test="${adminVo.type eq 'G'}">기관관리자</c:when>
                        <c:when test="${adminVo.type eq 'N'}">일반관리자</c:when>
                        <c:when test="${adminVo.type eq 'B'}">게시판관리자</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <th>관리자그룹</th>
                <td>관리자그룹이입력</td>
            </tr>
            <tr>
                <th>사용자IP</th>
                <td colspan="3">
                    ${adminLoginVo.login_ip}
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <br/>
        <div class="left">
            <ul class="list star">
                <li>기존비밀번호를 입력하고 [저장]을 눌러야 정보가 수정됩니다.</li>
            </ul>
            <ul class="list star">
                <li>비밀번호를 변경하시려면, 신규비밀번호 및 신규비밀번호 재확인 항목에 새로운 비밀번호를 입력해 주세요. <span class="co_red">(8~15자의 영문,숫자,특수문자 조합)</span></li>
            </ul>
        </div>
        <div class="btnArea ta_c">
            <a href="#none" class="btn red" id="btn_update">저장</a>
            <a href="/ssemadmin/cont/admin/history.do" class="btn">취소</a>
        </div>
    </article>
</div>
