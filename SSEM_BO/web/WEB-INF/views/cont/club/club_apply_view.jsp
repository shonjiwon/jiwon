<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-20
  Time: 오전 5:25
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
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <form name="frm" id="frm" action="/ssemadmin/cont/club/club_apply_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="club_idx" id="club_idx" value="${clubVo.club_idx}" />
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
                <td colspan="3">
                    <select id="status" name="status" class="wid150">
                        <option value="R" <c:if test="${clubVo.status eq 'R'}">selected="selected"</c:if>>신청대기</option>
                        <option value="C" <c:if test="${clubVo.status eq 'C'}">selected="selected"</c:if>>신청확인</option>
                        <option value="O" <c:if test="${clubVo.status eq 'O'}">selected="selected"</c:if>>동아리확정</option>
                        <option value="N" <c:if test="${clubVo.status eq 'N'}">selected="selected"</c:if>>신청취소</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>분야</th>
                <td colspan="3">${clubVo.code_nm}</td>
            </tr>
            <tr>
                <th>동아리명</th>
                <td colspan="3">${clubVo.name}</td>
            </tr>
            <tr>
                <th>신청자 ID</th>
                <td colspan="3">${clubVo.reg_id}</td>
            </tr>
            <tr>
                <th>신청자</th>
                <td>${clubVo.apy_name}</td>
                <th>휴대폰 번호</th>
                <td>${clubVo.apy_mob_no}</td>
            </tr>
            <tr>
                <th>창립일</th>
                <td colspan="3">${fn:substring(clubVo.stand_dt, 0, 10)}</td>
            </tr>
            <tr>
                <th>소속기관</th>
                <td colspan="3">${clubVo.org_name}</td>
            </tr>
            <tr>
                <th>회원수</th>
                <td colspan="3">${clubVo.mem_cnt}명</td>
            </tr>
            <tr>
                <th>모임주기 및 요일</th>
                <td colspan="3">${clubVo.meet_dt}</td>
            </tr>
            <tr>
                <th>모임장소</th>
                <td colspan="3">${clubVo.meet_plc}</td>
            </tr>
            <tr>
                <th>동아리 소개</th>
                <td colspan="3">${clubVo.intro}</td>
            </tr>
            <tr>
                <th>주요활동</th>
                <td colspan="3">${clubVo.action}</td>
            </tr>
            <tr>
                <th>제출서류 첨부</th>
                <td colspan="3">
                    <c:forEach items="${clubVo.fileList}" var="item" varStatus="status">
                        <c:if test="${item != null}">
                            <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                            </div>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <th>신청일</th>
                <td colspan="3">${clubVo.reg_dt}</td>
            </tr>
            <tr>
                <th>최종 수정자</th>
                <td colspan="3">${clubVo.up_id}</td>
            </tr>
            <tr>
                <th>최종 수정일</th>
                <td colspan="3">${clubVo.up_dt}</td>
            </tr>
            <tr>
                <th>업무 메모</th>
                <td colspan="3">
                    <textarea rows="10" class="wid100per" id="memo" name="memo">${clubVo.memo}</textarea>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/club/club_apply_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
