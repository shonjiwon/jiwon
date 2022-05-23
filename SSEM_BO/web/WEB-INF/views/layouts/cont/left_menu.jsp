<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 왼쪽 메뉴(S) -->
<aside class="leftMenu">
    <ul class="menu">
        <c:forEach items="${topMenuList}" var="topMenu_item">
        <li>
            <a href="#none" id="${topMenu_item.menu_idx}" <c:if test="${topMenu_item.menu_idx eq topMenu.menu_idx}">class="on"</c:if>>${topMenu_item.name}</a>
            <ul class="subMenu<c:if test="${topMenu_item.menu_idx eq topMenu.menu_idx}"> on</c:if>">
                <c:forEach items="${topMenu_item.sublist}" var="sub">
                    <li <c:if test="${menuSubDept eq sub.menu_idx}">class="on"</c:if>>
                        <c:choose>
                            <c:when test="${fn:length(sub.sublist) != 0}">
                                <a href="#none" class="hasSub" id="subMenu_${sub.menu_idx}">${sub.name}</a>
                                <ul class="finMenu <c:if test="${sub.menu_idx eq subMenu.menu_idx}"> on</c:if>">
                                    <c:forEach items="${sub.sublist}" var="child">
                                        <li <c:if test="${currentMenu.menu_idx eq child.menu_idx}">class="on"</c:if>>
                                            <a href="${child.url}" <c:if test="${child.kind eq 'LINK'}">target="_blank"</c:if>>${child.name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise><a href="${sub.url}">${sub.name}</a></c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
            </ul>
        </li>
        </c:forEach>
    </ul>
    <%--<ul class="menu">
        <li>
            <a href="#none" id="menu01">마스터관리</a>
            <ul class="subMenu">
                <li>
                    <a href="/ssemadmin/cont/master/admin_list.do">관리자관리</a>
                </li>
                <li>
                    <a href="#none">권한그룹관리</a>
                </li>
                <li>
                    <a href="#none">조직관리</a>
                </li>
                <li>
                    <a href="#none">로그관리</a>
                    <ul class="finMenu">
                        <li>
                            <a href="#none">관리자접속이력</a>
                        </li>
                        <li>
                            <a href="#none">권한변경이력</a>
                        </li>
                        <li>
                            <a href="#none">관리자활동이력</a>
                        </li>
                        <li>
                            <a href="#none">개인정보조회이력</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none">통계관리</a>
                    &lt;%&ndash;<ul class="finMenu">
                        <li>
                            <a href="#none">권한변경이력</a>
                        </li>
                        <li>
                            <a href="#none">개인정보조회이력</a>
                        </li>
                    </ul>&ndash;%&gt;
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu02">메인관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">메인이미지관리</a>
                </li>
                <li>
                    <a href="#none">알림판관리</a>
                </li>
                <li>
                    <a href="#none">팝업관리</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu03">통합 강좌관리</a>
            <ul class="subMenu">
                <li >
                    <a href="#none">강좌관리</a>
                </li>
                <li>
                    <a href="#none">신청/접수관리</a>
                </li>
                <li>
                    <a href="#none">강좌별교육생관리</a>
                </li>
                <li>
                    <a href="#none">수강생관리</a>
                </li>
                <li>
                    <a href="#none">강사관리</a>
                </li>
                <li>
                    <a href="#none">교육시설관리</a>
                    <ul class="finMenu">
                        <li>
                            <a href="#none">AAA</a>
                        </li>
                        <li>
                            <a href="#none">BBB</a>
                        </li>
                        <li>
                            <a href="#none">CCC</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu04">마그넷스풀관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">배우고싶어요</a>
                </li>
                <li>
                    <a href="#none">배울굥유채널</a>
                </li>
                <li>
                    <a href="#none">강사신청목록</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu05">웹사이트관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">공지사항관리</a>
                </li>
                <li>
                    <a href="#none">FAQ관리</a>
                </li>
                <li>
                    <a href="#none">Q&A관리</a>
                </li>
                <li>
                    <a href="#none">자료실관리</a>
                </li>
                <li>
                    <a href="#none">설문조사관리</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu06">온라인캠퍼스관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">인물도서관</a>
                    <ul class="finMenu">
                        <li>
                            <a href="#none">배너관리</a>
                        </li>
                        <li>
                            <a href="#none">인물도서관리</a>
                        </li>
                        <li>
                            <a href="#none">학교로 찾아가는 인물도서 관리</a>
                        </li>
                        <li>
                            <a href="#none">열람신청관리</a>
                        </li>
                        <li>
                            <a href="#none">이달의 인물도서관리</a>
                        </li>
                        <li>
                            <a href="#none">Live인물도서관리</a>
                        </li>
                        <li>
                            <a href="#none">등록신청관리</a>
                        </li>
                        <li>
                            <a href="#none">인물도서 열람후기</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none">악기도서관</a>
                </li>
                <li>
                    <a href="#none">미래교육센터</a>
                </li>
                <li>
                    <a href="#none">자기주도학습관</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu07">센터홈페이지관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">꿈마루</a>
                </li>
                <li>
                    <a href="#none">송파청소년센터</a>
                    <ul class="finMenu">
                        <li>
                            <a href="#none">메인 이미지 관리</a>
                        </li>
                        <li>
                            <a href="#none">공지사항</a>
                        </li>
                        <li>
                            <a href="#none">고객광장</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none">마천청소년센터</a>
                </li>
                <li>
                    <a href="#none">잠실청소년센터</a>
                </li>
                <li>
                    <a href="#none">구립송파청소년미래센터</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu08">평생학습동아리관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">동아리신청관리</a>
                </li>
                <li>
                    <a href="#none">활동현황관리</a>
                </li>
                <li>
                    <a href="#none">활동소식관리</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#none" id="menu09">자치회관리</a>
            <ul class="subMenu">
                <li>
                    <a href="#none">자치회관리</a>
                </li>
            </ul>
        </li>
    </ul>--%>
</aside>
<!-- //좌측 영역 -->
