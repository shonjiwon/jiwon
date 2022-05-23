<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '소개 및 이용안내 > 미래교육센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">소개 및 이용안내</a>
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
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/campus/future_intro.do" title="선택">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_3 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">미래교육센터란?</h5>
                    <p class="fs_22 fs_md_24 mt_40">
                        ‘미래교육센터에서는 4차산업, 미디어, 글로벌 등 <br class="screen_hide screen_md_show"> 미래교육과 관련된<br class="screen_md_hide">
                        다양한 교육프로그램을 진행하고 있습니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90 screen_md_hide">센터 조성 현황</h1>
                <div class="img_full mt_20 screen_md_hide">
                    <img src="/ssem/resources/img/sub/futureInfo_img_1.jpg" alt="미래교육센터 소개 및 이용안내 1번 2019년 미래교육센터1관 2번 2019년 미래교육센터2관 3번 2020년 미래교육센터3관 4번 2020년 미래교육센터4관 5번 2020년 미래교육센터5관 6번 2020년 미래교육센터6관 2번 2020년 미래교육센터7관">
                </div>
                <h1 class="c_tit_1 mt_90">센터별 이용안내</h1>
                <c:forEach items="${itemList}" var="item" varStatus="status">
                    <h2 class="c_tit_2 st_1 mt_25">
                        <span class="num"><span>${status.count}</span></span>
                        <span class="dp_inp va_m">${item.name}</span>
                    </h2>
                    <div class="row mt_20">
                        <div class="col_4 pr_30 col_md_12 pr_md_0">
                            <div class="row img_full row_p_10">
                                <div class="col_12">
                                    <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                        <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                    </c:forEach>
                                </div>
                                <div class="col_6 mt_20">
                                    <c:forEach items="${item.thumbSubFileList1}" var="thumb1" varStatus="status">
                                        <img src="${thumb1.file_src}" alt="${item.alt_txt1}">
                                    </c:forEach>
                                </div>
                                <div class="col_6 mt_20">
                                    <c:forEach items="${item.thumbSubFileList2}" var="thumb2" varStatus="status">
                                        <img src="${thumb2.file_src}" alt="${item.alt_txt2}">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="col_8 pl_20 col_md_12 pl_md_0 mtb_md_30">
                            <div class="table_box fs_18 fs_md_24 "><!--table_box-->
                                <table class="table">
                                    <caption class="text_hide">${item.name} 정보의 대상, 시간, 정원, 수강료, 문의, 위치, 이용안내</caption>
                                    <tbody>
                                    <tr>
                                        <th class="wid_230">프로그램</th>
                                        <td>
                                                ${item.cont}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">대상</th>
                                        <td>${item.tgt}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">시간</th>
                                        <td>${item.term_time}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">정원</th>
                                        <td>${item.capacity}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">수강료</th>
                                        <td>${item.fee}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">문의</th>
                                        <td>${item.quest}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">위치</th>
                                        <td>${item.location}</td>
                                    </tr>
                                    <tr>
                                        <th class="wid_230">이용안내</th>
                                        <td>
                                                ${item.explain}
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!--table_box //-->
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </div>
</div>
