
/*

2020.12.02 수정사항

꿈마루 미니홈 js 이동 maru.html 스크립트 이동이동

progressSlider();
maruNewsClick();

*/
function mainInit(){

	magnetPopup();
	mainVisualSlide();
	noticeSlide();
	programSlide();
	act_q_menu();


	var timer, oldWid =  window.outerWidth ,delta = 100;
	$(window).off('resize', mainResizeDone);
	$(window).on('resize', mainResizeDone);


	function mainResizeDone(){
		clearTimeout( timer );
		if( oldWid != window.outerWidth ){
			timer = setTimeout( programSlide, delta );
			oldWid = window.outerWidth;
		}
	}

}




function mainVisualSlide(){
	var len = $('.mv > div').length;
	if( len > 0 && !$('.mv').hasClass('slick-slider')) {
		var html = '';

		$('.main_visual').append('<div class="mv_control"></div>')

		$('.main_visual'            ).append('<div class="mv_arrows"></div>')
		$('.main_visual .mv_arrows' ).append('<button type="button" class="mv_prev"><img src="/ssem/resources/img/main/mv_arrow_left.png" alt="이전"></button><button type="button" class="mv_next"><img src="/ssem/resources/img/main/mv_arrow_right.png" alt="다음"></button>')

		//dot 생성
		var $mvSlide = $('.mv').slick({
			infinite: true,
			dots: true,
			slidesToShow: 1,
			slidesToScroll: 1,
			fade: true,
			autoplay: true,
			autoplaySpeed: 5000,
			appendDots : $('.mv_control'),
		});

		$('.mv_control').append('<div class="_player"></div>');
		$('.mv_control ._player').append('<button type="button" class="_btn_play"><img src="/ssem/resources/img/common/icon_play_w.png" alt="시작"></button><button type="button" class="_btn_stop"><img src="/ssem/resources/img/common/icon_stop_w.png" alt="일지정지"></button>');
		$('.mv_control ._btn_play').hide();


		$(document).off('click', '.mv_prev').on('click', '.mv_prev', function(){
			$('.main_visual .mv .slick-prev').trigger('click');
		});

		$(document).off('click', '.mv_next').on('click', '.mv_next', function(){
			$('.main_visual .mv .slick-next').trigger('click');
		});

		$(document).off('.mv_control ._btn_play').find('.mv_control ._btn_play').click(function(){
			$mvSlide.slick('slickPlay');
			$(this).hide();
			$('.mv_control ._btn_stop').show();
		});
		$(document).off('.mv_control ._btn_stop').find('.mv_control ._btn_stop').click(function(){
			$mvSlide.slick('slickPause');
			$(this).hide();
			$('.mv_control ._btn_play').show();
		});
	}
}
function programSlide(){
	var wid = window.innerWidth;
	if(wid > 767){
		if(!$('.program_box').hasClass('slick-slider')){
			/*$('.program_box').slick("unslick");
			$('.program_box_wrap  .p_control').remove();*/
			$('.program_box_wrap').append('<div class="p_control"></div>');

			var $pb = $('.program_box').slick({
				rows: 2,
				arrows:false,
				dots:true,
				infinite: true,
				speed: 300,
				slidesToShow: 4,
				slidesToScroll: 4,
				appendDots : $('.p_control'),

			});
		}
	}else{
		if( !$('.program_box').hasClass('slick-slider')  ){
			$('.program_box_wrap').append('<div class="p_control"></div>');

			var $pb = $('.program_box').slick({
				rows: 2,
				arrows:false,
				dots:true,
				infinite: true,
				speed: 300,
				slidesToShow: 2,
				slidesToScroll: 2,
				appendDots : $('.p_control'),

			});
		}
	}
	$(".program_box").removeAttr('style');
}

function noticeSlide(){
	var len = $('.nt > div').length;
	if( !$('.nt').hasClass('slick-slider')) {
		var html = '';

		$('.notice_wrap > .wrap').find('.more_btn').before('<div class="nt_control mt_20"></div>')

		if( len > 4) {
			$('.notice_wrap > .wrap'            ).find('.more_btn').before('<div class="nt_arrows"></div>')
			$('.notice_wrap > .wrap .nt_arrows' ).append('<button type="button" class="nt_prev"><img src="/ssem/resources/img/main/mv_arrow_left_bk.png" alt="이전"></button><button type="button" class="nt_next"><img src="/ssem/resources/img/main/mv_arrow_right_bk.png" alt="다음"></button>')
		}
		//dot 생성
		var $ntSlide = $('.nt').slick({
			infinite: true,
			arrows:true,
			dots: true,
			slidesToShow: 4,
			slidesToScroll: 4,
			appendDots : $('.nt_control'),
			adaptiveHeight:true,
			responsive: [
				{
					breakpoint: 1440,
					settings: {
						arrows:false,
						slidesToShow: 3,
						slidesToScroll: 3,
					}
				},
				{
				  breakpoint: 600,
				  settings: {
				  	arrows:false,
					slidesToShow: 2,
					slidesToScroll: 2
				  }
				}
			  ]
		});

		if( len > 4) {
			$(document).off('click', '.nt_prev').on('click', '.nt_prev', function(){
				console.log(111);
				$('.notice_wrap .nt .slick-prev').trigger('click');
			});

			$(document).off('click', '.nt_next').on('click', '.nt_next', function(){
				console.log(222);
				$('.notice_wrap .nt .slick-next').trigger('click');
			});
		}
	}
}


function magnetPopup(){


	$(document).on('mouseenter', '.info_btn, .magnet_school_popup', function(){
		$('.magnet_school_popup').stop().fadeIn(200);
	});
	$(document).on('click', '.info_btn', function(){
		$('.magnet_school_popup').stop().fadeIn(200,function(){
			accessIndex('.magnet_school_popup', $(this));
        	accessFocus('.magnet_school_popup');
		});

	});
	$(document).on('mouseleave', '.magnet_school_popup ', function(){
		$('.magnet_school_popup').stop().fadeOut(200, function(){
			accessRemove('.magnet_school_popup');
		});
	});

	$(document).on('click', function (event) {
		var $el = $('.magnet_school_popup, .info_btn');
		if (!$el.is(event.target) && $el.has(event.target).length === 0) {
			accessRemove('.magnet_school_popup');
			$('.magnet_school_popup').stop().fadeOut(200, function(){
				accessRemove('.magnet_school_popup');
			});
		}
	});

}

function act_q_menu(){
	$('.q_box_wrap').addClass('on');

	$(document).on('click', '.q_open', function(){
		$('.q_box_wrap').addClass('on');
	});
	$(document).on('click', '.q_close', function(){
		$('.q_box_wrap').removeClass('on');
	});
}




function closePopup(id){
	$(id).remove();             //popup숨기기
	var len = $('.popup-wrap').find('.popup-box').length;

	if(len == 0){
		$('.popup-bg').hide();
		$('.popup-wrap').hide();
		$('body').attr('style','');
	}
}


// 창열기
function openWin( winName ) {
	var blnCookie    = getCookie( winName );
	var obj = eval( "window." + winName );
	if( !blnCookie ) {
		obj.classList.add( 'show');
	} else{
		obj.classList.remove( 'show');
	}
	closePo();
 }

 // 창닫기
 function closeWin(winName, expiredays) {
	setCookie( winName, "done" , expiredays);
	var obj = eval( "window." + winName );
	obj.classList.remove( 'show');

	closePo();
 }

 function closePopup(id){
	$(id).remove();             //popup숨기기
	var len = $('.main_popup').find('.popup').length;

	if(len < 1){
		$('.main_popup').hide();
	}else{
		$('.main_popup').show();
	}
}


 function closePo(){
	var len = $('.main_popup').find('.popup').length;

	if(len < 1){
		$('.main_popup').hide();
	}else{
		$('.main_popup').show();
	}
 }

 // 쿠키 가져오기
 function getCookie( name ) {
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length )
	{
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
			break;
	}
	return "";
 }


// 24시간 기준 쿠키 설정하기  expiredays 후의 클릭한 시간까지 쿠키 설정
function setCookie( name, value, expiredays ) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
