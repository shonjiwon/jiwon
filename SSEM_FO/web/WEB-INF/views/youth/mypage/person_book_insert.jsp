<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '열람 신청 > 인물도서관 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("인물도서 열람신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
        });
    });

    function cancel_frm() {
        document.frm_cancel.submit();
    }

    function update_frm() {
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

        $("#frm").submit();
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
            }
        }).open();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_mypage"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    나의 송파쌤
                </h2>
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
                        <a href="#" class="deapth_tit" title="선택">인물도서관</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/youth/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/youth/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/youth/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">열람신청</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/person_book_list.do">열람신청</a></li>
                            <li><a href="/ssem/youth/mypage/person_reg_list.do">인물도서 등록 신청</a></li>
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
    <div class="sub_con st_1 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>

        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">인물도서관<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->


        <h4 class="tit2 mt_95 mb_50">인물도서관</h4>

        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_2">
                <li class="tab_item on"><a href="/ssem/youth/mypage/person_book_list.do">열람 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_reg_list.do">인물도서 등록 신청</a></li>
            </ul>
        </div><!-- mypage_tab : end -->


        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">열람 신청</h1>
                <!--2020.11.04 : s-->
                <h2 class="c_tit_2 ptb_15 clearfix">
                    <span class="dp_inb float_left">인물도서 정보</span>
                </h2>
                <form name="frm_cancel" id="frm_cancel" action="/ssem/youth/mypage/person_book_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="person_book_apy_idx" value="${personBookApyVo.person_book_apy_idx}" />
                </form>
                <!--2020.11.04 : e-->
                <form name="frm" id="frm" action="/ssem/youth/mypage/person_book_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="person_book_apy_idx" value="${personBookApyVo.person_book_apy_idx}" />
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="plc" id="plc" />
                    <input type="hidden" name="view_dt" id="view_dt" />
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">인물도서 정보의 신청 경록, 인물도서 제목, 분류, 인물도서</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300">신청경로</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${personBookApyVo.gubun eq 'N'}">인물도서</c:when>
                                        <c:when test="${personBookApyVo.gubun eq 'S'}">찾아가는 인물도서</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">인물도서 제목</th>
                                <td>
                                    ${personBookApyVo.title}
                                </td>
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
                                <td>
                                    ${personBookApyVo.person}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->

                    <!--2020.11.04 : s-->
                    <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                        <span class="dp_inb float_left">신청 정보</span>
                        <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                    </h2>
                    <!--2020.11.04 : e-->

                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">신청 정보의 신청상태, 신청자 이름, 휴대폰 번호, 신청 인원, 단체/학교명, 열람일시, 확정 일시, 열람 장소 </caption>
                            <tbody>
                            <tr>
                                <!--2020.11.04 : s-->
                                <th class="wid_300">신청상태</th>
                                <!--2020.11.04 : e-->
                                <td>
                                    <c:choose>
                                        <c:when test="${personBookApyVo.status eq 'A'}"><span class="my_tc_2">신청대기</span></c:when>
                                        <c:when test="${personBookApyVo.status eq 'P'}"><span class="my_tc_4">신청조율</span></c:when>
                                        <c:when test="${personBookApyVo.status eq 'O'}"><span class="my_tc_1">열람확정</span></c:when>
                                        <c:when test="${personBookApyVo.status eq 'C'}"><span class="my_tc_3">신청취소</span></c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">신청자 이름 </th>
                                <td>${personBookApyVo.apy_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="tc_point">*</span>휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
											<option value="">선택</option>
											<option value="010" <c:if test="${personBookApyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
											<option value="011" <c:if test="${personBookApyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
											<option value="016" <c:if test="${personBookApyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
											<option value="017" <c:if test="${personBookApyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
											<option value="019" <c:if test="${personBookApyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
										</select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${personBookApyVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${personBookApyVo.mob_3}">
									</span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span>신청 인원</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_inp mr_10"><input type="text" class="inp" name="apy_cnt" id="apy_cnt" title="인원수" placeholder="인원수" value="${personBookApyVo.apy_cnt}"></div>명
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span>단체/학교명</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_inp"><input type="text" class="inp" title="단체명" name="grp_name" id="grp_name" value="${personBookApyVo.grp_name}"></div>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span>열람 일시</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_cal full">
                                        <span class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" name="select_date" id="select_date" title="열람 일시" value="${fn:substring(personBookApyVo.view_dt, 0, 10)}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </span>
                                        <span>
                                            <span class="sel_box">
                                                <select name="select_hour_st" id="select_hour_st" title="시간">
                                                    <option value="00" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '00'}">selected="selected"</c:if>>00</option>
                                                    <option value="01" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '01'}">selected="selected"</c:if>>01</option>
                                                    <option value="02" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '02'}">selected="selected"</c:if>>02</option>
                                                    <option value="03" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '03'}">selected="selected"</c:if>>03</option>
                                                    <option value="04" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '04'}">selected="selected"</c:if>>04</option>
                                                    <option value="05" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '05'}">selected="selected"</c:if>>05</option>
                                                    <option value="06" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '06'}">selected="selected"</c:if>>06</option>
                                                    <option value="07" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '07'}">selected="selected"</c:if>>07</option>
                                                    <option value="08" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '08'}">selected="selected"</c:if>>08</option>
                                                    <option value="09" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '09'}">selected="selected"</c:if>>09</option>
                                                    <option value="10" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '10'}">selected="selected"</c:if>>10</option>
                                                    <option value="11" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '11'}">selected="selected"</c:if>>11</option>
                                                    <option value="12" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '12'}">selected="selected"</c:if>>12</option>
                                                    <option value="13" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '13'}">selected="selected"</c:if>>13</option>
                                                    <option value="14" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '14'}">selected="selected"</c:if>>14</option>
                                                    <option value="15" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '15'}">selected="selected"</c:if>>15</option>
                                                    <option value="16" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '16'}">selected="selected"</c:if>>16</option>
                                                    <option value="17" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '17'}">selected="selected"</c:if>>17</option>
                                                    <option value="18" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '18'}">selected="selected"</c:if>>18</option>
                                                    <option value="19" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '19'}">selected="selected"</c:if>>19</option>
                                                    <option value="20" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '20'}">selected="selected"</c:if>>20</option>
                                                    <option value="21" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '21'}">selected="selected"</c:if>>21</option>
                                                    <option value="22" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '22'}">selected="selected"</c:if>>22</option>
                                                    <option value="23" <c:if test="${fn:substring(personBookApyVo.view_dt, 11, 13) eq '23'}">selected="selected"</c:if>>23</option>
                                                </select>
                                            </span>
                                            <span>시</span>
                                            <span class="sel_box ml_10">
                                                <select name="select_min_st" id="select_min_st" title="분">
                                                    <option value="00" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '00'}">selected="selected"</c:if>>00</option>
                                                    <option value="10" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '10'}">selected="selected"</c:if>>10</option>
                                                    <option value="20" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '20'}">selected="selected"</c:if>>20</option>
                                                    <option value="30" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '30'}">selected="selected"</c:if>>30</option>
                                                    <option value="40" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '40'}">selected="selected"</c:if>>40</option>
                                                    <option value="50" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '50'}">selected="selected"</c:if>>50</option>
                                                    <option value="60" <c:if test="${fn:substring(personBookApyVo.view_dt, 14, 16) eq '60'}">selected="selected"</c:if>>60</option>
                                                </select>
                                            </span>
                                            <span>분</span>
                                        </span>
                                        <br class="screen_hide screen_lg_show">
                                        <span class="mt_lg_10 screen_lg_show">
                                            <span>~</span>
                                            <span class="sel_box">
                                                <select name="select_hour_et" id="select_hour_et" title="시간">
                                                    <option value="00" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '00'}">selected="selected"</c:if>>00</option>
                                                    <option value="01" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '01'}">selected="selected"</c:if>>01</option>
                                                    <option value="02" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '02'}">selected="selected"</c:if>>02</option>
                                                    <option value="03" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '03'}">selected="selected"</c:if>>03</option>
                                                    <option value="04" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '04'}">selected="selected"</c:if>>04</option>
                                                    <option value="05" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '05'}">selected="selected"</c:if>>05</option>
                                                    <option value="06" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '06'}">selected="selected"</c:if>>06</option>
                                                    <option value="07" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '07'}">selected="selected"</c:if>>07</option>
                                                    <option value="08" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '08'}">selected="selected"</c:if>>08</option>
                                                    <option value="09" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '09'}">selected="selected"</c:if>>09</option>
                                                    <option value="10" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '10'}">selected="selected"</c:if>>10</option>
                                                    <option value="11" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '11'}">selected="selected"</c:if>>11</option>
                                                    <option value="12" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '12'}">selected="selected"</c:if>>12</option>
                                                    <option value="13" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '13'}">selected="selected"</c:if>>13</option>
                                                    <option value="14" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '14'}">selected="selected"</c:if>>14</option>
                                                    <option value="15" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '15'}">selected="selected"</c:if>>15</option>
                                                    <option value="16" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '16'}">selected="selected"</c:if>>16</option>
                                                    <option value="17" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '17'}">selected="selected"</c:if>>17</option>
                                                    <option value="18" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '18'}">selected="selected"</c:if>>18</option>
                                                    <option value="19" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '19'}">selected="selected"</c:if>>19</option>
                                                    <option value="20" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '20'}">selected="selected"</c:if>>20</option>
                                                    <option value="21" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '21'}">selected="selected"</c:if>>21</option>
                                                    <option value="22" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '22'}">selected="selected"</c:if>>22</option>
                                                    <option value="23" <c:if test="${fn:substring(personBookApyVo.view_dt, 19, 21) eq '23'}">selected="selected"</c:if>>23</option>
                                                </select>
                                            </span>
                                            <span>시</span>
                                            <span class="sel_box ml_10">
                                                <select name="select_min_et" id="select_min_et" title="분">
                                                    <option value="00" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '00'}">selected="selected"</c:if>>00</option>
                                                    <option value="10" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '10'}">selected="selected"</c:if>>10</option>
                                                    <option value="20" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '20'}">selected="selected"</c:if>>20</option>
                                                    <option value="30" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '30'}">selected="selected"</c:if>>30</option>
                                                    <option value="40" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '40'}">selected="selected"</c:if>>40</option>
                                                    <option value="50" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '50'}">selected="selected"</c:if>>50</option>
                                                    <option value="60" <c:if test="${fn:substring(personBookApyVo.view_dt, 22, 24) eq '60'}">selected="selected"</c:if>>60</option>
                                                </select>
                                            </span>
                                            <span>분</span>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">확정 일시</th>
                                <td>
                                    ${fn:substring(item.confirm_dt, 0, 16)}
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span>열람 장소</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_btn">
                                        <input type="text" class="inp" title="우편번호" name="postcode" id="postcode" value="${personBookApyVo.postcode}">
                                        <a class="btn" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                    </div>
                                    <div class="fm_inp inp_full mt_10 mr_30 mr_lg_0"><input type="text" class="inp" name="addr" id="addr" title="주소" value="${personBookApyVo.addr}"></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="bg_1">
                                    <div class="fm_tf mb_20 mt_20">
                                        <textarea name="reason" id="reason">${personBookApyVo.reason}</textarea>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                        <div class="row">
                            <c:choose>
                                <c:when test="${personBookApyVo.status eq 'A'}">
                                    <div class="col_6 offset_3 offset_md_0 col_md_9">
                                        <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                        <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                                    </div>
                                    <div class="col_3 t_right">
                                        <a href="/ssem/youth/mypage/person_book_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="t_right">
                                        <a href="/ssem/youth/mypage/person_book_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div>
</div>
