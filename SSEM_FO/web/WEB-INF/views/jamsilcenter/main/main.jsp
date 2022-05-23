<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오전 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '잠실청소년센터 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js
    });
</script>
<div class="contents" id="contents">
    <div class="main_visual mini_home_macheon"><!--mv_wrap--->
        <div class="mv">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <div class="mv_item">
                    <a href="${banner.link}" <c:if test="${banner.link_tgt eq 'N'}">target="_blank"</c:if>>
                    <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                        <img src="${item.file_src}" alt="${banner.alt_txt}">
                    </c:forEach>
                    <div class="mv_text_box lh_16">
                        <p class="mv_sub_tit fs_32 lh_12 font_sc fw_600">즐거움과 교육으로 변화하고 진화하는</p>
                        <h3 class="fs_56 font_sc">구립잠실청소년센터</h3>
                        <p class="fs_26 fs_md_28 mt_10">
                            제4차산업혁명을 토대로 청소년의 능동적인 <br>
                            참여 중심 프로그램과 체험적 삶의 교육으로 즐거움을 창조하며,<br>
                            미래를 열어가는 청소년의 성장을 지원하고 있습니다.
                        </p>
                    </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="mch_wrap">
        <div class="wrap por pt_100 pt_md_80"><!--program_box_wrap-->
            <h3 class="tit fw_600 font_dxlp"><span class=" dp_b fs_48 fs_md_50 lh_10">JAMSIL YOUTH CENTER</span></h3>
            <p class="tit_sub t_center mt_10 fw_200 fs_18 fs_md_30 wb_ka">제4차산업혁명을 토대로 청소년의 능동적인 참여 중심 프로그램과 <br>체험적 삶의 교육으로 즐거움을 창조하며, 미래를 열어가는 청소년의 성장을 지원하고 있습니다.</p>
            <div class="row maru_box mt_50 mt_md_30 mb_35">
                <div class="color_1 col_6 col_md_12 mb_md_40">
                    <!-- id : SSEM-C-01-02-01  -->
                    <a href="/ssem/jamsilcenter/intro/intro.do">
                        <section>
                            <div class="pi_img_box por">
                                <img src="/ssem/resources/img/main/jamsil/about_bg.jpg" alt="새싹 이미지">
                                <span class="img_tit poa fs_20 fs_md_30 fw_700 font_robo">ABOUT</span>
                            </div>
                            <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                                <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                    <span class="">잠실청소년센터란</span>
                                </h4>
                                <p class="pi_data fs_18 fs_md_26 fw_200 lh_16">
                                    청소년의 즐거움이 시작되는 구립잠실청소년센터는 소통과 신뢰를 통한<br>
                                    지역과의 동반성장으로 온 마을이 사랑하는 센터로 발돋움하고 있습니다.
                                </p>
                            </div>
                        </section>
                    </a>
                </div>
                <div class="color_1 col_6 col_md_12 mb_md_40">
                    <!-- id : SSEM-C-01-04-01  -->
                    <a href="/ssem/jamsilcenter/program/program_list.do">
                        <section>
                            <div class="pi_img_box por">
                                <img src="/ssem/resources/img/main/jamsil/program_bg.jpg" alt="책 안경 이미지">
                                <span class="img_tit poa fs_20 fs_md_30 fw_700 font_robo">PROGRAM</span>
                            </div>
                            <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                                <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                    <span class="">프로그램 신청</span>
                                </h4>
                                <p class="pi_data fs_18 fs_md_26 fw_200 lh_16">
                                    송파구 청소년과 지역주민 대상 잠청센 특화프로그램을<br>확인해보세요!
                                </p>
                            </div>

                        </section>
                    </a>
                </div>

                <!-- : e-->
            </div>
        </div><!-- e-->
    </div>
    <div class="mch_wrap_st2 pb_100 bg_color_2">
        <div class="wrap pt_100 fs_20 pb_30">
            <div class="row">
                <div class="col_6 col_md_12">
                    <div class="syc_img_box fs_18 fs_lg_16 fs_md_26 mt_80 mt_md_0">
                        <div class="table">
                            <div class="col">
                                <div class="bg_color_1 ptb_50">
                                    <a href="/ssem/jamsilcenter/biz/culture.do">
                                        <section>
                                            <img src="/ssem/resources/img/main/macheon/mb_img_01.png" alt="퍼즐" class="mb_20">
                                            <strong class="fs_28 fs_md_36">주요사업</strong>
                                            <p class="mt_20 fw_300">
                                                문화·교육·체육·상담<br class="screen_hide screen_md_show">·복지 등의<br class="screen_md_hide">통합적인 <br class="screen_hide screen_md_show">서비스를 제공합니다.
                                            </p>
                                        </section>
                                    </a>
                                </div>
                            </div>
                            <div class="col">
                                <div class="bg_color_1 ptb_50">
                                    <a href="/ssem/jamsilcenter/fac/intro.do">
                                        <section>
                                            <img src="/ssem/resources/img/main/macheon/mb_img_02.png" alt="검색" class="mb_20">
                                            <strong class="fs_28 fs_md_36">시설안내</strong>
                                            <p class="mt_20 fw_300">
                                                센터 내부의<br class="screen_hide screen_md_show"> 자세한<br class="screen_md_hide">시설안내를 <br class="screen_hide screen_md_show">보실 수 있습니다.
                                            </p>
                                        </section>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col_6 col_md_12 pt_md_50 pr_50 pr_md_0">
                    <div class="notice_list_box fs_20 fs_md_28">
                        <h3 class="fs_38 fs_md_48 mb_20">Notice</h3>
                        <ul>
                            <c:forEach items="${noticeList}" var="notice" varStatus="status">
                                <c:choose>
                                    <c:when test="${notice.p_top_yn eq 'Y'}">
                                        <li class="nlb_item">
                                            <a href="/ssem/youth/ssem/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                                                <section>
                                                    <div class="table">
                                                        <div class="col _mark"><span>전체<br>공개</span></div>
                                                        <div class="col _tit"><p class="ellip_1">${notice.title}</p></div>
                                                        <div class="col _date">${fn:substring(notice.reg_dt, 0, 10)}</div>
                                                    </div>
                                                </section>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="nlb_item">
                                            <a href="/ssem/jamsilcenter/news/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
                                                <section>
                                                    <div class="table">
                                                        <div class="col _tit"><p class="ellip_1">${notice.title}</p></div>
                                                        <div class="col _date">${fn:substring(notice.reg_dt, 0, 10)}</div>
                                                    </div>
                                                </section>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                        <a href="/ssem/jamsilcenter/news/notice_list.do" class="more_btn"><i class="icon_more">more</i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
