<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-05
  Time: 오후 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '이메일주소 무단수집거부 > 잠실청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_13"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    이메일주소무단수집거부
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">이메일주소 무단수집거부</a>
                        <ul>
                            <li><a href="/ssem/jamsilcenter/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/jamsilcenter/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/jamsilcenter/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/jamsilcenter/main/terms.do">이용약관</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">이메일주소무단수집거부</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_18 fs_md_24 pb_100 mb_15">
            <div class="bg_color_2 t_center ptb_80 ptb_md_100 plr_50">
                <img src="/ssem/resources/img/sub/mail_img.jpg" alt="메일 검색" style="max-width: 12rem;">
                <p class="fs_24 fs_md_32 mt_20">이메일 무단수집 거부 정책</p>
                <p class="mt_10">
                    본 웹사이트에 게시된 이메일 주소가 전자우편수집 프로그램이나 그밖의 기술적장치를 이용하여 무단으로 수집되는 것을 거부하며, <br class="pc">
                    이를 위반시 정보통신망 이용촉진 및 정보보호등에 관한 법률에 의해 처벌 받을 수 있습니다.
                </p>
            </div>
        </div>
    </div>
</div>
