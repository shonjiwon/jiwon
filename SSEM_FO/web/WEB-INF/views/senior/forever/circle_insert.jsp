<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '등록 및 신청 > 평생학습동아리 > 평생학습도시 송파 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
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
                        <a href="#" class="deapth_tit" title="선택">평생학습동아리</a>
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
            <a href="#" class="tab_m">평생학습동아리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/bylaw.do">평생학습 조례</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">평생학습동아리</h4>
        <div class="mypage_tab_box st_2 fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_4">
                <li class="tab_item"><a href="/ssem/senior/forever/circle_intro.do">소개</a></li>
                <li class="tab_item on"><a href="/ssem/senior/forever/circle_insert.do">등록 및 신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_status_list.do">활동 현황</a></li>
                <li class="tab_item"><a href="/ssem/senior/forever/club_news_list.do">활동 소식</a></li>
            </ul>
        </div>
        <section class="text_con wrap fs_20 fs_md_26  pb_100 mb_15">
            <h1 class="c_tit_1 mt_95">등록 및 신청</h1>
            <h2 class="c_tit_2 mt_15 mb_25">학습동아리 등록안내</h2>
            <div class="table_box mt_25 fs_18 fs_md_26 t_center">
                <table class="table">
                    <caption class="text_hide">학습동아리 등록의 대상, 등록방법, 제출서류, 지원혜택, 등록기간, 문의 안내 </caption>
                    <colgroup>
                        <col style="width:20%; min-width: 260px;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>대상</th>
                        <td>
                            <ul class="ul_list_dot">
                                <li>송파구 관내에서 학습을 목적으로 자발적으로 조직된 모든 동아리 </li>
                                <li>성인학습자 10인 이상으로 구성 / 종교(전도), 정치등을 목적으로 하는 동아리는 제한됩니다. </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>등록방법</th>
                        <td>
                            온라인으로 등록 후 제출서류 첨부파일로 추가
                        </td>
                    </tr>
                    <tr>
                        <th>제출서류</th>
                        <td>
                            학습 동아리 등록신청서 1부(동아리활동 관련사진 jpg 파일 첨부), 학습동아리 회원명부 1부
                        </td>
                    </tr>
                    <tr>
                        <th>지원혜택</th>
                        <td>
                            <ul class="ul_list_dot">
                                <li>학습동아리 활성화 유도 </li>
                                <li>체계적인 학습동아리 정보망 확립 </li>
                                <li>우수한 동아리 공모하여 활동지원 </li>
                                <li>각 학습 동아리 연계하여 정보교류 및 학습네트워크 형성</li>
                                <li>평생학습 축제 등을 통해 학습동아리 홍보 및 발표회 장 마련 </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th>등록기간</th>
                        <td>
                            연중 수시
                        </td>
                    </tr>
                    <tr>
                        <th>문의</th>
                        <td>
                            송파구청 교육협력과 스마트평생교육팀 ☎ 02)2147-2374
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
            <h2 class="c_tit_2 mt_85 mb_25">신청안내</h2>
            <div class="img_row_list">
                <ul class="bef_middot fs_22 fs_md_30">
                    <li class="mt_15">하단의 [제출서류 다운로드] 버튼을 클릭하여 제출서류 양식을 다운로드 받아 내용작성</li>
                    <li class="mt_15">[온라인 신청하기] 클릭 후 내용 작성, 제출서류(동아리 신청서, 동아리 회원 명부) 첨부하셔서 동아리 등록 신청하시면 됩니다. </li>
                    <li class="mt_15">서류 제출 후 담당자 검토 후 승인여부를 알려드립니다.</li>
                    <li class="mt_15">기타 자세한 문의는 송파구청 교육협력과 스마트평생교육팀(02-2147-2374)으로 문의주시기 바랍니다.</li>
                </ul>
            </div>
            <div class="btn_box t_center mt_50 pt_50">
                <a href="/ssem/resources/download/application_form.hwp" title="다운로드" class="btn btn_long mr_20">제출서류 다운로드</a>
                <a href="/ssem/senior/forever/circle_insert_form.do" class="btn btn_long">온라인 신청하기</a>
            </div>
        </section>

    </div>
</div>
