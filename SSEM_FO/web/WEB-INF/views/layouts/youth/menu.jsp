<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="header_wrap">
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
                        <li><a href="/ssem/youth/login/login.do">로그인</a></li>
                        <li><a href="https://www.songpa.go.kr/www/joinStep0Form.do?url=https://www.songpa.go.kr/www/index.do">회원가입</a></li>
                        <li><a href="/ssem/youth/main/teacher_reg.do">강사신청</a></li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul class="h_top_left">
                        <li><a href="/ssem/youth/login/logout.do">로그아웃</a></li>
                        <li><a href="/ssem/youth/mypage/pwd_confirm.do">나의송파쌤</a></li>
                        <li><a href="/ssem/youth/main/teacher_reg.do">강사신청</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>
            <ul class="h_top_right">
                <li><a href="/ssem/youth/main/main.do" class="on">미래교육</a></li>
                <li><a href="/ssem/senior/main/main.do">평생교육</a></li>
            </ul>
        </div>
    </div>
    <div class="h_area_bottom"> <!--h_area_bottom-->
        <div class="wrap">
            <div id="nav">
                <h2 class="text_hide">메뉴</h2>
                <ul id="gnb"> <!-- gnb -->
                    <!-- depth_1 -->
                    <li class="depth_1"><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a>  <!-- 온라인 캠퍼스 -->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_01.jpg" alt="온라인캠퍼스"></div>
                                <h3 class="depth_tit">온라인 캠퍼스 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_intro.do">소개 및 이용안내</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_book_list.do">인물도서 목록</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_month_list.do">이달의 인물도서</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_live_list.do">LIVE 인물도서</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_school_list.do">찾아가는 인물도서</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_review_list.do">인물도서 열람후기</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_insert.do">인물도서 등록</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/campus/future_main.do">미래교육센터</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/campus/future_main.do">미래교육센터</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/self_intro.do">소개 및 이용안내</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/self_study_list.do">진학학습정보</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/self_program_list.do">프로그램 신청</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/self_counsel_insert.do">온라인 상담예약</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로직업체험지원센터(꿈마루)<i class="icon_link_bk">외부링크</i> </a></li>
                                <li class="depth_2"><a href="/ssem/youth/campus/songpa_vision.do">송파혁신교육지구</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_vision.do">운영비전</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_biz.do">주요사업 안내</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_group.do">네트워크 구성 및 조직도</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_gallery_list.do">갤러리</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 온라인 캠퍼스 : e-->

                    <li class="depth_1"><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li><!-- 통합프로그램신청 : e-->

                    <li class="depth_1"><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a><!-- 마그넷스쿨 : e-->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_03.jpg" alt="마그넷스쿨"></div>
                                <h3 class="depth_tit">마그넷스쿨 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                                <li class="depth_2"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                                <li class="depth_2"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유 채널</a></li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 마그넷스쿨 : e-->

                    <li class="depth_1"><a href="#">교육지원</a><!-- 교육지원 -->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_04.jpg" alt="교육지원"></div>
                                <h3 class="depth_tit">교육지원 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/songpacenter/main/main.do" target="_blank">송파청소년센터<i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="/ssem/machuncenter/main/main.do" target="_blank">마천청소년센터<i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="/ssem/jamsilcenter/main/main.do" target="_blank">잠실청소년센터<i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="/ssem/youth/center/child_culture.do">송파어린이문화회관</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/center/child_culture.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/center/broad_acamedy.do">송파어린이 방송아카데미</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/center/broad_acamedy.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/center/youth_counsel.do">송파구 청소년상담복지센터</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/center/youth_counsel.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/futurecenter/main/main.do" target="_blank">미래교육센터 오금Hub<i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="/ssem/youth/center/gender_culture.do">송파 청소년 성문화 센터</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/center/gender_culture.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/center/dream_support.do">송파구청소년 지원센터 꿈드림</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/center/dream_support.do">기관소개</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="http://www.espot.co.kr/" target="_blank">건우에듀<i class="icon_link_bk">외부링크</i></a></li>
                                <li class="depth_2"><a href="http://www.spenglish.kr" target="_blank">예일이러닝<i class="icon_link_bk">외부링크</i></a></li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 교육지원 : e-->

                    <li class="depth_1"><a href="/ssem/youth/ssem/vision.do">송파쌤</a><!-- 송파쌤 -->
                        <div class="depth_2_box"><div class="wrap">
                            <div class="depth_title">
                                <div class="depth_title_img"><img src="/ssem/resources/img/common/depth_title_img_05.jpg" alt="송파쌤"></div>
                                <h3 class="depth_tit">송파쌤 </h3>
                                <p class="depth_tit_sub">송파에서 나고 자라고<br> 완성되는 창의적 인재 육성</p>
                            </div>
                            <ul>
                                <!-- depth_2 -->
                                <li class="depth_2"><a href="/ssem/youth/ssem/vision.do">송파쌤이란</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/ssem/vision.do">비전</a></li>
                                        <li class="depth_3"><a href="/ssem/youth/ssem/organ.do">조직도</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <li class="depth_2"><a href="/ssem/youth/ssem/notice_list.do">공지사항</a></li>
                                <li class="depth_2"><a href="/ssem/youth/ssem/survey_list.do">설문조사</a></li>
                                <li class="depth_2"><a href="/ssem/youth/ssem/qna.do">고객지원</a>
                                    <ul>
                                        <!-- depth_3 -->
                                        <li class="depth_3"><a href="/ssem/youth/ssem/qna.do">자주 묻는 질문</a></li>
                                        <!-- depth_3 : e-->
                                    </ul>
                                </li>
                                <!-- depth_2 : e-->
                            </ul>
                        </div></div>
                    </li><!-- 송파쌤 : e-->
                    <li class="depth_1"><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a><!-- 온라인 코칭쌤 -->
                    </li><!-- 온라인 코칭쌤 : e-->
                    <!-- depth_1 : e-->
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
                <form id="frm_search" name="frm_search" action="/ssem/youth/search/search.do" method="post">
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
        <li class="depth_1"><a href="#"><span>온라인 캠퍼스</span></a>  <!-- 온라인 캠퍼스 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/youth/campus/person_lib_main.do"><span>인물도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_main.do"><span>인물도서관</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_intro.do"><span>소개 및 이용안내</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_book_list.do"><span>인물도서 목록</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_month_list.do"><span>이달의 인물도서</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_live_list.do"><span>LIVE 인물도서</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_school_list.do"><span>찾아가는 인물도서</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_review_list.do"><span>인물도서 열람후기</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/person_lib_insert.do"><span>인물도서 등록</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/campus/instrum_lib_main.do"><span>악기도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_main.do"><span>악기도서관</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_intro.do"><span>소개 및 이용안내</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_rental_list.do"><span>악기대여</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_room_list.do"><span>대관신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_program_list.do"><span>프로그램 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do"><span>악기기증</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/instrum_lib_review_list.do"><span>갤러리</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/campus/future_main.do"><span>미래교육센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/campus/future_main.do"><span>미래교육센터</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/future_intro.do"><span>소개 및 이용안내</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/future_drone.do"><span>송파쌤 드론스쿨</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/future_program_list.do"><span>프로그램 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/future_review_list.do"><span>갤러리</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/campus/self_main.do"><span>진학학습지원센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/campus/self_main.do"><span>진학학습지원센터</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/self_intro.do"><span>소개 및 이용안내</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/self_study_list.do"><span>진학학습정보</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/self_program_list.do"><span>프로그램 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/self_counsel_insert.do"><span>온라인 상담예약</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/dream/main/dream_main.do" target="_blank" class="export_link"><span>송파진로 직업체험지원센터(꿈마루)</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/campus/songpa_vision.do"><span>송파혁신교육지구</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_vision.do"><span>운영비전</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_biz.do"><span>주요사업 안내</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_group.do"><span>네트워크 구성 및 조직도</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/campus/songpa_gallery_list.do">갤러리</a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 온라인 캠퍼스 : e-->

        <li class="depth_1"><a href="/ssem/youth/program/lecture_list.do"><span>통합프로그램신청</span></a></li><!-- 통합프로그램신청 : e-->

        <li class="depth_1"><a href="/ssem/youth/magnet/intro.do"><span>마그넷스쿨</span></a><!-- 마그넷스쿨 : e-->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/youth/magnet/intro.do"><span>이용안내</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/magnet/study_hope_list.do"><span>배우고 싶어요</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/magnet/study_share_list.do"><span>배움 공유 채널</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 마그넷스쿨 : e-->

        <li class="depth_1"><a href="#"><span>교육지원</span></a><!-- 교육지원 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/songpacenter/main/main.do" target="_blank" class="export_link"><span>송파청소년센터</span></a></li>
                <li class="depth_2"><a href="/ssem/machuncenter/main/main.do" target="_blank" class="export_link"><span>마천청소년센터</span></a></li>
                <li class="depth_2"><a href="/ssem/jamsilcenter/main/main.do" target="_blank" class="export_link"><span>잠실청소년센터</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/center/child_culture.do"><span>송파어린이문화회관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/center/child_culture.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/center/broad_acamedy.do"><span>송파어린이 방송아카데미</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/center/broad_acamedy.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/center/gender_culture.do"><span>송파구 청소년상담복지센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/center/gender_culture.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/futurecenter/main/main.do" target="_blank" class="export_link"><span>미래교육센터 오금Hub</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/center/gender_culture.do"><span>송파 청소년 성문화 센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/center/gender_culture.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/center/dream_support.do"><span>송파구청소년 지원센터 꿈드림</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/center/dream_support.do"><span>기관소개</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="http://www.espot.co.kr/" target="_blank" class="export_link"><span>건우에듀</span></a></li>
                <li class="depth_2"><a href="http://www.spenglish.kr" target="_blank" class="export_link"><span>예일이러닝</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 교육지원 : e-->

        <li class="depth_1"><a href="/ssem/youth/ssem/vision.do"><span>송파쌤</span></a><!-- 송파쌤 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/youth/ssem/vision.do"><span>송파쌤이란</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/ssem/vision.do"><span>비전</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/ssem/organ.do"><span>조직도</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/ssem/notice_list.do"><span>공지사항</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/ssem/survey_list.do"><span>설문조사</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/ssem/qna.do"><span>고객지원</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/ssem/qna.do"><span>자주 묻는 질문</span></a></li>
                        <!-- depth_3 : e-->
                    </ul>
                </li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 송파쌤 : e-->
        <li class="depth_1"><a href="/ssem/youth/coach/coach_list.do"><span>온라인 코칭쌤</span></a></li><!-- 온라인 코칭쌤 : e-->
        <!--2020.11.23 : s-->
        <li class="depth_1"><a href="/ssem/youth/mypage/program_list.do"><span>나의 송파쌤<br><span class="fw_200 fs_24">(마이페이지)</span></span></a><!--나의 송파쌤 -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/youth/mypage/program_list.do"><span>프로그램 확인</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/program_list.do"><span>프로그램 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/attend_list.do"><span>교육이수 현황</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/teacher_love_list.do"><span>강사 만족도 평가</span></a></li>
                        <c:if test="${loginVo.teacher_yn eq 'Y'}">
                            <li class="depth_3"><a href="/ssem/youth/mypage/teacher_history_list.do"><span>강사 이력 조회</span></a></li>
                        </c:if>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/hope_study_list.do"><span>마그넷 스쿨</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/hope_study_list.do"><span>배우고 싶어요</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/teach_apply_list.do"><span>가르칠 수 있어요 </span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/together_study_list.do"><span>함께배워요</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/person_book_list.do"><span>인물도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/person_book_list.do"><span>열람 신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/person_reg_list.do"><span>인물도서 등록 신청</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span>악기도서관</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span>악기대여</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/room_rental_list.do"><span>대관신청</span></a></li>
                        <li class="depth_3"><a href="/ssem/youth/mypage/instrum_donation_list.do"><span>악기기증</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/online_counsel_list.do"><span>진학학습지원센터</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/online_counsel_list.do"><span>온라인 상담 예약</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/circle_reg_list.do"><span>평생학습동아리</span></a>
                    <ul>
                        <!-- depth_3 -->
                        <li class="depth_3"><a href="/ssem/youth/mypage/circle_reg_list.do"><span>동아리신청</span></a></li>
                    </ul>
                </li>
                <li class="depth_2"><a href="/ssem/youth/mypage/survey_list.do"><span>설문조사 참여/결과</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- 나의 송파쌤 : e-->
        <li class="depth_1"><a href="#"><span>ETC</span></a><!--ETC -->
            <ul>
                <!-- depth_2 -->
                <li class="depth_2"><a href="/ssem/youth/main/privacy.do"><span>개인정보처리방침</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/main/mail.do"><span>이메일주소무단수집거부</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/main/copyright.do"><span>저작권정책</span></a></li>
                <!--2020.12.02 : s-->
                <li class="depth_2"><a href="/ssem/youth/main/terms.do"><span>이용약관</span></a></li>
                <!--2020.12.02 : e-->
                <li class="depth_2"><a href="/ssem/youth/main/sitemap.do"><span>사이트맵(Sitemap)</span></a></li>
                <li class="depth_2"><a href="/ssem/youth/main/family_site.do"><span>패밀리사이트</span></a></li>
                <!-- depth_2 : e-->
            </ul>
        </li><!-- ETC : e-->
        <!-- depth_1 : e-->
    </ul>
</div><!-- all_menu_gnb : E -->
</div>
