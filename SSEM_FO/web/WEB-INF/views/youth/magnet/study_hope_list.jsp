<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '배우고 싶어요 > 마그넷스쿨 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        subListlSlide1();

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        $("#page").val("1");
        $("#frm").submit();
    }

    function subListlSlide1(){
        var len = $('.sml > div').length;
        if( !$('.sml').hasClass('slick-slider')) {
            var html = '';

            $('.sml').after('<div class="_control"></div>')

            //dot 생성
            var $slide = $('.sml').slick({
                infinite: true,
                arrows:true,
                nextArrow: "<button type='button' class='slick-next'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_next2.png' alt='다음'> </ button>",
                prevArrow: "<button type='button' class='slick-prev'> <img class='ani' src='/ssem/resources/img/common/icon_list_arrow_prev2.png' alt='이전'> </ button>",
                appendArrows:	$('.sml + ._control'),
                appendDots : $('.sml + ._control'),
                dots: false,
                slidesToShow: 4,
                slidesToScroll: 4,
                adaptiveHeight:true,
                responsive: [
                    {
                        breakpoint: 1660,
                        settings: {
                            arrows:false,
                            dots:true,
                        }
                    },
                    {
                        breakpoint: 1440,
                        settings: {
                            arrows:false,
                            dots:true,
                            slidesToShow: 3,
                            slidesToScroll: 3,
                        }
                    },
                    {
                        breakpoint: 1024,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 767,
                        settings: {
                            arrows:true,
                            dots:true,
                            slidesToShow: 2,
                            slidesToScroll: 3,
                        }
                    }
                ]
            });
        }
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_7"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    마그넷스쿨
                </h2>

                <p class="tit_sub">
                    <strong>“마그넷스쿨 이란?”</strong>
                    송파마그넷 스쿨은 학습자가 원하는 강좌를 신청하면 <br class="screen_hide screen_sm_show"> 강사 학습자 학습공간을 연결해주는 학교로 자석처럼 학생을<br>
                    끌어당기는 맞춤교육입니다. 배우고 싶던 교육이 있으셨나요? <br class="screen_hide screen_sm_show"> 기다리지 말고 지금 신청해보세요.
                </p>
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
                        <a href="#" class="deapth_tit" title="선택">마그넷스쿨</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">배우고 싶어요</a>
                        <ul>
                            <li><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                            <li><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                            <li><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
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
    <div class="sub_con st_1"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">마그넷스쿨</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">배우고 싶어요<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_3"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/magnet/intro.do">이용안내</a></li>
                <li class="tab_item on"><a href="/ssem/youth/magnet/study_hope_list.do">배우고 싶어요</a></li>
                <li class="tab_item"><a href="/ssem/youth/magnet/study_share_list.do">배움 공유채널</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_18 fs_md_26 mt_0 mt_md_50 pb_100 mb_15">
            <div class="sub_main_list_wrap st_3 pb_md_50">
                <div class="wrap por">
                    <h2 class="tit"><span>청원성공강좌 신청</span></h2>
                    <div class="sml row pt_30 pt_md_20 fs_24 fs_md_26">
                        <!-- snl_item -->
                        <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                            <div class="snl_item color_1 col_3 col_lg_4 col_sm_6">
                                <a href="/ssem/youth/program/lecture_view.do?lecture_idx=${lecture.lecture_idx}">
                                    <section>
                                        <div class="text_box">
                                            <div class="catalogue_box fs_18 fs_md_24">
                                                <c:forEach items="${lecture.array_tgt}" var="tgt" varStatus="status">
                                                    <span class="item">${tgt}</span>
                                                </c:forEach>
                                            </div>
                                            <h4 class="_tit">
                                                <span class="ellip_2">${lecture.name}</span>
                                            </h4>
                                            <ul class="fs_18 fw_300 fs_md_24">
                                                <li><span>접수기간 : </span> ${fn:substring(lecture.reg_start_st, 2, 10)} ~ ${fn:substring(lecture.reg_end_dt, 2, 10)}</li>
                                                <li><span>교육기간 : </span> ${fn:substring(lecture.start_dt, 2, 10)} ~ ${fn:substring(lecture.end_dt, 2, 10)}<br>(${lecture.dt_str} ${lecture.start_time} ~ ${lecture.end_time})</li>
                                            </ul>
                                            <div class="item_bottom tc_point">
                                                <c:choose>
                                                    <c:when test="${fn:contains(lecture.reg_method, '4')}">
                                                        외부홈페이지
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${lecture.status_code eq '1'}">접수대기</c:when>
                                                            <c:when test="${lecture.status_code eq '2'}">신청가능</c:when>
                                                            <c:when test="${lecture.status_code eq '3'}">대기신청</c:when>
                                                            <c:when test="${lecture.status_code eq '4'}">신청마감</c:when>
                                                            <c:when test="${lecture.status_code eq '5'}">교육전</c:when>
                                                            <c:when test="${lecture.status_code eq '6'}">교육중</c:when>
                                                            <c:when test="${lecture.status_code eq '7'}">교육종료</c:when>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </section>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="/ssem/youth/program/lecture_list.do?searchKind4=41" class="more_btn ani">+ 더보기</a>
                </div>
            </div>
            <form name="frm" id="frm" method="post" action="/ssem/youth/magnet/study_hope_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
            <div class="data_search mt_60 ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
                <div class="wrap">
                    <div class="row">
                        <div class="col_2 col_md_12 pl_10 pl_md_0 t_md_right">
                            <!--
                                sel_box select class="placeholder"
                                [option value= ""] placeholder 컬러
                            -->
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchKind" name="searchKind" title="검색조건" class="placeholder">
                                    <option value="ALL" <c:if test="${searchKind eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                    <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>희망강의명</option>
                                    <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>내용</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_10 col_md_12 pl_20 pr_10 pl_md_0 pr_md_0 mt_md_20 data_search_word_box">
                            <div class="fm_inp inp_full">
                                <input class="inp" name="searchVal" id="searchVal" title="검색어" placeholder="검색어를 입력하세요" value="${searchVal}">
                            </div>
                            <button type="submit" class="data_search_btn" id="btn_search">
                                <i class="icon_search">검색</i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            </form>
            <div class="wrap">
                <h4 class="tit2 mt_100 mb_40">배우고 싶어요</h4>
                <div class="info_tit wrap t_right fs_22">총 게시물 : <strong><fmt:formatNumber value="${totalCount}" pattern="##,###"/></strong>건</div>
                <div class="info_tit wrap t_left fs_22 mb_10">
                    <a href="/ssem/youth/magnet/study_hope_insert.do" class="btn btn_auto_2 t_center fs_auto btn_ex">글쓰기</a>
                </div>
                <div class="table_img_ul st_2 fs_18"> <!--table_img_ul-->
                    <ul>
                        <c:if test="${fn:length(itemList) == 0}">
                            <li>
                                <section>
                                    <!--data : s-->
                                    <div class="noDate t_center">
                                        <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                        <p  class="mt_30 fs_30"><span class="fw_600">‘배우고 싶어요’</span> 에 대한 검색결과가 없습니다.</p>
                                    </div>
                                    <!--data : e-->
                                </section>
                            </li>
                        </c:if>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <li>
                                <a href="/ssem/youth/magnet/study_hope_view.do?hope_study_idx=${item.hope_study_idx}">
                                    <section class="row">
                                        <div class="text_box col_12 fs_20 fs_md_24">
                                            <div class="text_top">
                                                <div class="plr_20 clearfix">
                                                    <ul class="category_list float_left">
                                                        <li>
                                                            <c:choose>
                                                                <c:when test="${item.close_yn eq 'Y'}">
                                                                    <b>종료</b>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <b>진행중</b>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </li>
                                                        <c:if test="${item.select_yn eq 'Y'}">
                                                            <li><b class="st_2">청원성공</b></li>
                                                        </c:if>
                                                    </ul>
                                                    <div class="dp_inb float_right">
                                                        <b class="dp_inb mr_20">청원기간</b>
                                                        <span class="tc_sub">${fn:substring(item.reg_dt, 0, 10)} ~ ${item.close_dt}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="text_con">
                                                <div class="plr_40 plr_md_20 pt_20 pt_md_40">
                                                    <div class="title ellip_1 fs_26 fs_md_28">${item.name}</div>
                                                    <p class="ellip_1 tc_sub fw_200 fs_md_24 mt_md_40">${item.cont}</p>
                                                </div>
                                            </div>
                                            <div class="text_bottom">
                                                <div class="plr_40 clearfix ">
                                                    <ul class="info_list fs_md_24 float_left">
                                                        <li><b>작성자</b> ${item.apy_name}</li>
                                                    </ul>
                                                    <div class="float_right">
                                                        <i class="icon_heart_line mr_5 va_m">하트</i>
                                                        <span class="dp_inb va_m mr_5">함께해요</span>
                                                        <span class="dp_inb va_m">${item.join_cnt}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div><!--table_img_ul-->
                <common:pageLink name="pageholder"/>
            </div>
        </section>
    </div>
</div>
