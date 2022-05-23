<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="header">
    <div class="h_area_top">
        <div class="wrap">
            <h1 class="logo">
                <a href="/ssem"><img src="/ssem/resources/img/common/logo.png" alt="송파쌤 SSEM"></a>
            </h1>
            <h2 class="text_hide">상단메뉴</h2>
            <c:choose>
                <c:when test="${loginVo eq null}">
                    <ul class="h_top_left">
                        <li><a href="/ssem/youth/login/login.do?return_url=/senior/main/main.do">로그인</a></li>
                        <li><a href="https://www.songpa.go.kr/www/joinStep0Form.do?url=https://www.songpa.go.kr/www/index.do">회원가입</a></li>
                        <li><a href="/ssem/senior/main/teacher_reg.do">강사신청</a></li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul class="h_top_left">
                        <li><a href="/ssem/youth/login/logout.do">로그아웃</a></li>
                        <li><a href="/ssem/senior/mypage/pwd_confirm.do">나의송파쌤</a></li>
                        <li><a href="/ssem/senior/main/teacher_reg.do">강사신청</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
            <ul class="h_top_right">
                <li><a href="/ssem/youth/main/main.do">미래교육</a></li>
                <li><a href="/ssem/senior/main/main.do" class="on">평생교육</a></li>
            </ul>
        </div>
    </div>

    <div class="h_area_bottom"> <!--h_area_bottom-->
        <div class="wrap">
            <div id="nav">
                <h2 class="text_hide">메뉴</h2>
                <ul id="gnb"> <!-- gnb -->
                    <!-- depth_1 -->
                    <li class="depth_1"><a href="/ssem/senior/forever/history.do">평생교육</a>  <!-- 평생교육 -->
                        <!--2020.11.23 : s-->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_01.jpg" alt="평생교육"></div>
                                <h3 class="depth_tit">평생교육</h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/forever/history.do">연혁</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/forever/vision.do">비전</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/forever/unesco.do">유네스코</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/forever/bylaw.do">평생학습조례</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/forever/learning_status.do">평생학습원</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/forever/circle_intro.do">평생학습동아리</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/forever/center_self_hall.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/forever/center_ict_hall.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/forever/center_woman_hall.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                        <!--2020.11.23 : e-->
                    </li><!-- 평생교육 : e-->

                    <li class="depth_1"><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li><!-- 통합프로그램신청 : e-->

                    <li class="depth_1"><a href="/ssem/senior/magnet/intro.do">마그넷스쿨</a><!-- 마그넷스쿨 : e-->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_03.jpg" alt="마그넷스쿨"></div>
                                <h3 class="depth_tit">마그넷스쿨 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/senior/magnet/intro.do">이용안내</a></li>
                                <li class="depth_2"><a href="/ssem/senior/magnet/study_hope_list.do">배우고 싶어요</a></li>
                                <li class="depth_2"><a href="/ssem/senior/magnet/study_share_list.do">배움 공유채널</a></li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 마그넷스쿨 : e-->

                    <li class="depth_1"><a href="/ssem/senior/center/woman_culture.do">교육지원</a><!-- 교육지원 -->
                        <!--2020.11.23 : s-->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_04.jpg" alt="교육지원"></div>
                                <h3 class="depth_tit">교육지원</h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/senior/center/woman_culture.do">송파여성문화회관</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/center/woman_culture.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/senior/center/life_culture.do">송파생활문화대학</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/center/life_culture.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <!-- <li class="depth_2"><a href="/ssem/senior/center/child_culture.do">송파어린이문화회관</a>
                                    <ul>
                                        <!-/- depth_3 -/->
                                        <li class="depth_3"><a href="/ssem/senior/center/child_culture.do">기관소개</a></li>
                                        <!-/- depth_3 : e-/->
                                    </ul>
                                </li> -->
                                <li class="depth_2"><a href="https://www.spcc.or.kr/" target="_blank">송파문화원 <i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="/ssem/senior/center/songpaga_info.do">송파가 송파하리 프로젝트</a></li>
                                <li class="depth_2"><a href="http://www.splib.or.kr/spclib/" target="_blank">송파어린이도서관 <i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="https://songpa.seoulwomanup.or.kr/" target="_blank">송파여성인력개발센터 <i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="https://splib.sen.go.kr/" target="_blank">도서관 <i class="icon_link_bk">외부링크</i></a></li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                        <!--2020.11.23 : e-->
                    </li><!-- 교육지원 : e-->

                    <li class="depth_1"><a href="/ssem/senior/ssem/vision.do">송파쌤</a><!-- 송파쌤 -->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_05.jpg" alt="송파쌤"></div>
                                <h3 class="depth_tit">송파쌤 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/senior/ssem/vision.do">송파쌤이란</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/ssem/vision.do">비전</a></li>
                                        <li class="depth_3"><a href="/ssem/senior/ssem/organ.do">조직도</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/senior/ssem/notice_list.do">공지사항</a></li>
                                <li class="depth_2"><a href="/ssem/senior/ssem/survey_list.do">설문조사</a></li>
                                <li class="depth_2"><a href="/ssem/senior/ssem/qna.do">고객지원</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/senior/ssem/qna.do">자주 묻는 질문</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 송파쌤 : e-->
                    <!-- depth_1 : e-->
                    <%--<li class="depth_1"><a href="/ssem/senior/coach/coach_list.do">온라인 코칭쌤</a></li>--%>
                    <li class="depth_1"><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                </ul>
            </div><!-- gnb : e-->
        </div>
    </div><!--h_area_bottom-->
    <div class="icon_btn_wrap wrap t_right">
        <div class="icon_btn_box clserfix">
            <button type="button" class="float_left icon_btn act_search_bar screen_md_hide"><i class="icon_search_bk">검색</i></button>
            <button type="button" class="float_right icon_btn act_menu"><i class="icon_menu_bk">전체메뉴</i></button>
        </div>
    </div>
    <div class="search_bar_box off">
        <div class="search_bar mtb_20">
            <form id="frm_search" name="frm_search" action="/ssem/senior/search/search.do" method="post">
                <input type="text" name="query" id="query" class="inp fs_18 fs_sm_26" title="검색입력창">
                <button type="submit" class="btn btn_icon btn_search">
                    <i class="icon_search_bk">검색</i>
                </button>
            </form>
        </div>
    </div>
</div><!--header : e-->

<div class="all_menu_gnb all_mneu"><!-- all_menu_gnb -->
    <h2 class="text_hide">전체 OR 모바일 메뉴</h2>
    <ul> <!-- gnb -->
        <!-- depth_1 -->
        <li class="depth_1"><a href="/ssem/senior/forever/history.do"><span>평생교육</span></a>  <!-- 평생교육 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/forever/history.do"><span>평생학습도시 송파</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/forever/history.do"><span>연혁</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/forever/vision.do"><span>비전</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/forever/unesco.do"><span>유네스코</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/forever/bylaw.do"><span>평생학습조례</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/forever/learning_status.do"><span>평생학습원</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/forever/circle_intro.do"><span>평생학습동아리</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/forever/center_self_hall.do"><span>동 주민자치회관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/forever/center_self_hall.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/forever/center_ict_hall.do"><span>정보화교실</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/forever/center_ict_hall.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/forever/center_woman_hall.do"><span>여성교실</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/forever/center_woman_hall.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 평생교육 : e-->
        <!--2020.11.23 : e-->

        <li class="depth_1"><a href="/ssem/senior/program/lecture_list.do"><span>통합프로그램신청</span></a></li><!-- 통합프로그램신청 : e-->

        <li class="depth_1"><a href="/ssem/senior/magnet/intro.do"><span>마그넷스쿨</span></a><!-- 마그넷스쿨 : e-->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/magnet/intro.do"><span>이용안내</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/magnet/study_hope_list.do"><span>배우고 싶어요</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/magnet/study_share_list.do"><span>배움 공유채널</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 마그넷스쿨 : e-->

        <!--2020.11.23 : s-->
        <li class="depth_1"><a href="/ssem/senior/center/woman_culture.do"><span>교육지원</span></a><!-- 교육지원 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/center/woman_culture.do"><span>송파여성문화회관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/center/woman_culture.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/center/life_culture.do"><span>송파생활문화대학</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/center/life_culture.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <!-- <li class="depth_2"><a href="/ssem/senior/center/child_culture.do"><span>송파어린이문화회관</span></a>
                    <ul>
                        <!-/- depth_3 -/->
                        <li class="depth_3"><a href="/ssem/senior/center/child_culture.do"><span>기관소개</span></a></li>
                        <!-/- depth_3 : e-/->
                    </ul>
                </li> -->
                <li class="depth_2"><a href="https://www.spcc.or.kr/" target="_blank" class="export_link"><span>송파문화원</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/center/songpaga_info.do"><span>송파가 송파하리 프로젝트</span></a></li>
                <li class="depth_2"><a href="http://www.splib.or.kr/spclib/" target="_blank" class="export_link"><span>송파어린이도서관</span></a></li>
                <li class="depth_2"><a href="https://songpa.seoulwomanup.or.kr/" target="_blank" class="export_link"><span>송파여성인력개발센터</span></a></li>
                <li class="depth_2"><a href="https://splib.sen.go.kr/" target="_blank" class="export_link"><span>도서관</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 교육지원 : e-->
        <!--2020.11.23 : e-->

        <li class="depth_1"><a href="/ssem/senior/ssem/vision.do"><span>송파쌤</span></a><!-- 송파쌤 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/ssem/vision.do"><span>송파쌤이란</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/ssem/vision.do"><span>비전</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/ssem/organ.do"><span>조직도</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/ssem/notice_list.do"><span>공지사항</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/ssem/survey_list.do"><span>설문조사</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/ssem/qna.do"><span>고객지원</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/ssem/qna.do"><span>자주 묻는 질문</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 송파쌤 : e-->

        <li class="depth_1"><a href="/ssem/senior/lawtax/law_counsel_list.do"><span>법률ㆍ세무 상담</span></a></li>

        <li class="depth_1"><a href="/ssem/senior/coach/coach_list.do"><span>온라인 코칭쌤</span></a></li><!-- 온라인 코칭쌤 : e-->

        <!--2020.11.23 : s-->
        <li class="depth_1"><a href="/ssem/senior/mypage/program_list.do"><span>나의 송파쌤<br><span class="fw_200 fs_24">(마이페이지)</span></span></a><!--나의 송파쌤 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/mypage/program_list.do"><span>프로그램 확인</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/program_list.do"><span>프로그램 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/attend_list.do"><span>교육이수 현황</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/teacher_love_list.do"><span>강사 만족도 평가</span></a></li>
                        <c:if test="${loginVo.teacher_yn eq 'Y'}">
                            <li class="depth_3"><a href="/ssem/senior/mypage/teacher_history_list.do"><span>강사 이력 조회</span></a></li>
                        </c:if>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/hope_study_list.do"><span>마그넷 스쿨</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/hope_study_list.do"><span>배우고 싶어요</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/teach_apply_list.do"><span>가르칠 수 있어요 </span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/together_study_list.do"><span>함께배워요</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/person_book_list.do"><span>인물도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/person_book_list.do"><span>열람 신청 </span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/person_reg_list.do"><span>인물도서 등록 신청 </span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span>악기도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span>악기대여</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/room_rental_list.do"><span>대관신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/senior/mypage/instrum_donation_list.do"><span>악기기증</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/online_counsel_list.do"><span>진학학습지원센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/online_counsel_list.do"><span>온라인 상담 예약</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/circle_reg_list.do"><span>평생학습동아리</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/senior/mypage/circle_reg_list.do"><span>동아리신청</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/senior/mypage/survey_list.do"><span>설문조사 참여/결과</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 나의 송파쌤 : e-->

        <li class="depth_1"><a href="#"><span>ETC</span></a><!--ETC -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/senior/main/privacy.do"><span>개인정보처리방침</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/main/mail.do"><span>이메일주소무단수집거부</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/main/copyright.do"><span>저작권정책</span></a></li>
                <!--2020.12.02 : s-->
                <li class="depth_2"><a href="/ssem/senior/main/terms.do"><span>이용약관</span></a></li>
                <!--2020.12.02 : e-->
                <li class="depth_2"><a href="/ssem/senior/main/sitemap.do"><span>사이트맵(Sitemap)</span></a></li>
                <li class="depth_2"><a href="/ssem/senior/main/family_site.do"><span>패밀리사이트</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- ETC : e-->
        <!-- depth_1 : e-->
    </ul>
</div><!-- all_menu_gnb : E -->
