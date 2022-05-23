<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '대관신청 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        subListlSlide1();

        svsw_img_box();
    });

    function svsw_img_box(){
        if( !$('.svsw_img_box').hasClass('slick-slider')) {
            var html = '';

            $('.sub_visual_sd_wrap').append('<div class="_control"></div>')

            var $ntSlide = $('.svsw_img_box').slick({
                infinite: true,
                arrows:true,
                dots: false,
                slidesToShow: 1,
                autoplay: true,
                autoplaySpeed: 5000,
                slidesToScroll: 1,
                adaptiveHeight:true,
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next5.png' alt='다음'> </ button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev5.png' alt='이전'> </ button>",
                appendArrows:	$('.sub_visual_sd_wrap > ._control'),
                fade:true,
            });
        }
    }

    function subListlSlide1(){
        var len = $('.studio_list  > div').length;

        if( !$('.studio_list ').hasClass('slick-slider')) {
            var html = '';

            $('.studio_list ').after('<div class="_control"></div>')

            //dot 생성
            var $ntSlide = $('.studio_list ').slick({
                infinite: true,
                arrows:false,
                dots: true,
                slidesToShow: 6,
                slidesToScroll: 6,
                appendDots : $('.studio_list  + ._control'),
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            slidesToShow: 6,
                            slidesToScroll: 6,
                        }
                    },
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            slidesToShow: 5,
                            slidesToScroll: 5
                        }
                    },
                    {
                        breakpoint: 1024,
                        settings: {
                            arrows:false,
                            slidesToShow: 4,
                            slidesToScroll: 4
                        }
                    },
                    {
                        breakpoint: 870,
                        settings: {
                            arrows:false,
                            slidesToShow: 3,
                            slidesToScroll: 3
                        }
                    }
                ]
            });
            if( len > 6) {
                $('.studio_list  + ._control').addClass('pc_show')
            }
        }
    }

    function goRentalFty(rental_fty_idx) {
        location.href = "/ssem/youth/campus/instrum_lib_room_list.do?searchVal=" + rental_fty_idx;
    }

    function goPrevWeek() {
        var rental_fty_idx = '${searchVal}';
        var curDate = '${searchVal2}';

        var dateList = curDate.split('-');
        var year = dateList[0];
        var mon = dateList[1];
        var day = dateList[2];

        var date = new Date(Number(year), Number(mon) - 1, Number(day));
        date.setDate(date.getDate() - 7);

        var preYear = date.getFullYear();
        var preMon = date.getMonth() + 1;
        var preDay = date.getDate();
        var preDate = preYear + "-" + preMon + "-" + preDay;

        location.href = "/ssem/youth/campus/instrum_lib_room_list.do?searchVal=" + rental_fty_idx + "&searchVal2=" + preDate;
    }

    function goNextWeek() {
        var rental_fty_idx = '${searchVal}';
        var curDate = '${searchVal2}';

        var dateList = curDate.split('-');
        var year = dateList[0];
        var mon = dateList[1];
        var day = dateList[2];

        var date = new Date(Number(year), Number(mon) - 1, Number(day));
        date.setDate(date.getDate() + 7);

        var nextYear = date.getFullYear();
        var nextMon = date.getMonth() + 1;
        var nextDay = date.getDate();
        var nextDate = nextYear + "-" + nextMon + "-" + nextDay;

        location.href = "/ssem/youth/campus/instrum_lib_room_list.do?searchVal=" + rental_fty_idx + "&searchVal2=" + nextDate;
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_2"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    악기도서관
                </h2>

                <p class="tit_sub fw_200">
                    <strong>“1인 1악기”</strong>
                    청소년과 주민들이 쉽게 악기를 접하고 <br class="screen_hide screen_sm_show"> 체험할 수 있도록 악기를 테마로 한 교육문화복합<br class="screen_hide screen_sm_show">  플랫폼을 구축하여<br class="screen_sm_hide">
                    구민들이 부담 없이 <br class="screen_hide screen_sm_show"> 다양한 예술적 소양과 적성을 계발할 수 있도록 <br class="screen_hide screen_sm_show"> 지원하는 플랫폼입니다.
                </p>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">온라인 캠퍼스</a>
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
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/future_main.do">미래교육센터</a></li>
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로 체험지원센터(꿈마루)</a></li>
                            <li><a href="/ssem/youth/campus/songpa_vision.do">송파혁신교육지구</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">대관신청</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
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
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">악기도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">악기대여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_room_list.do" title="선택">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">대관신청</h4>
            <div class="wrap">
                <h5 class="fs_24 fs_md_30 fw_600 fw_md_500 pb_20 mb_10">안내사항</h5>
                <div class="bg_color_2 plr_35 ptb_30 fs_20 fs_md_22 fw_200"><!--table_box-->
                    <ul class="ul_list_dash">
                        <li> 이용대상 : 송파구민, 관내 학교 재학생 또는 교육포털 회원</li>
                        <li> 이용안내
                            <p class="ml_20">● 스튜디오1,2(1인음악창작실): 미디(디지털 기반), 음원제작 연습 및 실습</p>
                            <p class="ml_20">● 스튜디오3,4(연습실): 단체 연습(개인악기연습 불가), 음악강좌진행</p>
                        </li>
                        <li> 이용시간 : 입실시간과 퇴실시간을 기준으로 합니다. (방역소독 및 시설정비를 위해 종료 5분전 퇴실 요청 드립니다.)</li>
                        <li> 대관은 최소 1시간, 최대 2시간 가능합니다.</li>
                        <li> 모든 스튜디오 이용은 개인/팀 당 월 8시간으로 제한됩니다. (구민들의 이용 기회 확대를 위함)</li>
                        <li> 대관관련 문의 : 02-2147-2544/2545</li>
                    </ul>
                </div><!--table_box //-->
                <h5 class="fs_24 fs_md_30 fw_600 fw_md_500 mt_95 mb_35 mt_md_40 clearfix">
                    <span class="dp_inb float_left">시설현황</span>
                    <span class="dp_inb float_right fs_18 fs_md_20 fw_200"><i class="icon_info">정보</i> <span class="va_m">시설을 선택하시면 대관현황을 보실 수 있습니다.</span></span>
                </h5>
                <div class="studio_list row fs_20 fs_md_24 t_center">
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <div class="col_2">
                            <a href="#none" onclick="goRentalFty('${item.rental_fty_idx}')" <c:if test="${item.rental_fty_idx eq selected_fty.rental_fty_idx}">class="on"</c:if>>
                                <section>
                                    <div class="img_box">
                                        <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                    </div>
                                    <p>${item.name}</p>
                                </section>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="cal_btn_box mt_50">
                    <button type="button" onclick="goPrevWeek()"><img src="/ssem/resources/img/sub/caldate_prev.png" alt="이전"  ></button>
                    <span id="caldate" class="fs_24 fs_md_26 fw_500 ls_0">
                        ${selected_fty.start_date} ~ ${selected_fty.end_date}
                    </span>
                    <button type="button" onclick="goNextWeek()"><img src="/ssem/resources/img/sub/caldate_next.png" alt="다음"></button>
                </div>
                <div class="mtb_50">
                    <div class="row">
                        <div class="col_12">
                            <div class="row_15 music_apply_box">
                                <div class="col_6 col_md_15 music_apply_btn_box pr_15 pr_md_0">
                                    <div class="music_apply">
                                        <div class="img_box">
                                            <c:forEach items="${selected_fty.thumbFileList}" var="thumb" varStatus="status">
                                                <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                            </c:forEach>
                                        </div>
                                        <div class="ma_btn_box">
                                            <a href="/ssem/youth/campus/instrum_lib_room_insert.do?rental_fty_idx=${selected_fty.rental_fty_idx}" class="btn btn_color_5">대관신청</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col_9 col_md_15 mt_md_30">
                                    <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                                        <ul>
                                            <li class="table">
                                                <div class="th">시설명</div>
                                                <div class="td">${selected_fty.name}</div>
                                            </li>
                                            <li class="table">
                                                <div class="th">사이즈 (수용인원)</div>
                                                <div class="td">${selected_fty.capacity}</div>
                                            </li>
                                            <li class="table">
                                                <div class="th">이용시간</div>
                                                <div class="td">${selected_fty.use_time}</div>
                                            </li>
                                            <li class="table">
                                                <div class="th">이용내용</div>
                                                <div class="td">${selected_fty.intro}</div>
                                            </li>
                                            <li class="table">
                                                <div class="th">대관료</div>
                                                <div class="td">시간당 <fmt:formatNumber value="${selected_fty.fee}" pattern="##,###"/>원</div>
                                            </li>
                                            <li class="table mo_full">
                                                <div class="th">시설안내</div>
                                                <div class="td">
                                                    <p>${selected_fty.cont}</p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col_12 mt_50 mb_80">
                            <div class="table_box cal_table fs_18 fs_md_24"><!--table_box-->
                                <table class="table">
                                    <caption class="text_hide">대관신청 날짜 및 오전 9시에서 오후9시 예약 안내 표</caption>

                                    <tbody>
                                    <tr>
                                        <th>시간</th>
                                        <th>${can_use_list[0].date_str}(${can_use_list[0].week})</th>
                                        <th>${can_use_list[1].date_str}(${can_use_list[1].week})</th>
                                        <th>${can_use_list[2].date_str}(${can_use_list[2].week})</th>
                                        <th>${can_use_list[3].date_str}(${can_use_list[3].week})</th>
                                        <th>${can_use_list[4].date_str}(${can_use_list[4].week})</th>
                                        <th>${can_use_list[5].date_str}(${can_use_list[5].week})</th>
                                        <th>${can_use_list[6].date_str}(${can_use_list[6].week})</th>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">09:00 - 10:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h9 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h9 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">10:00 - 11:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h10 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h10 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">11:00 - 12:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h11 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h11 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">12:00 - 13:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h12 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h12 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">13:00 - 14:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h13 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h13 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">14:00 - 15:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h14 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h14 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">15:00 - 16:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h15 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h15 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">16:00 - 17:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h16 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h16 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">17:00 - 18:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h17 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h17 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">18:00 - 19:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h18 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h18 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">19:00 - 20:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h19 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h19 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td><span class="fw_600">20:00 - 21:00</span></td>
                                        <c:forEach items="${can_use_list}" var="can" varStatus="status_can">
                                            <c:choose>
                                                <c:when test="${can_use_list[status_can.index].h20 eq 'R'}"><td class="end">예약완료</td></c:when>
                                                <c:when test="${can_use_list[status_can.index].h20 ne 'Y'}"><td class="end">이용불가</td></c:when>
                                                <c:otherwise><td>예약가능</td></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</div>
