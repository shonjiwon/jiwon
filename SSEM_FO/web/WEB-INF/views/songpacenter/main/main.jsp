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
        $(document).prop('title', '송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js
    });
</script>
<div class="contents" id="contents">
    <div class="main_visual mini_home_youth"><!--mv_wrap--->
        <div class="mv">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <div class="mv_item">
                    <a href="${banner.link}" <c:if test="${banner.link_tgt eq 'N'}">target="_blank"</c:if>>
                    <c:forEach items="${banner.fileList}" var="item" varStatus="status">
                        <img src="${item.file_src}" alt="${banner.alt_txt}">
                    </c:forEach>
                    <div class="mv_text_box lh_16 ">
                        <h3 class="mv_sub_tit fs_60 fs_md_76 lh_12 font_robo">HAPPY YOUTH<br>SOECIAL SONGPA</h3>
                        <p class="fs_26 fs_md_28 mt_10">청소년과 함께하는 청소년행복특별도시 송파</p>
                    </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div><!--mv_wrap : e-->
    <!--program_item-->
    <!---
    program_item color class
    창의융합교육  : color_1
    인물도서관    : color_2
    창의융합교육  : color_3
    자기주도학습관 : color_4
    악기도서관    : color_5
    -->
    <div class="syc_wrap">
        <div class="wrap por pt_100 pt_md_80"><!--program_box_wrap-->
            <h3 class="tit fw_600 font_dxlp"><span class=" dp_b fs_48 fs_md_50 lh_10">SONGPA YOUTH CENTER</span></h3>
            <p class="tit_sub t_center mt_10 fw_200 fs_18 fs_md_30 wb_ka">청소년들에게 작은 날갯짓이 되고자 합니다.</p>
            <div class="row maru_box mt_50 mt_md_30 mb_35">
                <div class="color_1 col_6 col_md_12 mb_md_40">
                    <!-- id : SSEM-C-01-02-01  -->
                    <a href="/ssem/songpacenter/intro/intro.do">
                        <section>
                            <div class="pi_img_box por">
                                <img src="/ssem/resources/img/main/youth/about_bg.jpg" alt="책이미지">
                                <span class="img_tit poa fs_20 fs_md_30 fw_700 font_robo"><span class="tc_w">ABOUT</span></span>
                            </div>
                            <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                                <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                    <span class="">송파청소년센터를 소개합니다!</span>
                                </h4>
                            </div>
                        </section>
                    </a>
                </div>
                <div class="color_1 col_6 col_md_12 mb_md_40">
                    <!-- id : SSEM-C-01-04-01  -->
                    <a href="/ssem/songpacenter/program/program_list.do">
                        <section>
                            <div class="pi_img_box por">
                                <img src="/ssem/resources/img/main/youth/program_bg.jpg" alt="책위에 사과이미지">
                                <span class="img_tit poa fs_20 fs_md_30 fw_700 font_robo"><span class="tc_w">PROGRAM</span></span>
                            </div>
                            <div class="pi_text_box ptb_40 plr_40 ptb_md_40 plr_md_20">
                                <h4 class="pi_tit fs_26 fs_md_36 mb_10">
                                    <span class="">프로그램 신청하실 분들은 클릭!</span>
                                </h4>
                            </div>
                        </section>
                    </a>
                </div>
                <!-- : e-->
            </div>
        </div><!-- e-->
    </div>
    <div class="syc_wrap_st2 mb_100">
        <h2 class="fs_90 tc_w lh_10">SONGPA YOUTH CENTER</h2>
        <div class="wrap fs_20 pb_30">
            <div class="row">
                <div class="col_6">
                    <div class="syc_img_box fs_18 fs_lg_16 fs_md_26">
                        <div class="table">
                            <div class="col">
                                <a href="/ssem/songpacenter/biz/youth.do">
                                    <section>
                                        <img src="/ssem/resources/img/main/youth/mb_img_01.png" alt="퍼즐">
                                        <strong class="fs_28 fs_md_36">주요사업</strong>
                                        <p class="mt_20 fw_300">
                                            문화·교육·체육·상담<br class="screen_hide screen_md_show">·복지 등의<br class="screen_md_hide">통합적인 <br class="screen_hide screen_md_show">서비스를 제공합니다.
                                        </p>
                                    </section>
                                </a>
                            </div>
                            <div class="col">
                                <a href="/ssem/songpacenter/place/intro.do">
                                    <section>
                                        <img src="/ssem/resources/img/main/youth/mb_img_02.png" alt="검색">
                                        <strong class="fs_28 fs_md_36">시설안내</strong>
                                        <p class="mt_20 fw_300">
                                            센터 내부의<br class="screen_hide screen_md_show"> 자세한<br class="screen_md_hide">시설안내를 <br class="screen_hide screen_md_show">보실 수 있습니다.
                                        </p>
                                    </section>
                                </a>
                            </div>
                            <!-- 2020.10.27 수정 : e -->
                        </div>
                    </div>
                </div>
                <div class="col_6 pr_50 pr_md_0">
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
                                        <a href="/ssem/songpacenter/news/notice_view.do?bbs_detail_idx=${notice.bbs_detail_idx}">
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
                        <a href="/ssem/songpacenter/news/notice_list.do" class="more_btn"><i class="icon_more">more</i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
