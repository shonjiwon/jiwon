<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="header_wrap">
    <div id="header" class="mini_page">
        <div class="h_area_top">
            <div class="wrap">
                <h1 class="rot_logo">
                    <a href="/ssem"><img src="/ssem/resources/img/common/logo.png" alt="송파쌤 SSEM"></a>
                </h1>
                <h1 class="logo">
                    <a href="/ssem/songpacenter/main/main.do"><img src="/ssem/resources/img/common/youth/youth_logo.jpg" alt="송파 청소년 센터"></a>
                </h1>
                <h2 class="text_hide">상단메뉴</h2>
                <div class="float_right">
                    <!--
                    로그아웃

                    <ul class="h_top_left">
                        <li><a href="#">로그아웃</a></li>
                        <li><a href="#">나의송파쌤</a></li>
                    </ul>
                    -->
                    <c:choose>
                        <c:when test="${loginVo eq null}">
                            <ul class="h_top_left">
                                <li><a href="/ssem/youth/login/login.do?return_url=/songpacenter/main/main.do">로그인</a></li>
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
        </div>
        <div class="h_area_bottom"> <!--h_area_bottom-->
            <div class="wrap">
                <div id="nav">
                    <h2 class="text_hide">메뉴</h2>
                    <ul id="gnb"> <!-- gnb -->
                        <!-- depth_1 -->
                        <li class="depth_1"><a href="/ssem/songpacenter/intro/intro.do" class="hov">기관소개</a>  <!-- 기관소개-->
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li class="depth_2"><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                                    <li class="depth_2"><a href="/ssem/songpacenter/intro/use.do">이용안내</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 기관소개 : e-->

                        <li class="depth_1"><a href="/ssem/songpacenter/program/program_list.do" class="hov">프로그램 신청</a></li><!-- 프로그램 신청 : e : e-->

                        <li class="depth_1"><a href="/ssem/songpacenter/biz/youth.do" class="hov">주요사업</a>
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li  class="depth_2"><a href="/ssem/songpacenter/biz/youth.do">청소년사업</a></li>
                                    <li  class="depth_2"><a href="/ssem/songpacenter/biz/child.do">유아체능단</a></li>
                                    <li  class="depth_2"><a href="/ssem/songpacenter/biz/alternative.do">대안학교</a></li>
                                    <li  class="depth_2"><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 주요사업 : e : e-->

                        <li class="depth_1"><a href="/ssem/songpacenter/place/intro.do" class="hov">시설안내</a></li><!-- 시설안내 : e : e-->

                        <li class="depth_1"><a href="/ssem/songpacenter/news/notice_list.do" class="hov">고객지원</a><!-- 고객지원 : e-->
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li class="depth_2"><a href="/ssem/songpacenter/news/notice_list.do">공지사항</a></li>
                                    <li class="depth_2"><a href="/ssem/songpacenter/news/qna_list.do">고객광장</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 고객지원 : e-->

                        <!-- depth_1 : e-->
                    </ul>
                </div><!-- gnb : e-->
            </div>
        </div><!--h_area_bottom-->
        <div class="icon_btn_wrap wrap t_right">
            <div class="icon_btn_box clserfix">
                <button type="button" class="float_right icon_btn act_search_bar screen_md_hide"><i class="icon_search_bk">검색</i></button>
                <button type="button" class="float_right icon_btn act_menu screen_md_show"><i class="icon_menu_bk">전체메뉴</i></button>
            </div>
        </div>
        <div class="search_bar_box off">
            <form id="frm_search" name="frm_search" action="/ssem/songpacenter/search/search.do" method="post" class="ptb_25 ptb_md_20">
                <div class="search_bar">
                    <input type="text" class="inp fs_18 fs_sm_26" title="검색입력창" name="query" id="query">
                    <button type="submit" class="btn btn_icon btn_search">
                        <i class="icon_search_bk">검색</i>
                    </button>
                </div>
            </form>
        </div>

    </div><!--header : e-->
    <div class="all_menu_gnb all_mneu"><!-- all_menu_gnb -->
        <h2 class="text_hide">모바일 메뉴</h2>
        <ul> <!-- gnb -->
            <!-- depth_1 -->
            <li class="depth_1"><a href="/ssem/songpacenter/intro/intro.do"><span>기관소개</span></a>  <!-- 기관소개-->
                <div class="depth_2_box jst_1"><div class="wrap">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/songpacenter/intro/intro.do"><span>기관소개</span></a></li>
                        <li class="depth_2"><a href="/ssem/songpacenter/intro/use.do"><span>이용안내</span></a></li>
                        <!-- depth_2 : e-->
                    </ul>
                </div></div>
            </li><!-- 기관소개 : e-->

            <li class="depth_1"><a href="/ssem/songpacenter/program/program_list.do"><span>프로그램 신청</span></a></li><!-- 프로그램 신청 : e : e-->

            <li class="depth_1"><a href="/ssem/songpacenter/biz/youth.do"><span>주요사업</span></a>
                <div class="depth_2_box jst_1"><div class="wrap">
                    <ul>
                        <!-- depth_2 -->
                        <li  class="depth_2"><a href="/ssem/songpacenter/biz/youth.do"><span>청소년사업</span></a></li>
                        <li  class="depth_2"><a href="/ssem/songpacenter/biz/child.do"><span>유아체능단</span></a></li>
                        <li  class="depth_2"><a href="/ssem/songpacenter/biz/alternative.do"><span>대안학교</span></a></li>
                        <li  class="depth_2"><a href="/ssem/songpacenter/biz/life.do"><span>생활체육 및 교육문화</span></a></li>
                        <!-- depth_2 : e-->
                    </ul>
                </div></div>
            </li><!-- 주요사업 : e : e-->
            <li class="depth_1"><a href="/ssem/songpacenter/place/intro.do"><span>시설안내</span></a></li><!-- 시설안내 : e : e-->
            <li class="depth_1"><a href="/ssem/songpacenter/news/notice_list.do"><span>고객지원</span></a><!-- 고객지원 : e-->
                <div class="depth_2_box jst_1"><div class="wrap">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/songpacenter/news/notice_list.do"><span>공지사항</span></a></li>
                        <li class="depth_2"><a href="/ssem/songpacenter/news/qna_list.do"><span>고객광장</span></a></li>
                        <!-- depth_2 : e-->
                    </ul>
                </div></div>
            </li><!-- 고객지원 : e-->
            <!-- depth_1 : e-->
        </ul>
    </div>
</div>
