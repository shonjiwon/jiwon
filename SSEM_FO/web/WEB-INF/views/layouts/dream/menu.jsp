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
                    <a href="/ssem/dream/main/dream_main.do"><img src="/ssem/resources/img/common/ggoom_logo.png" alt="꿈마루 송파진로직업 체험지원센터"></a>
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
                                <li><a href="/ssem/youth/login/login.do?return_url=/dream/main/dream_main.do">로그인</a></li>
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
                        <li class="depth_1"><a href="/ssem/dream/dream/intro.do" class="hov">꿈마루</a>  <!-- 꿈마루-->
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li class="depth_2"><a href="/ssem/dream/dream/intro.do">꿈마루 소개</a></li>
                                    <li class="depth_2"><a href="/ssem/dream/dream/program_info.do">프로그램 안내</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 꿈마루 : e-->

                        <li class="depth_1"><a href="/ssem/dream/together/experience.do" class="hov">가치, 같이 함께 해주세요</a>
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li class="depth_2"><a href="/ssem/dream/together/experience.do">현장직업체험처 참여</a></li>
                                    <li class="depth_2"><a href="/ssem/dream/together/job_mentor.do">직업인 멘토 참여</a></li>
                                    <li class="depth_2"><a href="/ssem/dream/together/home_mentor.do">학부모진로교육멘토단 참여</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 가치, 같이 함께 해주세요 : e : e-->

                        <li class="depth_1"><a href="/ssem/dream/program/program_list.do" class="hov">프로그램 신청</a></li><!-- 프로그램 신청 : e : e-->

                        <li class="depth_1"><a href="/ssem/dream/news/notice_list.do" class="hov">꿈마루 소식</a><!-- 마그넷스쿨 : e-->
                            <div class="depth_2_box jst_1"><div class="wrap">
                                <ul>
                                    <!-- depth_2 -->
                                    <li class="depth_2"><a href="/ssem/dream/news/notice_list.do">공지사항</a></li>
                                    <li class="depth_2"><a href="/ssem/dream/news/broad_list.do">보도자료</a></li>
                                    <li class="depth_2"><a href="/ssem/dream/news/gallery_list.do">갤러리</a></li>
                                    <!-- depth_2 : e-->
                                </ul>
                            </div></div>
                        </li><!-- 꿈마루 소식 : e-->

                        <!-- depth_1 : e-->
                    </ul>
                </div><!-- gnb : e-->
            </div>
        </div><!--h_area_bottom-->
        <div class="icon_btn_wrap wrap t_right">
            <div class="icon_btn_box clserfix">
                <button type="button" class=" float_left icon_btn act_search_bar screen_md_hide"><i class="icon_search_bk">검색</i></button>
                <button type="button" class="float_right icon_btn act_menu screen_md_show"><i class="icon_menu_bk">전체메뉴</i></button>
            </div>
        </div>
        <div class="search_bar_box off">
            <form id="frm_search" name="frm_search" action="/ssem/dream/search/search.do" method="post" class="ptb_25 ptb_md_20">
                <div class="search_bar">
                    <input type="text" name="query" id="query" class="inp fs_18 fs_sm_26" title="검색입력창">
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
            <li class="depth_1"><a href="/ssem/dream/dream/intro.do"><span>꿈마루</span></a>  <!-- 꿈마루 -->
                <ul>
                    <!-- depth_2 -->
                    <li class="depth_2"><a href="/ssem/dream/dream/intro.do"><span>꿈마루 소개</span></a></li>
                    <li class="depth_2"><a href="/ssem/dream/dream/program_info.do"><span>프로그램 안내</span></a></li>
                </ul>
            </li><!-- 꿈마루 : e-->

            <li class="depth_1"><a href="/ssem/dream/together/experience.do"><span>가치, 같이 함께 해주세요.</span></a><!-- 마그넷스쿨 : e-->
                <ul>
                    <!-- depth_2 -->
                    <li class="depth_2"><a href="/ssem/dream/together/experience.do"><span>현장직업체험처 참여</span></a></li>
                    <li class="depth_2"><a href="/ssem/dream/together/job_mentor.do"><span>직업인 멘토 참여</span></a></li>
                    <li class="depth_2"><a href="/ssem/dream/together/home_mentor.do"><span>학부모진로교육멘토단 참여</span></a></li>
                </ul>
            </li>

            <li class="depth_1"><a href="/ssem/dream/program/program_list.do"><span>프로그램신청</span></a></li><!-- 프로그램신청 : e-->

            <li class="depth_1"><a href="/ssem/dream/news/notice_list.do"><span>꿈마루 소식</span></a><!-- 교육지원 -->
                <ul>
                    <!-- depth_2 -->
                    <li class="depth_2"><a href="/ssem/dream/news/notice_list.do"><span>공지사항</span></a></li>
                    <li class="depth_2"><a href="/ssem/dream/news/broad_list.do"><span>보도자료</span></a></li>
                    <li class="depth_2"><a href="/ssem/dream/news/gallery_list.do"><span>갤러리</span></a></li>
                    <!-- depth_2 : e-->
                </ul>
            </li><!-- 교육지원 : e-->
            <!-- depth_1 : e-->
        </ul>
    </div>
</div>
