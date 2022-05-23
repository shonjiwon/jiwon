<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오후 3:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '갤러리 > 꿈마루 소식 > 송파진로직업체험지원센터 > 온라인 캠퍼스 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual mr_st_4"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    꿈마루 소식
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">꿈마루 소식</a>
                        <ul>
                            <li><a href="/ssem/dream/dream/intro.do">꿈마루</a></li>
                            <li><a href="/ssem/dream/together/experience.do">가치, 같이 함께 해주세요</a></li>
                            <li><a href="/ssem/dream/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/dream/news/notice_list.do">꿈마루 소식</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">갤러리</a>
                        <ul>
                            <li><a href="/ssem/dream/news/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/dream/news/broad_list.do">보도자료</a></li>
                            <li><a href="/ssem/dream/news/gallery_list.do">갤러리</a></li>
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
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">갤러리<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/dream/news/notice_list.do">공지사항</a></li>
                <li class="tab_item"><a href="/ssem/dream/news/broad_list.do">보도자료</a></li>
                <li class="tab_item on"><a href="/ssem/dream/news/gallery_list.do" title="선택">갤러리</a></li>
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
                            <a href="/ssem/dream/news/gallery_view.do?bbs_detail_idx=${bbsDetailVo.prev.bbs_detail_idx}">
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
                            <a href="/ssem/dream/news/gallery_view.do?bbs_detail_idx=${bbsDetailVo.next.bbs_detail_idx}">
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
                <a href="/ssem/dream/news/gallery_list.do" class="btn btn_short t_center">목록</a>
            </div>
        </div>
    </div>
</div>
