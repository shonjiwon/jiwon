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
<style>
    .ck-editor__editable {
        min-height: 250px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btn_update").click(function(){
            var frm = document.frm;

            $("#frm").submit();
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });
    });

    function delete_frm() {
        document.delfrm.submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>신청자 정보</h3>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>사진</th>
                <td colspan="5">
                    <c:forEach items="${teacherApyVo.picFileList}" var="pic" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${pic.atch_file_id}&amp;fileNum=${pic.file_num}">${pic.file_ori_nm}</a>
                            </span>
                            <br/><br/>
                            <img src="${pic.file_src}">
                        </div>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${teacherApyVo.apy_name}</td>
                <th>신청자ID</th>
                <td>${teacherApyVo.apy_id}</td>
                <th>성별</th>
                <td>
                    <c:choose>
                        <c:when test="${teacherApyVo.apy_gender eq 'M'}">남</c:when>
                        <c:when test="${teacherApyVo.apy_gender eq 'F'}">여</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>휴대폰번호</th>
                <td colspan="3">${teacherApyVo.apy_mob_no}</td>
                <th>생년월일</th>
                <td>${teacherApyVo.apy_birth}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td colspan="5">
                    ${teacherApyVo.apy_email}
                </td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
                <h3>강사신청 정보</h3>
            </div>
        </div>
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/magnet/teach_apply_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="teacher_apy_idx" value="${teacherApyVo.teacher_apy_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/magnet/teach_apply_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="teacher_apy_idx" value="${teacherApyVo.teacher_apy_idx}" />
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:85%">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>상태</th>
                <td>
                    <select id="status" name="status" class="kind">
                        <option value="A" <c:if test="${teacherApyVo.status eq 'A'}">selected="selected"</c:if>>강사신청</option>
                        <option value="R" <c:if test="${teacherApyVo.status eq 'R'}">selected="selected"</c:if>>신청확인</option>
                        <option value="O" <c:if test="${teacherApyVo.status eq 'O'}">selected="selected"</c:if>>강사등록</option>
                        <option value="C" <c:if test="${teacherApyVo.status eq 'C'}">selected="selected"</c:if>>신청취소</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>교육분야</th>
                <td>${teacherApyVo.code_name}</td>
            </tr>
            <tr>
                <th>전문분야</th>
                <td>${teacherApyVo.prof_field}</td>
            </tr>
            <tr>
                <th>학력 및 주요경력</th>
                <td>
                    ${teacherApyVo.career}
                </td>
            </tr>
            <tr>
                <th>취득자격</th>
                <td>${teacherApyVo.cert}</td>
            </tr>
            <tr>
                <th>강사이력</th>
                <td>
                    <c:forEach items="${teacherApyVo.careerFileList}" var="career" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${career.atch_file_id}&amp;fileNum=${career.file_num}">${career.file_ori_nm}</a>
                            </span>
                        </div>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <th>신청일</th>
                <td>${teacherApyVo.reg_dt}</td>
            </tr>
            <tr>
                <th>최종 수정자</th>
                <td>${teacherApyVo.up_id}</td>
            </tr>
            <tr>
                <th>최종 수정일</th>
                <td>${teacherApyVo.up_dt}</td>
            </tr>
            <tr>
                <th>업무 메모</th>
                <td>
                    <textarea rows="5" class="wid100per" name="memo" id="memo">${teacherApyVo.memo}</textarea>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/magnet/teach_apply_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
