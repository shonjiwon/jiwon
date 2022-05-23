<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-05
  Time: 오후 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '사이트맵 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_14"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    사이트맵
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">사이트맵</a>
                        <ul>
                            <li><a href="/ssem/youth/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/youth/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/youth/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/youth/main/terms.do">이용약관</a></li>
                            <li><a href="/ssem/youth/main/sitemap.do">사이트맵</a></li>
                            <li><a href="/ssem/youth/main/family_site.do">패밀리사이트</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">사이트맵</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_16 fs_md_22 pb_100 mb_15 mt_60">
            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">온라인 캠퍼스</strong>
                </div>
                <div class="sites">
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
                        <li class="depth_2"><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로 직업체험지원센터 (꿈마루) <i class="icon_link_bk">외부링크</i> </a></li>
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
                </div>
            </div>
            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></strong>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></strong>
                </div>
                <div class="sites">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                        <li class="depth_2"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                        <li class="depth_2"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유 채널</a></li>
                        <!-- depth_2 : e-->
                    </ul>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">교육지원</strong>
                </div>
                <div class="sites">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/songpacenter/main/main.do" target="_blank" class="export_link"><span>송파청소년센터</span></a></li>
                        <li class="depth_2"><a href="/ssem/machuncenter/main/main.do" target="_blank" class="export_link"><span>마천청소년센터</span></a></li>
                        <li class="depth_2"><a href="/ssem/jamsilcenter/main/main.do" target="_blank" class="export_link"><span>잠실청소년센터</span></a></li>
                        <li class="depth_2"><a href="/ssem/youth/center/child_culture.do"><span>송파어린이<br class="mo">문화회관</span></a>
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
                        <li class="depth_2"><a href="/ssem/youth/center/youth_counsel.do"><span>송파구청소년 상담복지센터</span></a>
                            <ul>
                                <!-- depth_3 -->
                                <li class="depth_3"><a href="/ssem/youth/center/youth_counsel.do"><span>기관소개</span></a></li>
                                <!-- depth_3 : e-->
                            </ul>
                        </li>
                        <li class="depth_2"><a href="/ssem/futurecenter/main/main.do" target="_blank" class="export_link"><span>미래교육센터<br>오금Hub</span></a></li>
                        <li class="depth_2"><a href="/ssem/youth/center/gender_culture.do"><span>송파청소년<br>성문화센터</span></a>
                            <ul>
                                <!-- depth_3 -->
                                <li class="depth_3"><a href="/ssem/youth/center/gender_culture.do"><span>기관소개</span></a></li>
                                <!-- depth_3 : e-->
                            </ul>
                        </li>
                        <li class="depth_2"><a href="/ssem/youth/center/dream_support.do"><span>송파구청소년 지원센터꿈드림</span></a>
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
                </div>
            </div>
            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/youth/ssem/vision.do">송파쌤</a></strong>
                </div>
                <div class="sites">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/youth/ssem/vision.do"><span>송파쌤이란</span></a>
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
                </div>
            </div>
            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></strong>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">나의 송파쌤</strong>
                </div>
                <div class="sites">
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
                </div>
            </div>
            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">ETC</strong>
                </div>
                <div class="sites">
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
                </div>
            </div>
        </div>
    </div>
</div>
