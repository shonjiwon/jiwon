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
        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.name, "배너명")){return false;}
            if(!fnIsValidRequired(frm.attfile, "이미지")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}

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
        <form name="frm" id="frm" action="/ssemadmin/cont/center/jamsil_banner_inscr.do" method="post" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width:15%;">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">배너명</th>
                    <td>
                        <input type="text" class="wid750" name="name" id="name">
                    </td>
                </tr>
                <tr>
                    <th class="required">노출상태</th>
                    <td colspan="3">
                        <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N">
                        <label for="use_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>노출순서</th>
                    <td>
                        <input type="text" class="wid100" name="ord" id="ord" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                        (<span class="co_red">숫자만 입력가능합니다.</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지</th>
                    <td colspan="3">
                        <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">1920 * 600</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지대체텍스트</th>
                    <td>
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt">
                    </td>
                </tr>
                <tr>
                    <th>링크URL</th>
                    <td>
                        <input type="text" class="wid500" name="link" id="link">
                        <select id="link_tgt" name="link_tgt" class="wid150">
                            <option value="C">현재창</option>
                            <option value="N">새창</option>
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/center/jamsil_banner_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
