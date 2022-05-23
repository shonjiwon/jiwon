<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 2:55
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
        $(document).prop('title', '송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        maruNewsClick();
        progressSlider(0);
    });

    function progressSlider(ind){
        var len = $('.news_contents').eq(ind).length;
        if(len <= 0) return;

        $('.news_contents').eq(ind).siblings('.news_contents').hide().find('.slick-slider').slick('unslick');
        $('.news_contents').eq(ind).siblings('.news_contents').find('.progBar').remove();

        $('.news_contents').eq(ind).show();
        var $progsb = $('.news_contents .slick_area').eq(ind).slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            swipeToSlide: true,
            arrows:false,
            dots:false,
            infinite: false,
            speed: 300,
            responsive: [
                {
                    breakpoint: 1280,
                    settings: {
                        slidesToShow: 2,
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 2.5,
                    }
                },
                {
                    breakpoint: 780,
                    settings: {
                        slidesToShow: 2,
                    }
                },
                {
                    breakpoint: 500,
                    settings: {
                        slidesToShow: 1.5,
                    }
                }
            ]
        });
        initProgressBar();
        // beforeChange
        $progsb.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
            var calc = ( (nextSlide+slick.options.slidesToShow) / (slick.slideCount) ) * 100;
            if(calc > 100) calc = 100;
            $progress
                .css('width', calc + '%')
                .attr('aria-valuenow', calc);
        });
        function initProgressBar() {
            var progressBar = '<div class="progBar"><div class="prog"></div></div>';

            $('.news_contents').eq(ind).append(progressBar);
            $progressBar = $('.news_contents:eq('+ind+') .progBar');
            $progress = $('.news_contents:eq('+ind+') .progBar .prog');
            var calc = ( (3) / ($progsb.find('.slick-slide').length) ) * 100;
            // 초기화
            $progress
                .css('width', calc + '%')
                .attr('aria-valuenow', calc);

        }
    }

    function maruNewsClick() {
        $(document).off('.cate_list a').on('click','.cate_list a', function(e) {
            e.preventDefault();
            $($(this).attr('href')).attr('tabindex', 0).focus();
            var ind = $(this).closest('li').index();
            $('.cate_list a').removeClass('on');
            $(this).addClass('on');

            //슬라이더 이벤트
            progressSlider(ind);
            $('.news_contents').eq(ind).focus();

            //더보기 버튼
            $('.new_more').hide();
            $('.new_more').eq(ind).show();
        })
    }
</script>
<div class="contents" id="contents">
    <div class="main_visual mv_st_02"><!--mv_wrap--->
        <div class="mv">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <div class="mv_item">
                    <a href="${banner.link}" <c:if test="${banner.link_tgt eq 'N'}">target="_blank"</c:if>>
                    <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                        <img src="${item.file_src}" alt="${banner.alt_txt}">
                        <%--<img src="/ssem/resources/img/main/maru/mv_m_03_01.jpg" alt="공부이미지" class="screen_hide  screen_md_show">--%>
                    </c:forEach>
                    <div class="mv_text_box lh_16 ">
                        <!-- <p class="mv_sub_tit fs_24 mb_15 font_mts fw_700 ml_5"></p> -->
                        <h3 class="mv_sub_tit fs_60 lh_14 font_sc"><span class="fw_600">송파구 청소년<br class="screen_hide screen_md_show"> 진로체험의 중심</span></h3>
                        <p class="fs_26 mt_10">개인맞춤형 생애주기별 진로방향설정, 송파 꿈마루에서</p>
                    </div>
                    </a>
                </div>
            </c:forEach>
            <!--mv_item-->
        </div>
    </div><!--mv_wrap : e-->
    <!--program_item-->
    <!---
        program_item color class
        창의융합교육   : color_1
        인물도서관     : color_2
        창의융합교육   : color_3
        자기주도학습관 : color_4
        악기도서관     : color_5
    -->
    <div class="wrap por mt_100 mt_md_70 mt_md_60"><!--program_box_wrap-->
        <h3 class="tit fw_600 font_dxlp"><span class=" dp_b fs_48 lh_10">GGoommaru</span></h3>
        <p class="tit_sub t_center mt_10 fw_200 fs_18 fs_md_24 wb-ka">꿈마루는 여러분의 꿈을 응원합니다. <br> 좋은꿈 꾸세요.</p>
        <div class="row maru_box mt_40 mt_md_30 pt_10">
            <div class="color_1 col_6 col_md_12 mb_md_40">
                <!-- id : SSEM-C-01-02-01  -->
                <a href="/ssem/dream/dream/intro.do">
                    <section >
                        <div class="pi_img_box por">
                            <img src="/ssem/resources/img/main/maru/mp_sample_img_01.jpg" alt="새싹이미지">
                            <span class="img_tit poa fs_20 fw_700 font_robo">ABOUT</span>
                        </div>
                        <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                            <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                <span class="">송파진로직업체험지원센터 (꿈마루)란</span>
                            </h4>
                            <p class="pi_data fs_18 fs_md_26 fw_200 lh_16">
                                송파쌤의 시작,<br>
                                송파꿈마루에서 완성되는 행복한 꿈꾸기
                            </p>
                        </div>
                    </section>
                </a>
            </div>
            <div class="color_1 col_6 col_md_12 mb_md_40">
                <!-- id : SSEM-C-01-04-01  -->
                <a href="/ssem/dream/program/program_list.do">
                    <section>
                        <div class="pi_img_box por">
                            <img src="/ssem/resources/img/main/maru/mp_sample_img_02.jpg" alt="책 안경 이미지">
                            <span class="img_tit poa fs_20 fw_700 font_robo">PROGRAM</span>
                        </div>
                        <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                            <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                <span class="">프로그램 신청</span>
                            </h4>
                            <p class="pi_data fs_18 fs_md_26 fw_200 lh_16">
                                꿈마루에서 제공하는 최고의 진로체험 프로그램입니다.<br class="screen_xs_hide">
                                안내드리는 프로그램 정보(연령, 프로그램)를 확인하신 후 신청부탁드립니다.
                            </p>
                        </div>
                    </section>
                </a>
            </div>

            <!-- : e-->
        </div>
    </div><!-- e-->
    <div class="wrap news_box mt_70 mb_70 fw_300 clearfix"><!--banner_box -->
        <div class="">
            <div class="news_cate_box pt_50 pb_50 plr_50 pb_md_0 pt_md_60 plr_md_0 tc_w">
                <div class="por">
                    <div class="cate_tit lh_13 t_md_center mb_md_55">
                        <h5 class="por fw_500">
                            <span class="font_dxlp">NEWS</span>
                        </h5>
                        <p class="cate_sub_tit">
                            꿈마루 소식
                        </p>
                    </div>
                    <ul class="cate_list">
                        <li><a href="#pNotice" class="on" tilte="공지사항 슬라이드 영역 이동">공지사항<i class="st_icon rarr w7 h7"></i></a></li>
                        <li><a href="#pNews" tilte="보도자료 슬라이드 영역 이동">보도자료<i class="st_icon rarr w7 h7"></i></a></li>
                        <li><a href="#pGallery" tilte="갤러리 슬라이드 영역 이동">갤러리<i class="st_icon rarr w7 h7"></i></a></li>
                    </ul>
                    <a href="/ssem/dream/news/notice_list.do" class="new_more st_icon plus w16" title="공지사항 더보기"><i class="text_hide">더보기</i></a>
                    <a href="/ssem/dream/news/broad_list.do" class="new_more st_icon plus w16" title="보도자료 더보기" style="display: none;"><i class="text_hide">더보기</i></a>
                    <a href="/ssem/dream/news/gallery_list.do" class="new_more st_icon plus w16" title="갤러리 더보기" style="display: none;"><i class="text_hide">더보기</i></a>
                </div>
            </div>

            <div class="news_contents mt_md_80 row por" id="pNotice" style="display: none;">
                <div class="slick_area">
                    <c:forEach items="${noticeList}" var="notice" varStatus="status">
                        <c:choose>
                            <c:when test="${notice.p_top_yn eq 'Y'}">
                                <div class="col_4 item nc_text_box ">
                                    <a href="/ssem/youth/ssem/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                                        <div class="category ptb_10">
                                            <span class="item">공지사항</span>
                                        </div>
                                        <h4 class="nc_tit ellip_2">
                                                ${notice.title}
                                        </h4>
                                        <div class='nc_data'>
                                            <%--<p class="ellip_3">${notice.cont}</p>--%>
                                            <span class="reg_date">${fn:substring(notice.reg_dt, 0, 10)}</span>
                                        </div>
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col_4 item nc_text_box ">
                                    <a href="/ssem/dream/news/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                                        <div class="category ptb_10">
                                            <span class="item">공지사항</span>
                                        </div>
                                        <h4 class="nc_tit ellip_2">
                                                ${notice.title}
                                        </h4>
                                        <div class='nc_data'>
                                            <%--<p class="ellip_3">${notice.cont}</p>--%>
                                            <span class="reg_date">${fn:substring(notice.reg_dt, 0, 10)}</span>
                                        </div>
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
            <div class="news_contents mt_md_80 row por" id="pGallery" style="display: none;">
                <div class="slick_area">
                    <c:forEach items="${broadList}" var="broad" varStatus="status">
                        <div class="col_4 item nc_text_box ">
                            <a href="/ssem/dream/news/broad_view.do?bbs_detail_idx=${broad.bbs_detail_idx}">
                                <div class="category ptb_10">
                                    <span class="item">보도자료</span>
                                </div>
                                <h4 class="nc_tit ellip_2">
                                        ${broad.title}
                                </h4>
                                <div class='nc_data'>
                                    <%--<p class="ellip_3">${broad.cont}</p>--%>
                                    <span class="reg_date">${fn:substring(broad.reg_dt, 0, 10)}</span>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="news_contents mt_md_80 row por" id="pNews" style="display: none;">
                <div class="slick_area">
                    <c:forEach items="${galleryList}" var="gallery" varStatus="status">
                        <div class="col_4 item nc_text_box ">
                            <a href="/ssem/dream/news/gallery_view.do?bbs_detail_idx=${gallery.bbs_detail_idx}">
                                <div class="category ptb_10">
                                    <span class="item">갤러리</span>
                                </div>
                                <h4 class="nc_tit ellip_2">
                                        ${gallery.title}
                                </h4>
                                <div class='nc_data'>
                                    <%--<p class="ellip_3">${gallery.cont}</p>--%>
                                    <span class="reg_date">${fn:substring(gallery.reg_dt, 0, 10)}</span>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- news_contents end -->
        </div>
    </div><!--banner_box : e-->
    <div class="together_wrap mt_100 md_mt_100"><!-- magnet_box -->
        <div class="wrap por">
            <div class="tog_box t_center ptb_90">
                <h3 class="tit por"><span class="font_dxlp fs_48 fs_md_58 fw_600">TOGETHER</span></h3>
                <p class="tit_sub fw_200 fs_22 fs_md_30 wb-ka">가치, 같이 함께 해주세요</p>
                <ul class="row together_list mt_60 fs_22 fs_md_26 t_left">
                    <li class="col_4 col_md_12 mb_md_40">
                        <a href="/ssem/dream/together/experience.do" class="tog_inner">
                            <div class="tog_img">
                                <img src="/ssem/resources/img/main/maru/mmr_img_01_01.png" alt="현장직업체험처 참여 아이콘">
                            </div>
                            <p class="mt_25 fs_18 fs_md_26">
                                <strong class="tog_tit dp_b fw_600 fs_24 fs_md_34 mb_10">현장직업체험처 참여</strong>
                                송파청소년들이 현장에서 직업체험을
                                할 수 있도록 체험처를 개방해주세요
                            </p>
                        </a>
                    </li>
                    <li class="col_4 col_md_12 mb_md_40">
                        <a href="/ssem/dream/together/job_mentor.do" class="tog_inner">
                            <div class="tog_img">
                                <img src="/ssem/resources/img/main/maru/mmr_img_01_02.png" alt="직업인 멘토 아이콘">
                            </div>
                            <p class="mt_25 fs_18 fs_md_26">
                                <strong class="tog_tit dp_b fw_600 fs_24 fs_md_34 mb_10">직업인 멘토 참여</strong>
                                송파의 청소년들에게 여러분의 직업에
                                대한 멋진 경험과 경력을  알려주세요
                            </p>
                        </a>
                    </li>
                    <li class="col_4 col_md_12 mb_md_40">
                        <a href="/ssem/dream/together/home_mentor.do" class="tog_inner">
                            <div class="tog_img">
                                <img src="/ssem/resources/img/main/maru/mmr_img_01_03.png" alt="학부모진로교육멘토단 참여 아이콘">
                            </div>
                            <p class="mt_25 fs_18 fs_md_26">
                                <strong class="tog_tit dp_b fw_600 fs_24 fs_md_34 mb_10">학부모진로교육멘토단 참여</strong>
                                송파의 아이들, 함께 꿈꿀 수 있는
                                공간 만들기와 교육에 참여해주세요
                            </p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
