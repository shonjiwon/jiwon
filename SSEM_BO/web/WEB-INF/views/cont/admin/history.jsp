<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-10
  Time: 오전 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="container">
    <article class="tit">
        <h2>마이페이지</h2>
        <p class="depth">HOME<span class="arrow">></span>마이페이지</p>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>${adminLoginVo.name}님 이력</h3>
            </div>
            <div class="right">
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>최근 접속일</th>
                <td>${adminLoginVo.last_login_dt}</td>
            </tr>
            <tr>
                <th>최근 접속 IP</th>
                <td>${adminLoginVo.last_login_ip}</td>
            </tr>
            </tbody>
        </table>
    </article>
</div>
