<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '시설안내 > 잠실청소년센터 > 송파쌤');

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
    <div class="sub_visual jamsil_st_4"><!-- sub_visual -->
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
                            <li><a href="/ssem/jamsilcenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/jamsilcenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/culture.do">주요사업</a></li>
                            <li><a href="/ssem/jamsilcenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/jamsilcenter/news/notice_list.do">고객지원</a></li>
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
									옥상
								</div>
								<div class="fs_20 fs_md_26 pr_60">
									<p class="plr_20">
										<span>For E Garden</span>
										<span> 옥상공연장 및 캠핑장</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample1_1.jpg" alt="For E Garden 1">
										<div>
											휴식공간 : 옥상활용 캠핑 활동 및 가족 공간 1
										</div>
									</div>
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample1_2.jpg" alt="For E Garden 1">
										<div>
											휴식공간 : 옥상활용 캠핑 활동 및 가족 공간 2
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample1_1.jpg" alt="For E Garden 1"></div>
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample1_2.jpg" alt="For E Garden 2"></div>
								</div>
							</div>
						</div>
					</li>
					<li class="sfl_item">
						<a href="javascript:void(0)" title="드롭 비활성">
							<section class="sfl_top_box">
								<div class="wid_200 fs_22 fs_md_26 fw_600">
									8F
								</div>
								<div class="fs_20 fs_md_26 pr_60">
									<p class="plr_20">
										<span>잠실본동송파 키움센터</span>
										<span>방과 후 초등돌봄 서비스 제공</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample2.jpg" alt="잠실본동송파 키움센터">
										<div>
											돌봄공간 : 돌봄 공백 해소 안심 공간
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample2.jpg" alt="잠실본동송파 키움센터"></div>
								</div>
							</div>
						</div>
					</li>

					<li class="sfl_item">
						<a href="javascript:void(0)" title="드롭 비활성">
							<section class="sfl_top_box">
								<div class="wid_200 fs_22 fs_md_26 fw_600">
									7F
								</div>
								<div class="fs_20 fs_md_26 pr_60">
									<p class="plr_20">
										<span>올라가방 실내암벽장, For E Gym </span>
										<span>청소년 체육 및 문화활동</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample3_1.jpg" alt="올라가방 실내암벽장">
										<div>
											활동공간 : 운동시설
										</div>
									</div>
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample3_2.jpg" alt="For E Gym">
										<div>
											활동공간 : 다목적 강당, 운동시설
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample3_1.jpg" alt="올라가방 실내암벽장"></div>
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample3_2.jpg" alt="For E Gym"></div>
								</div>
							</div>
						</div>
					</li>

					<li class="sfl_item">
						<a href="javascript:void(0)" title="드롭 비활성">
							<section class="sfl_top_box">
								<div class="wid_200 fs_22 fs_md_26 fw_600">
									6F
								</div>
								<div class="fs_20 fs_md_26 pr_60">
									<p class="plr_20">
										<span>For E Hall</span>
										<span>다목적강당, 무대</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample4.jpg" alt="For E Hall">
										<div>
											활동공간 : 다목적 강당
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample4.jpg" alt="For E Hall"></div>
								</div>
							</div>
						</div>
					</li>
					<li class="sfl_item">
						<a href="javascript:void(0)" title="드롭 비활성">
							<section class="sfl_top_box">
								<div class="wid_200 fs_22 fs_md_26 fw_600">
									5F
								</div>
								<div class="fs_20 fs_md_26 pr_60">
									<p class="plr_20">
										<span>상담실 '봄'</span>
										<span>청소년, 아동, 가족 대상 전문상담</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample5.jpg" alt="상담실 봄">
										<div>
											활동공간 : 전문상담실
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample5.jpg" alt="상담실 봄"></div>
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
										<span>송파구자기주도학습관, 강의실(도전해방, 생각해방,상상해방)
											</span>
										<span>자기주도학습실, 프로그램실</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample6.jpg" alt="송파구자기주도학습관">
										<div>
											활동공간: 교육프로그램에 적합한 청소년 배움공간
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample6.jpg" alt="송파구자기주도학습관"></div>
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
										<span>사무실(들어와방,찾아와방), 청소년운영위원회회의실</span>
										<span>사무실(2), 회의실, 상담실</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample7.jpg" alt="회의실">
										<div>
											지원공간: 청소년운영위원회 회의실, 사무실 등 센터 운영 공간
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample7.jpg" alt="회의실"></div>
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
										<span>VR 해방</span>
										<span>어울림공간, VR실</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample8.jpg" alt="VR 해방">
										<div>
											어울림공간 : 청소년 선호 컨텐츠를 활용한 청소년 만남 공간
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample8.jpg" alt="VR 해방"></div>
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
										<span>카페사이 &신한카드 아름인 도서관</span>
										<span>유스카페, 로비, 주차장</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample9.jpg" alt="유스카페">
										<div>
											문화공간 : 청소년과 지역주민의커뮤 니티 공간(인문학강좌, 북클럽활동)
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample9.jpg" alt="유스카페"></div>
								</div>
							</div>
						</div>
					</li>
					<li class="sfl_item">
						<a href="javascript:void(0)" title="드롭 비활성">
							<section class="sfl_top_box">
								<div class="wid_200 fs_22 fs_md_26 fw_600">
									지하1
								</div>
								<div class="fs_20 fs_md_26">
									<p>
										<span>작은놀이터, 밴드연습실 (연주해방), 개인연습실 (맘껏해방, 힘껏해방), 댄스연습실 (흔들어방, 땀흘려방)</span>
										<span>밴드연습실(1), 개인연습실(2), 댄스연습실(2)</span>
									</p>
								</div>
							</section>
						</a>
						<div class="img_box">
							<div class="sfl_img_list">
								<div class="sfl">
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample10_1.jpg" alt="밴드연습실">
										<div>
											문화공간 : 청소년과 지역주민의 커뮤 니티 공간 (인문학강좌, 북클럽활동)
										</div>
									</div>
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample10_2.jpg" alt="개인연습실">
										<div>
											문화공간 : 청소년과 지역주민의 커뮤 니티 공간 (인문학강좌, 북클럽활동)
										</div>
									</div>
									<div>
										<img src="/ssem/resources/img/sub/jamsil/jf_sample10_3.jpg" alt="댄스연습실">
										<div>
											문화공간 : 청소년과 지역주민의 커뮤 니티 공간 (인문학강좌, 북클럽활동)
										</div>
									</div>
								</div>
							</div>
							<div class="sfl_img_nav">
								<div class="sfl">
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample10_1.jpg" alt="밴드연습실"></div>
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample10_2.jpg" alt="개인연습실"></div>
									<div><img src="/ssem/resources/img/sub/jamsil/jf_sample10_3.jpg" alt="댄스연습실"></div>
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
