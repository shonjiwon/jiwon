<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 3:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '프로그램 안내 > 꿈마루 > 송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual mr_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    꿈마루
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">꿈마루</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루</a></li>
                            <li><a href="/ssem/dream/together/experience.do">가치, 같이 함께 해주세요</a></li>
                            <li><a href="/ssem/dream/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/dream/news/notice_list.do">꿈마루 소식</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">프로그램 안내</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루 소개</a></li>
                            <li><a href="/ssem/dream/dream/program_info.do">프로그램 안내</a></li>
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
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">프로그램 안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/dream/dream/intro.do">꿈마루 소개</a></li>
                <li  class="tab_item on"><a href="/ssem/dream/dream/program_info.do">프로그램 안내</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">송파 꿈마루의 진로체험 프로그램 안내</h3>
        <div class="sub_info_visual mr_st_2 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <span class="text_hide">송파 꿈마루의 진로체험 모습</span>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">

                <h2 class="c_tit_2 mt_95 mt_md_80">진로체험 프로그램 안내 송파 꿈마루 "DREAM-U"</h2>
                <div class="program_info_wrap mt_40 mt_md_30">
                    <div class="img_wrap t_center mb_50">
                        <img src="/ssem/resources/img/sub/maru/maru_dream_img_01.png" alt="SONGPA DREAM HIGH CAEER EXPERIENCE CENTER Different DREAM-U 지역특화 Realize 진로핵심역량 Experience 체험, 일 경험 Aptitude 적성찾기 Mentor 네트워크 Uncontact 비대면 온라인">
                    </div>
                    <div class="txt_wrap">
                        <p>
                            “D.R.E.A.M-U”는 독창적이고 차별된 프로그램을 통해 현실적이고 실현 가능한 일 경험과 직업체험을 하고 자신의 적성을 찾을 수 있도록 송파의 멘토들이 함께하는“마을 담은 진로 네트워크”를
                            구축하는 것으로 송파 진로직업체험지원센터가 추구하는 송파구 만의 진로교육 방향입니다.
                        </p>
                        <p>
                            “D.R.E.A.M-U”는 송파 꿈마루의 핵심역할을 뜻하는 단어들의 앞글자를 따서 만든 것으로 <strong class="fw_500 tc_b">Different(차별화-지역특화), Realize(실현가능-진로핵심역량교육), Experience(경험-일경험‧체험),
                            Aptitude(적성-적성‧소질찾기), Mentor(멘토-지역사회네트워크)와 함께 “U”는 Uncontact</strong>로서 포스트 코로나 시대, “비대면 원격 온라인 교육 시스템”을 구축하여, 보다 안전하면서도 효율적이며
                            시간과 공간을 초월하는 송파구만의 탁월하고 새로운 청소년 진로교육, 직업체험의 새로운 기준, 뉴-노멀을 만들어 갑니다.
                        </p>
                        <p>
                            더불어 송파 청소년의 DREAM(꿈)의 의미와 함께 ‘배워서 남 주는’ 사회기여의식 함양을 위해 ‘주다’ 의 높인 말인“드림”의 인성적 의미까지 담고 있으며 이러한 가치는 송파쌤 교육모델의
                            송파에서 길러지는 미래 핵심 인재양성의 목표와도 일치합니다.
                        </p>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_85">중점 추진 과제</h2>
                <div class="main_report_wrap mt_40 mt_md_30">
                    <div class="row">
                        <div class="col_4 col_md_12">
                            <div class="circle_report_box">
                                <div class="circle_box circle_2">
                                    <p class="circle_bg bg1">
                                            <span class="inner_txt">
                                                지역<br> 현장성<br> 강화
                                            </span>
                                    </p>
                                    <p class="circle_bg bg2">
                                            <span class="inner_txt">
                                                랜선<br> 이웃<br> 확대
                                            </span>
                                    </p>
                                </div>
                                <p class="t_center fs_20 fs_md_30 fw_400 mt_30">
                                    송파마을 지역특화 강화
                                </p>
                                <!-- circle_box : e -->
                            </div>
                            <!-- circle_report_box end -->
                        </div>
                        <div class="col_4 col_md_12">
                            <div class="circle_report_box">
                                <div class="circle_box circle_3">
                                    <p class="circle_bg bg3">
                                            <span class="inner_txt">
                                                초연결<br> 원격<br> 온라인
                                            </span>
                                    </p>
                                    <p class="circle_bg bg4">
                                            <span class="inner_txt">
                                                Uncontact
                                            </span>
                                    </p>
                                    <p class="circle_bg bg5">
                                            <span class="inner_txt">
                                                Though<br> &amp; <br>Smart Order
                                            </span>
                                    </p>
                                </div>
                                <p class="t_center fs_20 fs_md_30 fw_400 mt_30">
                                    비대면 온라인 프로그램 확대
                                </p>
                                <!-- circle_box : e -->
                            </div>
                            <!-- circle_report_box end -->
                        </div>
                        <div class="col_4 col_md_12">
                            <div class="circle_report_box">
                                <div class="circle_box circle_2">
                                    <p class="circle_bg bg6">
                                            <span class="inner_txt">
                                                홈스쿨링
                                            </span>
                                    </p>
                                    <p class="circle_bg bg7">
                                            <span class="inner_txt">
                                                공교육<br> 변화
                                            </span>
                                    </p>
                                </div>
                                <p class="t_center fs_20 fs_md_30 fw_400 mt_30">
                                    가정&amp;학교 교육지원
                                </p>
                                <!-- circle_box : e -->
                            </div>
                            <!-- circle_report_box end -->
                        </div>
                    </div>
                    <!-- row : e -->
                </div>
                <h2 class="c_tit_2 mt_85 mt_md_80">송파 꿈마루 "DREAM-U" 주요 프로그램</h2>
                <div class="dream_u_wrap mt_40 mt_md_30">
                    <div class="tag_box_wrap">
                        <ul>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_1.png" alt="Different"><p class="d_tit"><b class="fw_600">D</b>ifferent</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#특별하고</span>
                                                    <span>#차별된</span>
                                                    <span>#독창적인</span>
                                                </p>
                                                <p>
                                                    다른지역과는 다른 송파구만의 차별되고 특별한 <b>독창적인 진로프로그램</b>
                                                </p>
                                            </div>
                                        </div>

                                    </dd>
                                </dl>
                            </li>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_2.png" alt="Realize""><p class="d_tit"><b class="fw_600">R</b>ealize</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#실현가능한</span>
                                                    <span>#현실반영된</span>
                                                    <span>#현재에서 미래를 보는</span>
                                                </p>
                                                <p>
                                                    실현가능하고 현실과 미래가 반영된 송파만의 <b>진로핵심역량 5</b> 교육실시
                                                </p>
                                            </div>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_3.png" alt="experience"><p class="d_tit"><b class="fw_600">E</b>xperience</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#체험교육</span>
                                                    <span>#일경험</span>
                                                    <span>#진로체험</span>
                                                    <span>#직ㆍ간접체험</span>
                                                </p>
                                                <p>
                                                    현장직업체험, 직업실무체험, 진로캠프 등 <b>재미있고 흥미있는 진로체험</b>
                                                </p>
                                            </div>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_4.png" alt="Aptitude"><p class="d_tit"><b class="fw_600">A</b>ptitude</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#적성찾기</span>
                                                    <span>#진로적성 </span>
                                                    <span>#진로탐색</span>
                                                    <span>#진로방향설정</span>
                                                </p>
                                                <p>
                                                    다양한 진단을 통한 자아인식, 진로ㆍ직업체험을 통한 <b>즐거운 적성찾기</b>
                                                </p>
                                            </div>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_5.png" alt="mentor"><p class="d_tit"><b class="fw_600">M</b>entor</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#특별하고</span>
                                                    <span>#색다른</span>
                                                    <span>#차별된</span>
                                                    <span>#독창적인</span>
                                                </p>
                                                <p>
                                                    지속가능한 진로 인프라 구축을 위해 마을담은 송파 <b>진로네트워크 구축</b>
                                                </p>
                                            </div>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                            <li class="tag_box">
                                <dl>
                                    <dt><img src="/ssem/resources/img/sub/maru/img_info_2_img_6.png" alt="uncontact"><p class="d_tit"><b class="fw_600">U</b>ncontact</p></dt>
                                    <dd>
                                        <div class="txt_area">
                                            <div class="txt_box">
                                                <p class="tag_area">
                                                    <span>#비대면</span>
                                                    <span>#안전한체험</span>
                                                    <span>#온라인</span>
                                                    <span>#원격</span>
                                                    <span>초연결</span>
                                                </p>
                                                <p>
                                                    비대면 온라인 진로컨텐츠 제공을 통한 <b>안전한 언컨택트 진로ㆍ직업체험</b>
                                                </p>
                                            </div>
                                        </div>
                                    </dd>
                                </dl>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </div><!-- sub_con : e -->
</div>
