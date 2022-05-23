<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '설문조사 참여/결과 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_print").click(function(){
            window.print();
        });
    });
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
                        <a href="#" class="deapth_tit" title="선택">설문조사 참여/결과</a>
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
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">설문조사 참여/결과<i class="icon_arrow_down_w ml_60">다운</i></span></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <h4 class="tit2 mt_95 mb_50">설문조사 참여/결과</h4>
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
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
                <%--<div class="survey_box fs_18 fs_md_24">
                    <div class="table">
                        <div class="th">
                            질문 1
                        </div>
                        <div class="td">
                            <div class="q_table">
                                <div class="table">
                                    <div class="th">Q. 질문영역이 나오는 영역입니다.</div>
                                    <div class="th">선택 수(개)</div>
                                    <div class="th">선택 률(%)</div>
                                </div>
                                <div class="table">
                                    <div class="td">1. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">2. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">3. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">4. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="table">
                        <div class="th">
                            질문 2
                        </div>
                        <div class="td">
                            <div class="q_table">
                                <div class="table">
                                    <div class="th">Q. 질문영역이 나오는 영역입니다.</div>
                                    <div class="th">선택 수(개)</div>
                                    <div class="th">선택 률(%)</div>
                                </div>
                                <div class="table">
                                    <div class="td">1. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">2. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">3. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                                <div class="table">
                                    <div class="td">4. 선택 텍스트가 나오는 영역입니다.</div>
                                    <div class="td">00</div>
                                    <div class="td">00</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table">
                        <div class="th">
                            질문 3
                        </div>
                        <div class="td">
                            <div class="q_table">
                                <div class="table">
                                    <div class="th">Q. 질문영역이 나오는 영역입니다.</div>
                                    <div class="th">답변 수(개)</div>
                                    <div class="td">3</div>
                                </div>
                                <div class="table">
                                    <div class="td">1. 선택 텍스트가 나오는 영역입니다.</div>
                                </div>
                                <div class="table">
                                    <div class="td">2. 선택 텍스트가 나오는 영역입니다.</div>
                                </div>
                                <div class="table">
                                    <div class="td">3. 선택 텍스트가 나오는 영역입니다.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>
                <div class="btn_box mypage_btn_box mt_50 pb_30  t_right">
                    <a href="/ssem/youth/mypage/survey_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                </div>
            </div>
        </section>
    </div>
</div>
