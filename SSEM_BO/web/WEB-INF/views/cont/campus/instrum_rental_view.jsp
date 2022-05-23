<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-30
  Time: 오전 5:15
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
            var frm = document.frm;

            if(!fnIsValidRequired(frm.name, "시설명")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지 대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.capacity, "사이즈(수용인원)")){return false;}
            if(!fnIsValidRequired(frm.use_time, "이용시간")){return false;}
            if(!fnIsValidRequired(frm.intro, "이용안내")){return false;}
            if(!fnIsValidRequired(frm.cont, "시설설명")){return false;}
            if(!fnIsValidRequired(frm.fee, "대관료(시간당)")){return false;}

            $("#frm").submit();
        });

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
                            location.href = "?rental_fty_idx=${rentalFtyVo.rental_fty_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/instrum_rental_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="rental_fty_idx" value="${rentalFtyVo.rental_fty_idx}" />
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
                        <input type="text" class="wid350" name="name" id="name" value="${rentalFtyVo.name}">
                    </td>
                    <th class="required">대관여부</th>
                    <td>
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${rentalFtyVo.use_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="use_y">대관</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${rentalFtyVo.use_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="use_n">대관불가</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${adminLoginVo.p_name}</td>
                    <th>교육기관</th>
                    <td>${adminLoginVo.grp_name}</td>
                    <input type="hidden" name="group_idx" id="group_idx" value="${rentalFtyVo.group_idx}"/>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${rentalFtyVo.reg_id}</td>
                    <th>등록일</th>
                    <td>${rentalFtyVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td>${rentalFtyVo.up_id}</td>
                    <th>최종수정일</th>
                    <td>${rentalFtyVo.up_dt}</td>
                </tr>
                <tr>
                    <th class="required">썸네일 이미지</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        <span>(파일형식 : jpg, jpge, png, gif / <span class="co_red">사이즈 : 970*685</span>)</span>
                        <c:forEach items="${rentalFtyVo.thumbFileList}" var="thumb" varStatus="status">
                            <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${thumb.atch_file_id}&amp;fileNum=${thumb.file_num}">${thumb.file_ori_nm}</a>
                            </span>
                                <a href="#" id="btn_file_del_${thumb.atch_file_id}_${thumb.file_num}" class="btn_del">x</a><br/>
                                <img src="${thumb.file_src}">
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지 대체텍스트</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" name="alt_txt" id="alt_txt" value="${rentalFtyVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th class="required">사이즈(수용인원)</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="capacity" id="capacity" value="${rentalFtyVo.capacity}">
                    </td>
                </tr>
                <tr>
                    <th class="required">이용시간</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="use_time" id="use_time" value="${rentalFtyVo.use_time}"> 입력예) 13:00~21:00 (최소1시간~최대3시간)
                    </td>
                </tr>
                <tr>
                    <th class="required">이용안내</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="intro" id="intro" value="${rentalFtyVo.intro}">
                    </td>
                </tr>
                <tr>
                    <th class="required">시설설명</th>
                    <td colspan="3">
                        <textarea rows="10" class="wid100per" name="cont" id="cont">${rentalFtyVo.cont}</textarea>
                    </td>
                </tr>
                <tr>
                    <th class="required">대관료 (시간당)</th>
                    <td colspan="3">
                        <input type="text" class="wid150" name="fee" id="fee" value="${rentalFtyVo.fee}">원
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
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
</div>
