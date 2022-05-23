<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '학부모 진로교육멘토단 참여 > 가치, 같이 함께 해주세요 > 송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual mr_st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    가치, 같이 함께 해주세요
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
                        <a href="#" class="deapth_tit" title="선택">가치, 같이 함께 해주세요</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루</a></li>
                            <li><a href="/ssem/dream/together/experience.do">가치, 같이 함께 해주세요</a></li>
                            <li><a href="/ssem/dream/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/dream/news/notice_list.do">꿈마루 소식</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1 w270">
                        <a href="#" class="deapth_tit" title="선택">학부모 진로교육멘토단 참여</a>
                        <ul>
                            <li><a href="/ssem/dream/together/experience.do">현장직업체험처 참여</a></li>
                            <li><a href="/ssem/dream/together/job_mentor.do">직업인 멘토 참여</a></li>
                            <li><a href="/ssem/dream/together/home_mentor.do">학부모 진로교육멘토단 참여</a></li>
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
            <a href="#" class="tab_m">학부모 진로교육멘토단 참여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/dream/together/experience.do">현장직업체험처 참여</a></li>
                <li class="tab_item"><a href="/ssem/dream/together/job_mentor.do">직업인 멘토 참여</a></li>
                <li class="tab_item on"><a href="/ssem/dream/together/home_mentor.do" title="선택">학부모 진로교육멘토단 참여</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">학부모 진로교육멘토단 참여</h3>
        <div class="sub_info_visual mr_st_5 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <span class="text_hide">엄마 여자아이 공부하는 모습</span>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <div class="bg_color_box bg1 t_center fw_200 lh_16">
                    <p>
                        학부모진로교육멘토단은 관내 청소년진로교육과 체험에 관심있으신 학부모님들의 자발적 모임으로, <br class="screen_md_hide">
                        송파진로직업체험지원센터의 다양한 프로그램, 강의, 체험 등에 지원단으로 활동하실 수 있습니다.<br class="screen_md_hide">
                        사회적 기여 활동 이외에도 아카데미, 자격증과정, 진로독서단, 강의지원 등 다양한 청소년 진로교육분야에서 지원하며 <br class="screen_md_hide">
                        마을을 학교로 만드는 가치 있는 활동에 함께 해주실 송파 관내 학부모님들을 기다립니다.
                    </p>
                </div>
                <div class="drct_wrap mt_60 mt_md_50">
                    <div class="drct_txt_box location_info">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_home_b">집</i>모집대상</strong>
                                송파 관내 학부모 (서울시 교육청 진로교육지원단 원격 연수 가능하신 분)
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_bubble">말풍선</i>문의전화</strong>
                                02-6713-2396(오시은 팀장)
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_location">위치</i>센터위치</strong>
                                송파꿈마루 진로직업체험지원센터<br class="screen_hide screen_md_show"> (거여역 2번 출구에서 도보 15분)<br class="screen_hide screen_md_show"> 서울시 송파구 마천로35길 12.<br class="screen_hide screen_md_show"> 송파구 평생학습원 1층
                            </p></li>
                            <li><p class="por fw_400">
                                <strong class="s_loc_tit pnt_c1 top"><i class="icon_worker_blue">멘토</i>멘토등록 방법</strong>
                                하단의 등록서류 양식을 다운받아 내용작성 후 <br class="screen_hide screen_md_show">이메일 (ggoommaru@naver.com) 접수
                            </p></li>
                        </ul>
                    </div>
                    <p class="btn_box t_center pt_50 mt_50 pt_md_50 mt_md_50">
                        <c:forEach items="${oneFile.fileList}" var="one" varStatus="status">
                            <c:if test="${one != null}">
                                <a class="btn btn_auto mr_20" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${one.atch_file_id}&amp;fileNum=${one.file_num}">진로교육멘토단 소개자료</a>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${twoFile.fileList}" var="two" varStatus="status">
                            <c:if test="${two != null}">
                                <a class="btn btn_auto" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${two.atch_file_id}&amp;fileNum=${two.file_num}">진로교육멘토단 등록서류</a>
                            </c:if>
                        </c:forEach>
                    </p>
                </div>
            </div>
        </section>
    </div>
</div>
