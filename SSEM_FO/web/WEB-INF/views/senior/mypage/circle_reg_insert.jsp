<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '평생학습동아리 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_update").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("평생학습 동아리 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
        });
    });

    function cancel_frm() {
        $("#frm_cancel").submit();
    }

    function update_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.name, "동아리명")){return false;}
        if(!fnIsValidRequired(frm.code_idx, "분야")){return false;}
        if(!fnIsValidRequired(frm.action, "주요활동")){return false;}

        $("#apy_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm").submit();
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
                        <a href="#" class="deapth_tit" title="선택">평생학습동아리</a>
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
            <a href="#" class="tab_m act">평생학습동아리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">평생학습동아리</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <ul class="tab tab_1">
                <li class="tab_item on"><a href="/ssem/senior/mypage/circle_reg_list.do">동아리신청</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <form name="frm_cancel" id="frm_cancel" action="/ssem/senior/mypage/circle_reg_cancel.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="club_idx" value="${clubVo.club_idx}"/>
        </form>
        <form name="frm" id="frm" action="/ssem/senior/mypage/circle_reg_insert.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
            <input type="hidden" name="club_idx" value="${clubVo.club_idx}"/>
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">동아리신청</h1>
                <h2 class="c_tit_2 ptb_15">회원 기본 정보</h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">동아리신청 회원 기본 정보의 신청자 이름, 휴대폰 번호</caption>
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
                                    <select name="mob_1" id="mob_1" title="전화번호 앞번호">
                                        <option value="">선택</option>
                                        <option value="010" <c:if test="${clubVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${clubVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${clubVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${clubVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${clubVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                    </select>
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_2" id="mob_2" title="전화번호 중간번호" data-inp-type="number" maxlength="4" value="${clubVo.mob_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_3" id="mob_3" title="전화번호 끝번호" data-inp-type="number" maxlength="4" value="${clubVo.mob_3}">
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
                        <caption class="text_hide">신청 폼의 신청 상태, 동아리명, 분야, 창립일, 소속기관, 회원수, 모임주기 및 요일, 모임장소, 동아리 소개, 제출서류 첨부, 신청일</caption>
                        <tbody>

                        <tr>
                            <th class="wid_300">신청 상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${clubVo.status eq 'R'}"><span class="my_tc_2">신청대기</span></c:when>
                                    <c:when test="${clubVo.status eq 'C'}"><span class="my_tc_4">신청확인</span></c:when>
                                    <c:when test="${clubVo.status eq 'O'}"><span class="my_tc_1">인물도서 확정</span></c:when>
                                    <c:when test="${clubVo.status eq 'N'}"><span class="my_tc_3">신청취소</span></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>동아리명</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" name="name" id="name" class="inp" title="동아리명" value="${clubVo.name}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>분야</th>
                            <td>
                                <div class="sel_box">
                                    <select name="code_idx" id="code_idx" title="분야" class="placeholder">
                                        <c:forEach items="${codeList}" var="code" varStatus="status">
                                            <option value="${code.code_idx}" <c:if test="${clubVo.code_idx eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">창립일</th>
                            <td class="">
                                <div class="fm_cal st_2 full">
                                    <div class="fm_inp fm_date mr_10">
                                        <input type="text" class="inp" title="날짜" name="stand_dt" id="stand_dt" value="${fn:substring(clubVo.stand_dt, 0, 10)}">
                                        <button type="button" class="fm_date_btn">
                                            <i class="icon_cal">달력</i>
                                        </button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">소속기관</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="org_name" id="org_name" title="소속기관" value="${clubVo.org_name}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">회원수</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="mem_cnt" id="mem_cnt" title="회원수" value="${clubVo.mem_cnt}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">모임주기 및 요일</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="meet_dt" id="meet_dt" title="주 1회, 격주모임" value="${clubVo.meet_dt}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">모임장소</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="meet_plc" id="meet_plc" title="모임장소" value="${clubVo.meet_plc}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">동아리 소개</th>
                            <td class="" colspan="2">
                                <div class="fm_tf">
                                    <textarea name="intro" id="intro" title="동아리 소개">${clubVo.intro}</textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주요활동</th>
                            <td class="" colspan="2">
                                <div class="fm_tf h_140">
                                    <textarea name="action" id="action" title="주요활동">${clubVo.action}</textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">제출서류 첨부</th>
                            <td>
                                <div class="fm_file_btn act_uiFileBtn">
                                    <input type="file" name="attfile" id="attfile#" title="파일 첨부">
                                    <button type="button" class="btn btn_line">파일 찾기</button>
                                    <input type="text" class="inp" readonly="" title="파일 이름">
                                </div>
                                <p class="tc_sub fs_16 fs_md_22 mt_5"> (파일형식 : jpg, jpge, bmp, gif / 사이즈 : 000*000)</p>
                                <div class="file_box">
                                    <c:forEach items="${clubVo.fileList}" var="file" varStatus="status">
                                        <a href="/ssem/file/fileDown.do?atchFileId=${file.atch_file_id}&amp;fileNum=${file.file_num}" class="file_name">${file.file_ori_nm}</a>
                                        <a type="button" class="btn" id="btn_file_del_${file.atch_file_id}_${file.file_num}">삭제</a>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청일</th>
                            <td>
                                ${fn:substring(item.stand_dt, 0, 16)}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                    <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용에 대한 안내</p>
                    <ul class="ul_list_dot mb_20 tc_sub fw_300">
                        <li>개인정보의 수집ㆍ이용 목적  : 평생학습동아리 신청 및 관련 안내</li>
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
                <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                    <div class="row">
                        <div class="col_6 offset_3 offset_md_0 col_md_9">
                            <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_update">저장</button>
                            <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                        </div>
                        <div class="col_3 t_right">
                            <a href="/ssem/senior/mypage/circle_reg_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        </form>
    </div>
</div>
