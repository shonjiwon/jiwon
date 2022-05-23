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
        $('#summary').keyup(function (event) {
            if($(this).val().length > 80) {
                if(event.keyCode !== 8) {
                    alert("80자까지만 입력이 가능합니다.");
                }
                $('#summary').val($('#summary').val().substr(0, $('#summary').val().length -1));
            } else {
                $('#summary_length').text($(this).val().length);
            }
        });

        $('#summary').keydown(function (event) {
            if($(this).val().length > 80) {
                if(event.keyCode !== 8) {
                    alert("80자까지만 입력이 가능합니다.");
                }
                $('#summary').val($('#summary').val().substr(0, $('#summary').val().length -1));
            } else {
                $('#summary_length').text($(this).val().length);
            }
        });
        /* Date Picker Settings */
        $('#year_month').daterangepicker({
            "singleDatePicker": true,
            "timePicker": false,
            "linkedCalendars": false,
            "showCustomRangeLabel": false,
            "buttonClasses": "btn btn_cal",
            "locale": {
                "format": "YYYY-MM",
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": ["일","월","화","수","목","금","토"],
                "monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
                "firstDay": 0
            }
        }, function(start, end, label) {
            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });

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

            if(!fnIsValidRequired(frm.cate_cd, "분류")){return false;}
            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.year_month, "선정월 선택")){return false;}
            if(!fnIsValidRequired(frm.summary, "요약정보")){return false;}
            if(!fnIsValidRequired(frm.person, "인물도서")){return false;}
            if(!fnIsValidRequired(frm.thumb_atch_file_id, "썸네일 파일")){return false;}
            if(!fnIsValidRequired(frm.alt_txt, "이미지대체텍스트")){return false;}
            if(!fnIsValidRequired(frm.cont, "내용")){return false;}

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
        <form name="frm" id="frm" action="/ssemadmin/cont/campus/month_book_inscr.do" method="post" enctype="multipart/form-data">
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
                    <th class="required">분류</th>
                    <td colspan="3">
                        <select id="cate_cd" name="cate_cd" class="kind">
                            <option value="">선택</option>
                            <option value="J">진로직업</option>
                            <option value="C">문화예술</option>
                            <option value="H">인문교양</option>
                            <option value="P">인성심리</option>
                            <option value="E">전문인</option>
                            <option value="Z">기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">제목</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="title" id="title"> <span class="co_red" id="txt_length">0</span>/50
                    </td>
                </tr>
                <tr>
                    <th class="required">선정월 선택</th>
                    <td colspan="3">
                        <input type="text" id="year_month" name="year_month" class="wid150">
                        <a href="javascript:showCalendar('year_month');" style="border-bottom: 0px solid #000; !important;"><img src="/ssemadmin/resources/img/icon_cal.png"></a>
                        ( 일자를 선택하면 해당 월 정보가 입력됩니다. )
                    </td>
                </tr>
                <tr>
                    <th class="required">요약정보</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="summary" id="summary"> <span class="co_red" id="summary_length">0</span>/80
                    </td>
                </tr>
                <tr>
                    <th class="required">인물도서</th>
                    <td colspan="3">
                        <input type="text" class="wid750" name="person" id="person">
                    </td>
                </tr>
                <tr>
                    <th class="required">썸네일 파일</th>
                    <td colspan="3">
                        <input type="file" name="thumb_atch_file_id" id="thumb_atch_file_id" class="wid350 mgt10" />
                        (파일형식: jpg, jpeg, bmp, gif / 사이즈 : <span class="co_red">720 * 515</span> )
                    </td>
                </tr>
                <tr>
                    <th class="required">이미지대체텍스트</th>
                    <td>
                        <input type="text" class="wid750" name="alt_txt" id="alt_txt">
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
                <a href="/ssemadmin/cont/campus/month_book_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>
