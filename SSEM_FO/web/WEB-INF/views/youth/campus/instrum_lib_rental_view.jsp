<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '악기대여 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">악기대여</a>
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
            <a href="#" class="tab_m">악기대여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_rental_list.do" title="선택">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">악기대여</h4>
        <div class="wrap">
            <div class="table_box_ul music_table_img_box fs_18 fs_md_24"><!--table_box-->
                <div class="row_15">
                    <div class="col_4 col_lg_6 col_md_15">
                        <div class="img_box">
                            <c:forEach items="${instrumVo.fileList}" var="thumb" varStatus="status">
                                <img src="${thumb.file_src}" alt="${instrumVo.alt_txt}">
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col_11 col_lg_9 col_md_15 mti_border_top">
                        <ul>
                            <li class="table">
                                <div class="th wid_300">악기유형</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${instrumVo.gubun eq 'A'}">건반악기</c:when>
                                        <c:when test="${instrumVo.gubun eq 'B'}">관악기</c:when>
                                        <c:when test="${instrumVo.gubun eq 'C'}">타악기</c:when>
                                        <c:when test="${instrumVo.gubun eq 'D'}">현악기</c:when>
                                        <c:when test="${instrumVo.gubun eq 'E'}">MIDI장비</c:when>
                                        <c:when test="${instrumVo.gubun eq 'K'}">국악기</c:when>
                                        <c:when test="${instrumVo.gubun eq 'Z'}">기타</c:when>
                                    </c:choose>
                                </div>
                            </li>
                            <li class="table">
                                <div class="th wid_300">악기명</div>
                                <div class="td">${instrumVo.name}</div>
                            </li>
                            <li class="table">
                                <div class="th wid_300">대여료</div>
                                <div class="td"><fmt:formatNumber value="${instrumVo.fee}" pattern="##,###" />원/월</div>
                            </li>
                            <li class="table">
                                <div class="th wid_300">남은수량</div>
                                <div class="td"><c:out value="${instrumVo.qty - instrumVo.rental_qty}" />개</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <ul>
                    <li class="table">
                        <div class="th wid_full t_center line_none_bottom line_none_top">악기설명</div>
                    </li>
                    <li class="table">
                        <div class="td wid_full content_box">
                            ${instrumVo.cont}
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <ul class="table_list_ul prev_next_page_box fs_18 fs_md_24">
                <c:choose>
                    <c:when test="${instrumVo.prev ne null}">
                        <li class="prev_box">
                            <a href="/ssem/youth/campus/instrum_lib_rental_view.do?instrum_idx=${instrumVo.prev.instrum_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_prev_bk">이전</i><span class="screen_md_hide">이전글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${instrumVo.prev.name}</p></div>
                                    <div class="col wid_100 t_left">${instrumVo.prev.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(instrumVo.prev.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${instrumVo.next ne null}">
                        <li class="next_box">
                            <a href="/ssem/youth/campus/instrum_lib_rental_view.do?instrum_idx=${instrumVo.next.instrum_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_next_bk">다음</i><span class="screen_md_hide">다음글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${instrumVo.next.name}</p></div>
                                    <div class="col wid_100 t_left">${instrumVo.next.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(instrumVo.next.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="btn_box mt_50 mb_100 pb_30 t_right t_md_center">
                <c:if test="${instrumVo.qty - instrumVo.rental_qty > 0}">
                    <a href="/ssem/youth/campus/instrum_lib_rental_insert.do?instrum_idx=${instrumVo.instrum_idx}" id="applyBtn" class="btn btn_color_5 t_centermr_20 mr_15">대여 신청</a>
                </c:if>
                <a href="/ssem/youth/campus/instrum_lib_rental_list.do" class="btn btn_short t_center">목록</a>
            </div>
        </div>
    </div>
</div>
