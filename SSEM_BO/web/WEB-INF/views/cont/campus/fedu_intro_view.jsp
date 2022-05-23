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

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssemadmin/file/file_delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: "atch_file_id=" + del_id_arr[0] + "&file_num=" + del_id_arr[1],
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("삭제에 실패하였습니다.");
                        } else {
                            alert("삭제하였습니다.");
                            location.href = "?future_edu_intro_idx=${futureEduIntroVo.future_edu_intro_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });

        $("#btn_update").click(function(){
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
            /*if(!fnIsValidRequired(frm.thumb_atch_file_id, "썸네일 대표 파일")){return false;}*/
            if(!fnIsValidRequired(frm.alt_txt, "대표이미지대체텍스트")){return false;}
            /*if(!fnIsValidRequired(frm.thumb_sub_file_id1, "썸네일서브1파일")){return false;}*/
            if(!fnIsValidRequired(frm.alt_txt1, "서브1이미지대체텍스트")){return false;}
            /*if(!fnIsValidRequired(frm.thumb_sub_file_id2, "썸네일 서브2 파일")){return false;}*/
            if(!fnIsValidRequired(frm.alt_txt2, "서브2이미지대체텍스트")){return false;}

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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/campus/fedu_intro_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="future_edu_intro_idx" value="${futureEduIntroVo.future_edu_intro_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/fedu_intro_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="future_edu_intro_idx" id="future_edu_intro_idx" value="${futureEduIntroVo.future_edu_intro_idx}" />
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
                        <input type="radio" name="main_yn" id="main_y" value="Y" <c:if test="${futureEduIntroVo.main_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="main_y">노출</label>
                        <input type="radio" name="main_yn" id="main_n" value="N" <c:if test="${futureEduIntroVo.main_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="main_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${futureEduIntroVo.p_name}</td>
                    <th>교육기관</th>
                    <td>${futureEduIntroVo.grp_name}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        ${futureEduIntroVo.reg_id}
                    </td>
                    <th>작성일</th>
                    <td>${futureEduIntroVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종 수정자</th>
                    <td>
                        ${futureEduIntroVo.up_id}
                    </td>
                    <th>최종 수정일</th>
                    <td>${futureEduIntroVo.up_dt}</td>
                </tr>
                <tr>
                    <th class="required">센터명</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="name" id="title" value="${futureEduIntroVo.name}"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th class="required">프로그램</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="cont" id="cont">${futureEduIntroVo.cont}</textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">대상</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="tgt" id="tgt" value="${futureEduIntroVo.tgt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">시간</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="term_time" id="term_time" value="${futureEduIntroVo.term_time}">
                    </td>
                </tr>
                <tr>
                    <th class="required">정원</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="capacity" id="capacity" value="${futureEduIntroVo.capacity}">
                    </td>
                </tr>
                <tr>
                    <th class="required">수강표</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="fee" id="fee" value="${futureEduIntroVo.fee}">
                    </td>
                </tr>
                <tr>
                    <th class="required">문의</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="quest" id="quest" value="${futureEduIntroVo.quest}">
                    </td>
                </tr>
                <tr>
                    <th class="required">위치</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="location" id="location" value="${futureEduIntroVo.location}">
                    </td>
                </tr>
                <tr>
                    <th class="required">이용안내</th>
                    <td colspan="3">
                        <textarea rows="5" class="wid100per" name="explain" id="explain">${futureEduIntroVo.explain}</textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 대표 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">775 * 515</span> )
                        <c:forEach items="${futureEduIntroVo.thumbFileList}" var="item" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                                <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>
                                <img src="${item.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">대표이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt" value="${futureEduIntroVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 서브1 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_sub_file_id1" id="thumb_sub_file_id1" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">330 * 240</span> )
                        <c:forEach items="${futureEduIntroVo.thumbSubFileList1}" var="item" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                                <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>
                                <img src="${item.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">서브1 이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt1" id="alt_txt1" value="${futureEduIntroVo.alt_txt1}">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 서브2 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_sub_file_id2" id="thumb_sub_file_id2" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">330 * 240</span> )
                        <c:forEach items="${futureEduIntroVo.thumbSubFileList2}" var="item" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                                <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>
                                <img src="${item.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">서브2 이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt2" id="alt_txt2" value="${futureEduIntroVo.alt_txt2}">
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
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
