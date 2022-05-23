<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-15
  Time: 오후 6:46
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
    $(document).ready(function() {
        // 검색 조건중 소속 정보가 있는 경우
        let p_idx = '${adminLoginVo.p_idx}';
        let group_idx = '${adminLoginVo.group_idx}';
        if(p_idx !== '' && group_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">전체</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        } else if(p_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async: false,
                    success: function (data) {
                        $('#group_idx').children().remove();
                        html += '<option value="">전체</option>';
                        $.each(data, function (key, v) {
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        }

        $('#p_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">전체</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            } else {
                $('#group_idx').children().remove();
                html += '<option value="">전체</option>';
                $('#group_idx').append(html);
            }

            $("#top_center").hide();
        });

        $('#group_idx').change(function() {
            group_idx = $(this).val();

            if(group_idx === "75" || group_idx === "76" || group_idx === "77" || group_idx === "78" || group_idx === "86") {
                $("#top_center").show();
            } else {
                $("#top_center").hide();
            }
        });

        if(group_idx === "75" || group_idx === "76" || group_idx === "77" || group_idx === "78" || group_idx === "86") {
            $("#top_center").show();
        }

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
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
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
        <form name="frm" id="frm" action="/ssemadmin/cont/site/notice_inscr.do" method="post" enctype="multipart/form-data">
            <input type="hidden" class="wid100per ta_c" name="main_use_yn" id="main_use_yn" value="N">
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th>소속</th>
                <td>
                    <select id="p_idx" name="p_idx">
                        <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                            <option value="${item.group_idx}" <c:if test="${item.group_idx eq adminLoginVo.p_idx}">selected="selected"</c:if>>${item.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <th class="required">기관</th>
                <td>
                    <select id="group_idx" name="group_idx">
                    </select>
                </td>
            </tr>
            <tr>
                <th>노출상태</th>
                <td colspan="3">
                    <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                    <label for="use_y">노출</label>
                    <input type="radio" name="use_yn" id="use_n" value="N">
                    <label for="use_n">미노출</label>
                </td>
            </tr>
            <tr>
                <th>상단고정노출 여부<br><span class="co_sky">(교육포털)</span></th>
                <td colspan="3">
                    <input type="radio" name="p_top_yn" id="p_top_n" value="N" checked>
                    <label for="top_n">일반</label>
                    <input type="radio" name="p_top_yn" id="p_top_y" value="Y">
                    <label for="top_y">상단고정노출</label>
                </td>
            </tr>
            <tr id="top_center" style="display: none;">
                <th>상단고정노출 여부<br><span class="co_sky">(센터 미니홈페이지)</span></th>
                <td colspan="3">
                    <input type="radio" name="top_yn" id="top_n" value="N" checked>
                    <label for="top_n">일반</label>
                    <input type="radio" name="top_yn" id="top_y" value="Y">
                    <label for="top_y">상단고정노출</label>
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td colspan="3">${adminLoginVo.admin_id}</td>
            </tr>
            <tr>
                <th class="required">제목</th>
                <td colspan="3">
                    <input type="text" class="wid750" name="title" id="title"> <span class="co_red" id="txt_length">0</span>/50
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
                </td>
            </tr>
            <tr>
                <th class="required">내용</th>
                <td colspan="3">
                    <textarea name="cont" id="cont" class="textarea" cols="100%" rows="6" title="내용"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/site/notice_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
