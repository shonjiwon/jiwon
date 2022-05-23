<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {

        $('#status').change(function() {
            let select_val = $(this).val();
            if(select_val === 'O') {
                $('#rpy_cont').attr('disabled', false);
            } else {
                $('#rpy_cont').val('');
                $('#rpy_cont').attr('disabled', true);
            }
        });

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
    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/site/lawtax_delete.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lawtax_idx" value="${lawtaxCounselVo.lawtax_idx}" />
    </form>
    <form name="frm" id="frm" action="/ssemadmin/cont/site/lawtax_view.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lawtax_idx" value="${lawtaxCounselVo.lawtax_idx}" />
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>신청자 정보</h3>
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                </div>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%;">
                <col style="width:35%;">
                <col style="width:15%;">
                <col style="width:35%;">
            </colgroup>
            <tbody>
            <tr>
                <th>이름</th>
                <td>${lawtaxCounselVo.apy_nm}</td>
                <th>아이디</th>
                <td>${lawtaxCounselVo.apy_id}</td>
            </tr>
            <tr>
                <th>휴대폰번호</th>
                <td>${lawtaxCounselVo.apy_mob_no}</td>
                <th>이메일</th>
                <td>${lawtaxCounselVo.apy_email}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${lawtaxCounselVo.apy_addr}</td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>신청정보</h3>
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                </div>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%;">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <th>상담분류</th>
                <td>
                    <c:choose>
                        <c:when test="${lawtaxCounselVo.gbn eq 'L'}">법률</c:when>
                        <c:when test="${lawtaxCounselVo.gbn eq 'T'}">세무</c:when>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${lawtaxCounselVo.title}</td>
            </tr>
            <tr>
                <th>상담내용</th>
                <td>${lawtaxCounselVo.cont}</td>
            </tr>
            <tr>
                <th>신청일</th>
                <td>${lawtaxCounselVo.reg_dt}</td>
            </tr>
            <tr>
                <th>진행상태</th>
                <td>
                    <select id="status" name="status">
                        <option value="A" <c:if test="${lawtaxCounselVo.status eq 'A'}">selected="selected"</c:if>>신청</option>
                        <option value="P" <c:if test="${lawtaxCounselVo.status eq 'P'}">selected="selected"</c:if>>처리 중</option>
                        <option value="O" <c:if test="${lawtaxCounselVo.status eq 'O'}">selected="selected"</c:if>>답변완료</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>답변</th>
                <td>
                    <textarea name="rpy_cont" id="rpy_cont" class="textarea wid100per" cols="100%" rows="6" title="답변" <c:if test="${lawtaxCounselVo.status ne 'O'}">disabled</c:if>>${lawtaxCounselVo.rpy_cont}</textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/site/lawtax_list.do" class="btn grey">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
    </form>
</div>
