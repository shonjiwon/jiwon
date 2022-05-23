<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '온라인 상담예약 > 진학학습지원센터 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("온라인 상담에약을 취소하시겠습니까?", 'yesorno', cancel_frm);
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
                            location.href = "?self_counsel_idx=${selfCounselVo.self_counsel_idx}";
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

        if(!fnIsValidRequired(frm.meet_date_str, "희망 상담일")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
        $("#meet_dt").val(frm.meet_date_str.value + ' / ' + frm.meet_day_str.value);
        $("#able_phone_time").val(frm.able_start_time.value + '시 ~ ' + frm.able_end_time.value + '시');

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
                        <a href="#" class="deapth_tit" title="선택">진학학습지원센터</a>
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
            <a href="#" class="tab_m act">진학학습지원센터<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">진학학습지원센터</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <ul class="tab tab_1">
                <li class="tab_item on"><a href="/ssem/youth/mypage/online_counsel_list.do">온라인 상담예약</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">온라인 상담예약</h1>
                <h2 class="c_tit_2 ptb_15">회원 기본 정보</h2>
                <form name="frm_cancel" id="frm_cancel" action="/ssem/youth/mypage/online_counsel_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="self_counsel_idx" value="${selfCounselVo.self_counsel_idx}" />
                </form>
                <form name="frm" id="frm" action="/ssem/youth/mypage/online_counsel_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="self_counsel_idx" value="${selfCounselVo.self_counsel_idx}" />
                    <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
                    <input type="hidden" name="meet_dt" id="meet_dt" />
                    <input type="hidden" name="able_phone_time" id="able_phone_time" />
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">회원 기본 정보의 신청자 ID, 신청자 이름, 휴대전화 번호</caption>
                            <tbody>
                            <tr>
                                <th class="wid_300">신청자 ID</th>
                                <td>
                                    ${selfCounselVo.reg_id}
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">신청자 이름 </th>
                                <td>${selfCounselVo.apy_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300">휴대폰 번호</th>
                                <td>
                                    <div class="fm_phon">
									<span class="sel_box" title="휴대전화 앞번호">
										<select name="mob_1" id="mob_1" title="휴대전화 앞번호">
											<option value="">선택</option>
											<option value="010" <c:if test="${selfCounselVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                            <option value="011" <c:if test="${selfCounselVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                            <option value="016" <c:if test="${selfCounselVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                            <option value="017" <c:if test="${selfCounselVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                            <option value="019" <c:if test="${selfCounselVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
										</select>
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${selfCounselVo.mob_2}">
									</span>
                                        <span class="dash">-</span>
                                        <span class="fm_inp">
										<input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${selfCounselVo.mob_3}">
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
                        <span class="dp_inb float_left">예약 신청 정보</span>
                        <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                    </h2>
                    <!--2020.11.04:e-->
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">예약 신청의 예약상태, 희망 상담유형, 희망 상담일, 통화 가능시간, 신청자 메모, 신청일, 상담예약일시</caption>
                            <tbody>

                            <tr>
                                <th class="wid_300">예약 상태</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${selfCounselVo.status eq 'A'}"><span class="btn sml purple">예약접수</span></c:when>
                                        <c:when test="${selfCounselVo.status eq 'R'}"><span class="btn sml orange">예약완료</span></c:when>
                                        <c:when test="${selfCounselVo.status eq 'O'}"><span class="btn sml sky">상담완료</span></c:when>
                                        <c:when test="${selfCounselVo.status eq 'C'}"><span class="btn sml lightGrey">예약취소</span></c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>희망 상담유형</th>
                                <td>
                                    <div class="sel_box">
                                        <select title="분류" name="gubun" id="gubun" class="placeholder">
                                            <option value="J" <c:if test="${selfCounselVo.gubun eq 'J'}">selected="selected"</c:if>>진학</option>
                                            <option value="S" <c:if test="${selfCounselVo.gubun eq 'S'}">selected="selected"</c:if>>학습</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>희망 상담일</th>
                                <td class="">
                                    <div class="fm_cal st_2 full">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" title="날짜" name="meet_date_str" id="meet_date_str" value="${selfCounselVo.meet_date_str}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                        <div class="sel_box" title="오전 오후 선택">
                                            <select class="placeholder" name="meet_day_str" id="meet_day_str">
                                                <option value="오전" <c:if test="${selfCounselVo.meet_day_str eq '오전'}">selected="selected"</c:if>>오전</option>
                                                <option value="오후" <c:if test="${selfCounselVo.meet_day_str eq '오후'}">selected="selected"</c:if>>오후</option>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300"><span class="point">*</span>통화 가능시간</th>
                                <td class="">
                                    <div class="fm_cal full">
                                        <span>평일</span>
                                        <div class="sel_box ml_10">
                                            <select name="able_start_time" id="able_start_time">
                                                <option value="09" <c:if test="${selfCounselVo.able_start_time eq '09'}">selected="selected"</c:if>>09</option>
                                                <option value="10" <c:if test="${selfCounselVo.able_start_time eq '10'}">selected="selected"</c:if>>10</option>
                                                <option value="11" <c:if test="${selfCounselVo.able_start_time eq '11'}">selected="selected"</c:if>>11</option>
                                                <option value="12" <c:if test="${selfCounselVo.able_start_time eq '12'}">selected="selected"</c:if>>12</option>
                                                <option value="13" <c:if test="${selfCounselVo.able_start_time eq '13'}">selected="selected"</c:if>>13</option>
                                                <option value="14" <c:if test="${selfCounselVo.able_start_time eq '14'}">selected="selected"</c:if>>14</option>
                                                <option value="15" <c:if test="${selfCounselVo.able_start_time eq '15'}">selected="selected"</c:if>>15</option>
                                                <option value="16" <c:if test="${selfCounselVo.able_start_time eq '16'}">selected="selected"</c:if>>16</option>
                                                <option value="17" <c:if test="${selfCounselVo.able_start_time eq '17'}">selected="selected"</c:if>>17</option>
                                                <option value="18" <c:if test="${selfCounselVo.able_start_time eq '18'}">selected="selected"</c:if>>18</option>
                                            </select>
                                        </div>
                                        <span>시 <span class="screen_sm_hide">~</span> </span>
                                        <div class="sel_box ml_10">
                                            <select name="able_end_time" id="able_end_time">
                                                <option value="09" <c:if test="${selfCounselVo.able_end_time eq '09'}">selected="selected"</c:if>>09</option>
                                                <option value="10" <c:if test="${selfCounselVo.able_end_time eq '10'}">selected="selected"</c:if>>10</option>
                                                <option value="11" <c:if test="${selfCounselVo.able_end_time eq '11'}">selected="selected"</c:if>>11</option>
                                                <option value="12" <c:if test="${selfCounselVo.able_end_time eq '12'}">selected="selected"</c:if>>12</option>
                                                <option value="13" <c:if test="${selfCounselVo.able_end_time eq '13'}">selected="selected"</c:if>>13</option>
                                                <option value="14" <c:if test="${selfCounselVo.able_end_time eq '14'}">selected="selected"</c:if>>14</option>
                                                <option value="15" <c:if test="${selfCounselVo.able_end_time eq '15'}">selected="selected"</c:if>>15</option>
                                                <option value="16" <c:if test="${selfCounselVo.able_end_time eq '16'}">selected="selected"</c:if>>16</option>
                                                <option value="17" <c:if test="${selfCounselVo.able_end_time eq '17'}">selected="selected"</c:if>>17</option>
                                                <option value="18" <c:if test="${selfCounselVo.able_end_time eq '18'}">selected="selected"</c:if>>18</option>
                                            </select>
                                        </div>
                                        <span>시</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">신청자 메모</th>
                                <td class="" colspan="2">
                                    <div class="fm_tf">
                                        <textarea id="tf2" class="act_word_cnt" onkeyup="calcWordLng(200)" data-max-word="200" name="apy_memo" id="apy_memo">${selfCounselVo.apy_memo}</textarea>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">개인자료 업로드</th>
                                <td colspan="2">
                                    <div class="fm_file_btn st_2 act_uiFileBtn">
                                        <input type="file" name="atch_file_id" id="atch_file_id" title="개인자료 파일 첨부">
                                        <button type="button" class="btn btn_line fw_300">파일 찾기</button>
                                        <input type="text" class="inp" readonly="" title="개인자료 파일 이름">
                                    </div>
                                    <p class="fs_16 fs_md_20 mt_5">* 파일용량은 10M 이상 미만으로 제한하며, PDF, HWP, DOC, PPT 파일만 가능합니다.</p>
                                    <div class="file_box">
                                        <c:forEach items="${selfCounselVo.fileList}" var="file" varStatus="status">
                                            <a href="/ssem/file/fileDown.do?atchFileId=${file.atch_file_id}&amp;fileNum=${file.file_num}" class="file_name">${file.file_ori_nm}</a>
                                            <a type="button" class="btn" id="btn_file_del_${file.atch_file_id}_${file.file_num}">삭제</a>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">신청일</th>
                                <td>
                                    ${selfCounselVo.reg_dt}
                                </td>
                            </tr>
                            <tr>
                                <th class="wid_300">상담예약일시</th>
                                <td>
                                    ${selfCounselVo.resv_dt}
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" class="bg_1">
                                    <ul class="ul_list_dot ptb_40 fw_400 fs_18 fs_md_24 tc_sub">
                                        <li>상담예약 신청서를 제출해 주시면, 담당자가 확인 후 <span class="tc_1">송파구청 회원정보에 기재 된 회원님의 휴대폰번호</span>로 연락을 드려 상담 예약을 진행합니다.</li>
                                        <li>원활한 상담예약 진행을 위하여, 연락가능한 휴대폰번호로 회원정보 업데이트 부탁 드립니다.</li>
                                        <li>실제 상담진행 일정은 담당자와의 협의를 통해 결정 됩니다.</li>
                                    </ul>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div><!--table_box //-->

                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                        <div class="row">
                            <c:choose>
                                <c:when test="${selfCounselVo.status eq 'A'}">
                                    <div class="col_6 offset_3 offset_md_0 col_md_9">
                                        <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                        <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">예약 취소</button>
                                    </div>
                                    <div class="col_3 t_right">
                                        <a href="/ssem/youth/mypage/online_counsel_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="t_right">
                                        <a href="/ssem/youth/mypage/online_counsel_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
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
