<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 3:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '찾아가는 인물도서 > 인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">찾아가는 인물도서</a>
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
            <a href="#" class="tab_m">찾아가는 인물도서<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/person_lib_school_list.do" title="선택">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">인물도서 열람신청</h4>
        <div class="wrap">
            <div class="completion_box t_center">
                <img src="/ssem/resources/img/sub/completion_img_1.png" alt="완료">

                <h5 class="fs_30 mt_15"> 찾아가는 인물도서 <b>열람신청이 완료</b> 되었습니다.</h5>
                <p class="fs_20 mt_5">인물도서 열람신청을 신청해 주셔서 감사합니다.</p>
                <a href="/ssem/youth/mypage/person_book_list.do" class="btn mt_15">마이페이지</a>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">찾아가는 인물도서 정보</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">찾아가는 인물도서 정보의 제목, 분류, 인물도서</caption>
                    <tbody>
                    <tr>
                        <th class="wid_300">제목</th>
                        <td>${personBookApyVo.title}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">분류</th>
                        <td>
                            <c:choose>
                                <c:when test="${personBookApyVo.cate_cd eq 'J'}">진로직업</c:when>
                                <c:when test="${personBookApyVo.cate_cd eq 'C'}">문화예술</c:when>
                                <c:when test="${personBookApyVo.cate_cd eq 'H'}">인문교양</c:when>
                                <c:when test="${personBookApyVo.cate_cd eq 'P'}">인성심리</c:when>
                                <c:when test="${personBookApyVo.cate_cd eq 'E'}">전문인</c:when>
                                <c:when test="${personBookApyVo.cate_cd eq 'Z'}">기타</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">인물도서</th>
                        <td>${personBookApyVo.person}</td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->

            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">신청자 정보</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">신청자 정보의 이름, 휴대폰번호, 신청인원, 단체명, 열람희망 일시, 열람희망 장소</caption>
                    <tbody>
                    <tr>
                        <th class="wid_300">신청자 이름</th>
                        <td>${personBookApyVo.apy_name}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">휴대폰 번호</th>
                        <td>${personBookApyVo.apy_mob_no}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">신청인원</th>
                        <td>${personBookApyVo.apy_cnt}명</td>
                    </tr>
                    <tr>
                        <th class="wid_300">단체명</th>
                        <td>${personBookApyVo.grp_name}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">열람희망 일시</th>
                        <td>${personBookApyVo.view_dt}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">열람희망 장소</th>
                        <td>${personBookApyVo.plc}</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="bg_1">
                            <p class="ptb_20 fs_md_26 fw_md_400 tc_b">
                                ${personBookApyVo.reason}
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/youth/mypage/person_book_list.do"class="btn btn_long btn_big btn_color_2 t_center mr_20">열람신청 확인하기</a>
                <a href="/ssem/youth/campus/person_lib_school_list.do" class="btn btn_long btn_big t_center">확인</a>
            </div>

        </div>
    </div>
</div>
