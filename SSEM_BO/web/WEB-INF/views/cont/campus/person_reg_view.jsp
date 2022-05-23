<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btn_update").click(function(){
            $("#frm").submit();
        });
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">

            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/person_reg_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="person_book_reg_idx" id="person_book_reg_idx" value="${personBookRegVo.person_book_reg_idx}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>상태</th>
                    <td>
                        <select id="status" name="status" class="kind">
                            <option value="A" <c:if test="${personBookRegVo.status eq 'A'}">selected="selected"</c:if>>신청대기</option>
                            <option value="P" <c:if test="${personBookRegVo.status eq 'P'}">selected="selected"</c:if>>신청확인</option>
                            <option value="O" <c:if test="${personBookRegVo.status eq 'O'}">selected="selected"</c:if>>인물도서 확정</option>
                            <option value="C" <c:if test="${personBookRegVo.status eq 'C'}">selected="selected"</c:if>>신청취소</option>
                        </select>
                    </td>
                    <th>분류</th>
                    <td>
                        <c:choose>
                            <c:when test="${personBookRegVo.cate_cd eq 'J'}">진로직업</c:when>
                            <c:when test="${personBookRegVo.cate_cd eq 'C'}">문화예술</c:when>
                            <c:when test="${personBookRegVo.cate_cd eq 'H'}">인문교양</c:when>
                            <c:when test="${personBookRegVo.cate_cd eq 'P'}">인성심리</c:when>
                            <c:when test="${personBookRegVo.cate_cd eq 'E'}">전문인</c:when>
                            <c:when test="${personBookRegVo.cate_cd eq 'Z'}">기타</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>신청자 ID</th>
                    <td>${personBookRegVo.reg_id}</td>
                    <th>신청자</th>
                    <td>${personBookRegVo.reg_name}</td>
                </tr>
                <tr>
                    <th>휴대폰 번호</th>
                    <td>${personBookRegVo.reg_mob_no}</td>
                    <th>생년월일</th>
                    <td>${personBookRegVo.reg_birth}</td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <c:choose>
                            <c:when test="${personBookRegVo.reg_gender eq 'M'}">남자</c:when>
                            <c:when test="${personBookRegVo.reg_gender eq 'F'}">여자</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <th>연령대</th>
                    <td>
                        <c:choose>
                            <c:when test="${personBookRegVo.reg_age eq '1'}">10대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '2'}">20대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '3'}">30대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '4'}">40대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '5'}">50대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '6'}">60대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '7'}">70대</c:when>
                            <c:when test="${personBookRegVo.reg_age eq '8'}">80대</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3">${personBookRegVo.reg_addr}</td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>${personBookRegVo.reg_tel_no}</td>
                    <th>이메일</th>
                    <td>${personBookRegVo.reg_email}</td>
                </tr>
                <tr>
                    <th>사진등록</th>
                    <td colspan="3">
                        <c:forEach items="${personBookRegVo.fileList}" var="item" varStatus="status">
                            <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                <br/><br/>
                                <img src="${item.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>신청일</th>
                    <td colspan="3">${personBookRegVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종 수정자</th>
                    <td>${personBookRegVo.up_id}</td>
                    <th>최종 수정일</th>
                    <td>${personBookRegVo.up_dt}</td>
                </tr>
                <tr>
                    <th>대표경력</th>
                    <td colspan="3">${personBookRegVo.career}</td>
                </tr>
                <tr>
                    <th>소개글</th>
                    <td colspan="3">${personBookRegVo.intro}</td>
                </tr>
                <tr>
                    <th>업무 메모</th>
                    <td colspan="3">
                        <textarea name="memo" id="memo" class="wid100per" cols="100%" rows="6" title="업무 메모">${personBookRegVo.memo}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/person_reg_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
