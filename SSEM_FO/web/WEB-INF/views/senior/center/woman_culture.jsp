<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-25
  Time: 오전 1:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파여성문화회관 > 교육지원 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_2"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    교육지원
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
                        <a href="#" class="deapth_tit" title="선택">교육지원</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파여성문화회관</a>
                        <ul>
                            <li><a href="/ssem/senior/center/woman_culture.do">송파여성문화회관</a></li>
                            <li><a href="/ssem/senior/center/life_culture.do">송파생활문화대학</a></li>
                            <li><a href="/ssem/senior/center/songpaga_info.do">송파가 송파하리 프로젝트</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_100 tit font_sc mb_50">송파여성문화회관</h3>
        <div class="sub_info_visual foreverEdu_st_4 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">송파여성문화회관</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_2 mt_85 mb_25">기관소개</h4>
            <ul class="ul_list_span st_2 tc_sub2">
                <li><span class="fw_600 tc_b"><i class="icon_location mr_10">위치</i>위치</span><span class="va_m">송파구 백제고분로 42길 5(송파동 113-2)</span></li>
                <li><span class="fw_600 tc_b"><i class="icon_building mr_10">규모</i>규모</span><span class="va_m">지하2층, 지상 3층(연면적 8,900.39㎡)</span></li>
                <li class="p_none">
				<span class="fw_600 tc_b">
					<i class="icon_book mr_10">강좌개수</i> 강좌개수
				</span>
                    <ul class="wm_step mt_25">
                        <li><span class="wms_item"><span class="text_wrap">문화&middot;교양강좌</span></span></li>
                        <li><span class="wms_item"><span class="text_wrap">직업능력개발강좌</span></span></li>
                        <li><span class="wms_item"><span class="text_wrap">건강강좌운영</span></span></li>
                        <li class="last"><span class="wms_item"><span class="text_wrap">총 370여개강좌</span></span></li>
                    </ul>
                </li>
                <li><span class="fw_600 tc_b"><i class="icon_tel mr_10">문의처</i>문의처</span><span class="va_m">02)2203-3330</span></li>
            </ul>
            <h4 class="c_tit_2 mt_85">이용안내</h4>
            <div class="img_step_box st_2 bg_color_4 bg_color_md_1 t_center fs_20 fs_md_26 ptb_30 ptb_md_0">
                <ul class="row_24">
                    <li class="col_5 col_md_12 offset_2 offset_md_0">
                        <div class="step_text_wrap">
                            <span class="step_num">1</span>
                            <div class="step_text_box">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_setp_01.png" alt="1.로그인 ">
                                <p class="fw_600 fs_22 fs_md_26 mt_10">1.로그인 </p>
                                <p class="mt_10">신규회원은 회원가입</p>
                            </div>
                        </div>
                    </li>
                    <li class="col_5 col_md_12">
                        <div class="step_text_wrap">
                            <span class="step_num">2</span>
                            <div class="step_text_box">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_setp_02.png" alt="2.강좌검색">
                                <p class="fw_600 fs_22 fs_md_26 mt_10">2.강좌검색</p>
                                <p class="mt_10">강좌검색/신청</p>
                            </div>
                        </div>
                    </li>
                    <li class="col_5 col_md_12">
                        <div class="step_text_wrap">
                            <span class="step_num">3</span>
                            <div class="step_text_box">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_setp_03.png" alt="3.신청 및 결제">
                                <p class="fw_600 fs_22 fs_md_26 mt_10">3.신청 및 결제</p>
                                <p class="mt_10">강좌검색/신청</p>
                            </div>
                        </div>
                    </li>
                    <li class="col_5 col_md_12">
                        <div class="step_text_wrap">
                            <span class="step_num">4</span>
                            <div class="step_text_box">
                                <img src="/ssem/resources/img/sub/foreverEdu/img_setp_04.png" alt="4.수강신청 확인">
                                <p class="fw_600 fs_22 fs_md_26 mt_10">4.수강신청 확인</p>
                                <p class="mt_10">내강좌 정보</p>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="dot_dashed_list mt_30">
                <ul>
                    <li>
                        <span>1. 로그인</span>
                        <ul class="ul_list_dash">
                            <li>회원가입 후 로그인</li>
                        </ul>
                    </li>
                    <li>
                        <span>2.강좌검색</span>
                        <ul class="ul_list_dash">
                            <li>홈페이지 메인 화면 오른쪽 퀵바 강좌검색 또는 교육사업 - 강좌검색/수강신청 클릭</li>
                            <li>메뉴 - 문화교양강좌 - 강좌시간표 또는 강좌검색/신청에서 원하는 강좌 선택</li>
                            <li>강좌 세부내역(강좌명, 운영시간, 요일, 강사, 강좌 교육개요 및 강의계획서)확인</li>
                        </ul>
                    </li>
                    <li>
                        <span>3.신청 및 결제</span>
                        <ul class="ul_list_dash">
                            <li>해당강좌 "수강신청"을 클릭(접수버튼은 수강신청기간 및 시간에만 보임)</li>
                            <li>"수강신청조회/취소"창으로 넘어가며 여기서 수강신청내역 확인 후 실시간계좌이체, 카드결제, 무통장입금(가상계좌) 중 선택하여 결제</li>
                            <li>기존회원 재등록시: 로그인하신 후[내강좌정보]를 클릭하여 기존접수 가능 강좌 조회 후 신청</li>
                        </ul>
                    </li>
                    <li>
                        <span>4.수강신청 확인</span>
                        <ul class="ul_list_dash">
                            <li>홈페이지 상단에 위차한 "내강좌정보" 클릭 후 수강신청 내역 확인</li>
                        </ul>
                    </li>
                </ul>
            </div>
            <h4 class="c_tit_2 mt_85">유의사항</h4>
            <div class="img_row_list st_b3 fs_20">
                <div class="table">
                    <div class="col_6">
                        <div class="img_box">
                            <img src="/ssem/resources/img/sub/foreverEdu/woman_img_01.jpg" alt="생각하는 여성">
                        </div>
                    </div>
                    <div class="col_6 por txt_wrap">
                        <ul class="bef_middot ptb_60 ptb_lg_40 ptb_md_60 pl_60 pr_20 pl_lg_20  fs_20 fs_md_26 lh_30 ">
                            <li class="mt_25 mt_lg_10">유아교실, 아동교실, 어린이교실 신청자 유의사항
                                <p class="fs_18 fs_md_24 fw_300 tc_sub2">- 수강아동이름으로 회원가입 후 강좌 신청(예: 부모이름으로 신청금지)</p>
                            </li>
                            <li class="mt_25 mt_lg_10">타인명으로 수강신청 및 양도 금지(확인 시 수강제한)</li>
                            <li class="mt_25 mt_lg_10">수강료 할인 혜택
                                <p class="fs_18 fs_md_24 fw_300 tc_sub2 mt_5">- 방문신청: 강의접수 시 구비서류 준비 후 1층 안내데스크에서 신청</p>
                                <p class="fs_18 fs_md_24 fw_300 tc_sub2 mt_5">- 온라인접수: 홈페이지 강의 접수 후 해당 분기 접수 기간 내 구비서류 준비하여 1층 안내데스크에서 감면</p>
                                <p class="fs_18 fs_md_24 fw_300 tc_sub2 mt_5">- 증빙서류제출 / 재료비 미포함 / 1강좌만 가능</p>
                            </li>
                            <li class="mt_25 mt_lg_10">접수시간: 09:30 ~ 18:00</li>
                            <li class="mt_25 mt_lg_10">정원의 50%미만인 강좌는 폐강될 수 있음</li>
                            <li class="mt_25 mt_lg_10">재료비 및 교재비는 본인부담</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="btn_box t_center mt_50">
                <a href="https://www.songpawoman.org/" class="btn btn_long" target="_blank" title="새창">홈페이지 바로가기</a>
            </div>
        </div>
    </div>
</div>
