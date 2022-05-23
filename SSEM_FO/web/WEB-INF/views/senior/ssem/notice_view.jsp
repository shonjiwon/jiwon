<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '공지사항 > 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_11"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    송파쌤(SSEM)
                </h2>
                <p class="tit_sub">
                    <strong>“세상에서 가장 큰 학교”</strong>
                    송파에서 나고 자라고 완성되는 <br>창의적 인재육성
                </p>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">송파쌤</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">공지사항</a>
                        <ul>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/senior/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/senior/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/senior/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_80 tit font_sc mb_50">공지사항</h3>
        <div class="wrap text_con fs_20 fs_md_26 mt_50 mb_15 mb_100">
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="th wid_300">기관</div>
                        <div class="td">송파쌤</div>
                    </li>
                    <li class="table half col_65">
                        <div class="th wid_300">제목</div>
                        <div class="td">${bbsDetailVo.title}</div>
                    </li>
                    <li class="table half col_35">
                        <div class="th wid_200">조회수</div>
                        <div class="td"><fmt:formatNumber value="${bbsDetailVo.cnt}" pattern="##,###"/></div>
                    </li>
                    <li class="table half col_65">
                        <div class="th wid_300">작성자</div>
                        <div class="td">${bbsDetailVo.reg_nm}</div>
                    </li>
                    <li class="table half col_35">
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
                        <div class="td wid_full content_box">${bbsDetailVo.cont}</div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <ul class="table_list_ul prev_next_page_box fs_18 fs_md_24">
                <c:choose>
                    <c:when test="${bbsDetailVo.prev ne null}">
                        <li class="prev_box">
                            <a href="/ssem/senior/ssem/notice_view.do?bbs_detail_idx=${bbsDetailVo.prev.bbs_detail_idx}">
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
                            <a href="/ssem/senior/ssem/notice_view.do?bbs_detail_idx=${bbsDetailVo.next.bbs_detail_idx}">
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
                <a href="/ssem/senior/ssem/notice_list.do" class="btn btn_short t_center">목록</a>
            </div>
        </div>
    </div>
</div>
