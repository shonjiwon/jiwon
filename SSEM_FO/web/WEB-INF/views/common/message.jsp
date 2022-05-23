<%@page contentType="text/html;charset=utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <title><spring:message code="app.title"/></title>
    <meta charset="utf-8"/>

    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

    <meta property="og:title" content="세상에서 가장큰 학교 송파쌤(SSEM)"/>
    <meta property="og:url" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:description" content="세상에서 가장큰 학교 송파쌤(SSEM)"/>

    <meta property="title" content="세상에서 가장큰 학교 송파쌤(SSEM)"/>
    <meta property="url" content=""/>
    <meta property="image" content=""/>
    <meta property="description" content="세상에서 가장큰 학교 송파쌤(SSEM)"/>

    <!--style -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/layout.css"/>

    <!-- style: main page -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/main.css"/>

    <!-- style: sub page -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/sub.css" />

    <!-- style: color -->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/color.css" />

    <!--js -->
    <script src="/ssem/resources/js/jquery-3.4.1.min.js"></script>
    <script src="/ssem/resources/js/common.js"></script>
    <script src="/ssem/resources/js/jquery.ellipsis.min.js"></script>
    <script src="/ssem/resources/js/ui.js"></script>
    <script src="/ssem/resources/js/main.js"></script>

    <!--lib / slick-->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/lib/slick/slick.css"/>
    <script src="/ssem/resources/lib/slick/slick.min.js"></script>

    <!--lib / aos-->
    <link rel="stylesheet" type="text/css" href="/ssem/resources/lib/aos/aos.css"/>
    <script src="/ssem/resources/lib/aos/aos.js"></script>

    <!--lib / aniNum-->
    <script src="/ssem/resources/lib/aniNum/jquery.animateNumber.js"></script>

    <!-- style: sub page -->
    <link rel="stylesheet" href="/ssem/resources/lib/jquery-ui/jquery-ui.css" />
    <script src="/ssem/resources/lib/jquery-ui/jquery-ui.js"></script>
    <script src="/ssem/resources/lib/jquery-ui/datepicker-ko.js"></script>

    <script src="/ssem/resources/js/sub.js"></script>

    <!-- Dialog tingle -->
    <script type="text/javascript" src="/ssem/resources/plugins/tingle/tingle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/plugins/tingle/tingle.min.css" />

    <script src="/ssem/resources/js/dialog.js"></script>
    <script src="/ssem/resources/js/a2k.js"></script>

    <!--[if lt IE 10]>
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/ie_9.css"/>
    <![endif]-->
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
