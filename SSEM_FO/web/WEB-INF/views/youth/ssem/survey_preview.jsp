<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 5:58
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
        <div class="wrap text_con fs_20 fs_md_26 mt_50 mb_15 mb_100">
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">설문조사 정보의 제목, 설문기간</caption>
                    <colgroup>
                        <col style="width:22.222%">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>제 목</th>
                        <td>${svyMstVo.title}</td>
                    </tr>
                    <tr>
                        <th>설문기간</th>
                        <td>${fn:substring(svyMstVo.start_dt, 0, 10)} ~ ${fn:substring(svyMstVo.end_dt, 0, 10)}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_50">문항</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <form name="frm_reply" id="frm_reply" action="/ssem/youth/ssem/survey_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="svy_idx" id="svy_idx" value="${svyMstVo.svy_idx}" />
                    <table class="table">
                        <caption class="text_hide">설문조사 문항 내용</caption>
                        <colgroup>
                            <col style="width:22.222%">
                            <col>
                        </colgroup>
                        <tbody>
                        <!--item : s-->
                        <c:forEach items="${svyMstVo.questList}" var="quest" varStatus="status_quest">
                            <input type="hidden" name="questList[${status_quest.index}].svy_qst_idx" id="questList[${status_quest.index}].svy_qst_idx" value="${quest.svy_qst_idx}" />
                            <input type="hidden" name="questList[${status_quest.index}].type" id="questList[${status_quest.index}].type" value="${quest.type}" />
                            <c:choose>
                                <c:when test="${quest.type eq 'S'}">
                                    <tr>
                                        <th rowspan="${fn:length(quest.itemList) + 1}">${quest.no}</th>
                                        <td class="line_left">
                                            질문 : ${quest.title}
                                        </td>
                                    </tr>
                                    <c:forEach items="${quest.itemList}" var="item" varStatus="status_item">
                                        <tr>
                                            <td class="line_left">
                                                <label class="fm_ch act_uiRdCh mr_20">
                                                    <input type="radio" name="questList[${status_quest.index}].select_item_idx" id="item_${status_quest.index}_${status_item.index}" value="${item.svy_item_idx}">
                                                    <span>${item.no}. ${item.cont}</span>
                                                </label>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${quest.type eq 'M'}">
                                    <tr>
                                        <th rowspan="${fn:length(quest.itemList) + 1}">${quest.no}</th>
                                        <td class="line_left">
                                            질문 : ${quest.title}
                                        </td>
                                    </tr>
                                    <c:forEach items="${quest.itemList}" var="item" varStatus="status_item">
                                        <tr>
                                            <td class="line_left">
                                                <label class="fm_ch act_uiRdCh mr_20">
                                                    <input type="checkbox" name="questList[${status_quest.index}].select_item_idx" id="item_${status_quest.index}_${status_item.index}" value="${item.svy_item_idx}">
                                                    <span>${item.no}. ${item.cont}</span>
                                                </label>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${quest.type eq 'L'}">
                                    <tr>
                                        <th rowspan="2">${quest.no}</th>
                                        <td class="line_left">
                                            질문 : ${quest.title}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="line_left">
                                            <div class="fm_tf mtb_20 mr_20">
                                                <c:forEach items="${quest.itemList}" var="item" varStatus="status_item">
                                                    <input type="hidden" name="questList[${status_quest.index}].select_item_idx" id="item_${status_quest.index}_${status_item.index}" value="${item.svy_item_idx}" />
                                                    <textarea rows="5" name="questList[${status_quest.index}].answer" id="item_${status_quest.index}" title="의견답변"></textarea>
                                                </c:forEach>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
            </div>
            <%--<div class="btn_box mt_50 mb_100 pb_30 t_right t_md_center">
                <a href="#none" class="btn btn_long btn_big btn_color_1 mr_15" id="btn_insert">설문조사 참여하기</a>
                <a href="/ssem/youth/ssem/survey_list.do" class="btn btn_short t_center">목록</a>
            </div>--%>
        </div>
    </div>
</div>
