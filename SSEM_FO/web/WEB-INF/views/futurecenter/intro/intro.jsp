<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '기관소개 > 미래교육센터 오금Hub > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual songpa_st_1"><!-- sub_visual -->
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
    <!--

			sub_con st_1 color - #3f78d4
			sub_con st_2 color - #e08c34
			sub_con st_3 color - #9e61e4
			sub_con st_4 color - #f05484
			sub_con st_5 color - #1fb593

    -->
    <div class="sub_con st_1"><!-- sub_con -->

        <h3 class="mt_80 mb_50 tit font_sc">기관소개</h3>


        <div class="sub_info_visual songpa_st_1 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <h5 class="fs_28 fs_md_32 fw_400">미래교육센터 오금Hub 홈페이지에<br class="screen_hide screen_md_show"> 방문하신 여러분을 환영합니다.</h5>
                    <p class="fs_18 fs_md_26 mt_40">
                        ‘미래교육센터 오금Hub’는 미래사회의 주인공인 <br class="screen_hide screen_md_show">청소년의 함성(함께성장)을 위하여 <br>
                        송파구가 설립한 송파구 유일의 청소년특화시설입니다. <br>
                        미래사회의 주인공인 청소년들이 새로운 변화를 <br class="screen_hide screen_md_show">두려워 않고(Don’t Worry), <br class="screen_md_hide">
                        그 변화를 주도하며 즐기는(Be Happy) <br class="screen_hide screen_md_show">젊은 혁신가들이 되길 응원합니다.
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h3 class="c_tit_3 t_bef_middot c1 mt_70 mb_15 fw_400">로고</h3>
                <div class="youth_box mt_25 bg_color_2">
                    <img src="/ssem/resources/img/sub/songpa/songpa_img01.jpg"  class="mo_hide" alt="구립 송파청소년 미래센터 사람의 이미지는 청소년을 의미합니다. 위로 상승하는 곡선은 미래로의 도약과 성장을 의미합니다. 나뭇잎은 청소년의 성장을 의미합니다.">
                    <img src="/ssem/resources/img/sub/songpa/songpa_img01_m.jpg" class="pc_hide" alt="구립 송파청소년 미래센터 사람의 이미지는 청소년을 의미합니다. 위로 상승하는 곡선은 미래로의 도약과 성장을 의미합니다. 나뭇잎은 청소년의 성장을 의미합니다.">
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">미션</h3>
                <div class="youth_box fs_26 fs_md_32 t_center ptb_45 ptb_md_35">
                    <span class="tc_1">미래</span>를 꿈꾸는 가치있는 삶
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">비전</h3>
                <div class="youth_box fs_26 fs_md_32 t_center ptb_45 ptb_md_35">
                    <span class="tc_1">청소년의 미래를 </span>만들어가는 플랫폼
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">핵심가치</h3>
                <div class="row row_p_10 songpa_info_list fs_26 fs_md_30">
                    <div class="col_4">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/songpa/item_01.jpg" alt="도전">
                                <span class="_tit">도전</span>
                            </div>
                            <div class="text_box st_1">
                                <div class="text fw_600">Challenge</div>
                            </div>
                        </div>
                    </div>
                    <div class="col_4">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/songpa/item_02.jpg" alt="성장">
                                <span class="_tit">성장</span>
                            </div>
                            <div class="text_box st_2">
                                <div class="text fw_600">Expand</div>
                            </div>
                        </div>
                    </div>
                    <div class="col_4">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/songpa/item_03.jpg" alt="기회">
                                <span class="_tit">기회</span>
                            </div>
                            <div class="text_box st_3">
                                <div class="text fw_600">Opportunity</div>
                            </div>
                        </div>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_95">소개글</h2>
                <div class="row_table mt_20 yil_img_text_box">
                    <div class="col pr_30 pr_md_0">
                        <img src="/ssem/resources/img/sub/songpa/info_img_01.jpg" alt="어린이 이미지">
                    </div>
                    <div class="col fs_18 fs_lg_14 fs_md_26 pl_30 pl_md_20 pr_md_20 pt_md_40 lh_16">
                        <p class="fs_30 fs_lg_28 fs_md_34 tc_1" style="text-indent: -0.5em;">「청소년미래교육 특화시설」창의·융합 제작공간,
                            미래교육센터 오금Hub는</p>

                        <p class="mt_20 fw_300 tc_sub">트렌드를 반영한 팹랩 조성으로 관내 청소년이라면 <br>
                            누구나 메이커 교육을 접하고, 배울 수 있는 청소년 자율 활동 공간입니다.
                        </p>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_80">오시는 길</h2>
                <div class="drct_wrap line_bottom pb_100 mt_30 mt_md_10">
                    <div class="drct_box">
                        <div id="daumRoughmapContainer1605706054163" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1605706054163",
                                "key" : "23zpb",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                    </div>
                    <div class="drct_txt_box location_info tc_sub">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_location"></i>주소</strong>
                                우)05738 서울시 송파구 동남로28길 40(오금동)
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit tc_b"><i class="icon_phon"></i>대표번호</strong>
                                <span class="dp_inb mr_20">TEL : 02)6951-1825</span>
                                <span class="dp_inb">FAX : 02)6951-1826</span>
                            </p></li>
                        </ul>
                        <p class="btn_box screen_md_hide">
                            <button type="button" class="btn">지도크게보기</button>
                            <button type="button" class="btn">길찾기</button>
                        </p>
                    </div>
                </div>
                <div class="btn_box mt_50 t_center">
                    <a href="http://www.spmirae.or.kr" class="btn btn_auto btn_big t_center" target="_blank">홈페이지 바로가기</a>
                </div>
            </div>
        </section>
    </div>
</div>
