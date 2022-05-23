<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '비전 > 송파쌤이란? > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_11"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    송파쌤(SSEM)
                </h2>
                <p class="tit_sub">
                    <strong>“세상에서 가장 큰 학교”</strong>
                    송파에서 나고 자라고 완성되는 <br>창의적 인재육성
                </p>
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤이란</a>
                        <ul>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/youth/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/youth/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/youth/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">비전</a>
                        <ul>
                            <li><a href="/ssem/youth/ssem/vision.do">비전</a></li>
                            <li><a href="/ssem/youth/ssem/organ.do">조직도</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="text_con ">
            <h3 class="mt_80 mb_50 tit font_sc">송파쌤이란?</h3>
            <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
                <h4 class="text_hide">탭</h4>
                <a href="#" class="tab_m">비전<i class="icon_arrow_down_w ml_60">다운</i></a>
                <ul class="tab tab_2"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                    <li  class="tab_item on"><a href="/ssem/youth/ssem/vision.do">비전</a></li>
                    <li  class="tab_item"><a href="/ssem/youth/ssem/organ.do">조직도</a></li>
                </ul>
            </div><!-- tab_box //-->


            <div class="wrap fw_300 fs_20 fs_md_24 ls_75 li_16">

                <div class="greeting_box">
                    <div class="gb_text">
                        <p class="tc_1 fw_700 fs_38">인사말씀</p>
                        <p class="fs_26 fs_md_28 mt_20">
                            반갑습니다. <br class="screen_hide screen_md_show"> <b class="fs_500">송파구청장 박성수</b>입니다.<br>
                            <b class="fs_500">송파쌤(SSEM) 교육포털</b>에 <br class="screen_hide screen_md_show">오신 것을 환영합니다.
                        </p>
                    </div>
                </div>

                <p class="mt_30 mt_md_40"> 송파구의 인구는 서울시 25개 자치구 가운데 가장 많습니다. 인구는 모든 연령층에 비교적 고르게 분포되어 있습니다. 그렇다 보니, 교육에 대한 욕구도 모든 연령층에서 다양하게 나타납니다. <br>
                이러한 특성을 지닌 송파에 정말 필요한 교육이 무엇일까. 그 고민에서 탄생한 것이 송파쌤 입니다.</p>

                <p class="mt_30 mt_md_40"><b class="fw_500">송파쌤은 송파구만의 특화된 교육지원체계이자 플랫폼입니다. </b>송파의 기존 교육 인프라와 교육 사업을 총망라하고, 송파의 지역적 특색에 맞춘 새로운 교육시스템을 개발해 이를 통합했습니다. <br>
                핵심목표는 <b class="fw_500">구민 누구나 배움의 의지만 있다면 소득과 나이에 상관없이 원하는 교육을 받을 수 있는 도시</b>를 실현하는 것입니다. <br>
                영유아부터 어르신까지 송파구민의 전 생애를 아우르는 교육을 지향합니다. 이를 통해 구민 여러분들께서 평생교육의 질을 높일 수 있도록 지원하고 있습니다.</p>

                <p class="mt_30 mt_md_40"><b class="fw_500">‘사람이 책이 되는 곳’ 인물도서관은 </b>자라나는 청소년들에게 전문지식은 물론, 삶의 지혜와 경험을 전달해 주고 있습니다. <b class="fw_500">‘송파쌤의 거점’, 미래교육센터</b>는 4차 산업혁명시대에 어린 학생들이
                첨단기술의 기본적인 소양을 갖출 수 있도록 지원합니다. <b class="fw_500">악기도서관과 음악창작소</b>는 송파구민이라면 1인 1악기는 부담 없이 다룰 수 있도록 하는 것이 목표입니다. <br>
                그리고 송파구 안에 흩어져 있던 50여개의 교육 인프라와 콘텐츠를 하나의 네트워크로 통합한 것이 <b class="fw_500">‘온라인 캠퍼스’ 송파쌤 교육포털</b>입니다.</p>

                <p class="mt_30 mt_md_40">교육 분야의 급속한 변화는 기존 공교육과 지역사회 간 소통과 협업을 요구하고 있습니다. 송파쌤이 공교육을 적극 뒷받침하겠습니다. </p>

                <p class="mt_30 mt_md_40">앞으로도 송파구가 <b class="fw_500">세상에서 가장 큰 학교</b>가 될 수 있도록 최선을 다하겠습니다. <br>
                감사합니다.</p>

                <p class="mt_30 mt_md_40 mb_100 fw_500 fs_26">송파구청장<b class="fs_38 ml_20">박 성 수</b></p>

            </div>



            <div class="sub_info_visual st_10 mt_md_50"> <!---sub_info_visual-->
                <div class="wrap t_center tc_w fw_200">


                    <div class="sub_info_visual_text_box plr_lg_20 plr_md_0">
                        <div class="row_table row_md_table_none">
                            <div class="col t_left t_md_center">
                                <h5 class="fs_38"><b>비전</b></h5>
                                <p class="fs_26 fs_md_22 fs_md_32 mt_20 fw_400">‘송파교육모델’은 구민 누구나 배움의 의지만 있다면, <br class="screen_lg_hide screen_md_show">원하는 교육을 받을 수 있는 송파구만의 <br class="mo">독자적인 교육모델입니다.</p>
                                <p class="fs_20 fs_md_18 fs_md_24 mt_30 fw_200">
                                    모든 구민이 평생에 걸쳐 배움을 이어나갈 수 있도록 전 생애를 아우르는 <br class="screen_lg_hide screen_md_show">
                                    교육지원체계와 학습환경을 제공하고,  특히 자라나는 청소년들이 적성과 <br class="screen_hide screen_md_show"> 재능을<br class="screen_lg_hide ">
                                    찾아갈 수 있도록 지원하여 창의적 인재를 육성하고자 합니다.
                                </p>
                            </div>
                            <div class="col t_center mt_md_40">
                                <div class="dp_inb">
                                    <div class="sub_v_inp">
                                        <div>
                                            <img src="/ssem/resources/img/sub/ssemVison_img_01.png" alt="연필" class="mb_20">
                                            <span class="fs_md_24">교육지원 체계와 <br>학습환경을 제공</span>
                                        </div>
                                    </div>
                                    <div class="sub_v_inp">
                                        <div>
                                            <img src="/ssem/resources/img/sub/ssemVison_img_02.png" alt="전구" class="mb_20">
                                            <span class="fs_md_24">창의적 인재 육성</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="wrap">
                <h5 class="c_tit_2 mt_95">교육철학</h5>
                <div class="row row_p_13 mt_25">
                    <div class="col_6 col_md_12">
                        <div>
                            <div class="vision_info">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ssemVison_img_03.png" alt="공정">
                                </div>
                                <div class="text_box">
                                    <strong class="fs_30 fs_md_32">공정한 교육</strong>
                                    <p class="fw_300 pt_20 pr_40 fs_20 fs_md_26">누구나 배움의 의지만 있다면, 소득과 <br class="screen_lg_hide screen_md_show">상관없이 원하는 교육을 받을 수 있습니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col_6 col_md_12 mt_md_30">
                        <div>
                            <div class="vision_info">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ssemVison_img_04.png" alt="평생">
                                </div>
                                <div class="text_box">
                                    <strong class="fs_30 fs_md_32">평생학습권의 보장</strong>
                                    <p class="fw_300 pt_20 pr_40 fs_20 fs_md_26">모든 구민이 평생에 걸쳐 학습하고 능력과<br class="screen_lg_hide scwreen_md_sho"> 적성에 따라 교육을 받을 권리가 있습니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h5 class="c_tit_2 mt_95">교육목표</h5>
                <div class="row row_p_13 mt_25 fs_20 fs_lg_16 fs_md_26">
                    <div class="col_4 col_md_6 col_sm_12 vision_info_2">
                        <div class="item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/ssemVison_img_05.jpg" alt="공부하는 아이">
                                <img src="/ssem/resources/img/sub/ssemVison_icon_01.png" alt="셍긱">
                            </div>

                            <div class="text_box">
                                <div class="text_top">
                                    <p>각자의 적성과 재능에 맞는 <br class="screen_hide screen_lg_show screen_md_hide">길을 찾아주는</p>
                                    <b>열린교육</b>
                                </div>
                                <p class="fw_200">
                                    전생애를 아우르는 교육로드맵 도출<br>
                                    송파쌤 교육브랜드 추진
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col_4 col_md_6 col_sm_12 mt_sm_40 vision_info_2">
                        <div class="item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/ssemVison_img_06.jpg" alt="여려명이 노트북보는 모습">
                                <img src="/ssem/resources/img/sub/ssemVison_icon_02.png" alt="링크">
                            </div>
                            <div class="text_box">
                                <div class="text_top">
                                    <p>지역사회 구성원 모두가 <br class="screen_hide screen_lg_show screen_md_hide">교육에 함께 참여하는</p>
                                    <b>교육공동체</b>
                                </div>
                                <p class="fw_200">
                                    민관학 송파교육발전협의회 <br>송파혁신교육지구 추진
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col_4 col_md_6 col_sm_12 mt_md_40 vision_info_2">
                        <div class="item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/ssemVison_img_07.jpg" alt="기타">
                                <img src="/ssem/resources/img/sub/ssemVison_icon_03.png" alt="뷰">
                            </div>
                            <div class="text_box">
                                <div class="text_top">
                                    <p>배움의 의지만 있다면 쉽게<br class="screen_hide screen_lg_show screen_md_hide"> 교육이 이루어지는</p>
                                    <b>교육플랫폼</b>
                                </div>
                                <p class="fw_200">
                                    인물도서관 구축, 송파미래교육센터 조성 <br>송파교육포털 구축, 악기도서관 조성
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg_color_2 mt_90 pt_90 pb_100">
                <div class="wrap pb_15 signature_wrap st_2 pb_50">
                    <h5 class="c_tit_2">BI (Brand Identity) 소개</h5>
                    <div class="row_table row_md_table_none mt_15">
                        <div class="col">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/signature_img_01.png" alt="송파쌤 SSEM">
                            </div>
                        </div>
                        <div class="col bg_color_1 fs_24 fs_lg_18 fs_md_30 fs_md_28 lh_16 t_center">
                            <div class="fw_200 ptb_md_100">
                                <b class="fw_600">송파교육모델, Songpa Smart Education Model은</b><br>
                                학습자의 요구를 정확히 파악하고, 맞춤형 교육을 지원하는 <br>
                                스마트한 교육이라는 뜻을 함축하고 있으며, 이의 영문약자를<br class="screen_hide screen_md_show"> 따서 <br class="screen_md_hide">
                                송파쌤이라는 고유의 교육브랜드를 만들었습니다.
                            </div>
                        </div>
                    </div>

                    <div class="row mt_15">
                        <div class="col_6 col_md_12">
                            <h5 class="c_tit_3 mt_45">Signature <span class="number_box"><span class="num">1</span></span></h5>
                            <div class="img_box mr_20 mr_md_0 mt_15">
                                <img src="/ssem/resources/img/sub/signature_img_02.png" alt="송파쌤 SSEM 시그니처1">
                                <a href="/ssem/resources/download/signaure_1.ai" class="download_btn" title="다운로드">다운로드 <i class="ml_5 icon_download">다운</i></a>
                            </div>
                        </div>
                        <div class="col_6 col_md_12">
                            <h5 class="c_tit_3 mt_45 pl_20 pl_md_0">Signature <span class="number_box"><span class="num">2</span></span></h5>
                            <div class="img_box ml_20 ml_md_0 mt_15">
                                <img src="/ssem/resources/img/sub/signature_img_03.png" alt="송파쌤 SSEM 시그니처2">
                                <a href="/ssem/resources/download/signaure_2.ai" class="download_btn" title="다운로드">다운로드 <i class="ml_5 icon_download">다운</i></a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt_15">
                        <div class="col_6 col_md_12">
                            <h5 class="c_tit_3 mt_45">Signature <span class="number_box"><span class="num">3</span></span></h5>
                            <div class="img_box mr_20 mr_md_0 mt_15">
                                <img src="/ssem/resources/img/sub/signature_img_04.png" alt="송파쌤 SSEM 시그니처3">
                                <a href="/ssem/resources/download/signaure_3.ai" class="download_btn" title="다운로드">다운로드 <i class="ml_5 icon_download">다운</i></a>
                            </div>
                        </div>
                        <div class="col_6 col_md_12">
                            <h5 class="c_tit_3 mt_45 pl_20 pl_md_0">Signature <span class="number_box"><span class="num">4</span></span></h5>
                            <div class="img_box ml_20 ml_md_0 mt_15">
                                <img src="/ssem/resources/img/sub/signature_img_05.png" alt="송파쌤 SSEM 시그니처4">
                                <a href="/ssem/resources/download/signaure_4.ai" class="download_btn" title="다운로드">다운로드 <i class="ml_5 icon_download">다운</i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
