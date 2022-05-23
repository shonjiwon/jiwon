<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-29
  Time: 오후 12:49
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
        $(document).prop('title', '미래교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        $('.magnet_close').click(function(e){
            e.preventDefault();
            $('.magnet_school_popup').fadeOut(300);
            $('#magnetBtn').focus();
        });

        <c:forEach items="${popupList}" var="popup_item" varStatus="status_item">
            openWin('popup0${status_item.count}');
        </c:forEach>
    });
</script>
<div class="contents" id="contents">
    <div class="main_top">
        <div class="main_visual"><!--mv_wrap--->
            <div class="mv">
                <!--mv_item-->
                <c:forEach items="${mainImgList}" var="banner" varStatus="status">
                    <div class="mv_item">
                        <c:choose>
                            <c:when test="${banner.link ne null}">
                                <a href="${banner.link}" <c:if test="${banner.link_tgt eq 'N'}">target="_blank"</c:if>>
                                    <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                                        <img src="${item.file_src}" alt="${banner.alt_txt}">
                                    </c:forEach>
                                    <div class="mv_text_box lh_16">
                                        <p class="mv_sub_tit fs_24 mb_15 font_mts fw_700 ml_5">Songpa Smart Education Model</p>
                                        <h3 class="mv_sub_tit fs_60 lh_12 font_sc"><span class="fw_300">세상에서 </span><span class="fw_600">가장 큰 학교 <br>송파쌤(SSEM)</span></h3>
                                        <p class="fs_26 mt_10">송파에서 나고 자라고 완성되는 창의적 인재 육성</p>
                                    </div>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                                    <img src="${item.file_src}" alt="${banner.alt_txt}">
                                </c:forEach>
                                <div class="mv_text_box lh_16">
                                    <p class="mv_sub_tit fs_24 mb_15 font_mts fw_700 ml_5">Songpa Smart Education Model</p>
                                    <h3 class="mv_sub_tit fs_60 lh_12 font_sc"><span class="fw_300">세상에서 </span><span class="fw_600">가장 큰 학교 <br>송파쌤(SSEM)</span></h3>
                                    <p class="fs_26 mt_10">송파에서 나고 자라고 완성되는 창의적 인재 육성</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </div><!--mv_wrap : e-->
        <div class="q_box_wrap">
            <button type="button" class="q_open on">퀵메뉴 열기</button>
            <div class="">
                <h1 class="fs_48 fw_100"><b class="fw_500">SSEM</b> QUICK MENU</h1>
                <div class="q_box fs_16 fs_md_24">
                    <ul>
                        <li class="q_item">
                            <a href="/ssem/youth/campus/person_lib_main.do">
                                <img src="/ssem/resources/img/main/icon_1.png" alt="인물도서관">
                                <span>인물도서관</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/youth/campus/instrum_lib_main.do">
                                <img src="/ssem/resources/img/main/icon_2.png" alt="악기도서관">
                                <span>악기도서관</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/youth/campus/future_main.do">
                                <img src="/ssem/resources/img/main/icon_3.png" alt="미래교육센터">
                                <span>미래교육센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/youth/campus/self_main.do">
                                <img src="/ssem/resources/img/main/icon_4.png" alt="진학학습지원센터">
                                <span>진학학습<br class="mo">지원센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/dream/main/dream_main.do" target="_blank">

                                <img src="/ssem/resources/img/main/icon_5.png" alt="송파진로직업 체험지원센터">
                                <span>송파진로직업<br class="mo"> 체험지원센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/songpacenter/main/main.do" target="_blank">
                                <img src="/ssem/resources/img/main/icon_6.png" alt="송파청소년센터">
                                <span>송파<br class="mo">청소년센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/machuncenter/main/main.do" target="_blank">
                                <img src="/ssem/resources/img/main/icon_7.png" alt="마천청소년센터">
                                <span>마천<br class="mo">청소년센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/jamsilcenter/main/main.do" target="_blank">
                                <img src="/ssem/resources/img/main/icon_8.png" alt="잠실청소년센터">
                                <span>잠실<br class="mo">청소년센터</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="/ssem/youth/campus/songpa_vision.do">
                                <img src="/ssem/resources/img/main/icon_9.png" alt="송파혁신교육지구">
                                <span>송파혁신<br class="mo">교육지구</span>
                            </a>
                        </li>
                        <li class="q_item">
                            <a href="http://songpakids.com/" target="_blank">
                                <img src="/ssem/resources/img/main/icon_10.png" alt="송파어린이 문화회관">
                                <span>송파어린이<br class="mo"> 문화회관</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <button type="button" class="q_close">퀵메뉴 닫기</button>
        </div>
    </div>

    <div class="program_box_wrap wrap por mt_100 mt_md_70 mt_md_60"><!--program_box_wrap slick-initialized slick-slider slick-dots-->
        <h3 class="tit"><span class="fw_200">송파쌤의 </span><br class="screen_hide screen_md_show"><span>미래교육 추천 프로그램</span></h3>
        <div class="program_box row mt_45 mt_md_30 pt_10">
            <!--program_item-->
            <!---
                program_item color class
                창의융합교육   : color_1
                인물도서관     : color_2
                창의융합교육   : color_3
                자기주도학습관  : color_4
                악기도서관     : color_5
            -->
            <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                <c:choose>
                    <c:when test="${lecture.grp_name eq '악기도서관'}"><div class="program_item color_5 col_3 col_lg_4 col_sm_6"></c:when>
                    <c:when test="${lecture.grp_name eq '마그넷스쿨'}"><div class="program_item color_3 col_3 col_lg_4 col_sm_6"></c:when>
                    <c:when test="${lecture.grp_name eq '구립송파청소년미래센터'}"><div class="program_item color_2 col_3 col_lg_4 col_sm_6"></c:when>
                    <c:when test="${lecture.grp_name eq '자기주도학습관'}"><div class="program_item color_4 col_3 col_lg_4 col_sm_6"></c:when>
                    <c:otherwise><div class="program_item color_1 col_3 col_lg_4 col_sm_6"></c:otherwise>
                </c:choose>
                    <a href="/ssem/youth/program/lecture_view.do?lecture_idx=${lecture.lecture_idx}">
                        <section>
                            <div class="pi_img_box">
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
                            <div class="pi_text_box">
                                <div class="catalogue_box">
                                    <span class="item">${lecture.grp_name}</span>
                                </div>
                                <h4 class="pi_tit">
                                    <span class="ellip_1">${lecture.name}</span>
                                    <%--<span class="icon_new"><span>N</span></span>--%>
                                </h4>
                                <p class="pi_data">
                                    <i class="icon_time_bk mr_10">시간</i><span>${fn:substring(lecture.start_dt, 0, 10)} ~ ${fn:substring(lecture.end_dt, 0, 10)}</span>
                                </p>
                            </div>
                        </section>
                    </a>
                </div>
            </c:forEach>
        </div>
        <a href="/ssem/youth/program/lecture_list.do" class="more_btn ani">+ 더보기</a>
    </div><!--program_box_wrap : e-->

    <div class="banner_box2 mt_100">
        <a href="/ssem/youth/program/lecture_list.do">
		<span class="b_wrap">
			<img src="/ssem/resources/img/main/mb_title.png" alt="통합강좌 및 프로그램 신청" class="mb_20" >
			<span class="fs_22 fs_sm_26">
				송파구 청소년 교육 통합프로그램 정보와 <br class="screen_hide screen_sm_show">수강신청을 할 수 있습니다.
			</span>
		</span>
        </a>
    </div><!--banner_box : e-->

    <div class="magnet_wrap"><!-- magnet_box -->
        <div class="wrap por">
            <div class="magnet_box tc_w t_center">
                <h3 class="tit por"><span class="fs_42 fs_md_46 fw_600">마그넷 스쿨</span><button type="button" class="info_btn" id="magnetBtn">?</button></h3>
                <div class="magnet_school_popup mt_5">
                    <h4 class="fs_34 tc_w">마그넷 스쿨</h4>
                    <p class="tit_sub fw_400 fs_20 tc_w"><b>배우고 싶던 교육이 있었나요?</b> 기다리지 말고 지금 신청해 보세요.</p>
                    <div class="grp_box fs_18">
                        <div class="line_box">
                            <div class="line1"></div>
                            <div class="line2"></div>
                        </div>
                        <div class="grp_tab mt_30">
                            <div class="grp_col">
                                <div class="grp_img_box">
                                    <div class="grp_img color_1">
                                        <i class="icon_book_w">책</i>
                                    </div>
                                    <div class="ml_20">
                                        <p class="fs_20 tc_w">학습지</p>
                                        <p>배우고싶어요</p>
                                    </div>
                                </div>
                                <div class="grp_img_box mt_60">
                                    <div class="grp_img color_2">
                                        <i class="icon_pan_w">칠판</i>
                                    </div>
                                    <div class="ml_20">
                                        <p class="fs_20 tc_w">강사</p>
                                        <p>가르치고 싶어요</p>
                                    </div>
                                </div>
                            </div>
                            <div class="grp_col t_right">
                                <div class="grp_img_2 fist">
                                    <span  class="fs_20">마그넷 스쿨</span>
                                </div>
                            </div>
                            <div class="grp_col t_right">
                                <div class="grp_img_2 color_3">
                                    <span class="fs_20">수업개설</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="#magnetBtn" class="magnet_close">닫기</a>
                </div>

                <p class="tit_sub mt_10 fw_200 fs_24 fs_md_24 wb-ka"><b>배우고 싶던 교육이 있었나요?</b> 기다리지 말고 지금 신청해 보세요.</p>
                <ul class="row magnet_list mt_60 fs_22 fs_md_26">
                    <li class="col_3 col_sm_6">
                        <div class="magnet_img">
                            <a href="https://www.songpa.go.kr/ssem/youth/magnet/study_hope_list.do"><img src="/ssem/resources/img/main/mms_img_01.jpg" alt="배우고 싶어요"></a>
                        </div>
                        <p class="mt_25">
                            배우고 싶어요
                        </p>
                    </li>
                    <li class="col_3 col_sm_6">
                        <div class="magnet_img">
                            <a href="https://www.songpa.go.kr/ssem/youth/magnet/study_hope_list.do"><img src="/ssem/resources/img/main/mms_img_02.jpg" alt="가르칠 수 있어요"></a>
                        </div>
                        <p class="mt_25">
                            가르칠 수 있어요
                        </p>
                    </li>
                    <li class="col_3 col_sm_6 mt_sm_20">
                        <div class="magnet_img">
                            <a href="https://www.songpa.go.kr/ssem/youth/magnet/study_hope_list.do"><img src="/ssem/resources/img/main/mms_img_03.jpg" alt="함께 배워요"></a>
                        </div>
                        <p class="mt_25">
                            함께 배워요
                        </p>
                    </li>
                    <li class="col_3 col_sm_6 mt_sm_20">
                        <div class="magnet_img">
                            <a href="https://www.songpa.go.kr/ssem/youth/magnet/study_share_list.do"><img src="/ssem/resources/img/main/mms_img_04.jpg" alt="배움 공유 채널"></a>
                        </div>
                        <p class="mt_25">
                            배움 공유 채널
                        </p>
                    </li>
                </ul>
                <a href="/ssem/youth/magnet/intro.do" class="more_btn ani">+ 더보기</a>
            </div>
        </div>
    </div><!-- magnet_box :e -->
    <div class="notice_wrap mt_100 mt_md_70 pb_100 pb_md_50">
        <div class="wrap por pb_70">
            <h3 class="tit"><span class="fw_200">송파쌤의 </span><span>공지사항</span></h3>
            <div class="nt pt_50 fs_24 fs_md_26">
                <c:forEach items="${noticeList}" var="notice" varStatus="status">
                    <div class="nt_item">
                        <a href="/ssem/youth/ssem/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                            <section>
                                <h4 class="nt_tit ellip_3">
                                    ${notice.title}
                                </h4>
                                <%--<div class="icon_new"><span>N</span></div>--%>
                                <p class="nt_data fs_18 fs_md_24">
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
</div>

<div class="main_popup">
<c:forEach items="${popupList}" var="popup" varStatus="popup_status">
    <div class="popup" style="z-index: 2000;" id="popup0${popup_status.count}">
        <c:choose>
            <c:when test="${popup.link_tgt eq 'C'}">
                <a href="${popup.link}">
                    <c:forEach items="${popup.fileList}" var="thumb" varStatus="status">
                        <img src="${thumb.file_src}" alt="${popup.alt_txt}"/>
                    </c:forEach>
                </a>
            </c:when>
            <c:otherwise>
                <a href="${popup.link}" target="_blank">
                    <c:forEach items="${popup.fileList}" var="thumb" varStatus="status">
                        <img src="${thumb.file_src}" alt="${popup.alt_txt}"/>
                    </c:forEach>
                </a>
            </c:otherwise>
        </c:choose>
        <div class="popup_bottom">
            <div class="row">
                <div class="col_6 t_left">
                    <button class="" onclick="closePopup('#popup0${popup_status.count}')">닫기</button>
                </div>
                <div class="col_6 t_right">
                    <button class="" onclick="closeWin('popup0${popup_status.count}', 1);">오늘하루 보지 않기</button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
</div>

