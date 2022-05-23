<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '미래교육센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        svsw_img_box();

        subMainNoticeSlide();
        subListlSlide1();
        subListlSlide2();
        subListlSlide3();
        subMainReviewSlide();
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

    function subMainNoticeSlide(){
        var len = $('.snt > div').length;
        if( !$('.snt').hasClass('slick-slider')) {
            var html = '';

            $('.sub_notice_wrap > .wrap').append('<div class="snt_control mt_20"></div>')

            //dot 생성
            var $ntSlide = $('.snt').slick({
                infinite: true,
                arrows:false,
                dots: true,
                slidesToShow: 4,
                slidesToScroll: 4,
                appendDots : $('.snt_control'),
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            arrows:false,
                            slidesToShow: 2,
                            slidesToScroll: 2
                        }
                    }
                ]
            });
        }
    }

    function subListlSlide1(){
        var len = $('.sml > div').length;
        if( !$('.sml').hasClass('slick-slider')) {
            var html = '';

            $('.sml').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.sml').slick({
                infinite: true,
                arrows:true,
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next2.png' alt='다음'> </ button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev2.png' alt='이전'> </ button>",
                appendArrows:	$('.sml + ._control'),
                appendDots : $('.sml + ._control'),
                dots: false,
                slidesToShow: 4,
                slidesToScroll: 4,
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1660,
                        settings: {
                            arrows:false,
                            dots:true,
                        }
                    },
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            dots:true,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 1024,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 767,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 3,
                        }
                    }
                ]
            });
        }
    }

    function subListlSlide2(){
        var len = $('.img_info_slide > div').length;
        if( !$('.img_info_slide').hasClass('slick-slider')) {
            var html = '';

            $('.img_info_slide').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.img_info_slide').slick({
                infinite: true,
                arrows:true,
                appendArrows:	$('.img_info_slide + ._control'),
                dots: false,
                fade:true,
                slidesToShow: 1,
                slidesToScroll: 1,
                adaptiveHeight:true,
            });
        }
    }


    function subListlSlide3(){
        var len = $('.sub_main_list_img_row_box > div').length;
        if( !$('.sub_main_list_img_row_box').hasClass('slick-slider')) {
            var html = '';

            $('.sub_main_list_img_row_box').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.sub_main_list_img_row_box').slick({
                infinite: true,
                arrows:true,
                appendArrows:	$('.sub_main_list_img_row_box + ._control'),
                dots: false,
                rows: 2,
                slidesToShow: 1,
                slidesToScroll: 1,
            });
        }
    }

    function subMainReviewSlide(){
        var len = $('.swt > div').length;
        if( !$('.swt').hasClass('slick-slider')) {
            var html = '';

            $('.swt').after('<div class="_control"></div>')

            //dot 생성
            var $ntSlide = $('.swt').slick({
                infinite: true,
                arrows:false,
                dots: true,
                slidesToShow: 4,
                slidesToScroll: 4,
                appendDots : $('.swt + ._control'),
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            arrows:false,
                            slidesToShow: 2,
                            slidesToScroll: 2
                        }
                    }
                ]
            });
        }
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual_sd_wrap"><!-- sub_visual_sd_wrap -->
        <div class="svsw_img_box">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <div class="svsw_img_item">
                    <a href="${banner.link}" <c:if test="${banner.link_tgt eq 'N'}">target="_blank"</c:if>>
                        <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                            <img src="${item.file_src}" alt="${banner.alt_txt}">
                        </c:forEach>
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
                    </a>
                </div>
            </c:forEach>
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
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                <li  class="tab_item"><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                <li  class="tab_item"><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                <li  class="tab_item"><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15 mt_md_50">
            <div class="sub_main_list_wrap pb_md_50">
                <div class="wrap por">
                    <h2 class="tit"><span>프로그램 신청</span></h2>
                    <div class="sml row pt_30 pt_md_20 fs_24 fs_md_26">
                        <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                            <div class="snt_item color_1 col_3 col_lg_4 col_sm_6">
                                <a href="/ssem/youth/campus/future_program_view.do?lecture_idx=${lecture.lecture_idx}">
                                    <section>
                                        <div class="img_box">
                                            <c:if test="${lecture.closing_yn eq 'Y'}">
                                                <div class="marker_box">
                                                    <span class="marker">
                                                        <span>마감 임박</span>
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:forEach items="${lecture.thumbFileList}" var="thumb" varStatus="status">
                                                <img src="${thumb.file_src}" alt="${lecture.alt_txt}">
                                            </c:forEach>
                                        </div>
                                        <div class="text_box">
                                            <div class="catalogue_box fs_18 fs_md_24">
                                                <span class="item">미래교육센터</span>
                                            </div>
                                            <h4 class="_tit">
                                                <span class="ellip_1">${lecture.name}</span>
                                            </h4>
                                            <div class="item_bottom">
                                                <div class="clearfix">
                                                    <span class="float_left"><i class="icon_time_bk mr_5">타임</i> <span class="va_m">${fn:substring(lecture.start_dt, 2, 10)} ~ ${fn:substring(lecture.end_dt, 2, 10)}</span></span>
                                                    <c:choose>
                                                        <c:when test="${lecture.love_self_yn eq 'Y'}">
                                                            <span class="float_right fw_400"><i class="icon_heart_line mr_5 on" title="활성화">하트</i><span class="va_m">${lecture.love_cnt}</span></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="float_right fw_400"><i class="icon_heart_line mr_5" title="비활성화">하트</i><span class="va_m">${lecture.love_cnt}</span></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="/ssem/youth/campus/future_program_list.do" class="more_btn ani">+ 더보기</a>
                </div>
            </div>
            <div class="wrap mt_100 mt_lg_100 mt_md_80">
                <div class="row row_p_13">
                    <div class="col_6 col_md_10 offset_md_1 col_sm_12 offset_sm_0">
                        <div class="line_box">
                            <h2 class="fs_32 mb_25">센터별 소개</h2>
                            <div class="img_info_slide st_2">
                                <c:forEach items="${introList}" var="intro" varStatus="status">
                                    <div class="iis_itme">
                                        <a href="/ssem/youth/campus/future_intro.do#${intro.future_edu_intro_idx}">
                                            <section>
                                                <div class="img_box">
                                                    <c:forEach items="${intro.thumbFileList}" var="thumb" varStatus="status">
                                                        <img src="${thumb.file_src}" alt="${intro.alt_txt}">
                                                    </c:forEach>
                                                </div>
                                                <div class="text_box fs_18 fs_md_22">
                                                    <div class="table">
                                                        <div class="col fw_600 fs_28 fs_md_26">${intro.name}</div>
                                                        <div class="col">
                                                            <ul>
                                                                <li><strong class="fw_400">대상</strong> ${intro.tgt}</li>
                                                                <li><strong class="fw_400">시간</strong> ${intro.term_time}</li>
                                                                <li><strong class="fw_400">위치</strong> ${intro.location}</li>
                                                                <li><strong class="fw_400">문의</strong> ${intro.quest}</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                            <a href="/ssem/youth/campus/future_intro.do" class="more">+</a>
                        </div>
                    </div>
                    <div class="col_6 col_md_10 offset_md_1 col_sm_12 offset_sm_0 mt_md_80 screen_md_hide">
                        <div class="line_box">
                            <h2 class="fs_32 mb_0">갤러리</h2>
                            <div class="sub_main_list_img_row_box">
                                <c:forEach items="${reviewList}" var="review" varStatus="stat">
                                    <c:choose>
                                        <c:when test="${stat.count % 2 eq 1}">
                                            <div class="item">
                                                <a href="/ssem/youth/campus/future_review_view.do?future_edu_review_idx=${review.future_edu_review_idx}">
                                                    <section>
                                                        <div class="img_box">
                                                            <div class="img_con">
                                                                <c:forEach items="${review.thumbFileList}" var="thumb" varStatus="status">
                                                                    <img src="${thumb.file_src}" alt="${review.alt_txt}">
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="text_box">
                                                            <h1 class="title"><p class="fs_22 fw_600 ellip_2">${review.title}</p></h1>
                                                            <ul>
                                                                <li><strong>등록일</strong><span>${fn:substring(review.reg_dt, 0, 10)}</span></li>
                                                                <li><strong>조회수</strong><span>${review.cnt}</span></li>
                                                            </ul>
                                                        </div>
                                                    </section>
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="item">
                                                <a href="/ssem/youth/campus/future_review_view.do?future_edu_review_idx=${review.future_edu_review_idx}">
                                                    <section>
                                                        <div class="text_box">
                                                            <h1 class="title"><p class="fs_22 fw_600 ellip_2">${review.title}</p></h1>
                                                            <ul>
                                                                <li><strong>등록일</strong><span>${fn:substring(review.reg_dt, 0, 10)}</span></li>
                                                                <li><strong>조회수</strong><span>${review.cnt}</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="img_box">
                                                            <div class="img_con">
                                                                <c:forEach items="${review.thumbFileList}" var="thumb" varStatus="status">
                                                                    <img src="${thumb.file_src}" alt="${review.alt_txt}">
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </section>
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <a href="/ssem/youth/campus/future_review_list.do" class="more">+</a>
                        </div>
                    </div>
                </div>
            </div>
            <!--이용 후기 모바일-->
            <div class="sub_review_wrap mt_100 mt_md_70 pt_50 pb_100 bg_color_2 screen_hide screen_md_show">
                <div class="wrap por">
                    <h3 class="tit"><span>갤러리</span></h3>
                    <div class="swt pt_30 fs_18 fs_md_22">
                        <!-- swt_item -->
                        <div class="swt_item">
                            <a href="#">
                                <section>
                                    <div class="img_box">
                                        <img src="/ssem/resources/img/sample/sample_img_03.jpg" alt="샘플이미지">
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit">
                                            <span class="ellip_1">4차산업 교육 실시</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <ul>
                                                <li><strong>등록일</strong><span>2020-06-30</span></li>
                                                <li><strong>조회수</strong><span>123</span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                        <div class="swt_item">
                            <a href="#">
                                <section>
                                    <div class="img_box">
                                        <img src="/ssem/resources/img/sample/sample_img_04.jpg" alt="샘플이미지">
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit">
                                            <span class="ellip_1">4차산업 교육 실시</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <ul>
                                                <li><strong>등록일</strong><span>2020-06-30</span></li>
                                                <li><strong>조회수</strong><span>123</span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                        <div class="swt_item">
                            <a href="#">
                                <section>
                                    <div class="img_box">
                                        <img src="/ssem/resources/img/sample/sample_img_03.jpg" alt="샘플이미지">
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit">
                                            <span class="ellip_1">4차산업 교육 실시</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <ul>
                                                <li><strong>등록일</strong><span>2020-06-30</span></li>
                                                <li><strong>조회수</strong><span>123</span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                        <div class="swt_item">
                            <a href="#">
                                <section>
                                    <div class="img_box">
                                        <img src="/ssem/resources/img/sample/sample_img_04.jpg" alt="샘플이미지">
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit">
                                            <span class="ellip_1">4차산업 교육 실시</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <ul>
                                                <li><strong>등록일</strong><span>2020-06-30</span></li>
                                                <li><strong>조회수</strong><span>123</span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                        <!-- swt_item : e-->
                    </div>
                    <a href="#" class="more_btn ani">+ 더보기</a>
                </div>
            </div>
            <!--이용 후기 모바일 : e-->
            <div class="sub_notice_wrap mt_100 mt_md_70 pb_md_50">
                <div class="wrap por">
                    <h3 class="tit"><span>공지사항</span></h3>
                    <div class="snt pt_30 fs_24 fs_md_26">
                        <c:forEach items="${noticeList}" var="notice" varStatus="status">
                            <div class="snt_item">
                                <a href="/ssem/youth/ssem/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                                    <section>
                                        <h4 class="snt_tit ellip_3">${notice.title}</h4>
                                        <c:if test="${notice.p_top_yn eq 'Y'}">
                                        <div class="icon_new"><span>공지</span></div>
                                        </c:if>
                                        <p class="snt_data fs_18 fs_md_24">
                                            <i class="icon_date_bk mr_15">시간</i><span>${fn:substring(notice.reg_dt, 0, 10)}</span>
                                        </p>
                                    </section>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="/ssem/youth/ssem/notice_list.do" class="more_btn ani">+ 더보기</a>
                </div>
            </div>
        </section>
    </div><!-- sub_con : e -->
</div>
