<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 3:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '직업인 멘토 참여 > 가치, 같이 함께 해주세요 > 송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

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
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">직업인 멘토 참여</a>
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
            <a href="#" class="tab_m">직업인 멘토 참여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/dream/together/experience.do">현장직업체험처 참여</a></li>
                <li class="tab_item on"><a href="/ssem/dream/together/job_mentor.do" title="선택">직업인 멘토 참여</a></li>
                <li class="tab_item"><a href="/ssem/dream/together/home_mentor.do">학부모 진로교육멘토단 참여</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">직업인 멘토 참여</h3>
        <div class="sub_info_visual mr_st_4 mt_md_50"> <!---sub_info_visual-->
            <div class="wrap tc_w fw_200">
                <div class="sub_info_visual_text_box t_center">
                    <span class="text_hide">멘토 참여 모습</span>
                </div>
            </div>
        </div><!---sub_info_visual //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <div class="bg_color_box bg1 t_center fw_200 lh_16">
                    <p>
                        직업인멘토는 송파 관내 학교 방문 또는 송파 꿈마루 센터에서 초, 중, 고등학교 학생 및 특수학급, 학교 밖 청소년, 위기학생 등<br class="screen_md_hide">
                        모든 청소년에게 멘토님의 직업에 대해 알려주고 함께 체험하는 역할을 담당합니다.<br class="screen_md_hide">
                        청소년들은 멘토님의 직업에 대한 자부심과 지식에 감탄하고 흥미로워 할 것입니다.<br class="screen_md_hide">
                        어떤 직업이라도 상관없습니다. 청소년들의 꿈에 날개를 달아주실 열정만 있으면 됩니다.<br class="screen_md_hide">
                        송파의 청소년들의 꿈을 키우는 가치 있는 활동에 함께 해주실 멘토님을 기다립니다.
                    </p>
                </div>
                <div class="drct_wrap mt_60 mt_md_50">
                    <div class="drct_txt_box location_info">
                        <ul>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_home_b">집</i>모집대상</strong>
                                직업인 특강 및 직업체험 진행이 가능한<br class="screen_hide screen_md_hide"> 직업인멘토
                            </p></li>
                            <li><p class="por">
                                <strong class="s_loc_tit"><i class="icon_bubble">말풍선</i>문의전화</strong>
                                02-6713-2394 (신경현 연구원)
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
                    <p class="txt_block bg_ash mt_55 fw_200 tc_sb t_center fs_18 fs_md_26 fs_xs_13">
                        송파 관내 청소년에게 꿈과 희망을 심어주는 가치 있는 일에 함께 하세요.<br>
                        직업인 특강 및 직업체험, 송파 꿈마루 진로 프로그램 진행 등 다양한 활동을 통해 같이 가치의 사회적 기여를 할 수 있습니다.
                    </p>
                    <p class="btn_box t_center pt_50">
                        <c:forEach items="${oneFile.fileList}" var="one" varStatus="status">
                            <c:if test="${one != null}">
                                <a class="btn btn_auto mr_20" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${one.atch_file_id}&amp;fileNum=${one.file_num}">직업인멘토 소개자료</a>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${twoFile.fileList}" var="two" varStatus="status">
                            <c:if test="${two != null}">
                                <a class="btn btn_auto" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${two.atch_file_id}&amp;fileNum=${two.file_num}">직업인멘토 등록서류</a>
                            </c:if>
                        </c:forEach>
                    </p>

                </div>

            </div>
        </section>
    </div><!-- sub_con : e -->
</div>
