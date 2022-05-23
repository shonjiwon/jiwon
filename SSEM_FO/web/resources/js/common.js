
$(window).on('load', function() {
  $('body').removeClass('_load');
});

function commonInit(){
  $('body').prepend('<div class="screen_md_hide" id="boolPcMo"></div>');
  try {
    moInit();
    actMenu();
    textEllipsis();
    familysite();
    actSearch();
    actAlSearch();
    headerTop();
    fn_topBtn();
    $(window).scroll(headerTop);
    $('a[target="_blank"]').attr('title', '새창');
    //접근성 popup
	  accessibilityFocus(); 
  } catch (error) {
    console.error(error);
    $('body').removeClass('_load');

  }
}

function fn_pcMo(){
  var pcMo = document.getElementById('boolPcMo');
  var pcMo_bool = ( window.getComputedStyle(pcMo).getPropertyValue('display') == 'block' ) ? 'pc' : 'mo';
  
  return pcMo_bool;
}


function fn_topBtn(){
  if($('.top_btn').length > 0){
    $('body').prepend('<div class="body_first_focus" tabindex="0" style=" overflow: hidden; height: 0;">최상단</div>')
    $( '.top_btn button' ).click( function() {
      $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
      $( 'body .body_first_focus' ).focus();
        return false;
    });
  }
}
  
function headerTop(){
    var st     = $(this).scrollTop();
    var w      = $(this).outerWidth();
    var h      = $('#header').outerHeight() / 2 ;

    if(st > h && !$('#header').hasClass('_fixed') ){
        $('#header').addClass('_fixed');
    }else if(st <= h && $('#header').hasClass('_fixed')){
        $('#header').removeClass('_fixed').removeAttr('style');
    }
}


function menuHeight(){

  var top = $('.h_area_bottom').offset().top;
  var h  = $('.h_area_bottom').height();

  var wH = window.innerHeight;
  var st = $(window).scrollTop();
  var maxH = wH - (h + top - st) - 2;
  
  $('.depth_2_box').css({
    'max-height' : maxH,
  });

}

//pc 메뉴
function actMenu(){

    //menu wrap
    $('#header .depth_1').each(function(){
      
        var $depth_1  =  $(this),
        $depth_2_box  =  $depth_1.find('> .depth_2_box');

        if($depth_2_box.length > 0 && $depth_2_box.find('.scroll_box').length < 1){

          $depth_2_box.find('.wrap').wrap('<div class="scroll_box"></div>');

        }

    });

    function actMenuOpen(){

      var $depth_1  =  $(this);

      if(!$(this).hasClass('.depth_1')){

        var $a        =  $(this);
            $depth_1  =  $a.closest('.depth_1');

      }

      $depth_1.siblings().find('>a').removeClass('on');
      $depth_1.siblings().find('> .depth_2_box').hide();

      var $depth_2_box  =  $depth_1.find('> .depth_2_box');

          $depth_1.find('> a').addClass('on');

          $depth_2_box.stop().slideDown(200,function(){

            $depth_2_box.addClass('on');

            menuHeight();

          });
    }

    //메뉴 열기
    $(document).on('focus', '.depth_1 > a', actMenuOpen);
    $(document).on('mouseenter', '.depth_1', actMenuOpen);
   

    //메뉴 닫기
    $(document).on('mouseleave', '.depth_1', function(){

      var $depth_1  =  $(this),
          $depth_2_box  =  $depth_1.find('> .depth_2_box');

          $depth_1.find('> a').removeClass('on');

          $depth_2_box.stop().slideUp(200,function(){

            $depth_2_box.removeClass('on');

            $depth_2_box.removeAttr('style');

          });
    });

    $(document).on('keydown', function(e){
        var code = e.keyCode || e.which;
        if ( ( code == '9' && e.shiftKey && $(e.target).is('#gnb .depth_1:first > a') ) || (code == '9' && $('#gnb a').index(e.target) == ($('#gnb a').length -1)  ) ) {

            var $depth_1  =  $('.depth_1'),
                $depth_2_box  =  $depth_1.find('> .depth_2_box');
      
                $depth_1.find('> a').removeClass('on');
      
                $depth_2_box.stop().slideUp(200,function(){
      
                  $depth_2_box.removeClass('on');
      
                  $depth_2_box.removeAttr('style');
      
                });

        }
        
    });

      
      
}




function allMneuH(){
  $('.all_mneu .depth_2').removeAttr('style');
  if( fn_pcMo() == 'pc'){
    $('.all_mneu .depth_1').find('.depth_2').prepend('<div class="_line"></div>')
  }else{
    $('.all_mneu ._line').remove();
  } 
}

function moInit(){

  var $mo_menu = $('all_menu_gnb all_mneu _load').css({opacity : 0, display: 'block'});

  $('#header').after($mo_menu);
  $('.all_menu_gnb.all_mneu').after('<div class="_bg"></div>');
  $('.all_menu_gnb').find('#gnb').removeAttr('id');
  $('.all_menu_gnb').find(' > .text_hide').text('모바일 메뉴');
  
  $('.all_menu_gnb .depth_1').each(function(){
    var depth2 = $(this).find('.depth_2_box .wrap').html();
    $(this).append( depth2 );
    $(this).find('.depth_title, .depth_2_box').remove();
  });

  $('.all_menu_gnb li > a').each(function(){
    var $a     =  $(this),
        $icon  =  $a.find('i[class*=icon_], i[class^=icon_]'),
        $li    =  $a.closest('li');

    if( $li.find(' > ul').length > 0 ) {
      $a.addClass('no_link');
    }
    if( $icon.length > 0 ) {
      $a.addClass('export_link');
      $a.find('i').remove();
    }
  });
  
  $(document).off('click', '.act_menu');
  $(document).on('click', '.act_menu', function(e){
    e.preventDefault();

    $btn = $(this);

    if($btn.hasClass('on')){
      $btn.removeClass('on');

      $('.all_mneu').stop().hide().addClass('on _load');
      $('.all_mneu li').removeClass('on');

      $('.all_menu_gnb + ._bg').hide();

      
      if( fn_pcMo() == 'mo' ){
        $('.search_bar_box').hide();
        $('.al_search_bar_box').hide();
      }

      //접근성
      accessRemove('.all_mneu');
      
      scrollAbleSt2(); //스크롤 막기 헤제
    }else{
      $btn.addClass('on');

      scrollDisableSt2();//스크롤 막기 
      $('.all_menu_gnb + ._bg').show();
      
      $('.all_mneu').show().removeClass('on _load');
      allMneuH();
      allMenuHeight();

      if( fn_pcMo() == 'mo' ){
        $('.search_bar_box').show();
        $('.al_search_bar_box').show();
      }
      //접근성
      accessIndex('.all_mneu',  $('.act_menu'));
      accessFocus('.all_mneu');
    }
  });

  var $am = $('.all_mneu');
  if($am.find('.all_mneu_close').length < 1){
    $am.append('<button class="all_mneu_close">닫기</button>');
  }
  $(document).on('click', '.all_mneu_close' ,function(){
    $('.act_menu.on').trigger('click');
  });


  var timer,timer2 ,oldWid =  window.outerWidth  ,delta = 100;
  $(window).on('resize', function(){ // resize 후 한번만 실행
    clearTimeout( timer );
    timer = setTimeout( resizeAllMenu, delta );
    if( oldWid != window.outerWidth ){
      clearTimeout( timer2 );
      timer2 = setTimeout( meneClose, delta );
    }
  });

  resizeAllMenu();
  $('.all_menu_gnb.all_mneu').hide(function(){
    $(this).removeAttr('style');
  });

}

function meneClose(){
  $('.act_menu.on').trigger('click');
}

function allMenuHeight($depth_2_box){

  var top = $('#header').offset().top;
  var h  = $('#header').height();

  var wH = window.innerHeight;
  var st = $(window).scrollTop();
  var maxH = wH - h + top - st;

  $('.all_mneu').css({
    'max-height' : maxH,
  });

}



function resizeAllMenu(){
  
  $(document).off('click','.no_link');
  if(fn_pcMo() == 'mo'){
    $(document).on('click', '.no_link', function(e){
      e.preventDefault();

      var $a     =  $(this),
          $icon  =  $a.find('i[class*=icon_], i[class^=icon_]'),
          $li    =  $a.closest('li');
      
    
      if($li.hasClass('on')){
        $li.removeClass('on')
        $a.next('ul').stop().slideUp(200,function(){
        });
      }else{
        $li.addClass('on')
        $a.next('ul').stop().slideDown(200,function(){
        });
      }
    });
  }else{
    $('.all_mneu [style]').removeAttr('style');
    $('.all_mneu li').removeClass('on');
  }
  allMenuHeight();
  allMneuH();
}
function actSearch(){

  $(document).off('click','.act_search_bar');
  $(document).on('click','.act_search_bar', function(){
    var $actBtn =  $(this);
    $actBtn.toggleClass('on');

    if(  $actBtn.hasClass('on') ){

      $('.search_bar_box').removeClass('off');
      $('.search_bar_box').stop().slideDown(200,function(){
        accessIndex('.search_bar_box', $actBtn);
        accessFocus('.search_bar_box');
      });

     
    }else{
      $('.search_bar_box').stop().slideUp(200,function(){
        accessRemove('.search_bar_box');
        $('.search_bar_box').removeAttr('style').addClass('off');
        console.log(1212);
      });
    }
    
  });
  
  $('.search_bar_box').append('<button type="button"  class="accessClose">닫기</button>');
  $(document).on('click', '.accessClose' ,function(){
    $('.act_search_bar').trigger('click');
  });

  var timer, oldWid =  window.outerWidth , delta = 100;
  $(window).on('resize', function(){ // resize 후 한번만 실행
    if( oldWid != window.outerWidth ){
      clearTimeout( timer );
      timer = setTimeout( searchBarInit, delta );
    }
  });
  function searchBarInit(){
    $('.search_bar_box').removeAttr('style').addClass('off');
    $('.act_search_bar').removeClass('on');
  }

}

// 접근성 관련 포커스 생성
function accessRemove(el){
  var $actPopBtn = $('[data-access-btn="on"]');
  $(el).removeAttr('tabindex');
  $(el).find('._focus_first').remove();
  $(el).find('._focus_last').remove();
  $actPopBtn.focus().removeAttr('data-access-btn');        
}
function accessIndex(el, $btn){

	if($(el).find('._focus_first').length < 1){
    
    $(el).prepend('<div tabindex="0" class="_focus_first"><span class="text_hide">처음</span></div>');
    
  } 
	if($(el).find('._focus_last').length < 1){
    
		$(el).append('<div tabindex="0" class="_focus_last"><span class="text_hide">마지막</span></div>');

  } 
  setTimeout( function(){  $btn.attr('data-access-btn', 'on');}, 100 );
	$(el).attr('tabindex','0');
}

// 접근성 관련 포커스 강제 이동 
function accessFocus(el) { 
	$(document).off('focus', '._focus_last').on('focus', '._focus_last', function(){ 
		$(el).find('._focus_first').focus(); 
  }); 
  
  $(el).off('focus').on('focus', function(){
    $(this).find('._focus_last').focus(); 
  });
  setTimeout( function(){$(el).find('._focus_first').focus();}, 100 );
  
}

function actAlSearch() {
  var docWid = window.outerWidth;
  if( fn_pcMo == 'mo' ) return;

  if($('.act_al_search_bar').length < 1){
    $('<button class="act_al_search_bar">닫기</button>');
  }
  $(document).on('click', '.all_mneu_close' ,function(){
    $('.act_menu.on').trigger('click');
  });
  
  $(document).off('click', '.act_al_search_bar');
  $(document).on('click', '.act_al_search_bar', function() {
    console.log('test');
    $(this).toggleClass('on');
    var tH = $(this).closest('#header').find('.h_area_top').css('height');
    var tB = $(this).closest('#header').find('.h_area_bottom').css('height');
    $('.al_search_bar_box').toggleClass('off').hasClass('off') ? $('.al_search_bar_box').hide() : $('.al_search_bar_box').show();
  })
  var timer, oldWid =  window.outerWidth , delta = 100;
  $(window).on('resize', function(){ // resize 후 한번만 실행
    if( oldWid != window.outerWidth ){
      clearTimeout( timer );
      timer = setTimeout( searchBarInit, delta );
    }
  });
  $(document).on('click', function(e) {
    var $tg = $('.act_al_search_bar');
    var $tgBox = $('.al_search_bar_box');
    if($tg.is(e.currentTarget.activeElement) || $tgBox.find(e.currentTarget.activeElement).length != 0) return;
    if($tg.length > 0 && $tg.hasClass('on')) {
      $tg.toggleClass('on');
      $tgBox.toggleClass('off').hasClass('off') ? $tgBox.hide() : $tgBox.show();
    }
  })

  function searchBarInit(){
    $('.al_search_bar_box').removeAttr('style').addClass('off');
    $('.act_al_search_bar').removeClass('on');
  }
  
}

function textEllipsis(){

  $('.ellip_1').ellipsis({
    lines: 1,             
    ellipClass: 'ellip',  
    responsive: true      
  });
  
  $('.ellip_2').ellipsis({
    lines: 2,            
    ellipClass: 'ellip', 
    responsive: true     
  });

  $('.ellip_3').ellipsis({
    lines: 3,            
    ellipClass: 'ellip', 
    responsive: true     
  });

}

function familysite(){
  $('.family_site_box a').each(function(){
    if( $(this).find('.sapn_wrap').length < 1){
      $(this).html('<span class="sapn_wrap">'+$(this).html()+'</span>');
    }
  });
  
  
  //2020.12.18 : s
  $('.family_site_box').off('click', '.fs_btn');

  $('.family_site_box').on('click', '.fs_btn', function(e){

      e.preventDefault();

      var $fs_btn = $(this),
          $fs     = $fs_btn.closest('.family_site');

          $fs.toggleClass('on');

          $fs.siblings('.on').find('.family_site_close').remove();

          $fs.siblings('.on').removeClass('on').find('ul').hide();

          $fs_btn.next('ul').slideToggle(200,function(){

            if($fs.hasClass('on')){

              $fs.append('<button class="text_hide family_site_close">닫기</button>');

            }else{

              $fs.find('.family_site_close').remove();

            }
      })

  });

  $(document).on('click', '.family_site_close' ,function(){
    $(this).closest('.family_site').find('.fs_btn').trigger('click');
  });
  //2020.12.18 : e
}



// idName popup id
// click btn
function popupOpen(idName, el){
  scrollDisableSt2(); 

  if(idName != null ){ 
    //접근성 포커싱
    accessibilityTabIndex(idName);
  }
  
  if(el != null){ 
    $(el).addClass(idName.replace('#','') + 'Btn');
    $(idName).attr('data-popup-btn',idName.replace('#','') + 'Btn');
  }
}


function popupClose(idName){
    $(idName).fadeOut(200);
    accessibilityTabIndexRemove(idName) ///포커싱 제거
    scrollAbleSt2();
}

// 접근성 관련 포커스 생성
function accessibilityTabIndexRemove(idName){

  var actPopBtn = $(idName).attr('data-popup-btn');
  console.log(actPopBtn);

  $(idName).find('.popup_focus_first').remove();
  $(idName).find('.popup_focus_last').remove();

  if(actPopBtn != ''){
    $('.'+actPopBtn).focus().removeClass(actPopBtn);
  }
}
function accessibilityTabIndex(idName){
	$(idName).attr('tabindex','0').attr('data-popup-bg', idName);

	$(idName).find('.popup_box').attr('tabindex','0');

	$(idName).find('.popup_box').focus();

	if($(idName).find('.popup_box .popup_focus_first').length < 1){
		
		$(idName).append('<div tabindex="0" class="popup_focus_first"></div>');

	} 
	if($(idName).find('.popup_box .popup_focus_last').length < 1){
		
		$(idName).prepend('<div tabindex="0" class="popup_focus_last"></div>');

	} 
}

// 접근성 관련 포커스 강제 이동 
function accessibilityFocus() { 
	$(document).on('focus', '.popup_focus_last', function(){ 
		$(this).siblings('.popup_focus_first').focus(); 
	}); 
	$(document).on('focus', '.popup_focus_first', function(){ 
		$(this).siblings('.popup_box').focus(); 
	}); 
}

function getScrollBarWidth () {//ScrollBarWidth
  return window.innerWidth - document.documentElement.clientWidth;
};

function handler(e){ //이벤트 막기
  e.preventDefault();
}

function scrollDisable(){ //scrollDisable on
  $('body').css( 'right', getScrollBarWidth() + 'px' ).addClass('scrollDisable')

  document.body.addEventListener('touchmove',   handler, {passive: false}); 
  document.body.addEventListener('mousewheel',  handler, {passive: false}); 
  document.body.addEventListener('scroll',      handler, {passive: false}); 
}

function scrollAble(){ //scrollDisable off
  $('body').removeAttr('style').removeClass('scrollDisable');
  document.body.removeEventListener('touchmove',  handler, {passive: true}); 
  document.body.removeEventListener('mousewheel', handler, {passive: true}); 
  document.body.removeEventListener('scroll',     handler, {passive: true}); 
}

function scrollDisableSt2(){ //scrollDisable on
  document.getElementsByTagName('body')[0].style.overflow = 'hidden';
}

function scrollAbleSt2(){ //scrollDisable off
  document.getElementsByTagName('body')[0].removeAttribute('style');
}
