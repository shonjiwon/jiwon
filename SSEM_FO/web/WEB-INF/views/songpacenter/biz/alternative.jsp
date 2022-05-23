<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '대안학교 > 주요사업 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    주요사업
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
                        <a href="/ssem/songpacenter/biz/youth.do" class="deapth_tit" title="선택">주요사업</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">대안학교</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/biz/youth.do">청소년사업</a></li>
                            <li><a href="/ssem/songpacenter/biz/child.do">유아체능단</a></li>
                            <li><a href="/ssem/songpacenter/biz/alternative.do">대안학교</a></li>
                            <li><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
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
            <a href="#" class="tab_m">대안학교<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/songpacenter/biz/youth.do">청소년사업</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/child.do">유아체능단</a></li>
                <li class="tab_item on"><a href="/ssem/songpacenter/biz/alternative.do" title="선택">대안학교</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <h1 class="tit2 mt_100 mb_50">대안학교</h1>
            <div class="sub_info_visual youth_st_4 mt_md_50"> <!---sub_info_visual-->
                <div class="wrap tc_w fw_200">
                    <div class="sub_info_visual_text_box t_center"><span class="text_hide">여학생들 공부하는 이미지</span></div>
                </div>
            </div><!---sub_info_visual //-->
            <div class="wrap">
                <h2 class="c_tit_2 mt_85 mt_md_75">소개</h2>
                <p class="mt_25 middot">
                    대안학교 “한들”은 송파청소년센터에서 운영하는 서울시학교밖청소년지원센터 네트워크학교입니다. <br>
                    지역사회와 센터의 다양한 자원을 활용하여 실질적인 학습을 지원하며 넓은 들판에 자라는 생명에 넉넉하고 푸근한 공간을 마련하고 싹을 틔우도록 도와주는 곳입니다.
                </p>
                <h2 class="c_tit_2 mt_85 mt_md_75">한들의 철학</h2>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">교육철학</h3>
                <div class="youth_line_box mt_10 bg_color_2">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img03.jpg" class="mo_hide" alt="배려의 교육, 조화의 교육, 사회화의 네트워크">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img03_m.jpg" class="pc_hide" alt="배려의 교육, 조화의 교육, 사회화의 네트워크">
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15">목적</h3>
                <ul class="row row_p_23  fs_18 fs_md_22 fs_sm_26 ls_75 t_center">
                    <li class="col_3 col_lg_6 col_sm_12">
                        <div class="yb_box ptb_60">
                            <img src="/ssem/resources/img/sub/youth/school_img_01.jpg" alt="계단 올라가는 아이콘">
                            <p class="lh_17">
                                학교 밖 청소년들의<br>
                                자기주도적 목표설정을 통한<br>
                                자기정체성 형성
                            </p>
                        </div>
                    </li>
                    <li class="col_3 col_lg_6 col_sm_12 mt_sm_40">
                        <div class="yb_box ptb_60">
                            <img src="/ssem/resources/img/sub/youth/school_img_02.jpg" alt="글로벌 아이콘">
                            <p class="lh_17">
                                학교생활을 통한<br>
                                사회안전망 구축으로<br>
                                유해환경으로의 유입 차단
                            </p>
                        </div>
                    </li>
                    <li class="col_3 col_lg_6 col_sm_12 mt_lg_40">
                        <div class="yb_box ptb_60">
                            <img src="/ssem/resources/img/sub/youth/school_img_03.jpg" alt="표지판 아이콘">
                            <p class="lh_17">
                                공동체활동을 통한<br>
                                유대감 형성으로 학교 밖<br>
                                청소년들의 전인적 성장 도모
                            </p>
                        </div>
                    </li>
                    <li class="col_3 col_lg_6 col_sm_12 mt_lg_40">
                        <div class="yb_box ptb_60">
                            <img src="/ssem/resources/img/sub/youth/school_img_04.jpg" alt="학사모 아이콘">
                            <p class="lh_17">
                                다양한 경험 및 외부<br>
                                체험활동을 통하여<br>
                                상급학교 진학 및 직업으로 연계
                            </p>
                        </div>
                    </li>
                </ul>
                <h2 class="c_tit_2 mt_85 mt_md_75">입학안내</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">입학안내의 대상, 정원, 학기, 교육비, 입학절차, 교육장소</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="76%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>대상</th>
                            <td><p class="mtb_10 mlr_20 t_left">14~19세 학교 밖 청소년</p></td>
                        </tr>
                        <tr>
                            <th>정원</th>
                            <td><p class="mtb_10 mlr_20 t_left">15명</p></td>
                        </tr>
                        <tr>
                            <th>학기</th>
                            <td><p class="mtb_10 mlr_20 t_left">2년 4학기제(1학기 : 3~7월 / 2학기 : 9~12월)</p></td>
                        </tr>
                        <tr>
                            <th>교육비</th>
                            <td><p class="mtb_10 mlr_20 t_left">월 20만원</p></td>
                        </tr>
                        <tr>
                            <th>입학절차</th>
                            <td><p class="mtb_10 mlr_20 t_left">전화/방문상담 &rarr; 서류접수 &rarr; 예비학교 &rarr; 합격발표</p></td>
                        </tr>
                        <tr>
                            <th>교육장소</th>
                            <td><p class="mtb_10 mlr_20 t_left">한들교실, 피아노실, 드럼실, 체육관, 헬스장</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h2 class="c_tit_2 mt_95 mt_md_75">교육과정</h2>
                <p class="mt_25 middot"><strong>기초교과</strong> : 독서ㆍ논술 / 스포츠 / 도시농업</p>
                <p class="mt_25 middot"><strong>선택교과</strong> : 드럼 / 피아노 / 미술 / 헬스 </p>
                <p class="mt_25 middot"><strong>특별활동</strong> : 경제 시사 / 만화 / 애니메이션</p>
                <p class="mt_25 middot"><strong>개별학습</strong> : 영어 / 수학 / 사회 / 피아노 / 컴퓨터</p>
                <p class="mt_25 middot"><strong>검정고시 무상지원</strong></p>
                <p class="mt_25 middot"><strong>특별 프로젝트 활동</strong></p>
                <ul class="row row_p_23 mt_25  fs_20 fs_md_22 fs_sm_26">
                    <li class="col_4 col_lg_6 col_sm_12">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img07.jpg" alt="환경프로젝트">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">환경프로젝트</strong>삼성꿈장학재단 “달리는 지구 지킴이” <br>자전거하이킹, 환경캠페인 등</p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_sm_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img08.jpg" alt="JOB프로젝트">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">JOB프로젝트</strong> 집단상담, 진로직업체험, 문화체험활동</p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_lg_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img09.jpg" alt="동아리 활동">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">동아리 활동</strong> 밴드 10초, 디자인한들 </p>
                        </div>
                    </li>
                </ul>
                <h2 class="c_tit_2 mt_95 mt_md_75">문의</h2>
                <p class="mt_25 middot">02-2147-5323~4 (한들 네이버카페 <a href="https://cafe.naver.com/gksemf" target="_blank" class="link_blank">https://cafe.naver.com/gksemf</a>)</p>
            </div>
        </section>
    </div>
</div>
