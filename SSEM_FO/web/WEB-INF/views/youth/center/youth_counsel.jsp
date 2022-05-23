<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '송파 청소년 상담복지센터 > 교육지원 > 미래교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">송파 청소년 상담복지센터</a>
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
        <h3 class="mt_100 mb_50 tit font_sc">송파 청소년 상담복지센터</h3>

        <div class="sub_info_visual st_7 mt_md_50 t_center"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box ">
                    <h5 class="fs_38">송파 청소년 상담복지센터는</h5>
                    <p class="fs_22 fs_md_26 mt_30">
                        청소년상담 전문기관으로서 청소년들의 정신건강, 학습, <br class="screen_hide screen_lg_show">
                        진로문제 등 청소년기의 고민과 갈등을 해소하고 <br class="screen_hide screen_md_show"> 꿈과 희망을 심어주는 <br class="screen_md_hide">
                        상담활동 및 위기청소년 상담, <br class="screen_hide screen_md_show">
                        긴급구조, 치료, 자활, 찾아가는 상담(청소년동반자) 등 <br class="screen_hide screen_lg_show">
                        종합적인 지원서비스를 원스톱으로 제공합니다.<br>
                        본 센터는 전문적인 상담과 기관연계 등을 통해 청소년이 <br class="screen_hide screen_md_show"> 건강한 삶을 펼쳐 나갈 수 있도록 함께 합니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">

                <h2 class="c_tit_2 mt_95">기관소개</h2>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">조직도</h3>

                <div class="youthCareGrp_wrap fs_20 fs_md_26">
                    <div class="ycg_1 ">
                        <div class="line_1"></div>
                        <div class="ycg_grp st_1"><span>센터장</span></div>

                        <div class="clearfix mt_70">
                            <div class="line_2"></div>
                            <div class="ycg_grp st_2 float_left"><span>운영위원회</span></div>
                            <div class="ycg_grp st_3 float_right"><span>실행위원회</span></div>
                        </div>

                        <div class="clearfix mt_50">
                            <div class="line_2"></div>
                            <div class="ycg_grp st_2 float_left"><span>1388 청소년지원단</span></div>
                            <div class="ycg_grp st_3 float_right"><span>학교지원단</span></div>
                        </div>
                    </div>
                    <div class="ycg_2">
                        <div class="line_1"></div>
                        <div class="ycg_grp_box">
                            <div class="ycg_grp mb_md_50">
                                <span class="ycg_grp_top"><span>상담지원팀</span></span>
                                <ul class="ul_list_dash fs_18 fs_md_26 fw_300 plr_20 pt_20">
                                    <li>개인상담</li>
                                    <li>심리검사</li>
                                    <li>놀이/미술치료</li>
                                    <li>놀이평가</li>
                                    <li>1388 전화상담</li>
                                    <li>솔리언 또래상담 </li>
                                </ul>
                            </div>
                        </div>
                        <div class="ycg_grp_box">
                            <div class="ycg_grp mb_md_50">
                                <span class="ycg_grp_top"><span>통합지원팀</span></span>
                                <span class="dp_inb plr_20 pt_20 fs_20 fs_md_26 fw_600 tc_b">청소년안전망 구축 사업</span>
                                <ul class="ul_list_dash fs_18 fs_md_26 fw_300 plr_20 pt_5">
                                    <li>운영위원회</li>
                                    <li>실행위원회</li>
                                    <li>학교지원단</li>
                                    <li>1388청소년지원단</li>
                                    <li>위기청소년 긴급구조 및 통합 사례 관리</li>
                                    <li>1388 아웃리치</li>
                                    <li>멘토링 지원</li>
                                </ul>
                            </div>
                        </div>
                        <div class="ycg_grp_box">
                            <div class="ycg_grp">
                                <span class="ycg_grp_top"><span>청소년동반자</span></span>
                                <ul class="ul_list_dash fs_18 fs_md_26 fw_300 plr_20 pt_20">
                                    <li>청소년동반자 프로그램 운영 관리</li>
                                    <li>위기청소년 지원 및 찾아가는 상담</li>
                                    <li>위기청소년 문화활동 지원</li>
                                    <li>지역사회 연계 및 지원</li>
                                </ul>
                            </div>
                        </div>
                        <div class="ycg_grp_box">
                            <div class="ycg_grp">
                                <span class="ycg_grp_top"><span>학교폭력예방센터</span></span>
                                <ul class="ul_list_dash fs_18 fs_md_26 fw_300 plr_20 pt_20">
                                    <li>학교폭력 신고 접수 및 상담개입</li>
                                    <li>학교폭력예방교육</li>
                                    <li>회복적 대화모임</li>
                                    <li>학교폭력예방 집단 상담</li>
                                    <li>학교폭력실태조사 및 연구</li>
                                    <li>학교폭력 관련 프로그램 개발</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_80">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <!--2020.11.09:s-->
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location">주소</i>주소</strong>
                                서울시 송파구 중대로4길 4(문정동 150-8) <br class="screen_hide screen_md_show"> 송파청소년센터 3층
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_tel">전화</i>전화번호</strong>
                                02)407-7179
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_bus">대중교통</i>대중교통</strong>
                                - 지하철 :  3호선 · 분당선 수서역 4,5번 출구 방면 3 · 8호선 가락시장역 8번출구 방면 도보로 10분 소요 <br>
                                - 일반버스 : 16 , 333, 401, 461, 3011, 3413, 4316
                                </p>
                            </li>
                        </ul>
                    </div>
                    <!--2020.11.09:e-->
                </div>
                <h2 class="c_tit_2 mt_90">이용안내</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_md_26 t_center t_center screen_md_hide">
                    <table class="st_2">
                        <caption class="text_hide">이용안내의 이용대상, 이용시간, 이메일</caption>
                        <colgroup>
                            <col width="33.333%">
                            <col width="33.333%">
                            <col width="33.333%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th><p class="mlr_15 fw_500">이용대상</p></th>
                            <th><p class="mlr_15 fw_500">이용시간</p></th>
                            <th><p class="mlr_15 fw_500">E - mail</p></th>
                        </tr>
                        <tr>
                            <td><p class="mtb_10 mlr_15 ">아동, 청소년(9~24세), 부모</p></td>
                            <td><p class="mtb_10 mlr_15 ">
                                평     일 : 오전 9시 ~ 오후 8시<br>
                                토요일 : 오전 9시 ~ 오후 5시<br>
                                (Help Call 청소년전화1388은 365일 24시간 운영)
                            </p></td>
                            <td><p class="mtb_10 mlr_15 "> spl388@daum.net</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!--모바일-->
                <div class="table_box mt_25 fs_18 fs_md_20 fs_md_26 t_center screen_hide screen_md_show">
                    <table class="st_2">
                        <caption class="text_hide">이용안내의 이용대상, 이용시간, 이메일</caption>
                        <colgroup>
                            <col width="30%">
                            <col width="70%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="t_left"><p class="mlr_15">이용대상</p></th>
                            <td><p class="mtb_10 mlr_15 t_left">아동, 청소년(9~24세), 부모</p></td>
                        </tr>
                        <tr>
                            <th class="t_left"><p class="mlr_15">이용시간</p></th>
                            <td><p class="mtb_10 mlr_15 t_left">
                                평     일 : 오전 9시 ~ 오후 8시<br>
                                토요일 : 오전 9시 ~ 오후 5시<br>
                                (Help Call 청소년전화1388은 365일 24시간 운영)
                            </p></td>
                        </tr>
                        <tr>
                            <th class="t_left"><p class="mlr_15">E - mail</p></th>
                            <td><p class="mtb_10 mlr_15 t_left"> spl388@daum.net</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h2 class="c_tit_2 mt_90">주요 사업소개</h2>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_01.png" alt="운영이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">청소년안전망 구축ㆍ운영</span></p>
                                    <p>1388전화 운영</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_02.png" alt="팔렛트이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">위기 청소년 상담사업 운영</span></p>
                                    <p>개인상담, 심리검사, 놀이치료, 미술치료 등</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_03.png" alt="말풍선이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">위기 청소년 예방사업 운영</span></p>
                                    <p>찾아가는 집단상담</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_04.png" alt="학교이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">학교폭력 예방사업 운영</span></p>
                                    <p>부모교육, 예방교육, 갈등 해결프로그램 등</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_05.png" alt="사람이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">청소년 동반자 프로그램 운영</span></p>
                                    <p>청소년 및 학부모 상담, 학부모 교육 등</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_06.png" alt="책이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">상담종사자 및 자원봉사자</span></p>
                                    <p>교육 및 연수</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="info_box_table st_2 mt_15 fs_18 fs_md_26">
                    <div class="col_wrap mt_md_20">
                        <dl>
                            <dt>
                                <img src="/ssem/resources/img/sub/ycg_img_07.png" alt="전구이미지">
                            </dt>
                            <dd>
                                <div class="plr_20">
                                    <p class="c_tit_3 t_bef_middot c1 mb_15"><span class="fs_22 fs_md_26">특별지원 청소년 사례관리</span></p>
                                    <p>&nbsp;</p>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="col_wrap">
                    </div>
                </div>
                <!--2020.11.09:s-->
                <h2 class="c_tit_2 mt_90">상담신청 방법 </h2>
                <p class="por mt_30">전화를 통한 사전예약제로 진행되며, 별도의 비용 및 대기기간이 발생할 수 있습니다.</p>
                <div class="bg_color_4 bg_color_md_1 ptb_20 ptb_md_0 mt_15">
                    <div class="img_step_box st_2 t_center fs_20 fs_md_26">
                        <ul class="row_24">
                            <li class="col_4 offset_6 col_md_12 offset_md_0">
                                <div class="step_text_wrap">
                                    <span class="step_num" ptb_md_20>1</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_06_img_01.png" alt="상담신청서 양식 작성">
                                        <p>
                                            <b class="fs_22 fs_md_26 dp_inb">상담신청서 양식 작성</b><br>
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_4 col_md_12 ">
                                <div class="step_text_wrap">
                                    <span class="step_num" ptb_md_20>2</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_05_img_03.png" alt="이메일 발송">
                                        <p>
                                            <b class="fs_22 fs_md_26 dp_inb">이메일 발송</b><br>
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_4 col_md_12 ">
                                <div class="step_text_wrap ptb_md_20">
                                    <span class="step_num">3</span>
                                    <div class="step_text_box">
                                        <img src="/ssem/resources/img/sub/img_setp_06_img_02.png" alt="센터 확인 후 전화예약">
                                        <p><b class="fs_22 fs_md_26 dp_inb">센터 확인 후 전화예약</b><br>
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li class="col_24 t_center mb_40">
                                &middot; 센터 홈페이지에서 상담신청서 다운로드 가능 (http://www.sp1318.or.kr/index.asp)
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="btn_box mt_50 t_center">
                    <a href="http://www.sp1318.or.kr/index.asp" class="btn btn_auto btn_big t_center" target="_blank">상담신청하러가기</a>
                </div>
                <!--2020.11.09:e-->
            </div>
        </section>
    </div>
</div>
