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
        $(document).prop('title', '배우고 싶어요 > 마그넷스쿨 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', cancel_frm);
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

        if(!fnIsValidRequired(frm.name, "희망강의명")){return false;}
        if(!fnIsValidRequired(frm.week, "희망요일일")){return false;}
        if(!fnIsValidRequired(frm.cont, "상세내용")){return false;}

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
                        <a href="#" class="deapth_tit" title="선택">배우고 싶어요</a>
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
                <li class="tab_item on"><a href="/ssem/senior/mypage/hope_study_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/teach_apply_list.do">가르칠 수 있어요</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/together_study_list.do">함께 배워요</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90 mb_15 clearfix">
                    <span class="dp_inb float_left">배우고 싶어요</span>
                    <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                </h1>
                <form name="frm_cancel" id="frm_cancel" action="/ssem/senior/mypage/hope_study_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="hope_study_idx" value="${hopeStudyVo.hope_study_idx}" />
                </form>
                <form name="frm" id="frm" action="/ssem/senior/mypage/hope_study_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="hope_study_idx" value="${hopeStudyVo.hope_study_idx}"/>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">배우고 싶어요 신청폼의 청원신청, 청원기간, 성명, 휴대폰 번호, 주소, 단체명/인원, 희망강의명, 희망요일, 상세내용, 등록일</caption>
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
                                <th class="wid_300"><span class="point">*</span>성명</th>
                                <td>${hopeStudyVo.apy_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon pr_10">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
											<option value="">선택</option>
											<option value="010" <c:if test="${hopeStudyVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${hopeStudyVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${hopeStudyVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${hopeStudyVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${hopeStudyVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
										</select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${hopeStudyVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${hopeStudyVo.mob_3}">
									</span>
                                    </div>
                                    <span class="dp_inb tc_sub fs_16 fs_md_22 ">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>주소</th>
                                <td>
                                    <p>(${hopeStudyVo.postcode})</p>
                                    <p class="mt_5">
                                        <span>${hopeStudyVo.apy_addr1}</span>
                                        <span>${hopeStudyVo.apy_addr2}</span>
                                    </p>
                                </td>
                            </tr>

                            <tr>
                                <th class="wid_300">단체명/인원</th>
                                <td>
                                    <div class="fm_inp inp_wid_400 dp_inb"><input type="text" class="inp" name="grp_name" id="grp_name" title="단체명" value="${hopeStudyVo.grp_name}"></div>
                                    <div class="fm_inp mr_10 inp_wid_140 dp_inb"><input type="text" class="inp" name="grp_cnt" id="grp_cnt" data-inp-type="number" title="인원" value="${hopeStudyVo.grp_cnt}"></div>명
                                    <p class="fs_16 fs_md_20 mt_10">* 개인이 아닌 단체로 신청하실 경우, 단체명을 적어주세요.</p>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>희망강의명</th>
                                <td>
                                    <div class="fm_inp inp_full mr_30 mr_lg_0"><input type="text" class="inp" name="name" id="name" title="희망강의명" value="${hopeStudyVo.name}"></div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>희망요일</th>
                                <td>
                                    <div class="fm_inp inp_full mr_30 mr_lg_0"><input type="text" class="inp" name="week" id="week" title="희망요일" value="${hopeStudyVo.week}"></div>
                                    <p class="fs_16 fs_md_20 mt_5">* 강의가 개설되기를 희망하는 요일을 적어주세요. 강의개설에 참고합니다. </p>
                                </td>
                            </tr>

                            <tr>
                                <th class="wid_300"><span class="point">*</span>상세내용</th>
                                <td>
                                    <div class="fm_tf h_140 mr_30 mr_lg_0">
                                        <textarea title="상세내용" name="cont" id="cont">${hopeStudyVo.cont}</textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">등록일</th>
                                <td>
                                    ${fn:substring(hopeStudyVo.reg_dt, 0, 16)}
                                </td>
                            </tr>
                            <tr class="bg_color_2">
                                <td colspan="2">
                                    <div class="ptb_30 mr_20 clearfix">
                                        <p class="fs_26 fs_md_32 fw_500 tc_b float_left">원하시는 강의인가요? 함께 참여해 주세요.</p>
                                    </div>
                                    <div class="bg_color_1 tc_b ptb_30 plr_30 mr_20 mb_30">
                                        <p class="fs_24 fs_md_30">
                                            지금 ##의 구민이 함께 참여 중입니다.
                                        </p>
                                        <div class="fs_18 fs_md_24 mt_20">
                                            <ul class=" user_img_list">
                                                <c:forEach items="${joinList}" var="join" varStatus="status">
                                                    <li>
                                                        <span class="img_box">&nbsp;</span>
                                                        <span>${join.apy_id}</span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->
                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                        <div class="row">
                            <c:choose>
                                <c:when test="${hopeStudyVo.select_yn ne 'Y'}">
                                    <div class="col_6 offset_3 offset_md_0 col_md_9">
                                        <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                        <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">삭제</button>
                                    </div>
                                    <div class="col_3 t_right">
                                        <a href="/ssem/senior/mypage/hope_study_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="t_right">
                                        <a href="/ssem/senior/mypage/hope_study_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
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
