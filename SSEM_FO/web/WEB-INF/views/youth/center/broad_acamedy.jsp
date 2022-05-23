<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파어린이 방송아카데미 > 교육지원 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">송파어린이 방송아카데미</a>
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
        <h3 class="mt_100 mb_50 tit font_sc">송파어린이 방송아카데미</h3>
        <div class="sub_info_visual st_6 mt_md_50 t_center"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">송파어린이 방송아카데미는</h5>
                    <p class="fs_22 fs_md_24 mt_30">
                        송파TV 스튜디오 및 야외촬영지에서 <br class="screen_hide screen_md_show"> 아나운서, 작가, PD 등의<br class="screen_md_hide">방송직업 역할을 맡아보며 <br class="screen_hide screen_md_show">방송제작과 미디어를 체험하는 프로그램입니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_90">교육과정 안내</h2>
                <div class="table_box mt_25 fs_18 fs_md_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">교육과정의 교육대상, 교육기간, 교육장소, 교육내용, 교육강사, 교육비용 안내</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="76%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육대상</p></th>
                            <td class="t_left">
                                <p class="mt_5 mlr_15">관내 초등학교 4 ~ 6학년</p>
                            </td>
                        </tr>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육기간</p></th>
                            <td class="t_left">
                                <p class="mtb_10 mlr_15">방학기간(여름·겨울)중 실시</p>
                            </td>
                        </tr>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육장소</p></th>
                            <td class="t_left">
                                <p class="mtb_10 mlr_15">송파TV(송파구청 신관 10층), 석촌호수·올림픽공원 등</p>
                            </td>
                        </tr>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육내용</p></th>
                            <td class="t_left">
                                <p class="mtb_10 mlr_15">아이디어 회의 및 대본 작성, 개인별 카메라 테스트, 스튜디오 녹화, 야외촬영, 아나운서 체험, 애니메이션 더빙 등</p>
                            </td>
                        </tr>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육강사</p></th>
                            <td class="t_left">
                                <p class="mtb_10 mlr_15">송파TV PD, 작가, 아나운서</p>
                            </td>
                        </tr>
                        <tr>
                            <th><p class="mlr_15 t_md_left">교육비용</p></th>
                            <td class="t_left">
                                <p class="mtb_10 mlr_15">무료</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <p class="mt_10 tc_1">※ 코로나19 상황에 따라 운영 취소 및 변동 가능.</p>
                <h2 class="c_tit_2 mt_90">접수안내</h2>
                <div class="bg_color_4 bg_color_md_1 ptb_20 mt_15">
                    <div class="img_step_box st_2 t_center fs_20 fs_md_26">
                        <ul class="row_15">
                            <li class="col_3 col_md_6 offset_3 offset_md_0">
                                <div class="step_text_wrap">
                                    <span class="step_num">2</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_02.png" alt="접수기간">
                                        <p>
                                            <b class="fs_22 fs_md_26 dp_inb mb_15">접수기간</b><br>
                                            교육 1주 전 접수 <br>&nbsp;
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap">
                                    <span class="step_num">3</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_03.png" alt="신청방법">
                                        <p><b class="fs_22 fs_md_26 dp_inb mb_15">신청방법</b><br>
                                            인터넷 접수<br>(전화접수 및 방문접수 불가)
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_3 col_md_6">
                                <div class="step_text_wrap">
                                    <span class="step_num">4</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_04.png" alt="선정방법">
                                        <p><b class="fs_22 fs_md_26 dp_inb mb_15">선정방법</b><br>
                                            선착순<br> &nbsp;
                                        </p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_85 mt_md_75">문의처</h2>
                <p class="mt_25 middot">송파구청 홍보담당관  ☎ 02-2147-2280</p>
            </div>
        </section>
    </div>
</div>
