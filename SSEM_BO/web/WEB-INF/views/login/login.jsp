<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-10
  Time: 오전 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="/ssemadmin/resources/js/jquery.cookie.js"></script>

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
    $(document).ready(function(){
        //쿠키확인
        let adminId = $.cookie("adminId");
        if (adminId != null && adminId !== "") {
            $("#admin_id").val(adminId);
            $("#idsaveCheck").attr("checked", "checked");
        }
    });

    function goSubmit() {
        let frm = document.frm;

        if (!fnIsValidRequired(frm.admin_id, "아이디")) {
            return;
        }
        if (!fnIsValidRequired(frm.pwd, "비밀번호")) {
            return;
        }

        let checkStatus = $("#idsaveCheck").is(":checked");	// id값 저장 여부
        if(checkStatus){ //  체크되어있으면
            $.cookie("adminId", $("#admin_id").val(), {
                expires : 365,
                path : '/ssemadmin/login'
            });
        }else{	// 아니면 쿠키 값을 없에고
            $.cookie("adminId", '', {
                path : '/ssemadmin/login'
            });
        }

        frm.admin_id.value = frm.admin_id.value.trim();
        frm.pwd.value = frm.pwd.value.trim();

        frm.submit();
    }
</script>
<section class="loginWrap">
    <div class="loginArea">
        <div class="topUnit">
            <img src="/ssemadmin/resources/img/logo_color.png">
            <span>홈페이지 관리자</span>
        </div>
        <div class="formUnit">
            <h2>로그인</h2>
            <form name="frm" id="frm" method="post" action="/ssemadmin/login/login.do">
            <div class="info">
                <div class="input">
                    <input type="text" name="admin_id" id="admin_id" placeholder="아이디를 입력해주세요" title="아이디를 입력해주세요">
                    <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" title="비밀번호를 입력해주세요">
                </div>
                <div class="check">
                    <input type="checkbox" id="idsaveCheck" name="idsaveCheck"><label for="idsaveCheck">ID저장</label>
                </div>
                <%--<div class="btnSch">
                    <a href="#none">
                        <span class="material-icons">person_search</span> 아이디/비밀번호 찾기
                    </a>
                </div>--%>
            </div>
            </form>
            <div class="noti">
                <ul class="list dot">
                    <li>아이디 또는 비밀번호 문의는 최고관리자에게 문의하시기 바랍니다.<br /><span class="co_red">(교육협력과 / 02-2147-2375)</span></li>
                    <li>관리자 권한이 없는 사용자는 관리자 페이지에 접근하실 수 없습니다.</li>
                    <li>임의 접근시도 확인 시 법적 제재를 받을 수 있습니다.</li>
                </ul>
            </div>
            <div class="btnLogin">
                <a href="javascript:goSubmit();" class="btn red">로그인</a>
                <a href="/ssemadmin/admin/join.do" class="btn">회원가입</a>
            </div>
        </div>
    </div>
</section>
</body>
</html>
