<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:06
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
        $(document).prop('title', '악기대여 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js
        uiInti();       //ui.js

        svsw_img_box();

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
        let frm = document.frm;
        $("#page").val("1");
        $("#frm").submit();
    }

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
                        <a href="#" class="deapth_tit" title="선택">악기대여</a>
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
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_rental_list.do" title="선택">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">악기대여</h4>
        <form name="frm" id="frm" method="post" action="/ssem/youth/campus/instrum_lib_rental_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <div class="wrap">
                <div class="row">
                    <div class="col_2 col_md_6 pr_10 t_md_right">
                        <!--
                            sel_box select class="placeholder"
                            [option value= ""] placeholder 컬러
                        -->
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchKind" name="searchKind" title="악기유형 조건" class="placeholder">
                                <option value="">악기유형</option>
                                <option value="A" <c:if test="${searchKind eq 'A'}">selected="selected"</c:if>>건반악기</option>
                                <option value="B" <c:if test="${searchKind eq 'B'}">selected="selected"</c:if>>관악기</option>
                                <option value="C" <c:if test="${searchKind eq 'C'}">selected="selected"</c:if>>타악기</option>
                                <option value="D" <c:if test="${searchKind eq 'D'}">selected="selected"</c:if>>현악기</option>
                                <option value="E" <c:if test="${searchKind eq 'E'}">selected="selected"</c:if>>MIDI장비</option>
                                <option value="K" <c:if test="${searchKind eq 'K'}">selected="selected"</c:if>>국악기</option>
                                <option value="Z" <c:if test="${searchKind eq 'Z'}">selected="selected"</c:if>>기타</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_2 col_md_6 pl_10 t_md_right">
                        <!--
                            sel_box select class="placeholder"
                            [option value= ""] placeholder 컬러
                        -->
                        <div class="sel_box sel_full sel_md_short">
                            <select id="searchKind3" name="searchKind3" title="검색조건" class="placeholder">
                                <option value="ALL" <c:if test="${searchKind3 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                <option value="1" <c:if test="${searchKind3 eq '1'}">selected="selected"</c:if>>악기명</option>
                                <option value="2" <c:if test="${searchKind3 eq '2'}">selected="selected"</c:if>>내용</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_8 col_md_12 pl_20 pl_md_0 mt_md_25 data_search_word_box">
                        <div class="fm_inp inp_full">
                            <input class="inp" id="searchVal" name="searchVal" title="검색어" placeholder="검색어 입력" value="${searchVal}">
                        </div>
                        <button href="#none" class="data_search_btn" id="btn_search">
                            <i class="icon_search">검색</i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <div class="img_list_wrap st_2"><!--img_list_wrap-->
            <div class="wrap">
                <div class="img_list_box row mt_25 mt_md_30 pt_10">
                    <c:if test="${fn:length(itemList) == 0}">
                        <div class="img_list_item color_1 col_12">
                            <!--data : s-->
                            <div class="noDate t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘악기대여’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </div>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <!--img_list_item-->
                        <div class="img_list_item color_1 col_3 col_lg_4 col_sm_6">
                            <a href="/ssem/youth/campus/instrum_lib_rental_view.do?instrum_idx=${item.instrum_idx}">
                                <section>
                                    <div class="img_box">
                                        <c:forEach items="${item.fileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                    </div>
                                    <div class="text_box">
                                        <div class="catalogue_box">
                                            <span class="item">
                                                <c:choose>
                                                    <c:when test="${item.gubun eq 'A'}">건반악기</c:when>
                                                    <c:when test="${item.gubun eq 'B'}">관악기</c:when>
                                                    <c:when test="${item.gubun eq 'C'}">타악기</c:when>
                                                    <c:when test="${item.gubun eq 'D'}">현악기</c:when>
                                                    <c:when test="${item.gubun eq 'E'}">MIDI장비</c:when>
                                                    <c:when test="${item.gubun eq 'K'}">국악기</c:when>
                                                    <c:when test="${item.gubun eq 'Z'}">기타</c:when>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <h4 class="_tit">
                                            <span class="ellip_1">${item.name}</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <div class="clearfix">
                                                <span class="float_left fw_200">
                                                    <span class="fw_500 tc_b mr_10">남은 수량 </span>  <c:out value="${item.qty - item.rental_qty}" />개
                                                    /
                                                    ${item.qty}개
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div><!--img_list_wrap : e-->
        <common:pageLink name="pageholder"/>
    </div>
</div>
