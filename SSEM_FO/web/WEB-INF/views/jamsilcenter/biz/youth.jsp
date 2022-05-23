<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-18
  Time: 오후 8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '청소년 사업 > 주요사업 > 잠실청소년센터 > 송파쌤');

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
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">청소년 사업</a>
                        <ul>
                            <li><a href="/ssem/jamsilcenter/biz/culture.do">교육문화 사업</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/youth.do">청소년 사업</a></li>
                            <li><a href="/ssem/jamsilcenter/biz/counsel.do">상담 사업</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">청소년 사업<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/jamsilcenter/biz/culture.do">교육문화 사업</a></li>
                <li class="tab_item on"><a href="/ssem/jamsilcenter/biz/youth.do">청소년 사업</a></li>
                <li class="tab_item"><a href="/ssem/jamsilcenter/biz/counsel.do">상담 사업</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">청소년 사업</h3>
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <div class="row_table mt_20 jil_img_text_box">
                    <div class="col plr_30 plr_md_0 va_t">
                        <div class="row row_p_10">
                            <div class="col_6"><img src="/ssem/resources/img/sub/jamsil/img_02.jpg" class="shd" alt="단체사진1"></div>
                            <div class="col_6"><img src="/ssem/resources/img/sub/jamsil/img_03.jpg" class="shd" alt="단체사진2"></div>
                            <div class="col_6 pt_20"><img src="/ssem/resources/img/sub/jamsil/img_04.jpg" class="shd" alt="단체사진3"></div>
                            <div class="col_6 pt_20"><img src="/ssem/resources/img/sub/jamsil/img_08.jpg" class="shd" alt="vr이미지"></div>
                        </div>
                    </div>
                    <div class="col fs_18 fs_lg_14 fs_md_26 pl_20 pl_md_20 pr_md_20 pt_md_40 lh_16 fw_200 va_t">
                        <p class="fs_20 fs_lg_28 fs_md_34">
                            청소년 네트워크 조성 및 청소년 전용 공간 제공, 주도적 활동 장려를 통해 즐겁게 배우고 성장하는 자유로운 청소년과 함께 다양한 청소년 활동 진행
                        </p>
                        <ul class="mt_30 tc_sub">
                            <li class="mb_20">
                                <p class="fw_400 tc_b"><b class="tc_1 fw_400 mr_10 va_m">즐거운 청소년</b> <span class="va_m">청소년의 즐거움이 시작 되는 곳</span> </p>
                                <p>청소년문화공간, 활동서포터즈, 작은문화제</p>
                            </li>
                            <li class="mb_20">
                                <p class="fw_400 tc_b"><b class="tc_1 fw_400 mr_10 va_m"> 배우는 청소년</b>  <span class="va_m">학업에서 배울 수 없는 중요한 가치를 찾다</span> </p>
                                <p>자원봉사운영, 토요체험활동, 학교연계사업</p>
                            </li>
                            <li class="mb_20">
                                <p class="fw_400 tc_b"><b class="tc_1 fw_400 mr_10 va_m"> 성장하는 청소년</b>  <span class="va_m">소통과 신뢰를 통한 너와 나의 동반성장</span> </p>
                                <p class="ls_6">청소년운영위원회, 자치기구발대식·교류활동·어워드, <br>체인지메이커활동(청소년수련활동인증프로그램)</p>
                            </li>
                            <li class="mb_20">
                                <p class="fw_400 tc_b"><b class="tc_1 fw_400 mr_10 va_m">자유로운 청소년</b>  <span class="va_m">즐길 줄 아는 청소년, 온 마을이 사랑하는 청소년 </span> </p>
                                <p>청소년동아리, 특화동아리, 네트워킹사업</p>
                            </li>
                            <li class="mb_20">
                                <p class="fw_400 tc_b"><b class="tc_1 fw_400 mr_10 va_m">특화사업</b>  <span class="va_m">가족과 함께 청소년과 함께 행복을 비추는 동행</span> </p>
                                <p>가족재능나눔사업, 가족캠프, 스포츠기획단, 청소년캠프</p>
                            </li>
                            <!-- <li>
                                <p class="fw_400"><b class="tc_1 fw_400 mr_10 va_m">잠실솔이학교</b> <span class="va_m">「초·중등교육법」 제 28조, 서울특별시조례 제6424 「서울특별시교육청 대안교육 위탁교육기관 지원조례」에 의거하여 서울특별시교육청으로부터 위탁받아 운영되는 위탁형 대안학교</span></p>
                            </li> -->
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
