<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 7:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    .ck-editor__editable {
        min-height: 250px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        add_file();

        ClassicEditor
            .create( document.querySelector( '#cont' ), {
                /*plugins: [ CKFinder ],*/
                ckfinder: { uploadUrl: '/ssemadmin/editor/imgUpload.do' },
                /*plugins: [ SimpleUploadAdapter ],
                simpleUpload: { uploadUrl: '/editor/imgUpload.do' },*/
                toolbar: {
                    items: [
                        'heading',
                        '|',
                        'Source',
                        'code',
                        '|',
                        'bold',
                        'italic',
                        'fontColor',
                        'fontSize',
                        'underline',
                        'link',
                        'bulletedList',
                        'numberedList',
                        '|',
                        'alignment:left',
                        'alignment:right',
                        'alignment:center',
                        'alignment:justify',
                        '|',
                        'indent',
                        'outdent',
                        '|',
                        'imageUpload',
                        'mediaEmbed',
                        'blockQuote',
                        'insertTable',
                        'undo',
                        'redo',
                        '|',
                        'htmlEmbed',

                    ]
                },
                language: 'ko',
                image: {
                    toolbar: [
                        'imageTextAlternative',
                        'imageStyle:alignLeft',
                        'imageStyle:full',
                        'imageStyle:side'
                    ],
                    styles: [ 'full','alignLeft','alignRight','side' ]
                },
                table: {
                    contentToolbar: [
                        'tableColumn',
                        'tableRow',
                        'mergeTableCells',
                        'tableCellProperties',
                        'tableProperties'
                    ]
                },
                licenseKey: ''
            } )
            .then( editor => {
                window.editor = editor;
            } )
            .catch( error => {
                console.error( error );
            } );

        $("#btn_insert").click(function(){
            var frm = document.frm;

            frm.cont.value = window.editor.getData();

            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.cont, "본문")){return false;}

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
                            location.href = "?bbs_detail_idx=${bbsDetailVo.bbs_detail_idx}";
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

            frm.cont.value = window.editor.getData();

            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.cont, "본문")){return false;}

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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/center/jamsil_notice_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="bbs_detail_idx" value="${bbsDetailVo.bbs_detail_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/center/jamsil_notice_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="bbs_detail_idx" id="bbs_detail_idx" value="${bbsDetailVo.bbs_detail_idx}" />
            <input type="hidden" name="atch_file_id" id="atch_file_id" value="${bbsDetailVo.atch_file_id}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:20%">
                    <col style="width:10%">
                    <col style="width:5%">
                </colgroup>
                <tbody>
                <tr>
                    <th>노출상태</th>
                    <td colspan="5">
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${bbsDetailVo.use_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${bbsDetailVo.use_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="use_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>상단고정노출 여부<%--<br><span class="co_blue">(센터 미니홈페이지)</span>--%></th>
                    <td colspan="5">
                        <input type="radio" name="top_yn" id="top_n" value="N" <c:if test="${bbsDetailVo.top_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="top_n">일반</label>
                        <input type="radio" name="top_yn" id="top_y" value="Y" <c:if test="${bbsDetailVo.top_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="top_y">상단고정노출</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${bbsDetailVo.p_name}</td>
                    <th>기관</th>
                    <td colspan="3">${bbsDetailVo.grp_name}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${bbsDetailVo.reg_id}</td>
                    <th>작성일</th>
                    <td>${bbsDetailVo.reg_dt}</td>
                    <th>조회수</th>
                    <td>${bbsDetailVo.cnt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td>${bbsDetailVo.up_id}</td>
                    <th>작성일</th>
                    <td colspan="3">${bbsDetailVo.up_dt}</td>
                </tr>
                <tr>
                    <th class="required">제목</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="title" id="title" value="${bbsDetailVo.title}"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="5">
                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                        <ul id="file_ul">
                            <li class="mb5" style="display:none">
                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                            </li>
                        </ul>
                        <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                        <c:forEach items="${bbsDetailVo.fileList}" var="item" varStatus="status">
                            <c:if test="${item != null}">
                                <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                    <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                </div>
                            </c:if>
                        </c:forEach>
                        <%--<div class="imgArea">
                            <span>filename.png</span>
                            <a href="#none" class="btn_del">x</a><br>
                            <img src="/ssemadmin/resources/img/temp/img_001.png">
                        </div>
                        <div class="imgArea">
                            <span class="tit">filename.png</span>
                            <a href="#none" class="btn_del">x</a><br>
                            <img src="/ssemadmin/resources/img/temp/img_001.png">
                        </div>--%>
                    </td>
                </tr>
                <tr>
                    <th class="required">내용</th>
                    <td colspan="3">
                        <textarea name="cont" id="cont" class="textarea" cols="100%" rows="6" title="내용">${bbsDetailVo.cont}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/center/jamsil_notice_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
