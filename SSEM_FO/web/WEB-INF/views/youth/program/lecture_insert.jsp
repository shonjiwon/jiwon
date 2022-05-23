<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '통합프로그램신청 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("통합프로그램 신청을 하시겠습니까?", 'yesorno', insert_frm);
        });

        $(document).on('change', '#disabledToggle', function(){
            if($(this).is(':checked')){
                $('.disabled [disabled]').each(function(){
                    $(this).removeAttr('disabled').addClass('fm_disabled');
                })
            }else{
                $('.disabled .fm_disabled').each(function(){
                    $(this).attr('disabled','disabled').removeClass('fm_disabled');
                    $('[type=checkbox]').prop('checked', false);
                })
            }
        });

        $(document).on('change', '#vaccine_y', function(){
            if($(this).is(':checked')){
                $("#vaccine_dt").removeAttr('disabled');
            }else{
                $("#vaccine_dt").attr('disabled','disabled');
            }
        });

        $(document).on('change', '#vaccine_n', function(){
            if($(this).is(':checked')){
                $("#vaccine_dt").attr('disabled','disabled');
            }else{
                $("#vaccine_dt").removeAttr('disabled');
            }
        });

        $(document).on('change', '#same_mob_no', function(){
            if($(this).is(':checked')){
                $("#ref_mob_1").val($("#mob_1").val());
                $("#ref_mob_2").val($("#mob_2").val());
                $("#ref_mob_3").val($("#mob_3").val());
            }else{
                $("#ref_mob_1").val("");
                $("#ref_mob_2").val("");
                $("#ref_mob_3").val("");
            }
        });

        $(document).on('change', '#student_type', function(){
            var selected_str = $(this).val();
            if(selected_str === '초등학생') {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                html +='<option value="1학년">1학년</option>';
                html +='<option value="2학년">2학년</option>';
                html +='<option value="3학년">3학년</option>';
                html +='<option value="4학년">4학년</option>';
                html +='<option value="5학년">5학년</option>';
                html +='<option value="6학년">6학년</option>';
                $('#student_grade').append(html); //항목 추가

            } else if(selected_str === '중학생' || selected_str === '고등학생') {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                html +='<option value="1학년">1학년</option>';
                html +='<option value="2학년">2학년</option>';
                html +='<option value="3학년">3학년</option>';
                $('#student_grade').append(html); //항목 추가
            } else {
                $('#student_grade').children().remove();
                var html = '';
                html +='<option value="">선택</option>';
                $('#student_grade').append(html); //항목 추가
            }
        });
    });

    function insert_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        if($("#disabledToggle").is(':checked')) {
            if (!fnIsValidRequired(frm.apy_ref, "신청자와의 관계")) {
                return false;
            }
            if (!fnIsValidRequired(frm.apy_real_name, "교육대상자 이름")) {
                return false;
            }
            if(!fnIsValidRequired(frm.ref_mob_1, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.ref_mob_2, "휴대폰번호")){return false;}
            if(!fnIsValidRequired(frm.ref_mob_3, "휴대폰번호")){return false;}

            $("#apy_ref_mob_no").val(frm.ref_mob_1.value + '-' + frm.ref_mob_2.value + '-' + frm.ref_mob_3.value);
        }

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 필수항목 동의를 선택해 주세요.", "notice", "");
            return;
        }

        if(frm.agree_opt_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 선택항목 동의를 선택해 주세요.", "notice", "");
            return;
        }

        if(frm.vaccine_yn.value === 'Y') {
            if(frm.vaccine_dt.value === '') {
                modalMsg("코로나19 백신접종일을 입력해주세요.", "notice", "");
                return;
            }
        }

        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_9"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    통합프로그램신청
                </h2>

                <p class="tit_sub">
                    청소년의 적성과 재능에 맞는 길을 찾아주는<br>
                    열린교육 송파쌤, 청소년 교육
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
                        <a href="#" class="deapth_tit" title="선택">통합프로그램신청</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
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
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">통합프로그램신청</h3>
                </div>
            </div>
        </div>
        <div class="wrap">

            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix_after">
                <span>프로그램 상세</span>
            </h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table ">
                        <div class="th wid_230">프로그램명</div>
                        <div class="td">${lectureVo.name}</div>
                    </li>

                    <li class="table half">
                        <div class="th wid_230">교육분야</div>
                        <div class="td">${lectureVo.part_name}</div>
                    </li>

                    <li class="table half">
                        <div class="th wid_230">교육대상</div>
                        <div class="td">
                            <c:forTokens  var="tgt" items="${lectureVo.array_tgt}" delims="," varStatus="status">
                                ${tgt}
                            </c:forTokens>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육기관</div>
                        <div class="td">${lectureVo.group.name}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육장소</div>
                        <div class="td">${lectureVo.place.name}</div>
                    </li>
                    <li class="table">
                        <div class="th wid_230">주소
                        </div>
                        <div class="td">
                            <span class="dp_inp va_m mr_10">${lectureVo.place.addr} ${lectureVo.place.addr2}</span>
                            <!--
                                2020.10.26 : start
                                .act_popup_map_open > sub.js
                            -->
                            <a href="https://map.kakao.com/?q=${lectureVo.place.addr}" class="btn btn_color_t btn_small btn_auto screen_md_hide" target="_blank">지도보기</a>
                            <!--2020.10.26 : end-->
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육기간
                        </div>
                        <div class="td">${fn:substring(lectureVo.start_dt, 0, 10)} ~ ${fn:substring(lectureVo.end_dt, 0, 10)}
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육시간
                        </div>
                        <div class="td">${lectureVo.dt_str} ${lectureVo.start_time}~${lectureVo.end_time}
                        </div>
                    </li>

                    <li class="table half">
                        <div class="td wid_p_50 p_0 line_none_bottom">
                            <div class="table">
                                <div class="th wid_230">수강료</div>
                                <div class="td"><fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                                    <c:if test="${lectureVo.fee_detail ne '' && lectureVo.fee_detail ne null}">
                                        (${lectureVo.fee_detail})
                                    </c:if>
                                </div>
                            </div>
                            <div class="table">
                                <div class="th wid_230">결제방법</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${lectureVo.pay_type eq 'I'}">
                                            온라인결제
                                        </c:when>
                                        <c:otherwise>
                                            현장결제
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">감면대상</div>
                        <div class="td">
                            <ul class="ul_list_dash">
                                <c:forEach items="${lectureVo.array_discount}" var="discount" varStatus="status">
                                    <li>${discount.rate}% (${discount.tgt_name})</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                    <li class="table">
                        <div class="th wid_230">정보화교육여부</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.ict_yn eq 'Y'}">
                                    예
                                </c:when>
                                <c:otherwise>
                                    아니오
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <li class="table">
                        <div class="th wid_230">특이사항</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.desc_txt eq '' || lectureVo.desc_txt eq null}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    ${lectureVo.desc_txt}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>

                    <li class="table">
                        <div class="th wid_230">환불정책</div>
                        <div class="td">
                            <c:choose>
                                <c:when test="${lectureVo.refund_txt eq '' || lectureVo.refund_txt eq null}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    ${lectureVo.refund_txt}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>

                </ul>
            </div><!--table_box //-->
            <form name="frm" id="frm" action="/ssem/youth/program/lecture_insert.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}"/>
                <input type="hidden" name="group_idx" value="${lectureVo.group_idx}"/>
                <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}"/>
                <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}"/>
                <input type="hidden" name="postcode" id="postcode" value="${loginVo.zip}"/>
                <input type="hidden" name="apy_addr1" id="apy_addr1" value="${loginVo.adres}"/>
                <input type="hidden" name="apy_addr2" id="apy_addr2" value="${loginVo.detail_adres}"/>
                <input type="hidden" name="apy_type" id="apy_type" value="${lectureVo.status_code}"/>
                <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                <input type="hidden" name="apy_ref_mob_no" id="apy_ref_mob_no" />
                <input type="hidden" name="age_type" id="age_type" value="${lectureVo.age_type}"/>
                <input type="hidden" name="fee_type" id="fee_type" value="${lectureVo.fee_type}"/> <!--지불 방법 -->
                <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20 clearfix">
                    <span class="dp_inb float_left">신청자 정보</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point fw_300 mt_5">*필수입력</span>
                </h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">신청자 정보의 신청자 이름, 휴대폰 번호, 주소</caption>
                    <tbody>
                    <tr>
                        <th class="wid_300"><span class="point">*</span>신청자 이름 </th>
                        <td colspan="3">${loginVo.user_nm}</td>
                    </tr>
                    <tr>
                        <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                        <td colspan="3">
                            <div class="fm_phon">
                                <span class="sel_box" title="휴대전화 앞번호">
                                    <select name="mob_1" id="mob_1" title="휴대전화 앞번호">
                                        <option value="">선택</option>
                                        <option value="010" <c:if test="${lectureVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${lectureVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${lectureVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${lectureVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${lectureVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                    </select>
                                </span>
                                <span class="dash">-</span>
                                <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${lectureVo.mob_2}">
                                </span>
                                <span class="dash">-</span>
                                <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${lectureVo.mob_3}">
                                </span>
                            </div>
                            <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300"><span class="point">*</span>주소</th>
                        <td colspan="3">(${loginVo.zip}) ${loginVo.adres} ${loginVo.detail_adres}</td>
                    </tr>
                    <tr>
                        <th class="wid_300">코로나19<br>백신접종여부</th>
                        <td colspan="3">
                            <div>
                                <label class="fm_rd act_uiRdCh mr_20">
                                    <input type="radio" name="vaccine_yn" id="vaccine_n" value="N" checked><span>미접종</span>
                                </label>
                                <label class="fm_rd act_uiRdCh">
                                    <input type="radio" name="vaccine_yn" id="vaccine_y" value="Y"><span>접종 / 접종일</span>
                                </label>
                            </div>
                            <div class="row mt_10">
                                <div class="col_4 col_lg_7 col_md_12 pr_10">
                                    <div class="fm_cal full" style="max-width: none;">
                                        <div class="fm_inp fm_date mr_10" style="max-width: none;">
                                            <input type="text" class="inp" title="날짜" name="vaccine_dt" id="vaccine_dt" disabled>
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">학생</th>
                        <td>
                            <div class="col_2 col_md_12">
                                <div class="sel_box">
                                    <select name="student_type" id="student_type" title="학생조건" class="placeholder">
                                        <option value="">선택</option>
                                        <option value="유치원">유치원</option>
                                        <option value="초등학생">초등학생</option>
                                        <option value="중학생">중학생</option>
                                        <option value="고등학생">고등학생</option>
                                    </select>
                                </div>
                            </div>
                        </td>
                        <th class="wid_300">학년</th>
                        <td>
                            <div class="col_2 col_md_12">
                                <div class="sel_box">
                                    <select name="student_grade" id="student_grade" title="학년" class="placeholder">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <h5 class="fs_18 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">
                <label class="fm_ch act_uiRdCh">
                    <input type="checkbox" name="ch_1" id="disabledToggle"><span class="ml_5">교육대상이 미성년 자제인 경우 선택해 주세요.</span>
                </label>
            </h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">교육대상이 미성년 자제인 경우 정보 입력내용의 신청자와의 관계, 교육대상자 이름, 휴대전화 </caption>
                    <tbody class="disabled">
                    <tr>
                        <th class="wid_300">신청자와의 관계</th>
                        <td>
                            <div class="fm_inp"><input type="text" id="apy_ref" name="apy_ref" class="inp" title="신청자와의 관계" disabled></div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">교육대상자 이름</th>
                        <td>
                            <div class="fm_inp"><input type="text" id="apy_real_name" name="apy_real_name" class="inp" title="교육대상자 이름" disabled></div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_300">휴대전화</th>
                        <td>
                            <div class="mb_10 fs_16">
                                <label class="fm_ch act_uiRdCh ">
                                    <input type="checkbox" name="ch_2" id="same_mob_no" disabled><span class="ml_5">신청자와 동일</span>
                                </label>
                            </div>
                            <div class="fm_phon">
                                <span class="sel_box">
                                    <select name="ref_mob_1" id="ref_mob_1" title="전화번호 앞번호" disabled>
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
                                    <input type="text" class="inp" name="ref_mob_2" id="ref_mob_2" title="전화번호 중간번호" data-inp-type="number" disabled maxlength="4">
                                </span>
                                <span class="dash">-</span>
                                <span class="fm_inp">
                                    <input type="text" class="inp" name="ref_mob_3" id="ref_mob_3" title="전화번호 끝번호" data-inp-type="number" disabled maxlength="4">
                                </span>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                    <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub fw_300">
                        <li>개인정보의 수집 이용 목적 : 프로그램 신청 및 관련 안내</li>
                        <li>수집하려는 개인정보의 항목 : (필수) 성명, 휴대폰 번호, 주소 (선택) 코로나19 백신접종여부, 학생, 학년</li>
                        <li><b>개인정보의 보유 및 이용기간 : 회원 탈퇴를 요청하거나 수집이용 목적을 달성하거나 보유이용기간이 종료한 경우, 사업 폐지 등의 사유발생시 당해 개인정보를 지체없이 파기합니다.</b></li>
                        <li>개인정보보호법 제15조에 따라 개인정보의 수집이용목적에 대한 동의를 거부할 수 있으며, 동의 거부 시 송파쌤 교육포털 홈페이지에서 제공하는 서비스 이용에 어려움이 있을 수 있습니다.</li>
                    </ul>
                    <div>
                        <span style="vertical-align: middle;">필수&nbsp;&nbsp;&nbsp;</span>
                        <label class="fm_rd act_uiRdCh mr_20">
                            <input type="radio" name="agree_yn" id="agree_y" value="Y"><span>동의</span>
                        </label>
                        <label class="fm_rd act_uiRdCh">
                            <input type="radio" name="agree_yn" id="agree_n" value="N" checked><span>미동의</span>
                        </label>
                    </div>
                    <div class="mt_20">
                        <span style="vertical-align: middle;">선택&nbsp;&nbsp;&nbsp;</span>
                        <label class="fm_rd act_uiRdCh mr_20">
                            <input type="radio" name="agree_opt_yn" id="agree_opt_y" value="Y"><span>동의</span>
                        </label>
                        <label class="fm_rd act_uiRdCh">
                            <input type="radio" name="agree_opt_yn" id="agree_opt_n" value="N" checked><span>미동의</span>
                        </label>
                    </div>
                </div><!--agree_box //-->
            </form>
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/youth/program/lecture_view.do?lecture_idx=${lectureVo.lecture_idx}" class="btn btn_long btn_big t_center mr_15">취소</a>
                <a href="#none" class="btn btn_long btn_big btn_color_1 t_centermr_20" id="btn_submit">신청하기</a>
            </div>
        </div>
    </div><!-- sub_con : e -->
    <!--
        2020.10.26 : start
        강의장소보기
        Event > sub.js
        close_btn : click > sub.js
    -->
    <div class="popup_wrap_st3" id="popup1">
        <div class="popup_box">
            <div class="popup_top">
                <p>강의장소보기</p>
            </div>
            <div class="popup_con">
                <div class="table_box t_center">
                    <table class="st_2">
                        <caption class="text_hide">강의장소안내의 교육장소, 주소, 연락처</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="76%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="t_left">교육장소</th>
                            <td><p class="mlr_20 t_left">송파 미래교육센터 1관</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">주소</th>
                            <td><p class="mlr_20 t_left">서울시 송파구 송파대로1 ,1 송파빌딩 1층</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">연락처</th>
                            <td><p class="mlr_20 t_left">02-2147-5322</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="popup_map mt_30">
                    <!--text 제거 : 임시-->
                    <p class="t_center ptb_55 fs_30">MAP</p>
                    <!--text 제거 : 임시-->
                </div>
            </div>
            <div class="popup_btn clearfix">
                <button type="button" class="btn float_left"><i class="icon_print mr_5">프린트</i><span class="fs_20 fs_md_26">인쇄</span></button>
                <button type="button" data-popup-id="#popup1" class="btn float_right btn_short close_btn"><span class="fs_20 fs_md_26">닫기</span></button>
            </div>
            <button class="close_btn" data-popup-id="#popup1"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>
</div>
