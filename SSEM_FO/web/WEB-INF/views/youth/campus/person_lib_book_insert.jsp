<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 3:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '인물도서 목록 > 인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        uiRdCh();    //ui.js
        svsw_img_box();

        $("#btn_submit").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

            if(!fnIsValidRequired(frm.apy_cnt, "신청 인원")){return false;}
            if(!fnIsValidRequired(frm.grp_name, "단체명")){return false;}
            if(!fnIsValidRequired(frm.select_date, "열람 일시")){return false;}

            if(!fnIsValidRequired(frm.postcode, "열람 장소")){return false;}
            if(!fnIsValidRequired(frm.addr, "열람 장소")){return false;}

            $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
            $("#plc").val('(' +  frm.postcode.value + ') ' + frm.addr.value);
            $("#view_dt").val(frm.select_date.value + ' ' + frm.select_hour_st.value + ':' + frm.select_min_st.value + " ~ " + frm.select_hour_et.value + ':' + frm.select_min_et.value);

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
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullRoadAddr;
                //document.getElementById('addr_dtl').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                /*  if(data.autoRoadAddress) {
                     //예상되는 도로명 주소에 조합형 주소를 추가한다.
                     var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                     document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                 } else if(data.autoJibunAddress) {
                     var expJibunAddr = data.autoJibunAddress;
                     document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                 } else {
                     document.getElementById('guide').innerHTML = '';
                 } */
            }
        }).open();
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
                        <a href="#" class="deapth_tit" title="선택">인물도서 목록</a>
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
            <a href="#" class="tab_m">인물도서 목록<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/person_lib_book_list.do" title="선택">인물도서 목록</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">인물도서 열람신청</h4>
            <form name="frm" id="frm" action="/ssem/youth/campus/person_lib_book_insert.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="person_book_idx" id="person_book_idx" value="${personBookVo.person_book_idx}" />
                <input type="hidden" name="gubun" id="gubun" value="N" />
                <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                <input type="hidden" name="plc" id="plc" />
                <input type="hidden" name="status" id="status" value="A"/>
                <input type="hidden" name="view_dt" id="view_dt" />
            <div class="wrap">
                <h5 class="fs_24 fs_md_30 fw_600 fw_md_500 ptb_20">인물도서 정보</h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">인물도서 정보의 제목, 분류 인물도서</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">제목</th>
                            <td>${personBookVo.title}</td>
                            <input type="hidden" name="title" id="title" value="${personBookVo.title}" />
                        </tr>
                        <tr>
                            <th class="wid_300">분류</th>
                            <td>
                                <c:choose>
                                    <c:when test="${personBookVo.cate_cd eq 'J'}">진로직업</c:when>
                                    <c:when test="${personBookVo.cate_cd eq 'C'}">문화예술</c:when>
                                    <c:when test="${personBookVo.cate_cd eq 'H'}">인문교양</c:when>
                                    <c:when test="${personBookVo.cate_cd eq 'P'}">인성심리</c:when>
                                    <c:when test="${personBookVo.cate_cd eq 'E'}">전문인</c:when>
                                    <c:when test="${personBookVo.cate_cd eq 'Z'}">기타</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                                <input type="hidden" name="cate_cd" id="cate_cd" value="${personBookVo.cate_cd}" />
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">인물도서</th>
                            <td>${personBookVo.person}</td>
                            <input type="hidden" name="person" id="person" value="${personBookVo.person}" />
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <h5 class="fs_24 fs_md_30 fw_600 fw_md_500 ptb_20 mt_20 clearfix">
                    <span class="dp_inb float_left">인물도서 신청</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">인물도서 신청 작성의 이름, 휴대전화번호, 신청인원, 신청기관(단체명), 열람희망일시, 열람희망 장소</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${loginVo.user_nm}</td>
                            <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}" />
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                            <td>
                                <div class="fm_phon">
										<span class="sel_box">
											<select id="mob_1" name="mob_1"  title="휴대전화 앞번호">
												<option value="">선택</option>
												<option value="010" <c:if test="${personBookVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
												<option value="011" <c:if test="${personBookVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
												<option value="016" <c:if test="${personBookVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
												<option value="017" <c:if test="${personBookVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
												<option value="019" <c:if test="${personBookVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
											</select>
										</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									    <input type="text" class="inp" id="mob_2" name="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${personBookVo.mob_2}">
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									    <input type="text" class="inp" d="mob_3" name="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${personBookVo.mob_3}">
                                    </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>신청 인원</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="apy_cnt" id="apy_cnt" title="인원수" placeholder="인원수"></div>명
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>신청기관(단체)명</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="grp_name" id="grp_name" title="단체명"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>열람희망 일시</th>
                            <td>
                                <div class="fm_cal full">
                                    <span class="fm_inp fm_date mr_10">
                                        <input type="text" class="inp" name="select_date" id="select_date" title="열람희망 일시">
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </span>
                                    <span>
                                        <span class="sel_box">
                                            <select name="select_hour_st" id="select_hour_st" title="시간">
                                                <option value="00">00</option>
                                                <option value="01">01</option>
                                                <option value="02">02</option>
                                                <option value="03">03</option>
                                                <option value="04">04</option>
                                                <option value="05">05</option>
                                                <option value="06">06</option>
                                                <option value="07">07</option>
                                                <option value="08">08</option>
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
                                                <option value="19">19</option>
                                                <option value="20">20</option>
                                                <option value="21">21</option>
                                                <option value="22">22</option>
                                                <option value="23">23</option>
                                            </select>
                                        </span>
                                        <span>시</span>
                                        <span class="sel_box ml_10">
                                            <select name="select_min_st" id="select_min_st" title="분">
                                                <option value="00">00</option>
                                                <option value="01">10</option>
                                                <option value="02">20</option>
                                                <option value="03">30</option>
                                                <option value="04">40</option>
                                                <option value="05">50</option>
                                                <option value="06">60</option>
                                            </select>
                                        </span>
                                        <span>분</span>
                                    </span>
                                    <br class="screen_hide screen_lg_show">
                                    <span class="mt_lg_10 screen_lg_show">
                                        <span>~</span>
                                        <span class="sel_box">
                                            <select name="select_hour_et" id="select_hour_et" title="시간">
                                                <option value="00">00</option>
                                                <option value="01">01</option>
                                                <option value="02">02</option>
                                                <option value="03">03</option>
                                                <option value="04">04</option>
                                                <option value="05">05</option>
                                                <option value="06">06</option>
                                                <option value="07">07</option>
                                                <option value="08">08</option>
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
                                                <option value="19">19</option>
                                                <option value="20">20</option>
                                                <option value="21">21</option>
                                                <option value="22">22</option>
                                                <option value="23">23</option>
                                            </select>
                                        </span>
                                        <span>시</span>
                                        <span class="sel_box ml_10">
                                            <select name="select_min_et" id="select_min_et" title="분">
                                                <option value="00">00</option>
                                                <option value="01">10</option>
                                                <option value="02">20</option>
                                                <option value="03">30</option>
                                                <option value="04">40</option>
                                                <option value="05">50</option>
                                                <option value="06">60</option>
                                            </select>
                                        </span>
                                        <span>분</span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>열람희망 장소</th>
                            <td>
                                <div class="fm_btn">
                                    <input type="text" class="inp" title="주소" name="postcode" id="postcode">
                                    <a class="btn" tpye="button" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                </div>
                                <div class="fm_inp inp_full mt_10"><input type="text" class="inp" title="주소2" name="addr" id="addr"></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bg_1">
                                <p class="ptb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">
                                    인물도서 열람을 신청한 이유와 질문을 자세히 적어 주세요.<br class="screen_hide screen_md_show">
                                    소통의 질 향상에 도움이 됩니다.</p>
                                <div class="fm_tf mb_20">
                                    <textarea name="reason" id="reason"  title="인물도서 열람을 신청한 이유와 질문"></textarea>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24 fs_20"><!--agree_box-->
                    <p class="pb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub">
                        <li>개인정보의 수집ㆍ이용 목적  :  인물도서 열람신청 및 관련 안내</li>
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
                <p class="tc_point fs_18 fs_md_24 fw_md_200 mt_30">
                    인물도서는 독자와 소통을 위해 내용을 준비하는 자원봉사자입니다.<br>열람 일정에 차질이 없도록 반드시 참석해 주시기 바랍니다.
                </p>
                <div class="btn_box mt_50 mb_100 pb_30 t_center">
                    <a href="#none" class="btn btn_long btn_big btn_color_2 t_centermr_20 mr_15" id="btn_submit">인물도서 열람 신청하기</a>
                    <a href="/ssem/youth/campus/person_lib_book_view.do?person_book_idx=${personBookVo.person_book_idx}" class="btn btn_long btn_big t_center">취소하기</a>
                </div>
            </div>
            </form>
    </div>
</div>
