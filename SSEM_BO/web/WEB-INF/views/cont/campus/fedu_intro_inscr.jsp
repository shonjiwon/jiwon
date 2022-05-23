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

            if(!fnIsValidRequired(frm.name, "센터명")){return false;}
            if(!fnIsValidRequired(frm.cont, "프로그램")){return false;}
            if(!fnIsValidRequired(frm.tgt, "대상")){return false;}
            if(!fnIsValidRequired(frm.term_time, "시간")){return false;}
            if(!fnIsValidRequired(frm.capacity, "정원")){return false;}
            if(!fnIsValidRequired(frm.fee, "수강료")){return false;}
            if(!fnIsValidRequired(frm.quest, "문의")){return false;}
            if(!fnIsValidRequired(frm.location, "위치")){return false;}
            if(!fnIsValidRequired(frm.explain, "이용안내")){return false;}
            if(!fnIsValidRequired(frm.thumb_atch_file_id, "썸네일 대표 파일")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "대표이미지대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.thumb_sub_file_id1, "썸네일서브1파일")){return false;}
            if(!fnIsValidRequired(frm.alt_txt1, "서브1이미지대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.thumb_sub_file_id2, "썸네일 서브2 파일")){return false;}
            if(!fnIsValidRequired(frm.alt_txt2, "서브2이미지대체텍스트")){return false;}

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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/fedu_intro_inscr.do" method="post" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>메인노출상태</th>
                    <td colspan="3">
                        <input type="radio" name="main_yn" id="main_y" value="Y" checked>
                        <label for="main_y">노출</label>
                        <input type="radio" name="main_yn" id="main_n" value="N">
                        <label for="main_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${adminLoginVo.p_name}</td>
                    <th>교육기관</th>
                    <td>${adminLoginVo.grp_name}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td colspan="3">
                        ${adminLoginVo.admin_id}
                    </td>
                </tr>
                <tr>
                    <th class="required">센터명</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="name" id="title"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th class="required">프로그램</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="cont" id="cont"></textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">대상</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="tgt" id="tgt">
                    </td>
                </tr>
                <tr>
                    <th class="required">시간</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="term_time" id="term_time">
                    </td>
                </tr>
                <tr>
                    <th class="required">정원</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="capacity" id="capacity">
                    </td>
                </tr>
                <tr>
                    <th class="required">수강표</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="fee" id="fee">
                    </td>
                </tr>
                <tr>
                    <th class="required">문의</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="quest" id="quest">
                    </td>
                </tr>
                <tr>
                    <th class="required">위치</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="location" id="location">
                    </td>
                </tr>
                <tr>
                    <th class="required">이용안내</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="explain" id="explain"></textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 대표 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">775 * 515</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">대표이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 서브1 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_sub_file_id1" id="thumb_sub_file_id1" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">330 * 240</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">서브1 이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt1" id="alt_txt1">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 서브2 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_sub_file_id2" id="thumb_sub_file_id2" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">330 * 240</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">서브2 이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt2" id="alt_txt2">
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/fedu_intro_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
