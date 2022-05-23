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
        $(document).prop('title', '시설안내 > 미래교육센터 오금Hub > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js

        var timer;
        var delta = 100;
        $(window).on('resize', function(){
            clearTimeout( timer );
            timer = setTimeout( resizeDone, delta );

        });

        $(document).on('click', '.sfl_item a', function(e){
            e.preventDefault();

            var $lis  = $(this).parent('li').siblings();
            var $li   = $(this).parent('li');
            var ind   = $li.index();

            $('.slide_fac_list_2 li').each(function(ind, item){
                //2020.11.27 : s
                $(item).find('.img_box ._control').remove();
                $(item).find('.img_box  .sfl_img_nav').removeClass('none_slide')
                $(item).find('.img_box  .sfl_img_nav .on').removeClass('on');
                //2020.11.27 : e

                //이벤트 제거
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

    function resizeDone(){
        var w = window.innerWidth;
        $('.sfl_item.on .img_box').removeAttr('style');
        $('.sfl_item.on').removeClass('on');
    }

    function slider(ind){
        //2020.11.27 : s
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
        //2020.11.27 : e
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual songpa_st_4"><!-- sub_visual -->
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
                            <li><a href="/ssem/futurecenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/futurecenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/futurecenter/biz/major.do">주요사업</a></li>
                            <li><a href="/ssem/futurecenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/futurecenter/news/notice_list.do">고객지원</a></li>
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
                                        3F
                                    </div>
                                    <div class="fs_20 fs_md_26 pr_60">
                                        <p class="plr_20">
                                            <span> 배움공간(301), TED스퀘어, 통합사무실</span>
                                            <span>356.3㎡</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <!-- 2020.11.23  : s-->
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_3_1.jpg" alt="배움공간301">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_3_2.jpg" alt="TED스퀘어">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 2020.11.23  : e-->
                                </div>
                                <div class="sfl_img_nav">
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_3_1.jpg" alt="샘플이미지"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_3_2.jpg" alt="샘플이미지"></div>
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
                                            <span>배움공간(201), 창작공간[폼], 공유의가치[오피스], 웹 스튜디오, 포토스튜디오, 크리에이터 스튜디오</span>
                                            <span>758.9㎡</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <!-- 2020.11.23  : s-->
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_1.jpg" alt="배움공간(201)">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_2.jpg" alt="창작공간[폼]">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_3.jpg" alt="공유의가치[오피스]">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_4.jpg" alt="웹 스튜디오">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_5.jpg" alt="포토스튜디오">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_2_6.jpg" alt="크리에이터 스튜디오">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 2020.11.23  : e-->
                                </div>
                                <div class="sfl_img_nav">
                                    <!-- 2020.11.23  : s-->
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_1.jpg" alt="배움공간(201)"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_2.jpg" alt="창작공간[폼]"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_3.jpg" alt="공유의가치[오피스]"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_4.jpg" alt="웹 스튜디오"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_5.jpg" alt="포토스튜디오"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_2_6.jpg" alt="크리에이터 스튜디오"></div>
                                    </div>
                                    <!-- 2020.11.23  : e-->
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
                                            <span>배움공간(101-102), FAB갤러리, FAB라운지</span>
                                            <span>356.3㎡</span>
                                        </p>
                                    </div>
                                </section>
                            </a>
                            <div class="img_box">
                                <div class="sfl_img_list">
                                    <!-- 2020.11.23  : s-->
                                    <div class="sfl">
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_1_1.jpg" alt="배움공간101">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_1_2.jpg" alt="배움공간102">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_1_3.jpg" alt="FAB갤러리">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                        <div>
                                            <img src="/ssem/resources/img/sub/songpa/facilities_1_4.jpg" alt="FAB라운지">
                                            <div>
                                                ※ 창작공간 ‘폼 ’은 Fab Lab의 애칭임
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 2020.11.23  : e-->
                                </div>
                                <div class="sfl_img_nav">
                                    <!-- 2020.11.23  : s-->
                                    <div class="sfl">
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_1_1.jpg" alt="배움공간101"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_1_2.jpg" alt="배움공간102"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_1_3.jpg" alt="FAB갤러리"></div>
                                        <div><img src="/ssem/resources/img/sub/songpa/facilities_1_4.jpg" alt="FAB라운지"></div>
                                    </div>
                                    <!-- 2020.11.23  : s-->
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
