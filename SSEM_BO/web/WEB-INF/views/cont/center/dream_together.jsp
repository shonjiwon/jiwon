<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:38
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
                            location.href = "/ssemadmin/cont/center/dream_together.do";
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

            if(frm.atch_file_id_one.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_1, "파일선택1")){return false;}
            }
            if(frm.atch_file_id_two.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_2, "파일선택2")){return false;}
            }
            if(frm.atch_file_id_three.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_3, "파일선택3")){return false;}
            }
            if(frm.atch_file_id_four.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_4, "파일선택4")){return false;}
            }
            if(frm.atch_file_id_five.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_5, "파일선택5")){return false;}
            }
            if(frm.atch_file_id_six.value === "") {
                if(!fnIsValidRequired(frm.atch_file_id_6, "파일선택6")){return false;}
            }

            $("#frm").submit();
        });

    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${subMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <form name="frm" id="frm" action="/ssemadmin/cont/center/dream_together.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="idx" id="idx" value="${togetherVo.idx}" />
        <input type="hidden" name="atch_file_id_one" id="atch_file_id_one" value="${togetherList[0].atch_file_id}" />
        <input type="hidden" name="atch_file_id_two" id="atch_file_id_two" value="${togetherList[1].atch_file_id}" />
        <input type="hidden" name="atch_file_id_three" id="atch_file_id_three" value="${togetherList[2].atch_file_id}" />
        <input type="hidden" name="atch_file_id_four" id="atch_file_id_four" value="${togetherList[3].atch_file_id}" />
        <input type="hidden" name="atch_file_id_five" id="atch_file_id_five" value="${togetherList[4].atch_file_id}" />
        <input type="hidden" name="atch_file_id_six" id="atch_file_id_six" value="${togetherList[5].atch_file_id}" />
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>현장직업체험처 참여</h3>
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>

        <table>
            <colgroup>
                <col style="width:10%;">
                <col style="width:30%;">
                <col style="width:10%;">
                <col style="width:20%;">
                <col style="width:10%;">
                <col style="width:20%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="required" rowspan="2">파일등록1</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_1" id="atch_file_id_1" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[0].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[0].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[0].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[0].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[0].up_dt}</td>
            </tr>
            <tr>
                <th class="required" rowspan="2">파일등록2</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_2" id="atch_file_id_2" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[1].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[1].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[1].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[1].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[1].up_dt}</td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>직업인 멘토 참여</h3>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:10%;">
                <col style="width:30%;">
                <col style="width:10%;">
                <col style="width:20%;">
                <col style="width:10%;">
                <col style="width:20%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="required" rowspan="2">파일등록3</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_3" id="atch_file_id_3" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[2].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[2].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[2].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[2].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[2].up_dt}</td>
            </tr>
            <tr>
                <th class="required" rowspan="2">파일등록4</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_4" id="atch_file_id_4" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[3].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[3].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[3].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[3].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[3].up_dt}</td>
            </tr>
            </tbody>
        </table>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
                <h3>학부모진로교육멘토단 참여</h3>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:10%;">
                <col style="width:30%;">
                <col style="width:10%;">
                <col style="width:20%;">
                <col style="width:10%;">
                <col style="width:20%;">
            </colgroup>
            <tbody>
            <tr>
                <th class="required" rowspan="2">파일등록5</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_5" id="atch_file_id_5" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[4].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[4].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[4].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[4].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[4].up_dt}</td>
            </tr>
            <tr>
                <th class="required" rowspan="2">파일등록6</th>
                <td rowspan="2">
                    <input type="file" name="atch_file_id_6" id="atch_file_id_6" class="wid350 mgt10" />
                    <c:forEach items="${togetherList[5].fileList}" var="item" varStatus="status">
                        <div class="imgArea">
                            <span>
                            <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                            </span>
                            <%--<a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a><br/>--%>
                        </div>
                    </c:forEach>
                </td>
                <th>등록자</th>
                <td>${togetherList[5].reg_id}</td>
                <th>등록일</th>
                <td>${togetherList[5].reg_dt}</td>
            </tr>
            <tr>
                <th>최종수정자</th>
                <td>${togetherList[5].up_id}</td>
                <th>최종수정일</th>
                <td>${togetherList[5].up_dt}</td>
            </tr>
            </tbody>
        </table>

        <div class="btnArea">
            <div class="left">
                <ul class="list star">
                    <li>필수입력 <span class="co_red">(6개의 파일 모두 등록 되어야 합니다.)</span></li>
                </ul>
                <ul class="list bili">
                    <li>파일은 교제 등록만 가능하며, 교체 후 [저장]버튼을 눌러야 반영 됩니다.</li>
                </ul>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
            </div>
        </div>
    </article>
    </form>
</div>
