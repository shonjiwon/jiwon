<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-10
  Time: 오전 2:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="format-detection" content="telephone=no"><!-- iOS 전화 자동연결 방지 메타태그 -->

    <title><spring:message code="app.title"/></title>

    <script src="/ssemadmin/resources/js/common.js"></script>
    <script src="/ssemadmin/resources/js/jquery-1.12.4.min.js"></script>

    <link rel="shortcut icon" href="/ssemadmin/resources/img/favicon.ico">
    <link href="/ssemadmin/resources/css/common.css" rel="stylesheet" type="text/css">
    <link href="/ssemadmin/resources/css/style.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <script type="text/javascript" src="/ssemadmin/resources/plugins/tingle/tingle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ssemadmin/resources/plugins/tingle/tingle.min.css" />

    <script src="/ssemadmin/resources/js/dialog.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready(function () {
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
        }
    });

    $("#btn_insert").click(function(){
        //modalMsg("가입요청 하시겠습니까?", 'yesorno', insert_frm);
        insert_frm();
    });

    $("#btn_id_check").click(function(){
        var frm = document.frm;

        if(!fnIsValidRequired(frm.admin_id, "ID")){return false;}
        if(!fnIdCheck(frm.admin_id)) {return false;}

        // 아이디 중복 확인
        $.ajax({
            url: "/ssemadmin/ajax/admin_id_check.do?admin_id=" + frm.admin_id.value,
            type: 'POST',
            dataType: 'json',
            xhrFields: {
                withCredentials: true
            },
            async   : false,
            success: function(data){
                if(data == '0'){
                    $("#check_id").val("Y");
                    modalMsg("사용할 수 있는 아이디 입니다.", "notice", "");
                }else{
                    $("#check_id").val("N");
                    modalMsg("사용중인 아이디입니다.", "notice", "");
                }
            }
        });
    });
});

function insert_frm() {
    let frm = document.frm;

    if(!fnIsValidRequired(frm.name, "이름")){
        frm.name.focus();
        return false;
    }
    if(!fnIsValidRequired(frm.admin_id, "아이디")){return false;}
    if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
    if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
    if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}
    if(!fnIsValidRequired(frm.tel_1, "전화번호")){return false;}
    if(!fnIsValidRequired(frm.tel_2, "전화번호")){return false;}
    if(!fnIsValidRequired(frm.tel_3, "전화번호")){return false;}
    if(!fnIsValidRequired(frm.email, "이메일")){return false;}

    if(!fnIsEmailAddr(frm.email)) {
        modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'focus', '');
        return false;
    }

    if(frm.check_id.value != 'Y') {
        modalMsg("아이디 중복확인을 해주세요.", 'notice', '');
        return false;
    }

    $("#mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
    $("#tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);

    $("#frm").submit();
}
</script>
<section class="loginWrap">
    <div class="loginArea">
        <div class="topUnit">
            <img src="/ssemadmin/resources/img/logo_color.png">
            <span>홈페이지 관리자</span>
        </div>
        <div class="formUnit">
            <h2>회원가입</h2>
            <form name="frm" id="frm" action="/ssemadmin/admin/join.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="check_id" id="check_id" />
            <input type="hidden" name="mob_no" id="mob_no" />
            <input type="hidden" name="tel_no" id="tel_no" />
            <div class="info">
                <div class="input">
                    <input type="text" name="name" id="name" placeholder="이름" title="이름"/>
                </div>
                <div class="select">
                    <select id="p_idx" name="p_idx">
                        <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                            <option value="${item.group_idx}">${item.name}</option>
                        </c:forEach>
                    </select>
                    <select id="group_idx" name="group_idx">
                        <c:forEach items="${subGroupList}" var="sub_item" varStatus="status">
                            <option value="${sub_item.group_idx}">${sub_item.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="idCheck">
                    <input type="text" name="admin_id" id="admin_id" placeholder="ID" title="ID"/>
                    <a href="#none" id="btn_id_check">중복확인</a>
                </div>
                <div class="tel">
                    <%--<select name="tel_1" id="tel_1">
                        <c:forEach items="${telList}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>--%>
                    <input type="text" name="mob_1" id="mob_1" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" name="mob_2" id="mob_2" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    -
                    <input type="text" name="mob_3" id="mob_3" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                </div>
                <div class="tel">
                    <%--<select name="tel_1" id="tel_1">
                        <c:forEach items="${telList}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>--%>
                    <input type="text" name="tel_1" id="tel_1" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                    <input type="text" name="tel_2" id="tel_2" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                    <input type="text" name="tel_3" id="tel_3" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                </div>
                <div class="input">
                    <input type="text" name="email" id="email" placeholder="이메일" title="이메일"/>
                </div>
                <%--<div class="input">
                    <input type="password" name="pwd" id="pwd" placeholder="신규비밀번호(8~15자 영문,숫자,특수문자 조합)" title="신규비밀번호(8~15자 영문,숫자,특수문자 조합)"/>
                </div>
                <div class="input">
                    <input type="password" name="pwd_c" id="pwd_c" placeholder="비밀번호재확인" title="비밀번호재확인"/>
                </div>--%>
            </div>
            </form>
            <div class="noti">
                <ul class="list dot">
                    <li>가입요청 후 마스터관리자가 승인하면, 임시비밀번호를 부여 받고 이용하실 수 있습니다.<br /><span class="co_red">(관리계정 관련 문의 : 교육협력과 / 02-2147-2375)</span></li>
                    <li>이후 비밀번호 및 개인정보는 로그인 후 우측상단의 [정보변경] 페이지에서 변경하실 수 있습니다.</li>
                </ul>
            </div>
            <div class="btnLogin">
                <a href="#none" class="btn red" id="btn_insert">가입요청</a>
                <a href="/ssemadmin/login/login.do" class="btn">취소</a>
            </div>
        </div>
    </div>
</section>
</body>
</html>
