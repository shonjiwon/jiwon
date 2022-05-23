<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '평생학습조례 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        $(document).on('click', '.sl_itme a', function(e){
            e.preventDefault();

            var $lis  = $(this).parent('li').siblings();
            var $li   = $(this).parent('li');
            var ind   = $li.index();

            $lis.removeClass('on').find('a').attr('title', '드롭 비활성');
            $lis.find('.contents').stop().slideUp();

            $li.toggleClass(function(){
                if ( $( this ).is( ".on" ) ) {
                    $(this).find('a').attr('title', '드롭 비활성')
                } else {
                    $(this).find('a').attr('title', '드롭 활성')
                }
                return 'on';
            })
            $li.find('.contents').stop().slideToggle();

        });

        $(document).on('click', '.sl_itme .close_btn', function(){
            var $li   = $(this).parents('.sl_itme');

            $li.removeClass('on').find('a').attr('title', '드롭 비활성');
            $li.find('.contents').stop().slideUp();
        });
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    평생교육
                </h2>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="" class="deapth_tit" title="선택">평생교육</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습도시 송파</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">평생학습 조례</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">연혁</a></li>
                            <li><a href="/ssem/senior/forever/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                            <li><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                            <li><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                            <li><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
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
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">평생학습도시 송파</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">유네스코<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li  class="tab_item on"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <div class="wrap text_con fs_20 fs_md_26 mb_15 ">
            <h4 class="tit2 mt_100 mb_50">평생학습조례</h4>
            <h5 class="c_tit_2 mt_95">서울특별시 송파구 평생학습 진흥 조례</h5>
            <ul class="mt_20 tc_sub fw_300">
                <li class="mt_10">(일부개정) 2007.09.21 조례 제 778호</li>
                <li class="mt_10">(일부개정) 2008.02.14 조례 제 792호 (서울특별시 송파구 행정기구 설치 조례)</li>
                <li class="mt_10">(일부개정) 2008.05.13 조례 제 806호</li>
                <li class="mt_10">(일부개정) 2010.07.12 조례 제 914호 (부패유발요인 정비를 위한 서울특별시 송파구 도시계획 조례 등 일부개정조례)</li>
                <li class="mt_10">(일부개정) 2011.12.12 조례 제1012호 조례정비특별위원회</li>
                <li class="mt_10">(일부개정) 2015.12.28 조례 제1296호</li>
                <li class="mt_10">(일부개정) 2017.09.14 조례 제1366호</li>
            </ul>
            <div class="slide_list fs_18 fs_md_26 mt_50 mb_100"><!--slide_list-->
                <ul>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28">
                                    제1장 총  칙
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <div class="sl_bottom_box">
                                <div class="fw_300 plr_30 tc_sub">
                                    <div class="ptb_50 mtb_30 plr_50 bg_color_1">
                                        <p><b class="tc_b">&middot; 제1조(목적)</b></p>
                                        <p>이 조례는「평생교육법」제5조에 따라 서울특별시 송파구민의 평생학습 진흥을 도모하고 평생학습
                                            도시조성사업을 원활하게 추진하기 위하여 평생학습에 필요한 기구의 설치&middot;운영 및 지원에 관한
                                            제반사항을 규정함을 목적으로 한다.
                                            &lt;개정 2008.5.13, 2011.12.12 &gt;
                                        </p>
                                        <p class="mt_10"><b class="tc_b">&middot; 제2조(용어의 정의)</b></p>
                                        <ul>
                                            <li class="mt_5">① "평생학습"이란 학교의 정규교육과정을 제외한 학력보완교육, 성인의 기초&middot;문자해득교육, 직업능력향상교육, 인문교양교육, 문화예술교육, 시민참여교육 등을
                                                포함하는 모든 형태의 조직적인 학습활동을 말한다. &lt;개정 2015.12.28&gt;</li>
                                            <li class="mt_5">② "평생학습원"이란 평생학습에 대한 연구, 정책 개발, 평생학습종사자에 대한 연수 및 평생학습에 대한 정보의 수집&middot;제공 등의 기능을 수행하는 시설을 말한다. &lt;개정 2011.12.12&gt;</li>
                                            <li class="mt_5">③ "평생교육사"란 「고등교육법」제2조에 따른 학교에서 평생교육 관련과목을 일정학점 이상 이수한 자 또는 「평생교육법」제25조에 따른 평생교육사 양성기관에서 소정의 과정을
                                                이수한 자를 말한다.  <br> &lt;개정 2011.12.12&gt;</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제3조(평생학습의 진흥)</b></p>
                                        <ul>
                                            <li class="mt_5">① 서울특별시 송파구청장(이하“구청장”이라 한다)은 평생학습을 통하여 구민의 삶의 질 향상과 서울특별시 송파구(이하“구”라 한다)의 경쟁력 향상을 위해 배움과 나눔이 실천되는 평생학습 도시 조성에 노력한다.</li>
                                            <li class="mt_5">② 구청장은 송파구민 누구나, 언제, 어디서나 원하는 학습을 받을 수 있도록 평생학습에 관한 정책개발과 조사&middot;연구계획을 수립하여 운영하는 등 평생학습 지원정책을 적극적으로 추진한다.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>

                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28">
                                    제2장 평생학습협의회
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <div class="sl_bottom_box">
                                <div class="fw_300 plr_30 tc_sub">
                                    <div class="ptb_50 mtb_30 plr_50 bg_color_1">
                                        <p><b class="tc_b">&middot; 제4조(설치) </b></p>
                                        <p>평생학습에 관한 주요 사항을 심의&middot;의결하고 평생학습사업의 효율적인 추진을 위하여 서울특별시 송파구 평생학습협의회(이하"협의회"라 한다)를 둔다.</p>
                                        <p class="mt_10"><b class="tc_b">&middot; 제5조(기능) </b></p>
                                        <p>협의회는 다음 각 호의 사항을 협의&middot;조정하고 구청장의 자문 역할을 수행한다.</p>
                                        <ul>
                                            <li>1. 평생학습에 관한 기본계획의 수립 및 운영&middot;지원에 관한 사항</li>
                                            <li class="mt_5">2. 평생학습원 운영 및 평생학습 관련 단체&middot;시설의 지원에 관한 사항</li>
                                            <li class="mt_5">3. 평생학습의 효율적인 운영을 위해 필요한 사항</li>
                                            <li class="mt_5">4. 그 밖에 평생학습 시책에 대하여 구청장이 부의하는 사항</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제6조(구성) </b></p>
                                        <ul>
                                            <li class="mt_5">① 협의회는 의장 1명과 부의장 1명을 포함하여 12명 이내의 위원으로 구성한다.&lt;개정 2008.5.13&gt;</li>
                                            <li class="mt_5">② 의장은 구청장이 되고, 부의장은 부구청장이 된다. &lt;개정 2008.5.13&gt;</li>
                                            <li class="mt_5">③ 의장은 협의회를 대표하며 회의를 총괄한다.&lt;개정 2008.5.13&gt;</li>
                                            <li class="mt_5">④ 부의장은 의장을 보좌하며 의장이 부득이한 사유로 직무를 수행할 수 없을 때에는 그 직무를 대행한다. &lt;개정 2008.5.13&gt;</li>
                                            <li class="mt_5">⑤ 위원은 평생학습과 관련되는 기관의 단체장 또는 사회단체 대표자, 학계 전문가 중에서 구청장이 위촉한다.</li>
                                            <li class="mt_5">⑥ 구청장은 위촉 위원 본인의 면직의사가 있거나 질병, 품위손상, 그 밖의 사유로 업무를 수행하기 어렵다고 판단될 때에는 해당 위원을 위촉해제할 수 있다. <br>&lt;개정 2011.12.12&gt;</li>
                                            <li class="mt_5">⑦ 위원의 임기는 3년으로 하되, 한 차례만 연임할 수 있으며 보궐위원의 임기는 전임자의 남은 기간으로 한다. 다만, 공무원은 그 직의 재직기간으로 한다. <br>&lt;개정 2010.7.12, 2011.12.12&gt;</li>
                                            <li class="mt_5">⑧ 협의회의 원활한 사무처리를 위하여 간사 1명을 두되, 간사는 평생학습 담당 과장이 된다.</li>
                                            <li class="mt_5">⑨ 협의회는 관련 업무 수행에 필요할 경우 관계공무원, 관계전문가, 그 밖의 관련자 등을 참석하게 하여 의견을 듣거나 자료 및 서류의 제출 등 필요한 협조를 요청할 수 있다. <br>&lt;개정 2011.12.12&gt;</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제7조(회의)</b></p>
                                        <ul>
                                            <li>① 협의회는 다음 각 호의 어느 하나에 해당하는 경우 의장이 소집한다. &lt;개정 2008.5.13&gt;
                                                <ul>
                                                    <li>1. 의장이 필요하다고 인정할 때 &lt;개정 2008.5.13&gt;</li>
                                                    <li>2. 구청장이 부의하는 안건이 접수되었을 때</li>
                                                    <li>3. 재적위원 3분의 1 이상의 회의소집 요구가 있을 때</li>
                                                </ul>
                                            </li>
                                            <li>② 회의는 재적위원 과반수의 출석으로 개의하고, 출석위원 과반수의 찬성으로 의결한다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제8조(실무협의회 설치 및 기능) </b></p>
                                        <p>평생학습 시책의 효율적인 운영을 위하여 관내 평생학습기관(시설)의 실무관계자, 교육전문가로 평생학습실무협의회를 구성하며, 실무협의회는 다음 각 호의 사항을 협의&middot;조정한다.</p>
                                        <ul>
                                            <li>1. 평생학습 프로그램 관련 정보 교환</li>
                                            <li>2. 평생학습 활성화를 위한 네트워크 사업</li>
                                            <li>3. 그 밖에 평생학습 진흥에 관한 사항<br>[전문개정 2015.12.28]</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제9조(수당 등) </b></p>
                                        <p>협의회에 출석한 위원과 관계전문가에 대하여는 예산의 범위에서 수당 등을 지급할 수 있다. 다만, 공무원인 위원이 그 직무와 관련하여 참석하는 경우에는 지급하지 아니한다. &lt;개정 2011.12.12&gt;</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28">
                                    평생학습원
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <div class="sl_bottom_box">
                                <div class="fw_300 plr_30 tc_sub">
                                    <div class="ptb_50 mtb_30 plr_50 bg_color_1">
                                        <p class="mt_10"><b class="tc_b">&middot; 제10조(설치) </b></p>
                                        <ul>
                                            <li class="mt_5">① 구청장은 구 전체의 평생교육 진흥을 위한 정책 추진과 구민에게 평생학습 기회를 제공하고 삶의 질을 향상시키기 위하여 서울특별시 송파구 평생학습원(이하 “평생학습원”이라 한다)을 설치&middot;운영한다.</li>
                                            <li class="mt_5">② 평생학습원은 구 관할구역 내에 둔다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제11조(기능) </b></p>
                                        <p class="mt_10">평생학습원은 다음 각 호의 사무를 수행한다.</p>
                                        <ul>
                                            <li class="mt_5">1. 평생학습 정책개발 연구 및 홍보</li>
                                            <li class="mt_5">2. 평생학습 프로그램의 개발 및 운영</li>
                                            <li class="mt_5">3. 평생학습 프로그램의 개발을 위한 지역사회 수요조사 통계 및 분석 &lt;신설 2015.12.28&gt;</li>
                                            <li class="mt_5">4. 평생학습 관련 기관. 단체 및 시설의 연계체계 구축(네트워킹) 및 지원</li>
                                            <li class="mt_5">5. 평생학습에 관한 정보의 수집 및 제공</li>
                                            <li class="mt_5">6. 학습동아리 조직과 활동 지원에 관한 사항</li>
                                            <li class="mt_5">7. 평생학습 진흥을 위한 각종 행사 개최 및 지원</li>
                                            <li class="mt_5">8. 평생학습 관계자에 대한 교육지원</li>
                                            <li class="mt_5">9. 평생학습 특화사업 추진에 관한 사항</li>
                                            <li class="mt_5">10. 제15조에 따른 동 평생학습센터에 대한 운영지원 및 관리 &lt;신설 2015.12.28&gt;</li>
                                            <li class="mt_5">11. 그 밖에 평생학습 진흥을 위하여 구청장이 필요하다고 인정하는 사업</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제12조(운영)</b></p>
                                        <ul>
                                            <li class="mt_5">① 평생학습원은 구청장이 관리·운영하고 원장은 구청장이 겸임한다. 단, 평생학습원을 효율적으로 운영하기 위하여 필요하다고 인정되는 경우에는 관련 조례에 따라 위탁 관리·운영할 수 있다. &lt;개정 2015.12.28&gt;</li>
                                            <li class="mt_5">② 위탁 관리·운영에 관한 세부사항 등은 규칙으로 정한다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제13조(운영비 등 지원)</b></p>
                                        <p class="mt_5">구청장은 평생학습의 활성화를 위하여 학습참여자와 평생학습단체 및 시설 등에 대하여 예산의 범위에서 운영비와 학습경비를 지원할 수 있다. &lt;개정 2011.12.12&gt;</p>
                                        <p class="mt_10"><b class="tc_b">&middot; 제14조(운영요원 등)</b></p>
                                        <ul>
                                            <li class="mt_10">① 구청장은 평생학습원의 효율적인 운영을 위하여 소관부서에 평생교육사 및 필요한 직원을 둘 수 있다. &lt;개정 2015.12.28&gt;</li>
                                            <li class="mt_10">② 직원의 자격기준은 규칙으로 정한다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제15조(동 평생학습센터의 운영) </b></p>
                                        <ul>
                                            <li class="mt_5">① 구청장은 동별 주민을 대상으로 하여 평생교육 프로그램을 운영하고 상담을 제공하는 동 평생학습센터를 설치하거나 지정하여 운영할 수 있다.</li>
                                            <li class="mt_5">② 동 평생학습센터는 주민의 근거리 학습권 보장과 지역사회 수요에 맞는 프로그램 및 지역자원 등을 발굴·연계하여 운영한다.</li>
                                            <li class="mt_5">③ 제20조에 따라 동 평생학습센터에서는 평생교육프로그램 수료생에게 평생학습원장의 이름으로 수료증을 교부할 수 있다.&lt;본조신설 2015.12.28&gt;</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제16조(수강료의 징수 등) </b></p>
                                        <ul>
                                            <li class="mt_5">① 구청장은 평생학습원이 관리·운영하는 시설의 이용자로부터 이용료 또는 수강료 등을 징수할 수 있다.</li>
                                            <li class="mt_5">② 수강료 징수는 수익자부담 원칙과 공공성을 고려하여 합리적으로 정하여야 하며, 평생학습 강좌 운영 활성화를 위하여 구청장이 필요하다고 판단될 때에는 협의회의 의견을 고려하여 일부 강좌의 운영을 무료로 할 수 있다.</li>
                                            <li class="mt_5">③ 수강료의 금액 및 징수방법 등은 별표1과 같다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제17조(수강료 감면) </b></p>
                                        <p>구청장은 다음 각 호의 어느 하나에 해당하는 경우 수강료를 감면할 수 있으며, 그 기준은 별표2와 같다.</p>
                                        <ul>
                                            <li class="mt_5">1.「국민기초생활보장법」에 따른 수급권자</li>
                                            <li class="mt_5">2.「한부모가족지원법」에 따른 보호대상자</li>
                                            <li class="mt_5">3.「장애인복지법」에 따른 장애인</li>
                                            <li class="mt_5">4.「국가유공자 등 예우 및 지원에 관한 법률」에 따른 국가보훈대상자와 그 배우자, 국가유공자의 유족 중 선 순위자 1명</li>
                                            <li class="mt_5">5. 다둥이 행복카드 소지자 중 막내가 만 13세 미만인 세 자녀 이상의 세대주 및 세대원</li>
                                            <li class="mt_5">6.「다문화가족지원법」에 따른 다문화가족</li>
                                            <li class="mt_5">7. 만 65세 이상 경로우대자</li>
                                            <li class="mt_5">8.「북한이탈주민의 보호 및 정착지원에 관한 법률」에 따른 북한이탈주민&lt;본조신설 2015.12.28&gt; </li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제18조(수강료 반환)</b></p>
                                        <ul>
                                            <li>① 구청장은 다음 각 호의 사유가 발생한 경우에는 별표3의 수강료 반환기준에 따라 수강료를 반환하여야 한다.
                                                <ul>
                                                    <li class="mt_5">1. 모집정원 미달 등 평생학습원의 사정으로 강좌를 개설할 수 없게 된 경우</li>
                                                    <li class="mt_5">2. 수강생이 본인의 의사로 수강을 포기한 경우</li>
                                                </ul>
                                            </li>
                                            <li>② 제1항에 따라 수강료를 반환받고자 하는 사람은 별지 서식의 수강료 반환신청서를 제출하여야 한다. 이 경우 반환신청서 제출일을 반환사유 기준일로 한다.</li>
                                            <li>③ 구청장은 제1항에 따른 수강생이 수료증을 수령하지 않은 경우 해당 수료증을 수료일로부터 3개월간 보관한다.</li>
                                        </ul>
                                        <p class="mt_10"><b class="tc_b">&middot; 제19조(자원봉사자) </b></p>
                                        <p class="mt_5">구청장은 평생학습원의 운영에 필요한 자원봉사자를 모집·활용하고 자원봉사자에게는 예산의 범위에서 실비를 지급할 수 있다.</p>
                                        <p class="mt_10"><b class="tc_b">&middot; 제20조(수료증 발급) </b></p>
                                        <p class="mt_5">구청장은 구에서 이루어지는 평생교육과정을 수료한 사람에게는 송파구 평생학습원장의 이름으로 수료증을 교부할 수 있으며, 우수 수료자에게는「서울특별시 송파구 표창 조례」에 따라 표창할 수 있다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28">
                                    제4장 보   칙
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <div class="sl_bottom_box">
                                <div class="fw_300 plr_30 tc_sub">
                                    <div class="ptb_50 mtb_30 plr_50 bg_color_1">
                                        <p class="mt_10"><b class="tc_b">&middot; 제21조(공동추진 등) </b></p>
                                        <p>구청장은 평생학습도시 조성 및 사업의 원활한 추진을 위하여 필요하다고 인정하는 경우에는 해당 교육청 등 유관기관 및 민간단체와 공동으로 사업을 추진할 수 있다.</p>
                                        <p class="mt_10"><b class="tc_b">&middot; 제22조(시행규칙) </b></p>
                                        <p>이 조례의 시행에 필요한 사항은 규칙으로 정한다. &lt;개정 2011.12.12&gt;</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙(2006·2·14)</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 2008년 2월 15일부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙(2008·5·13)</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙(2010·7·12)</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙(2011·12·12)</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙 &lt; 제1,296호, 2015.12.28&gt;</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <div class="sl_top_box">
                            <div class="fs_20 fs_md_28 plr_35">
                                <span class="dp_inp va_m mr_20">부칙 &lt; 조례 제1366호, 2017.9.14&gt;(서울특별시 송파구 다자녀가정 감면 혜택 변경을 위한 조례 일괄개정조례)</span><span class="dp_inp va_m fs_18 tc_sub">※ 이 조례는 공포한 날부터 시행한다.</span>
                            </div>
                        </div>
                    </li>
                </ul> <!-- //bl -->
            </div>
        </div>
    </div>
</div>
