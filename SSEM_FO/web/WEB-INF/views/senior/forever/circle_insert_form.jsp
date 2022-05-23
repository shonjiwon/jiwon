<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '등록 및 신청 > 평생학습동아리 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        $("#btn_submit").click(function(){
            modalMsg("동아리 등록 및 신청을 하시겠습니까?", 'yesorno', insert_frm);
        });

        $("#btn_canccel").click(function(){
            modalMsg("동아리 등록 및 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
        });
    });

    function cancel_frm() {
        location.href = "/ssem/senior/forever/circle_insert.do";
    }

    function insert_frm() {
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
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    평생교육
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생교육</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습도시 송파</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습동아리</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">연혁</a></li>
                            <li><a href="/ssem/senior/forever/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                            <li><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                            <li><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                            <li><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
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
        <h3 class="mt_80 tit font_sc mb_50">평생학습도시 송파</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">평생학습동아리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">평생학습동아리</h4>
        <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_4">
                <li class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">소개</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_insert.do">등록 및 신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_status_list.do">활동 현황</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_news_list.do">활동 소식</a></li>
            </ul>
        </div>
        <form name="frm" id="frm" action="/ssem/senior/forever/circle_insert_form.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="apy_mob_no" id="apy_mob_no" />
            <input type="hidden" name="reg_id" id="reg_id" value="${loginVo.user_id}"/>
            <input type="hidden" name="apy_name" id="apy_name" value="${loginVo.user_nm}"/>
            <section class="text_con wrap fs_20 fs_md_26  pb_100 mb_15">
                <h1 class="c_tit_1 mt_95">등록 및 신청</h1>
                <h2 class="c_tit_2 mt_15 mb_25">회원 기본 정보</h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 이름, 전화번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">이름</th>
                            <td>${loginVo.user_nm}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">전화번호</th>
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
                <h2 class="c_tit_2 mt_45 mb_25 clearfix">
                    <span class="dp_inb float_left">동아리 등록 신청</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">등록 신청 작성폼의 동아리명, 분야, 창립일, 소속기관, 회원수, 모임주기 및 요일, 모임장소, 동아리 소개, 주요활동, 제출서류 첨부</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>동아리명</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="name" id="name" title="동아리명"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>분야</th>
                            <td>
                                <div class="sel_box">
                                    <select name="code_idx" id="code_idx" title="분야" id="sel1">
                                        <option value="">분야 선택</option>
                                        <c:forEach items="${codeList}" var="code" varStatus="status">
                                            <option value="${code.code_idx}">${code.cd_val}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">창립일</th>
                            <td>
                                <div class="fm_cal mr_20">
                                    <div class="fm_inp fm_date mr_20">
                                        <input type="text" class="inp" name="stand_dt" id="stand_dt" title="창립일">
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
                                <div class="fm_inp"><input type="text" class="inp" name="org_name" id="org_name" title="소속기관"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">회원수</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="mem_cnt" id="mem_cnt" title="회원수" data-inp-type="number"></div> 명
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">모임주기 및 요일</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="meet_dt" id="meet_dt" title="모임주기 및 요일"></div> ex) 주 1회, 격주 모임
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">모임장소</th>
                            <td>
                                <div class="fm_inp"><input type="text" class="inp" name="meet_plc" id="meet_plc" title="모임장소"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">동아리 소개</th>
                            <td>
                                <div class="fm_tf hafl mr_20 mr_lg_0">
                                    <textarea name="intro" id="intro" title="동아리 소개"></textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>주요활동</th>
                            <td>
                                <div class="fm_tf hafl mr_20 mr_lg_0">
                                    <textarea name="action" id="action" title="주요활동"></textarea>
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
                                <p class="tc_sub fs_16 fs_md_22">* 동아리신청서, 동아리회원명부</p>
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
                <div class="btn_box mt_50  pb_30 t_center">
                    <button type="button" class="btn btn_long btn_big mr_15" id="btn_submit">신청하기</button>
                    <button type="button" class="btn btn_long btn_big mr_15" id="btn_canccel">취소하기</button>
                </div>
            </section>
        </form>
    </div>
</div>
