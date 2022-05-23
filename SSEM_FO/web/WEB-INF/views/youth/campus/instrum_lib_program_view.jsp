<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '프로그램 신청 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
        tableInit(); //sub.js table.half pc높이 맞춤

        svsw_img_box();

        $("#btn_print").click(function(){
            window.print();
        });

        $("#btn_facebook").click(function(){
            fnFacebook(window.location.href);
        });

        $("#btn_twitter").click(function(){
            fnTwitter(window.location.href);
        });

        $("#btn_clipboard").click(function(){
            fnCopyUrlToClipboard(window.location.href);
        });

        $("#btn_apply").click(function(){
            modalMsg("신청기간이 아닙니다.", 'notice', "");
        });

        $("#btn_love").click(function(){
            var check = '${lectureVo.love_self_yn}';
            if(check === 'Y') {
                modalMsg("'좋아요'를 취소하시겠습니까?", 'yesorno', love_submit);
            } else {
                love_submit();
            }
        });
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

    function love_submit() {
        $("#frm_love").submit();
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
                        <a href="#" class="deapth_tit" title="선택">프로그램 신청</a>
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
            <a href="#" class="tab_m">프로그램 신청<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_program_list.do" title="선택">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">프로그램 신청</h4>
        <div class="wrap">
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">통합수강신청</h5>
            <div class="program_info_box">
                <div class="top clearfix mb_20 mb_md_40">
                    <div class="float_left float_md_none">
                        <div class="catalogue_box">
                            <c:forEach items="${lectureVo.array_tgt}" var="tgt" varStatus="status">
                                <span class="item">${tgt}</span>
                            </c:forEach>
                            <span class="item"> ${lectureVo.part_name}</span>
                        </div>
                        <c:choose>
                            <c:when test="${lectureVo.love_self_yn eq 'Y'}">
                                <a href="#none" class="btn like_btn" id="btn_love"><i class="icon_heart_line on" title="활성화">하트</i> <span class="count">${lectureVo.love_cnt}</span></a>
                            </c:when>
                            <c:otherwise>
                                <a href="#none" class="btn like_btn" id="btn_love"><i class="icon_heart_line" title="비활성화">하트</i> <span class="count">${lectureVo.love_cnt}</span></a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <form name="frm_love" id="frm_love" action="/ssem/youth/campus/instrum_lib_love_insert.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="lecture_idx" id="lecture_idx" value="${lectureVo.lecture_idx}"/>
                    </form>
                    <div class="float_right float_md_none fs_20 fs_md_22 t_right t_md_left mt_md_45">
                        <c:if test="${lectureVo.qty_open_yn ne 'N'}">
                            <span>신청인원 및 정원 <b> <c:out value="${lectureVo.online_qty + lectureVo.tel_qty + lectureVo.visit_qty - lectureVo.online_can_qty}" />/<c:out value="${lectureVo.online_qty + lectureVo.tel_qty + lectureVo.visit_qty}" /></b>명 (대기자 ${lectureVo.wait_qty - lectureVo.wait_can_qty}/${lectureVo.wait_qty}명)</span>
                        </c:if>
                        <!--2020.10.27 : s-->
                        <c:choose>
                            <c:when test="${fn:contains(lectureVo.reg_method, '4')}">
                                <span class="btn link_btn va_m mr_10">외부홈페이지</span>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${lectureVo.status_code eq '1'}"><span class="btn link_btn va_m mr_10">접수대기</span></c:when>
                                    <c:when test="${lectureVo.status_code eq '2'}">
                                        <c:if test="${fn:contains(lectureVo.reg_method, '1')}"><span class="btn link_btn va_m mr_10">온라인신청가능</span></c:if>
                                        <c:choose>
                                            <c:when test="${lectureVo.tel_can_qty + lectureVo.visit_can_qty eq 0}">
                                                <c:if test="${fn:contains(lectureVo.reg_method, '2') || fn:contains(lectureVo.reg_method, '3')}">
                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${lectureVo.status_code eq '3'}">
                                        <span class="btn link_btn va_m mr_10">대기신청</span>
                                        <c:choose>
                                            <c:when test="${lectureVo.tel_can_qty + lectureVo.visit_can_qty eq 0}">
                                                <c:if test="${fn:contains(lectureVo.reg_method, '2') || fn:contains(lectureVo.reg_method, '3')}">
                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${lectureVo.status_code eq '4'}">
                                        <c:if test="${fn:contains(lectureVo.reg_method, '1')}"><span class="btn link_btn va_m mr_10">온라인신청마감</span></c:if>
                                        <c:choose>
                                            <c:when test="${lectureVo.tel_can_qty + lectureVo.visit_can_qty eq 0}">
                                                <c:if test="${fn:contains(lectureVo.reg_method, '2') || fn:contains(lectureVo.reg_method, '3')}">
                                                    <span class="btn link_btn va_m mr_10">오프라인 신청마감</span>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="btn link_btn va_m mr_10">오프라인 신청</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${lectureVo.status_code eq '5'}"><span class="btn link_btn va_m mr_10">교육전</span></c:when>
                                    <c:when test="${lectureVo.status_code eq '6'}"><span class="btn link_btn va_m mr_10">교육중</span></c:when>
                                    <c:when test="${lectureVo.status_code eq '7'}"><span class="btn link_btn va_m mr_10">교육종료</span></c:when>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <!--2020.10.27 : e-->
                    </div>
                </div>
                <p class="title fs_30 fw_600">${lectureVo.name}</p>
                <ul class="row mt_40">
                    <li class="col_4 col_md_6"><span><b class="fw_400">교육기간 : </b> ${fn:substring(lectureVo.start_dt, 2, 10)} ~ ${fn:substring(lectureVo.end_dt, 2, 10)}</span></li>
                    <li class="col_4 col_md_6"><span><b class="fw_400">교육시간 : </b> ${lectureVo.dt_str} <br/>(${lectureVo.start_time} ~ ${lectureVo.end_time})</span></li>
                    <li class="col_4 col_md_6"><span><b class="fw_400">수강료 : </b><fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원</span></li>
                    <li class="col_4 col_md_6"><span><b class="fw_400">접수기간 :</b> ${fn:substring(lectureVo.reg_start_st, 2, 10)} ~ ${fn:substring(lectureVo.reg_end_dt, 2, 10)}</span></li>
                    <li class="col_4 col_md_6">
                        <span><b class="fw_400">접수방법 :</b> ${lectureVo.reg_method_str}</span>
                    </li>
                    <li class="col_4 col_md_6"><span><b class="fw_400">문의 :</b> ${lectureVo.group.tel_no}</span></li>
                </ul>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">기본정보</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table half">
                        <div class="th wid_230">교육장소</div>
                        <div class="td">${lectureVo.place.name}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">주소</div>
                        <div class="td">
                            <span class="dp_inp va_m mr_10">${lectureVo.place.addr} ${lectureVo.place.addr2}</span>
                            <!--
                                2020.10.26 : start
                                .act_popup_map_open > sub.js
                            -->
                            <a href="https://map.kakao.com/?q=${lectureVo.place.addr}" class="btn btn_color_t btn_small btn_auto screen_md_hide" target="_blank" title="새창">지도보기</a>
                            <!--2020.10.26 : end-->
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">모집인원</div>
                        <c:choose>
                            <c:when test="${lectureVo.qty_open_yn ne 'N'}">
                                <div class="td">온라인 : ${lectureVo.online_qty} 명  (온라인 대기 : ${lectureVo.wait_qty} 명) / 전화 : ${lectureVo.tel_qty}명 / 방문 : ${lectureVo.visit_qty}명</div>
                            </c:when>
                            <c:otherwise>
                                <div class="td">-</div>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">연령제한</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.age_type eq 'U'}">
                                    제한없음
                                </c:when>
                                <c:otherwise>
                                    14세이상
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="td wid_p_50 p_0 line_none_bottom">
                            <div class="table">
                                <div class="th wid_230">수강료</div>
                                <div class="td"><fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                                    <c:if test="${lectureVo.fee_detail ne '' && lectureVo.fee_detail ne null}">
                                        (${lectureVo.fee_detail})
                                    </c:if>
                                </div>
                            </div>
                            <div class="table">
                                <div class="th wid_230">결제방법</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${lectureVo.pay_type eq 'I'}">
                                            온라인결제
                                        </c:when>
                                        <c:otherwise>
                                            현장결제
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">감면대상</div>
                        <div class="td">
                            <ul class="ul_list_dash">
                                <c:forEach items="${lectureVo.array_discount}" var="discount" varStatus="status">
                                    <li>${discount.rate}% (${discount.tgt_name})</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">특이사항</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.desc_txt eq '' || lectureVo.desc_txt eq null}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    ${lectureVo.desc_txt}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">정보화교육여부</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.ict_yn eq 'Y'}">
                                    예
                                </c:when>
                                <c:otherwise>
                                    아니오
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>

                </ul>
            </div><!--table_box //-->
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">강좌정보</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="th wid_230">강사</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.teacher_idx ne null && lectureVo.teacher_idx ne ''}">
                                    <span class="dp_inb va_m mr_10">${lectureVo.teacher.name}</span>
                                    <button type="button" data-popup-id="#popup2" class="act_popup_open btn btn_color_t btn_small btn_auto" >강사이력보기</button>
                                </c:when>
                                <c:otherwise>
                                    <span class="dp_inb va_m mr_10">미정</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <li class="table">
                        <div class="th wid_230">프로그램소개</div>
                        <div class="td">${lectureVo.cont}</div>
                    </li>

                    <li class="table">
                        <div class="th wid_230">환불정책</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.refund_txt eq '' || lectureVo.refund_txt eq null}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    ${lectureVo.refund_txt}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/youth/campus/instrum_lib_program_list.do" class="btn btn_long btn_big t_center mr_15">목록</a>
                <c:choose>
                    <c:when test="${lectureVo.reg_method eq '4'}">
                        <c:if test="${lectureVo.status_code eq '2'}">
                            <a href="${lectureVo.reg_method_url}" class="btn btn_long btn_big btn_color_1 t_centermr_20" target="_blank">신청하기</a>
                        </c:if>
                    </c:when>
                    <c:when test="${lectureVo.status_code eq '1'}">
                        <a href="#none" class="btn btn_long btn_big btn_color_1 t_centermr_20" id="btn_apply">신청하기</a>
                    </c:when>
                    <c:when test="${lectureVo.status_code eq '2'}">
                        <a href="/ssem/youth/program/lecture_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn btn_long btn_big btn_color_1 t_centermr_20">신청하기</a>
                    </c:when>
                    <c:when test="${lectureVo.status_code eq '3'}">
                        <a href="/ssem/youth/program/lecture_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn btn_long btn_big btn_color_1 t_centermr_20">신청하기</a>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="popup_wrap_st3" id="popup2">
        <div class="popup_box">
            <div class="popup_top">
                <p>강사이력보기</p>
            </div>
            <div class="popup_con">
                <div class="img_box">
                    <!--img 제거 : 임시 이미지 사이즈 미정 -->
                    <c:forEach items="${lectureVo.teacher.picFileList}" var="thumb" varStatus="status">
                        <img src="${thumb.file_src}" alt="${lectureVo.teacher.alt_txt}">
                    </c:forEach>
                    <!--img 제거 : 임시 이미지 사이즈 미정 -->
                </div>
                <div class="table_box t_center mt_30">
                    <table class="st_2">
                        <caption class="text_hide">강사정보 이름, 성별, 강의만족도, 전문분야, 주요경력 안내</caption>
                        <colgroup>
                            <col width="24%">
                            <col>
                            <col width="24%">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="t_left">이름</th>
                            <td><p class="mlr_20 t_left">${lectureVo.teacher.name}</p></td>
                            <th class="t_left">성별</th>
                            <td><p class="mlr_20 t_left">
                                <c:choose>
                                    <c:when test="${lectureVo.teacher.gender eq 'M'}">
                                        남
                                    </c:when>
                                    <c:otherwise>
                                        여
                                    </c:otherwise>
                                </c:choose>
                            </p></td>
                        </tr>
                        <tr>
                            <th class="t_left">강의만족도</th>
                            <td colspan="3">
                                <p class="mlr_20 t_left">
                                    <!--
                                        <img src="/ssem/resources/img/common/gold.png" alt="금">
                                        <img src="/ssem/resources/img/common/silver.png" alt="은">
                                    -->
                                    <c:choose>
                                        <c:when test="${lectureVo.teacher.score eq '1'}">
                                            <img src="/ssem/resources/img/common/gold.png" alt="금">
                                        </c:when>
                                        <c:when test="${lectureVo.teacher.score eq '2'}">
                                            <img src="/ssem/resources/img/common/silver.png" alt="은">
                                        </c:when>
                                        <c:when test="${lectureVo.teacher.score eq '3'}">
                                            <img src="/ssem/resources/img/common/bronze.png" alt="동">
                                        </c:when>
                                        <c:otherwise>
                                            평가없음
                                        </c:otherwise>
                                    </c:choose>
                                    <br/>* 강의 만족도는 강의에 참여해 주신 교육생들의 평가 만족도 입니다.
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <th class="t_left">전문분야</th>
                            <td  colspan="3"><p class="mlr_20 t_left">${lectureVo.teacher.prof_field}</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">주요경력</th>
                            <td  colspan="3"><p class="mlr_20 t_left">${lectureVo.teacher.career}</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="popup_btn clearfix">
                <button type="button" data-popup-id="#popup2" class="btn float_right btn_short close_btn"><span class="fs_20 fs_md_26">닫기</span></button>
            </div>
            <button class="close_btn" data-popup-id="#popup2"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>
</div>
