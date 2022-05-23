<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '진학학습지원센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
                arrows: false,
                dots: true,
                slidesToShow: 4,
                slidesToScroll: 4,
                appendDots: $('.snt_control'),
                adaptiveHeight: true,
                responsive: [
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows: false,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            arrows: false,
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
        var len = $('.sub_main_list_img_col_box > div').length;
        if( !$('.sub_main_list_img_col_box').hasClass('slick-slider')) {
            var html = '';

            $('.sub_main_list_img_col_box').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.sub_main_list_img_col_box').slick({
                infinite: true,
                arrows:true,
                appendArrows:	$('.sub_main_list_img_col_box + ._control'),
                dots: false,
                slidesToShow: 2,
                slidesToScroll: 2,
                adaptiveHeight:true,
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
                <li class="tab_item"><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_counsel_insert.do">온라인 상담예약</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15 mt_md_50">
            <div class="sub_main_list_wrap pb_md_50">
                <div class="wrap por">
                    <h2 class="tit"><span>프로그램 신청</span></h2>
                    <div class="sml row pt_30 pt_md_20 fs_24 fs_md_26">
                        <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                            <div class="snt_item color_1 col_3 col_lg_4 col_sm_6">
                                <a href="/ssem/youth/campus/self_program_view.do?lecture_idx=${lecture.lecture_idx}">
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
                                                <span class="item">진학학습지원센터</span>
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
                    <a href="/ssem/youth/campus/self_program_list.do" class="more_btn ani">+ 더보기</a>
                </div>
            </div>
            <div class="wrap mt_100 mt_lg_100 mt_md_80">
                <div class="row row_p_13">
                    <div class="col_6 col_lg_8 offset_lg_2 col_md_10 offset_md_1 col_sm_12 offset_sm_0">
                        <div class="line_box">
                            <h2 class="fs_32 mb_25">온라인 상담 예약</h2>
                            <div class="img_info_slide st_2">
                                <!--iis_itme-->
                                <div class="iis_itme">
                                    <a href="/ssem/youth/campus/self_counsel_insert.do">
                                        <section>
                                            <div class="img_box">
                                                <img src="/ssem/resources/img/sample/sample_img_06.jpg" alt="샘플이미지">
                                            </div>
                                        </section>
                                    </a>
                                </div>
                                <!--iis_itme-->
                            </div>
                            <a href="/ssem/youth/campus/self_counsel_insert.do" class="more">+</a>
                        </div>
                    </div>
                    <div class="col_6 col_lg_8 offset_lg_2 col_md_10 offset_md_1 col_sm_12 offset_sm_0 mt_lg_40 mt_md_80">
                        <div class="line_box ">
                            <h2 class="fs_32 mb_25">진학학습정보</h2>
                            <div class="sub_main_list_img_col_box st_2">
                                <c:forEach items="${eduList}" var="edu" varStatus="status">
                                    <div class="item">
                                        <a href="/ssem/youth/campus/self_study_view.do?self_edu_intro_idx=${edu.self_edu_intro_idx}">
                                            <section>
                                                <div class="img_box">
                                                    <div class="img_con">
                                                        <c:forEach items="${edu.thumbFileList}" var="thumb" varStatus="status">
                                                            <img src="${thumb.file_src}" alt="${edu.alt_txt}">
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <div class="text_box">
                                                    <h1 class="title ellip_2">${edu.title}</h1>
                                                    <ul>
                                                        <li><strong>등록일</strong><span>${fn:substring(edu.reg_dt, 0, 10)}</span></li>
                                                        <li><strong>조회수</strong><span>${edu.cnt}</span></li>
                                                    </ul>
                                                </div>
                                            </section>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                            <a href="/ssem/youth/campus/self_study_list.do" class="more">+</a>
                        </div>
                    </div>
                </div>
            </div>
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
                                            <i class="icon_date_bk mr_15">달력</i><span>${fn:substring(notice.reg_dt, 0, 10)}</span>
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
    </div>
</div>
