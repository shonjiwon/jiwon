<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 5:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '강사 만족도 평가 > 프로그램 확인 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_insert").click(function(){
            modalMsg("강사 만족도를 평가하시겠습니까?", 'yesorno', insert_frm);
        });
    });

    function insert_frm() {
        if($("input[name='radioName']:checked").val() === '') {
          modalMsg("강사 만족도를 선택해 주세요.", 'notice', "");
          return;
        }

        $("#frm").submit();
    }

</script>
<div class="contents" id="contents">
    <div class="sub_visual st_mypage"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    나의 송파쌤
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
                        <a href="#" class="deapth_tit" title="선택">프로그램 확인</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/youth/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/youth/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/youth/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">강사 만족도 평가</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/mypage/attend_list.do">교육이수 현황</a></li>
                            <li><a href="/ssem/youth/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                            <c:if test="${loginVo.teacher_yn eq 'Y'}">
                                <li><a href="/ssem/youth/mypage/teacher_history_list.do">강의이력 조회</a></li>
                            </c:if>
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
    <div class="sub_con st_1 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">프로그램확인<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">강사 만족도 평가</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/attend_list.do">교육이수 현황</a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                <c:if test="${loginVo.teacher_yn eq 'Y'}">
                    <li class="tab_item"><a href="/ssem/youth/mypage/teacher_history_list.do">강의이력 조회</a></li>
                </c:if>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h2 class="c_tit_2 ptb_20 mt_90 clearfix_after">
                    <span>강사 만족도 평가</span>
                </h2>
                <form name="frm" id="frm" method="post" action="/ssem/youth/mypage/teacher_love_view.do" enctype="multipart/form-data">
                <input type="hidden" name="lecture_apy_idx" id="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/> <%-- 프로그램 일련번호 --%>
                <input type="hidden" name="lecture_idx" id="lecture_idx" value="${lectureVo.lecture_idx}"/> <%-- 프로그램 신청 일련번호 --%>
                <input type="hidden" name="teacher_idx" id="teacher_idx" value="${lectureVo.teacher_idx}"/> <%-- 강사 일련번호 --%>
                <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                    <ul>
                        <li class="table">
                            <div class="th wid_230">프로그램명</div>
                            <div class="td">${lectureVo.name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육기관</div>
                            <div class="td">${lectureVo.group.name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육분야</div>
                            <div class="td">${lectureVo.part_name}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">프로그램 상태</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureVo.status_code eq '1'}">접수대기</c:when>
                                    <c:when test="${lectureVo.status_code eq '2'}">신청가능</c:when>
                                    <c:when test="${lectureVo.status_code eq '3'}">대기신청</c:when>
                                    <c:when test="${lectureVo.status_code eq '4'}">신청마감</c:when>
                                    <c:when test="${lectureVo.status_code eq '5'}">교육전</c:when>
                                    <c:when test="${lectureVo.status_code eq '6'}">교육중</c:when>
                                    <c:when test="${lectureVo.status_code eq '7'}">교육종료</c:when>
                                </c:choose>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">교육장소</div>
                            <div class="td">${lectureVo.place.name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육기간</div>
                            <div class="td">${lectureVo.start_dt} ~ ${lectureVo.end_dt}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육시간</div>
                            <div class="td">${lectureVo.dt_str} (${lectureVo.start_time} ~ ${lectureVo.end_time})</div>
                        </li>


                        <div class="table half">
                            <div class="th wid_230">결제금액</div>
                            <div class="td"><fmt:formatNumber value="${lectureApyVo.pay_sum}" pattern="##,###"/>원</div>
                        </div>

                        <li class="table half">
                            <div class="th wid_230">감면여부</div>
                            <div class="td">
                                <ul class="ul_list_dash mtb_10">
                                    ${discountVo.rate}% <br/>
                                    ${discountVo.tgt_name}
                                    <c:if test="${discountVo.dtl_txt ne null && discountVo.dtl_txt ne ''}">
                                        (${discountVo.dtl_txt})
                                    </c:if>
                                </ul>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">강사명</div>
                            <div class="td">${lectureVo.teacher_nm}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">강사 만족도</div>
                            <div class="td">
                                <div class="mtb_10">
                                    <p class="mb_15">평가 점수 : ${teacherSatisfactionVo.score}점 (회원님의 소중한 평가 감사합니다.)</p>
                                    <c:choose>
                                        <c:when test="${teacherSatisfactionVo.avg_score eq '1'}"><img src="/ssem/resources/img/common/gold.png" alt="금"></c:when>
                                        <c:when test="${teacherSatisfactionVo.avg_score eq '2'}"><img src="/ssem/resources/img/common/silver.png" alt="은"></c:when>
                                        <c:when test="${teacherSatisfactionVo.avg_score eq '3'}"><img src="/ssem/resources/img/common/bronze.png" alt="동"><br></c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div><!--table_box //-->
                <div class="btn_box mt_50 t_right">
                    <a href="/ssem/youth/mypage/teacher_love_list.do"  class="btn btn_short btn_big t_center">목록</a>
                </div>
            </div>
        </section>
    </div>
</div>
