<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '대관신청 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        uiRdCh();    //ui.js
        tableInit(); //sub.js table.half pc높이 맞춤

        svsw_img_box();

        $(document).on('click', '.btn_time', function(){
            $(this).toggleClass('on');

            if($('.btn_time.on').length > 2) {
                $(this).removeClass('on');
                modalMsg('예약시간은 최대 2시간입니다.', 'notice', '');
            } else {
                var select_val = $(this).attr('id');
                var selector = "#" + select_val.replace("btn_", "");
                var ch_val = $(selector).val();
                if(ch_val === '') {
                    $(selector).val("Y");
                } else {
                    $(selector).val("");
                }
            }
        });

        $("#btn_submit").click(function(){
            modalMsg(" 신청을 하시겠습니까?", 'yesorno', insert_frm);
        });

        $("#btn_select").click(function(){
            var searchVal = $('#resv_dt').val();
            location.href = "/ssem/youth/campus/instrum_lib_room_insert.do?rental_fty_idx=" + ${selected_fty.rental_fty_idx} + "&searchVal=" + searchVal;
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

    function insert_frm() {
        var frm = document.frm_insert;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.resv_dt, "예약날짜")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        var select_cnt = $('.btn_time.on').length;
        if(select_cnt === 0) {
            modalMsg("시간을 선택해주세요.", "notice", "");
            return;
        } else {
            $("#pay_sum").val(select_cnt * Number(${selected_fty.fee}));
        }

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm_insert").submit();
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
                        <a href="#" class="deapth_tit" title="선택">대관신청</a>
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
        <h3 class="mt_100 mb_60 mb_md_40 tit font_sc">악기도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">대관신청<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_room_list.do" title="선택">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">대관신청</h4>
        <div class="wrap">
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 pb_20">시설선택</h5>
            <div class="row_24 music_apply_box h_340"><!--music_apply_box-->
                <div class="col_9 col_md_24 music_apply_btn_box pr_30 pr_md_0">
                    <div class="music_apply">
                        <div class="img_box">
                            <c:forEach items="${selected_fty.thumbFileList}" var="thumb" varStatus="status">
                                <img src="${thumb.file_src}" alt="${item.alt_txt}">
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="col_15 col_md_24 mt_md_30">
                    <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                        <ul>
                            <li class="table half">
                                <div class="th">시설명</div>
                                <div class="td">${selected_fty.name}</div>
                            </li>
                            <li class="table half">
                                <div class="th">사이즈 (수용인원)</div>
                                <div class="td">${selected_fty.capacity}</div>
                            </li>
                            <li class="table">
                                <div class="th">이용시간</div>
                                <div class="td">${selected_fty.use_time}</div>
                            </li>
                            <li class="table">
                                <div class="th">이용내용</div>
                                <div class="td">${selected_fty.intro}</div>
                            </li>
                            <li class="table">
                                <div class="th">대관료</div>
                                <div class="td">시간당 <fmt:formatNumber value="${selected_fty.fee}" pattern="##,###"/>원</div>
                            </li>
                            <li class="table mo_full">
                                <div class="th">시설안내</div>
                                <div class="td">
                                    <p>${selected_fty.cont}</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div><!--music_apply_box//-->
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix">
                <span class="dp_inb float_left">예약날짜 및 시간 선택</span>
                <span class="dp_inb float_right fs_18 fs_md_22 fw_200"><i class="icon_info">정보</i> <span class="va_m">회색 표기된 시간은 예약불가 시간입니다</span></span>
            </h5>
            <form name="frm_insert" id="frm_insert" method="post" action="/ssem/youth/campus/instrum_lib_room_insert.do" enctype="multipart/form-data">
                <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}" />
                <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}" />
                <input type="hidden" name="rental_fty_idx" value="${selected_fty.rental_fty_idx}" />
                <input type="hidden" name="group_idx" value="${selected_fty.group_idx}" />
                <input type="hidden" name="pay_sum" id="pay_sum" />
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">예약날짜 및 시간 선택</caption>
                        <tbody>
                        <tr>
                            <th class="wid_200">날짜</th>
                            <td>
                                <div class="row">
                                    <div class="col_4 col_lg_7 col_md_12 pr_10">
                                        <div class="fm_cal full" style="max-width: none;">
                                            <div class="fm_inp fm_date mr_10" style="max-width: none;">
                                                <input type="text" class="inp" title="날짜" name="resv_dt" id="resv_dt" value="${searchVal}">
                                                <button type="button" class="fm_date_btn">
                                                    <i class="icon_cal">달력</i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col_8 col_lg_5 col_md_12">
                                        <button type="button" class="btn btn_color_5 btn_small" id="btn_select">선택</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_200 va_t">시간</th>
                            <td>
                                <c:if test="${rentalFtySdVo ne null}">
                                    <div class="time_btn_box">
                                        <button type="button" class="btn_time btn" id="btn_h9" <c:if test="${rentalFtySdVo.h9 ne 'Y'}">disabled</c:if>>9:00 ~10:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h10" <c:if test="${rentalFtySdVo.h10 ne 'Y'}">disabled</c:if>>10:00 ~11:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h11" <c:if test="${rentalFtySdVo.h11 ne 'Y'}">disabled</c:if>>11:00 ~12:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h12" <c:if test="${rentalFtySdVo.h12 ne 'Y'}">disabled</c:if>>12:00 ~13:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h13" <c:if test="${rentalFtySdVo.h13 ne 'Y'}">disabled</c:if>>13:00 ~14:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h14" <c:if test="${rentalFtySdVo.h14 ne 'Y'}">disabled</c:if>>14:00 ~15:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h15" <c:if test="${rentalFtySdVo.h15 ne 'Y'}">disabled</c:if>>15:00 ~16:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h16" <c:if test="${rentalFtySdVo.h16 ne 'Y'}">disabled</c:if>>16:00 ~17:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h17" <c:if test="${rentalFtySdVo.h17 ne 'Y'}">disabled</c:if>>17:00 ~18:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h18" <c:if test="${rentalFtySdVo.h18 ne 'Y'}">disabled</c:if>>18:00 ~19:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h19" <c:if test="${rentalFtySdVo.h19 ne 'Y'}">disabled</c:if>>19:00 ~20:00</button>
                                        <button type="button" class="btn_time btn" id="btn_h20" <c:if test="${rentalFtySdVo.h20 ne 'Y'}">disabled</c:if>>20:00 ~21:00</button>
                                        <input type="hidden" name="h9" id="h9" />
                                        <input type="hidden" name="h10" id="h10" />
                                        <input type="hidden" name="h11" id="h11" />
                                        <input type="hidden" name="h12" id="h12" />
                                        <input type="hidden" name="h13" id="h13" />
                                        <input type="hidden" name="h14" id="h14" />
                                        <input type="hidden" name="h15" id="h15" />
                                        <input type="hidden" name="h16" id="h16" />
                                        <input type="hidden" name="h17" id="h17" />
                                        <input type="hidden" name="h18" id="h18" />
                                        <input type="hidden" name="h19" id="h19" />
                                        <input type="hidden" name="h20" id="h20" />
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">신청자 정보</h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">신청자 정보의 신청자 이름, 휴대폰 번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${loginVo.user_nm}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">휴대폰 번호</th>
                            <td>
                                <div class="fm_phon">
                                <span class="sel_box" title="휴대전화 앞번호">
                                    <select name="mob_1" id="mob_1" title="전화번호 앞번호">
                                        <option value="">선택</option>
                                        <option value="010" <c:if test="${selected_fty.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${selected_fty.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${selected_fty.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${selected_fty.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${selected_fty.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                    </select>
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_2" id="mob_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4" value="${selected_fty.mob_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_3" id="mob_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4" value="${selected_fty.mob_3}">
                                </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                    <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub fw_300">
                        <li>개인정보의 수집ㆍ이용 목적  : 대관신청 및 관련 안내</li>
                        <li>수집하려는 개인정보의 항목  : 성명, 휴대폰 번호, 주소</li>
                        <li>개인정보보호법 제15조에 따라 개인정보의 수집동의를 거부할 권리가 있으나, 동의를 거절할 경우 내용을 등록할 수 없습니다.</li>
                    </ul>
                    <div>
                        <label class="fm_rd act_uiRdCh mr_20">
                            <input type="radio" name="agree_yn" id="agree_y" value="Y"><span>동의</span>
                        </label>
                        <label class="fm_rd act_uiRdCh">
                            <input type="radio" name="agree_yn" id="agree_n" value="N" checked><span>미동의</span>
                        </label>
                    </div>
                </div><!--agree_box //-->
            </form>
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="#none" class="btn btn_long btn_big btn_color_5 t_centermr_20 mr_15" id="btn_submit">대관신청</a>
            </div>
        </div>
    </div>
</div>
