<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '갤러리 > 미래교육센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        svsw_img_box();

        tabMoImgInit();

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
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

    function tabMoImgInit(){
        $('.table_img_ul > ul > li').each(function(ind, item){
            if($(item).find('.text_con').length < 2){
                var $text_c = $(item).find('.text_con').clone().addClass('screen_hide screen_md_show col_12');
                var $text_t = $(item).find('.text_top').clone().addClass('screen_hide screen_md_show col_12');

                $(item).find('.text_box').after($text_c);
                $(item).find('.text_box').after($text_t);
                $(item).find('.text_box .text_con').addClass('screen_md_hide');
                $(item).find('.text_box .text_top').addClass('screen_md_hide');

                $(item).addClass('st_2');
            }
        });
    }
    function goSearch() {
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
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
                        <a href="#" class="deapth_tit" title="선택">갤러리</a>
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
            <a href="#" class="tab_m">갤러리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/future_review_list.do" title="선택">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">갤러리</h4>
        <form name="frm" id="frm" method="post" action="/ssem/youth/campus/future_review_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <div class="wrap">
                <div class="row">
                    <div class="col_2 col_md_12 pl_20 pl_md_0 col_half t_md_right">
                        <!--
                            sel_box select class="placeholder"
                            [option value= ""] placeholder 컬러
                        -->
                        <div class="sel_box sel_full sel_md_short">
                            <select name="searchKind2" id="searchKind2" title="검색조건" class="placeholder">
                                <option value="ALL" <c:if test="${searchKind2 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                <option value="1" <c:if test="${searchKind2 eq '1'}">selected="selected"</c:if>>제목</option>
                                <option value="2" <c:if test="${searchKind2 eq '2'}">selected="selected"</c:if>>내용</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_10 col_md_12 pl_20 pl_md_0 mt_md_25 data_search_word_box">
                        <div class="fm_inp inp_full">
                            <input class="inp" name="searchVal" id="searchVal" value="${searchVal}" title="검색어">
                        </div>
                        <button type="submit" class="data_search_btn" id="btn_search">
                            <i class="icon_search">검색</i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <div class="wrap">
            <div class="table_img_ul mt_10 fs_18"> <!--table_img_ul-->
                <ul>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li>
                            <!--data : s-->
                            <div class="noDate t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘갤러리’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </li>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <li>
                            <a href="/ssem/youth/campus/future_review_view.do?future_edu_review_idx=${item.future_edu_review_idx}">
                                <section class="row">
                                    <div class="img_box col_4 col_sm_6">
                                        <div class="img_wrap">
                                            <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                                <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="text_box col_8 col_sm_6  fs_20 fs_md_24">
                                        <div class="text_top line_top">
                                            <div class="title ellip_1 fs_26 fs_md_28">${item.title}</div>
                                        </div>
                                        <div class="text_con">
                                            <p class="ellip_3 tc_sub fw_200 fs_md_24 plr_20 plr_md_0">
                                                <common:removeHtml pstr="${item.cont}" />
                                            </p>
                                        </div>
                                        <div class="text_bottom">
                                            <ul class="info_list fs_md_24">
                                                <li><b>글쓴이</b> ${item.reg_nm}</li>
                                                <li><b>등록일</b> ${fn:substring(item.reg_dt, 0, 10)}</li>
                                                <li><b>조회수</b> ${item.cnt}</li>
                                            </ul>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div><!--table_img_ul //-->
        </div>
        <common:pageLink name="pageholder"/>
    </div>
</div>
