<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '정보화교실 > 평생교육 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        var len = $('[data-itme-max]').attr('data-itme-max');
        for(var j = 0; j < $('[data-itme-max]').length; j++){
            $('[data-itme-max]').eq(j).find('.ig_item').each(function(ind, item){
                var len2 = $(item).find('li').length;
                if(len2 == 0 ){
                    $(item).append('<ul></ul>')
                }
                for(var i = len2; i <= len; i++ ){
                    $(item).find('ul').append('<li class="op_0"><div>&nbsp;</div></li>');
                }
            });
        }
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    <!--2020.11.25:s-->
                    평생교육
                    <!--2020.11.25:e-->
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
                        <a href="#" class="deapth_tit" title="선택">정보화교실</a>
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
        <h3 class="mt_100 tit font_sc mb_50">정보화교실</h3>
        <div class="sub_info_visual foreverEdu_st_2 mt_md_50"> <!---sub_info_visual-->
            <p class="text_hide">정보화교실</p>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 mb_15 mb_100">
            <h4 class="c_tit_1 mt_85">교육안내</h4>
            <h5 class="c_tit_2 mt_25">소개</h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">정보소외계층을 위한 컴퓨터, 스마트폰, 키오스크 등 IT환경변화에 맞춘 교육실시로 지역주민의 정보격차를 해소하고 정보활용능력 배양</span></h5>
            <h5 class="c_tit_2 mt_85">수강신청 안내</h5>
            <div class="table_box st_2 mt_25 fs_18 fs_md_26 t_center">
                <table class="table">
                    <caption class="text_hide">수강신청의 교육대상, 운영기간, 접수기간, 신청방법, 선정방법의 안내</caption>
                    <colgroup>
                        <col style="width:22%;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>교육대상</th>
                        <td>만20세 이상 송파구민 ( 주민등록 거주지 기준 ), 송파구 사업자 및 직장인 ( 사업자 등록증, 재직증명서 기준 )</td>
                    </tr>
                    <tr>
                        <th>운영기간</th>
                        <td>2021년 2월 ~ 12월 ( 내부사정에 따라 변동될 수 있습니다. )</td>
                    </tr>
                    <tr>
                        <th>접수기간</th>
                        <td>매월 26일경부터 2일간 ( 26일 공휴일인 경우 그다음 평일 접수 )</td>
                    </tr>
                    <tr>
                        <th>신청방법</th>
                        <td>
                            전과정 인터넷접수 ( 기초과정만 전화접수 가능 )<br>
                            (프로그램 신청은 <a  class="link_blank2" href="/ssem/senior/program/lecture_list.do">통합프로그램신청 </a>메뉴에서 가능합니다.)<br>
                            ※ 코로나19로 인한 온라인 교육 진행 시 접수과정 없이 송파구민이면 누구나 수강 가능
                        </td>
                    </tr>
                    <tr>
                        <th>선정방법</th>
                        <td>선착순</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h5 class="c_tit_2 mt_85 mb_25">교육과정 안내</h5>
            <div class="info_grp_wrap"> <!--info_grp_wrap-->
                <div class="info_grp_tit">
                    <span>구민정보화교육 과정흐름도</span>
                </div>
                <div class="ingo_grp_item">
                    <div class="igi_t no_line"></div>
                    <div class="ifg_row">
                        <div class="ig_item line line_over">
                            <div class="ig_t"><span>PC 활용</span></div>
                        </div>
                        <div class="ig_item line line_over">
                            <div class="ig_t"><span>OA 활용</span></div>
                        </div>
                        <div class="ig_item line line_over">
                            <div class="ig_t"><span>UCC</span></div>
                        </div>
                        <div class="ig_item line line_over">
                            <div class="ig_t"><span>최신 트렌드</span></div>
                        </div>
                        <div class="ig_item line line_over">
                            <div class="ig_t"><span>스마트폰</span></div>
                        </div>
                    </div>
                </div>
                <div class="ingo_grp_item color_1" data-itme-max="2">
                    <div class="igi_t"><span>기초</span></div>
                    <div class="ifg_row">
                        <div class="ig_item line line_over">
                            <ul>
                                <li><div><span>컴퓨터 기초(윈도우10)</span></div></li>
                                <li><div><span>인터넷 기초</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line line_over"> </div>
                        <div class="ig_item line line_over"></div>
                        <div class="ig_item line line_over"> </div>
                        <div class="ig_item line line_over">
                            <ul>
                                <li><div><span>스마트폰 기초</span></div></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="ingo_grp_item color_2" data-itme-max="3">
                    <div class="igi_t"><span>활용</span></div>
                    <div class="ifg_row">
                        <div class="ig_item line line_over">
                            <ul>
                                <li><div><span>인터넷 활용</span></div></li>
                                <li><div><span>내 컴퓨터 쉽게 관리하기<br>(윈도우10)</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line line_over">
                            <ul>
                                <li><div><span>한글 기초(NEO)<br>한글 활용(NEO)</span></div></li>
                                <li><div><span>파워포인트 기초(2016)<br>파워포인트 활용(2016)</span></div></li>
                                <li><div><span>엑셀 기초(2016)<br>엑셀 활용(2016)</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line line_over"></div>
                        <div class="ig_item line line_over"></div>
                        <div class="ig_item line line_over">
                            <ul>
                                <li><div><span>스마트폰 활용</span></div></li>
                                <li><div><span>스마트폰 정보검색</span></div></li>
                                <li><div><span>생활 속 필수 앱 활용</span></div></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="ingo_grp_item color_3" data-itme-max="3">
                    <div class="igi_t"><span>심화</span></div>
                    <div class="ifg_row">
                        <div class="ig_item line line_over"></div>
                        <div class="ig_item line line_over"></div>
                        <div class="ig_item line">
                            <ul>
                                <li><div><span>마법의 사진 편집도구<br>픽슬러 활용</span></div></li>
                                <li><div><span>마법의 사진 편집도구<br>포토스케이프 활용</span></div></li>
                                <li><div><span>나도 유튜버!<br>동영상 제작하기</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line">
                            <ul>
                                <li><div><span>엔트리로<br>시작하는 코딩</span></div></li>
                                <li><div><span>앱인벤터로<br>스마트폰 앱 만들기</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>
                        <div class="ig_item line">
                            <ul>
                                <li><div><span>스마트폰 UCC만들기</span></div></li>
                                <li><div><span>스마트폰을 이용한 SNS</span></div></li>
                                <li><div><span>스마트폰 여행즐기기</span></div></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="ingo_grp_item color_4" data-itme-max="3">
                    <div class="igi_t"><span>자격증</span></div>
                    <div class="ifg_row">
                        <div class="ig_item line">
                            <ul>
                                <li><div><span>DIAT자격증(인터넷)</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 80%;"></div>
                        </div>
                        <div class="ig_item line">
                            <ul>
                                <li><div><span>DIAT자격증(한글)</span></div></li>
                                <li><div><span>DIAT자격증(파워포인트)</span></div></li>
                                <li><div><span>DIAT자격증(엑셀)</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item"></div>
                        <div class="ig_item"></div>
                        <div class="ig_item"></div>
                    </div>
                </div>
                <%--<div class="ingo_grp_item color_5">
                    <div class="igi_t">IT융합</div>
                    <div class="ifg_row">
                        <div class="ig_item line">
                            <div class="ig_t"><span>최신IT트렌드</span></div>
                            <ul>
                                <li><div><span>최신트렌드 융합1<br>(코딩, VR, 3D)</span></div></li>
                                <li><div><span>최신트렌드 융합2<br>(코딩, VR, 3D, 드론)</span></div></li>
                                <li><div><span>사물인터넷 체험<br>(앱 인벤터, 아두이노)</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line">
                            <div class="ig_t"><span>생활밀착형</span></div>
                            <ul>
                                <li><div><span>생활형 IT융합교육<br>(무인키오스크, 생활편의앱)</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>
                        <div class="ig_item screen_md_hide"></div>
                        <div class="ig_item screen_md_hide"></div>
                        <div class="ig_item screen_md_hide"></div>
                    </div>
                </div>
                <div class="ingo_grp_item color_6">
                    <div class="igi_t">종합</div>
                    <div class="ifg_row">
                        <div class="ig_item line">
                            <div class="ig_t"><span>PC</span></div>
                            <ul>
                                <li><div><span>컴퓨터 입문<br>(컴퓨터, 인터넷)</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="ig_t"><span>OA</span></div>
                            <ul>
                                <li><div><span>OA입문<br>(한글, 엑셀, 파워포인트)</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="ig_t"><span>스마트폰</span></div>
                            <ul>
                                <li><div><span>스마트폰 입문<br>(스마트폰 기초/활용)</span></div></li>
                                <li><div><span>스마트폰브이로그로<br> 소통하기(UCC, SNS)</span></div></li>
                                <li><div><span>스마트폰똑똑하게<br>사용하기(정보검색, 앱활용)</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>
                        <div class="ig_item screen_md_hide"></div>
                        <div class="ig_item screen_md_hide"></div>
                    </div>
                </div>--%>
                <div class="ingo_grp_item color_7">
                    <div class="igi_t">특강</div>
                    <div class="ifg_row">
                        <div class="ig_item line">
                            <div class="ig_t"><span>PC 활용</span></div>
                            <ul>
                                <li><div><span>도전! 내 PC정리의 달인</span></div></li>
                                <li><div><span>클라우드 제대로<br> 활용하기</span></div></li>
                                <li><div><span>크롬으로 만나는<br> 인터넷 세상</span></div></li>
                                <li><div><span>무료 오피스 활용</span></div></li>
                                <li><div><span>나도 유튜버! <br> 유튜영상채널 만들기</span></div></li>
                                <li><div><span>알기 쉬운 해외직구</span></div></li>
                                <li><div><span>나도 있다! <br> 모바일 홈페이지</span></div></li>
                                <li><div><span>PC로 만나는 즐거운 쇼핑</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 30%;"></div>
                        </div>

                        <div class="ig_item line">
                            <div class="ig_t"><span>PC 활용</span></div>
                            <ul>
                                <li><div><span>한글로 멋진 생활문서 만들기</span></div></li>
                                <li><div><span>파워포인트로 멋지게<br>문서 만들기</span></div></li>
                                <li><div><span>엑셀로 편리한 생활문서 만들기</span></div></li>
                                <li><div><span>정보검색을 활용한<br>문서 만들기</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 60%;"></div>
                        </div>

                        <div class="ig_item line">
                            <div class="ig_t"><span>UCC</span></div>
                            <ul>
                                <li><div><span>웹포토샵으로<br>멋진 사진 작가되기</span></div></li>
                                <li><div><span>포토스케이프로<br>움직이는 사진 만들기</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 80%;"></div>
                        </div>

                        <div class="ig_item line">
                            <div class="ig_t"><span>스마트폰 활용</span></div>
                            <ul>
                                <li><div><span>스마트폰 왕초보 탈출</span></div></li>
                                <li><div><span>카카오톡 100배 활용팀</span></div></li>
                                <li><div><span>도전! 스마트폰<br>정리의 달인</span></div></li>
                                <li><div><span>내 손안의<br>키오스크 활용하기</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(교통-교통,주차,지도,네비)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(건강-병원,복약알리미)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(예약-교통,숙박,식당)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(주문-배달,포장)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(도구-생활도구,QR코드)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(편의-뷰어,스캔,팩스)</span></div></li>
                                <li><div><span>생활속 편리한 앱 활용<br>(결제-각종페이)</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <%--<div class="ig_item line">
                            <div class="ig_t"><span>스마트폰&PC 활용</span></div>
                            <ul>
                                <li><div><span>PC와 스마트폰 연결하여<br> 제대로 활용하기</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 80%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="ig_t"><span>최신트렌드</span></div>
                            <ul>
                                <li><div><span>코딩으로 <br>로봇과 친해지기</span></div></li>
                            </ul>
                            <div class="none_line" style="height: 80%;"></div>
                        </div>--%>
                    </div>
                </div>
                <div class="ingo_grp_item color_5">
                    <div class="igi_t">최신트렌드</div>
                    <div class="ifg_row">
                        <div class="ig_item line">
                            <div class="ig_t"><span>최신IT트렌드</span></div>
                            <ul>
                                <li><div><span>사물인터넷으로<br>만나는 코딩</span></div></li>
                                <li><div><span>코딩으로 로봇과<br>친해지기</span></div></li>
                                <li><div><span>나만의 캐릭터로<br>3D 프린팅하기</span></div></li>
                                <li><div><span>생활 속 VR/AR 체험하기</span></div></li>
                                <li><div><span>도전! 드론 비행!</span></div></li>
                            </ul>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                        <div class="ig_item line">
                            <div class="none_line" style="height: 100%;"></div>
                        </div>
                    </div>
                </div>
            </div><!--info_grp_wrap //-->
            <h5 class="c_tit_2 mt_85">수강신청 시 유의사항</h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">전과정 인터넷 접수 ( 단, 기초과정만 전화접수 병행가능 )</span></h5>
            <h5 class="c_tit_2 mt_85">감면 및 환불 규정</h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">서울특별시 송파구 정보화 기본 조례 제 43조 ( 수강료 및 교재비 )</span></h5>
            <div class="table_box st_2 mt_25 fs_18 fs_md_26 t_center">
                <table class="st_2">
                    <caption class="text_hide">감면 및 환불 규정의 단위, 교육시간, 수강료 안내</caption>
                    <colgroup>
                        <col style="width:22%;">
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>단위</th>
                        <th>교육시간</th>
                        <th>수강료</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td rowspan="3">월 1인 1강좌</td>
                        <td>10시간 ~ 20시간</td>
                        <td>10,000원 이하</td>
                    </tr>
                    <tr>
                        <td class="line_left">21시간 ~ 30시간</td>
                        <td>20,000원 이하</td>
                    </tr>
                    <tr>
                        <td class="line_left">31시간 ~ 50시간</td>
                        <td>30,000원 이하</td>
                    </tr>
                    <tr>
                        <td colspan="3" class="bg_color_2 t_left">
                            <div class="tc_b ptb_45 plr_40">
                                <strong class="fs_22 fs_md_30">감면기준</strong>
                                <ul class="ul_list_span mt_10 fs_20 fs_md_26 mb_40">
                                    <li> <span>※</span>제43조 제2항의 수강료 면제대상은 초급과정에 한하여 무료</li>
                                    <li> <span>※</span>단,「국민기초생활 보장법」 제2조제2호에 따른 수급자에 한하여 모든 정보화교육 무료</li>
                                    <li> <span>※</span>비고 : 제43조 제2항의 수강료 면제대상
                                        <ul class="mt_10 fs_18 fs_md_24">
                                            <li><span>1.</span>「국가정보화 기본법」제35조제2항 각 호에 따른 장애인, 수급자, 북한이탈주민</li>
                                            <li><span>2.</span>「국가정보화 기본법 시행령」제34조제2항 각호에 따른 보호대상아동, 고령자, 결혼이민자등, 한부모가족복지시설에서 지원을 받고 있는 사람, 농업인, 어업인</li>
                                            <li><span>3.</span>세 자녀 이상 가정의 부모 및 자녀들</li>
                                            <li><span>4.</span>그 밖에 구청장이 필요하다고 인정하는 사람</li>
                                        </ul>
                                    </li>
                                </ul>
                                <strong class="fs_22 fs_md_30 mt_40">환불기준</strong>
                                <ul class="ul_list_dot mt_10 fs_20 fs_md_26">
                                    <li>교육 개강일 전까지 수강을 포기한 경우는 수강료 전액 환불</li>
                                    <li>교육기간의 2분의 1이 경과하기 전에는 날짜 계산하여 환불</li>
                                    <li>교육기간의 2분의 1이 경과한 경우는 환불하지 아니함</li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h5 class="c_tit_2 mt_85">정보화교실 커뮤니티 교육상담안내 번호</h5>
            <h5 class="middot mt_15"><span class="tc_b fs_22 fs_md_28">구민정보화교육 콜센터 ( 헬프데스크 ) : 02)1577-2066</span></h5>
        </div>
    </div>
</div>
