$(window).on('load', function() {
     /*history.replaceState({}, null, location.pathname);*/

    var _bwa = [];
    _bwa.push(['setCollectorUrl', 'https://www.songpa.go.kr/blueworks/api']);
    _bwa.push(['setCustomerId', 'songpa']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript';
    g.src='/ssem/resources/js/blueworksWebAgent-2.0-min.js';
    g.async=g.defer=true;
    s.parentNode.insertBefore(g, s);

    var nodes = $('figure.media oembed');
    nodes.each(function() {
       var url =  $(this).attr('url');

        if(url !== '') {
            var videoId = getId(url);

            var iframeMarkup = '<iframe src="//www.youtube.com/embed/' + videoId + '" frameborder="0" allowfullscreen></iframe>';
            $(this).parent().append(iframeMarkup);
        }
    });

    let style = $( 'figure.table' ).attr('style');
    if(style !== '') {
        $( 'figure.table' ).contents().unwrap().wrap( '<div style="' + style + '"></div>' );
    }
});

function getId(url) {
    var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    var match = url.match(regExp);

    if (match && match[2].length == 11) {
        return match[2];
    } else {
        return 'error';
    }
}

function fnFacebook(url){
    let s = url;
    s = encodeURIComponent(s);
    window.open("http://www.facebook.com/sharer.php?u="+s+"&t=SSEM", '_blank');
}

function fnTwitter(url){
    let s = url;
    s = encodeURIComponent(s);
    window.open("http://twitter.com/home/?status="+s, '_blank');
}

function fnCopyUrlToClipboard(url) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = url;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);

    alert("URL이 클립보드에 복사되었습니다");
}

function fnCopyClipboardEx(url) {
    let tempElem = document.createElement('textarea');
    tempElem.value = url;
    document.body.appendChild(tempElem);

    tempElem.select();
    document.execCommand("copy");
    document.body.removeChild(tempElem);

    alert("URL이 클립보드에 복사되었습니다");
}

function fnGetToday() {
    var date = new Date();
    var year = date.getFullYear();
    var month = new String(date.getMonth()+1);
    var day = new String(date.getDate());

    // 한자리수일 경우 0을 채워준다.
    if(month.length == 1){
        month = "0" + month;
    }
    if(day.length == 1){
        day = "0" + day;
    }

    return year + "-" + month + "-" + day;
}

function fnGetDateMinusMonth(num_month) {
    var date = new Date();
    date.setMonth(date.getMonth() + Number(num_month));

    var year = date.getFullYear();
    var month = new String(date.getMonth()+1);
    var day = new String(date.getDate());

    // 한자리수일 경우 0을 채워준다.
    if(month.length == 1){
        month = "0" + month;
    }
    if(day.length == 1){
        day = "0" + day;
    }

    return year + "-" + month + "-" + day;
}

// fixday : YYYY-MM-DD
function fnGetDateMinusMonthEx(fixday, num_month) {
    /*//alert(fixday);
    var jbSplit = fixday.split('-');
    var fix_year = jbSplit[0];
    var fix_month = jbSplit[1];
    var fix_day = jbSplit[2];*/

    //var date = new Date(Number(fix_year), Number(fix_month) - 1, Number(fix_day));
    var date = new Date(fixday);
    date.setMonth(date.getMonth() + Number(num_month));

    var year = date.getFullYear();
    var month = new String(date.getMonth()+1);
    var day = new String(date.getDate());

    // 한자리수일 경우 0을 채워준다.
    if(month.length == 1){
        month = "0" + month;
    }
    if(day.length == 1){
        day = "0" + day;
    }

    return year + "-" + month + "-" + day;
}

function getToday() {
    let today = new Date();

    let year = today.getFullYear(); // 년도
    let month = today.getMonth() + 1;  // 월
    let date = today.getDate();  // 날짜
    let week = today.getDay();  // 요일

    return year + "-" + month + "-" + date;
}

function goPageNavigation(page) {
    //location.href = param;
    $("#page").val(page);
    $('#frm').submit();
}

function isMobile() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}
