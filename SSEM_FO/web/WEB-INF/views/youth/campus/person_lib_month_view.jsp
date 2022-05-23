<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '이달의 인물도서 > 인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
    <div class="sub_visual st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    인물도서관
                </h2>
                <p class="tit_sub">
                    <strong>“사람이 책이다”</strong>라는 개념으로 사회저명인사, 마을인재, 기업들이 송파쌤 대표 인재풀인 ‘인물도서’로 참여하여 <br>자라나는 청소년들이 올바르게 성장할 수 있도록 돕는 멘토링 플랫폼입니다.
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
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">이달의 인물도서</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                            <li><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
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
    <div class="sub_con st_2"><!-- sub_con -->
        <h3 class="mt_100 mb_60 mb_md_40 tit font_sc">인물도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">이달의 인물도서<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/person_lib_month_list.do" title="선택">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">이달의 인물도서</h4>
        <div class="wrap">
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="th wid_300">제목</div>
                        <div class="td">${personBookVo.title}</div>
                    </li>
                    <li class="table">
                        <div class="th wid_300">인물도서</div>
                        <div class="td">${personBookVo.person}</div>
                    </li>
                    <li class="table">
                        <div class="th wid_300">첨부파일</div>
                        <div class="td">
                            <c:forEach items="${personBookVo.fileList}" var="item" varStatus="status">
                                <c:if test="${item != null}">
                                    <a class="link_down" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a><br/>
                                </c:if>
                            </c:forEach>
                        </div>
                    </li>
                    <li class="table">
                        <div class="td wid_full content_box">${personBookVo.cont}</div>
                    </li>
                    <%--<li class="table">
                        <div class="td wid_full content_box plr_0">
                            <!--인물도서-->
                            <div class="profile_box mtb_50 mlr_50">
                                <div class="profile_img">
                                    <div class="img_box">
                                        <c:forEach items="${personBookVo.thumbFileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                    </div>
                                    <div class="text_box">
                                        <div class="date"><span><span class="fs_40 fw_600 font_roboS">${personBookVo.month}</span>월</span></div>
                                        <div class="text_wrap">
										<span class="p_book fs_22 fs_md_26 fw_600">
											<span>인물도서</span>
											<span class="fw_900 mrl_10">&middot;</span>
											<span class="tc_2">${personBookVo.person}</span>
										</span>
                                            <p class="p_text fs_34 fs_md_42 font_sc fw_800">${personBookVo.summary}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--인물도서 //-->
                        </div>
                    </li>--%>
                </ul>
            </div><!--table_box //-->

            <ul class="table_list_ul prev_next_page_box fs_18 fs_md_24">
                <c:choose>
                    <c:when test="${personBookVo.prev ne null}">
                        <li class="prev_box">
                            <a href="/ssem/youth/campus/person_lib_month_view.do?person_book_idx=${personBookVo.prev.person_book_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_prev_bk">이전</i><span class="screen_md_hide">이전글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${personBookVo.prev.title}</p></div>
                                    <div class="col wid_100 t_left">${personBookVo.prev.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(personBookVo.prev.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${personBookVo.next ne null}">
                        <li class="next_box">
                            <a href="/ssem/youth/campus/person_lib_month_view.do?person_book_idx=${personBookVo.next.person_book_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_next_bk">다음</i><span class="screen_md_hide">다음글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${personBookVo.next.title}</p></div>
                                    <div class="col wid_100 t_left">${personBookVo.next.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(personBookVo.next.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="btn_box mt_50 mb_100 pb_30 t_right t_md_center">
                <a href="/ssem/youth/campus/person_lib_month_list.do" class="btn btn_short t_center">목록</a>
            </div>
        </div>
    </div>
</div>
