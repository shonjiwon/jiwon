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
        $(document).prop('title', '저작권정책 > 송파청소년센터 > 송파쌤');

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
                    저작권정책
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
                        <a href="#" class="deapth_tit" title="선택">저작권정책</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/songpacenter/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/songpacenter/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/songpacenter/main/terms.do">이용약관</a></li>
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
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">저작권정책</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 pb_100 mb_15">
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p >저작권법 제24조의2(공공저작물의 자유이용)에 따라 송파구청 누리집(홈페이지)에서 제공하는 자료 중에서 송파구가 저작재산권의 전부를 보유한 저작물의 경우에는 별도의 이용허락 없이 자유이용이 가능합니다.</p>
                    <p class="mt_10">단, 위 규정에 따라 자유이용이 가능한 자료는 “공공저작물 자유이용허락표시기준(공공누리, KOGL) 제1유형”을 부착하여 개방하고 있으므로 공공누리 표시가 부착된 저작물인지를 확인한 이후에 자유롭게 이용하시기 바랍니다.</p>
                    <p class="mt_10">자유이용의 경우, 이용자께서는 반드시 저작물의 출처(저작물의 작성연도, 작성기관명, 누리집 주소, 작성자명)를 표시하여야 합니다.</p>
                    <p class="mt_10">공공누리가 부착되지 않은 자료들을 이용하고자 할 경우에는 공공저작물 관리책임자 및 실무담당자와 사전에 협의한 이후에 이용하여 주시기 바랍니다.</p>
                </div>
            </div>
            <p class="mt_25">공공저작물 관리책임자: 문화체육과장 김기범(02-2147-2803)</p>
            <p class="mt_5">공공저작물 실무담당자: 문화체육과 김도연 주무관(02-2147-2829)</p>
            <div class="btn_box t_center mt_50">
                <a href="http://www.law.go.kr/LSW/lsSc.do?query=%EC%A0%80%EC%9E%91%EA%B6%8C%EB%B2%95" target="_blank" class="btn bnt_round  btn_color_1">저작권법 자세히 보기</a>
                <a href="http://www.kogl.or.kr/index.do" target="_blank" class="btn bnt_round  btn_color_1">공공누리 바로가기</a>
            </div>
        </div>
    </div>
</div>
