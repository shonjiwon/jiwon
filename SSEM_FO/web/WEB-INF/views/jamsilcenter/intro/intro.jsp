<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '기관소개 > 잠실청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual jamsil_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    기관소개
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
                        <a href="#" class="deapth_tit" title="선택">기관소개</a>
                        <ul>
                            <li><a href="/ssem/jamsilcenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/jamsilcenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/culture.do">주요사업</a></li>
                            <li><a href="/ssem/jamsilcenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/jamsilcenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_90 mb_20 mb_md_40 tit font_sc">기관소개</h3>
        <section class="text_con fs_18 fs_md_26 pb_100 mb_15 ">
            <div class="bg_color_4 jamsil_introduce">
                <div class="wrap">
                    <div class="row">
                        <div class="col_8 col_md_12 ptb_75 ptb_75 ptb_md_40">
                            <h2 class="c_tit_2">인사말</h2>
                            <p class="fs_18 fs_md_26 mt_15 fw_200">제4차 산업혁명을 토대로 청소년의 능동적인 참여 중심 프로그램과 <br class="screen_md_hide">체험적 삶의 교육으로 즐거움을 창조하며, 미래를 열어가는 청소년의 성장을 지원하고 있습니다.</p>
                        </div>
                        <div class="col_4 col_md_12">
                            <img src="/ssem/resources/img/sub/jamsil/introduce_img_01.png" alt="건물이미지">
                        </div>
                    </div>
                </div>
            </div>
            <div class="wrap">
                <div class="youth_line_box mt_100">
                    <img src="/ssem/resources/img/sub/jamsil/introduce_img_02.jpg" class="mo_hide" alt="자유, 즐거움, 성장, 배움은 이로운 가치를 실현하는 청소년의 삶 서울을 이끄는 송파와 함께 미래를 이끄는 잠실 청소년 센터">
                    <img src="/ssem/resources/img/sub/jamsil/introduce_img_02_m.jpg" class="pc_hide" alt="자유, 즐거움, 성장, 배움은 이로운 가치를 실현하는 청소년의 삶 서울을 이끄는 송파와 함께 미래를 이끄는 잠실 청소년 센터">
                </div>
                <h2 class="c_tit_2 mt_80">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_box">
                        <div id="daumRoughmapContainer1605699599034" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1605699599034",
                                "key" : "23zoq",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                    </div>
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location"></i>주소</strong>
                                (05561)서울시 송파구 올림픽로8길 22(잠실동)
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_phon"></i>대표번호</strong>
                                02)2039-1530
                            </p></li>
                        </ul>
                        <%--<p class="btn_box screen_md_hide">
                            <button type="button" class="btn">지도크게보기</button>
                            <button type="button" class="btn">길찾기</button>
                        </p>--%>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
