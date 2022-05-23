<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '배우고 싶어요 > 마그넷스쿨 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        subListlSlide1();

        $("#btn_submit").click(function(){
            modalMsg("함께 참여하기를 하시겠습니까?", 'yesorno', insert_frm);
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
    });

    function insert_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm").submit();
    }

    function popupAct(el){
        $('#popup1').fadeIn(200);

        popupOpen('#popup1', el);//common.js

        $(document).off('click',  '#popup1 .close_btn');
        $(document).on('click',  '#popup1 .close_btn',function(e){
            popupClose('#popup1'); //common.js : 닫기
        });

        $(document).off('click',  '#popup1 .ok_btn');
        $(document).on('click',  '#popup1 .ok_btn',function(e){
            popupClose('#popup1'); //common.js : 닫기
        });


        $(document).off('click',  '#popup1 #applyBtn');
        $(document).on('click',  '#popup1 #applyBtn',function(e){
            popupClose('#popup1');//common.js : 닫기
        });
    }

    function subListlSlide1(){
        var len = $('.sml > div').length;
        if( !$('.sml').hasClass('slick-slider')) {
            var html = '';

            $('.sml').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.sml').slick({
                infinite: true,
                arrows:true,
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next2.png' alt='다음'> </ button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev2.png' alt='이전'> </ button>",
                appendArrows:	$('.sml + ._control'),
                appendDots : $('.sml + ._control'),
                dots: false,
                slidesToShow: 4,
                slidesToScroll: 4,
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1660,
                        settings: {
                            arrows:false,
                            dots:true,
                        }
                    },
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            dots:true,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 1024,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 767,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 3,
                        }
                    }
                ]
            });
        }
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_7"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    마그넷스쿨
                </h2>

                <p class="tit_sub">
                    <strong>“마그넷스쿨 이란?”</strong>
                    송파마그넷 스쿨은 학습자가 원하는 강좌를 신청하면 <br class="screen_hide screen_sm_show"> 강사 학습자 학습공간을 연결해주는 학교로 자석처럼 학생을<br>
                    끌어당기는 맞춤교육입니다. 배우고 싶던 교육이 있으셨나요? <br class="screen_hide screen_sm_show"> 기다리지 말고 지금 신청해보세요.
                </p>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">마그넷스쿨</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">배우고 싶어요</a>
                        <ul>
                            <li><a href="/ssem/senior/magnet/intro.do">이용안내</a></li>
                            <li><a href="/ssem/senior/magnet/study_hope_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/senior/magnet/study_share_list.do">배움 공유채널</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">마그넷스쿨</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">배우고 싶어요<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_3"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/magnet/intro.do">이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/senior/magnet/study_hope_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/magnet/study_share_list.do">배움 공유채널</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">배우고 싶어요</h4>
        <section>
        <div class="wrap">
            <div class="clearfix_after mb_20">
                <ul class="program_btn_box">
                    <li>
                        <button type="button" class="act_share_btn"><i class="icon_share">공유</i></button>
                        <ul class="share_box">
                            <li><button type="button" id="btn_facebook"><i class="icon_facebook">페이스북</i></button></li>
                            <li><button type="button" id="btn_twitter"><i class="icon_twitter">트위터</i></button></li>
                            <li><button type="button" id="btn_clipboard"><i class="icon_URL">url</i></button></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="td">
                            <div class="ptb_30 ptb_md_10">
                                <c:if test="${hopeStudyVo.select_yn eq 'Y'}">
                                    <span class="view_mark mr_10">청원성공</span>
                                </c:if>
                                <span class="dip_inb va_m fs_24 fs_md_30 fw_500 fw_md_600 tc_b">${hopeStudyVo.name}</span>
                            </div>
                        </div>
                    </li>
                    <li class="table">
                        <div class="td">
                            <div class="clearfix tc_b magnet_st">
                                <div class="fs_20 fs_md_26 dip_inb float_left">
                                    <span class="view_mark st_line mr_10">
                                        <c:choose>
                                            <c:when test="${hopeStudyVo.close_yn eq 'Y'}">
                                                종료
                                            </c:when>
                                            <c:otherwise>
                                                진행중
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <b class="dip_inb mr_20">청원기간</b>
                                    <span class="tc_sub">${fn:substring(hopeStudyVo.reg_dt, 0, 10)} ~ ${hopeStudyVo.close_dt}</span>
                                </div>
                                <ul class="info_list mt_5 float_right">
                                    <!--2020.11.09:s-->
                                    <li><b>작성자</b>${hopeStudyVo.apy_name}</li>
                                    <!--2020.11.09:e-->
                                    <li><b>등록일</b>${fn:substring(hopeStudyVo.reg_dt, 0, 10)}</li>
                                    <li><b>조회수</b>${hopeStudyVo.cnt}</li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <c:if test="${hopeStudyVo.select_yn eq 'Y'}">
                    <li class="table">
                        <div class="td line_none_bottom wid_full">
                            <div class="magnet_view_info mtb_30"> <!--magnet_view_info-->
                                <div class="mvi_wrap">
                                    <div class="row_15">
                                        <div class="img_box col_5 col_sm_6">
                                            <div class="img_wrap">
                                                <img src="/ssem/resources/img/sample/sample_img_12.jpg" alt="샘플이미지 1">
                                            </div>
                                        </div>
                                        <div class="text_box col_10 col_sm_6 fs_20 fs_md_24">
                                            <div class="text_top line_top">
                                                <span class="view_mark mr_10">청원성공</span>
                                                <c:forEach items="${lectureVo.array_tgt}" var="tgt" varStatus="status">
                                                    <span class="view_mark st_line">${tgt}</span>
                                                </c:forEach>
                                            </div>
                                            <div class="text_con mt_20">
                                                <div class="clearfix">
                                                    <div class="title fs_26 fs_md_28 va_m fs_24 fw_500 tc_b float_left">${lectureVo.name}</div>
                                                    <a href="/ssem/senior/program/lecture_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn btn_color_1 btn_small float_right">바로가기</a>
                                                </div>
                                            </div>
                                            <div class="text_bottom mt_40 mt_md_0">
                                                <ul class="fs_18 fs_md_24">
                                                    <li class="mr_40"><b class="tc_b fw_400">접수기간 : </b> ${fn:substring(lectureVo.reg_start_st, 0, 10)} ~ ${fn:substring(lectureVo.reg_end_dt, 0, 10)}</li>
                                                    <li><b class="tc_b fw_400">교육기간 : </b> ${fn:substring(lectureVo.start_dt, 0, 10)} ~ ${fn:substring(lectureVo.end_dt, 0, 10)} <span>(${lectureVo.dt_str} ${lectureVo.start_time} ~ ${lectureVo.end_time})</span></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--magnet_view_info :e -->
                        </div>
                    </li>
                    </c:if>
                    <li class="table">
                        <div class="td wid_full content_box">
                            ${hopeStudyVo.cont}
                        </div>
                    </li>
                    <li class="table bg_color_2">
                        <div class="td">
                            <div class="ptb_30 mr_20 clearfix">
                                <p class="fs_26 fs_md_32 fw_500 tc_b float_left">원하시는 강의인가요?  <br class="screen_hide screen_md_show"> 함께 참여해 주세요.</p>
                                <button type="button" onclick="popupAct(this)"  class="btn btn_color_1 btn_small float_right mt_md_10">함께 참여하기</button></div>
                            <div class="bg_color_1 tc_b ptb_30 plr_30 mr_20 mb_30">
                                <p class="fs_24 fs_md_28">
                                    지금 ${fn:length(joinList)}명의 구민이 함께 참여 중입니다.
                                </p>
                                <div class="fs_18 fs_md_26 mt_20">
                                    <ul class=" user_img_list">
                                        <c:forEach items="${joinList}" var="join" varStatus="status">
                                            <li>
                                                <span class="img_box">&nbsp;</span>
                                                <span>${join.apy_id}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="table bg_color_2">
                        <div class="td">
                            <div class="pt_30 pb_20 mr_20 clearfix">
                                <p class="fs_26 fs_md_32 fw_500 tc_b float_left">강사로 활동 가능한 강의인가요?  <br class="screen_hide screen_md_show"> 지원해 주세요.</p>
                                <a href="/ssem/senior/magnet/teach_can_insert.do?hope_study_idx=${hopeStudyVo.hope_study_idx}" class="btn btn_auto btn_color_1 btn_small float_right mt_md_10">가르칠 수 있어요</a>
                            </div>
                            <p class="fs_20 fs_md_26 mb_30 mr_20">
                                송파구는 역량 있는 숨은 인재를 발굴하고 송파구와 함께하는 전문 강사로 위촉하고자 합니다.<br>
                                “배우고 싶어요”에 해당하는 강의 진행이 가능하신가요? 강사 신청해주세요. 담당자 검토 후 연락드립니다.
                            </p>
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 fs_20 t_right t_md_center">
                <a href="/ssem/senior/magnet/study_hope_list.do" class="btn btn_short fs_auto t_center">목록</a>
            </div>
        </div>
        </section>
        <!--팝업-->
        <div class="popup_wrap_st2" id="popup1">
            <div class="popup_box">
                <div class="popup_con">
                    <p class="t_center fs_24 fw_500">많은 분들이 같이 참여하시면 강좌가 개설 될 수 있습니다.</p>
                    <form name="frm" id="frm" action="/ssem/senior/magnet/study_hope_join_insert.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                        <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}" />
                        <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}" />
                        <input type="hidden" name="postcode" id="postcode" value="${loginVo.zip}" />
                        <input type="hidden" name="apy_addr1" id="apy_addr1" value="${loginVo.adres}" />
                        <input type="hidden" name="apy_addr2" id="apy_addr2" value="${loginVo.detail_adres}" />
                        <input type="hidden" name="hope_study_idx" id="hope_study_idx" value="${hopeStudyVo.hope_study_idx}"/>
                    <div class="table_box fs_18 fs_md_24 mt_60"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">회원 기본 정보의 이름, 휴대폰 번호</caption>
                            <colgroup>
                                <col width="25%">
                                <col width="75%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>이름</th>
                                <td>${loginVo.user_nm}</td>
                            </tr>
                            <tr>
                                <th class="line_none_bottom">휴대폰 번호</th>
                                <td class="line_none_bottom">
                                    <div class="fm_phon">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
											<option value="">선택</option>
											<option value="010" <c:if test="${hopeStudyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${hopeStudyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${hopeStudyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${hopeStudyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${hopeStudyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
										</select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${hopeStudyVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${hopeStudyVo.mob_3}">
									</span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22 ">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="agree_box "><!--agree_box-->
                        <p class="pb_20 fw_500 fs_20 fs_md_26 fs_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                        <ul class="ul_list_dot fs_18 fs_md_24  mb_20 tc_sub">
                            <li>개인정보의 수집ㆍ이용 목적  :  배우고 싶어요 신청 및 관련 안내</li>
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
                    </form>
                    <div class="popup_btn mtb_50 fs_20">
                        <button type="button" class="btn btn_long btn_color_1 fs_auto" id="btn_submit">함께 참여하기</button>
                    </div>
                </div>
                <button type="button" class="close_btn"><i class="icon_close_bk">닫기</i></button>
            </div>
        </div>
        <!--팝업 : e-->
    </div>
</div>
