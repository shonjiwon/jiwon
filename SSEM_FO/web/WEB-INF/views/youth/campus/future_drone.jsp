<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파쌤 드론스쿨 > 미래교육센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
<div class="contents" id="contents">
    <div class="sub_visual st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    미래교육센터
                </h2>
                <p class="tit_sub">
                    <strong>“AI코딩, VR, 드론, 미디어, 글로벌 토론”</strong>
                    창의적 문제해결능력과 글로벌 리더십을 가진 <br class="screen_hide screen_sm_show">미래융합 인재를 양성합니다.<br>
                    송파쌤 미래교육센터는 현재 7관까지 조성&middot;운영하고 있습니다
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
                        <a href="#" class="deapth_tit" title="선택">미래교육센터</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤 드론스쿨</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                            <li><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
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
    <div class="sub_con st_3"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">미래교육센터</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">송파쌤 드론스쿨<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/future_drone.do" title="선택">송파쌤 드론스쿨</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_3_1 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <h5 class="fs_38">송파쌤 드론스쿨</h5>
                    <p class="fs_22 fs_md_24 mt_40 mt_md_20">
                        미래성장산업인 드론에 대한 이론과 드론 실무비행 체험 등 <br class="screen_hide screen_md_show"> 체계적인 교육을 통해<br class="screen_md_hide">청소년들의 재능과 적성을 개발하고 <br class="screen_hide screen_md_show"> 창의적 인재육성을 지원합니다.
                    </p>
                    <div class="info_grp mt_30">
                        <img src="/ssem/resources/img/sub/sub_info_visual_st_3_img_01.png" class="screen_md_hide" alt="송파샘 드론스쿨 송파쌤 드론전문 교육기관 송파구정">
                        <img src="/ssem/resources/img/sub/sub_info_visual_st_3_img_01_m.png" class="screen_hide screen_md_show" alt="송파샘 드론스쿨 송파쌤 드론전문 교육기관 송파구정">
                        <div class="info_grp_text st_1">
                            <strong>교육생</strong>
                            <ul>
                                <li> - 관내 초중학생 대상</li>
                                <li> - 학생들의 자발적 참여</li>
                            </ul>
                        </div>
                        <div class="info_grp_text st_2">
                            <strong>드론전문 교육기관</strong>
                            <ul>
                                <li> - 교육 커리큘럼 개발</li>
                                <li> - 교육 운영(이론/실습)</li>
                                <li> - 교육과정 수료증 수여</li>
                            </ul>
                        </div>
                        <div class="info_grp_text st_3">
                            <strong>송파구청</strong>
                            <ul>
                                <li> - 드론 스쿨 기획/홍보</li>
                                <li> - 교육 수강생 모집</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_100">교육과정</h2>

                <div class="img_step_box st_3 t_center fs_22 fs_md_26">
                    <ul class="row_15">
                        <li class="col_7">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <p class="fs_22 fs_md_26 fw_600">Step 1. 입문종합반</p>
                                <div class="float_left mt_25">
                                    <img src="/ssem/resources/img/sub/img_setp_drone_img_01.png" alt="이론교육">
                                    <p class="mt_10 mb_5">이론교육</p>
                                    <p class="fs_18 fs_md_26 fw_200 tc_sub">원리·기초비행</p>
                                    <span class="mark mt_10">초&middot;중학생</span>
                                </div>
                                <div class="float_left mt_25 line_left">
                                    <img src="/ssem/resources/img/sub/img_setp_drone_img_02.png" alt="체험학습">
                                    <p class="mt_10 mb_5">체험학습</p>
                                    <p class="fs_18 fs_md_26 fw_200 tc_sub">개념이해 및 체험</p>
                                    <span class="mark mt_10">초&middot;중학생</span>
                                </div>
                            </div>
                        </li>
                        <li class="col_4">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <p class="fs_22 fs_md_26 fw_600">Step 2. 심화반</p>
                                <div class="mt_25">
                                    <img src="/ssem/resources/img/sub/img_setp_drone_img_03.png" alt="실습 응용">
                                    <p class="mt_10 mb_5">실습·응용</p>
                                    <p class="fs_18 fs_md_26 fw_200 tc_sub">드론촬영, 드론축구</p>
                                    <span class="mark mt_10">초&middot;중학생</span>
                                </div>
                            </div>
                        </li>
                        <li class="col_4">
                            <div class="step_text_wrap">
                                <span class="step_num">3</span>
                                <p class="fs_22 fs_md_26 fw_600">Step 3. 자격증반</p>
                                <div class="mt_25">
                                    <img src="/ssem/resources/img/sub/img_setp_drone_img_04.png" alt="전문가 양성">
                                    <p class="mt_10 mb_5">전문가 양성</p>
                                    <p class="fs_18 fs_md_26 fw_200 tc_sub">국가공인 자격증 취득</p>
                                    <span class="mark mt_10">중학생</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="row mt_90 mt_md_0 fs_20 fs_md_26">
                    <div class="col_6 col_md_12 mt_md_70">
                        <h2 class="c_tit_2">교육기관</h2>
                        <p class="mt_20">SQ무인항공교육원 - ‘드론 이야기’(송파구 중대로 212)</p>
                    </div>
                    <div class="col_6 col_md_12 mt_md_70">
                        <h2 class="c_tit_2">교육대상</h2>
                        <p class="mt_20">관내 초5 ~ 중3</p>
                    </div>
                    <div class="col_12 col_md_12 mt_90 mt_md_70">
                        <h2 class="c_tit_2">지원내용</h2>
                        <p class="mt_20">교육비 일부지원</p>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_90">이용안내</h2>
                <div class="img_step_box t_center fs_22 fs_md_26">
                    <ul class="row_15">
                        <li class="col_3">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_03_img_01.png" alt="회원가입">
                                    <p>회원가입</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_03_img_02.png" alt="프로그램 검색">
                                    <p>프로그램 검색</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="step_text_wrap">
                                <span class="step_num">3</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_03_img_03.png" alt="참가신청서 작성">
                                    <p>참가신청서 작성</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_03_img_04.png" alt="교육생 선정">
                                    <p>교육생 선정</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="step_text_wrap">
                                <span class="step_num">5</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_03_img_05.png" alt="교육 진행">
                                    <p>교육 진행</p>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="row mt_30 mt_md_0 fs_20 fs_md_26">
                    <div class="col_12 col_md_12 mt_30 mt_md_30">
                        <h2 class="c_tit_2">문의</h2>
                        <p class="mt_20">02-2147-2374</p>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
