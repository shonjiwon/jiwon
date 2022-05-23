<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 4:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '시설안내 > 마천청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js

        var timer;
		var delta = 100;
		$(window).on('resize', function(){
			clearTimeout( timer );
			timer = setTimeout( resizeDone, delta );
	
		});
		function resizeDone(){
			var w = window.innerWidth;
			$('.sfl_item.on .img_box').removeAttr('style');
			$('.sfl_item.on').removeClass('on');
		}
		
		$(document).on('click', '.sfl_item a', function(e){
			e.preventDefault();
	
			var $lis  = $(this).parent('li').siblings();
			var $li   = $(this).parent('li');
			var ind   = $li.index();
			
	
			$('.slide_fac_list_2 li').each(function(ind, item){
				$(item).find('.img_box ._control').remove();
				$(item).find('.img_box  .sfl_img_nav').removeClass('none_slide')
				$(item).find('.img_box  .sfl_img_nav .on').removeClass('on');
				$(item).off('click', '.img_box  .sfl_img_nav .sfl > div');
	
				if($(item).find('.img_box  .sfl_img_list .sfl').hasClass('slick-slider')){
					$(item).find('.img_box  .sfl_img_list .sfl').slick('unslick');
				}
				if($(item).find('.img_box  .sfl_img_nav .sfl').hasClass('slick-slider')){
					$(item).find('.img_box  .sfl_img_nav .sfl').slick('unslick');
				}
			});
	
			
			$lis.removeClass('on').find('a').attr('title', '드롭 비활성');
			$lis.find('.img_box').stop().slideUp();
	
			$li.toggleClass(function(){
				if ( $( this ).is( ".on" ) ) {
					$(this).find('a').attr('title', '드롭 비활성')
				} else {
					$(this).find('a').attr('title', '드롭 활성')
				}
				return 'on';
			})
			$li.find('.img_box').stop().slideToggle();
			
			slider(ind)
		});
    });

    function slider(ind){
		var $li = $('.sfl_item').eq(ind);
            $li.find('.img_box  .sfl_img_list .sfl').after('<div class="_control"></div>');
            
		var $sf;
		var $sfNav;
		var slickOptions = {
			slidesToShow: 1,
			slidesToScroll: 1,
			arrows:true,
            dots:false,
            fade: true,
			nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next3.png' alt='다음'> </ button>",
            prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev3.png' alt='이전'> </ button>",
			appendArrows:	$li.find('._control'),
			appendDots : $li.find('._control'),
			responsive: [{
				breakpoint: 1024,
				settings: {
					arrows: false,
				}
			}]
		};
	
		var slickOptionsNav = {
			slidesToShow: 9,
			slidesToScroll: 9,
			asNavFor:  '.img_box:eq('+ind+')  .sfl_img_list .sfl',
			dots: true,
			focusOnSelect: true,
			arrows:false,
		};
	
		if($li.find('.sfl_img_nav .sfl > div').length == 1 ){
	
		}else if($li.find('.sfl_img_list .sfl > div').length > 1  && $li.find('.sfl_img_list .sfl > div').length <= 9){
			$sf = $li.find('.img_box  .sfl_img_list .sfl').slick(slickOptions);
			$sf.on('beforeChange', function(event, slick, currentSlide, nextSlide){
				$('.none_slide .sfl > div').removeClass('on').eq(nextSlide).addClass('on');
			});
		}else{
			slickOptions.asNavFor =  '.img_box:eq('+ind+')  .sfl_img_nav .sfl';
			$sf = $li.find('.img_box  .sfl_img_list .sfl').slick(slickOptions);
		}
	
		/*slide nav*/
		if($li.find('.sfl_img_nav .sfl > div').length <= 1 ){
			$li.find('.img_box  .sfl_img_nav .sfl').hide();
			$li.find('.img_box  .sfl_img_nav').remove();
		}else if($li.find('.sfl_img_nav .sfl > div').length > 1 && $li.find('.sfl_img_nav .sfl > div').length <= 9){
			var $noSlide = $li.find('.img_box  .sfl_img_nav').addClass('none_slide');
				$noSlide.find('.sfl > div:eq(0)').addClass('on');
				$noSlide.on('click', '.sfl > div',function(){
					$(this).addClass('on')
					$(this).siblings().removeClass('on');
					$sf.slick('slickGoTo', $(this).index());
				});
		}else{
			$sfNav = $li.find('.img_box  .sfl_img_nav .sfl').slick(slickOptionsNav);
		}
	}
</script>
<div class="contents" id="contents">
    <div class="sub_visual macheon_st_4"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    시설안내
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">시설안내</a>
                        <ul>
                            <li><a href="/ssem/machuncenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/machuncenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/machuncenter/biz/major.do">주요사업</a></li>
                            <li><a href="/ssem/machuncenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/machuncenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>

                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <section class="text_con pb_100 mb_15">
            <h1 class="tit2 mt_100 mb_50">시설안내</h1>

            <div class="wrap">
                <div class="slide_fac_list_2 fs_18 fs_md_26">
                    <ul>
                        <!--item : s --> 
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        5F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>강당, 관장실, 물품보관실</span>
                                            <span>면적 : 343.44㎡</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample1.jpg" alt="강당">
                                            <div>
                                                강당, 관장실, 물품보관실
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample1.jpg" alt="강당"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        4F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>소나무언덕 3호 작은도서관</span>
                                            <span>면적 : 343.44㎡</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample2.jpg" alt="소나무언덕 3호 작은도서관">
                                            <div>
                                                소나무언덕 3호 작은도서관
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample2.jpg" alt="소나무언덕 3호 작은도서관"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        3F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>꿈터301~305(프로그램실), 도담도담실, 상담실, 청운위실</span>
                                            <span>면적 : 343.44㎡	</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample3.jpg" alt="프로그램실">
                                            <div>
                                                꿈터301~305(프로그램실), 도담도담실, 상담실, 청운위실
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample3.jpg" alt="프로그램실"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        2F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>꿈터201~206(프로그램실), 음악실, 다목적실, 동아리실
                                            </span>
                                            <span>면적 : 343.44㎡
                                            </span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample4.jpg" alt="프로그램실">
                                            <div>
                                                꿈터201~206(프로그램실), 음악실, 다목적실, 동아리실
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample4.jpg" alt="프로그램실"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        1F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>사무실, 안내데스크, 드림스타트
                                            </span>
                                            <span>면적 : 294.84㎡
                                            </span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample6.jpg" alt="안내데스크">
                                            <div>
                                                사무실, 안내데스크, 드림스타트
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample6.jpg" alt="안내데스크"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="sfl_item">
                            <a href="javascript:void(0)" title="드롭 비활성">
                                <section class="sfl_top_box">
                                    <div class="wid_200 fs_22 fs_md_26 fw_600">
                                        지하
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span>주차장, 기계실
                                            </span>
                                            <span>면적 : 479.34㎡
                                            </span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/macheon/mf_sample7.jpg" alt="주차장">
                                            <div>
                                                주차장, 기계실
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/macheon/mf_sample7.jpg" alt="주차장"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--item : e -->
                    </ul>
                </div>
            </div>
        </section>
    </div>
</div>
