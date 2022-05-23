<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-22
  Time: 오후 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '인물도서 등록 > 인물도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

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

            if(!fnIsValidRequired(frm.cate_cd, "분류")){return false;}
            if(!fnIsValidRequired(frm.reg_gender, "성별")){return false;}
            if(!fnIsValidRequired(frm.reg_age, "연령대")){return false;}

            if(!fnIsValidRequired(frm.postcode, "주소")){return false;}
            if(!fnIsValidRequired(frm.addr, "주소")){return false;}

            $("#reg_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
            $("#reg_addr").val('(' +  frm.postcode.value + ') ' + frm.addr.value);
            if(frm.tel_1.value !== '' &&  frm.tel_2.value !== '' && frm.tel_3.value !== '') {
                $("#reg_tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);
            }

            if(frm.mail_domain.value === '') {
                if(!fnIsValidRequired(frm.mail_domain_txt, "이메일")){return false;}

                var email = frm.mail.value + "@" + frm.mail_domain_txt.value;
                if(!fnIsEmailAddr(email)) {
                    modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
                    return false;
                }

                $("#reg_email").val(email);
            } else {
                var email = frm.mail.value + "@" + frm.mail_domain.value;
                if(!fnIsEmailAddr(email)) {
                    modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
                    return false;
                }
                $("#reg_email").val(email);
            }

            if(!fnIsValidRequired(frm.career, "대표경력")){return false;}
            if(!fnIsValidRequired(frm.intro, "소개글")){return false;}

            if(frm.agree_yn.value === 'N') {
                modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
                return;
            }

            modalMsg("인물도서 등록 신청을 하시겠습니까?", "yesorno", doSubmit);
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
    });

    function doSubmit() {
        $("#frm").submit();
    }

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
                        <a href="#" class="deapth_tit" title="선택">인물도서 등록</a>
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
            <a href="#" class="tab_m">인물도서 등록<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/person_lib_insert.do" title="선택">인물도서 등록</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">인물도서 등록</h4>
        <section class="text_con wrap fs_20 fs_md_26  pb_100 mb_15">
            <h2 class="c_tit_2 mt_90">인물도서관 이용안내</h2>
                <p class="mt_20 mb_95">인물도서는 독자를 직접 만나 자신의 지식과 경혐을 전달하는 자원봉사자로 강의, 멘토링, 인터뷰 등 다양한 활동으로 독자와 만납니다.</p>
                <h2 class="c_tit_2 mt_25">인물도서 활동방법</h2>
                <div class="img_step_box t_center fs_22 fs_md_26">
                    <ul class="row">
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">1</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_01.png" alt="독자의 열람신청">
                                    <p>독자의 열람신청</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">2</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_05.png" alt="인물도서의 봉사활동 가능시간 조율">
                                    <p>인물도서의 봉사활동 가능시간 조율</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">3</span>
                                <div class="step_text_box">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_06.png" alt="열람 진행">
                                    <p>열람 진행</p>
                                </div>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="step_text_wrap">
                                <span class="step_num">4</span>
                                <div class="step_text_box pt_25">
                                    <img src="/ssem/resources/img/sub/img_setp_01_img_07.png" alt="인물도서 봉사시간 인정 (1365자원봉사포털 연계)">
                                    <p class="lh_14">인물도서 봉사시간 인정<br><span class="fs_18 fs_md_24">(1365자원봉사포털 연계)</span></p>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>

                <h2 class="c_tit_2 mt_95">인물도서 등록신청</h2>
                <form name="frm" id="frm" action="/ssem/youth/campus/person_lib_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="reg_addr" id="reg_addr" />
                    <input type="hidden" name="reg_mob_no" id="reg_mob_no" />
                    <input type="hidden" name="reg_tel_no" id="reg_tel_no" />
                    <input type="hidden" name="reg_email" id="reg_email" />
                <h3 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20">회원 기본 정보</h3>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호, 생년월일</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${loginVo.user_nm}</td>
                            <input type="hidden" name="reg_name" id="reg_name" value="${loginVo.user_nm}" />
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>휴대전화 번호</th>
                            <td>
                                <div class="fm_phon">
                                    <span class="sel_box">
                                        <select id="mob_1" name="mob_1" title="휴대전화 앞번호">
                                            <option value="">선택</option>
                                            <option value="010" <c:if test="${personBookRegVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${personBookRegVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${personBookRegVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${personBookRegVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${personBookRegVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                        </select>
                                    </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" id="mob_2" name="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.mob_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" d="mob_3" name="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.mob_3}">
                                </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">생년월일</th>
                            <td>${loginVo.brthdy}</td>
                            <input type="hidden" name="reg_birth" id="reg_birth" value="${loginVo.brthdy}" />
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <h3 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix">
                    <span class="dp_inb float_left">등록 신청</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h3>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">인물도서 신청의 분류, 성별, 연령대, 주소, 전화번호, 이메일, 사진등록, 대표경력</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>분류</th>
                            <td>
                                <div class="sel_box">
                                    <select id="cate_cd" name="cate_cd" class="placeholder"  title="분류">
                                        <option value="">선택</option>
                                        <option value="J">진로직업</option>
                                        <option value="C">문화예술</option>
                                        <option value="H">인문교양</option>
                                        <option value="P">인성심리</option>
                                        <option value="E">전문인</option>
                                        <option value="Z">기타</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>성별</th>
                            <td>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_gender" id="reg_gender_m" value="M" checked><span>남자</span>
                                </label>
                                <label class="fm_rd act_uiRdCh">
                                    <input type="radio" name="reg_gender" id="reg_gender_f" value="F" ><span>여자</span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>연령대</th>
                            <td>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_1" value="1" checked><span>10대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_2" value="2"><span>20대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_3" value="3"><span>30대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_4" value="4"><span>40대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_5" value="5"><span>50대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_6" value="6"><span>60대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_7" value="7"><span>70대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_8" value="8"><span>80대</span>
                                </label>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="reg_age" id="reg_age_9" value="9"><span>90대</span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주소</th>
                            <td>
                                <div class="fm_btn">
                                    <input type="text" class="inp" title="우편번호" name="postcode" id="postcode">
                                    <a class="btn" tpye="button" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                </div>
                                <div class="fm_inp inp_full mt_10"><input type="text" class="inp" title="주소2" name="addr" id="addr"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">전화번호</th>
                            <td>
                                <div class="fm_phon">
                                    <span class="sel_box">
                                        <select name="tel_1" id="tel_1" title="전화번호 앞번호">
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
                                        <input type="text" class="inp" title="이메일1" id="mail" name="mail">
                                    </span>
                                    <span class="dash">@</span>
                                    <span class="sel_box">
                                        <select id="mail_domain" name="mail_domain" title="이메일2">
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
                                        <input type="text" class="inp" id="mail_domain_txt" name="mail_domain_txt" title="직접입력" placeholder="직접입력" id="mail2">
                                    </span>
                                </div>
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
                                <span class="dp_inb tc_sub fs_16 fs_md_22">(파일형식 : jpg, jpeg, png, bmp, gif )</span>
                            </td>
                        </tr>

                        <tr>
                            <th class="wid_300"><span class="point">*</span>대표경력</th>
                            <td>
                                <div class="fm_tf hafl">
                                    <textarea id="career" name="career"  title="대표경력"></textarea>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="bg_1" colspan="2">
                                <p class="fs_20 fs_md_26 fw_400 mtb_20 tc_b"><span class="tc_point">*</span>소개글</p>
                                <div class="fm_tf mb_20">
                                    <textarea id="intro" name="intro" title="소개글"></textarea>
                                </div>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div><!--table_box //-->

                <div class="agree_box mt_60 fs_18 fs_md_24 fs_20"><!--agree_box-->
                    <p class="pb_20 fw_600 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub">
                        <li>개인정보의 수집ㆍ이용 목적  :  인물도서 등록 신청 및 관련 안내</li>
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
                <div class="btn_box mt_50  pb_30 t_center">
                    <a type="button" class="btn btn_long btn_big btn_color_2  mr_15" id="btn_submit">인물도서 신청하기</a>
                </div>
                </form>
        </section>
    </div><!-- sub_con : e -->
    <%--<div class="popup_wrap" id="popup1">
        <div class="popup_box" tabindex="0">
            <div class="popup_con">
                <div class="_text fs_24 fs_md_30 fw_500 t_center">인물도서 등록 신청이 <br class="screen_hide screen_md_show">완료되었습니다.</div>
                <div class="popup_btn t_center mt_40">
                    <button type="button" class="btn ok_btn btn_color_2  mr_15"><span class="fs_20 fs_md_26">확인</span></button>
                    <button type="button" class="btn close_btn"><span class="fs_20 fs_md_26">취소</span></button>
                </div>
            </div>
        </div>
    </div>--%>
</div>
