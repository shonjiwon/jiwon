<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.name, "시설명")){return false;}
            if(!fnIsValidRequired(frm.thumb_atch_file_id, "썸네일 이미지")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지 대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.capacity, "사이즈(수용인원)")){return false;}
            if(!fnIsValidRequired(frm.use_time, "이용시간")){return false;}
            if(!fnIsValidRequired(frm.intro, "이용안내")){return false;}
            if(!fnIsValidRequired(frm.cont, "시설설명")){return false;}
            if(!fnIsValidRequired(frm.fee, "대관료(시간당)")){return false;}

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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/instrum_rental_inscr.do" method="post" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">시설명</th>
                    <td>
                        <input type="text" class="wid350" name="name" id="name">
                    </td>
                    <th class="required">대관여부</th>
                    <td>
                        <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                        <label for="use_y">대관</label>
                        <input type="radio" name="use_yn" id="use_n" value="N">
                        <label for="use_n">대관불가</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${adminLoginVo.p_name}</td>
                    <th>교육기관</th>
                    <td>${adminLoginVo.grp_name}</td>
                    <input type="hidden" name="group_idx" id="group_idx" value="${adminLoginVo.group_idx}"/>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td colspan="3">${adminLoginVo.admin_id}</td>
                </tr>
                <tr>
                    <th class="required">썸네일 이미지</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        <span>(파일형식 : jpg, jpge, png, gif / <span class="co_red">사이즈 : 970*685</span>)</span>
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt">
                    </td>
                </tr>
                <tr>
                    <th class="required">사이즈(수용인원)</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="capacity" id="capacity">
                    </td>
                </tr>
                <tr>
                    <th class="required">이용시간</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="use_time" id="use_time"> 입력예) 13:00~21:00 (최소1시간~최대3시간)
                    </td>
                </tr>
                <tr>
                    <th class="required">이용안내</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="intro" id="intro">
                    </td>
                </tr>
                <tr>
                    <th class="required">시설설명</th>
                    <td colspan="3">
                        <textarea rows="10" class="wid100per" name="cont" id="cont"></textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">대관료 (시간당)</th>
                    <td colspan="3">
                        <input type="text" class="wid150" name="fee" id="fee">원
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/instrum_rental_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
