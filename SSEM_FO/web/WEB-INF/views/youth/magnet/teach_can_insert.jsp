<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '배우고 싶어요 > 마그넷스쿨 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        $("#btn_submit").click(function(){
            modalMsg("가르칠 수 있어요를 지원 하시겠습니까?", 'yesorno', insert_frm);
        });
    });

    function insert_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.code_idx, "교육분야")){return false;}
        if(!fnIsValidRequired(frm.name, "강의명")){return false;}
        if(!fnIsValidRequired(frm.cont, "강좌계획")){return false;}
        if(!fnIsValidRequired(frm.career_atch_file, "강사이력 첨부파일")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm").submit();
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
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">배우고 싶어요</a>
                        <ul>
                            <li><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                            <li><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">마그넷스쿨</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">배우고 싶어요<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_3"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
            </ul>
        </div><!-- tab_box //-->
        <form name="frm" id="frm" action="/ssem/youth/magnet/teach_can_insert.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
            <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}"/>
            <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}"/>
            <input type="hidden" name="hope_study_idx" id="hope_study_idx" value="${teachStudyVo.hope_study_idx}"/>
            <section class="text_con fs_18 fs_md_26 mt_100">
                <div class="wrap ">
                    <h2 class="c_tit_2 mt_95 mb_25 clearfix">
                        <span class="dp_inb float_left">가르칠 수 있어요 신청하기</span>
                        <span class="dp_inb float_right fs_18 fs_md_24 tc_point fw_300 mt_5">*필수입력</span>
                    </h2>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">가르칠 수 있어요 신청의 강사명, 휴대폰 번호, 교육분야, 강의명, 강좌계획, 강의계획서, 강사이력</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강사명</th>
                                <td>${loginVo.user_nm}</td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon">
								<span class="sel_box" title="휴대전화 앞번호">
									<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
										<option value="">선택</option>
										<option value="010" <c:if test="${teachStudyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${teachStudyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${teachStudyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${teachStudyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${teachStudyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
									</select>
								</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
									<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${teachStudyVo.mob_2}">
								</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
									<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${teachStudyVo.mob_3}">
								</span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22 ">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>교육분야</th>
                                <td>
                                    <div class="sel_box">
                                        <select title="분류" name="code_idx" id="code_idx" class="placeholder">
                                            <option value="">분야를 선택하세요.</option>
                                            <c:forEach items="${codeList}" var="code" varStatus="status">
                                                <option value="${code.code_idx}">${code.cd_val}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강의명</th>
                                <td>
                                    <div class="fm_inp inp_full mr_30 mr_lg_0"><input type="text" class="inp" id="name" name="name" title="강의명"></div>
                                </td>
                            </tr>

                            <tr>
                                <th class="wid_300"><span class="point">*</span>강좌계획</th>
                                <td>
                                    <div class="fm_tf mr_30 mr_lg_0">
                                        <textarea class="act_word_cnt fw_300" onkeyup="calcWordLng(200)" data-max-word="200" placeholder="강의 진행계획이나 커리큘럼 등을 적어주세요." title="강의계획" name="cont" id="cont"></textarea>
                                        <span class="fw_200 fs_18 word_cnt_wrap"><b class="now_cnt fw_200">0</b> / 200</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">강의계획서</th>
                                <td>
                                    <div class="fm_file_btn st_2 act_uiFileBtn">
                                        <input type="file" name="teach_atch_file_id" id="teach_atch_file_id" title="강의계획서 파일 첨부">
                                        <button type="button" class="btn btn_line fw_300">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="강의계획서 파일 이름">
                                    </div>
                                    <p class="fs_16 fs_md_20 mt_5">* 파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.</p>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강사이력</th>
                                <td>
                                    <div class="fm_file_btn st_2 act_uiFileBtn">
                                        <input type="file" name="career_atch_file_id" id="career_atch_file_id" title="강사이력 파일 첨부">
                                        <button type="button" class="btn btn_line fw_300">파일 찾기</button>
                                        <input type="text" class="inp" name="career_atch_file" readonly="" title="강사이력 파일 이름">
                                    </div>
                                    <p class="fs_16 fs_md_20 mt_5">* 강사로 활동하신 이력 이나 본인의 프로필을 등록해 주세요. (파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.)</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                        <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                        <ul class="ul_list_dot mb_20 tc_sub fw_300">
                            <li>개인정보의 수집ㆍ이용 목적  :  가르칠 수 있어요 신청 및 관련 안내</li>
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
                        <a href="/ssem/youth/magnet/study_hope_view.do?hope_study_idx=${teachStudyVo.hope_study_idx}" class="btn btn_long btn_big t_center  mr_15">취소</a>
                        <a href="#none" class="btn btn_long btn_big t_center" id="btn_submit">지원</a>
                    </div>
                </div>
            </section>
        </form>
    </div>
</div>
