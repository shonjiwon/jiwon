<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <title><spring:message code="app.title"/></title>

    <script src="/ssemadmin/resources/js/common.js"></script>
    <script src="/ssemadmin/resources/js/jquery-1.12.4.min.js"></script>
    <script src="/ssemadmin/resources/js/jquery-ui.js"></script>

    <link href="/ssemadmin/resources/css/jquery-ui.css" rel="stylesheet" type="text/css">

    <!-- Dialog tingle -->
    <script type="text/javascript" src="/ssemadmin/resources/plugins/tingle/tingle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ssemadmin/resources/plugins/tingle/tingle.min.css" />


    <script src="/ssemadmin/resources/js/dialog.js"></script>
</head>
<body>
<script type="text/javascript">
    let newwin;
    <c:choose>
    <c:when test="${msg=='noMemInfo'}">
    alert('회원님께서 입력하신 로그인 정보가 올바르지 않거나 회원으로 등록하지 않으셨습니다.');
    location.href = '/';
    </c:when>
    <c:when test="${msg=='badInfo'}">
    alert('잘못된 접근입니다.');
    location.href = '/';
    </c:when>
    <c:when test="${msg=='alterSelf'}">
    alert('${altmsg}');
    self.close();
    </c:when>
    <c:when test="${msg=='alterBack'}">
    modalMsg("${altmsg}", "back", "");
    </c:when>
    <c:when test="${msg=='alterNewWin'}">
    alert('${altmsg}');
    window.open('${openurl}', '', 'width=400;height=500;');
    </c:when>
    <c:when test="${msg=='alterNewWinBack'}">
    alert('${altmsg}');
    newwin = window.open('${openurl}', 'newWin', 'width=600;height=300;');
    if (newwin != null) {
        history.back();
    } else {
        alert('팝업차단을 해제해 주세요');
    }
    </c:when>
    <c:when test="${msg=='alter'}">
    modalMsg("${altmsg}", "notice", "");
    </c:when>
    <c:when test="${msg=='loc'}">
    location.href = '${fn:replace(locurl, "&amp;", "&")}';
    </c:when>
    <c:when test="${msg=='alterloc'}">
    modalMsg("${altmsg}", "locurl", "${locurl}");
    </c:when>
    <c:when test="${msg=='alterPloc'}">
    alert('${altmsg}');
    window.parent.location.reload();
    window.parent.$('.ui-dialog').remove();
    </c:when>
    <c:when test="${msg=='alterCloc'}">
    alert('${altmsg}');
    opener.location.href = '${fn:replace(locurl, "&amp;", "&")}';
    self.close();
    </c:when>
    <c:when test="${msg=='alterCloseCReload'}">
    //modalMsg("${altmsg}", "notice", "");
    alert('${altmsg}');
    opener.location.reload();
    self.close();
    </c:when>
    <c:when test="${msg=='closeCReload'}">
    opener.location.reload();
    self.close();
    </c:when>
    <c:when test="${msg=='alterClose'}">
    alert('${altmsg}');
    self.close();
    </c:when>
    <c:when test="${msg=='alterSpopClose'}">
    alert('${altmsg}');
    parent.$.smartPop.close();
    </c:when>

    <c:when test="${msg == null}">
    alert('-.-;');
    location.href = '/';
    </c:when>

    <c:otherwise>
    alert('${msg}');
    history.back();
    </c:otherwise>
    </c:choose>
</script>
</body>
</html>
