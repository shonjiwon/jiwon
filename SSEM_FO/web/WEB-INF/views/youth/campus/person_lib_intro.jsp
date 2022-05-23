<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-22
  Time: 오후 11:04
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
        $(document).prop('title', '소개 및 이용안내 > 인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">소개 및 이용안내</a>
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
        <h3 class="mt_100 mb_60 tit font_sc">인물도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/campus/person_lib_intro.do" title="선택">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_1 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap t_center tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">인물도서관이란?</h5>
                    <p class="fs_22 fs_md_24 mt_40">“사람이 책이다”라는 개념으로 사회저명인사, 마을인재, 기업들이 <br class="srceean_hide srceean_md_show "> 송파쌤 대표 인재풀인 ‘인물도서’로 참여하여 <br class="srceean_hide srceean_md_show "> 자라나는 청소년들이 올바르게 성장할 수 있도록 돕는 멘토링 플랫폼입니다. </p>

                    <ul class="row fs_20 pt_20  pt_md_40 fs_20 fs_md_24 fw_200">
                        <li class="col_4 col_md_6">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_1_img_01.png" alt="생각"></div>
                            <div class="text_box mt_15">
                                <p>
                                    한달에 한번 송파소식 및<br>
                                    강연을 통해 명사와 만나는<br>
                                    <b class="fw_500">‘이달의 인물도서’</b>
                                </p>
                            </div>
                        </li>
                        <li class="col_4 col_md_6">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_1_img_02.png" alt="책"></div>
                            <div class="text_box mt_15">
                                <p>
                                    인물도서가 직접 학교로 찾아가<br>
                                    교육서비스를 제공하는<br>
                                    <b class="fw_500">‘찾아가는 인물도서’</b>
                                </p>
                            </div>
                        </li>
                        <li class="col_4 col_md_6 offset_md_3">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_1_img_03.png" alt="모니터"></div>
                            <div class="text_box mt_15">
                                <p>
                                    생생한 인물도서 다큐멘터리를<br>
                                    온라인으로 즐기는<br>
                                    <b class="fw_500">‘LIVE 인물도서’</b>
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <div class="wrap">
            <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
                <h1 class="c_tit_1 mt_90">인물도서관 이용안내</h1>
                <h2 class="c_tit_2 mt_25">인물도서 열람절차</h2>
                <div class="img_step_box t_center fs_22 fs_md_26">
                    <ul class="row">
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_01.png" alt="인물도서 열람신청">
                                    <p>인물도서 열람신청</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_02.png" alt="열람일시 및 장소 조율(관리자)">
                                    <p>열람일시 및 장소 조율(관리자)</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">3</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_03.png" alt="열람 확정 알림">
                                    <p>열람 확정 알림</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_04.png" alt="열람">
                                    <p>열람</p>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="row mt_90 mt_md_0">
                    <div class="col_6 col_md_12 mt_md_70">
                        <h2 class="c_tit_2">열람안내</h2>
                        <ul class="ul_list_dash mt_20">
                            <li>열람 시작 : 10분 전 도착</li>
                            <li>열람 시간 : 40분 ~ 60분</li>
                            <li>열람 인원 : 15명 이상 단체 열람 신청</li>
                            <li>열람 연장 : 인물도서와 독자 모두 동의할 때 열람시간 연장 1회 가능</li>
                            <li>열람 종료 : 열람 종료 10분 전 알림, 설문지, 후기 등 작성</li>
                        </ul>
                    </div>
                    <div class="col_6 col_md_12 mt_md_70">
                        <h2 class="c_tit_2">열람에티켓</h2>
                        <ul class="ul_list_dash mt_20">
                            <li>열람은 경청과 존중의 자세로 대화</li>
                            <li>정치적, 상업적, 종교적 목적으로 접근 불가</li>
                            <li>대화내용과 태도가 불편할 경우 누구나 대화중단을 요청할 수 있음</li>
                            <li>연락처 교환 불가</li>
                            <li>독자가 어린이일 경우에도 '경어' 사용</li>
                        </ul>
                    </div>
                </div>
            </section>
        </div>
    </div><!-- sub_con : e -->
</div>
