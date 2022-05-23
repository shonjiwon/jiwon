<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 6:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '대관신청 > 악기도서관 > 나의 송파쌤 > 평생교육 > 송파쌤');

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
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/senior/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/senior/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/senior/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/senior/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">대관신청</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
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
    <div class="sub_con st_5 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">악기도서관<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">악기도서관</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do">악기대여</a></li>
                <li class="tab_item on"><a href="/ssem/senior/mypage/room_rental_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_donation_list.do">악기기증</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <form action="#" onSubmit="return false;">
                <div class="wrap">
                    <h1 class="c_tit_1 mt_90">대관신청</h1>
                    <h2 class="c_tit_2 ptb_15 clearfix">시설정보</h2>
                    <div class="row_24 music_apply_box h_340"><!--music_apply_box-->
                        <div class="col_9 col_md_24 music_apply_btn_box pr_30 pr_md_0">
                            <div class="music_apply">
                                <div class="img_box">
                                    <c:forEach items="${rentalFtyVo.thumbFileList}" var="thumb" varStatus="status">
                                        <img src="${thumb.file_src}" alt="${rentalFtyVo.alt_txt}">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="col_15 col_md_24 mt_md_30">
                            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                                <ul>
                                    <li class="table half">
                                        <div class="th">시설명</div>
                                        <div class="td">${rentalFtyVo.name}</div>
                                    </li>
                                    <li class="table half">
                                        <div class="th">사이즈 (수용인원)</div>
                                        <div class="td">${rentalFtyVo.capacity}</div>
                                    </li>
                                    <li class="table">
                                        <div class="th">이용시간</div>
                                        <div class="td">${rentalFtyVo.use_time}</div>
                                    </li>
                                    <li class="table">
                                        <div class="th">이용내용</div>
                                        <div class="td">${rentalFtyVo.intro}</div>
                                    </li>
                                    <li class="table">
                                        <div class="th">대관료</div>
                                        <div class="td">시간당 <fmt:formatNumber value="${rentalFtyVo.fee}" pattern="##,###"/>원</div>
                                    </li>
                                    <li class="table mo_full">
                                        <div class="th">시설안내</div>
                                        <div class="td">
                                            <p>${rentalFtyVo.cont}</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div><!--music_apply_box//-->
                    <h2 class="c_tit_2 ptb_15 mt_50">회원 기본 정보</h2>
                    <div class="table_box fs_18 fs_md_24"><!--table_box-->
                        <table class="table">
                            <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                            <tr>
                                <th class="wid_300">신청자 이름</th>
                                <td>${rentalFtyApyVo.apy_name}</td>
                            </tr>
                            <tr>
                                <th class="wid_300">휴대전화 번호</th>
                                <td>
                                    ${rentalFtyApyVo.apy_mob_no}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!--table_box //-->

                    <h2 class="c_tit_2 ptb_15 mt_50">신청 정보</h2>
                    <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                        <ul>
                            <li class="table">
                                <div class="th wid_300">예약상태</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${rentalFtyApyVo.pay_status eq 'O'}"><span class="my_tc_1">예약완료</span></c:when>
                                        <c:when test="${rentalFtyApyVo.pay_status eq 'C'}"><span class="my_tc_3">예약취소</span></c:when>
                                    </c:choose>
                                </div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">대관시설</div>
                                <div class="td">${rentalFtyVo.name}</div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">결제금액</div>
                                <div class="td"><span class="my_tc_1"><fmt:formatNumber value="${rentalFtyApyVo.pay_sum}" pattern="##,###"/> 원</span></div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">예약날짜</div>
                                <div class="td">${fn:substring(rentalFtyApyVo.resv_dt, 0, 10)}</div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">예약시간</div>
                                <div class="td">
                                    <c:if test="${rentalFtyApyVo.h9 eq 'Y'}">[09:00 ~ 10:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h10 eq 'Y'}"> [10:00 ~ 11:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h11 eq 'Y'}"> [11:00 ~ 12:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h12 eq 'Y'}"> [12:00 ~ 13:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h13 eq 'Y'}"> [13:00 ~ 14:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h14 eq 'Y'}"> [14:00 ~ 15:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h15 eq 'Y'}"> [15:00 ~ 16:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h16 eq 'Y'}"> [16:00 ~ 17:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h17 eq 'Y'}"> [17:00 ~ 18:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h18 eq 'Y'}"> [18:00 ~ 19:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h19 eq 'Y'}"> [19:00 ~ 20:00]</c:if>
                                    <c:if test="${rentalFtyApyVo.h20 eq 'Y'}"> [20:00 ~ 21:00]</c:if>
                                </div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">결제완료일</div>
                                <div class="td">${rentalFtyApyVo.pay_dt}</div>
                            </li>
                            <li class="table half">
                                <div class="th wid_300">결제취소일</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${rentalFtyApyVo.pay_cancel_dt eq '' || rentalFtyApyVo.pay_cancel_dt eq null}">-</c:when>
                                        <c:otherwise>${rentalFtyApyVo.pay_cancel_dt}</c:otherwise>
                                    </c:choose>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <p class="tc_point mt_10 fs_18 fs_md_24">※ 예약 취소 및 변경은 담당자에게 문의해 주세요. (☎ 02-2147-2544 ~ 2545)</p>
                    <div class="btn_box mypage_btn_box mt_50 pb_30 t_right">
                        <a href="/ssem/senior/mypage/room_rental_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                    </div>
                </div>
            </form>
        </section>
    </div>
</div>
