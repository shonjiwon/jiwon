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

            if(!fnIsValidRequired(frm.gubun, "악기유형")){return false;}
            if(!fnIsValidRequired(frm.name, "악기명")){return false;}
            if(!fnIsValidRequired(frm.fee_str, "대여료")){return false;}
            if(!fnIsValidRequired(frm.qty, "보유수량")){return false;}
            if(!fnIsValidRequired(frm.attfile, "악기 사진")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.cont, "악기설명")){return false;}

            frm.fee.value = replaceAll(frm.fee_str.value, ",", "");

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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/instrum_reg_inscr.do" method="post" enctype="multipart/form-data">
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
                        <input type="radio" name="use_yn" id="use_y" value="Y" checked>
                        <label for="use_y">노출</label>
                        <input type="radio" name="use_yn" id="use_n" value="N">
                        <label for="use_n">미노출</label>
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
                    <td colspan="3">${adminLoginVo.admin_id}</td>
                </tr>
                <tr>
                    <th class="required">악기유형</th>
                    <td colspan="3">
                        <select class="wid250" name="gubun" id="gubun">
                            <option value="">선택</option>
                            <option value="A">건반악기</option>
                            <option value="B">관악기</option>
                            <option value="C">타악기</option>
                            <option value="D">현악기</option>
                            <option value="E">MIDI장비</option>
                            <option value="K">국악기</option>
                            <option value="Z">기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">악기명</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="name" id="name">
                    </td>
                </tr>
                <tr>
                    <th class="required">대여료</th>
                    <td colspan="3">
                        <input type="hidden" name="fee" id="fee"/>
                        <input type="text" class="wid350" name="fee_str" id="fee_str" onkeyup="numberWithCommas(this.value, 'fee_str');" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 원 / 월
                    </td>
                </tr>
                <tr>
                    <th class="required">보유수량</th>
                    <td colspan="3">
                        <input type="text" class="wid350" name="qty" id="qty" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> 개
                    </td>
                </tr>
                <tr>
                    <th class="required">악기사진</th>
                    <td colspan="3">
                        <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif / 사이즈 : <span class="co_red">430 * 280</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지대체텍스트</th>
                    <td>
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt">
                    </td>
                </tr>
                <tr>
                    <th class="required">악기설명</th>
                    <td colspan="3">
                        <textarea name="cont" id="cont" class="textarea" cols="100%" rows="6" title="내용"></textarea>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/campus/instrum_reg_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
