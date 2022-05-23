<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '악기기증 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        uiFileBtn(); //ui.js
        uiRdCh();    //ui.js

        svsw_img_box();

        $("#btn_submit").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

            if(!fnIsValidRequired(frm.instrum_name, "악기명")){return false;}
            if(!fnIsValidRequired(frm.gubun, "악기유형")){return false;}
            if(!fnIsValidRequired(frm.pc_year, "악기구입년도")){return false;}

            $("#dnt_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

            if(frm.agree_yn.value === 'N') {
                modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
                return;
            }

            $("#frm").submit();
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
                        <a href="#" class="deapth_tit" title="선택">악기기증</a>
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
            <a href="#" class="tab_m">악기기증<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do" title="선택">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">악기기증 접수</h4>
        <form name="frm" id="frm" action="/ssem/youth/campus/instrum_lib_donate_insert.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="dnt_mob_no" id="dnt_mob_no" />
            <input type="hidden" name="dnt_id" id="dnt_id" value="${loginVo.user_id}"/>
            <div class="wrap">
                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20">회원 기본 정보</h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 이름, 휴대폰 번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">이름</th>
                            <td>${loginVo.user_nm}</td>
                            <input type="hidden" name="dnt_name" id="dnt_name" value="${loginVo.user_nm}" />
                        </tr>
                        <tr>
                            <th class="wid_300">휴대폰 번호</th>
                            <td>
                                <div class="fm_phon">
                                    <span class="sel_box" >
                                        <select id="mob_1" name="mob_1" title="휴대전화 앞번호">
                                            <option value="">선택</option>
                                            <option value="010" <c:if test="${instrumDntVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${instrumDntVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${instrumDntVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${instrumDntVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${instrumDntVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                        </select>
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
										<input type="text" class="inp" id="mob_2" name="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${instrumDntVo.mob_2}">
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									    <input type="text" class="inp" d="mob_3" name="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${instrumDntVo.mob_3}">
                                    </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22 ">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->

                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix">
                    <span class="dp_inb float_left">악기기증 접수</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">악기기증 접수 작성폼의 악기명, 악기유형, 악기구입년도, 사진등록</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기명</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" title="악기명" name="instrum_name" id="instrum_name"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기유형</th>
                            <td>
									<span class="sel_box">
										<select title="악기유형" name="gubun" id="gubun">
											<option value="">선택</option>
											<option value="A">건반악기</option>
											<option value="B">관악기</option>
											<option value="C">타악기</option>
											<option value="D">현악기</option>
											<option value="E">MIDI장비</option>
											<option value="K">국악기</option>
											<option value="Z">기타</option>
										</select>
									</span>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기구입년도</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" title="악기구입년도" name="pc_year" id="pc_year"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">사진등록</th>
                            <td>
                                <div class="fm_file_btn act_uiFileBtn">
                                    <input type="file" name="attfile" id="attfile#" multiple="multiple" accept="image/*" title="파일 첨부">
                                    <button type="button" class="btn btn_line">파일 찾기</button>
                                    <input type="text" class="inp" readonly="" title="파일 이름">
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22 ">(파일형식 : jpg, jpeg, bmp, gif, png)</span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bg_1">
                                <p class="ptb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">
                                    악기설명 및 기증사연</p>
                                <div class="fm_tf mb_20">
                                    <textarea name="cont" id="cont" title="악기설명 및 기증사연"></textarea>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->

                <div class="agree_box mt_60 fs_18 fs_md_24 fs_20"><!--agree_box-->
                    <p class="pb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub">
                        <li>개인정보의 수집ㆍ이용 목적  :  프로그램 신청 및 관련 안내</li>
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
                <div class="btn_box mt_50 mb_100 pb_30 t_center">
                    <a href="#none" type="submit" class="btn btn_long btn_big btn_color_5" id="btn_submit">악기기증 신청하기</a>
                </div>
            </div>
        </form>
    </div>
</div>
