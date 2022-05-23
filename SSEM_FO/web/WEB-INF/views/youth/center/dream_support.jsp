<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파구 청소년 지원센터(꿈드림) > 교육지원 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">송파구청소년 지원센터 꿈드림</a>
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
    </div>
    <!--sub_nav_wrap//-->
    <!--

        sub_con st_1 color - #3f78d4
        sub_con st_2 color - #e08c34
        sub_con st_3 color - #9e61e4
        sub_con st_4 color - #f05484
        sub_con st_5 color - #1fb593

    -->
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">송파구 청소년 지원센터(꿈드림)</h3>
        <div class="sub_info_visual st_8 mt_md_50 t_center"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">송파구 청소년지원센터 꿈드림은</h5>
                    <p class="fs_22 fs_md_26 mt_30">
                        학교라는 울타리를 벗어나 <br class="screen_hide screen_md_show"> 학업을 중단한 청소년들이 자신감을 회복하고 <br>
                        꿈을 키울 수 있도록 돕는 청소년들의 공간입니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_95 mt_md_75">꿈드림 프로그램</h2>
                <div class="info_box_table st_3 mt_25 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_08.jpg" alt="공부">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">교육지원사업</span></p>
                                    <p>검정고시학습 / 초 &middot; 중 &middot; 고 교과학습 / 음악 &middot; 미술 &middot; 외국어 등 특별활동</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_09.jpg" alt="상담">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">상담지원사업</span></p>
                                    <p>개인상담 / 심리검사 / 집단상담 / 학업중단숙려제</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_3 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_10.jpg" alt="줄다리기">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">특성화프로그램</span></p>
                                    <p>소풍 / 캠프 / 문화체험 / 운동회</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_11.jpg" alt="요리">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">자립지원사업</span></p>
                                    <p>요리 / 사진영상 / 뮤지컬 / 인턴십 / 직업체험 / 건강검진</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_3 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_12.jpg" alt="댄스">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <!--2020.11.09 : s-->
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">청소년동아리 운영</span></p>
                                    <!--2020.11.09 : e-->
                                    <p>기타 / 댄스 / 미술 동아리</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                    </div>
                </div>
                <h2 class="c_tit_2 mt_95 mt_md_75">이용안내</h2>
                <div class="table_box mt_25 fs_18 fs_md_22 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">이용안내의 운영시간, 이용대상, 신청방법, 위치</caption>
                        <colgroup>
                            <col width="25%">
                            <col width="75%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>운영시간</th>
                            <td class="t_left">
                                <p class="mtb_md_10 mlr_20">월 ~ 금요일 오전 09:30 ~ 오후 06:30</p>
                            </td>
                        </tr>
                        <tr>
                            <th>이용대상</th>
                            <td class="t_left">
                                <p class="mtb_md_10 mlr_20">9세~24세 학교 밖 청소년</p>
                            </td>
                        </tr>
                        <tr>
                            <th>신청방법</th>
                            <td class="t_left">
                                <ul class="mtb_md_10 mlr_20 ul_list_dash">
                                    <li>송파구청소년지원센터 직접 방문, 전화 문의(02-3402-1318)</li>
                                    <li>송파쌤 교육포털 온라인 신청</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th>위치</th>
                            <td class="t_left">
                                <p class="mtb_md_10 mlr_20">송파구 송파대로 14길 7(문정역 2번 출구)</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</div>
