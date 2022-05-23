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
        $(document).prop('title', '2013~2009년 > 연혁 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        AOS.init({   easing: 'ease-in-out-sine', duration: 800, once : true });
        onElementHeightChange(document.body, function(){
            AOS.refresh();
        });
    });

    function onElementHeightChange(elm, callback) {
        var lastHeight = elm.clientHeight
        var newHeight;

        (function run() {
            newHeight = elm.clientHeight;
            if (lastHeight !== newHeight) callback();
            lastHeight = newHeight;

            if (elm.onElementHeightChangeTimer) {
                clearTimeout(elm.onElementHeightChangeTimer);
            }

            elm.onElementHeightChangeTimer = setTimeout(run, 200);
        })();
    }
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
        <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_2">
                <li class="tab_item"><a href="/ssem/senior/forever/history.do">2019~2014년</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/history_two.do">2013~2009년</a></li>
            </ul>
        </div>
        <div class="wrap his_wrap">
            <div class="his_line"><span></span></div>
            <div>
                <div class="his _right" data-aos="fade-up">
                    <strong>2013</strong>
                    <ul>
                        <li> <span>10</span><span>제2회 대한민국 평생학습 박람회 참여</span></li>
                        <li> <span>10</span><span>2013 신규 평생학습도시 선정</span></li>
                        <li> <span>5</span><span>송파구민아카데미 운영(1~5회)</span></li>
                        <li> <span>4</span><span>토크콘서트(1~4회)</span></li>
                        <li> <span>4</span><span>은나래 자원활동가 양성과정 운영</span></li>
                        <li> <span>2</span><span>자녀학습지도를 위한 학부모 특강(1~3회)</span></li>
                    </ul>
                </div>
                <div class="his _left" data-aos="fade-up">
                    <strong>2012</strong>
                    <ul>
                        <li> <span>11</span><span>「제1회 대한민국 평생학습 박람회」 견학 </span></li>
                        <li> <span>9</span><span>토크콘서트(1~4회) </span></li>
                        <li> <span>5</span><span>자녀 학습지도를 위한 학부모 특강(1~4회)</span></li>
                        <li> <span>2</span><span>국제교육도시연합(IAEC) 총회 및 회의 참여</span></li>
                    </ul>

                </div>
                <div class="his _right" data-aos="fade-up">
                    <strong>2011</strong>
                    <ul>
                        <li><span>10</span><span>전문자원봉사자 양성과정 독서지도자 운영</span></li>
                        <li><span>10</span><span>제7기 송파여성아카데미(공연과 경연이 함께있는 인문학콘서트) </span></li>
                        <li><span>5</span><span>서울시 지원 유네스코세계문화유산탐방 교실 속 세계여행 </span></li>
                        <li><span>3</span><span>명사와 함께하는 송파구민아카데미</span></li>
                    </ul>

                </div>
                <div class="his _left" data-aos="fade-up">
                    <strong>2010</strong>
                    <ul>
                        <li><span>6</span><span>평생학습우수프로그램 및 학습동아리 공모사업</span></li>
                        <li><span>6</span><span>송파구-건국대협력「대하소설 토지, 혼불로 배우는 인문학」강좌 운영</span></li>
                        <li><span>5</span><span>「행복한 학교만들기 좋은 부모 프로젝트」운영</span></li>
                        <li><span>3</span><span>서울시 5권역 문화해설사 양성과정</span></li>
                    </ul>
                </div>
                <div class="his _right" data-aos="fade-up">
                    <strong>2009</strong>
                    <ul>
                        <li><span>6</span><span>「제3회 송파구 주민서비스 박람회」평생학습 홍보관 운영</span></li>
                        <li><span>6</span><span>「2009. 하반기 평생학습 활성화 추진계획 」 수립</span></li>
                        <li><span>5</span><span>행복한 학교만들기, 좋은부모 프로젝트」운영</span></li>
                        <li><span>3</span><span>송파구평생학습센터 홈페이지 오픈</span></li>
                        <li><span>2</span><span>「러닝! 송파 프로젝트」시행</span></li>
                        <li><span>2</span><span>송파구평생학습실무협의회 개최</span></li>
                        <li><span>2</span><span>평생학습도시」조성을 위한 2009. 평생교육 세부 추진계획</span></li>
                        <li><span>1</span><span>「평생교육 관련기관 설문조사」</span></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
