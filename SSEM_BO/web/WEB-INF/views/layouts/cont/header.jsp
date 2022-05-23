<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title><spring:message code="app.title"/></title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="format-detection" content="telephone=no"><!-- iOS 전화 자동연결 방지 메타태그 -->

    <script src="/ssemadmin/resources/js/common.js"></script>
    <script src="/ssemadmin/resources/js/jquery-1.12.4.min.js"></script>
    <script src="/ssemadmin/resources/js/jquery-ui.js"></script>
    <script src="/ssemadmin/resources/js/util.js"></script>

    <link rel="shortcut icon" href="/ssemadmin/resources/img/favicon.ico">
    <link href="/ssemadmin/resources/css/common.css" rel="stylesheet" type="text/css">
    <link href="/ssemadmin/resources/css/style.css" rel="stylesheet" type="text/css">
    <link href="/ssemadmin/resources/css/jquery-ui.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Dialog tingle -->
    <script type="text/javascript" src="/ssemadmin/resources/plugins/tingle/tingle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ssemadmin/resources/plugins/tingle/tingle.min.css" />
    <!-- jBox Dialog and ToolTip -->
    <%--<script type="text/javascript" src="/resources/fo/kor/plugins/jbox/jBox.all.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/fo/kor/plugins/jbox/jBox.css" />
    <link rel="stylesheet" type="text/css" href="/resources/fo/kor/plugins/jbox/jBox.all.css" />--%>

    <!-- Date Picker -->
    <script type="text/javascript" src="/ssemadmin/resources/plugins/datepicker/moment.min.js"></script>
    <script type="text/javascript" src="/ssemadmin/resources/plugins/datepicker/daterangepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="/ssemadmin/resources/plugins/datepicker/daterangepicker.css"/>

    <!-- 네이버 에디터 -->
    <%--<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>--%>

    <!-- ckeditor -->
    <script type="text/javascript" src="/ssemadmin/resources/ckeditor/ckeditor.js"></script>

    <!-- 갤러리 -->
    <%--<script type="text/javascript" src="/resources/bo/plugins/gallery/jquery.justifiedGallery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/bo/plugins/gallery/justifiedGallery.min.css" />--%>

    <!-- chart js -->
    <%--<script type="text/javascript" src="/resources/bo/plugins/chartjs-2.8/Chart.min.js"></script>--%>

    <!-- tree view -->
    <%--<script type="text/javascript" src="/resources/bo/plugins/treeview/jstree.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/bo/plugins/treeview/themes/default/style.min.css" />--%>

    <!-- awesome font -->
    <!-- <script src="https://kit.fontawesome.com/8b5932bd44.js"></script> -->

    <script src="/ssemadmin/resources/js/dialog.js"></script>
</head>
<body>
<script type="text/javascript">
    $(document).ready(function () {

        $("#btn_logout").click(function(){
            modalMsg("로그아웃 하시겠습니까?", 'yesorno', goLogout);
        });
    });

    function goLogout() {
        location.href = "/ssemadmin/login/logout.do";
    }
</script>
<!-- head -->
<header>
    <div class="left">
        <img src="/ssemadmin/resources/img/logo.png">
        <span class="tit">ADMINISTRATOR</span>
    </div>
    <div class="right">
        <a href="/ssemadmin/cont/admin/history.do"><span class="user"><b>${adminLoginVo.name}</b>
            <c:choose>
                <c:when test="${adminLoginVo.type eq 'S'}">(마스터관리자)</c:when>
                <c:when test="${adminLoginVo.type eq 'G'}">(기관관리자)</c:when>
                <c:when test="${adminLoginVo.type eq 'N'}">(일반관리자)</c:when>
                <c:when test="${adminLoginVo.type eq 'B'}">(게시판관리자)</c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </span></a>
        <a href="/ssemadmin/cont/admin/mypage.do" class="btn_top">
            <span class="material-icons">portrait</span>
            정보변경
        </a>
        <a href="#none" class="btn_top" id="btn_logout">
            <span class="material-icons">logout</span>
            로그아웃
        </a>
    </div>
</header>

<section class="wrap">
