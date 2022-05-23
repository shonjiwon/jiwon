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
        $(document).prop('title', '사이트맵 > 평생교육 > 송파쌤');

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
                            <li><a href="/ssem/senior/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/senior/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/senior/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/senior/main/terms.do">이용약관</a></li>
                            <li><a href="/ssem/senior/main/sitemap.do">사이트맵</a></li>
                            <li><a href="/ssem/senior/main/family_site.do">패밀리사이트</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
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
                    <strong class="smb_tit">평생교육</strong>
                </div>
                <div class="sites">
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
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></strong>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/senior/magnet/intro.do">마그넷스쿨</a></strong>
                </div>
                <div class="sites">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/senior/magnet/intro.do">이용안내</a></li>
                        <li class="depth_2"><a href="/ssem/senior/magnet/study_hope_list.do">배우고 싶어요</a></li>
                        <li class="depth_2"><a href="/ssem/senior/magnet/study_share_list.do">배움 공유채널</a></li>
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
                        <li class="depth_2"><a href="/ssem/senior/center/woman_culture.do"><span>송파여성<br class="mo">문화회관</span></a>
                            <ul>
                                <!-- depth_3 -->
                                <li class="depth_3"><a href="/ssem/senior/center/woman_culture.do"><span>기관소개</span></a></li>
                                <!-- depth_3 : e-->
                            </ul>
                        </li>
                        <li class="depth_2"><a href="/ssem/senior/center/life_culture.do"><span>송파생활<br class="mo">문화회관</span></a>
                            <ul>
                                <!-- depth_3 -->
                                <li class="depth_3"><a href="/ssem/senior/center/life_culture.do"><span>기관소개</span></a></li>
                                <!-- depth_3 : e-->
                            </ul>
                        </li>
                        <!-- <li class="depth_2"><a href="/senior/center/child_culture.do"><span>송파어린이<br class="mo">문화회관</span></a>
                            <ul>
                                <!-/- depth_3 -/->
                                <li class="depth_3"><a href="/senior/center/child_culture.do"><span>기관소개</span></a></li>
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
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">송파쌤</strong>
                </div>
                <div class="sites">
                    <ul>
                        <!-- depth_2 -->
                        <li class="depth_2"><a href="/ssem/senior/ssem/vision.do"><span>송파쌤이란</span></a>
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
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></strong>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit"><a href="/ssem/senior/coach/coach_list.do">온라인 코칭쌤</a></strong>
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">나의 송파쌤</strong>
                </div>
                <div class="sites">
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
                </div>
            </div>

            <div class="siteMap_box">
                <div class="smb_title_box">
                    <strong class="smb_tit">ETC</strong>
                </div>
                <div class="sites">
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
                </div>
            </div>

        </div>

    </div>
</div>
