<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '주요사업 > 마천청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js

        AOS.init({easing: 'ease-in-out', duration:800, once : true });
        setTimeout(function() {
            AOS.refresh();
        }, 100);
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual macheon_st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    주요사업
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
                        <a href="#" class="deapth_tit" title="선택">주요사업</a>
                        <ul>
                            <li><a href="/ssem/machuncenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/machuncenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/machuncenter/biz/major.do">주요사업</a></li>
                            <li><a href="/ssem/machuncenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/machuncenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <section class="text_con fs_18 fs_md_26 fw_300 pb_100 mb_15">
            <div class="wrap">
                <h1 class="tit2 mt_100 mb_50">주요사업</h1>
                <div class="mch_busi_img_box">
                    <div class="mch_busi_img"  data-aos="fade-left">
                        <img src="/ssem/resources/img/sub/macheon/business_01.jpg" alt="청소년자치조직활동 이미지">
                    </div>
                    <div class="mch_busi_text">
                        <div class="text_con st_1 fw_300">
                            <div>
                                <h2 class="_tit fs_24 fs_md_30 fw_500">청소년자치조직활동</h2>
                                <p class="mt_20 lh_16">
                                    청소년 스스로가 주인공이 되어 숨겨진 재능과 역량을 키우는 활동으로 <br>
                                    청소년운영위원회, 자원봉사동아리, 미술동아리, 영어동아리,  <br>
                                    기자단 등의 활동이 있습니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mch_busi_img_box st_2">
                    <div class="mch_busi_text">
                        <div class="text_con st_2 fw_300">
                            <div>
                                <h2 class="_tit fs_24 fs_md_30 fw_500">방과후학습교실</h2>
                                <p class="mt_20 lh_16">
                                    초등연령의 청소년들의 자립역량을 개발하고 건강한 성장 지원을 위한<br>
                                    학습지원, 체험활동 등 종합서비스를 제공하는 사업으로 아이스쿨, <br>
                                    해피스쿨, 원어민 영어교실 등이 있습니다.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="mch_busi_img"  data-aos="fade-right">
                        <img src="/ssem/resources/img/sub/macheon/business_02.jpg" alt="방과후학습교실 이미지">
                    </div>
                </div>
                <div class="mch_busi_img_box">
                    <div class="mch_busi_img"  data-aos="fade-left">
                        <img src="/ssem/resources/img/sub/macheon/business_03.jpg" alt="해피오케스트라 이미지">
                    </div>
                    <div class="mch_busi_text">
                        <div class="text_con st_3 fw_300">
                            <div>
                                <h2 class="_tit fs_24 fs_md_30 fw_500">해피오케스트라</h2>
                                <p class="mt_20 lh_16">
                                    지역청소년들에게 오케스트라 경험을 통해 문화역량 향상과 사회성 향상을<br>
                                    이끌어 내는 종합예술프로그램입니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mch_busi_img_box st_2 mb_30">
                    <div class="mch_busi_text">
                        <div class="text_con st_4 fw_300">
                            <div>
                                <h2 class="_tit fs_24 fs_md_30 fw_500">청소년체험활동</h2>
                                <p class="mt_20 lh_16">
                                    청소년들의 자기주도적 경험과 민주시민으로서 성장, <br>
                                    미래사회를 살아가게 하는 다양한 봉사, 사회참여, 문화예술, 진로 등의 <br>
                                    체험을 제공하는 사업입니다.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="mch_busi_img"  data-aos="fade-right">
                        <img src="/ssem/resources/img/sub/macheon/business_04.jpg" alt="청소년체험활동 이미지">
                    </div>
                </div>
                <div class="mch_busi_img_box">
                    <div class="mch_busi_img"  data-aos="fade-left">
                        <img src="/ssem/resources/img/sub/macheon/business_05.jpg" alt="평생교육활동 이미지">
                    </div>
                    <div class="mch_busi_text">
                        <div class="text_con st_5 fw_300">
                            <div>
                                <h2 class="_tit fs_24 fs_md_30 fw_500">평생교육활동</h2>
                                <p class="mt_20 lh_16">
                                    지역주민들의 인문, 취미 강좌 및 사회체육 등의 프로그램제공으로 <br class="screen_md_hide ">삶의 질을 향상시키는 사업입니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
