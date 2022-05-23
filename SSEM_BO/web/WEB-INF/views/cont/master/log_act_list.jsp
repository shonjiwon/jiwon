<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 6:41
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit sch_area">
        <h3>
            <span class="material-icons">search</span> Search <small>검색</small>
        </h3>
        <div class="line">
            <div class="formCont">
                <label for="sel01">소속</label>
                <select id="sel01" class="wid150">
                    <option>전체</option>
                </select>
            </div>
            <div class="formCont">
                <label for="sel02">부서</label>
                <select id="sel02" class="wid150">
                    <option>전체</option>
                </select>
            </div>
            <div class="formCont">
                <label>조회기간</label>
                <input type="text" id="datepicker_start" class="wid100"> ~ <input type="text" id="datepicker_end" class="wid100">
            </div>
        </div>
        <div class="line">
            <div class="formCont">
                <label for="sel05">승인여부</label>
                <select id="sel05" class="wid150">
                    <option>전체</option>
                </select>
                <input type="text" placeholder="검색어 입력" class="wid350">
                <a href="#none" class="btn orange">검색</a>
            </div>
        </div>
    </article>
    <article class="contUnit tbl_area">
        <table>
            <colgroup>
                <col style="width:5rem">
                <col style="width:10rem">
                <col style="width:12rem">
                <col style="width:10rem">
                <col style="width:15rem">
                <col style="width:12rem">
                <col style="width:12rem">
                <col style="width:12rem">
                <col>
                <col style="width:12rem">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>소속</th>
                <th>기관/교육장</th>
                <th>1레벨</th>
                <th>2레벨</th>
                <th>3레벨</th>
                <th>활동기록</th>
                <th>날짜</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>999</td>
                <td>홍길동</td>
                <td>abde1234</td>
                <td>자치회관</td>
                <td>가락1동 자치회관</td>
                <td>1depth 메뉴명</td>
                <td>2depth 메뉴명</td>
                <td>3depth 메뉴명</td>
                <td>생성</td>
                <td>2020.12.31 23:59</td>
            </tr>
            <tr>
                <td colspan="10">데이터가 없습니다.</td>
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
    </article>
</div>
