<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '가르칠 수 있어요 > 마그넷스쿨 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("가르칠 수 있어요 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
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
                            location.href = "?teach_study_idx=${teachStudyVo.teach_study_idx}";
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

        if(!fnIsValidRequired(frm.code_idx, "교육분야")){return false;}
        if(!fnIsValidRequired(frm.name, "강의명")){return false;}
        if(!fnIsValidRequired(frm.cont, "강좌계획")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        $("#frm").submit();
        //frm.submit();
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
                        <a href="#" class="deapth_tit" title="선택">마그넷스쿨</a>
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
                        <a href="#" class="deapth_tit" title="선택">가르칠 수 있어요</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/senior/mypage/teach_apply_list.do">가르칠 수 있어요</a></li>
                            <li><a href="/ssem/senior/mypage/together_study_list.do">함께배워요</a></li>
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
            <a href="#" class="tab_m act">마그넷스쿨<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->

        <h4 class="tit2 mt_95 mb_50">마그넷스쿨</h4>

        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do">배우고 싶어요</a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/teach_apply_list.do">가르칠 수 있어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/together_study_list.do">함께 배워요</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">가르칠 수 있어요</h1>
                <h2 class="c_tit_2 ptb_15 clearfix">
                    <span class="dp_inb float_left">배우고 싶어요 정보</span>
                    <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                </h2>
                <form name="frm_cancel" id="frm_cancel" action="/ssem/senior/mypage/teach_apply_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="teach_study_idx" value="${teachStudyVo.teach_study_idx}" />
                </form>
                <form name="frm" id="frm" action="/ssem/senior/mypage/teach_apply_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="teach_study_idx" value="${teachStudyVo.teach_study_idx}"/>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">배우고 싶어요 신청의 청원신청, 청원기간, 희망강의명, 내용, 함께 배워요</caption>
                            <tbody>
                            <c:if test="${hopeStudyVo.select_yn eq 'Y'}">
                            <tr>
                                <th class="wid_300">청원신청</th>
                                <td>
                                    <div class="mt_10">
                                        <span class="line_mark_box mr_10"><i class="icon_success mr_5">성공</i><span>청원성공</span></span>
                                        <span class="dp_inb va_m mr_10 mtb_md_10 screen_md_show">개설된 프로그램 명이 입력됩니다.</span>
                                        <a href="#" class="btn btn_color_1 btn_small btn_auto">프로그램 바로가기</a>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            <tr>
                                <th class="wid_300">청원기간</th>
                                <td>
                                    <p class="mt_10">${fn:substring(hopeStudyVo.reg_dt, 0, 10)} ~ ${hopeStudyVo.close_dt}</p>
                                    <p class="fs_16 fs_md_20 mt_5 mb_10">* 등록일로부터 한달동안 청원이 진행됩니다. 기간내에 많은 분들의 같이 참여하시면 강좌로 개설 될 수 있습니다.</p>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>희망강의명</th>
                                <td>
                                    ${hopeStudyVo.name}
                                </td>
                            </tr>


                            <tr>
                                <td colspan="2" class="td content_box">
                                    <div>
                                        ${hopeStudyVo.cont}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">함께 배워요</th>
                                <td>
                                    ${hopeStudyVo.join_cnt}명
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                        <span class="dp_inb float_left">신청 정보</span>
                        <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                    </h2>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">신청 정보의 강사명, 휴대폰 번호, 교육분야, 강의명, 강좌 계획, 강의 계획서, 강사이력</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강사명</th>
                                <td>${teachStudyVo.apy_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon pr_10">
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
                                    <div class="sel_box sel_md_short">
                                        <select name="code_idx" id="code_idx" title="교육분야" class="placeholder">
                                            <c:forEach items="${codeList}" var="code" varStatus="status">
                                                <option value="${code.code_idx}" <c:if test="${teachStudyVo.code_idx eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강의명</th>
                                <td>
                                    <div class="fm_inp inp_full mr_30 mr_lg_0"><input type="text" class="inp" id="name" name="name" title="강의명" value="${teachStudyVo.name}"></div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강좌계획</th>
                                <td>
                                    <div class="fm_tf h_140 mr_30 mr_lg_0">
                                        <textarea title="강좌계획" name="cont" id="cont">${teachStudyVo.cont}</textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">강의계획서</th>
                                <td>
                                    <div class="fm_file_btn act_uiFileBtn">
                                        <input type="file" name="teach_atch_file_id" id="teach_atch_file_id" title="파일 첨부">
                                        <button type="button" class="btn btn_line">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="파일 이름">
                                    </div>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5"> 파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.</p>

                                    <div class="file_box">
                                        <c:forEach items="${teachStudyVo.planFileList}" var="plan" varStatus="status">
                                            <a href="/ssem/file/fileDown.do?atchFileId=${plan.atch_file_id}&amp;fileNum=${plan.file_num}" class="file_name">${plan.file_ori_nm}</a>
                                            <a type="button" class="btn" id="btn_file_del_${plan.atch_file_id}_${plan.file_num}">삭제</a>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>강사이력</th>
                                <td>
                                    <div class="fm_file_btn act_uiFileBtn">
                                        <input type="file" name="career_atch_file_id" id="career_atch_file_id" title="파일 첨부">
                                        <button type="button" class="btn btn_line">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="파일 이름">
                                    </div>
                                    <p class="tc_sub fs_16 fs_md_22 mt_5">
                                        강사로 활동하신 이력 이나 본인의 프로필을 등록해 주세요. <br>
                                        (파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.)
                                    </p>

                                    <div class="file_box">
                                        <c:forEach items="${teachStudyVo.careerFileList}" var="career" varStatus="status">
                                            <a href="/ssem/file/fileDown.do?atchFileId=${career.atch_file_id}&amp;fileNum=${career.file_num}" class="file_name">${career.file_ori_nm}</a>
                                            <a type="button" class="btn" id="btn_file_del_${career.atch_file_id}_${career.file_num}">삭제</a>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <p class="fs_18 fs_md_26 mt_10 tc_point">※ 가르칠 수 있어요는 관리자 확인 후 선정이 되신 분에 한하여 개별적으로 연락을 드립니다.</p>

                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                        <div class="row">
                            <div class="col_6 offset_3 offset_md_0 col_md_9">
                                <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                            </div>
                            <div class="col_3 t_right">
                                <a href="/ssem/senior/mypage/teach_apply_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div>
</div>
