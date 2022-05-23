<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '유네스코 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
    });
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
                        <a href="#" class="deapth_tit" title="선택">유네스코</a>
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
            <a href="#" class="tab_m">유네스코<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li  class="tab_item on"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="wrap text_con fs_20 fs_md_26 mb_15 ">
            <h4 class="tit2 mt_100 mb_50">유네스코</h4>

            <div class="bg_color_2">
                <div class="fs_28 ptb_30 t_center fw_500">
                    글로벌 평생학습도시 송파<br>
                    <span class="fs_28 tc_5">‘2020 유네스코 글로벌평생학습도시 네트워크 가입’ </span>
                </div>
            </div>
            <h2 class="c_tit_2 mt_95">글로벌 학습도시 네트워크(Global Network Learning City, GNLC)란?</h2>
            <div class="mt_20">
                모두를 위한 평생학습을 촉진하기 위해 유네스코가 2015년 설립하였으며, 학습에 대한 영감과 지식, 우수사례를 제공하는 정책지향적 국제네트워크
            </div>
            <div class="mt_20 mt_md_40 t_md_center">
                <img src="/ssem/resources/img/sub/foreverEdu/unesco_img.jpg" alt="Cerificate of Membership 표지">
            </div>

            <h2 class="c_tit_2 mt_85">GNLC란?</h2>
            <div class="table_box fs_18 fs_md_24 mt_20 mb_100"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">GNLC의 공식명칭, 목적, 취지, 출범년도, 가입기준, 가입혜택 및 장점, 홍보 및 성과 인정, 기본원칙, 사무국, 공식홈페이지, 가입도시 안내</caption>
                    <tbody>
                    <tr>
                        <th class="wid_230">공식명칭</th>
                        <td>
                            <div class="ptb_10">
                                유네스코 글로벌 학습도시 네트워크(UNESCO Global Network of Learning Cities)
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">목적</th>
                        <td>
                            <div class="ptb_10">
                                <ul class="ul_list_dash mt_5">
                                    <li>학습도시 구축에 대한 우수 사례 및 전문성 공유를 위한 국제 정보 교환 플랫폼 제공</li>
                                    <li>정책 공유, 협력 증진을 통한 전 세계 여러 지역에서 평생학습의 발전 지원</li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">취지</th>
                        <td>
                            <div class="ptb_10">
                                전 세계 도시의 평생학습 및 2030 지속가능발전 의제, 특히 SDG 4, SDG 11 이행 실천 촉진
                                <ul class="ul_list_dash mt_5">
                                    <li><b class="tc_b">SDG(Sustainable Development Goal)</b> : 지속가능발전목표, 총 17개 목표</li>
                                    <li><b class="tc_b">SDG4</b> : 모든 사람을 위한 포용적이고 형평성 있는 양질의 교육 보장 및 평생교육 기회증진</li>
                                    <li><b class="tc_b">SDG11</b> : 포용적인・안전한・회복력 있는 지속가능한 도시와 거주지 조성</li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">출범년도</th>
                        <td>
                            <div class="ptb_10">2015년</div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">가입기준</th>
                        <td>
                            <div class="ptb_10">
                                학습도시의 핵심 문서인 ‘학습도시 구축에 대한 베이징 선언(Beijing Declaration on Building Learning Cities)’과 <br class="pc">‘학습도시의 핵심특징(Key Features of Learning Cities)’ 채택에 동의하는 도시
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">가입혜택 및 장점</th>
                        <td>
                            <div class="ptb_10">
                                <p>1. 학습도시 구축을 위한 지도 및 지원</p>
                                <ul class="ul_list_dash mt_5">
                                    <li>학습도시 개발을 위한 도구 및 전략, 최근 연구 결과와 운영 사례 보고서 제공</li>
                                    <li>전 세계 학습도시 실행 현황에 대한 정보 제공</li>
                                </ul>
                                <p class="mt_5">2. 국제 및 지역회의 주최국에게 지원 제공</p>
                                <p class="mt_5">3. 동일한 관심사, 문제 및 개발의제를 가진 학습도시 간의 네트워크 구축</p>
                                <p class="mt_5">4. 지속가능발전을 위한 평생학습 전문가 네트워크와의 관계 형성</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">홍보 및 성과 인정</th>
                        <td>
                            <div class="ptb_10">
                                유네스코 글로벌 학습도시 네트워크의 사례연구, 통신 채널을 통해 성과와 좋은 운영 사례 공유<br>
                                유네스코 학습도시상 지원 자격 제공
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">기본원칙</th>
                        <td>
                            <div class="ptb_10">
                                <ul class="ul_list_dash mt_5">
                                    <li>유네스코 글로벌 학습도시 네트워크는 열린 네트워크로서 가입을 희망하는 모든 도시에게 멤버십을 부여함.<br> 이에 따라 유네스코 글로벌 학습도시 네트워크 운영팀은 네트워크를 관리할 뿐, 각 도시의 지원 자격을 검토 및 심사하여<br> 멤버십을 제공하는 역할이 아님</li>
                                    <li>유네스코 글로벌 학습도시 네트워크 가입에 따른 회원비 납부 의무 없음</li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">사무국</th>
                        <td>
                            <div class="ptb_10">
                                유네스코 글로벌 학습도시 네트워크 운영팀(Coordination Team of the UNESCO GNLC)
                                <ul class="ul_list_dash mt_5">
                                    <li> 유네스코 평생학습연구소 소속</li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">공식홈페이지</th>
                        <td>
                            <div class="ptb_10">
                                <a href="https://uil.unesco.org/lifelong-learning/learning-cities" target="_blank" class="btn btn_small btn_color_5" title="새창">바로가기</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">가입도시</th>
                        <td>
                            <div class="ptb_10">
                                64개국 230개 도시(2020년 11월 기준) ※ 한국: 총 50개 시&middot;군&middot;구
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
