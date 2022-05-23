<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '운영비전 > 송파혁신교육지구 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_6"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    송파혁신교육지구
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
                        <a href="#" class="deapth_tit" title="선택">온라인 캠퍼스</a>
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
                        <a href="#" class="deapth_tit" title="선택">송파혁신교육지구</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/future_main.do">미래교육센터</a></li>
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로 체험지원센터(꿈마루)</a></li>
                            <li><a href="/ssem/youth/campus/songpa_vision.do">송파혁신교육지구</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">운영비전</a>
                        <ul>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_vision.do">운영비전</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_biz.do">주요사업안내</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_group.do">네트워크 구성 및 조직도</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_gallery_list.do">갤러리</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">송파혁신교육지구</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">운영비전<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab st_2 tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/campus/songpa_vision.do" title="선택">운영비전</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_biz.do">주요사업안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_group.do">네트워크 구성 및 조직도</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_gallery_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15 mt_md_50">
            <div class="innovation_vision_wrap pb_95 pb_md_80">
                <div class="wrap t_center">
                    <h1 class="tit2 ptb_95 pt_md_75 pb_md_65">운영비전</h1>

                    <div class="iv_grap_wrap">
                        <div class="iv_grap">
                            <img src="/ssem/resources/img/sub/innovation_vision_img.png" alt="생각하는 이미지">
                            <p class="iv_text_box fs_30 fs_md_28">
                                <strong class="bg font_mts fw_900">VISION</strong>
                                <span>배움을 디자인하는 송파</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg_color_2 pt_95 pb_100 pt_md_75 pb_md_80">
                <div class="wrap">
                    <h2 class="c_tit_2 ">핵심목표</h2>
                    <div class="t_center mt_40 mt_md_20 fs_20 fs_md_22">
                        <ul class="clearfix">
                            <li class="iv_grap_wrap2">
                                <div class="iv_grap">
                                    <img src="/ssem/resources/img/sub/innovation_vision_img_02.png" alt="소통 이미지" class="screen_sm_hide">
                                    <p class="iv_text_box">
                                        <span>학교-마을 소통과 협력 강화</span>
                                    </p>
                                </div>
                            </li>
                            <li class="iv_grap_wrap2">
                                <div class="iv_grap">
                                    <img src="/ssem/resources/img/sub/innovation_vision_img_03.png" alt="거버넌스 이미지" class="screen_sm_hide">
                                    <p class="iv_text_box">
                                        <span>민·관·학 거버넌스를 통한 마을교육생태계 조정</span>
                                    </p>
                                </div>
                            </li>
                            <li class="iv_grap_wrap2">
                                <div class="iv_grap">
                                    <img src="/ssem/resources/img/sub/innovation_vision_img_04.png" alt="말풍선 이미지" class="screen_sm_hide">
                                    <p class="iv_text_box">
                                        <span>학생자치역량 강화를 통한 민주시민 양성</span>
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="wrap pt_95 pb_100 pt_md_75 pb_md_80">
                <h2 class="c_tit_2">기본방향</h2>
                <div class="mt_40 fs_20 fs_md_22">
                    <div class="info_box_table">
                        <div class="col_wrap">
                            <dl>
                                <dt><strong>민·관·학<br>거 버 넌 스</strong></dt>
                                <dd>
                                    <ul class="ul_list_dash">
                                        <li >유기적 민·관·학 거버넌스 체제 구축·운영</li>
                                        <li >책임과 권한의 균형을 유지하는 실질적 협치 구조 구축·운영</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                        <div class="col_wrap mt_md_20">
                            <dl>
                                <dt><strong>교 육 과 정<br>마 을 연 계</strong></dt>
                                <dd>
                                    <ul class="ul_list_dash">
                                        <li >마을의 다양한 인적·물적 자원과 학교와의 관계망 형성을 통해 학교 교육과정을 마을과 함께하는 마을 결합형 교육공동체 운영</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                    </div>
                    <div class="info_box_table mt_30 mt_md_20">
                        <div class="col_wrap">
                            <dl>
                                <dt><strong>마 을 활 동<br>지 원 체 제</strong></dt>
                                <dd>
                                    <ul class="ul_list_dash">
                                        <li >학교-마을 연계를 위한 마을 교육역량 강화</li>
                                        <li >어린이·청소년이 지역사회구성원으로서의 삶을  누릴 수 있도록 지역자원 기관 연계</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                        <div class="col_wrap mt_md_20">
                            <dl>
                                <dt><strong><span class="w_3">청 소 년</span><br>활 동 지 원</strong></dt>
                                <dd>
                                    <ul class="ul_list_dash">
                                        <li>어린이·청소년 자치활동 강화</li>
                                        <li>민주시민으로서의 성장을 도모할 수 있는 활동 지원</li>
                                        <li>다양한 동아리 활동 참여 기회 확대</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</div>
