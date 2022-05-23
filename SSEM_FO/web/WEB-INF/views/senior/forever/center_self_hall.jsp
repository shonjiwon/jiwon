<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '동 주민자치회관 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    평생교육
                </h2>
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
                        <a href="#" class="deapth_tit" title="선택">평생교육</a>
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
                        <a href="#" class="deapth_tit" title="선택">동 주민자치회관</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생학습도시 송파</a></li>
                            <li><a href="/ssem/senior/forever/center_self_hall.do">동 주민자치회관</a></li>
                            <li><a href="/ssem/senior/forever/center_ict_hall.do">정보화교실</a></li>
                            <li><a href="/ssem/senior/forever/center_woman_hall.do">여성교실</a></li>
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
    <div class="sub_con st_5"><!-- sub_con -->
        <h3 class="mt_100 tit font_sc mb_50">동 &middot; 주민자치회관</h3>
        <div class="sub_info_visual foreverEdu_st_1 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">동 주민지치회 이미지</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_2 mt_85">이용안내</h4>
            <h5 class="middot mt_20"><span class="tc_b fs_22 fs_md_28">문화강좌 관련 문의</span></h5>
            <p class="mt_15 tc_sub"> 강의 내용, 준비물, 강의시간 등 각 동마다 수강신청 방법이 다르기 때문에, 홈페이지를 확인하시거나 각 동으로 문의바랍니다.<br>
                (프로그램 신청은 <a  class="link_blank2" href="/ssem/senior/program/lecture_list.do">통합프로그램신청 </a>메뉴에서 가능합니다.)
            </p>
            <h5 class="middot mt_50"><span class="tc_b fs_22 fs_md_28">동별 주민자치위원회 전화번호 (27개동)</span></h5>
            <div class="table_box mt_25 fs_18 fs_md_26 t_center">
                <table class="st_2">
                    <caption class="text_hide">동별 주민자치위원회의 연번, 동명, 문의 안내</caption>
                    <colgroup>
                        <col style="width:20%">
                        <col style="width:40%">
                        <col style="width:40%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>연번</th>
                        <th>동명</th>
                        <th>문의</th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="fw_600 tc_b">1</span></td>
                            <td>풍납1동</td>
                            <td> 02)2147-4006,4000</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">2</span></td>
                            <td>풍납2동</td>
                            <td> 02)2147-4041,4030</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">3</span></td>
                            <td>거여1동</td>
                            <td> 02)2147-4068,4060</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">4</span></td>
                            <td>거여2동</td>
                            <td> 02)2147-4097,4090</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">5</span></td>
                            <td>마천1동</td>
                            <td> 02)2147-4129,4120</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">6</span></td>
                            <td>마천2동</td>
                            <td> 02)2147-4167,4150</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">7</span></td>
                            <td>방이1동</td>
                            <td> 02)2147-4192,4180</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">8</span></td>
                            <td>방이2동</td>
                            <td> 02)2147-4217,4210</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">9</span></td>
                            <td>오륜동</td>
                            <td> 02)2147-4248,4240</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">10</span></td>
                            <td>오금동</td>
                            <td> 02)2147-4276,4270</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">11</span></td>
                            <td>송파1동</td>
                            <td> 02)2147-4308,4300</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">12</span></td>
                            <td>송파2동</td>
                            <td> 02)2147-4349,4330</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">13</span></td>
                            <td>석촌동</td>
                            <td> 02)2147-4369,4360</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">14</span></td>
                            <td>삼전동</td>
                            <td> 02)2147-4469,4390</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">15</span></td>
                            <td>가락본동</td>
                            <td> 02)2147-4431,4420</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">16</span></td>
                            <td>가락1동</td>
                            <td> 02)2147-4464,4450</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">17</span></td>
                            <td>가락2동</td>
                            <td> 02)2147-4492,4480</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">18</span></td>
                            <td>문정1동</td>
                            <td> 02)2147-4522,4510</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">19</span></td>
                            <td>문정2동</td>
                            <td> 02)2147-4557,4540</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">20</span></td>
                            <td>장지동</td>
                            <td> 02)2147-4579,4570</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">21</span></td>
                            <td>위례동</td>
                            <td> 02)2147-4964,4950</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">22</span></td>
                            <td>잠실본동</td>
                            <td> 02)2147-4610,4600</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">23</span></td>
                            <td>잠실2동</td>
                            <td> 02)2147-4643,4630</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">24</span></td>
                            <td>잠실3동</td>
                            <td> 02)2147-4672,4660</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">25</span></td>
                            <td>잠실4동</td>
                            <td> 02)2147-4697,4690</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">26</span></td>
                            <td>잠실6동</td>
                            <td> 02)2147-4734,4720</td>
                        </tr>
                        <tr>
                            <td><span class="fw_600 tc_b">27</span></td>
                            <td>잠실7동</td>
                            <td> 02)2147-4758,4750</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
