<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파 청소년 성문화센터 > 교육지원 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_8"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    교육지원
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
                        <a href="#" class="deapth_tit" title="선택">교육지원</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파 청소년 성문화 센터</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/main/main.do" target="_blank">송파청소년센터</a></li>
                            <li><a href="/ssem/machuncenter/main/main.do" target="_blank">마천청소년센터</a></li>
                            <li><a href="/ssem/jamsilcenter/main/main.do" target="_blank">잠실청소년센터</a></li>
                            <li><a href="/ssem/youth/center/child_culture.do">송파어린이문화회관</a></li>
                            <li><a href="/ssem/youth/center/broad_acamedy.do">송파어린이 방송아카데미</a></li>
                            <li><a href="/ssem/youth/center/youth_counsel.do">송파구 청소년상담복지센터</a></li>
                            <li><a href="/ssem/futurecenter/main/main.do" target="_blank">구립송파 청소년미래센터</a></li>
                            <li><a href="/ssem/youth/center/gender_culture.do">송파 청소년 성문화 센터</a></li>
                            <li><a href="/ssem/youth/center/dream_support.do">송파구청소년 지원센터 꿈드림</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">송파 청소년 성문화센터</h3>
        <div class="sub_info_visual st_9 mt_md_50 t_center"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">송파 청소년 성문화센터는 </h5>
                    <p class="fs_22 fs_md_24 mt_30">
                        시청각 자료와 실천적 체험 중심의 교육을 통해<br class="screen_hide screen_md_show"> 건강한 성문화 확산을 돕는 청소년 전문 성교육 기관입니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="bg_color_2 ys_box">
                <div class="wrap pt_95">
                    <h2 class="c_tit_2">시설안내</h2>
                    <div class="row row_p_10">
                        <div class="col_3 col_md_6 mt_md_20">
                            <div class="ys_item">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ycg_img_13.jpg" alt="손잡는 이미지">
                                    <span class="fs_22 fs_md_26 fw_md_500">우주방</span>
                                </div>
                                <div class="text_box">
                                    <!--2020.11.09 : s-->
                                    <strong class="fs_22 fs_md_26">생명과 탄생</strong>
                                    <!--2020.11.09 : e-->
                                    <p class="mt_10">
                                        심박소리를 들으며<br class="screen_hide screen_md_show">단 하나뿐인 <br>소중한 나를 느끼는 공간
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col_3 col_md_6 mt_md_20">
                            <div class="ys_item">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ycg_img_14.jpg" alt="퍼즐이미지">
                                    <span class="fs_22 fs_md_26 fw_md_500">평등방</span>
                                </div>
                                <div class="text_box">
                                    <strong class="fs_22 fs_md_26">소통과 관계</strong>
                                    <p class="mt_10">
                                        존중과 평등을 기반으로<br class="screen_hide screen_md_show">
                                        차별에<br class="screen_md_hide"> 대한 민감성을 키우고<br class="screen_hide screen_md_show">
                                        성감수성을 높이는 공간
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col_3 col_md_6 mt_md_20">
                            <div class="ys_item">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ycg_img_15.jpg" alt="3명 누어있는 이미지">
                                    <span class="fs_22 fs_md_26 fw_md_500">사춘기방</span>
                                </div>
                                <div class="text_box">
                                    <strong class="fs_22 fs_md_26">변화와 존중</strong>
                                    <p class="mt_10">
                                        사춘기 몸과 마음의 변화를<br class="screen_hide screen_md_show">
                                        긍정적으로 인식하고<br class="screen_hide screen_md_show">
                                        준비하는 공간
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col_3 col_md_6 mt_md_20">
                            <div class="ys_item">
                                <div class="img_box">
                                    <img src="/ssem/resources/img/sub/ycg_img_16.jpg" alt="남학생 여학생">
                                    <span class="fs_22 fs_md_26 fw_md_500">섹슈얼리티방</span>
                                </div>
                                <div class="text_box">
                                    <strong class="fs_22 fs_md_26">성적자기결정권</strong>
                                    <p class="mt_10">
                                        성적 주체자로서 <br class="screen_hide screen_md_show">성적자기결정능력을<br>
                                        향상시키는 공간
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="wrap">
                <h2 class="c_tit_2 mt_90">주요 사업소개</h2>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_17.png" alt="남여">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">체험관 성교육</span></p>
                                    <p>대상별 특성에 맞는 체험형 성교육</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_18.png" alt="스마일">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">찾아가는 성교육</span></p>
                                    <p>신청기관의 요청에 따른 주제별 찾아가는 성교육</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_19.png" alt="폭죽">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">‘사.이.다’</span></p>
                                    <p>긍정적 사춘기 맞이를 위한 파티 형식의 성교육</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_20.png" alt="커플">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">커플 성교육</span></p>
                                    <p>양육자, 자녀 성교육 및 소통 프로그램</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_21.png" alt="새싹">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">함.성.캠프</span></p>
                                    <!--2020.11.09 : s-->
                                    <p>성인지 감수성 향상을 위한 다양한 성교육 활동</p>
                                    <!--2020.11.09 : e-->
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap">
                    </div>
                </div>
                <h2 class="c_tit_2 mt_80">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location">주소</i>주소</strong>
                                서울 송파구 중대로 4길 4, 3층 성문화센터
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_tel">전화</i>연락처</strong>
                                02)3012-1318
                            </p></li>
                        </ul>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_80">고객광장</h2>
                <div class="bg_color_2 ycg_qa mt_25">
                    <p class="fw_600"><i class="icon_qw mr_20">질문</i><span class="va_m">개인이 신청하여 체험관을 이용할 수 있나요?</span></p>
                    <p class="mt_20"><i class="icon_a mr_20">답변</i><span class="va_m">네, 프로그램에 따라 개별 신청으로 접수를 받는 경우도 있습니다. 자세한 내용은 성문화센터로 문의 바랍니다.</span></p>
                </div>
                <h2 class="c_tit_2 mt_95">이용안내</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">이용안내의 이용대상, 운영시간, 접수방법, 참가비용, 접수문의</caption>
                        <colgroup>
                            <col width="25%">
                            <col width="75%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>이용대상</th>
                            <td class="t_left">
                                <p class="mlr_20 mtb_10">유아, 초등, 중고등, 성인 <br class="screen_hide screen_md_show"> (양육자, 교사, 지도자 등)</p>
                            </td>
                        </tr>
                        <tr>
                            <th>운영시간</th>
                            <td class="t_left">
                                <p class="mlr_20 mtb_10">월요일 ~ 토요일(09:00 ~ 18:00)</p>
                            </td>
                        </tr>
                        <tr>
                            <th>접수방법</th>
                            <td class="t_left">
                                <p class="mlr_20 mtb_10">이메일 선착순 접수 (spsay@hanmail.net)</p>
                            </td>
                        </tr>
                        <tr>
                            <th>참가비용 </th>
                            <td class="t_left">
                                <p class="mlr_20 mtb_10">별도 문의</p>
                            </td>
                        </tr>
                        <tr>
                            <th>접수문의  </th>
                            <td class="t_left">
                                <p class="mlr_20 mtb_10">02) 3012-1318 / 02) 2147-5341~5</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="btn_box mt_50 t_center">
                    <a href="/ssem/youth/program/lecture_list.do" class="btn btn_auto btn_big t_center mr_15">수강신청 하러가기</a>
                </div>
            </div>
        </section>
    </div>
</div>
