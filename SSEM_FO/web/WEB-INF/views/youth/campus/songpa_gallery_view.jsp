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
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '갤러리 > 송파혁신교육지구 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤
    });
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
        <div class="wrap">
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table half">
                        <div class="th wid_300">제목</div>
                        <div class="td">${bbsDetailVo.title}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_200">조회수</div>
                        <div class="td"><fmt:formatNumber value="${bbsDetailVo.cnt}" pattern="##,###"/></div>
                    </li>
                    <li class="table half">
                        <div class="th wid_300">글쓴이</div>
                        <div class="td">${bbsDetailVo.reg_nm}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_200">작성일</div>
                        <div class="td">${fn:substring(bbsDetailVo.reg_dt, 0, 16)}</div>
                    </li>
                    <li class="table">
                        <div class="th wid_300">첨부파일</div>
                        <div class="td">
                            <c:forEach items="${bbsDetailVo.fileList}" var="item" varStatus="status">
                                <c:if test="${item != null}">
                                    <a class="link_down" title="파일 다운로드" href="/ssem/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </li>
                    <li class="table">
                        <div class="th wid_300">동영상URL</div>
                        <div class="td">
                            <c:if test="${bbsDetailVo.movie_url ne null && bbsDetailVo.movie_url ne ''}">
                                <a class="btn btn_small btn_color_1" title="새창" href="${bbsDetailVo.movie_url}" target="_blank">영상 보러가기</a>
                            </c:if>
                        </div>
                    </li>
                    <li class="table">
                        <div class="td wid_full content_box big_h">
                            ${bbsDetailVo.cont}
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <ul class="table_list_ul prev_next_page_box fs_18 fs_md_24">
                <c:choose>
                    <c:when test="${bbsDetailVo.prev ne null}">
                        <li class="prev_box">
                            <a href="/ssem/youth/campus/songpa_gallery_view.do?bbs_detail_idx=${bbsDetailVo.prev.bbs_detail_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_prev_bk">이전</i><span class="screen_md_hide">이전글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${bbsDetailVo.prev.title}</p></div>
                                    <div class="col wid_100 t_left">${bbsDetailVo.prev.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(bbsDetailVo.prev.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${bbsDetailVo.next ne null}">
                        <li class="next_box">
                            <a href="/ssem/youth/campus/songpa_gallery_view.do?bbs_detail_idx=${bbsDetailVo.next.bbs_detail_idx}">
                                <section class="table">
                                    <div class="col"><i class="icon_next_bk">다음</i><span class="screen_md_hide">다음글</span></div>
                                    <div class="col t_left"><p class="table_tit ellip_1">${bbsDetailVo.next.title}</p></div>
                                    <div class="col wid_100 t_left">${bbsDetailVo.next.reg_nm}</div>
                                    <div class="col wid_170 wid_md_200 t_left">${fn:substring(bbsDetailVo.next.reg_dt, 0, 16)}</div>
                                </section>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="btn_box mt_50 mb_100 pb_30 t_right t_md_center">
                <a href="/ssem/youth/campus/songpa_gallery_list.do" class="btn btn_short t_center">목록</a>
            </div>
        </div>
    </div>
</div>
