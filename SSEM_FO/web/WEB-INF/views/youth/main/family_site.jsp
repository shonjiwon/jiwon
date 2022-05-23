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
        $(document).prop('title', '패밀리사이트 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_16"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    패밀리사이트
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
                        <a href="#" class="deapth_tit" title="선택">패밀리사이트</a>
                        <ul>
                            <li><a href="/ssem/youth/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/youth/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/youth/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/youth/main/terms.do">이용약관</a></li>
                            <li><a href="/ssem/youth/main/sitemap.do">사이트맵</a></li>
                            <li><a href="/ssem/youth/main/family_site.do">패밀리사이트</a></li>
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
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">패밀리사이트</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_18 fs_md_24 pb_100 mb_15">
            <div class="familysite_box">
                <div>
                    <div class="fsb_title">동 주민센터</div>
                    <div>
                        <ul class="ul_list_dot">
                            <li><a href="http://www.songpa.go.kr/garak1/" class="export_link" target="_blank">가락1동</a></li>
                            <li><a href="http://www.songpa.go.kr/garak2/" class="export_link" target="_blank">가락2동</a></li>
                            <li><a href="http://www.songpa.go.kr/garakbon/" class="export_link" target="_blank">가락본동</a></li>
                            <li><a href="http://www.songpa.go.kr/geoyeo1/" class="export_link" target="_blank">거여1동</a></li>
                            <li><a href="http://www.songpa.go.kr/geoyeo2/" class="export_link" target="_blank">거여2동</a></li>
                            <li><a href="http://www.songpa.go.kr/macheon1/" class="export_link" target="_blank">마천1동</a></li>
                            <li><a href="http://www.songpa.go.kr/macheon2/" class="export_link" target="_blank">마천2동</a></li>
                            <li><a href="http://www.songpa.go.kr/munjeong1/" class="export_link" target="_blank">문정1동</a></li>
                            <li><a href="http://www.songpa.go.kr/munjeong2/" class="export_link" target="_blank">문정2동</a></li>
                            <li><a href="http://www.songpa.go.kr/bangi1/" class="export_link" target="_blank">방이1동</a></li>
                            <li><a href="http://www.songpa.go.kr/bangi2/" class="export_link" target="_blank">방이2동</a></li>
                            <li><a href="http://www.songpa.go.kr/samjeon/" class="export_link" target="_blank">삼전동</a></li>
                            <li><a href="http://www.songpa.go.kr/seokchon/" class="export_link" target="_blank">석촌동</a></li>
                            <li><a href="http://www.songpa.go.kr/songpa1/" class="export_link" target="_blank">송파1동</a></li>
                            <li><a href="http://www.songpa.go.kr/songpa2/" class="export_link" target="_blank">송파2동</a></li>
                            <li><a href="http://www.songpa.go.kr/ogeum/" class="export_link" target="_blank">오금동</a></li>
                            <li><a href="http://www.songpa.go.kr/oryun/" class="export_link" target="_blank">오륜동</a></li>
                            <li><a href="http://www.songpa.go.kr/wirye/" class="export_link" target="_blank">위례동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsil2/" class="export_link" target="_blank">잠실2동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsil3/" class="export_link" target="_blank">잠실3동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsil4/" class="export_link" target="_blank">잠실4동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsil6/" class="export_link" target="_blank">잠실6동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsil7/" class="export_link" target="_blank">잠실7동</a></li>
                            <li><a href="http://www.songpa.go.kr/jamsilbon/" class="export_link" target="_blank">잠실본동</a></li>
                            <li><a href="http://www.songpa.go.kr/jangji/" class="export_link" target="_blank">장지동</a></li>
                            <li><a href="http://www.songpa.go.kr/pungnap1/" class="export_link" target="_blank">풍납1동</a></li>
                            <li><a href="http://www.songpa.go.kr/pungnap2/" class="export_link" target="_blank">풍납2동</a></li>
                        </ul>
                    </div>
                </div>
                <div>
                    <div class="fsb_title">주요 사이트</div>
                    <div>
                        <ul class="ul_list_dot">
                            <li><a href="https://www.songpa.go.kr/" class="export_link" target="_blank">송파구청</a></li>
                            <li><a href="https://www.songpa.go.kr/user.kdf?a=songpa.menu.MenuApp&c=1001&cate_id=AM0201001000" class="export_link" target="_blank">한성백제</a></li>
                            <li><a href="http://www.songpa.go.kr/culture/" class="export_link" target="_blank">문화관광</a></li>
                            <%--<li><a href="http://www.songpa.tv" class="export_link" target="_blank">송파TV</a></li>--%>
                            <li><a href="http://job.seoul.go.kr/songpa/Main.do?method=getMain" class="export_link" target="_blank">일자리센터</a></li>
                            <li><a href="http://www.songpa.go.kr/child/" class="export_link" target="_blank">송파꿈나무</a></li>
                            <li><a href="http://land.songpa.go.kr" class="export_link" target="_blank">부동산포털</a></li>
                            <li><a href="https://www.songpa.go.kr/user.kdf?a=songpa.menu.MenuApp&c=1001&cate_id=AM0311001000" class="export_link" target="_blank">송파둘레길</a></li>
                            <li><a href="http://www.songpa.go.kr/lang.jsp?sub=speec1" class="export_link" target="_blank">원어민화상영어(예일이러닝)</a></li>
                            <li><a href="http://www.spenglish.co.kr" class="export_link" target="_blank">원어민화상영어(건우애듀)</a></li>
                            <%--<li><a href="http://cafe.songpa.go.kr" class="export_link" target="_blank">커뮤니티</a></li>
                            <li><a href="http://u-work.songpa.go.kr/uconst/" class="export_link" target="_blank">공사장현장관리</a></li>
                            <li><a href="http://u-work.songpa.go.kr/uconst/findFlawMendngMainList.do" class="export_link" target="_blank">하자보증보험증권 열람</a></li>--%>
                            <li><a href="http://etax.seoul.go.kr/" class="export_link" target="_blank">서울시Etax</a></li>
                            <li><a href="http://songpa.rtms.seoul.go.kr/" class="export_link" target="_blank">부동산거래관리시스템</a></li>
                            <li><a href="https://www.laiis.go.kr/lips/nya/lrn/localRegulationList.do" class="export_link" target="_blank">중앙부처 법령유권해석</a></li>
                            <li><a href="http://traffic.songpa.go.kr/" class="export_link" target="_blank">주정차 단속조회 민원시스템</a></li>
                            <li><a href="http://bid.songpa.go.kr/" class="export_link" target="_blank">계약정보공개시스템</a></li>
                            <li><a href="http://www.minwon.go.kr" class="export_link" target="_blank">민원24</a></li>
                            <li><a href="http://www.songpa.go.kr/map/index.jsp" class="export_link" target="_blank">송파지도</a></li>
                            <li><a href="https://yeyak.seoul.go.kr/web/main.do"  class="export_link" target="_blank">서울시 공공서비스 예약</a></li>
                        </ul>
                    </div>
                </div>
                <div>
                    <div class="fsb_title">관내 주요기관</div>
                    <div>
                        <ul class="ul_list_dot">
                            <li><a href="http://council.songpa.go.kr" class="export_link" target="_blank">송파구의회</a></li>
                            <li><a href="http://ehealth.songpa.go.kr/" class="export_link" target="_blank">송파구보건소</a></li>
                            <li><a href="http://www.songpa.go.kr/gumin/index.jsp" class="export_link" target="_blank">송파구 구민회관</a></li>
                            <li><a href="http://www.acrc.go.kr/acrc/index.jsp?menuID=010501" class="export_link" target="_blank">국민권익위원회</a></li>
                            <li><a href="http://su.nec.go.kr/su/sp/sub1.jsp" class="export_link" target="_blank">송파구선거관리위원회</a></li>
                            <li><a href="http://www.songpagongdan.or.kr" class="export_link" target="_blank">송파구시설관리공단</a></li>
                            <li><a href="http://www.esongpa.or.kr" class="export_link" target="_blank">송파구체육문화회관</a></li>
                            <li><a href="http://www.songpawoman.org" class="export_link" target="_blank">송파구여성문화회관</a></li>
                            <li><a href="http://songpakids.com/" class="export_link" target="_blank">송파구어린이문화회관</a></li>
                            <li><a href="http://www.spcc.or.kr" class="export_link" target="_blank">송파구문화원</a></li>
                            <li><a href="http://songpa-gu.seoulcci.korcham.net" class="export_link" target="_blank">송파구상공회</a></li>
                            <li><a href="http://s.nts.go.kr/sp/" class="export_link" target="_blank">송파구세무서</a></li>
                            <li><a href="http://www.smpa.go.kr/sp/" class="export_link" target="_blank">송파구경찰서</a></li>
                            <li><a href="http://fire.seoul.go.kr/songpa/" class="export_link" target="_blank">송파소방서</a></li>
                            <li><a href="http://songpa.seoulwomanup.or.kr/" class="export_link" target="_blank">송파여성인력개발센터</a></li>
                            <li><a href="http://www.splib.or.kr" class="export_link" target="_blank">송파구통합도서관</a></li>
                            <li><a href="http://splib.sen.go.kr" class="export_link" target="_blank">송파도서관</a></li>
                            <li><a href="http://www.songpavc.or.kr" class="export_link" target="_blank">송파구자원봉사센터</a></li>
                            <li><a href="http://www.song-pa.or.kr" class="export_link" target="_blank">송파노인종합복지관</a></li>
                            <li><a href="https://www.bookmuseum.go.kr/" class="export_link" target="_blank">송파책박물관</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
