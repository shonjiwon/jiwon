<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '이용안내 > 마그넷스쿨 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
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
                        <a href="#" class="deapth_tit" title="선택">이용안내</a>
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
            <a href="#" class="tab_m">이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_3"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="sub_info_visual st_5 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <h5 class="fs_38">마그넷스쿨 이란?</h5>
                    <p class="fs_22 fs_md_24 mt_40 mt_md_20">
                        송파마그넷 스쿨은 학습자가 원하는 강좌를 신청하면 강사 학습자 <br class="screen_hide screen_md_show"> 학습공간을 연결해주는 학교로 자석처럼 학생을<br>
                        끌어당기는 맞춤교육입니다. 배우고 싶던 교육이 있으셨나요? <br class="screen_hide screen_md_show">
                        기다리지 말고 지금 신청해보세요.
                    </p>
                    <!--2020.11.09 : s-->
                    <ul class="row row_md pt_60 fs_20 fs_md_24 fw_300">
                        <li class="col_3 col_md_6">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_5_img_01.png" alt="책"></div>
                            <div class="text_box mt_15">
                                <p>
                                    배우고 싶어요
                                </p>
                            </div>
                        </li>
                        <li class="col_3 col_md_6">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_5_img_02.png" alt="배움"></div>
                            <div class="text_box mt_15">
                                <p>
                                    가르칠 수 있어요
                                </p>
                            </div>
                        </li>
                        <li class="col_3 col_md_6 mt_md_20">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_5_img_03.png" alt="학교"></div>
                            <div class="text_box mt_15">
                                <p>
                                    함께 배워요
                                </p>
                            </div>
                        </li>
                        <li class="col_3 col_md_6 mt_md_20">
                            <div class="img_box"><img src="/ssem/resources/img/sub/sub_info_visual_5_img_04.png" alt="공유"></div>
                            <div class="text_box mt_15">
                                <p>
                                    배움 공유 채널
                                </p>
                            </div>
                        </li>
                    </ul>
                    <!--2020.11.09 : e-->
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_18 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">마그넷스쿨 이용안내</h1>
                <h2 class="c_tit_2 mt_25">이용안내 절차</h2>
                <div class="bg_color_4 ptb_70 mt_15">
                    <div class="grp_box fs_18 fs_md_26">
                        <div class="grp_line_box">
                            <div class="line1"></div>
                            <div class="line2"></div>
                        </div>
                        <div class="grp_tab mt_30">
                            <div class="grp_col">
                                <div class="grp_img_box">
                                    <div class="grp_img color_1">
                                        <i class="icon_book_w">책</i>
                                    </div>
                                    <div class="ml_20">
                                        <p class="fs_22 fs_md_30 fw_500">학습자</p>
                                        <p class="fw_300">배우고 싶어요 <br class="screen_hide screen_md_show"> (교육요청)</p>
                                    </div>
                                </div>

                                <div class="grp_img_box mt_60">
                                    <div class="grp_img color_2">
                                        <i class="icon_pan_w">칠판</i>
                                    </div>
                                    <div class="ml_20">
                                        <p class="fs_22 fs_md_30 fw_500">강사</p>
                                        <p class="fw_300">가르칠 수 있어요 <br class="screen_hide screen_md_show"> (지식제공)</p>
                                    </div>
                                </div>
                            </div>

                            <div class="grp_col t_right">
                                <div class="grp_img_2 fist">
                                    <span class="fs_22 fs_md_24 fw_500">마그넷 스쿨</span>
                                </div>
                            </div>

                            <div class="grp_col t_right">
                                <div class="grp_img_2 color_3">
                                    <span class="fs_22 fs_md_24 fw_500">수업개설</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col_10 col_md_9  mt_90">
                        <h2 class="c_tit_2 dp_inb va_m">
                            배우고 싶어요
                        </h2>
                        <span class="fw_300 dp_inb va_m fs_26 fs_md_28">(희망강좌 개설 요청)</span>
                    </div>
                    <div class="col_2 col_md_3 btn_full t_right mt_90 fs_md_20">
                        <a href="/ssem/youth/magnet/study_hope_list.do" class="btn btn_small fs_auto btn_auto va_m btn_round"><i class="icon_plus_b mr_5 screen_lg_hide dp_xxs_inb">배우고 싶어요 이동</i> <span class="screen_xxs_hide">배우고 싶어요</span> </a>
                    </div>
                </div>
                <div class="bg_color_4 bg_color_md_1 ptb_20 ptb_md_0 mt_15">
                    <div class="img_step_box st_2 t_center fs_20 fs_md_26">
                        <ul class="row_15">
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap">
                                    <span class="step_num" ptb_md_20>1</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_01.png" alt="가입">
                                        <p>
                                            <b class="fs_22 fs_md_26 dp_inb">가입</b><br>
                                            통합회원가입<br>&nbsp;
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap">
                                    <span class="step_num" ptb_md_20>2</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_02.png" alt="강좌 개설 신청">
                                        <p>
                                            <b class="fs_22 fs_md_26 dp_inb">강좌 개설 신청</b><br>
                                            마그넷 스쿨  “배우고 싶어요” <br>(송파구민)
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap ptb_md_20">
                                    <span class="step_num">3</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_03.png" alt="관리자 확인">
                                        <p><b class="fs_22 fs_md_26 dp_inb">관리자 확인</b><br>
                                            등록된 강의 검토<br>&nbsp;
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap ptb_md_20">
                                    <span class="step_num">4</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_04.png" alt="매칭 진행">
                                        <p><b class="fs_22 fs_md_26 dp_inb">매칭 진행</b><br>
                                            학습자 &middot; 강사 &middot; 공간 <br> 조정을 통해 매칭 진행
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap ptb_md_20">
                                    <span class="step_num">4</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_05.png" alt="완료">
                                        <p><b class="fs_22 fs_md_26 dp_inb">완료</b><br>
                                            최종 확정 후 <br>수업을 진행
                                        </p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_90 dp_inb va_m">함께 배워요 </h2><br class="screen_hide screen_md_show">
                <span class="fw_300 mt_90 mt_md_0 dp_inb va_m fs_26 fs_md_28">(관리자가 강의를 올리고 학생을 모집해서 연결)</span>
                <ul class="ul_list_dash fs_20 fs_md_26 mt_25">
                    <li>분기별로 “배우고 싶어요” 의 희망 강좌 중 호응도가 높은 프로그램을 만들고 함께 배울 학습자들을 모집하는 곳입니다.</li>
                    <li>강의 목록을 보시고 신청하기 버튼을 눌러주시면 선착순으로 등록됩니다.</li>
                </ul>
                <h2 class="c_tit_2 mt_90 dp_inb va_m">가르칠 수 있어요 </h2><br class="screen_hide screen_md_show">
                <span class="fw_300 mt_90 mt_md_0 dp_inb va_m fs_26 fs_md_28"> (강사 지원 및 등록신청)</span>
                <ul class="ul_list_dash fs_20 fs_md_26 mt_25">
                    <li>등록 신청된 “배우고 싶어요” 의 희망 강좌를 통하여 강사분들이 직접 등록신청하는 곳입니다.</li>
                    <li>청원된 “배우고 싶어요” 게시글을 보시고 가르칠 수 있어요 버튼을 눌러 지원해 주세요.</li>
                </ul>
            </div>
        </section>
    </div>
</div>
