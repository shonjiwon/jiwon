// 입력글자수 실시간 세크
$(document).ready(function () {
    // 입력 문자열 계산 //////////////////////////////////////////////////////////////////////////////////////////
    $('#title').keyup(function (event) {
        if($(this).val().length > 50) {
            if(event.keyCode !== 8) {
                alert("50자까지만 입력이 가능합니다.");
            }
            $('#title').val($('#title').val().substr(0, $('#title').val().length -1));
        } else {
            $('#txt_length').text($(this).val().length);
        }
    });

    $('#title').keydown(function (event) {
        if($(this).val().length > 50) {
            if(event.keyCode !== 8) {
                alert("50자까지만 입력이 가능합니다.");
            }
            $('#title').val($('#title').val().substr(0, $('#title').val().length -1));
        } else {
            $('#txt_length').text($(this).val().length);
        }
    });

    let title = $('#title').val();
    if(!isEmpty(title) && title !== '') {
        $('#txt_length').text(title.length);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    // 첨부파일 한줄 삭제
    $(document).on('click', '.btn_del' , function(){
        if($("#file_ul li").size() > 1){
            var clickedRow = $(this).parent();
            clickedRow.remove();
        }
        return false;
    });

    // 첨부파일 추가
    $("#btn_add").click(function(){
        add_file();
        return false;
    });
});

// 숫자만 입력가능
function fnIsNumberKeyCode(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;

    alert(keyID);
    if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
    {
        return true;
    }
    else
    {
        if (keyID == 8) {return true;} /* 백스페이스 예외 허용 */
        if (keyID == 9) {return true;} /* 탭 예외 허용 */
        return false;
    }
}

function add_file()
{
    var lastItemNo = $("#file_ul li:last").find("input:eq(0)").attr("id").replace("attfile", "");
    $("#file_ul li:eq(0)").attr("style", "display:none");

    if(lastItemNo == '#'){
        lastItemNo = 0;
    }
    var newitem = $("#file_ul li:eq(0)").clone();
    newitem.attr("style", "");
    newitem.removeClass();
    newitem.find("input").each(function(){
        $(this).attr("id", $(this).attr("id").replace("#", parseInt(lastItemNo)+1));
    });
    newitem.find("label").each(function(){
        $(this).attr("for", $(this).attr("for").replace("#", parseInt(lastItemNo)+1));
    });
    $("#file_ul").append(newitem);
}

function showCalendar(id) {
    var selector = "#" + id;
    $(selector).trigger("click");
}

function nvl(str, defaultStr){

    if(typeof str == "undefined" || str == null || str == "")
        str = defaultStr ;

    return str ;
}

function isEmpty(str){

    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}

function numberWithCommas(x, name) {
    var selector = '#' + name;
    x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
    x = x.replace(/,/g,'');          // ,값 공백처리

    $(selector).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
}

function replaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}

// 글자수 입력 제한
function calcWordLng(max_length) {
    var MAX_LENGTH = max_length;
    var tg = event.currentTarget,
        wordCnt = $(tg).val().length,
        writer = $(tg).parent().find('.word_cnt_wrap');
    if(wordCnt > MAX_LENGTH) {
        alert(MAX_LENGTH+'글자까지 입력 가능합니다.');
        var bakWord = $(tg).val().substr(0,200);
        $(tg).val(bakWord);
        wordCnt = $(tg).val().length;
    }
    writer.find('.now_cnt').text(wordCnt);
}

// 콤마 찍기
function numberWithCommasString(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function goPageNavigation(page) {
    $("#page").val(page);
    $('#frm').submit();
}
