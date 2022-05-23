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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/campus/instrum_donation_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="instrum_dnt_idx" value="${instrumDntVo.instrum_dnt_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/instrum_donation_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="instrum_dnt_idx" value="${instrumDntVo.instrum_dnt_idx}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:20%">
                    <col style="width:15%">
                    <col style="width:20%">
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>상태</th>
                    <td colspan="3">
                        <select id="status" name="status" class="wid150">
                            <option value="A" <c:if test="${instrumDntVo.status eq 'A'}">selected="selected"</c:if>>기증신청</option>
                            <option value="R" <c:if test="${instrumDntVo.status eq 'R'}">selected="selected"</c:if>>기증확인</option>
                            <option value="O" <c:if test="${instrumDntVo.status eq 'O'}">selected="selected"</c:if>>기증완료</option>
                            <option value="C" <c:if test="${instrumDntVo.status eq 'C'}">selected="selected"</c:if>>기증취소</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>아아디</th>
                    <td colspan="3">${instrumDntVo.dnt_id}</td>
                </tr>
                <tr>
                    <th>기증신청자</th>
                    <td>${instrumDntVo.dnt_name}</td>
                    <th>전화번호</th>
                    <td>${instrumDntVo.dnt_mob_no}</td>
                </tr>
                <tr>
                    <th>악기명</th>
                    <td colspan="3">${instrumDntVo.instrum_name}</td>
                </tr>
                <tr>
                    <th>악기유형</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${instrumDntVo.gubun eq 'A'}">건반악기</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'B'}">관악기</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'C'}">타악기</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'D'}">현악기</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'E'}">MIDI장비</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'K'}">국악기</c:when>
                            <c:when test="${instrumDntVo.gubun eq 'Z'}">기타</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>악기구입년</th>
                    <td colspan="3">${instrumDntVo.pc_year}</td>
                </tr>
                <tr>
                    <th>악기사진</th>
                    <td colspan="3">
                        <c:forEach items="${instrumDntVo.fileList}" var="thumb" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${thumb.atch_file_id}&amp;fileNum=${thumb.file_num}">${thumb.file_ori_nm}</a>
                            <br/><br/>
                            </span>
                                <img src="${thumb.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>신청일</th>
                    <td colspan="3">${instrumDntVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td colspan="3">${instrumDntVo.up_id}</td>
                </tr>
                <tr>
                    <th>최종수정일</th>
                    <td colspan="3">${instrumDntVo.up_dt}</td>
                </tr>
                <tr>
                    <th class="required">악기설명 및 기증사연</th>
                    <td colspan="5">
                        ${instrumDntVo.cont}
                    </td>
                </tr>
                <tr>
                    <th class="required">업무메모</th>
                    <td colspan="3">
                        <textarea name="memo" id="memo" class="textarea" cols="100%" rows="5" title="업무메모">${instrumDntVo.memo}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/instrum_donation_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
