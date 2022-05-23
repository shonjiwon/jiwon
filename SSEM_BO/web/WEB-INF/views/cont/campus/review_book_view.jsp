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
                            location.href = "?person_book_idx=${personBookVo.person_book_idx}";
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

            if(!fnIsValidRequired(frm.cate_cd, "분류")){return false;}
            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.person, "인물도서")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.cont, "내용")){return false;}

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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/campus/review_book_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="person_book_idx" value="${personBookVo.person_book_idx}" />
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/review_book_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="person_book_idx" id="person_book_idx" value="${personBookVo.person_book_idx}" />
            <input type="hidden" name="atch_file_id" id="atch_file_id" value="${personBookVo.atch_file_id}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>노출상태</th>
                    <td colspan="3">
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${personBookVo.use_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${personBookVo.use_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="use_n">미노출</label>
                    </td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td>${personBookVo.p_name}</td>
                    <th>교육기관</th>
                    <td>${personBookVo.grp_name}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td colspan="3">${personBookVo.reg_id}</td>
                </tr>
                <tr>
                    <th class="required">분류</th>
                    <td colspan="3">
                        <select id="cate_cd" name="cate_cd" class="kind">
                            <option value="J" <c:if test="${personBookVo.cate_cd eq 'J'}">selected="selected"</c:if>>진로직업</option>
                            <option value="C" <c:if test="${personBookVo.cate_cd eq 'C'}">selected="selected"</c:if>>문화예술</option>
                            <option value="H" <c:if test="${personBookVo.cate_cd eq 'H'}">selected="selected"</c:if>>인문교양</option>
                            <option value="P" <c:if test="${personBookVo.cate_cd eq 'P'}">selected="selected"</c:if>>인성심리</option>
                            <option value="E" <c:if test="${personBookVo.cate_cd eq 'E'}">selected="selected"</c:if>>전문인</option>
                            <option value="Z" <c:if test="${personBookVo.cate_cd eq 'Z'}">selected="selected"</c:if>>기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">제목</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="title" id="title" value="${personBookVo.title}"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th class="required">인물도서</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="person" id="person" value="${personBookVo.person}">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif, png / 사이즈 : <span class="co_red">450 * 305</span> )
                        <c:forEach items="${personBookVo.thumbFileList}" var="thumb" varStatus="status">
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
                    <th class="required">이미지대체텍스트</th>
                    <td>
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt" value="${personBookVo.alt_txt}">
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                        <ul id="file_ul">
                            <li class="mb5" style="display:none">
                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                            </li>
                        </ul>
                        <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                        <c:forEach items="${personBookVo.fileList}" var="item" varStatus="status">
                            <c:if test="${item != null}">
                                <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                    <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th class="required">내용</th>
                    <td colspan="3">
                        <textarea name="cont" id="cont" class="textarea" cols="100%" rows="6" title="내용">${personBookVo.cont}</textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/review_book_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
