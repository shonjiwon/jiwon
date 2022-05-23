<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '기관소개 > 기관소개 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    기관소개
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
                        <a href="/ssem/songpacenter/intro/intro.do" class="deapth_tit" title="선택">기관소개</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">기관소개</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/intro/use.do">이용안내</a></li>
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
            <a href="#" class="tab_m">기관소개<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item on"><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                <li  class="tab_item"><a href="/ssem/songpacenter/intro/use.do">이용안내</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">기관소개</h3>
        <div class="sub_info_visual youth_st_1 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <h5 class="fs_28 fw_400"></h5>
                    <p class="fs_18 fs_md_24 mt_40">
                        <span class="text_hide">풍선 아이이미지</span>
                    </p>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_95">비전</h2>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">미션</h3>
                <div class="youth_box fs_26 fs_md_34 t_center ptb_45 ptb_md_35">
                    <span class="tc_1">청소년</span>이 행복한 세상 만들기
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">비전</h3>
                <div class="youth_box fs_26 fs_md_34 t_center ptb_45 ptb_md_35">
                    청소년과 함께하는<span class="tc_1">청소년 행복특별도시 송파</span>
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">슬로건</h3>
                <div class="youth_box fs_26 fs_md_34 t_center ptb_45 ptb_md_35">
                    Happy Younth Special Songpa!!<br>
                    <span class="tc_1">청소년이 행복한 특별한 송파</span>
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">핵심가치</h3>
                <div class="row row_p_10 youth_info_list">
                    <div class="col_3 col_md_6">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/yil_item_01.jpg" alt="소통">
                                <span class="_tit">소통</span>
                            </div>
                            <div class="text_box st_1">
                                <div class="text">능동적으로 참여하고 <br>가치를 공유하는 청소년으로 성장</div>
                            </div>
                        </div>
                    </div>
                    <div class="col_3 col_md_6">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/yil_item_02.jpg" alt="협업">
                                <span class="_tit">협업</span>
                            </div>
                            <div class="text_box st_2">
                                <div class="text">더불어 성장하는 <br>네트워크형 청소년 육성</div>
                            </div>
                        </div>
                    </div>
                    <div class="col_3 col_md_6 mt_md_20">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/yil_item_03.jpg" alt="창의">
                                <span class="_tit">창의</span>
                            </div>
                            <div class="text_box st_3">
                                <div class="text">창의적 사고로 <br>미래를 주도하는 인재양성</div>
                            </div>
                        </div>
                    </div>
                    <div class="col_3 col_md_6 mt_md_20">
                        <div class="yil_item">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/yil_item_04.jpg" alt="인성">
                                <span class="_tit">인성</span>
                            </div>
                            <div class="text_box st_4">
                                <div class="text">미래 사회에 꼭 필요한 <br>사람중심의 인성함양</div>
                            </div>
                        </div>
                    </div>
                </div>

                <h2 class="c_tit_2 mt_95">인사말</h2>
                <div class="row_table mt_20 yil_img_text_box">
                    <div class="col pr_30 pr_md_0" >
                        <img src="/ssem/resources/img/sub/youth/yil_info_img_01.jpg" alt="깃발든 이미지">
                    </div>
                    <div class="col fs_18 fs_lg_14 fs_md_26 pl_30 pl_md_0 pt_md_40 lh_16">
                        <p class="fs_30 fs_lg_28 fs_md_34 tc_1"> 송파청소년센터는</p>

                        <p class="mt_20 fw_300 tc_sub">	4차 산업혁명 시대를 이끌어갈 미래 창의인재 양성을 위해 <br class="screen_lg_hide">
                            청소년들의 상상력과 창의력을 발현할 수 있는 ‘송파미래교육센터 제3관’의<br class="screen_lg_hide">
                            메이커스페이스 프로그램과 함께 청소년들의 심신단련, 자질배양, 취미개발,<br class="screen_lg_hide">
                            정서함양, 교류활동과 사회봉사활동을 통한 배움을 실천하는 <br class="screen_lg_hide">
                            다양한 프로그램 및 건전한 청소년 성문화 정착과 학교폭력 예방상담, <br class="screen_lg_hide">
                            대안학교까지도 그 사업의 폭을 넓혀 펼쳐 나가고 있습니다. 아울러 송파구<br class="screen_lg_hide">
                            생애 맞춤형 교육 플랫폼 ‘송파쌤(SSEM)’의 실현을 위해 유아체능단, <br class="screen_lg_hide">
                            초등방과후돌봄서비스 ‘송파키움센터’,  지역주민 평생교육, 생활체육프로그램 및<br class="screen_lg_hide">
                            주민편익시설 운영 등 모든 세대를 위한 양질의 교육서비스 제공을 통하여 청소년과<br class="screen_lg_hide">
                            함께하는 행복한 송파를 만들 수 있도록 노력하겠습니다.
                        </p>
                        <p class="mt_20">송파청소년센터 직원일동</p>
                    </div>
                </div>
                <h2 class="c_tit_2 mt_95">운영조직도</h2>
                <div class="youth_line_box mt_25">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img01.jpg"  class="mo_hide" alt="운영조직도 관장 밑 청소년운영위원회, 운영위원회 , 운영부장, 운영부장, 운영부장, 운영부장 운영부장 밑 업무지원팀, 청소년사업팀, 문화체육팀">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img01_m.jpg" class="pc_hide" alt="운영조직도 관장 밑 청소년운영위원회, 운영위원회 , 운영부장, 운영부장, 운영부장, 운영부장 운영부장 밑 업무지원팀, 청소년사업팀, 문화체육팀">
                </div>
                <h2 class="c_tit_2 mt_90">운영시간</h2>
                <div class="youth_info_table mt_25 fs_18 fs_md_26 t_center">
                    <ul class="row">
                        <li class="col_4">
                            <div class="_head">평일</div>
                            <div class="_cell">
                                06:00 ~ 22:00
                            </div>
                        </li>
                        <li class="col_4">
                            <div class="_head">토&middot;일요일</div>
                            <div class="_cell">
                                09:00 ~ 18:00
                            </div>
                        </li>
                        <li class="col_4">
                            <div class="_head">설 / 추석 / 법정공휴일</div>
                            <div class="_cell">
                                휴관
                            </div>
                        </li>
                    </ul>
                </div>

                <h2 class="c_tit_2 mt_100">오시는 길</h2>
                <div class="drct_wrap mt_30">
                    <div class="drct_box">
                        <!-- 네이버 지도 API 삽입 부분 -->
                        <div id="daumRoughmapContainer1605493177379" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;"></div>
                        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                        <script charset="UTF-8">
                            new daum.roughmap.Lander({
                                "timestamp" : "1605493177379",
                                "key" : "22xnr",
                                "mapHeight" : "420"
                            }).render();
                        </script>
                        <%--<img src="/ssem/resources/img/sub/smp_map_img_01.jpg" alt="네이버 지도">--%>
                        <!-- map_marker.png -->
                    </div>
                    <div class="drct_txt_box location_info">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_location">주소</i>주소</strong>
                                서울시 송파구 중대로4길 4
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_tel">연락처</i>연락처</strong>
                                (02)449 - 0500
                            </p></li>
                            <li><div class="por">
                                <strong class="s_loc_tit top"><i class="icon_bus">대중교통</i>대중교통</strong>
                                <ul class="ul_list_dash">
                                    <li> 가락시장역(3호선, 8호선) 8번 출구 수서방향 도보 10분 소요, 수서역 4,5번 출구 가락시장 방면 버스환승</li>
                                    <li> 수서역(3호선, 분당선) 4,5번 출구 가락시장 방면 버스환승</li>
                                    <li> 일반버스 : 16, 101, 401, 461, 1007, 3416, 333, 3011, N37</li>
                                </ul>
                            </div></li>
                        </ul>
                        <%--<p class="btn_box screen_md_hide">
                            <button type="button" class="btn">지도크게보기</button>
                            <button type="button" class="btn">길찾기</button>
                        </p>--%>
                    </div>
                </div>
            </div>
        </section>
    </div><!-- sub_con : e -->
</div>
