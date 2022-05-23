<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '인물도서 등록 신청 > 인물도서관 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("인물도서 등록 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
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

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssem/file/file_delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: "atch_file_id=" + del_id_arr[0] + "&file_num=" + del_id_arr[1],
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("삭제에 실패하였습니다.");
                        } else {
                            alert("삭제하였습니다.");
                            location.href = "?person_book_reg_idx=${personBookRegVo.person_book_reg_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
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

        if(!fnIsValidRequired(frm.cate_cd, "분류")){return false;}
        if(!fnIsValidRequired(frm.postcode, "우편번호")){return false;}
        if(!fnIsValidRequired(frm.addr, "주소")){return false;}

        if(!fnIsValidRequired(frm.mail_id, "이메일계정")){return false;}
        if(!fnIsValidRequired(frm.mail_domain_txt, "이메일도메인")){return false;}

        if(!fnIsValidRequired(frm.career, "대표경력")){return false;}
        if(!fnIsValidRequired(frm.intro, "소개글")){return false;}

        $("#reg_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
        $("#reg_addr").val('(' +  frm.postcode.value + ') ' + frm.addr.value);
        if(frm.tel_1.value !== '' &&  frm.tel_2.value !== '' && frm.tel_3.value !== '') {
            $("#reg_tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);
        }
        var email = frm.mail_id.value + "@" + frm.mail_domain_txt.value;
        if(!fnIsEmailAddr(email)) {
            modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
            return false;
        }
        $("#reg_email").val(frm.mail_id.value + '@' + frm.mail_domain_txt.value);

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
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do">열람 신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/person_reg_list.do">인물도서 등록 신청</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">인물도서 등록 신청</h1>
                <!--2020.11.04:s-->
                <h2 class="c_tit_2 ptb_15 clearfix">
                    <span class="dp_inb float_left">회원 기본 정보</span>
                </h2>
                <!--2020.11.04:e-->
                <form name="frm_cancel" id="frm_cancel" action="/ssem/youth/mypage/person_reg_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="person_book_reg_idx" value="${personBookRegVo.person_book_reg_idx}" />
                </form>
                <form name="frm" id="frm" action="/ssem/youth/mypage/person_reg_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="person_book_reg_idx" value="${personBookRegVo.person_book_reg_idx}" />
                    <input type="hidden" name="reg_mob_no" id="reg_mob_no" />
                    <input type="hidden" name="reg_addr" id="reg_addr" />
                    <input type="hidden" name="reg_tel_no" id="reg_tel_no" />
                    <input type="hidden" name="reg_email" id="reg_email" />
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300">신청자 이름</th>
                                <td>${personBookRegVo.reg_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300">휴대전화 번호</th>
                                <td>
                                    <div class="fm_phon">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
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
										<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.mob_3}">
									</span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">생년월일</th>
                                <td>${personBookRegVo.reg_birth}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <!--2020.11.04:s-->
                    <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                        <span class="dp_inb float_left">등록 신청 정보</span>
                        <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                    </h2>
                    <!--2020.11.04:e-->
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">등록 신청의 분류, 성별, 연령대, 주소, 전화번호, 이메일, 사진등록, 대표경력, 소개글</caption>
                            <tbody>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 분류</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="sel_box">
                                        <select title="분류" id="cate_cd" name="cate_cd">
                                            <option value="">선택</option>
                                            <option value="J" <c:if test="${personBookRegVo.cate_cd eq 'J'}">selected="selected"</c:if>>진로직업</option>
                                            <option value="C" <c:if test="${personBookRegVo.cate_cd eq 'C'}">selected="selected"</c:if>>문화예술</option>
                                            <option value="H" <c:if test="${personBookRegVo.cate_cd eq 'H'}">selected="selected"</c:if>>인문교양</option>
                                            <option value="P" <c:if test="${personBookRegVo.cate_cd eq 'P'}">selected="selected"</c:if>>인성심리</option>
                                            <option value="E" <c:if test="${personBookRegVo.cate_cd eq 'E'}">selected="selected"</c:if>>전문인</option>
                                            <option value="Z" <c:if test="${personBookRegVo.cate_cd eq 'Z'}">selected="selected"</c:if>>기타</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 성별</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_gender" id="reg_gender_m" value="M" <c:if test="${personBookRegVo.reg_gender eq 'M'}">checked="checked"</c:if>><span>남자</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh">
                                        <input type="radio" name="reg_gender" id="reg_gender_f" value="여" <c:if test="${personBookRegVo.reg_gender eq 'F'}">checked="checked"</c:if>><span>여자</span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 연령대</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_10" value="1" <c:if test="${personBookRegVo.reg_age eq '1'}">checked="checked"</c:if>><span>10대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_20" value="2" <c:if test="${personBookRegVo.reg_age eq '2'}">checked="checked"</c:if>><span>20대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_30" value="3" <c:if test="${personBookRegVo.reg_age eq '3'}">checked="checked"</c:if>><span>30대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_40" value="4" <c:if test="${personBookRegVo.reg_age eq '4'}">checked="checked"</c:if>><span>40대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_50" value="5" <c:if test="${personBookRegVo.reg_age eq '5'}">checked="checked"</c:if>><span>50대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_60" value="6" <c:if test="${personBookRegVo.reg_age eq '6'}">checked="checked"</c:if>><span>60대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_70" value="7" <c:if test="${personBookRegVo.reg_age eq '7'}">checked="checked"</c:if>><span>70대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_80" value="8" <c:if test="${personBookRegVo.reg_age eq '8'}">checked="checked"</c:if>><span>80대</span>
                                    </label>
                                    <label class="fm_rd act_uiRdCh mr_20">
                                        <input type="radio" name="reg_age" id="reg_age_90" value="9" <c:if test="${personBookRegVo.reg_age eq '9'}">checked="checked"</c:if>><span>90대</span>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 주소</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_btn">
                                        <input type="text" class="inp" title="우편번호" name="postcode" id="postcode" value="${personBookRegVo.postcode}">
                                        <a class="btn" onclick="sample4_execDaumPostcode();">주소찾기</a>
                                    </div>
                                    <div class="fm_inp inp_full mt_10"><input type="text" class="inp" name="addr" id="addr" title="주소" value="${personBookRegVo.addr}"></div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">전화번호</th>
                                <td>
                                    <div class="fm_phon">
									<span class="sel_box" title="전화번호 앞번호">
										<select title="전화번호 앞번호" name="tel_1" id="tel_1">
											<option value="">선택</option>
											<option value="02" <c:if test="${personBookRegVo.tel_1 eq '02'}">selected="selected"</c:if>>02</option>
											<option value="031" <c:if test="${personBookRegVo.tel_1 eq '031'}">selected="selected"</c:if>>031</option>
											<option value="032" <c:if test="${personBookRegVo.tel_1 eq '032'}">selected="selected"</c:if>>032</option>
											<option value="033" <c:if test="${personBookRegVo.tel_1 eq '033'}">selected="selected"</c:if>>033</option>
											<option value="041" <c:if test="${personBookRegVo.tel_1 eq '041'}">selected="selected"</c:if>>041</option>
											<option value="043" <c:if test="${personBookRegVo.tel_1 eq '043'}">selected="selected"</c:if>>043</option>
											<option value="042" <c:if test="${personBookRegVo.tel_1 eq '042'}">selected="selected"</c:if>>042</option>
											<option value="044" <c:if test="${personBookRegVo.tel_1 eq '044'}">selected="selected"</c:if>>044</option>
											<option value="051" <c:if test="${personBookRegVo.tel_1 eq '051'}">selected="selected"</c:if>>051</option>
											<option value="052" <c:if test="${personBookRegVo.tel_1 eq '052'}">selected="selected"</c:if>>052</option>
											<option value="053" <c:if test="${personBookRegVo.tel_1 eq '053'}">selected="selected"</c:if>>053</option>
											<option value="054" <c:if test="${personBookRegVo.tel_1 eq '054'}">selected="selected"</c:if>>054</option>
											<option value="055" <c:if test="${personBookRegVo.tel_1 eq '055'}">selected="selected"</c:if>>055</option>
											<option value="061" <c:if test="${personBookRegVo.tel_1 eq '061'}">selected="selected"</c:if>>061</option>
											<option value="062" <c:if test="${personBookRegVo.tel_1 eq '062'}">selected="selected"</c:if>>062</option>
											<option value="063" <c:if test="${personBookRegVo.tel_1 eq '063'}">selected="selected"</c:if>>063</option>
											<option value="064" <c:if test="${personBookRegVo.tel_1 eq '064'}">selected="selected"</c:if>>064</option>
											<option value="070" <c:if test="${personBookRegVo.tel_1 eq '070'}">selected="selected"</c:if>>070</option>
										</select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="tel_2" id="tel_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.tel_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="tel_3" id="tel_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4" value="${personBookRegVo.tel_3}">
									</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 이메일</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_mail act_uiEmail">
									<span class="fm_inp">
										<input type="text" class="inp" title="이메일계정" id="mail_id" name="mail_id" value="${personBookRegVo.email_id}">
									</span>
                                        <span class="dash">@</span>
                                        <span class="sel_box" title="이메일도메인">
										<select name="mail_domain" id="mail_domain" title="이메일도메인">
											<option value="">직접입력</option>
											<option value="naver.com" <c:if test="${personBookRegVo.email_domain eq 'naver.com'}">selected="selected"</c:if>>naver.com</option>
											<option value="hanmail.net" <c:if test="${personBookRegVo.email_domain eq 'hanmail.net'}">selected="selected"</c:if>>hanmail.net</option>
											<option value="hotmail.com" <c:if test="${personBookRegVo.email_domain eq 'hotmail.com'}">selected="selected"</c:if>>hotmail.com</option>
											<option value="nate.com" <c:if test="${personBookRegVo.email_domain eq 'nate.com'}">selected="selected"</c:if>>nate.com</option>
											<option value="yahoo.co.kr" <c:if test="${personBookRegVo.email_domain eq 'yahoo.co.kr'}">selected="selected"</c:if>>yahoo.co.kr</option>
											<option value="empas.com" <c:if test="${personBookRegVo.email_domain eq 'empas.com'}">selected="selected"</c:if>>empas.com</option>
											<option value="dreamwiz.com" <c:if test="${personBookRegVo.email_domain eq 'dreamwiz.com'}">selected="selected"</c:if>>dreamwiz.com</option>
											<option value="freechal.com" <c:if test="${personBookRegVo.email_domain eq 'freechal.com'}">selected="selected"</c:if>>freechal.com</option>
											<option value="korea.com" <c:if test="${personBookRegVo.email_domain eq 'korea.com'}">selected="selected"</c:if>>korea.com</option>
											<option value="gmail.com" <c:if test="${personBookRegVo.email_domain eq 'gmail.com'}">selected="selected"</c:if>>gmail.com</option>
											<option value="hanmir.com" <c:if test="${personBookRegVo.email_domain eq 'hanmir.com'}">selected="selected"</c:if>>hanmir.com</option>
										</select>
									</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mail_domain_txt" id="mail_domain_txt" title="이메일도메인" placeholder="직접입력" value="${personBookRegVo.email_domain}">
									</span>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="wid_300">사진등록</th>
                                <td>
                                    <div class="fm_file_btn act_uiFileBtn">
                                        <input type="file" name="attfile" id="attfile#" accept="image/*" title="파일 첨부">
                                        <button type="button" class="btn btn_line">파일 찾기</button>
                                        <input type="text" class="inp" title="파일 이름" readonly>
                                    </div>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5"> (파일형식 : jpg, jpeg, bmp, gif, png / 사이즈 : 000*000)</p>

                                    <div class="file_box">
                                        <c:forEach items="${personBookRegVo.fileList}" var="item" varStatus="status">
                                            <a href="/ssem/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}" class="file_name">${item.file_ori_nm}</a>
                                            <a type="button" class="btn" id="btn_file_del_${item.atch_file_id}_${item.file_num}">삭제</a>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 대표경력</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_tf hafl">
                                        <textarea name="career" id="career" title="대표경력">${personBookRegVo.career}</textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <!--2020.11.04:s-->
                                <th class="wid_300"><span class="tc_point">*</span> 소개글</th>
                                <!--2020.11.04:e-->
                                <td>
                                    <div class="fm_tf">
                                        <textarea name="intro" id="intro" title="소개글">${personBookRegVo.intro}</textarea>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                        <div class="row">
                            <c:choose>
                                <c:when test="${personBookRegVo.status eq 'A'}">
                                    <div class="col_6 offset_3 offset_md_0 col_md_9">
                                        <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                        <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                                    </div>
                                    <div class="col_3 t_right">
                                        <a href="/ssem/youth/mypage/person_reg_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="t_right">
                                        <a href="/ssem/youth/mypage/person_reg_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
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
