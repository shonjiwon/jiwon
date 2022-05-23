<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '악기대여 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.
        mainInit();   //main.js
        uiInti();       //ui.js
        subInit();   //sub.js
        /*uiRdCh();    //ui.js*/

        svsw_img_box();

        $("#btn_submit").click(function(){
            var frm = document.frm;

            // 회원 휴대폰 번호 - 미성년자일 경우 휴대폰 없을 수 도 있음
            /*if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}*/

            var gubun = $("input[name='gubun']:checked").val();
            //var gubun = frm.gubun.value;
            if(gubun === "P") {
                // 개인신청
                if(frm.tel_1.value != '') {
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

                if(!fnIsValidRequired(frm.p_purpose, "대여목적")){return false;}
                $("#purpose").val(frm.p_purpose.value);

                $("#rental_qty").val("1");

                if(!fnIsValidRequired(frm.p_rental_start_dt, "대여시작일자")){return false;}
                if(!fnIsValidRequired(frm.p_rental_end_dt, "대여종료일자")){return false;}

                $("#rental_start_dt").val(frm.p_rental_start_dt.value);
                $("#rental_end_dt").val(frm.p_rental_end_dt.value);

                // IE 오류
                var rental_month = $("input:radio[name='p_rental_month']:checked").val();

                $("#rental_month").val(rental_month);
                $("#return_due_dt").val(frm.p_return_due_dt.value);

                // 결제금액 계산
                var pay = Number(rental_month) * Number(${instrumVo.fee});
                $("#pay").val(pay);

            } else {
                // 단체신청
                if(!fnIsValidRequired(frm.grp_name, "단체명")){return false;}
                if(frm.grp_tel_1.value != '') {
                    $("#apy_tel_no").val(frm.grp_tel_1.value + '-' + frm.grp_tel_2.value + '-' + frm.grp_tel_3.value);
                }

                if(!fnIsValidRequired(frm.grp_mail_id, "이메일 게정")){return false;}
                if(frm.grp_mail_domain.value === "") {
                    if(!fnIsValidRequired(frm.grp_mail_domain_txt, "이메일도메인")){return false;}
                }

                var email = frm.grp_mail_id.value + "@" + frm.grp_mail_domain_txt.value;
                if(!fnIsEmailAddr(email)) {
                    modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
                    return false;
                }
                $("#apy_email").val(email);

                if(!fnIsValidRequired(frm.grp_postcode, "주소")){return false;}
                if(!fnIsValidRequired(frm.grp_addr, "주소")){return false;}
                $("#apy_addr").val('(' +  frm.grp_postcode.value + ') ' + frm.grp_addr.value);

                if(!fnIsValidRequired(frm.mem_cnt, "인원")){return false;}

                if(!fnIsValidRequired(frm.grp_purpose, "대여목적")){return false;}
                $("#purpose").val(frm.grp_purpose.value);

                var qty = $("#grp_rnetal_qty").val();
                qty = Number(qty);
                if(qty > ${instrumVo.qty - instrumVo.rental_qty}) {
                    modalMsg("신청수량이 남은수량보다 많습니다.", 'notice', '');
                    return false;
                } else if(qty === 0) {
                    modalMsg("신청수량 입력해 주세요.", 'notice', '');
                    return false;
                }
                $("#rental_qty").val(qty);

                if(!fnIsValidRequired(frm.grp_rental_start_dt, "대여시작일자")){return false;}
                if(!fnIsValidRequired(frm.grp_rental_end_dt, "대여종료일자")){return false;}

                $("#rental_start_dt").val(frm.grp_rental_start_dt.value);
                $("#rental_end_dt").val(frm.grp_rental_end_dt.value);

                // IE 오류
                var rental_month = $("input:radio[name='grp_rental_month']:checked").val();

                $("#rental_month").val(rental_month);

                $("#return_due_dt").val(frm.grp_return_due_dt.value);

                var pay = Number(rental_month) * Number(${instrumVo.fee}) * qty;
                $("#pay").val(pay);
            }

            if($("#disabledToggle").is(':checked')) {
                if(!fnIsValidRequired(frm.apy_parent_name, "부모이름")){return false;}
                if(!fnIsValidRequired(frm.parent_mob_1, "부모연락처")){return false;}
                if(!fnIsValidRequired(frm.parent_mob_2, "부모연락처")){return false;}
                if(!fnIsValidRequired(frm.parent_mob_3, "부모연락처")){return false;}

                $("#apy_parent_mob_no").val(frm.parent_mob_1.value + '-' + frm.parent_mob_2.value + '-' + frm.parent_mob_3.value);
            }

            if(frm.agree_yn.value === 'N') {
                modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
                return;
            }

            if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

            $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

            $("#frm").submit();
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

        $("#grp_mail_domain").change(function() {
            var mail_domain = $(this).val();
            if(mail_domain === '') {
                $('#grp_mail_domain_txt').removeAttr("disabled");
                $('#grp_mail_domain_txt').focus();
            } else {
                $('#grp_mail_domain_txt').val('');
                $('#grp_mail_domain_txt').attr("disabled", true);
            }
        });


        // 예외처리
        var gubun = $("input[name='gubun']:checked").val();
        if(gubun === 'P') {
            $('.rd_type1').show();
            $('.rd_type2').hide();
        } else {
            $('.rd_type1').hide();
            $('.rd_type2').show();
        }

        $(document).on('change', '.rd_type', function(){
            if($(this).val() == "G" ){
                $('.rd_type1').hide();
                $('.rd_type2').show();
            }else if($(this).val() == "P" ){
                $('.rd_type1').show();
                $('.rd_type2').hide();
            }
        });

        $(document).on('change', '#disabledToggle', function(){
            if($(this).is(':checked')){
                $('.disabled [disabled]').each(function(){
                    $(this).removeAttr('disabled').addClass('fm_disabled');
                })
            }else{
                $('.disabled .fm_disabled').each(function(){
                    $(this).attr('disabled','disabled').removeClass('fm_disabled');
                })
            }
        });

        $(document).on('change', '#p_rental_month_1', function(){
            if($(this).is(':checked')){
                if($('#p_rental_start_dt').val() === '') {
                    $('#p_rental_start_dt').val(fnGetToday());
                    $('#p_rental_end_dt').val(fnGetDateMinusMonth(1));
                    $('#p_return_due_dt').val(fnGetDateMinusMonth(1));
                } else {
                    $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 1));
                    $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 1));
                }
            }
        });

        $(document).on('change', '#p_rental_month_2', function(){
            if($(this).is(':checked')){
                if($('#p_rental_start_dt').val() === '') {
                    $('#p_rental_start_dt').val(fnGetToday());
                    $('#p_rental_end_dt').val(fnGetDateMinusMonth(2));
                    $('#p_return_due_dt').val(fnGetDateMinusMonth(2));
                } else {
                    $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 2));
                    $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 2));
                }
            }
        });

        $(document).on('change', '#p_rental_month_3', function(){
            if($(this).is(':checked')){
                if($('#p_rental_start_dt').val() === '') {
                    $('#p_rental_start_dt').val(fnGetToday());
                    $('#p_rental_end_dt').val(fnGetDateMinusMonth(3));
                    $('#p_return_due_dt').val(fnGetDateMinusMonth(3));
                } else {
                    $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 3));
                    $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 3));
                }
            }
        });

        $(document).on('change', '#p_rental_start_dt', function(){
            var radio_val = $('input[name="p_rental_month"]:checked').val();
            if(radio_val === '1') {
                $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 1));
                $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 1));
            } else if(radio_val === '2') {
                $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 2));
                $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 2));
            } else if(radio_val === '3') {
                $('#p_rental_end_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 3));
                $('#p_return_due_dt').val(fnGetDateMinusMonthEx($('#p_rental_start_dt').val(), 3));
            }
        });

        $(document).on('change', '#grp_rental_month_1', function(){
            if($(this).is(':checked')){
                if($('#grp_rental_start_dt').val() === '') {
                    $('#grp_rental_start_dt').val(fnGetToday());
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonth(1));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonth(1));
                } else {
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 1));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 1));
                }
            }
        });

        $(document).on('change', '#grp_rental_month_2', function(){
            if($(this).is(':checked')){
                if($('#grp_rental_start_dt').val() === '') {
                    $('#grp_rental_start_dt').val(fnGetToday());
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonth(2));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonth(2));
                } else {
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 2));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 2));
                }
            }
        });

        $(document).on('change', '#grp_rental_month_3', function(){
            if($(this).is(':checked')){
                if($('#grp_rental_start_dt').val() === '') {
                    $('#grp_rental_start_dt').val(fnGetToday());
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonth(3));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonth(3));
                } else {
                    $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 3));
                    $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 3));
                }
            }
        });

        $(document).on('change', '#grp_rental_start_dt', function(){
            var radio_val = $('input[name="grp_rental_month"]:checked').val();
            if(radio_val === '1') {
                $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 1));
                $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 1));
            } else if(radio_val === '2') {
                $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 2));
                $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 2));
            } else if(radio_val === '3') {
                $('#grp_rental_end_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 3));
                $('#grp_return_due_dt').val(fnGetDateMinusMonthEx($('#grp_rental_start_dt').val(), 3));
            }
        });

        $("#p_rental_end_dt").on("propertychange change keyup paste input", function() {
            $('#p_return_due_dt').val($(this).val());
        });

        $("#grp_rental_end_dt").on("propertychange change keyup paste input", function() {
            $('#grp_return_due_dt').val($(this).val());
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
            }
        }).open();
    }

    function sample3_execDaumPostcode() {
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
                document.getElementById('grp_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('grp_addr').value = fullRoadAddr;
            }
        }).open();
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
                        <a href="#" class="deapth_tit" title="선택">악기대여</a>
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
            <a href="#" class="tab_m">악기대여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_rental_list.do" title="선택">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">악기대여</h4>
        <form name="frm" id="frm" action="/ssem/youth/campus/instrum_lib_rental_insert.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="instrum_idx" id="instrum_idx" value="${instrumVo.instrum_idx}"/>
            <input type="hidden" name="group_idx" id="group_idx" value="${instrumVo.group_idx}"/>
            <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
            <input type="hidden" name="apy_tel_no" id="apy_tel_no" />
            <input type="hidden" name="apy_email" id="apy_email" />
            <input type="hidden" name="apy_addr" id="apy_addr" />
            <input type="hidden" name="purpose" id="purpose" />
            <input type="hidden" name="apy_parent_mob_no" id="apy_parent_mob_no" />
            <input type="hidden" name="rental_qty" id="rental_qty" />
            <input type="hidden" name="rental_start_dt" id="rental_start_dt" />
            <input type="hidden" name="rental_end_dt" id="rental_end_dt" />
            <input type="hidden" name="rental_month" id="rental_month" />
            <input type="hidden" name="return_due_dt" id="return_due_dt" />
            <input type="hidden" name="pay" id="pay" />
            <div class="wrap">
                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 pb_md_40">악기 정보</h5>
                <div class="table_box_ul music_table_img_box fs_18 fs_md_24"><!--table_box-->
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
                                            <c:when test="${instrumVo.gubun eq 'A'}">건반악기</c:when>
                                            <c:when test="${instrumVo.gubun eq 'B'}">관악기</c:when>
                                            <c:when test="${instrumVo.gubun eq 'C'}">타악기</c:when>
                                            <c:when test="${instrumVo.gubun eq 'D'}">현악기</c:when>
                                            <c:when test="${instrumVo.gubun eq 'E'}">MIDI장비</c:when>
                                            <c:when test="${instrumVo.gubun eq 'K'}">국악기</c:when>
                                            <c:when test="${instrumVo.gubun eq 'Z'}">기타</c:when>
                                        </c:choose>
                                    </div>
                                </li>
                                <li class="table">
                                    <div class="th wid_300">악기명</div>
                                    <div class="td">${instrumVo.name}</div>
                                </li>
                                <li class="table">
                                    <div class="th wid_300">대여료</div>
                                    <div class="td"><fmt:formatNumber value="${instrumVo.fee}" pattern="##,###" />원/월</div>
                                </li>
                                <li class="table">
                                    <div class="th wid_300">남은수량</div>
                                    <div class="td"><c:out value="${instrumVo.qty - instrumVo.rental_qty}" />개</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div><!--table_box //-->
                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">회원 기본 정보</h5>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${loginVo.user_nm}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">휴대폰 번호</th>
                            <td>
                                <div class="fm_phon">
								<span class="sel_box">
									<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
										<option value="">선택</option>
                                        <option value="010" <c:if test="${instrumVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${instrumVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${instrumVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${instrumVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${instrumVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
									</select>
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" id="mob_2" name="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${instrumVo.mob_2}">
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" id="mob_3" name="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${instrumVo.mob_3}">
								</span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <h3 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix">
                    <span class="dp_inb float_left">
                        <span class="dp_inb va_m">악기대여 신청</span>
                        <span class="dp_inb va_m ml_20 fs_18">
                            <label class="fm_rd act_uiRdCh mr_20">
                                <input type="radio" name="gubun" id="gubun_p" class="rd_type" value="P" checked><span>개인</span>
                            </label>
                            <label class="fm_rd act_uiRdCh">
                                <input type="radio" name="gubun" id="gubun_g" class="rd_type" value="G" ><span>단체</span>
                            </label>
                        </span>
                    </span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h3>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">악기대여 신청의 개인은 전화번호, 이메일, 주소, 대여목적, 대여수량, 대여기간, 반납일정 단체는 단체명, 전화번호, 이메일, 주소, 대여목적, 대여수량, 대여기간, 반납일정</caption>
                        <tbody class="rd_type1">
                        <!-- 개인 -->
                        <tr>
                            <th class="wid_300">전화번호</th>
                            <td>
                                <div class="fm_phon">
								<span class="sel_box" title="전화번호 앞번호">
									<select name="tel_1" id="tel_1">
										<option value="">선택</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="043">043</option>
										<option value="042">042</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="070">070</option>
									</select>
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="tel_2" id="tel_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4">
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="tel_3" id="tel_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4">
								</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>이메일</th>
                            <td>
                                <div class="fm_mail act_uiEmail">
                                    <span class="fm_inp">
                                        <input type="text" class="inp" title="이메일계정" id="mail_id" name="mail_id">
                                    </span>
                                    <span class="dash">@</span>
                                    <span class="sel_box" title="이메일도메인">
									<select name="mail_domain" id="mail_domain">
										<option value="">직접입력</option>
										<option value="naver.com" >naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="empas.com">empas.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="korea.com">korea.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hanmir.com">hanmir.com</option>
										<option value="paran.com">paran.com</option>
									</select>
								</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="mail_domain_txt" id="mail_domain_txt" title="이메일도메인" placeholder="직접입력">
								</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주소</th>
                            <td>
                                <div class="fm_btn">
                                    <input type="text" class="inp" title="우편번호" name="postcode" id="postcode">
                                    <a class="btn" tpye="button" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                </div>
                                <div class="fm_inp inp_full mt_10"><input type="text" class="inp" title="주소" name="addr" id="addr"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여목적</th>
                            <td>
                                <div class="fm_tf hafl">
                                    <textarea title="대여목적" name="p_purpose" id="p_purpose" placeholder="대여목적, 실대여자 이름 및 생년월일 등" class="placeholder"></textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여수량</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" title="대여수량" id="p_rental_qty" value="1" readonly></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여기간</th>
                            <td>
                                <div class="fm_cal">
                                    <div class="fm_inp fm_date">
                                        <input type="text" class="inp" name="p_rental_start_dt" id="p_rental_start_dt" title="대여시작일자" readonly>
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                                <div class="dp_inb" style="display: none;"><div class="dash"> ~ </div></div>
                                <div class="fm_cal mr_20" style="display: none;">
                                    <div class="fm_inp mr_20">
                                        <input type="text" class="inp" name="p_rental_end_dt" id="p_rental_end_dt" title="대여종료일자" readonly>
                                        <%--<button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>--%>
                                    </div>
                                </div>
                                <div class="dp_inb ml_20">
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="p_rental_month" id="p_rental_month_1" value="1"><span>1개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="p_rental_month" id="p_rental_month_2" value="2" ><span>2개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh">
                                        <input type="radio" name="p_rental_month" id="p_rental_month_3" value="3" ><span>3개월</span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">반납일정</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" id="p_return_due_dt" name="p_return_due_dt" title="반납일정" readonly></div>
                            </td>
                        </tr>
                        <!-- 개인 : e-->
                        </tbody>

                        <tbody class="rd_type2" style="display: none;">
                        <!-- 단체명 -->
                        <tr>
                            <th class="wid_300"><span class="point">*</span>단체명</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="grp_name" id="grp_name" title="단체명"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">전화번호</th>
                            <td>
                                <div class="fm_phon">
								<span class="sel_box" title="전화번호 앞번호">
									<select name="grp_tel_1" id="grp_tel_1">
										<option value="">선택</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="043">043</option>
										<option value="042">042</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="070">070</option>
									</select>
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="grp_tel_2" id="grp_tel_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4">
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="grp_tel_3" id="grp_tel_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4">
								</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>이메일</th>
                            <td>
                                <div class="fm_mail act_uiEmail">
								<span class="fm_inp">
									<input type="text" class="inp" title="이메일계정" id="grp_mail_id" name="grp_mail_id">
								</span>
                                    <span class="dash">@</span>
                                    <span class="sel_box" title="이메일도메인">
									<select id="grp_mail_domain" name="grp_mail_domain">
										<option value="">직접입력</option>
										<option value="naver.com" >naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="empas.com">empas.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="korea.com">korea.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hanmir.com">hanmir.com</option>
										<option value="paran.com">paran.com</option>
									</select>
								</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" id="grp_mail_domain_txt" name="grp_mail_domain_txt" title="이메일도메인" placeholder="직접입력">
								</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주소</th>
                            <td>
                                <div class="fm_btn">
                                    <input type="text" class="inp" title="우편번호" name="grp_postcode" id="grp_postcode">
                                    <a class="btn" tpye="button" onclick="sample3_execDaumPostcode();">주소찾기</a>
                                </div>
                                <div class="fm_inp inp_full mt_10"><input type="text" class="inp" title="주소" name="grp_addr" id="grp_addr"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>인원</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" title="인원" name="mem_cnt" id="mem_cnt" data-inp-type="number"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여목적</th>
                            <td>
                                <div class="fm_tf hafl">
                                    <textarea title="대여목적" id="grp_purpose" name="grp_purpose"></textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여수량</th>
                            <td>
                                <div class="act_uiNumberCount fm_count">
                                    <button type="button" class="minus_btn"><i class="icon_minus_b">빼기</i></button>
                                    <div class="fm_inp">
                                        <input type="text" data-max="100" data-min="0" class="inp" data-inp-type="number" id="grp_rnetal_qty">
                                    </div>
                                    <button type="button" class="plus_btn"><i class="icon_plus_b">더하기</i></button>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>대여기간</th>
                            <td>
                                <div class="fm_cal">
                                    <div class="fm_inp fm_date">
                                        <input type="text" class="inp" id="grp_rental_start_dt" name="grp_rental_start_dt" title="대여시작일자" readonly>
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                                <div class="dp_inb" style="display: none;"><div class="dash"> ~ </div></div>
                                <div class="fm_cal mr_20" style="display: none;">
                                    <div class="fm_inp mr_20">
                                        <input type="text" class="inp" id="grp_rental_end_dt" name="grp_rental_end_dt" title="대여종료일자">
                                        <%--<button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>--%>
                                    </div>
                                </div>
                                <div class="dp_inb mr_20">
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="grp_rental_month" id="grp_rental_month_1" value="1"><span>1개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="grp_rental_month" id="grp_rental_month_2" value="2" ><span>2개월</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh">
                                        <input type="radio" name="grp_rental_month" id="grp_rental_month_3" value="3" ><span>3개월</span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>반납일정</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" id="grp_return_due_dt" name="grp_return_due_dt" title="반납일정" readonly></div>
                            </td>
                        </tr>
                        <!-- 단체명 : e-->
                        </tbody>
                    </table>
                </div><!--table_box //-->

                <h3 class="fs_18 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">
                    <label class="fm_ch act_uiRdCh">
                        <input type="checkbox" name="ch_1" id="disabledToggle" value="Y"><span class="ml_5">미성년자인 경우 선택 해주세요.</span>
                    </label>
                </h3>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">보호자 정보 부모이름, 부모연락처</caption>
                        <tbody class="disabled">
                        <tr>
                            <th class="wid_300">부모이름</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="apy_parent_name" id="apy_parent_name" title="부모이름" disabled></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">부모연락처</th>
                            <td>
                                <div class="fm_phon">
								<span class="sel_box" >
									<select title="전화번호 앞번호" name="parent_mob_1" id="parent_mob_1" disabled>
										<option value="">선택</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select>
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="parent_mob_2" id="parent_mob_2" title="전화번호 중간번호" data-inp-type="number" disabled maxlength="4">
								</span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
									<input type="text" class="inp" name="parent_mob_3" id="parent_mob_3" title="전화번호 끝번호" data-inp-type="number" disabled maxlength="4">
								</span>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24 fs_20"><!--agree_box-->
                    <p class="pb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub">
                        <li>개인정보의 수집ㆍ이용 목적  :  악기대여 신청 및 관련 관련 안내</li>
                        <li>수집하려는 개인정보의 항목  :  성명, 휴대폰 번호, 전화번호, 생년월일, 주소, 이메일</li>
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
                    <a href="#none" class="btn btn_long btn_big btn_color_5 t_centermr_20 mr_15" id="btn_submit">대여 신청</a>
                    <a href="/ssem/youth/campus/instrum_lib_rental_view.do?instrum_idx=${instrumVo.instrum_idx}" class="btn btn_long btn_big t_center">취소하기</a>
                </div>
            </div>
        </form>
    </div>
</div>
