<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오전 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '청소년사업 > 주요사업 > 송파청소년센터 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">청소년사업</a>
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
            <a href="#" class="tab_m">청소년사업<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/songpacenter/biz/youth.do" title="선택">청소년사업</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/child.do">유아체능단</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/alternative.do">대안학교</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <h1 class="tit2 mt_100 mb_50">청소년사업</h1>

            <div class="sub_info_visual youth_st_2 mt_md_50"> <!---sub_info_visual-->
                <div class="wrap tc_w fw_200">
                    <div class="sub_info_visual_text_box t_center">
                        <span class="text_hide">여학생들 공부하는 이미지</span>
                    </div>
                </div>
            </div><!---sub_info_visual //-->
            <div class="wrap">
                <h2 class="c_tit_2 mt_95 mt_md_75">청소년 참여기구</h2>
                <p class="mt_25 middot">
                    송파구의 아동, 청소년들이 지방자치단체 정책 및 사업과정에 주체적으로 참여하여 아동, 청소년들의 권익증진 도모
                </p>
                <h2 class="c_tit_2 mt_85">청소년 동아리</h2>
                <ul class="row row_p_23 mt_25  fs_20 fs_md_22 fs_sm_26">
                    <li class="col_4 col_lg_6 col_sm_12">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img01.jpg" alt="문화동아리">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">문화동아리</strong> 올바른 청소년의 문화정착과 건전한 여가활동 <br>(댄스, 태권도, 밴드, 보컬 등)</p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_sm_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img02.jpg" alt="특성화동아리">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">특성화동아리</strong> 다양한 분야의 특성화활동 프로젝트 개발 및 연구, 진행 등을 통해 미래진로 설계<br> (대학생 서포터즈, 봉사지역단, 과학동아리)</p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_lg_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img03.jpg" alt="메이커동아리">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">메이커동아리</strong> 4차산업 미래교육을 통해 문제해결능력을 향상하고 창의적 인재 육성을 위한 창작문화 확산<br>(디자인, 3D, 메이커)</p>
                        </div>
                    </li>
                </ul>
                <h2 class="c_tit_2 mt_95 mt_md_75">학교연계</h2>
                <p class="mt_25 middot">
                    창의체험&middot;진로직업 활동을 통한 창의력함양 교육과 다양한 장르와 연계된 융합체험활동(창의체험활동, 자유학년제활동, 봉사인성체험활동)
                </p>
                <h2 class="c_tit_2 mt_95 mt_md_75">청소년 봉사활동</h2>
                <p class="mt_25 middot">
                    타인 및 지역사회 복지의 증진과 발전을 위해 봉사활동을 실시하고 건강한 인성을 형성해 가는 체험형 봉사활동 <br>(장애체험봉사활동, 언어순화봉사활동, 지역사회 노력봉사, 유해환경캠페인, 환경보호, 나눔 봉사활동)
                </p>
                <h2 class="c_tit_2 mt_95 mt_md_75">청소년 참여 인성 활동</h2>
                <p class="mt_25 middot">
                    청소년의 눈높이에 맞는 정책 교육과 토론을 통해 청소년의 참여의식을 향상시키고 정책사업 과정에 주체적으로 참여 하여 건전한 자치활동 보장 및 사회참여역량 향상 (정책참여학교, 정책토론회, 청소년의회, 참여워크숍 등)
                </p>
                <h2 class="c_tit_2 mt_95 mt_md_75">청소년 체험활동</h2>
                <p class="mt_25 middot">
                    <strong>4차 산업 메이커 활동 </strong>: 지역사회 및 학교를 기반으로 한 네트워크 구성으로 함께 배우고 성장하는 마을 중심의 4차 산업교육을 통해 인간중심의 창의적 문제해결 능력 향상
                </p>
                <p class="mt_25 middot">
                    <strong>진로 체험 활동 </strong>: 다양한 진로직업 체험을 통해 흥미를 유발하고 미래를 설계하는 과정을 거침으로써 창의적인 미래세대 육성
                </p>
            </div>
        </section>
    </div>
</div>
