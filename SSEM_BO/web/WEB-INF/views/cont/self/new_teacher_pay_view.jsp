<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $('#btn_update').click(function() {
            var frm = document.frm;

            if(!fnIsValidRequired(frm.group_idx, "동별")){return false;}
            if(!fnIsValidRequired(frm.lecture_cnt, "프로그램수")){return false;}
            if(!fnIsValidRequired(frm.classroom_cnt, "수강인원")){return false;}
            if(!fnIsValidRequired(frm.teacher_cnt, "강사수")){return false;}
            if(!fnIsValidRequired(frm.apply_amount, "신청액")){return false;}

            $("#frm").submit();
        });

        $('#btn_auto').click(function() {
            if($('#group_idx').val() !== '') {
                location.href = "/ssemadmin/cont/self/new_teacher_pay_auto_update.do?sdate=${newTracLecturerCostVo.standard_yymm}&lecturer_cost=${newTracLecturerCostVo.lecturer_cost}&group_idx=" + $('#group_idx').val();
            } else {
                alert("동을 선택해 주세요.")
            }
        });

        $('#btn_delete').click(function() {
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

    <form name="delfrm" id="delfrm" action="/ssemadmin/cont/self/new_teacher_pay_delete.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="lecturer_cost" value="${newTracLecturerCostVo.lecturer_cost}" />
    </form>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>

            <div class="left" style="width:60%">
                <span class="co_red">*기준 년/월 정보와 동별 구분 선택 후 [자동입력]을 클릭하면 프로그램실적등록에서 구비금액이 0원이 아닌 목록이 계산되어 입력 됩니다.</span><br/><br/>
                <span class="co_red">*</span> 필수입력
            </div>
            <div class="right" style="width:80%">
                <div class="tblMsg ta_r">
                    <a href="#none" class="btn sml blue mgl20" id="btn_auto">자동입력</a>
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/self/new_teacher_pay_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="lecturer_cost" value="${newTracLecturerCostVo.lecturer_cost}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">기준년월</th>
                    <td colspan="3">
                        ${newTracLecturerCostVo.standard_yymm}
                        <input type="hidden" class="wid150" id="standard_yymm" name="standard_yymm" value="${newTracLecturerCostVo.standard_yymm}">
                    </td>
                </tr>
                <tr>
                    <th class="required">동별</th>
                    <td>
                        <select id="group_idx" name="group_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                            <option value="">선택하세요</option>
                            <c:forEach items="${dongList}" var="dong" varStatus="status">
                                <option value="${dong.group_idx}" <c:if test="${newTracLecturerCostVo.group_idx eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th class="required">프로그램수</th>
                    <td>
                        <input type="text" class="wid150" id="lecture_cnt" name="lecture_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${newTracLecturerCostVo.lecture_cnt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">수강인원</th>
                    <td>
                        <input type="text" class="wid150" id="classroom_cnt" name="classroom_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${newTracLecturerCostVo.classroom_cnt}"> 명
                    </td>
                    <th class="required">강사수</th>
                    <td>
                        <input type="text" class="wid150" id="teacher_cnt" name="teacher_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${newTracLecturerCostVo.teacher_cnt}"> 명
                    </td>
                </tr>
                <tr>
                    <th class="required">신청액</th>
                    <td colspan="3">
                        <input type="text" class="wid150" id="apply_amount" name="apply_amount" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${newTracLecturerCostVo.apply_amount}"> 원
                    </td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" id="note" name="note" value="${newTracLecturerCostVo.note}">
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn grey" id="btn_update">저장</a>
                <a href="#none" class="btn red" id="btn_delete">삭제</a>
                <a href="/ssemadmin/cont/self/new_teacher_pay_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
