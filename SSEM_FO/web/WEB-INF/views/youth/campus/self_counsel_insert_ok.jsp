<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 7:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '온라인 상담예약 > 진학학습지원센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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
    <div class="sub_visual st_4"><!-- sub_visual -->
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
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">온라인 상담예약</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                            <li><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/self_counsel_insert.do">온라인 상담예약</a></li>
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
        <h3 class="mt_100 mb_60 mb_md_40 tit font_sc">진학학습지원센터</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">온라인 상담예약<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/self_counsel_insert.do" title="선택">온라인 상담예약</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">온라인 상담예약</h4>
        <div class="wrap">
            <div class="completion_box t_center">
                <img src="/ssem/resources/img/sub/completion_img_4.png" alt="완료">

                <h5 class="fs_30 mt_15">온라인 상담  <b>예약 신청이 완료</b> 되었습니다.</h5>
                <p class="fs_20 mt_5">담당자가 확인 후, 회원님의 휴대폰으로 연락 드릴 예정입니다.</p>
                <a href="/ssem/youth/mypage/online_counsel_list.do" class="btn mt_15">마이페이지</a>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">신청자 정보</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">신청자 정보의 신청자 ID, 신청자 이름, 신청자 휴대폰 번호, 희망 상담유형, 희망 상담일, 통화 가능시간, 신청자 메모</caption>
                    <tbody>
                    <tr>
                        <th class="wid_300">신청자 ID</th>
                        <td>${loginVo.user_id}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">신청자 이름</th>
                        <td>${loginVo.user_nm}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">신청자 휴대폰 번호</th>
                        <td>${selfCounselVo.apy_mob_no}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">희망 상담유형</th>
                        <td>
                            <c:choose>
                                <c:when test="${selfCounselVo.gubun eq 'J'}">진로</c:when>
                                <c:when test="${selfCounselVo.gubun eq 'S'}">자기주도학습</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">희망 상담일</th>
                        <td>${selfCounselVo.meet_dt}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">통화 가능시간</th>
                        <td>${selfCounselVo.able_phone_time}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">신청자 메모</th>
                        <td>
                            ${selfCounselVo.apy_memo}
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">개인자료업로드</th>
                        <td>
                            <c:forEach items="${selfCounselVo.fileList}" var="item" varStatus="status">
                                <c:if test="${item != null}">
                                    <a class="link_down" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/youth/main/main.do" class="btn btn_long btn_big t_center btn_color_4 mr_20">미래교육 처음으로</a>
                <a href="/ssem/youth/mypage/online_counsel_list.do" class="btn btn_long btn_big t_center">예약신청 확인하기</a>
            </div>
        </div>
    </div>
</div>
