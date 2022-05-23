<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:45
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
    <article class="contUnit tbl_area leftType">
        <div class="tblMsg">
            <span class="co_red">*</span> 필수입력
        </div>
        <table>
            <colgroup>
                <col style="width:15rem">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th class="required">홈페이지</th>
                <td>
                    <input type="radio" name="radio01" id="radio01_01">
                    <label for="radio01_01">미래교육</label>
                    <input type="radio" name="radio01" id="radio01_02">
                    <label for="radio01_02">평생교육</label>
                </td>
            </tr>
            <tr>
                <th class="required">제목</th>
                <td>
                    <input type="text" class="wid100per">
                </td>
            </tr>
            <tr>
                <th class="required">노출상태</th>
                <td>
                    <input type="radio" name="radio02" id="radio02_01">
                    <label for="radio02_01">노출</label>
                    <input type="radio" name="radio02" id="radio02_02">
                    <label for="radio02_02">미노출</label>
                </td>
            </tr>
            <tr>
                <th>노출순서</th>
                <td>
                    <input type="text" class="wid100">
                </td>
            </tr>
            <tr>
                <th class="required">노출기간</th>
                <td>
                    <input type="text" id="datepicker_start" class="wid100">
                    <select>
                        <option>선택</option>
                    </select>시
                    <select>
                        <option>선택</option>
                    </select>분
                    ~
                    <input type="text" id="datepicker_end" class="wid100">
                    <select>
                        <option>선택</option>
                    </select>시
                    <select>
                        <option>선택</option>
                    </select>분
                </td>
            </tr>
            <tr>
                <th class="required">이미지</th>
                <td>
                    <input type="file" class="wid350">
                    <span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>
                    <div class="imgArea">
                        <span>filename.png</span>
                        <a href="#none" class="btn_del">x</a><br>
                        <img src="/ssemadmin/resources/img/temp/img_001.png">
                    </div>
                    <div class="imgArea">
                        <span class="tit">filename.png</span>
                        <a href="#none" class="btn_del">x</a><br>
                        <img src="/ssemadmin/resources/img/temp/img_001.png">
                    </div>
                </td>
            </tr>
            <tr>
                <th class="required">배너대체텍스트 </th>
                <td>
                    <input type="text" class="wid100per">
                </td>
            </tr>
            <tr>
                <th>링크URL</th>
                <td>
                    <input type="text" class="wid350">
                    <select class="wid100">
                        <option>현재창</option>
                        <option>새창</option>
                    </select>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/main/notice_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn grey">삭제</a>
                <a href="#none" class="btn red">수정</a>
            </div>
        </div>
    </article>
</div>
