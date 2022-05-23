<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '소개 및 이용안내 > 진학학습지원센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        svsw_img_box();
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
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=sngy"></script>
<div class="contents" id="contents">
    <div class="sub_visual st_4"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    진학학습지원센터
                </h2>
                <p class="tit_sub">
                    <strong>“공부를 잘 하고 싶나요? 입시제도가 복잡하고 어려운가요?”</strong>
                    <span class="dp_b fs_18 lh_18">
							나에게 맞는 공부법, 나에게 맞는 진학을 제공해 드립니다.<br />
							입시와 학습문제로 고민하는 학생과 학부모님을 위해서 송파쌤이 도와주겠습니다.
                    </span>
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
                        <a href="#" class="deapth_tit" title="선택">진학학습지원센터</a>
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
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                            <li><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/self_counsel_insert.do">온라인 상담예약</a></li>
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
    <div class="sub_con st_4"><!-- sub_con -->
        <h3 class="mt_100 mb_60 tit font_sc">진학학습지원센터</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/campus/self_intro.do" title="선택">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_counsel_insert.do">온라인 상담예약</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_4 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap t_center tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">진학학습지원센터는</h5>
                    <p class="fs_22 fs_md_24 mt_40">꿈을 키우는 자기주도형 창의 미래 인재를 키웁니다.
                        <span class="screen_hide screen_md_show">
                                잘 하고 싶나요? 공부가 어렵나요?  스스로 공부하는 힘을<br>
                                길러보세요. 송파구 진학학습지원센터가 도와주겠습니다.
                        </span>
                    </p>
                    <ul class="row fs_20 pt_20  pt_md_40 mt_60 mb_40 fs_20 fs_md_24 fw_200">
                        <li class="col_4 col_md_6">
                            <div class="img_box dash_line">
                                <div class="dash_brd md_no_line">
                                    <img src="/ssem/resources/img/sub/sub_info_visual_4_img_01.png" alt="공부">
                                </div>
                            </div>
                            <div class="text_box mt_15">
                                <p>
                                    공부를 잘 하고 싶나요?<br>
                                    복잡한 입시제도가 어려운가요?
                                </p>
                            </div>
                        </li>
                        <li class="col_4 col_md_6">
                            <div class="img_box dash_line"><div class="dash_brd md_no_line"><img src="/ssem/resources/img/sub/sub_info_visual_4_img_02.png" alt="스스로 공부하는 힘"></div></div>
                            <div class="text_box mt_15">
                                <p>
                                    나에게 맞는 공부법과<br>
                                    진학전략을 수립해 보세요.
                                </p>
                            </div>
                        </li>
                        <li class="col_4 col_md_6 offset_md_3">
                            <div class="img_box"><div class="dash_brd no_line"><img src="/ssem/resources/img/sub/sub_info_visual_4_img_03.png" alt="진학학습지원"></div></div>
                            <div class="text_box mt_15">
                                <p>
                                    송파쌤 진학학습지원센터가<br> 도와주겠습니다.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <div class="wrap">
            <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
                <h1 class="c_tit_1 mt_90">진학학습지원센터 이용안내</h1>
                <h2 class="c_tit_2 mt_25">이용대상</h2>
                <div class="img_row_list st_b fs_20 mb_90">
                    <div class="table">
                        <div class="col_6">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/led_learning_img_01.jpg" alt="송파구 초, 중, 고등학생 및 학부모">
                                <p class="fs_18 fs_md_24 t_md_right">송파구 초 · 중 · 고등학생 및 학부모</p>
                            </div>
                        </div>
                        <div class="col_6 por txt_wrap">

                            <ul class="bef_middot txt_box fs_20 fs_md_26 lh_30 ">
                                <li>공부를 열심히 해도 <b>성적이 오르지 않는 학생</b></li>
                                <li>공부를 어떻게 해야 <b>하는지 방법을 모르는 학생</b></li>
                                <li><b>왜 공부를 해야하는지</b> 모르는 학생</li>
                                <li>자신의 <b>진로를 결정하는데 도움</b>을 받고 싶은 학생</li>
                                <li>자녀에게 <b>학습방법 및 진로지도</b>에 도움을 주고 싶은 학부모</li>
                                <li><b>나에게 맞는 진학정보</b>를 알고 싶은 학생</li>
                            </ul>

                        </div>
                    </div>
                </div>
                <!-- 1 end -->
                <h2 class="c_tit_2 mt_25">진학학습 프로그램</h2>
                <div class="img_step_box2 st_b t_center fs_22 mb_90">
                    <ul class="row">
                        <li class="col_13 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_08.png" alt="진학상담실">
                                    <p>진학상담실</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_13 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_09.png" alt="입시설명회">
                                    <p>입시설명회</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_13 col_md_6 mt_md_20">
                            <div class="step_text_wrap">
                                <span class="step_num">3</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_10.png" alt="송파쌤 홈스쿨링">
                                    <p>송파쌤 홈스쿨링</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_13 col_md_6 mt_md_20">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_11.png" alt="온라인 코칭쌤">
                                    <p>온라인 코칭쌤</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_13 col_md_6 mt_md_20">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_12.png" alt="학습상담실">
                                    <p>학습상담실</p>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- 2 end -->
                <h2 class="c_tit_2 mt_25">오시는 길</h2>
                <div class="drct_wrap mt_20">
                    <div class="drct_box st_b">
                        <!-- 네이버 지도 API 삽입 부분 -->
                        <div id="daumRoughmapContainer1603957029068" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1603957029068",
                                "key" : "22pxm",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                        <%--<img src="/ssem/resources/img/sub/smp_map_img_01.jpg" alt="네이버 지도">--%>
                        <!-- map_marker.png -->
                        <i class="icon_map_marker">송파쌤</i>
                    </div>
                    <div class="drct_txt_box">
                        <p class="fs_24 fs_md_26 fw_500">
                            서울특별시 송파구 올림픽로 8길 22 (잠실청소년센터 2층)<br>
                            <span class="sub_txt fw_200"><a href="tel:02-2147-2381" class="fs_md_24 tc_sub">T. 02-2147-2381/2385</a></span>
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
