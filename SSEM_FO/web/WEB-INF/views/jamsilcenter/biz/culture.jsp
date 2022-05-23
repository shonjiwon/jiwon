<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '교육문화 사업 > 주요사업 > 잠실청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual jamsil_st_3"><!-- sub_visual -->
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
                            <li><a href="/ssem/jamsilcenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/jamsilcenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/culture.do">주요사업</a></li>
                            <li><a href="/ssem/jamsilcenter/fac/intro.do">시설안내</a></li>
                            <li><a href="/ssem/jamsilcenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">교육문화 사업</a>
                        <ul>
                            <li><a href="/ssem/jamsilcenter/biz/culture.do">교육문화 사업</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/youth.do">청소년 사업</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/counsel.do">상담 사업</a></li>
                        </ul>
                    </li>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">교육문화 사업<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/jamsilcenter/biz/culture.do">교육문화 사업</a></li>
                <li class="tab_item"><a href="/ssem/jamsilcenter/biz/youth.do">청소년 사업</a></li>
                <li class="tab_item"><a href="/ssem/jamsilcenter/biz/counsel.do">상담 사업</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">교육문화 사업</h3>
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <div class="row_table mt_20 jil_img_text_box">
                    <div class="col plr_30 plr_md_0 pr_md_0">
                        <img src="/ssem/resources/img/sub/jamsil/img_01.jpg" alt="암벽 등반">
                    </div>
                    <div class="col fs_18 fs_lg_14 fs_md_26 pl_30 pl_md_20 pr_md_20 pt_md_40 lh_16">
                        <p class="fs_20 fs_lg_28 fs_md_34">
                            송파구 청소년과 지역주민 대상 특성별 프로그램을 개발·제공하여 개인의 역량강화와<br class="screen_md_hide">
                            건전한 여가선용을 도모하며 송파구 삶의 질이 향상되도록 돕는 교육문화프로그램 제공
                        </p>
                        <p class="mt_20 fw_300 tc_sub"> <span class="tc_b">대표프로그램 : </span>가족클라이밍, 청소년 대상 예체능프로그램, 토요일특화 가족프로그램 등</p>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
