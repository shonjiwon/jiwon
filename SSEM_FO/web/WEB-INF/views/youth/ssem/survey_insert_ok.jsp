<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '설문조사 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_11"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    송파쌤(SSEM)
                </h2>
                <p class="tit_sub">
                    <strong>“세상에서 가장 큰 학교”</strong>
                    송파에서 나고 자라고 완성되는 <br>창의적 인재육성
                </p>
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤</a>
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
                        <a href="#" class="deapth_tit" title="선택">설문조사</a>
                        <ul>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/youth/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/youth/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/youth/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">설문조사</h3>
        <div class="wrap">
            <div class="completion_box t_center">
                <img src="/ssem/resources/img/sub/completion_img.png" alt="완료">

                <h5 class="fs_30 mt_15">설문조사에 <b>참여</b>해 주셔서 감사합니다.</h5>
                <p class="fs_20 mt_5">설문조사 참여 내역 및 결과는 마이페이지에서 확인 가능 합니다.</p>
                <a href="/ssem/youth/mypage/survey_list.do" class="btn mt_15">마이페이지</a>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">설문조사 결과</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="st_2">
                    <caption class="text_hide">설문조사 결과 내용</caption>
                    <colgroup>
                        <col style="width:10%">
                        <col>
                        <col style="width:15%">
                        <col style="width:15%">
                    </colgroup>
                    <tbody>
                    <!--item : s-->
                    <c:forEach items="${svyMstVo.questList}" var="quest" varStatus="status">
                        <c:choose>
                            <c:when test="${quest.type eq 'S'}">
                                <tr>
                                    <th rowspan="${fn:length(quest.itemList) + 1}" class="t_left"> <p class="plr_15">${quest.no}</p></th>
                                    <td class="line_left t_left">
                                        <p class="pl_15">질문 : ${quest.title}</p>
                                    </td>
                                    <th>선택 수(개)</th>
                                    <th>선택률(%)</th>
                                </tr>
                                <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                                    <tr>
                                        <td class="line_left t_left">
                                            <p class="pl_15">${item.no}. ${item.cont}</p>
                                        </td>
                                        <td>${item.tot_reply_cnt}</td>
                                        <td>${item.reply_percent}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:when test="${quest.type eq 'M'}">
                                <tr>
                                    <th rowspan="${fn:length(quest.itemList) + 1}" class="t_left"> <p class="plr_15">${quest.no}</p></th>
                                    <td class="line_left t_left">
                                        <p class="pl_15">질문 : ${quest.title}</p>
                                    </td>
                                    <th>선택 수(개)</th>
                                    <th>선택률(%)</th>
                                </tr>
                                <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                                    <tr>
                                        <td class="line_left t_left">
                                            <p class="pl_15">${item.no}. ${item.cont}</p>
                                        </td>
                                        <td>${item.tot_reply_cnt}</td>
                                        <td>${item.reply_percent}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:when test="${quest.type eq 'L'}">
                                <tr>
                                    <th rowspan="${fn:length(quest.itemList) + 1}" class="t_left"> <p class="plr_15">${quest.no}</p></th>
                                    <td class="line_left t_left">
                                        <p class="pl_15">질문 : ${quest.title}</p>
                                    </td>
                                    <th>답변</th>
                                    <td>${quest.itemList[0].tot_reply_cnt}개</td>
                                </tr>
                                <c:forEach items="${quest.itemList}" var="item" varStatus="status">
                                    <c:forEach items="${item.replyList}" var="reply" varStatus="status_reply">
                                        <tr>
                                            <td class="line_left t_left" colspan="3">
                                                <p class="pl_15">답변. ${reply.answer}</p>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/youth/mypage/survey_list.do" class="btn btn_long btn_big t_center mr_20">설문조사 참여 보기</a>
                <a href="/ssem/youth/ssem/survey_list.do" class="btn btn_long btn_big t_center">확인</a>
            </div>
        </div>
    </div>
</div>
