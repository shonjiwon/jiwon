<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 6:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="sel01">홈페이지</label>
                <select id="sel01" class="wid150">
                    <option>전체</option>
                </select>
            </div>
            <div class="formCont">
                <label for="sel02">노출상태</label>
                <select id="sel02" class="wid150">
                    <option>전체</option>
                </select>
            </div>
            <div class="formCont">
                <label for="text01">검색</label>
                <input type="text" placeholder="검색어 입력" class="wid350" id="text01">
                <a href="#none" class="btn orange">검색</a>
            </div>
        </div>
    </article>
    <article class="contUnit tbl_area">
        <div class="totalNum">
            총 <b>999</b>건 | 현재페이지 <b class="co_blue">1</b>/100
        </div>
        <table>
            <colgroup>
                <col style="width:8rem">
                <col style="width:12rem">
                <col>
                <col style="width:20rem">
                <col style="width:10rem">
                <col style="width:10rem">
                <col style="width:10rem">
            </colgroup>
            <thead>
            <tr>
                <th>노출순서</th>
                <th>홈페이지</th>
                <th>제목</th>
                <th>노출기간</th>
                <th>등록자</th>
                <th>등록일</th>
                <th>노출상태</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="text" class="wid100per ta_c" placeholder="번호"></td>
                <td>미래교육</td>
                <td class="ta_l"><a href="/ssemadmin/cont/main/notice_view.do">배너명이 표기됩니다.</a></td>
                <td>2020-12-31 ~ 2020-12-31</td>
                <td>홍길동</td>
                <td>2020-12-31</td>
                <td>노출</td>
            </tr>
            <tr>
                <td colspan="7">데이터가 없습니다.</td>
            </tr>
            <tr>
            </tbody>
        </table>
        <div class="paginArea">
            <ul class="pagination">
                <li class="first">
                    <a href="#none"><span class="material-icons">keyboard_arrow_left</span><span class="material-icons">keyboard_arrow_left</span></a>
                </li>
                <li class="prev">
                    <a href="#none"><span class="material-icons">keyboard_arrow_left</span></a>
                </li>
                <li><a href="#none">1</a></li>
                <li class="on"><a href="#none">2</a></li>
                <li><a href="#none">3</a></li>
                <li><a href="#none">4</a></li>
                <li><a href="#none">5</a></li>
                <li><a href="#none">6</a></li>
                <li><a href="#none">7</a></li>
                <li><a href="#none">8</a></li>
                <li><a href="#none">9</a></li>
                <li><a href="#none">10</a></li>
                <li class="next">
                    <a href="#none"><span class="material-icons">keyboard_arrow_right</span></a>
                </li>
                <li class="last">
                    <a href="#none"><span class="material-icons">keyboard_arrow_right</span><span class="material-icons">keyboard_arrow_right</span></a>
                </li>
            </ul>
        </div>
        <div class="btnArea">
            <div class="left">
                <a href="#none" class="btn blue">노출순서 저장</a>
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/main/notice_inscr.do" class="btn red">등록</a>
            </div>
        </div>
    </article>
</div>
