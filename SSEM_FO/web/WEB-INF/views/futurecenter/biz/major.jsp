<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '주요사업 > 미래교육센터 오금Hub > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js

        AOS.init({easing: 'ease-in-out', duration:800, once : true });
        setTimeout(function() {
            AOS.refresh();
        }, 100);
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual songpa_st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    주요사업
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">주요사업</a>
                        <ul>
                            <li><a href="/ssem/futurecenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/futurecenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/futurecenter/biz/major.do">주요사업</a></li>
                            <li><a href="/ssem/futurecenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/futurecenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_80 mb_50 tit font_sc">주요사업</h3>
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h1 class="c_tit_2 mt_100">팹랩 (FAB Lab) 사업</h1>
                <p class="mt_25 middot">
                    '배우고(Learn)-만들고(Make)-공유하라(Share)' 는 생각의 바탕 위에 창의적 아이디어를 현실이 되도록 메이커 공간 및 사업(메이킹 프로젝트, 워크숍, 체험 등)
                </p>
                <div class="bg_color_4 plr_100 plr_md_40 ptb_50 ptb_md_20 mt_25">
                    <h3 class="c_tit_3 t_bef_middot c1 mt_45 mb_15">비전</h3>
                    <div class="songpa_box fs_22 fs_md_30 t_center ptb_45 ptb_md_35">
                        <span class="tc_1">상상의 즐거움, </span>현실로의 실현
                    </div>
                    <h3 class="c_tit_3 t_bef_middot c1 mt_45 mb_15">슬로건</h3>
                    <div class="songpa_box fs_22 fs_md_30 t_center ptb_45 ptb_md_35">
                        미래 예측이 어려운 다변화 사회를 준비<br class="screen_hide screen_md_show"> <span class="tc_1">송파창의인재 육성</span>
                    </div>
                    <h3 class="c_tit_3 t_bef_middot c1 mt_45 mb_15">핵심가치</h3>
                    <div class="row row_p_25 row_p_md_5 songpa_info_list st_2 fs_18 fs_md_26 mb_30">
                        <div class="col_4">
                            <div class="item st_1">
                                <div class="img_box">
                                    <span class="_tit mt_45 mb_20 mb_xs_0 fs_22 fs_md_30">융합</span>
                                    <img src="/ssem/resources/img/sub/songpa/item_04.png" alt="융합">
                                </div>
                                <div class="text_box st_1">
                                    <div class="text">
                                        <span class="tc_1">융합적 사고</span>를 기반으로<br>
                                        상상을 현실로 실현하는<br>
                                        ‘ESC프로젝트’ 추진
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col_4">
                            <div class="item st_2">
                                <div class="img_box">
                                    <span class="_tit mt_45 mb_20 mb_xs_0 fs_22 fs_md_30">확산</span>
                                    <img src="/ssem/resources/img/sub/songpa/item_05.png" alt="확산">
                                </div>
                                <div class="text_box st_2">
                                    <div class="text">
                                        지역사회 커뮤니티 활성화로<br>
                                        <span class="tc_1">배우고 - 만들고 - 공유하는</span><br>
                                        팹문화 조성
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col_4">
                            <div class="item st_3">
                                <div class="img_box">
                                    <span class="_tit mt_45 mb_20 mb_xs_0 fs_22 fs_md_30">즐거움</span>
                                    <img src="/ssem/resources/img/sub/songpa/item_06.png" alt="즐거움">
                                </div>
                                <div class="text_box st_3">
                                    <div class="text">
                                        문제해결의 즐거움을 발견하는<br>
                                        청소년 중심의<br>
                                        <span class="tc_1">플레이 그라운드 구축</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h1 class="c_tit_2 mt_100">미디어사업</h1>
                <p class="mt_25 middot">
                    Video, Sound, Picture 등을 소재로 표현하고자 하는 콘텐츠를 구체적으로 실현되도록 디자인 및 크리에이터 창작활동을 지원 (미디어랩소디, 웹툰, 더빙체험, 콘텐츠제작지원 등)
                </p>
                <h1 class="c_tit_2 mt_100">SSEM추진사업</h1>
                <p class="mt_25 middot">
                    송파형교육모델인 ‘송파쌤(SSEM)’의 수행기관으로 청소년 진로·직업 체험 및 탐색과 관련한 사업을 추진 (진로직업체험_발견하다, 메이커 교사연수, 청소년진로직업상담 등)
                </p>
                <h1 class="c_tit_2 mt_100">공유오피스 운영 및 지원</h1>
                <p class="mt_25 middot">
                    청소년 취·창업 사업운영 및 관련 지식전달 및 커뮤니티 운영 (창업지원, 유스CEO, 인물도서관 TED강연 등)
                </p>
            </div>
        </section>
    </div>
</div>
