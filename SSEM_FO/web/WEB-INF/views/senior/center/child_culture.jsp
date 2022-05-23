<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-25
  Time: 오전 1:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파어린이문화회관 > 교육지원 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">송파어린이문화회관</a>
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
        <h3 class="mt_100 tit font_sc mb_50">송파어린이문화회관</h3>
        <div class="sub_info_visual foreverEdu_st_6 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">송파어린이문화회관</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_2 mt_85 mb_25">기관소개</h4>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">운영목적</span></h5>
            <p class="fw_300 ls_50">'서울특별시 송파구 어린이문화회관 설치 및 운영 조례'에 의거하여 영&middot;유아 및 아동의 건전한 육성을 도모하여 행복한 보육시대확립 및 지역사회를 만드는데 기여</p>
            <h5 class="middot mt_55"><span class="tc_b fs_22 fs_md_28">시설현황</span></h5>
            <div class="table_box mt_15 fs_18 fs_md_26 t_center">
                <table class="table">
                    <caption class="text_hide">기관의 기관명, 위치, 설립연월, 면접, 대표전화 안내</caption>
                    <colgroup>
                        <col style="width:22.222%; min-width:  12.255rem;">
                        <col>
                    </colgroup>

                    <tbody>
                    <tr>
                        <th>기관명</th><td>송파어린이문화회관</td>
                    </tr>
                    <tr>
                        <th>위치</th><td>송파구 중대로 235</td>
                    </tr>
                    <tr>
                        <th>설립연월</th><td>2010년 9월</td>
                    </tr>
                    <tr>
                        <th>면적</th><td>연면적 5,714.82㎡, 지상5층, 지하3층</td>
                    </tr>
                    <tr>
                        <th>대표전화</th><td>02) 449-0505</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h4 class="c_tit_2 mt_85 mb_25">주요사업소개</h4>
            <div class="info_box_table st_2 color_2 mt_15 fs_18 fs_md_26">
                <div class="col_wrap">
                    <dl>
                        <dt>
                            <img src="/ssem/resources/img/sub/foreverEdu/fec_img_01.png" alt="상상마루 체험관">
                        </dt>
                        <dd>
                            <div class="plr_20">
                                <p class="c_tit_3 t_bef_middot c5 mb_15"><span class="fs_22 fs_md_26">상상마루 체험관</span></p>
                                <p>직접적인 체험과 유희적 놀이가 결합되어 풍부한 경험을 유도하는 체험전시</p>
                            </div>
                        </dd>
                    </dl>
                </div>
                <div class="col_wrap mt_md_20">
                    <dl>
                        <dt>
                            <img src="/ssem/resources/img/sub/foreverEdu/fec_img_02.png" alt="재능개발프로그램">
                        </dt>
                        <dd>
                            <div class="plr_20">
                                <p class="c_tit_3 t_bef_middot c5 mb_15"><span class="fs_22 fs_md_26">재능개발프로그램</span></p>
                                <p>다양한 프로그램을 통해 각각의 특성을 이해하고 활동과정을 통해 자신감, 문제해결능력 등을 기를 수 있는 기회제공</p>
                            </div>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="info_box_table st_2 color_2 mt_15 fs_18 fs_md_26">
                <div class="col_wrap">
                    <dl>
                        <dt>
                            <img src="/ssem/resources/img/sub/foreverEdu/fec_img_03.png" alt="공연장">
                        </dt>
                        <dd>
                            <div class="plr_20">
                                <p class="c_tit_3 t_bef_middot c5 mb_15"><span class="fs_22 fs_md_26">공연장</span></p>
                                <p>질 높은 예술문화작품을 기획 공연함으로써 영&middot;유아의 예술적 능력을 키우고 건강한 가족문화 향상에 기여</p>
                            </div>
                        </dd>
                    </dl>
                </div>
                <div class="col_wrap mt_md_20">
                    <dl>
                        <dt>
                            <img src="/ssem/resources/img/sub/foreverEdu/fec_img_04.png" alt="통합상담실">
                        </dt>
                        <dd>
                            <div class="plr_20">
                                <p class="c_tit_3 t_bef_middot c5 mb_15"><span class="fs_22 fs_md_26">통합상담실</span></p>
                                <p>아동의 발달과정에서의 인지 및 언어발달의 어려움을 해소할 수 있도록 상담서비스 제공</p>
                            </div>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="info_box_table st_2 color_2 mt_15 fs_18 fs_md_26">
                <div class="col_wrap">
                    <dl>
                        <dt>
                            <img src="/ssem/resources/img/sub/foreverEdu/fec_img_05.png" alt="키즈카페">
                        </dt>
                        <dd>
                            <div class="plr_20">
                                <p class="c_tit_3 t_bef_middot c5 mb_15"><span class="fs_22 fs_md_26">키즈카페</span></p>
                                <p>이용자의 편익을 돕고 영&middot;유아에게 건강한 먹거리 제공</p>
                            </div>
                        </dd>
                    </dl>
                </div>
                <div class="col_wrap mt_md_20">

                </div>
            </div>
            <h4 class="c_tit_2 mt_85 mb_25">재능개발프로그램 이용안내</h4>
            <div class="table_box mt_15 fs_18 fs_md_26 t_center">
                <table class="table">
                    <caption class="text_hide">재능개발프로그램 이용의 소개, 감면 규정, 환불 규정, 재능개발프로그램 상담안내번호 안내</caption>
                    <colgroup>
                        <col style="width:22.222%; min-width:  12.255rem;">
                        <col>
                    </colgroup>

                    <tbody>
                    <tr>
                        <th>소개</th>
                        <td>
                            <p class="ptb_10">
                                학기별 프로그램은 봄(3~5월), 여름(6~8월), 가을(9~11월), 겨울(12~2월)로 진행되며, <br class="pc">특성화 프로그램은 프렌즈쿠킹(단체요리), 패밀리쿠킹(가족요리)으로 진행
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <th>감면 규정</th>
                        <td>국가유공자, 장애인, 기초수급자, 한부모, 다둥이 세자녀, 다문화 1인 2강좌(50%, 20%)할인</td>
                    </tr>
                    <tr>
                        <th>환불 규정</th>
                        <td>
                            <ul class="ptb_10">
                                <li>- 프로그램 개시일 이전: 전액환급</li>
                                <li>- 프로그램 개시일 이후: 수수료 및 일할계산 공제 후 환급</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>재능개발프로그램<br>상담안내번호</th>
                        <td><p class="ptb_20">070) 4298-6446, 6448</p></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
