<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $('#btn_add_isnert').click(function() {
            let frm = document.frm_add;

            if(!fnIsValidRequired(frm.tgt_name, "감면대상")){return false;}
            if(!fnIsValidRequired(frm.rate, "감면률")){return false;}

            $("#frm_add").submit();
        });

        $('#btn_add_pop').click(function() {
            $("#tgt_name").val("");
            $("#dtl_txt").val("");
            $("#rate").val("");
            $(".pop_add").addClass('on');
        });

        // 팝업 수정
        var popUpdateSubmit = $(".btn_item_update_submit");
        popUpdateSubmit.click(function() {
            var discount_idx = $(this).attr('id').replaceAll("item_", "");
            var selector = "#frm_update_" + discount_idx;

            var selector_tgt_name = "#tgt_name_" + discount_idx;
            var selector_rate = "#rate_" + discount_idx;

            $(selector).submit();
        });

        // 삭제
        var popDeleteSubmit = $(".btn_item_delete");
        popDeleteSubmit.click(function() {
            var discount_idx = $(this).attr('id').replaceAll("delete_", "");

            let frm = document.frm_delete;
            frm.discount_idx.value = discount_idx;

            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);

        });

        // 팝업 열기
        var popUpdate = $(".btn_item_update");
        popUpdate.click(function() {
            var discount_idx = $(this).attr('id');
            var selector = "#pop_update_" + discount_idx;

            $(selector).addClass('on')
        });

        // 팝업닫기
        $('.btnClose').click(function() {
            $('.popArea').removeClass('on');
        });

        $('.btn_pop_close').click(function() {
            $('.popArea').removeClass('on');
        });
    });

    function delete_frm() {
        document.frm_delete.submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area">
        <div class="btnArea mgt0 mgb10">
            <div class="btnArea mgt0 mgb10">
                <div class="left">
                    <h3>${groupVo.p_name} - ${groupVo.name}</h3>
                </div>
                <div class="right">

                </div>
            </div>
            <%--<div class="left">
                총 <b><fmt:formatNumber value="${totalCount}" pattern="##,###"/></b>건
            </div>--%>
            <div class="right">
            </div>
        </div>
        <form name="frm_delete" id="frm_delete" method="post" action="/ssemadmin/cont/lecture/discount_delete.do" enctype="multipart/form-data">
            <input type="hidden" name="discount_idx"/>
            <input type="hidden" name="group_idx" value="${groupVo.group_idx}"/>
        </form>
        <table>
            <colgroup>
                <col style="width:8%">
                <col style="width:20%">
                <col>
                <col style="width:20%">
                <col style="width:10%">
            </colgroup>
            <thead>
            <tr>
                <th>NO</th>
                <th>감면대상</th>
                <th>상세조건</th>
                <th>감면율(%)</th>
                <th>수정/삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${fn:length(itemList) == 0}">
                <tr>
                    <td colspan="5">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:set var="lno" value="0"/>
            <c:forEach items="${itemList}" var="item" varStatus="status">
                <c:set var="lno">${lno + 1}</c:set>
                <tr>
                    <td><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></td>
                    <td>${item.tgt_name}</td>
                    <td>${item.dtl_txt}</td>
                    <td>${item.rate}</td>
                    <td>
                        <a href="#none" class="btn sml blue btn_item_update" id="${item.discount_idx}">수정</a>
                        <a href="#none" class="btn sml blue btn_item_delete" id="delete_${item.discount_idx}">삭제</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <common:pageLinkAdmin name="pageholder"/>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/lecture/discount_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_add_pop">등록</a>
            </div>
        </div>
    </article>
</div>

<section class="popArea pop_add">
    <div class="popBody" style="width: 80rem !important;">
        <div class="tit">
            <h2>감연정보등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_add" id="frm_add" method="post" action="/ssemadmin/cont/lecture/discount_inscr.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" id="group_idx" value="${groupVo.group_idx}"/>
                    <table>
                        <colgroup>
                            <col style="width:20rem">
                            <col>
                        </colgroup>
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <th class="required">소속</th>
                            <td class="ta_l">
                                ${groupVo.p_name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육기관</th>
                            <td class="ta_l">
                                ${groupVo.name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">감면대상</th>
                            <td class="ta_l">
                                <input type="text" class="wid100per" name="tgt_name" id="tgt_name" placeholder="감면대상">
                            </td>
                        </tr>
                        <tr>
                            <th>상세조건</th>
                            <td class="ta_l">
                                <input type="text" class="wid100per" name="dtl_txt" id="dtl_txt" placeholder="상세조건">
                            </td>
                        </tr>
                        <tr>
                            <th class="required">감면률</th>
                            <td class="ta_l">
                                <select id="rate" name="rate" class="wid150">
                                    <option value="">선택</option>
                                    <c:forEach items="${rateList}" var="rate" varStatus="status">
                                        <option value="${rate}">${rate}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey" id="btn_add_isnert">저장</a>
                        <a href="#none" class="btn red btn_pop_close">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>

<c:forEach items="${itemList}" var="item" varStatus="status">
<section class="popArea pop_update" id="pop_update_${item.discount_idx}">
    <div class="popBody" style="width: 80rem !important;">
        <div class="tit">
            <h2>감연정보등록</h2>
            <a href="#none" class="btnClose">
                <span class="material-icons">close</span>
            </a>
        </div>
        <div class="cont">
            <article class="contUnit tbl_area">
                <form name="frm_update_${item.discount_idx}" id="frm_update_${item.discount_idx}" method="post" action="/ssemadmin/cont/lecture/discount_upscr.do" enctype="multipart/form-data">
                    <input type="hidden" name="group_idx" value="${item.group_idx}"/>
                    <input type="hidden" name="discount_idx" value="${item.discount_idx}"/>
                    <table>
                        <colgroup>
                            <col style="width:15%">
                            <col style="width:35%">
                            <col style="width:15%">
                            <col>
                        </colgroup>
                        <thead>
                        </thead>
                        <tbody>
                        <tr>
                            <th class="required">소속</th>
                            <td class="ta_l" colspan="3">
                                ${groupVo.p_name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">교육기관</th>
                            <td class="ta_l" colspan="3">
                                ${groupVo.name}
                            </td>
                        </tr>
                        <tr>
                            <th class="required">감면대상</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid100per" name="tgt_name" id="tgt_name_${item.discount_idx}" placeholder="감면대상" value="${item.tgt_name}">
                            </td>
                        </tr>
                        <tr>
                            <th>상세조건</th>
                            <td class="ta_l" colspan="3">
                                <input type="text" class="wid100per" name="dtl_txt" placeholder="상세조건" value="${item.dtl_txt}">
                            </td>
                        </tr>
                        <tr>
                            <th class="required">감면률</th>
                            <td class="ta_l" colspan="3">
                                <select name="rate" id="rate_${item.discount_idx}" class="wid150">
                                    <option value="">선택</option>
                                    <c:forEach items="${rateList}" var="rate" varStatus="status">
                                        <option value="${rate}" <c:if test="${rate eq item.rate}">selected="selected"</c:if>>${rate}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>등록자</th>
                            <td class="ta_l">${item.reg_id}</td>
                            <th>등록일</th>
                            <td class="ta_l">${item.reg_dt}</td>
                        </tr>
                        <tr>
                            <th>최종수정자</th>
                            <td class="ta_l">${item.up_id}</td>
                            <th>최종수정일</th>
                            <td class="ta_l">${item.up_dt}</td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btnArea">
                    <div class="left">
                    </div>
                    <div class="right">
                        <a href="#none" class="btn grey btn_item_update_submit" id="item_${item.discount_idx}">저장</a>
                        <a href="#none" class="btn red btn_pop_close">취소</a>
                    </div>
                </div>
            </article>
        </div>
    </div>
</section>
</c:forEach>
