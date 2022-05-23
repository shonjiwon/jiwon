<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-22
  Time: 오후 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js
        svsw_img_box();
        subMainNoticeSlide();
        subListlSlide1();
        subListlSlide2();
        subListlSlide3();
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
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next2.png' alt='다음'> </button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev2.png' alt='이전'> </button>",
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
                        }
                    },
                    {
                        breakpoint: 1200,
                        settings: {
                            arrows:false,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 870,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                ]
            });
        }
    }

    function subListlSlide2(){
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
                                    인물도서관
                                </h2>
                                <p class="tit_sub">
                                    <strong>“사람이 책이다”</strong>라는 개념으로 사회저명인사, 마을인재, 기업들이 송파쌤 대표 인재풀인 ‘인물도서’로 참여하여<br class="screen_sm_hide">자라나는 청소년들이 올바르게 성장할 수 있도록 돕는 멘토링 플랫폼입니다.
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
                        <a href="#" class="deapth_tit" title="선택">인물도서관</a>
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
    </div>

    <div class="sub_con st_2"><!-- sub_con -->
        <h3 class="mt_100 mb_60 tit font_sc">인물도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->

        <section class="text_con fs_20 fs_md_26  pb_100 mb_15 mt_md_50">
            <div class="sub_main_list_wrap pb_md_50">
                <div class="wrap por">
                    <h2 class="tit"><span>인물도서 목록</span></h2>
                    <div class="sml row pt_30 pt_md_20 fs_24 fs_md_26">
                        <c:forEach items="${personList}" var="person" varStatus="status">
                            <div class="snt_item color_1 col_3 col_lg_4 col_sm_6">
                                <a href="/ssem/youth/campus/person_lib_book_view.do?person_book_idx=${person.person_book_idx}">
                                    <section>
                                        <div class="img_box">
                                            <c:forEach items="${person.thumbFileList}" var="thumb_person" varStatus="status">
                                                <img src="${thumb_person.file_src}" alt="${person.alt_txt}">
                                            </c:forEach>
                                        </div>
                                        <div class="text_box">
                                            <div class="catalogue_box fs_18 fs_md_24">
                                                <span class="item">
                                                    <c:choose>
                                                        <c:when test="${person.cate_cd eq 'J'}">진로직업</c:when>
                                                        <c:when test="${person.cate_cd eq 'C'}">문화예술</c:when>
                                                        <c:when test="${person.cate_cd eq 'H'}">인문교양</c:when>
                                                        <c:when test="${person.cate_cd eq 'P'}">인성심리</c:when>
                                                        <c:when test="${person.cate_cd eq 'E'}">전문인</c:when>
                                                        <c:when test="${person.cate_cd eq 'Z'}">기타</c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <h4 class="_tit">
                                                <span class="ellip_1">${person.title}</span>
                                            </h4>
                                            <div class="item_bottom">
                                                <div class="clearfix">
                                                    <span class="float_left">인물도서 : ${person.person}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="/ssem/youth/campus/person_lib_book_list.do" class="more_btn ani">+ 더보기</a>
                </div>
            </div>

            <div class="wrap mt_100 mt_lg_100 mt_md_80">
                <div class="row row_p_13">
                    <div class="col_6 col_md_10 offset_md_1 col_sm_12 offset_sm_0">
                        <div class="line_box">
                            <h2 class="fs_32 mb_25">이달의 인물도서</h2>
                            <div class="img_info_slide library_img_box">
                                <!--iis_itme-->
                                <div class="iis_itme">
                                    <a href="#">
                                        <section>
                                            <span class="lib_month_box">
                                                <span class="lib_month">
                                                    <strong class="fs_40 fw_600 font_roboS">${monthInfo.month}</strong>
                                                    <span>월</span>
                                                </span>
                                            </span>
                                            <div class="img_box">
                                                <c:forEach items="${monthInfo.thumbFileList}" var="thumb_month" varStatus="status">
                                                    <img src="${thumb_month.file_src}" alt="${monthInfo.alt_txt}">
                                                </c:forEach>
                                            </div>
                                            <div class="text_box fs_22 fs_lg_18 fs_md_26">
                                                <div class="table">
                                                    <div class="col">
                                                        <div class="fw_600 lh_16">
                                                            <span>인물도서</span><br>
                                                            <span class="tc_2">${monthInfo.person}</span>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="line_left">${monthInfo.summary}</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </a>
                                </div>
                                <!--iis_itme-->
                            </div>
                            <a href="/ssem/youth/campus/person_lib_month_list.do" class="more">+</a>
                        </div>
                    </div>
                    <div class="col_6  col_md_10 offset_md_1 col_sm_12 offset_sm_0 mt_md_80">
                        <div class="line_box ">
                            <h2 class="fs_32 mb_25">LIVE 인물도서</h2>
                            <ul class="sub_main_list_box">
                                <c:forEach items="${liveList}" var="live" varStatus="status">
                                    <li>
                                        <a href="/ssem/youth/campus/person_lib_live_view.do?person_book_idx=${live.person_book_idx}">
                                            <section>
                                                <h1 class="title">${live.title}</h1>
                                                <ul>
                                                    <li><strong>인물도서</strong><span>${live.person}</span></li>
                                                </ul>
                                            </section>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <a href="/ssem/youth/campus/person_lib_live_list.do" class="more">+</a>
                        </div>
                    </div>
                </div>
                <div class="row row_p_13 mt_100 mt_md_80">
                    <div class="col_6 col_md_10 offset_md_1 col_sm_12 offset_sm_0">
                        <div class="line_box ">
                            <h2 class="fs_32 mb_25">찾아가는 인물도서</h2>
                            <div class="sub_main_list_img_col_box">
                                <c:forEach items="${schoolList}" var="school" varStatus="status">
                                    <div class="item">
                                        <a href="/ssem/youth/campus/person_lib_school_view.do?person_book_idx=${school.person_book_idx}">
                                            <section>
                                                <div class="img_box">
                                                    <div class="img_con">
                                                        <c:forEach items="${school.thumbFileList}" var="thumb_school" varStatus="status">
                                                            <img src="${thumb_school.file_src}" alt="${school.alt_txt}">
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <div class="text_box">
                                                    <p class="fs_22 fs_md_26 fw_600">인물도서 : ${school.person}</p>
                                                    <h1 class="title ellip_2">${school.title}</h1>
                                                    <ul>
                                                        <li><strong>등록일</strong><span>${fn:substring(school.reg_dt, 0, 10)}</span></li>
                                                    </ul>
                                                </div>
                                            </section>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                            <a href="/ssem/youth/campus/person_lib_school_list.do" class="more">+</a>
                        </div>
                    </div>
                    <div class="col_6 col_md_10 offset_md_1 col_sm_12 offset_sm_0 mt_md_80">
                        <div class="line_box ">
                            <h2 class="fs_32 mb_0">인물도서 열람후기</h2>
                            <div class="sub_main_list_img_row_box">
                                <c:forEach items="${reviewList}" var="review" varStatus="stat">
                                    <c:choose>
                                        <c:when test="${stat.count % 2 eq 1}">
                                            <div class="item">
                                                <a href="/ssem/youth/campus/person_lib_review_view.do?person_book_idx=${review.person_book_idx}">
                                                    <section>
                                                        <div class="img_box">
                                                            <div class="img_con">
                                                                <c:forEach items="${review.thumbFileList}" var="thumb_review" varStatus="status">
                                                                    <img src="${thumb_review.file_src}" alt="${review.alt_txt}">
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="text_box">
                                                            <h1 class="title ellip_2">${review.title}</h1>
                                                            <ul>
                                                                <li><strong>인물도서</strong><span>${review.person}</span></li>
                                                            </ul>
                                                        </div>
                                                    </section>
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="item">
                                                <a href="/ssem/youth/campus/person_lib_review_view.do?person_book_idx=${review.person_book_idx}">
                                                    <section>
                                                        <div class="text_box">
                                                            <h1 class="title ellip_2">${review.title}</h1>
                                                            <ul>
                                                                <li><strong>인물도서</strong><span>${review.person}</span></li>
                                                            </ul>
                                                        </div>
                                                        <div class="img_box">
                                                            <div class="img_con">
                                                                <c:forEach items="${review.thumbFileList}" var="thumb_review" varStatus="status">
                                                                    <img src="${thumb_review.file_src}" alt="${review.alt_txt}">
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
                            <a href="/ssem/youth/campus/person_lib_review_list.do" class="more">+</a>
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
                            <a href="#">
                                <section>
                                    <h4 class="snt_tit ellip_3">
                                        ${notice.title}
                                    </h4>
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
