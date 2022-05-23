
function subInit(){
	location_nav(); 
	dropMenu();
	dataPicker();
	$(".sv_text_box").addClass("on");
	$('.al_text_box').addClass('on');

	// textarea 글자 카운트
	initCalcWord();

	
	//2020.10.26 : s
	actShareBtn(); 
	popupProgramClose();
	actMapPopupOpen();
	actPopupOpen();
	actPopupResize();
	//2020.10.26 : e
	
	//2020.10.27 : s
	actPopupOpen2();
	//2020.10.27 : e
	
	
}

function location_nav() {
	$('.location_nav li a').each(function(ind, item){
		var html = $(item).html();
		$(item).html('<span class="dt_middle">' + html + '</span>');

	})
	$(document).on('click', '.location_nav .deapth_tit', function(event){
		event.preventDefault();
		var $li = $(this).closest('li');
		var $deapth = $('.location_nav li[class*=deapth_]')
		$deapth.removeClass('on')
			.find('ul')
			.stop()
			.slideUp(200);

		$li.toggleClass('on')
			.find('ul')
			.stop()
			.slideToggle(200);
	});
	$(document).on('click', function (event) {
		var $li = $('.location_nav li[class*=deapth_].on');
		var $deapth = $('.location_nav li[class*=deapth_]')
		if (!$li.is(event.target) && $li.has(event.target).length === 0) {
			$deapth.removeClass('on')
					.find('ul')
					.stop()
					.slideUp(200);
		}
	});
}


function dropMenu() {
	$('.tab_box').each(function(ind, item){
		if($(item).find('.tab_item.on').length > 0) {
			$(item).find('.tab_m').addClass('act');
		}
	});
	$('.tab_box a').each(function(ind, item){
		var html = $(item).html();
		$(item).html('<span class="tab_middle">' + html + '</span>');
	});
	$('.brd_line_box a').each(function(ind, item){
		var html = $(item).html();
		$(item).html('<span class="tab_middle">' + html + '</span>');
	});

	$(document).off('click','.tab_box .tab_m').on('click', '.tab_box .tab_m', function(event){
		event.preventDefault();
		var $tab_box = $(this).parents('.tab_box');
		var $deapth = $tab_box.find('.tab');
		$tab_box.toggleClass('on')
			.find('ul')
			.stop()
			.slideToggle(200);
	});
	$(document).on('click', function (event) {
		var $tab_box = $('.tab_box.on');
		var $deapth = $tab_box.find('.tab');
		if (!$tab_box.is(event.target) && $tab_box.has(event.target).length === 0) {
			$tab_box.removeClass('on')
					.find('ul')
					.stop()
					.slideUp(200);
		}
	});

	$(document).off('click','.brd_line_box .tab_m').on('click', '.brd_line_box .tab_m', function(event){
		event.preventDefault();
		var $tab_box = $(this).parents('.brd_line_box');
		var $deapth = $tab_box.find('.tab');
		$tab_box.toggleClass('on')
			.find('ul')
			.stop()
			.slideToggle(200);
	});
	$(document).on('click', function (event) {
		var $tab_box = $('.brd_line_box.on');
		var $deapth = $tab_box.find('.tab');
		if (!$tab_box.is(event.target) && $tab_box.has(event.target).length === 0) {
			$tab_box.removeClass('on')
					.find('ul')
					.stop()
					.slideUp(200);
		}
	});

	$(document).off('click','.tab_box .tab .tab_item  a').on('click', '.tab_box .tab .tab_item  a', function(event){
		var w = $(this).outerWidth();
		var $ti = $(this).parents('.tab_item');
		var ind = $ti.index();
		$('.tab .tab_item').removeClass('on').attr('title', '비 활성화');
		$ti.addClass('on').attr('title', '활성화');
	});
	$(document).off('click','.brd_line_box .tab .tab_item  a').on('click', '.brd_line_box .tab .tab_item  a', function(event){
		var w = $(this).outerWidth();
		var $ti = $(this).parents('.tab_item');
		var ind = $ti.index();
		$('.tab .tab_item').removeClass('on').attr('title', '비 활성화');
		$ti.addClass('on').attr('title', '활성화');
	});

	//접근성 outline
	$(document).off('click','.tab_box .tab .tab_item  a').on('focus', '.tab_box .tab .tab_item  a', function(){
		$(this).closest('.tab_item').addClass('_hover');
	});
	$(document).off('click','.tab_box .tab .tab_item  a').on('blur', '.tab_box .tab .tab_item  a', function(){
		$(this).closest('.tab_item').removeClass('_hover');
	});

	resizeDone();

	var timer;
	var delta = 100;
	$(window).on('resize', function(){
		clearTimeout( timer );
		timer = setTimeout( resizeDone, delta );

	});
	function resizeDone(){
		var w = window.innerWidth;
		if( w >= 1024){
			$('.tab_box .tab').removeAttr('style');
			$('.brd_line_box  .tab').removeAttr('style');
		}
	}
}


function dataPicker(){

	//날짜 
	$(".fm_date .inp").datepicker();

	$(document).on('click', '.fm_date .fm_date_btn', function(){
		$(this).closest('.fm_date').find('.inp').datepicker("show");;
	})
}


// writer jst
// date  20201008

function initCalcWord() {
	// act_word_cnt 클래스가 없다면 그대로 실행 종료
	if($('.act_word_cnt').length <= 0) {
		return;
	}

	// 카운팅 태그 추가를 위한 최대 글자수 저장 배열
	var tgs = [];
	// 카운팅 할 대상이 2개 이상일 경우  each로 저장, 아닐경우 단순 push
	if($('.act_word_cnt').length != 1) {
		$('.act_word_cnt').each(function(idx, el) {
			tgs.push($(this).data('max-word'));
		})
	}else {
		tgs.push($('.act_word_cnt').data('max-word'));
	}
	// 대상을 인덱스별로 찾아 태그 삽입
	$.each(tgs, function(idx, el) {
		var rot = $('.act_word_cnt')[idx];
		var len = $('.act_word_cnt').val().length;
		var par = $(rot).parent();
		var setHtml = '<span class="fw_200 word_cnt_wrap"><b class="now_cnt fw_200">'+len+'</b> / '+tgs[idx]+'</span>';
		par.append(setHtml);
	})
	
}
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
function tableMoHtmlInit(el){
	var th = [];
	$(el).addClass('mo_table_list_ul')
	$(el).find('li.t_head .col').each(function(index, item){
		var text = $(item).text();
		th.push( text);
	})
	$(el).find('li').each(function(index, item){
		if(!$(item).hasClass('_moInit')){
			$(item).addClass('_moInit');
			$(item).find('.col').each(function(index, item){
				$(item).html('<span class="text">' + $(item).html() + '</span>');
				var html = '<span class="label">' + th[index] + '</span>';
				$(item).prepend(html);
			});
		}
	});
}

//2020.11.26 : s
function tableInit() {

	function tableHeight(){
		var w = window.innerWidth;
		$('.table.half').find('> *').removeAttr('style')
		if( w >= 1024){
			$('.table.half').each(function(ind, item){
				
				if( ind % 2  == 1 ){
					var h = $(item).height();
					var h2 = h;
					var prevH = $(item).prev().height();
					console.log(h);
					console.log(prevH);
					if (h <= prevH) {
						h2 = prevH;
					}
					$(item).find('> * ').innerHeight(h2);
					var len = $(item).find('.table').length;
					if (len > 0) { 
						for (var i = 0; i < len; i++){ 
							$(item).find('.table').eq(i).find(' > * ').innerHeight( Math.ceil( h2 / 2 ) -1);
						}
					}
					$(item).prev().find('> * ').innerHeight(h2);
					var len = $(item).prev().find('.table').length;
					if (len > 0) { 
						for (var i = 0; i < len; i++){ 
							$(item).prev().find('.table').eq(i).find(' > * ').innerHeight( Math.ceil( h2 / 2 ) -1 );
						}
					}
				}
			});
		}else{
			$('.table.half').find('> *').removeAttr('style')
		}
	}
	setTimeout(function () { tableHeight(); }, 100);
	$(window).on('resize', function(){
		tableHeight();
	});
}
//2020.11.26 : e


//2020.10.26 : start
function actShareBtn(){
	$(document).on('click', '.act_share_btn', function(){
		$(this).closest('li').find('> ul').fadeToggle(200);
	});
	$(document).off('click', actClose);
	$(document).on('click', actClose);
}

function actClose(event) {
	var $btn = $('.act_share_btn');
	var $box = $('.share_box');
	if (!$btn.is(event.target) && $btn.has(event.target).length === 0) {
		$box.fadeOut(200);
	}
}


function popupProgramClose(){
	$(document).on('click', '.popup_wrap_st3 .close_btn', function(){
		var popupBoxId = $(this).attr('data-popup-id');
		$(popupBoxId).fadeOut(200);
		accessibilityTabIndexRemove(popupBoxId) //common.js 포커싱 제거
		scrollAbleSt2();
	});
}

function actPopupOpen(){
	$(document).on('click', '.act_popup_open', function(){
		var popupBoxId = $(this).attr('data-popup-id');
		if($(popupBoxId).length > 0){
			scrollDisableSt2();
			$(popupBoxId).fadeIn(200);
			accessibilityTabIndex(popupBoxId) //common.js 접근성 포커싱 생성
		}else{
			alert('강사이력보기 실패');
		}
	});
}
function actMapPopupOpen(){
	$(document).on('click', '.act_popup_map_open', function(){
		var popupBoxId = $(this).attr('data-popup-id');
		if($(popupBoxId).length > 0){
			scrollDisableSt2();
			$(popupBoxId).fadeIn(200);
			accessibilityTabIndex(popupBoxId) //common.js 접근성 포커싱 생성
		}else{
			alert('지도오픈 실패');
		}
	});
}

function actPopupResize(){
	popResize();

	var timer;
	var delta = 100;
	$(window).on('resize', function(){
		clearTimeout( timer );
		timer = setTimeout( popResize, delta );

	});
	function popResize(){
		var w = window.innerWidth;
		if($('.popup_wrap_st3').length > 0 && w < 1024){
			scrollDisableSt2();
			$('.popup_wrap_st3 .close_btn').trigger('click');
		}
	}
}
//2020.10.26 : e

//2020.10.27 : s
function actPopupOpen2(){
	$(document).on('click', '.act_popup', function(){
		var popupBoxId = $(this).attr('data-popup-id');
		if($(popupBoxId).length > 0){
			scrollDisableSt2();
			$(popupBoxId).fadeIn(200);
			accessibilityTabIndex(popupBoxId) //common.js 접근성 포커싱 생성
		}else{
			alert('팝업 열기 실패');
		}
	});
}
//2020.10.27 : e


