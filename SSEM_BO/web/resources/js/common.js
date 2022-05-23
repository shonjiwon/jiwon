window.onload=function(){

    /*history.replaceState({}, null, location.pathname);*/

    //왼쪽메뉴 클릭
    var menuList = $('.leftMenu > .menu > li > a');
    menuList.click(function() {
        var menuClick = $(this).attr('id');
        var menuId = "#" + menuClick;

        if($(menuList).hasClass('on') === true){
            $('.leftMenu > .menu > li > a').removeClass('on');
            $('.leftMenu > .menu > li > .subMenu').removeClass('on');
        }

        if($(menuList).hasClass('on') === false) {
            $(menuId).toggleClass('on');
            $(menuId).next('.subMenu').toggleClass('on');
        }
    });

    //왼쪽서브메뉴 클릭
    var subMenuList = $('.leftMenu > .menu > li > .subMenu > li > a');
    subMenuList.click(function() {
        var subMenuClick = $(this).attr('id');
        var subMenuId = "#" + subMenuClick;

        // if($(subMenuList).hasClass('on') === true){
        //     $('.leftMenu > .menu > li > .finMenu > a').removeClass('on');
        //     $('.leftMenu > .menu > li > .subMenu').removeClass('on');
        // }

        // if($(subMenuList).hasClass('on') === false) {
        //$(subMenuId).toggleClass('on');
        $(subMenuId).next('.finMenu').toggleClass('on');
        // }
    });


    // 탭메뉴
    var tabList = $(".tabUnit li");
    tabList.click(function() {
        var tabClick = $(this).attr('id');
        var tabOpen = "." + tabClick;
        var tabOpenList = "#" + tabClick;

        $(".tabUnit .list li").removeClass('on')
        $(tabOpenList).addClass('on')
        $(".tabUnit .cont").removeClass('on')
        $(tabOpen).addClass('on')
    });

    // 팝업열기
    /*var popList = $(".popOpen");
    popList.click(function() {
        var popClick = $(this).attr('id');
        var popOpen = "." + popClick;
        $(popOpen).addClass('on')
    });

    // 팝업닫기
    $('.btnClose').click(function() {
        $('.popArea').removeClass('on')
    });*/

    //datepicker
    /*$(function() {
        $("#datepicker_start").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
        $("#datepicker_end").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
        $("#datepicker_start02").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
        $("#datepicker_end02").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
        $("#datepicker_start03").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
        $("#datepicker_end03").datepicker({
            showButtonPanel: true,
            currentText: 'today',
            closeText: 'close',
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage:"img/icon_cal.png",
            buttonImageOnly: true,
            buttonText: "Select date"
        });
    });*/
};
