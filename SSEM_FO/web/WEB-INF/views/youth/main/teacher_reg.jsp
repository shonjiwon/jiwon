<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-02
  Time: 오후 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '강사신청 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("강사 신청을 하시겠습니까?", 'yesorno', insert_frm);
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

    function insert_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.code_idx, "교육분야")){return false;}
        if(!fnIsValidRequired(frm.prof_field, "전문문야")){return false;}
        if(!fnIsValidRequired(frm.career, "학력 및 주요경력")){return false;}
        if(!fnIsValidRequired(frm.cert, "취득자격")){return false;}
        if(!fnIsValidRequired(frm.career_atch_file_id, "강사이력")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);


        if(frm.mail_id.value !== '') {
            var email = frm.mail_id.value + "@" + frm.mail_domain_txt.value;
            if (!fnIsEmailAddr(email)) {
                modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'notice', '');
                return false;
            }
            $("#apy_email").val(email);
        }

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_10"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    강사신청
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_con st_1 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">강사신청</h3>
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h2 class="c_tit_2 mt_75  ptb_15">회원 기본 정보</h2>
                <form name="frm" id="frm" action="/ssem/youth/main/teacher_reg.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="apy_email" id="apy_email" />
                    <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}"/>
                    <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}"/>
                    <input type="hidden" name="apy_gender" id="apy_gender" value="${loginVo.sex}"/>
                    <input type="hidden" name="apy_birth" id="apy_birth" value="${loginVo.brthdy}"/>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300">신청자 이름 </th>
                                <td>${loginVo.user_nm}</td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="전화번호 앞번호">
                                            <option value="">선택</option>
                                            <option value="010" <c:if test="${teacherApyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${teacherApyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${teacherApyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${teacherApyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${teacherApyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                        </select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
                                        <input type="text" class="inp" name="mob_2" id="mob_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4" value="${teacherApyVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										    <input type="text" class="inp" name="mob_3" id="mob_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4" value="${teacherApyVo.mob_3}">
									    </span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">성별 </th>
                                <td>
                                    <c:choose>
                                        <c:when test="${loginVo.sex eq 'M'}">남</c:when>
                                        <c:otherwise>여</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">생년월일</th>
                                <td>${loginVo.brthdy}</td>
                            </tr>
                            <tr>
                                <th class="wid_300">이메일</th>
                                <td>
                                    <div class="fm_mail act_uiEmail">
									<span class="fm_inp">
										<input type="text" class="inp" title="이메일계정" id="mail_id" name="mail_id">
									</span>
                                        <span class="dash">@</span>
                                        <span class="sel_box">
										<select name="mail_domain" id="mail_domain"  title="이메일도메인">
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
										<input type="text" class="inp" id="mail_domain_txt" name="mail_domain_txt" title="이메일도메인" placeholder="직접입력">
									</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">사진첨부</th>
                                <td>
                                    <div class="fm_file_btn act_uiFileBtn">
                                        <input type="file"  accept="image/*" title="파일 첨부" name="pic_atch_file_id" id="pic_atch_file_id">
                                        <button type="button" class="btn btn_line">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="파일 이름">
                                    </div>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5"> (파일형식 : jpg, jpge, bmp, gif / 사이즈 : 300*350)</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <!--2020.11.04:s-->
                    <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                        <span class="dp_inb float_left">등록 정보</span>
                        <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                    </h2>
                    <!--2020.11.04:e-->
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">등록 정보의 교육분야, 전문분야, 학력 및 주요경력, 취득자격, 강사이력 </caption>
                            <tbody>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>교육분야</th>
                                <td>
                                    <div class="sel_box">
                                        <select title="분야" class="placeholder" name="code_idx" id="code_idx">
                                            <option value="">분야 선택</option>
                                            <c:forEach items="${codeList}" var="code" varStatus="status">
                                                <option value="${code.code_idx}">${code.cd_val}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>전문분야</th>
                                <td class="">
                                    <div class="fm_cal st_2 full">
                                        <div class="fm_inp fm_full mr_10">
                                            <input type="text" class="inp" title="전문분야" name="prof_field" id="prof_field">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>학력 및 주요경력</th>
                                <td class="" colspan="2">
                                    <div class="fm_tf">
                                        <textarea name="career" id="career" title="학력 및 주요경력"></textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>취득자격</th>
                                <td class="">
                                    <div class="fm_cal st_2 full">
                                        <div class="fm_inp fm_full mr_10">
                                            <input type="text" class="inp" title="취득자격" name="cert" id="cert">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강사이력</th>
                                <td>
                                    <div class="fm_file_btn act_uiFileBtn">
                                        <input type="file" title="파일 첨부" name="career_atch_file_id" id="career_atch_file_id">
                                        <button type="button" class="btn btn_line">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="파일 이름">
                                    </div>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5"> 강사로 활동하신 이력 이나 본인의 프로필을 등록해 주세요.</p>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5"> (파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.)</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <p class="tc_point fs_18 fs_md_22 mt_5">※ 강사신청은 신청 후 해당 담당자 확인하여 개별적으로 연락을 드립니다.</p>
                    <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                        <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                        <ul class="ul_list_dot mb_20 tc_sub fw_300">
                            <li>개인정보의 수집ㆍ이용 목적  : 강사신청 및 관련 안내</li>
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
                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center">
                        <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                        <a href="/ssem/youth/main/main.do" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0">신청 취소</a>
                    </div>
                </form>
            </div>
        </section>
    </div>
</div>
