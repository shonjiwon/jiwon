<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 6:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '악기대여 > 악기도서관 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js
        uiInti();     //ui.js
        subInit();    //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_print").click(function(){
            window.print();
        });

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("악기대여 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
        });

        $("#mail_domain").change(function() {
            var mail_domain = $(this).val();
            if(mail_domain === '') {
                $('#mail_domain_txt').removeAttr("disabled");
                $('#mail_domain_txt').focus();
            } else {
                $('#mail_domain_txt').val('');
                $('#mail_domain_txt').attr("disabled", true);
            }
        });

        $(document).on('change', '#rental_month_1', function(){
            if($(this).is(':checked')){
                if($('#rental_start_dt').val() === '') {
                    $('#rental_start_dt').val(fnGetToday());
                    $('#rental_end_dt').val(fnGetDateMinusMonth(1));
                    $('#return_due_dt').val(fnGetDateMinusMonth(1));

                    $('#return_date').text(fnGetDateMinusMonth(1));

                } else {
                    $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));
                    $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));

                    $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));
                }
            }
        });

        $(document).on('change', '#rental_month_2', function(){
            if($(this).is(':checked')){

                if($('#rental_start_dt').val() === '') {
                    $('#rental_start_dt').val(fnGetToday());
                    $('#rental_end_dt').val(fnGetDateMinusMonth(2));
                    $('#return_due_dt').val(fnGetDateMinusMonth(2));

                    $('#return_date').text(fnGetDateMinusMonth(2));

                } else {
                    $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));
                    $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));

                    $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));
                }
            }
        });

        $(document).on('change', '#rental_month_3', function(){
            if($(this).is(':checked')){
                if($('#rental_start_dt').val() === '') {
                    $('#rental_start_dt').val(fnGetToday());
                    $('#rental_end_dt').val(fnGetDateMinusMonth(3));
                    $('#return_due_dt').val(fnGetDateMinusMonth(3));

                    $('#return_date').text(fnGetDateMinusMonth(3));

                } else {
                    $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));
                    $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));

                    $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));
                }
            }
        });

        $(document).on('change', '#rental_start_dt', function(){
            var radio_val = $('input[name="rental_month"]:checked').val();
            if(radio_val === '1') {
                $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));
                $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));
                $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 1));
            } else if(radio_val === '2') {
                $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));
                $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));
                $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 2));
            } else if(radio_val === '3') {
                $('#rental_end_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));
                $('#return_due_dt').val(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));
                $('#return_date').text(fnGetDateMinusMonthEx($('#rental_start_dt').val(), 3));
            }
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

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        if(frm.tel_1.value !== '' &&  frm.tel_2.value !== '' && frm.tel_3.value !== '') {
            $("#apy_tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);
        }

        if(!fnIsValidRequired(frm.mail_id, "이메일 게정")){return false;}
        if(frm.mail_domain.value === "") {
            if(!fnIsValidRequired(frm.mail_domain_txt, "이메일도메인")){return false;}
        }

        var email = frm.mail_id.value + "@" + frm.mail_domain_txt.value;
        if(!fnIsEmailAddr(email)) {
            modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
            return false;
        }
        $("#apy_email").val(email);

        if(!fnIsValidRequired(frm.postcode, "주소")){return false;}
        if(!fnIsValidRequired(frm.addr, "주소")){return false;}
        $("#apy_addr").val('(' +  frm.postcode.value + ') ' + frm.addr.value);

        if(!fnIsValidRequired(frm.purpose, "대여목적")){return false;}

        if(!fnIsValidRequired(frm.rental_start_dt, "대여시작일자")){return false;}
        if(!fnIsValidRequired(frm.rental_end_dt, "대여종료일자")){return false;}

        var qty = $("#rental_qty").val();
        var qty_diff = ${instrumApyVo.qty_diff};

        qty_diff = Number(qty_diff);
        qty = Number(qty);
        qty_diff = qty - qty_diff;

        if(qty_diff > ${instrumApyVo.instrumVo.qty - instrumApyVo.instrumVo.rental_qty}) {
            modalMsg("신청수량이 남은수량보다 많습니다.", 'notice', '');
            return false;
        } else if(qty === 0) {
            modalMsg("신청수량 입력해 주세요.", 'notice', '');
            return false;
        }
        $("#rental_qty").val(qty);
        $("#qty_diff").val(qty_diff);

        // 결제금액 계산
        var pay = Number(frm.rental_month.value) * Number(${instrumApyVo.instrumVo.fee}) * qty;
        $("#pay").val(pay);

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
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/senior/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/senior/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/senior/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/senior/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">악기대여</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
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
    <div class="sub_con st_5 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">악기도서관<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">악기도서관</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item on"><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">악기대여</h1>
                <h2 class="c_tit_2 ptb_15 clearfix">
                    <span class="dp_inb float_left">악기정보</span>
                </h2>
                <div class="table_box_ul music_table_img_box st_mypage fs_18 fs_md_24"><!--table_box-->
                    <div class="row_15">
                        <div class="col_4 col_lg_6 col_md_15 ">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sample/mp_sample_img_09.jpg" alt="샘플이미지">
                            </div>
                        </div>
                        <div class="col_11 col_lg_9 col_md_15 mti_border_top">
                            <ul>
                                <li class="table">
                                    <div class="th wid_300">악기유형</div>
                                    <div class="td">
                                        <c:choose>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'A'}">건반악기</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'B'}">관악기</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'C'}">타악기</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'D'}">현악기</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'E'}">MIDI장비</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'K'}">국악기</c:when>
                                            <c:when test="${instrumApyVo.instrum_gubun eq 'Z'}">기타</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                                <li class="table">
                                    <div class="th wid_300">악기명</div>
                                    <div class="td">${instrumApyVo.instrum_name}</div>
                                </li>
                                <li class="table">
                                    <div class="th wid_300">대여료</div>
                                    <div class="td"><fmt:formatNumber value="${instrumApyVo.instrum_fee}" pattern="##,###"/>원/월</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div><!--table_box //-->
                <form name="frm_cancel" id="frm_cancel" action="/ssem/senior/mypage/instrum_rental_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="instrum_apy_idx" value="${instrumApyVo.instrum_apy_idx}" />
                    <input type="hidden" name="instrum_idx" value="${instrumApyVo.instrumVo.instrum_idx}" />
                    <input type="hidden" name="rental_qty" value="${instrumApyVo.rental_qty}" />
                </form>

                <form name="frm" id="frm" action="/ssem/senior/mypage/instrum_rental_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="instrum_apy_idx" value="${instrumApyVo.instrum_apy_idx}" />
                    <input type="hidden" name="instrum_idx" value="${instrumApyVo.instrumVo.instrum_idx}" />
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="apy_addr" id="apy_addr" />
                    <input type="hidden" name="apy_tel_no" id="apy_tel_no" />
                    <input type="hidden" name="apy_email" id="apy_email" />
                    <input type="hidden" name="apy_parent_mob_no" id="apy_parent_mob_no" />
                    <input type="hidden" name="return_due_dt" id="return_due_dt" value="${instrumApyVo.return_due_dt}"/>
                    <input type="hidden" name="pay" id="pay" />
                    <input type="hidden" name="qty_diff" id="qty_diff" />
                <h2 class="c_tit_2 ptb_15 mt_50">회원 기본 정보</h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                        <tbody>
                            <tr>
                                <th class="wid_300">신청자 이름</th>
                                <td>${loginVo.user_nm}</td>
                            </tr>
                            <tr>
                                <th class="wid_300">휴대전화 번호</th>
                                <td>
                                    <div class="fm_phon">
                                    <span class="sel_box" title="휴대전화 앞번호">
                                        <select name="mob_1" id="mob_1" title="휴대전화 앞번호">
                                            <option value="">선택</option>
                                            <option value="010" <c:if test="${instrumApyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
											<option value="011" <c:if test="${instrumApyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
											<option value="016" <c:if test="${instrumApyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
											<option value="017" <c:if test="${instrumApyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
											<option value="019" <c:if test="${instrumApyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                        </select>
                                    </span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
                                        <input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${instrumApyVo.mob_2}">
                                    </span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
                                        <input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${instrumApyVo.mob_3}">
                                    </span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <!--2020.11.04:s-->
                <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                    <span class="dp_inb float_left">신청 정보</span>
                    <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                </h2>
                <!--2020.11.04:e-->
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">악기대여 신청정보의 신청상태, 구분, 단체명, 전화번호, 이메일, 주소, 인원, 대여목적, 부모이름, 부모연락처, 대여수량, 대여기간, 결제금액, 반납일정, 신청일</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${instrumApyVo.status eq 'A'}"><span class="my_tc_2">신청</span></c:when>
                                    <c:when test="${instrumApyVo.status eq 'R'}"><span class="my_tc_3">신청취소</span></c:when>
                                    <c:when test="${instrumApyVo.status eq 'O'}"><span class="my_tc_4">승인</span></c:when>
                                    <c:when test="${instrumApyVo.status eq 'C'}"><span class="my_tc_1">승인취소</span></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        <tr>
                            <th class="wid_300">구분</th>
                            <td>
                                <c:choose>
                                    <c:when test="${instrumApyVo.gubun eq 'P'}">개인</c:when>
                                    <c:when test="${instrumApyVo.gubun eq 'G'}">단체</c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <c:if test="${instrumApyVo.gubun eq 'G'}">
                        <tr>
                            <th class="wid_300">단체명</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="grp_name" id="grp_name" title="단체명" value="${instrumApyVo.grp_name}"></div>
                            </td>
                        </tr>
                        </c:if>
                        <tr>
                            <th class="wid_300">전화번호</th>
                            <td>
                                <div class="fm_phon">
                                <span class="sel_box" title="전화번호 앞번호">
                                    <select name="tel_1" id="tel_1" title="전화번호 앞번호">
                                        <option value="">선택</option>
                                        <option value="02" <c:if test="${instrumApyVo.tel_1 eq '02'}">selected="selected"</c:if>>02</option>
											<option value="031" <c:if test="${instrumApyVo.tel_1 eq '031'}">selected="selected"</c:if>>031</option>
											<option value="032" <c:if test="${instrumApyVo.tel_1 eq '032'}">selected="selected"</c:if>>032</option>
											<option value="033" <c:if test="${instrumApyVo.tel_1 eq '033'}">selected="selected"</c:if>>033</option>
											<option value="041" <c:if test="${instrumApyVo.tel_1 eq '041'}">selected="selected"</c:if>>041</option>
											<option value="043" <c:if test="${instrumApyVo.tel_1 eq '043'}">selected="selected"</c:if>>043</option>
											<option value="042" <c:if test="${instrumApyVo.tel_1 eq '042'}">selected="selected"</c:if>>042</option>
											<option value="044" <c:if test="${instrumApyVo.tel_1 eq '044'}">selected="selected"</c:if>>044</option>
											<option value="051" <c:if test="${instrumApyVo.tel_1 eq '051'}">selected="selected"</c:if>>051</option>
											<option value="052" <c:if test="${instrumApyVo.tel_1 eq '052'}">selected="selected"</c:if>>052</option>
											<option value="053" <c:if test="${instrumApyVo.tel_1 eq '053'}">selected="selected"</c:if>>053</option>
											<option value="054" <c:if test="${instrumApyVo.tel_1 eq '054'}">selected="selected"</c:if>>054</option>
											<option value="055" <c:if test="${instrumApyVo.tel_1 eq '055'}">selected="selected"</c:if>>055</option>
											<option value="061" <c:if test="${instrumApyVo.tel_1 eq '061'}">selected="selected"</c:if>>061</option>
											<option value="062" <c:if test="${instrumApyVo.tel_1 eq '062'}">selected="selected"</c:if>>062</option>
											<option value="063" <c:if test="${instrumApyVo.tel_1 eq '063'}">selected="selected"</c:if>>063</option>
											<option value="064" <c:if test="${instrumApyVo.tel_1 eq '064'}">selected="selected"</c:if>>064</option>
											<option value="070" <c:if test="${instrumApyVo.tel_1 eq '070'}">selected="selected"</c:if>>070</option>
                                    </select>
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="tel_2" id="tel_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4" value="${instrumApyVo.tel_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="tel_3" id="tel_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4" value="${instrumApyVo.tel_3}">
                                </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>이메일</th>
                            <td>
                                <div class="fm_mail act_uiEmail">
                                <span class="fm_inp">
                                    <input type="text" class="inp" title="이메일계정" id="mail_id" name="mail_id" value="${instrumApyVo.email_id}">
                                </span>
                                    <span class="dash">@</span>
                                    <span class="sel_box" title="이메일도메인">
                                    <select id="mail_domain" name="mail_domain" title="이메일도메인">
                                        <option value="">직접입력</option>
                                        <option value="naver.com" <c:if test="${instrumApyVo.email_domain eq 'naver.com'}">selected="selected"</c:if>>naver.com</option>
											<option value="hanmail.net" <c:if test="${instrumApyVo.email_domain eq 'hanmail.net'}">selected="selected"</c:if>>hanmail.net</option>
											<option value="hotmail.com" <c:if test="${instrumApyVo.email_domain eq 'hotmail.com'}">selected="selected"</c:if>>hotmail.com</option>
											<option value="nate.com" <c:if test="${instrumApyVo.email_domain eq 'nate.com'}">selected="selected"</c:if>>nate.com</option>
											<option value="yahoo.co.kr" <c:if test="${instrumApyVo.email_domain eq 'yahoo.co.kr'}">selected="selected"</c:if>>yahoo.co.kr</option>
											<option value="empas.com" <c:if test="${instrumApyVo.email_domain eq 'empas.com'}">selected="selected"</c:if>>empas.com</option>
											<option value="dreamwiz.com" <c:if test="${instrumApyVo.email_domain eq 'dreamwiz.com'}">selected="selected"</c:if>>dreamwiz.com</option>
											<option value="freechal.com" <c:if test="${instrumApyVo.email_domain eq 'freechal.com'}">selected="selected"</c:if>>freechal.com</option>
											<option value="korea.com" <c:if test="${instrumApyVo.email_domain eq 'korea.com'}">selected="selected"</c:if>>korea.com</option>
											<option value="gmail.com" <c:if test="${instrumApyVo.email_domain eq 'gmail.com'}">selected="selected"</c:if>>gmail.com</option>
											<option value="hanmir.com" <c:if test="${instrumApyVo.email_domain eq 'hanmir.com'}">selected="selected"</c:if>>hanmir.com</option>
                                    </select>
                                </span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mail_domain_txt" id="mail_domain_txt" title="이메일도메인" placeholder="직접입력" value="${instrumApyVo.email_domain}">
                                </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주소</th>
                            <td>
                                <div class="fm_btn">
                                    <input type="text" class="inp" title="우편번호" name="postcode" id="postcode" value="${instrumApyVo.postcode}">
                                    <a class="btn" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                </div>
                                <div class="fm_inp inp_full mt_10"><input type="text" class="inp" name="addr" id="addr" title="주소" value="${instrumApyVo.addr}"></div>
                            </td>
                        </tr>
                        <c:if test="${instrumApyVo.gubun eq 'G'}">
                            <tr>
                                <th class="wid_300"><span class="point">*</span>인원</th>
                                <td>
                                    <div class="fm_inp mr_10"><input type="text" class="inp" name="mem_cnt" id="mem_cnt" title="인원" data-inp-type="number" value="${instrumApyVo.mem_cnt}"></div>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여목적</th>
                            <td>
                                <div class="fm_tf hafl">
                                    <textarea title="대여목적" name="purpose" id="purpose">${instrumApyVo.purpose}</textarea>
                                </div>
                            </td>
                        </tr>
                        <c:if test="${instrumApyVo.apy_parent_name ne null}">
                        <tr>
                            <th class="wid_300">부모이름</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="apy_parent_name" id="apy_parent_name" title="부모이름" value="${instrumApyVo.apy_parent_name}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">부모연락처</th>
                            <td>
                                <div class="fm_phon">
                            <span class="sel_box" >
                                <select name="parent_mob_1" id="parent_mob_1" title="부모 휴대전화 앞번호">
                                    <option value="">선택</option>
                                    <option value="010" <c:if test="${instrumApyVo.parent_mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                    <option value="011" <c:if test="${instrumApyVo.parent_mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                    <option value="016" <c:if test="${instrumApyVo.parent_mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                    <option value="017" <c:if test="${instrumApyVo.parent_mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                    <option value="019" <c:if test="${instrumApyVo.parent_mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                </select>
                            </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                <input type="text" class="inp" name="parent_mob_2" id="parent_mob_2" title="부모 휴대전화 중간번호" data-inp-type="number" value="${instrumApyVo.parent_mob_2}"  maxlength="4">
                            </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                <input type="text" class="inp" name="parent_mob_3" id="parent_mob_3" title="부모 휴대전화 끝번호" data-inp-type="number" value="${instrumApyVo.parent_mob_3}"  maxlength="4">
                            </span>
                                </div>
                            </td>
                        </tr>
                        </c:if>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여수량</th>
                            <td>
                                <c:choose>
                                    <c:when test="${instrumApyVo.gubun eq 'P'}">
                                        <p>1</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="act_uiNumberCount fm_count">
                                            <button type="button" class="minus_btn"><i class="icon_minus_b">빼기</i></button>
                                            <div class="fm_inp">
                                                <input type="text" data-max="100" data-min="0" class="inp" name="rental_qty" id="rental_qty" data-inp-type="number" value="${instrumApyVo.rental_qty}">
                                            </div>
                                            <button type="button" class="plus_btn"><i class="icon_plus_b">더하기</i></button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여기간</th>
                            <td>
                                <div class="fm_cal">
                                    <div class="fm_inp fm_date">
                                        <input type="text" class="inp" id="rental_start_dt" name="rental_start_dt" title="대여시작일자" value="${instrumApyVo.rental_start_dt}" readonly>
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                                <div class="dp_inb" style="display: none;"><div class="dash"> ~ </div></div>
                                <div class="fm_cal" style="display: none;">
                                    <div class="fm_inp fm_date mr_20">
                                        <input type="text" class="inp" id="rental_end_dt" name="rental_end_dt" title="대여종료일자" value="${instrumApyVo.rental_end_dt}">
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                                <div class="dp_inb ml_20">
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="rental_month" id="rental_month_1" value="1" <c:if test="${instrumApyVo.rental_month eq '1'}">checked="checked"</c:if>><span>1개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="rental_month" id="rental_month_2" value="2" <c:if test="${instrumApyVo.rental_month eq '2'}">checked="checked"</c:if>><span>2개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh">
                                        <input type="radio" name="rental_month" id="rental_month_3" value="3" <c:if test="${instrumApyVo.rental_month eq '3'}">checked="checked"</c:if>><span>3개월</span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">반납일정</th>
                            <td id="return_date">
                                ${instrumApyVo.return_due_dt}
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">결제금액</th>
                            <td>
                                <fmt:formatNumber value="${instrumApyVo.pay}" pattern="##,###"/>원
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청일</th>
                            <td>
                                ${fn:substring(instrumApyVo.reg_dt, 0, 10)}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                </form>
                <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                    <div class="row">
                        <c:choose>
                            <c:when test="${instrumApyVo.status eq 'A'}">
                                <div class="col_6 offset_3 offset_md_0 col_md_9">
                                    <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                    <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                                </div>
                                <div class="col_3 t_right">
                                    <a href="/ssem/senior/mypage/instrum_rental_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="t_right">
                                    <a href="/ssem/senior/mypage/instrum_rental_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </section>
    </div>
</div>
