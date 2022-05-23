<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 6:24
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
        $(document).prop('title', '프로그램 신청 > 미래교육센터 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        svsw_img_box();

        subInit()       //sub.js
        tableMoHtmlInit('#moTable') //sub.js ul 태그만 모바일용 태그 생성;

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

        if(frm.searchSDate.value > frm.searchEDate.value) {
            modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
            return false;
        }

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
    <div class="sub_visual st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    미래교육센터
                </h2>
                <p class="tit_sub">
                    <strong>“AI코딩, VR, 드론, 미디어, 글로벌 토론”</strong>
                    창의적 문제해결능력과 글로벌 리더십을 가진 <br class="screen_hide screen_sm_show">미래융합 인재를 양성합니다.<br>
                    송파쌤 미래교육센터는 현재 7관까지 조성&middot;운영하고 있습니다
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
                        <a href="#" class="deapth_tit" title="선택">미래교육센터</a>
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
                        <a href="#" class="deapth_tit" title="선택">프로그램 신청</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                            <li><a href="/ssem/youth/campus/future_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
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
    <div class="sub_con st_3"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">미래교육센터</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">프로그램 신청<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/future_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_drone.do">송파쌤 드론스쿨</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/future_program_list.do" title="선택">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/future_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">프로그램 신청</h4>
        <form name="frm" id="frm" method="post" action="/ssem/youth/campus/future_program_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
            <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
                <div class="wrap_1250">
                    <div class="row row_p_10">
                        <div class="col_3 col_md_6 pr_md_10">
                            <!--
                                sel_box select class="placeholder"
                                [option value= ""] placeholder 컬러
                            -->
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchVal8" id="searchVal8" title="교육대상" class="placeholder">
                                    <option value="">교육대상 선택</option>
                                    <c:forEach items="${tgtList}" var="tgt" varStatus="status">
                                        <option value="${tgt.code_idx}" <c:if test="${searchVal8 eq tgt.code_idx}">selected="selected"</c:if>>${tgt.cd_val}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col_3 col_md_6 pl_md_10">
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchVal6" name="searchVal6" title="교육분야" class="placeholder">
                                    <option value="">교육분야 선택</option>
                                    <c:forEach items="${codeList}" var="code" varStatus="status">
                                        <option value="${code.code_idx}" <c:if test="${searchVal6 eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col_3 col_md_6 mt_md_20 pr_md_10">
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchVal2" name="searchVal2" title="수강료" class="placeholder">
                                    <option value="">수강료 선택</option>
                                    <option value="S" <c:if test="${searchVal2 eq 'S'}">selected="selected"</c:if>>유료</option>
                                    <option value="F" <c:if test="${searchVal2 eq 'F'}">selected="selected"</c:if>>무료</option>
                                </select>
                            </div>
                        </div>

                        <div class="col_3 col_md_6 mt_md_20 pl_md_10">
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchVal5" name="searchVal5" title="정보화 교육 여부" class="placeholder">
                                    <option value="">정보화 교육 여부 선택</option>
                                    <option value="Y" <c:if test="${searchVal5 eq 'Y'}">selected="selected"</c:if>>예</option>
                                    <option value="N" <c:if test="${searchVal5 eq 'N'}">selected="selected"</c:if>>아니오</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row row_p_10">
                        <div class="col_3 col_md_12 ">
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchVal7" name="searchVal7" title="접수상태" class="placeholder">
                                    <option value="">접수상태 선택</option>
                                    <option value="1" <c:if test="${searchVal7 eq '1'}">selected="selected"</c:if>>접수대기</option>
                                    <option value="2" <c:if test="${searchVal7 eq '2'}">selected="selected"</c:if>>신청가능</option>
                                    <option value="8" <c:if test="${searchVal7 eq '8'}">selected="selected"</c:if>>대기신청</option>
                                    <option value="3" <c:if test="${searchVal7 eq '3'}">selected="selected"</c:if>>신청마감</option>
                                    <option value="4" <c:if test="${searchVal7 eq '4'}">selected="selected"</c:if>>교육전</option>
                                    <option value="5" <c:if test="${searchVal7 eq '5'}">selected="selected"</c:if>>교육중</option>
                                    <option value="6" <c:if test="${searchVal7 eq '6'}">selected="selected"</c:if>>교육종료</option>
                                    <option value="7" <c:if test="${searchVal7 eq '7'}">selected="selected"</c:if>>외부홈페이지</option>
                                </select>
                            </div>
                        </div>

                        <div class="col_9 col_md_12 mt_md_20">
                            <div class="row_24 row_p_10">
                                <div class="col_7 offset_2 offset_md_0">
                                    <div class="sel_box sel_full sel_md_short">
                                        <select id="searchKind2" name="searchKind2" title="기간" class="placeholder">
                                            <option value="">기간선택</option>
                                            <option value="ALL">전체</option>
                                            <option value="1" <c:if test="${searchKind2 eq '1'}">selected="selected"</c:if>>교육기간</option>
                                            <option value="2" <c:if test="${searchKind2 eq '2'}">selected="selected"</c:if>>접수기간</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col_7 col_md_8">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchSDate" name="searchSDate" title="시작일" value="${searchSDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col_1">
                                    <div class="dash">~</div>
                                </div>
                                <div class="col_7 col_md_8">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchEDate" name="searchEDate" title="종료일" value="${searchEDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row row_p_10">
                        <div class="col_12 mt_md_25 data_search_word_box">
                            <div class="fm_inp inp_full">
                                <input class="inp" title="검색어" placeholder="프로그램명 또는 강사명으로 검색하세요." id="searchVal" name="searchVal" value="${searchVal}">
                            </div>
                            <button type="button" class="data_search_btn" id="btn_search">
                                <i class="icon_search">검색</i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="wrap">
            <div class="list_box_wrap_v_2"><!--list_box_wrap-->
                <div class="list_box row mt_25 mt_md_30 pt_10">
                    <c:if test="${fn:length(itemList) == 0}">
                        <div class="img_list_item color_1 col_12">
                            <!--data : s-->
                            <div class="noDate t_center">
                                <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                <p  class="mt_30 fs_30"><span class="fw_600">‘프로그램 신청’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </div>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <div class="list_item col_3 col_lg_4 col_sm_6">
                            <a href="/ssem/youth/campus/future_program_view.do?lecture_idx=${item.lecture_idx}">
                                <section>
                                    <div class="img_box">
                                        <c:if test="${item.closing_yn eq 'Y'}">
                                            <div class="marker_box">
                                            <span class="marker">
                                                <span>마감 임박</span>
                                            </span>
                                            </div>
                                        </c:if>
                                        <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                        <div class="like_box fs_18 fs_sm_24 _act">
                                            <i class="icon_heart_w mr_5" title="활성화">하트</i> <span>${item.love_cnt}</span>
                                        </div>
                                    </div>
                                    <div class="text_box">
                                        <div class="cl_box">
                                            <span class="cl_tit">교육대상</span><br>
                                            <div class="catalogue_box">
                                                <c:set var="list_cnt" value="0"/>
                                                <c:forEach items="${item.array_tgt}" var="tgt" varStatus="status">
                                                    <c:set var="list_cnt">${list_cnt + 1}</c:set>
                                                    <c:if test="${status.count < 3}">
                                                        <span class="item">${tgt}</span>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${list_cnt > 2}">
                                                <span class="more">
													<span>+${list_cnt - 2}</span>
												</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="cl_box">
                                            <span class="cl_tit">교육분야</span><br>
                                            <div class="catalogue_box">
                                                <span class="item">${item.part_name}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item_bottom">
                                        <h4 class="_tit"><span class="ellip_1">${item.name}</span></h4>
                                        <p class="fw_300"><b class="fw_500 mr_5">교육기간</b> <span>${fn:substring(item.start_dt, 2, 10)} ~ ${fn:substring(item.end_dt, 2, 10)}</span></p>
                                        <p class="fw_300"><b class="fw_500 mr_5">접수기간</b> <span>${fn:substring(item.reg_start_st, 2, 10)} ~ ${fn:substring(item.reg_end_dt, 2, 10)}</span></p>
                                    </div>
                                </section>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div><!--list_box_wrap : e-->
        </div>
        <common:pageLink name="pageholder"/>
    </div>
</div>
