<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:35
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
                            location.href = "?banner_idx=${bannerVo.banner_idx}";
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

            if(!fnIsValidRequired(frm.name, "배너명")){return false;}
            //if(!fnIsValidRequired(frm.attfile, "이미지")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}

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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/center/future_banner_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="banner_idx" value="${bannerVo.banner_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/center/future_banner_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="banner_idx" id="banner_idx" value="${bannerVo.banner_idx}" />
            <input type="hidden" name="atch_file_id" id="atch_file_id" value="${bannerVo.atch_file_id}" />
            <table>
                <colgroup>
                    <col style="width:15%;">
                    <col style="width:35%;">
                    <col style="width:15%;">
                    <col style="width:35%;">
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">배너명</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="name" id="name" value="${bannerVo.name}">
                    </td>
                </tr>
                <tr>
                    <th class="required">노출상태</th>
                    <td colspan="5">
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${bannerVo.use_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${bannerVo.use_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="use_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>노출순서</th>
                    <td colspan="3">
                        <input type="text" class="wid100" name="ord" id="ord" value="${bannerVo.ord}" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                        (<span class="co_red">숫자만 입력가능합니다.</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지</th>
                    <td colspan="3">
                        <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">1920 * 600</span> )
                        <c:forEach items="${bannerVo.fileList}" var="item" varStatus="status">
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
                    <th class="required">이미지대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt" value="${bannerVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th>링크URL</th>
                    <td colspan="3">
                        <input type="text" class="wid500" name="link" id="link" value="${bannerVo.link}">
                        <select id="link_tgt" name="link_tgt" class="wid150">
                            <option value="C" <c:if test="${bannerVo.link_tgt eq 'C'}">selected="selected"</c:if>>현재창</option>
                            <option value="N" <c:if test="${bannerVo.link_tgt eq 'N'}">selected="selected"</c:if>>새창</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td>${bannerVo.reg_id}</td>
                    <th>등록일</th>
                    <td>${bannerVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td>${bannerVo.up_id}</td>
                    <th>최종수정일</th>
                    <td>${bannerVo.up_dt}</td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/center/future_banner_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
