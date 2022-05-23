<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '소개 및 이용안내 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        svsw_img_box();

        mapBoxMoInit();
        listLineSlider();

        resizeDone();

        var timer;
        var delta = 100;
        $(window).on('resize', function(){
            clearTimeout( timer );
            timer = setTimeout( resizeDone, delta );

        });
    });

    function svsw_img_box(){
        if( !$('.svsw_img_box').hasClass('slick-slider')) {
            var html = '';

            $('.sub_visual_sd_wrap').append('<div class="_control"></div>')

            var $ntSlide = $('.svsw_img_box').slick({
                infinite: true,
                arrows:true,
                dots: false,
                slidesToShow: 1,
                autoplay: true,
                autoplaySpeed: 5000,
                slidesToScroll: 1,
                adaptiveHeight:true,
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next5.png' alt='다음'> </ button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev5.png' alt='이전'> </ button>",
                appendArrows:	$('.sub_visual_sd_wrap > ._control'),
                fade:true,
            });
        }
    }

    function resizeDone(){
        listLineSlider();
    }

    function mapBoxMoInit(){
        var $mapBox =$('#mapBox').clone().attr('id','mapBoxMo');
        $('.list_line_wrap').prepend($mapBox);
        $('#mapBoxMo').wrap('<div class="list_line_box screen_hide screen_md_show"> </div>');
        $('#mapBox').addClass('screen_md_hide');
    }



    function listLineSlider(){
        var wid = window.outerWidth;
        if(wid > 1024){
            if($('.list_line_slider').hasClass('slick-slider')){
                $('.list_line_slider').slick("unslick");
                $('.list_line_slider + ._control').remove();
            }
        }else{
            if( !$('.list_line_slider').hasClass('slick-slider')  ){
                $('.list_line_slider').after('<div class="_control t_center mt_30"></div>');

                var $pb = $('.list_line_slider').slick({
                    arrows:false,
                    dots:true,
                    fade:true,
                    infinite: true,
                    speed: 300,
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    appendDots : $('.list_line_slider + ._control'),
                });
            }
        }
    }

</script>
<div class="contents" id="contents">
    <div class="sub_visual st_2"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    악기도서관
                </h2>

                <p class="tit_sub fw_200">
                    <strong>“1인 1악기”</strong>
                    청소년과 주민들이 쉽게 악기를 접하고 <br class="screen_hide screen_sm_show"> 체험할 수 있도록 악기를 테마로 한 교육문화복합<br class="screen_hide screen_sm_show">  플랫폼을 구축하여<br class="screen_sm_hide">
                    구민들이 부담 없이 <br class="screen_hide screen_sm_show"> 다양한 예술적 소양과 적성을 계발할 수 있도록 <br class="screen_hide screen_sm_show"> 지원하는 플랫폼입니다.
                </p>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">온라인 캠퍼스</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/future_main.do">미래교육센터</a></li>
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로 체험지원센터(꿈마루)</a></li>
                            <li><a href="/ssem/youth/campus/songpa_vision.do">송파혁신교육지구</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">소개 및 이용안내</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">악기도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_intro.do" title="선택">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_2 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap t_center tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">악기도서관이란?</h5>
                    <p class="fs_22 fs_md_24 fs_md_24 mt_40">
                        ‘1인 1악기’ 문화예술융복합 교육 <br>
                        청소년과 주민들이 쉽게 악기를 접하고 체험할 수 있도록 <br class="screen_hide screen_md_show">악기를 테마로 한 교육문화복합 플랫폼을 구축하여 <br>
                        구민들이 부담 없이 다양한 예술적 소양과 적성을 계발할 수 있도록 <br class="screen_hide screen_md_show">지원하는 플랫폼입니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">

                <h1 class="c_tit_1 mt_90">악기도서관 이용안내</h1>

                <h2 class="c_tit_2 mt_25 mb_20">악기 대여 안내</h2>

                <div class="box_item_blue mb_20">
                    <img src="/ssem/resources/img/sub/youth/icon_notice.png" class="img_va" alt="알림">
                    &nbsp;&nbsp;문의전화 : 02-2147-2544 / 2545
                </div>

                <h3 class="c_tit_3 mt_15">대여 및 반납 절차</h3>

                <div class="img_step_box_st_2 t_center fs_22 fs_lg_16 fs_md_26 fs_xs_24">
                    <ul class="row">
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <div class="setp_grap_wrap outline">
                                    <div class="setp_grap">
                                        <strong>STEP 1</strong>
                                        <span>대여 신청</span>
                                    </div>
                                </div>
                                <div class="step_text_box">
                                    <p>대여를 희망하는 날의 <b>이틀전</b>까지 악기대여목록 리스트에서 <br>희망 악기 조회 후 사전 대여 신청 <br>(악기 종류, 대여 일정 선택)</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <div class="setp_grap_wrap">
                                    <div class="setp_grap">
                                        <strong>STEP 2</strong>
                                        <span>본인 인증</span>
                                    </div>
                                </div>
                                <div class="step_text_box">
                                    <p>대여 신청 승인 완료 확인 후  <br>이용대상 자격 및 본인 증명을 위한 <br>서류 지참해 방문</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num screen_md_hide">3</span>
                                <div class="setp_grap_wrap">
                                    <div class="setp_grap">
                                        <strong>STEP 3</strong>
                                        <span>악기 수령</span>
                                    </div>
                                </div>
                                <div class="step_text_box">
                                    <p>대여료 방문 결제 후  <br>악기 수령</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="setp_grap_wrap outline">
                                    <div class="setp_grap">
                                        <strong>STEP 4</strong>
                                        <span>악기 반납</span>
                                    </div>
                                </div>
                                <div class="step_text_box">
                                    <p>지정된 반납일내  <br>방문하여 악기 반납</p>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="sub_info_visual_2 mt_100 mt_md_80"> <!---sub_info_visual_2-->
                <div class="wrap">
                    <div class="row">
                        <%--<div class="col_6 col_md_12 line_right">
                            <h3 class="c_tit_3 mt_15 mt_md_40">이용 대상</h3><div class="mtb_30 t_md_center">
                            <div class="grap_wrap mr_30">
                                <div class="grap">
                                    <img src="/ssem/resources/img/sub/img_info_2_img_3.png" alt="1인">
                                    <p><b class="fs_26">1</b>인</p>
                                </div>
                            </div>
                            <div class="grap_wrap mr_30">
                                <div class="grap">
                                    <img src="/ssem/resources/img/sub/img_info_2_img_4.png" alt="1회">
                                    <p><b class="fs_26">1</b>회</p>
                                </div>
                            </div>
                            <div class="grap_wrap">
                                <div class="grap">
                                    <img src="/ssem/resources/img/sub/img_info_2_img_5.png" alt="1악기">
                                    <p><b class="fs_26">1</b>악기</p>
                                </div>
                            </div>
                            <ul class="list_inb_box t_center mtb_30 fs_20 fc_w">
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_7.png" alt="송파구에 주민등록을 둔 사람">
                                            <p class="pt_20">악기대여</p>
                                        </div>
                                    </div>
                                    <p>송파구에 주민등록을 <br>둔 사람</p>
                                </li>
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_8.png" alt="송파구 소재 학교의 재학생 및 직장의 재직자">
                                            <p>시설대관</p>
                                        </div>
                                    </div>
                                    <p>송파구 소재 학교의 재학생<br> 및 직장의 재직자</p>
                                </li>
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_9.png" alt="송파구 소재 학교의 재학생 및 직장의 재직자">
                                            <p>증빙자료</p>
                                        </div>
                                    </div>
                                    <p>송파구 소재 학교의 재학생<br> 및 직장의 재직자</p>
                                </li>
                            </ul>
                        </div>--%>
                        <div class="col_6 col_md_12 line_right">
                            <h3 class="c_tit_3 mt_15 mt_md_40"><span class="dp_inb mr_20">이용대상</span></h3>
                            <ul class="list_inb_box t_center mtb_30 fs_20 fc_w">
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_7.png" alt="송파구에 주민등록을 둔 사람">
                                            <p class="pt_20">악기대여</p>
                                        </div>
                                    </div>
                                    <p>만 19세 미만<br> 송파구민 또는 <br>관내 학교 재학생</p>
                                </li>
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_8.png" alt="송파구 소재 학교의 재학생 및 직장의 재직자">
                                            <p>시설대관</p>
                                        </div>
                                    </div>
                                    <p>송파구민 또는 <br>관내 학교 <br>재학생</p>
                                </li>
                                <li>
                                    <div class="grap_wrap mb_10">
                                        <div class="grap">
                                            <img src="/ssem/resources/img/sub/img_info_2_img_9.png" alt="송파구 소재 학교의 재학생 및 직장의 재직자">
                                            <p>증빙자료</p>
                                        </div>
                                    </div>
                                    <p>신분증(주민등록증,<br> 학생증, 청소년증),<br>주민등록 초본 등</p>
                                </li>
                            </ul>
                        </div>
                        <div class="col_5 offset_1 col_lg_6 offset_lg_0 col_md_12">
                            <h3 class="c_tit_3 mt_15 mt_md_40"><span class="dp_inb mr_20">대여수량</span> <span class="dp_inb fs_20 fs_md_26 fw_400">1인, 1회, 1악기 대여가능</span></h3>
                            <div class="mtb_30 t_md_center">
                                <div class="grap_wrap mr_30">
                                    <div class="grap">
                                        <img src="/ssem/resources/img/sub/img_info_2_img_3.png" alt="1인">
                                        <p><b class="fs_26">1</b>인</p>
                                    </div>
                                </div>
                                <div class="grap_wrap mr_30">
                                    <div class="grap">
                                        <img src="/ssem/resources/img/sub/img_info_2_img_4.png" alt="1회">
                                        <p><b class="fs_26">1</b>회</p>
                                    </div>
                                </div>
                                <div class="grap_wrap">
                                    <div class="grap">
                                        <img src="/ssem/resources/img/sub/img_info_2_img_5.png" alt="1악기">
                                        <p><b class="fs_26">1</b>악기</p>
                                    </div>
                                </div>
                            </div>
                            <h3 class="c_tit_3 mt_25 mb_15 "><span class="dp_inb mr_20">대여기간</span> <span class="dp_inb fs_20 fs_md_26 fw_400">1개월 단위로 대여 (3개월까지 대여가능)</span></h3>
                        </div>

                        <div class="col_12 mt_50">
                            <div class="info_text_box">
                                <h2 class="c_tit_2">악기 대여 안내</h2>
                                <ul class="mt_15 fs_20 fs_md_26 fw_200 ul_list_dash">
                                    <li><span class="uld_tit">연 &nbsp; 체 &nbsp; 료 :</span> 대여기간 만료일까지 반납하지 않은 경우 연체료 부과</li>
                                    <li><span class="uld_tit">악기 변상 :</span> 대여기간 중 악기 분실, 파손, 고장 등의 문제 발생 시 즉시 악기도서관에 통보하고 담당자의 지시 또는 조치에 따라 변상해야 함</li>
                                    <li><span class="uld_tit">대여 제한 :</span> 대여자의 상습적 연체 및 심각한 악기 파손이 우려되는 경우 악기대여를 제한할 수 있음</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!---sub_info_visual_2 //-->

            <div class="wrap">
                <h2 class="c_tit_2 mb_20 mt_100">시설안내</h2>
                <div class="list_line_wrap">
                    <!---->
                    <div class="list_line_slider">
                        <div class="row list_line_box">
                            <div class="col_6 col_md_12">
                                <div class="item_box">
                                    <h3 class="fs_24 fs_md_26 fw_500 mb_20">악기 대여관 & 기증 센터</h3>
                                    <ul class="ul_list_dash fs_20 fs_md_22 fw_200 tc_sub">
                                        <li><span class="uld_tit">이용대상 :</span>만 19세 미만 송파구민 또는 관내 학교 재학생</li>
                                        <li><span class="uld_tit">운영시간 :</span>(평일, 토요일) 10:00 ~ 19:00</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col_6 col_md_12">
                                <div class="item_box">
                                    <h3 class="fs_24 fs_md_26 fw_500 mb_20">소공연장</h3>
                                    <ul class="ul_list_dash fs_20 fs_md_22 fw_200 tc_sub">
                                        <li><span class="uld_tit">이용방법 :</span>홈페이지에서 별도 공지</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="row list_line_box">
                            <div class="col_6 col_md_12">
                                <div class="item_box">
                                    <h3 class="fs_24 fs_md_26 fw_500 mb_20">연습실(스튜디오3, 4)</h3>
                                    <ul class="ul_list_dash fs_20 fs_md_22 fw_200 tc_sub">
                                        <li><span class="uld_tit">이용대상 :</span>송파구민, 관내 학교 재학생 또는 교육포털 회원</li>
                                        <li><span class="uld_tit">이용내용 :</span>단체연습(개인악기연습 불가), 음악강좌진행</li>
                                        <li><span class="uld_tit">운영시간 :</span>(평일, 토요일) 10:00 ~ 19:00</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col_6 col_md_12">
                                <div class="item_box">
                                    <h3 class="fs_24 fs_md_26 fw_500 mb_20">1인 음악창작실(스튜디오1, 2)</h3>
                                    <ul class="ul_list_dash fs_20 fs_md_22 fw_200 tc_sub">
                                        <li><span class="uld_tit">이용대상 :</span>송파구민, 관내 학교 재학생 또는 교육포털 회원</li>
                                        <li><span class="uld_tit">이용내용 :</span>미디(디지털 기반), 음원제작 연습 및 실습</li>
                                        <li><span class="uld_tit">운영시간 :</span>(평일, 토요일) 10:00 ~ 19:00</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row list_line_box">
                            <div class="col_12 col_md_12" id="mapBox">
                                <div class="item_box2">
                                    <div class="text_box">
                                        <img src="/ssem/resources/img/sub/img_info_2_img_6.png" alt="마커" style="max-width:2.2rem">
                                        <p class="fw_200 fs_24 dp_inb ml_10"><span class="fw_500">오시는 길 : </span>송파구청 사거리앞 지하보도</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</div>
