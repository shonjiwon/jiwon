<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오전 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '시설안내 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        yfsSlider(0);
        dropMenu2();
    });

    function dropMenu2() {
        $('.tab_box2 button').each(function(ind, item){
            var html = $(item).html();
            $(item).html('<span class="tab_middle">' + html + '</span>');
        });

        $(document).off('click','.tab_box2 .tab_m').on('click', '.tab_box2 .tab_m', function(event){
            event.preventDefault();
            var $tab_box = $(this).parents('.tab_box2');
            var $deapth = $tab_box.find('.tab');
            $tab_box.toggleClass('on')
                .find('ul')
                .stop()
                .slideToggle(200);
        });

        $(document).on('click', function (event) {
            var $tab_box = $('.tab_box2.on');
            var $deapth = $tab_box.find('.tab');
            if (!$tab_box.is(event.target) && $tab_box.has(event.target).length === 0) {
                $tab_box.removeClass('on')
                    .find('ul')
                    .stop()
                    .slideUp(200);
            }
        });

        $(document).off('click','.tab_box2 button').on('click', '.tab_box2  button', function(event){
            var w = $(this).outerWidth();
            var $ti = $(this).parents('.tab_item');
            var ind = $ti.index();
            $('.tab .tab_item').removeClass('on').attr('title', '비 활성화');
            $ti.addClass('on').attr('title', '활성화');

            yfsSlider(ind) //슬라이드 변경
        });
        $(document).off('click','.tab_box2 .tab_item ').on('click', '.tab_box2._mo .tab_item', function(event){
            var $tab = $(this).parents('.tab');

            var $tab_box = $(this).parents('.tab_box2');
            $tab_box.toggleClass('on')
            $tab.stop()
                .slideUp(200);
            var text = '<span class="tab_middle">'+$(this).text()+'<i class="icon_arrow_down_w ml_60">다운</i></span>';
            $tab_box.find('.tab_m').html(text);
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
                $('.tab_box2 .tab').removeAttr('style');
                $('.tab_box2').removeClass('_mo');
            }else{
                $('.tab_box2').addClass('_mo');
            }
        }
    }

    function yfsSlider(ind){
        var $yfs, $yfsn;

        $('.youth_fac_nav_slider').removeClass('none_slide');
        $('.youth_fac_nav_slider').hide();
        
        $yfsn = $('.youth_fac_nav_slider').eq(ind);
        if($yfsn.find('.yfns').hasClass('slick-slider')){
            $yfsn.find('.yfns').slick('unslick');
        }
        $yfsn.show();
        if($('.youth_fac_slider .yfns').hasClass('slick-slider')){
            $('.youth_fac_slider .yfns').slick('unslick');
            $('.youth_fac_slider ._control').remove();
        }
        $yfsn.find('.yfns_item').removeClass('act');
        $yfsn.find('.yfns_item').eq(0).addClass('act');
        $('.youth_fac_slider .yfns').html($yfsn.find('.yfns').html());
        
        $('.youth_fac_nav_slider .yfns_item').removeClass('act');
        $('.youth_fac_slider .yfns').after('<div class="_control"></div>');
        var slickOptions = {
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows:true,
            fade: true,
            focusOnSelect: true,
            nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next3.png' alt='다음'> </ button>",
            prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev3.png' alt='이전'> </ button>",
            appendArrows:	$('.youth_fac_slider ._control'),
            responsive: [{
                breakpoint: 1024,
                settings: {
                    arrows: false,
                }
            }]
        };

        var slickOptionsNav = {
            slidesToShow: 5,
            slidesToScroll: 1,
            asNavFor: '.youth_fac_slider .yfns',
            dots: false,
            arrows: false,
            focusOnSelect: true,
            variableWidth: false,
        };

        if($('.youth_fac_slider .yfns > div').length == 1 ){

        }else if($('.youth_fac_slider .yfns > div').length > 1  && $('.youth_fac_slider .yfns > div').length <= 5){
            console.log(111);
            $yfs = $('.youth_fac_slider .yfns').slick(slickOptions);
            $yfs.on('beforeChange', function(event, slick, currentSlide, nextSlide){
                $('.none_slide .yfns > div').removeClass('act').eq(nextSlide).addClass('act');
            });
        }else{
            slickOptions.asNavFor =  '.youth_fac_nav_slider:eq('+ ind +') .yfns';
            $yfs = $('.youth_fac_slider .yfns').slick(slickOptions);
        }


        /*nav*/
        if( $('.youth_fac_nav_slider').eq(ind).find('.yfns > div').length <= 1 ){
            
        }else if($('.youth_fac_nav_slider').eq(ind).find('.yfns > div').length > 1 && $('.youth_fac_nav_slider').eq(ind).find('.yfns > div').length <= 5){
            var $noSlide = $('.youth_fac_nav_slider').eq(ind).addClass('none_slide');
                $noSlide.find('.yfns > div > div').attr('tabindex','0');
                $noSlide.find('.yfns > div:eq(0)').addClass('act');
                 
                $noSlide.off('click', '.yfns > div').on('click', '.yfns > div',function(){
                    $(this).addClass('act')
                    $(this).siblings().removeClass('act');
                    $yfs.slick('slickGoTo', $(this).index());
                });
                $noSlide.off('click', '.yfns > div > div').on('focus', '.yfns > div > div', function(){
                    var $div = $(this);
                    var num = $('.none_slide .yfns > .yfns_item').index( $(this).closest('.yfns_item'));
                    $yfs.slick('slickGoTo', num);
                });

        }else{
            $yfsn = $('.youth_fac_nav_slider').eq(ind).find('.yfns').slick(slickOptionsNav); 
        }
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_4"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    시설안내
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="/ssem/songpacenter/place/intro.do" class="deapth_tit" title="선택">시설안내</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
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
    <div class="sub_con st_1"><!-- sub_con -->
        <section class="text_con pb_100 mb_15">
            <h1 class="tit2 mt_100 mb_50">시설안내</h1>
            <div class="wrap">
                <div class="tab_box2 fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box2 -->
                    <h4 class="text_hide">탭</h4>
                    <button type="button" class="tab_m act">3층<i class="icon_arrow_down_w ml_60">다운</i></button>
                    <ul class="tab">
                        <li  class="tab_item on"><button type="button">3층</button></li>
                        <li  class="tab_item"><button type="button">2층</button></li>
                        <li  class="tab_item"><button type="button">1층</button></li>
                        <li  class="tab_item"><button type="button">지하1층</button></li>
                        <li  class="tab_item"><button type="button">지하2층</button></li>
                    </ul>
                </div><!-- tab_box //-->
                <div class="youth_fac_slider  mt_md_50">
                    <div class="yfns">
                    </div>
                </div>
                <!--3층-->
                <div class="youth_fac_nav_slider mt_35">
                    <div class="yfns">
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample1_1.jpg" alt="청소년상담복지센터학교폭력예방센터">
                                <p class="fs_22 fs_md_30">3층 :  청소년상담복지센터 &middot; 학교폭력예방센터</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample1_2.jpg" alt="음악실">
                                <p class="fs_22 fs_md_30">3층 :  음악실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample1_3.jpg" alt="성문화센터">
                                <p class="fs_22 fs_md_30">3층 : 성문화센터</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample1_4.jpg" alt="대강당">
                                <p class="fs_22 fs_md_30">3층 : 대강당</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!--3층 : e-->
                <!--2층-->
                <div class="youth_fac_nav_slider mt_35">
                    <div class="yfns">
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample2_1.jpg" alt="강의실">
                                <p class="fs_22 fs_md_30">2층 : 강의실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample2_2.jpg" alt="대안학교">
                                <p class="fs_22 fs_md_30">2층 : 대안학교</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample2_3.jpg" alt="피아노실">
                                <p class="fs_22 fs_md_30">2층 : 피아노실</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!--2층 : e-->
                <!--1층-->
                <div class="youth_fac_nav_slider mt_35">
                    <div class="yfns">
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_1.jpg" alt="한들카페">
                                <p class="fs_22 fs_md_30">1층 : 한들카페</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_2.jpg" alt=" 청소년자치실">
                                <p class="fs_22 fs_md_30">1층 : 청소년자치실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_3.jpg" alt="제3관-핸드메이킹실">
                                <p class="fs_22 fs_md_30">1층 : 제3관-핸드메이킹실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_4.jpg" alt="제3관-디지털제작실">
                                <p class="fs_22 fs_md_30">1층 : 제3관-디지털제작실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_5.jpg" alt="키움센터">
                                <p class="fs_22 fs_md_30">1층 : 키움센터</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_7.jpg" alt=" 북스테이션">
                                <p class="fs_22 fs_md_30">1층 : 북스테이션</p>
                            </div>
                        </div>
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_6.jpg" alt="필라테스">
                                <p class="fs_22 fs_md_30">1층 : 필라테스</p>
                            </div>
                        </div>
                        
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_8.jpg" alt="유아체능단">
                                <p class="fs_22 fs_md_30">1층 : 유아체능단</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_9.jpg" alt="청소년활동실">
                                <p class="fs_22 fs_md_30">1층 : 청소년활동실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample3_10.jpg" alt="창의디자인실">
                                <p class="fs_22 fs_md_30">1층 : 창의디자인실</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!--1층 : e-->
                <!--지하 1층-->
                <div class="youth_fac_nav_slider mt_35">
                    <div class="yfns">
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample4_1.jpg" alt="소체육실">
                                <p class="fs_22 fs_md_30">지하 1층 : 소체육실</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample4_2.jpg" alt="주차장">
                                <p class="fs_22 fs_md_30">지하 1층 : 주차장</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!--지하 1층 : e-->
                <!--지하 2층-->
                <div class="youth_fac_nav_slider mt_35">
                    <div class="yfns">
                        <div class="yfns_item act">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample5_1.jpg" alt="체육관">
                                <p class="fs_22 fs_md_30">지하 2층 : 체육관</p>
                            </div>
                        </div>
                        <div class="yfns_item">
                            <div>
                                <img src="/ssem/resources/img/sub/youth/sf_sample5_2.jpg" alt="피트니스 클럽">
                                <p class="fs_22 fs_md_30">지하 2층 : 피트니스 클럽</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--지하 2층 : e-->
            </div>
        </section>
    </div>
</div>
