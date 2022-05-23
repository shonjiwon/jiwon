<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 7:00
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
        uiInti();       //ui.js
        subInit()       //sub.js

        svsw_img_box();

        //uiRdCh();    //ui.js

        $("#btn_submit").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

            if(!fnIsValidRequired(frm.gubun, "희망 상담유형")){return false;}
            if(!fnIsValidRequired(frm.select_date, "희망 상담일")){return false;}
            if(!fnIsValidRequired(frm.select_day_type, "희망 상담일")){return false;}
            if(!fnIsValidRequired(frm.start_time, "통화 가능시간")){return false;}
            if(!fnIsValidRequired(frm.end_time, "통화 가능시간")){return false;}

            $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
            $("#meet_dt").val(frm.select_date.value + ' / ' + frm.select_day_type.value);
            $("#able_phone_time").val(frm.start_time.value + '시 ~ ' + frm.end_time.value + '시');

            if(frm.agree_yn.value === 'N') {
                modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
                return;
            }

            $("#frm").submit();
            //modalMsg("서비스 준비중입니다.", "notice", "");
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
        <h3 class="mt_100 mb_60 tit font_sc">진학학습지원센터</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">소개 및 이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/self_counsel_insert.do" title="선택">온라인 상담예약</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">온라인 상담예약</h4>
        <section class="text_con wrap fs_20 fs_md_26  pb_100 mb_15">
            <h2 class="c_tit_2 mt_95 mb_25">상담 프로그램</h2>
                <div class="img_info_box st_b">
                    <div class="row">
                        <div class="col_6 col_md_12 plr_10">
                            <div class="sub_box por pt_40 pb_20 plr_50">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/img_info_4_img_3.png" alt="진학">
                                </div>
                                <div class="txt_box">
                                    <h4 class="txt_box_tit fw_600 tc_b mb_20">진학</h4>
                                    <ul class="ul_list_dot fs_20 fs_md_24 fw_300 tc_b">
                                        <li>진로 목표에 맞는 고등학교 유형을 알고 싶을 때</li>
                                        <li>나에게 맞는 수시 · 정시 지원전략</li>
                                        <li>도움을 받고 싶을 때</li>
                                    </ul>
                                    <p class="fs_16 fs_md_22 tc_4 fw_300">※ 상담 준비 중입니다. (추후 안내 예정)</p>
                                </div>
                            </div>
                        </div>
                        <div class="col_6 col_md_12 mt_md_20">
                            <div class="sub_box por pt_40 pb_20 plr_50">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/img_info_4_img_4.png" alt="자기주도학습">
                                </div>
                                <div class="txt_box">
                                    <h4 class="txt_box_tit fw_600 tc_b mb_20">자기주도학습</h4>
                                    <ul class="ul_list_dot fs_20 fs_md_24 fw_300 tc_b">
                                        <li>나에게 맞는 학습전략을 알고 싶을 때</li>
                                        <li>나의 자기주도학습 능력을 알고 싶을 때</li>
                                        <li>효과적인 자기주도학습 방법을 배우고,<br class="screen_lg_hide"> 시간관리를 하고 싶을 때</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_95 mb_25 ov_h">
                    상담 신청방법
                    <span class="dp_inb dp_md_b float_right fw_200 fs_18 fs_md_24 screen_md_hide">※ 검사비용 : 4,000원 (검사비용 및 납부방법은 상담과정에서 담당자가 안내 드릴 예정입니다.)</span>
                </h2>
                <div class="img_step_box t_center fs_20 fs_md_24">
                    <ul class="row">
                        <li class="col_4 col_md_6">
                            <div class="step_text_wrap jst st_b">
                                <span class="step_num">1</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_05.png" alt="상담 및 검사 예약">
                                    <p>
                                        <strong class="dp_b fs_22 fs_md_24 fw_600 fw_md_400 mb_10 mb_md_0">상담 및 검사 예약</strong>
                                        <span class="dp_b tc_sub fw_md_200 sub_txt">온라인 신청</span>
                                    </p>
                                </div>
                            </div>
                        </li>
                        <li class="col_4 col_md_6">
                            <div class="step_text_wrap jst st_b">
                                <span class="step_num">2</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_06.png" alt="상담안내">
                                    <p>
                                        <strong class="dp_b fs_22 fs_md_24 fw_600 fw_md_400 mb_10 mb_md_0">상담안내</strong>
                                        <span class="dp_b tc_sub fw_md_200 sub_txt">상담 받고 싶은 내용 확인<br> 검사 및 상담시간 약속</span>
                                    </p>
                                </div>
                            </div>
                        </li>
                        <li class="col_4 col_md_6">
                            <div class="step_text_wrap jst st_b">
                                <span class="step_num">3</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_step_04_img_07.png" alt="상담 진행">
                                    <p>
                                        <strong class="dp_b fs_22 fs_md_24 fw_600 fw_md_400 mb_10 mb_md_0">상담진행</strong>
                                        <span class="dp_b tc_sub fw_md_200 sub_txt line_2">주1회, 60분 상담</span>
                                    </p>
                                </div>
                            </div>
                        </li>
                        <li class="col_md_6 screen_hide screen_md_show">
                            <div class="step_text_wrap jst st_b st_b_2">
                                <div class="step_text_box">
                                    <p class="fs_md_24 tc_sub">
                                        <strong class="dp_b fw_400 tc_b">※ 검사비용 : 4,000원</strong>
                                        (검사비용 및 납부방법은 상담과정에서 담당자가 안내 드릴 예정입니다.)
                                    </p>
                                </div>
                            </div>
                        </li>

                    </ul>
                </div>
                <h2 class="c_tit_2 mt_95 mb_25">
                    온라인 상담 예약 신청
                    <span class="dp_inb float_right fs_18 fs_md_24 fw_400 tc_point">*필수입력</span>
                </h2>
                <form name="frm" id="frm" action="/ssem/youth/campus/self_counsel_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="meet_dt" id="meet_dt" />
                    <input type="hidden" name="able_phone_time" id="able_phone_time" />
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">온라인 상담 예약 신청의 신청자 ID , 신청자 이름, 신청자 휴대폰, 희망 상담유형, 희망 상담일, 통화 가능시간, 신청자 메모</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 ID</th>
                            <td>
                                ${loginVo.user_id}
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>
                                ${loginVo.user_nm}
                            </td>
                            <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}" />
                        </tr>
                        <tr>
                            <th class="wid_300">신청자 휴대폰</th>
                            <td>
                                <div class="fm_phon">
                                    <span class="sel_box">
                                        <select id="mob_1" name="mob_1"  title="휴대전화 앞번호">
                                            <option value="">선택</option>
                                            <option value="010" <c:if test="${selfCounselVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${selfCounselVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${selfCounselVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${selfCounselVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${selfCounselVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                        </select>
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                        <input type="text" class="inp" id="mob_2" name="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${selfCounselVo.mob_2}">
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                        <input type="text" class="inp" id="mob_3" name="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${selfCounselVo.mob_3}">
                                    </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>희망 상담유형</th>
                            <td>
                                <div class="sel_box">
                                    <select title="희망 상담유형 분류" name="gubun" id="gubun" class="placeholder">
                                        <option value="">선택</option>
                                        <option value="J">진학</option>
                                        <option value="S">학습</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>희망 상담일</th>
                            <td class="">
                                <div class="fm_cal st_2 full">
                                    <div class="fm_inp fm_date mr_10">
                                        <input type="text" class="inp" title="날짜" id="select_date" name="select_date">
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                    <div class="sel_box">
                                        <select class="placeholder" id="select_day_type" name="select_day_type"  title="오전 오후 선택">
                                            <option value="">선택</option>
                                            <option value="오전">오전</option>
                                            <option value="오후">오후</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th class="wid_300"><span class="point">*</span>통화 가능시간</th>
                            <td class="">
                                <div class="fm_cal full">
                                    <span>평일</span>
                                    <div class="sel_box ml_10">
                                        <select name="start_time" id="start_time" title="통화 가능 시작시간">
                                            <option value="09">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                        </select>
                                    </div>
                                    <span>시 <span class="screen_sm_hide">~</span> </span>
                                    <div class="sel_box ml_10">
                                        <select name="end_time" id="end_time" title="통화 가능 종료시간">
                                            <option value="09">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                        </select>
                                    </div>
                                    <span>시</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청자 메모</th>
                            <td class="" colspan="2">
                                <div class="fm_tf">
                                    <textarea id="tf2" class="act_word_cnt" name="apy_memo" id="apy_memo" onkeyup="calcWordLng(200)" data-max-word="200" title="신청자 메모" placeholder="1. 내담자정보&#13;&#10; - 학생이름&#13;&#10; - 학교&#13;&#10; - 학년&#13;&#10;2. 상담내용"></textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">개인자료 업로드</th>
                            <td colspan="2">
                                <div class="fm_file_btn st_2 act_uiFileBtn">
                                    <input type="file" name="atch_file_id" id="atch_file_id" title="개인자료 파일 첨부">
                                    <button type="button" class="btn btn_line fw_300">파일 찾기</button>
                                    <input type="text" class="inp" readonly="" title="개인자료 파일 이름">
                                </div>
                                <p class="fs_16 fs_md_20 mt_5">* 파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bg_1">
                                <ul class="ul_list_dot ptb_40 fw_400 fs_18 fs_md_24 tc_sub">
                                    <li>상담예약 신청서를 제출해 주시면, 담당자가 확인 후 송파구청 회원정보에 기재 된 회원님의 휴대폰번호로 연락을 드려 상담 예약을 진행합니다.</li>
                                    <li>원활한 상담예약 진행을 위하여, 연락가능한 휴대폰번호로 회원정보 업데이트 부탁 드립니다.</li>
                                    <li>실제 상담진행 일정은 담당자와의 협의를 통해 결정 됩니다.</li>
                                </ul>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24 fs_20"><!--agree_box-->
                    <p class="pb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub">
                        <li>개인정보의 수집ㆍ이용 목적  :  상담프로그램 관련 안내 및 예약 개설 및 관련 안내</li>
                        <li>수집하려는 개인정보의 항목  :  성명, 휴대폰 번호, 주소</li>
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
                <div class="btn_box mt_50  pb_30 t_center">
                    <a href="#none" class="btn btn_long btn_big btn_color_4 mr_15" id="btn_submit">예약 신청하기</a>
                </div>
                </form>
        </section>
    </div>
    <%--<div class="popup_wrap" id="popup1">
        <div class="popup_box" tabindex="0">
            <div class="popup_con">
                <div class="_text fs_24 fw_500 t_center">예약 신청이 완료되었습니다.</div>
                <div class="popup_btn t_center mt_40">
                    <a href="#" class="btn ok_btn btn_color_2 mr_15"><span class="fs_20">확인</span></a>
                    <button type="button" class="btn close_btn"><span class="fs_20">취소</span></button>
                </div>
            </div>
        </div>
    </div>--%>
</div>
