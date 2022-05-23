<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 4:09
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
        $(document).prop('title', '갤러리 > 송파혁신교육지구 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

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
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_6"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    송파혁신교육지구
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
                        <a href="#" class="deapth_tit" title="선택">송파혁신교육지구</a>
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
                        <a href="#" class="deapth_tit" title="선택">주요사업안내</a>
                        <ul>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_vision.do">운영비전</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_biz.do">주요사업안내</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_group.do">네트워크 구성 및 조직도</a></li>
                            <li class="tab_item"><a href="/ssem/youth/campus/songpa_gallery_list.do">갤러리</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">송파혁신교육지구</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">갤러리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab st_2 tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_vision.do">운영비전</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_biz.do">주요사업안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/songpa_group.do">네트워크 구성 및 조직도</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/songpa_gallery_list.do" title="선택">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">갤러리</h4>
        <form name="frm" id="frm" method="post" action="/ssem/youth/campus/songpa_gallery_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24"><!--Data Search-->
            <div class="wrap">
                <div class="row">
                    <div class="col_2 col_md_12 pl_30 pl_md_0 col_half t_md_right">
                        <!--
                            sel_box select class="placeholder"
                            [option value= ""] placeholder 컬러
                        -->
                        <div class="sel_box sel_full sel_md_short">
                            <select name="searchKind4" id="searchKind4" title="검색조건" class="placeholder">
                                <option value="ALL" <c:if test="${searchKind4 eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                <option value="1" <c:if test="${searchKind4 eq '1'}">selected="selected"</c:if>>제목</option>
                                <option value="3" <c:if test="${searchKind4 eq '3'}">selected="selected"</c:if>>내용</option>
                            </select>
                        </div>
                    </div>
                    <div class="col_10 col_md_12 pl_20 pr_30 pl_md_0 pr_md_0  mt_md_25">
                        <div class="data_search_word_box">
                            <div class="fm_inp inp_full">
                                <input class="inp" name="searchVal" id="searchVal" value="${searchVal}" title="검색어">
                            </div>
                            <button type="submit" class="data_search_btn" id="btn_search">
                                <i class="icon_search">검색</i>
                            </button>
                        </div>
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
                                <p  class="mt_30 fs_30"><span class="fw_600">‘갤러리’</span> 에 대한 검색결과가 없습니다.</p>
                            </div>
                            <!--data : e-->
                        </div>
                    </c:if>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <div class="img_list_item color_1 col_3 col_lg_4 col_sm_6">
                            <a href="/ssem/youth/campus/songpa_gallery_view.do?bbs_detail_idx=${item.bbs_detail_idx}">
                                <section>
                                    <div class="img_box">
                                        <c:forEach items="${item.thumbFileList}" var="thumb" varStatus="status">
                                            <img src="${thumb.file_src}" alt="${item.alt_txt}">
                                        </c:forEach>
                                    </div>
                                    <div class="text_box">
                                        <h4 class="_tit">
                                            <span class="ellip_1">${item.title}</span>
                                        </h4>
                                        <div class="item_bottom">
                                            <div class="clearfix">
                                                <span class="float_left fw_200"><span class="fw_500 tc_b mr_10">등록일 </span>  ${fn:substring(item.reg_dt, 0, 10)}</span>
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
