<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '2019~2014년 > 연혁 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

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

            //$lis.removeClass('on').find('a').attr('title', '드롭 비활성');
            //$lis.find('.contents').stop().slideUp();

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
                        <a href="#" class="deapth_tit" title="선택">평생교육</a>
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
                        <a href="#" class="deapth_tit" title="선택">연혁</a>
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
        <h3 class="mt_80 mb_50 tit font_sc">평생학습도시 송파</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">연혁<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item on"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li  class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">연혁</h4>
        <div class="wrap mb_100">
            <div class="slide_list st_2 fs_18 fs_md_26"><!--questions_list-->
                <ul>
                    <!--2020.11.25 : s-->
                    <li class="sl_itme on">
                        <!--2020.11.25 : e-->
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2019년
                                </div>
                            </section>
                        </a>
                        <div class="contents" style="display: block;">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2019.11.01 ~ 11.02</span>2019 더북&단풍축제 우수평생학습 동아리 참가</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2019.10.10 ~ 11.14</span>송파구리더를 위한 제5기 인문학 최고위 과정 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2019.09.19 ~ 12.18</span>송파 새로 × 함께 배움터 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2019.04.19        </span>2019 우수평생학습동아리 네트워킹데이 ‘우리지금 만나’ 개최</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2019.03.28 ~ 09.05</span>자녀와 함께 성장하는 학부모 특강 운영</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2018년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.12.5</span>송파구 평생학습원 개원</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.10.25 ~ 10.27</span>제6회 대한민국 평생학습 박람회 참가</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.10.20 ~ 10.21</span>제6회 송파 북 페스티벌 우수평생학습동아리 체험부스 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.09.19 ~ 12.20</span>명사와 함께하는 구민아카데미 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.09.14 ~ 09.15</span>제14회 서울평생학습 축제 참가</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.04.16 ~ 12.13</span>송파구 리더를 위한 제4기 인문학 최고위 과정 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2018.02.23 ~ 12.11</span>올바른 자녀교육을 위한 학부모 특강 운영</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2017년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2017.10.21 ~ 10.22</span>  제5회 송파북페스티벌 우수학습동아리 체험부스 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2017.10.19 ~ 10.22</span>  제13회 서울평생학습축제 홍보체험관 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2017.09.13 ~ 09.27</span>  명사와 함께하는 송파 구민 아카데미</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2017.04.12 ~ 05.10</span>  100세 시대를 위한 행복한 100세 스쿨</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2017.02.23 ~ 12.11</span>  자녀학습지도를 위한 학부모 특강 운영</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2016년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2016.10.14 ~ 10.16</span>  제12회 서울평생학습 축제 참여</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2016.09.22 ~ 09.25</span>  제5회 대한민국 평생학습 박람회 홍보체험관 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2016.05.25 ~ 11.16</span>  명사와 함께하는 송파 구민 아카데미 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2016.04.18 ~ 05.16</span>  100세 시대를 위한 행복한 100세 스쿨 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2016.02.24 ~ 12.09</span>  자녀학습지도를 위한 학부모 특강 운영</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2015년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2015.05 ~ 12</span>  학부모 아카데미 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2015.07.10 ~ 07.17</span>  자녀학습지도를 위한 학부모 특강(3~4회)</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2015.04.16 ~ 06.04</span>  행복한 100세 스쿨 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2015.02.25 ~ 03.04</span>  자녀학습지도를 위한 학부모 특강(1~2회)</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2014년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2014.10.17~10.19</span> 제3회 대한민국 평생학습 박람회 참여</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2014.09.17~11.12</span> 송파구민아카데미 운영(1~5회)</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2014.02.17~11.19</span> 자녀학습지도를 위한 학부모 특강(1~5회)</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2013년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.10.17 ~ 10.20</span>  제2회 대한민국 평생학습 박람회 참여</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.10.17        </span>  2013. 신규 평생학습도시 선정</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.05.08 ~ 10.11</span>  송파구민아카데미 운영(1~5회)</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.04.09 ~ 04.30</span>  토크콘서트(1~4회)</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.04.05 ~ 04.26</span>  은나래 자원활동가 양성과정 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2013.02.28 ~ 10.31</span>  자녀학습지도를 위한 학부모 특강(1~3회)</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2012년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2012.11.23</span>「제1회 대한민국 평생학습 박람회」 견학 </li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2012.09.27~10.18</span>토크콘서트(1~4회) </li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2012.05.24~08.27</span>자녀 학습지도를 위한 학부모 특강(1~4회)</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2012.02.15~10 </span> 국제교육도시연합(IAEC) 총회 및 회의 참여</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2011년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2011.10.10 ~ 11.14 </span> 전문자원봉사자 양성과정 독서지도자 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2011.10.10 ~ 11.14 </span> 제7기 송파여성아카데미(공연과 경연이 함께있는 인문학콘서트) </li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2011.05.31 ~ 07.8 </span> 서울시 지원 유네스코세계문화유산탐방 교실 속 세계여행 </li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2011.03 ~ 11</span>  명사와 함께하는 송파구민아카데미</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <li class="sl_itme">
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2010년
                                </div>
                            </section>
                        </a>
                        <div class="contents">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2010.06 ~ 11</span>  평생학습우수프로그램 및 학습동아리 공모사업</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2010.06.07 ~ 10.04</span>  송파구-건국대협력「대하소설 토지, 혼불로 배우는 인문학」강좌 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2010.05 ~ 10</span>  「행복한 학교만들기 좋은 부모 프로젝트」운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2010.03.03 ~ 04.23</span>  서울시 5권역 문화해설사 양성과정</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                    <!--2020.11.25 : s-->
                    <li class="sl_itme on">
                        <!--2020.11.25 : e-->
                        <a href="javascript:void(0)" title="드롭 비활성">
                            <section class="sl_top_box">
                                <div class="fs_20 fs_md_28 fw_600">
                                    2009년
                                </div>
                            </section>
                        </a>
                        <div class="contents" style="display: block;">
                            <section class="sl_bottom_box">
                                <div class="fw_300 tc_b">
                                    <ul class="his_list_st2">
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.06.24 </span>「제3회 송파구 주민서비스 박람회」평생학습 홍보관 운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.06.10 </span>「2009. 하반기 평생학습 활성화 추진계획, 수립</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.05 ~ 2009.10</span> 「행복한 학교만들기, 좋은부모 프로젝트」운영</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.03.27</span> 송파구평생학습센터 홈페이지 오픈</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.02 ~ 2009.12 </span>「러닝! 송파 프로젝트」시행</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.02.12 </span>송파구평생학습실무협의회 개최</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.02.11 </span>「평생학습도시」조성을 위한 2009. 평생교육 세부 추진계획</li>
                                        <li><span class="tc_5">&bullet;</span><span class="his_day">2009.01.14 ~ 01.23</span> 「평생교육 관련기관 설문조사」</li>
                                    </ul>
                                </div>
                            </section>
                            <button type="button" class="close_btn text_hide"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
