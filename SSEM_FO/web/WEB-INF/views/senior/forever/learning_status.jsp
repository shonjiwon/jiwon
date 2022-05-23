<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '현황 > 평생학습원 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        slider();
    });

    function slider(){

        var $el = $('.sg_img_wrap');
			$el.find('.sg_img').append('<div class="_control"></div>')


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
            appendArrows:	$el.find('._control'),
			appendDots : $el.find('._control'),
			responsive: [{
				breakpoint: 1024,
				settings: {
					//arrows: false,
				}
			}]
		};

		var slickOptionsNav = {
			slidesToShow: 9,
			slidesToScroll: 1,
			asNavFor:  '.sg_img .sg',
			dots: false,
			focusOnSelect: true,
			arrows:false,
		};

		if($el.find('.sg_img .sg > div').length == 1 ){

		}else if($el.find('.sg_img .sg > div').length > 1  && $el.find('.sg_img .sg > div').length <= 9){
			$sf = $el.find('.sg_img .sg').slick(slickOptions);
			$sf.on('beforeChange', function(event, slick, currentSlide, nextSlide){
				$('.none_slide .sg > div').removeClass('on').eq(nextSlide).addClass('on');
			});
		}else{
			slickOptions.asNavFor =  '.sg_img_nav .sg';
			$sf = $el.find('.sg_img .sg').slick(slickOptions);
		}

		if($('.sg_img_nav .sg > div').length <= 1 ){
			$('.sg_img_nav').remove();
		} else if($('.sg_img_nav .sg > div').length > 1 && $('.sg_img_nav .sg > div').length <= 9){
			var $noSlide = $('.sg_img_nav').addClass('none_slide');
		     	$noSlide.find('.sg > div:eq(0)').addClass('on');
				$noSlide.on('click', '.sg > div',function(){
					$(this).addClass('on')
					$(this).siblings().removeClass('on');
					$sf.slick('slickGoTo', $(this).index());
				});
		} else{
			$sfNav = $('.sg_img_nav .sg').slick(slickOptionsNav);
		}
	}
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    평생교육
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생교육</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습도시 송파</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습원</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">연혁</a></li>
                            <li><a href="/ssem/senior/forever/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                            <li><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                            <li><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                            <li><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div><!--sub_nav_wrap//-->
    <!--

        sub_con st_1 color - #3f78d4
        sub_con st_2 color - #e08c34
        sub_con st_3 color - #9e61e4
        sub_con st_4 color - #f05484
        sub_con st_5 color - #1fb593

    -->
    <div class="sub_con st_5"><!-- sub_con -->
        <section class="text_con pb_100 mb_15">
            <h3 class="mt_80 mb_50 tit font_sc">평생학습도시 송파</h3>
            <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
                <h4 class="text_hide">탭</h4>
                <a href="#" class="tab_m">평생학습원<i class="icon_arrow_down_w ml_60">다운</i></a>
                <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                    <li  class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                    <li  class="tab_item on"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                    <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
                </ul>
            </div><!-- tab_box //-->
            <h4 class="tit2 mt_100 mb_50">평생학습원</h4>
            <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
                <h4 class="text_hide">3뎁스 탭</h4>
                <ul class="tab tab_2">
                    <li class="tab_item on"><a href="/ssem/senior/forever/learning_status.do">현황</a></li>
                    <li class="tab_item"><a href="/ssem/senior/forever/learning_tocome.do">오시는 길</a></li>
                </ul>
            </div>
            <div class="wrap">
                <div class="bg_color_2 mt_50">
                    <div class="fs_28 ptb_30 t_center fw_500 plr_20">
                        <span class="fs_28 tc_5">배움으로 미래를 여는 송파구 평생학습원</span>은<br>
                        송파구 주민의 평생학습권을 실현하는 기관으로, 생애주기별 맞춤형 평생학습 강좌,<br class="pc">
                        배움ON 특강, 학습동아리 학습활동 지원 등을 통하여 지역 내 평생학습문화 조성 및 확산을<br class="pc">
                        도모하고 배움과 나눔이 공존하는 평생배움터입니다.
                    </div>
                </div>
                <h2 class="fs_30 mt_85 mb_25">현황</h2>
                <!--2020.11.25 : s-->
                <div class="img_slide_gallery fs_18 fs_md_26">
                    <div class="sg_img_wrap">
                        <div class="sg_img">
                            <div class="sg">
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_01.jpg" alt="전경">
                                    <div>
                                         전경
                                    </div>
                                </div>
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_02.jpg" alt="로비">
                                    <div>
                                         로비
                                    </div>
                                </div>
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_03.jpg" alt="학습동아리실1">
                                    <div>
                                        학습동아리실_1
                                    </div>
                                </div>
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_04.jpg" alt=" 학습동아리실2">
                                    <div>
                                        학습동아리실_2
                                    </div>
                                </div>
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_05.jpg" alt="강의실1">
                                    <div>
                                        강의실1
                                    </div>
                                </div>
                                <div>
                                    <img src="/ssem/resources/img/sub/foreverEdu/fc_img_06.jpg" alt="강의실2">
                                    <div>
                                        강의실2
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="sg_top_box">
                                <div class="fs_20 fs_md_26">
                                    <p class="sg_top_text">
                                        <span class="_tit">위&nbsp; &nbsp;치</span>
                                        <span>송파구 마천로 35길 12(마천동)</span>
                                    </p>
                                    <p class="sg_top_text">
                                        <span class="_tit">시설규모</span>
                                        <span> 583.292㎡(지하1,지상3)</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="sg_img_nav">
                        <div class="sg">
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_01.jpg" alt="전경"></div>
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_02.jpg" alt="로비"></div>
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_03.jpg" alt="학습동아리1"></div>
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_04.jpg" alt="학습동아리2"></div>
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_05.jpg" alt="강의실1"></div>
                            <div><img src="/ssem/resources/img/sub/foreverEdu/fc_img_06.jpg" alt="강의실2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
