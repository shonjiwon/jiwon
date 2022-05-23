<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '이용안내 > 기관소개 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_1"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    기관소개
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
                        <a href="/ssem/songpacenter/intro/intro.do" class="deapth_tit" title="선택">기관소개</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">이용안내</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/intro/use.do">이용안내</a></li>
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
            <a href="#" class="tab_m">이용안내<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                <li  class="tab_item on"><a href="/ssem/songpacenter/intro/use.do">이용안내</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h3 class="mt_80 mb_50 tit font_sc">이용안내</h3>
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <div class="wrap">
                <h2 class="c_tit_2 mt_95">시설대관 방법 및 비용</h2>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mb_15 fw_400">대관절차</h3>
                <div class="youth_line_box mt_25 bg_color_2">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img02.jpg"  class="mo_hide" alt="대관절차 방법 1. 대관신청 2.신청서 작성 3.대관심의 4.대관료 납부 5.납부확인 6.대관확정 3.대관심의 4.미승인 5.사유통보 6.반려">
                    <img src="/ssem/resources/img/sub/youth/yil_grap_img02_m.jpg" class="pc_hide" alt="대관절차 방법 1. 대관신청 2.신청서 작성 3.대관심의 4.대관료 납부 5.납부확인 6.대관확정 3.대관심의 4.미승인 5.사유통보 6.반려">
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mt_md_45 mb_15">대관료</h3>
                <!--pc-->
                <div class="table_box mt_25 fs_18 fs_md_20 t_center screen_sm_hide">
                    <table class="st_2">
                        <caption class="text_hide">대관의 명칭, 좌석수, 사용료 기준시간, 초과금액, 소극장, 비고 안내</caption>
                        <colgroup>
                            <col width="20%">
                            <col width="20%">
                            <col width="20%">
                            <col width="20%">
                            <col width="20%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>명칭</th>
                            <th>좌석수(정원)</th>
                            <th>사용료/기준시간</th>
                            <th>초과금액 소극장</th>
                            <th>비고</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span  class="fw_600 tc_b">대강당</span></td>
                            <td>230석</td>
                            <td>250,000원 / 3시간</td>
                            <td>25,000원 / 시간</td>
                            <td class="t_left">
                                <ul class="ul_list_star">
                                    <li>냉난방비 50,000원/3시간 <br>(초과 1시간당 10,000원)</li>
                                    <li>빔프로젝트 10,000원/1시간</li>
                                    <li>그랜드피아노 50,000원/1회</li>
                                    <li class="tc_1">해당 성수기 시즌에만 토요일, 일요일 30% 할증적용(11월~2월)</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">체육관</span></td>
                            <td>50명</td>
                            <td>120,000원 / 2시간</td>
                            <td>60,000원 / 시간</td>
                            <td class="t_left">
                                <ul class="ul_list_star">
                                    <li>냉난방비 50,000원/2시간 초과 1시간당 5,000원 </li>
                                </ul></td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">교육실</span></td>
                            <td>20석</td>
                            <td>60,000원 / 2시간</td>
                            <td>10,000원 / 시간</td>
                            <td class="t_left">
                                <ul class="ul_list_star">
                                    <li>냉방비 10,000원/2시간 초과 1시간당 3,000원</li>
                                    <li>빔프로젝트 10,000원/시간</li>
                                </ul></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                ※부가세 10% 별도 –총 대관료의 10% 부과</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!--모바일-->
                <div class="youth_info_table mt_25 fs_18 fs_md_26 t_center screen_hide screen_sm_show">
                    <ul class="row_15">
                        <li class="col_3">
                            <div class="_head">명칭</div>
                            <div class="_cell fw_600">
                                <p class="t_center">대강당</p>
                            </div>
                            <div class="_cell fw_600">
                                <p class="t_center">체육관</p>
                            </div>
                            <div class="_cell fw_600">
                                <p class="t_center">교육실</p>
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="_head">좌석수(정원)</div>
                            <div class="_cell">
                                <span class="text_hide">대강당</span>
                                230석
                            </div>
                            <div class="_cell">
                                <span class="text_hide">체육관</span>
                                50명
                            </div>
                            <div class="_cell">
                                <span class="text_hide">교육실</span>
                                20석
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="_head">사용료/기준시간</div>
                            <div class="_cell">
                                <span class="text_hide">대강당</span>
                                250,000원 / 3시간
                            </div>
                            <div class="_cell">
                                <span class="text_hide">체육관</span>
                                120,000원 / 2시간
                            </div>
                            <div class="_cell">
                                <span class="text_hide">교육실</span>
                                60,000원 / 2시간
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="_head">초과금액</div>
                            <div class="_cell">
                                <span class="text_hide">대강당</span>
                                25,000원 / 시간
                            </div>
                            <div class="_cell">
                                <span class="text_hide">체육관</span>
                                60,000원 / 시간
                            </div>
                            <div class="_cell">
                                <span class="text_hide">교육실</span>
                                10,000원 / 시간
                            </div>
                        </li>
                        <li class="col_3">
                            <div class="_head">비고</div>
                            <div class="_cell">
                                <span class="text_hide">대강당</span>
                                <ul class="ul_list_star">
                                    <li>냉난방비 50,000원/3시간 <br>(초과 1시간당 10,000원)</li>
                                    <li>빔프로젝트 10,000원/1시간</li>
                                    <li>그랜드피아노 50,000원/1회</li>
                                    <li class="tc_1">해당 성수기 시즌에만 토요일, 일요일 30% 할증적용(11월~2월)</li>
                                </ul>
                            </div>
                            <div class="_cell">
                                <span class="text_hide">체육관</span>
                                <ul class="ul_list_star">
                                    <li>냉난방비 50,000원/2시간 초과 1시간당 5,000원 </li>
                                </ul>
                            </div>
                            <div class="_cell">
                                <span class="text_hide">교육실</span>
                                <ul class="ul_list_star">
                                    <li>냉방비 10,000원/2시간 초과 1시간당 3,000원</li>
                                    <li>빔프로젝트 10,000원/시간</li>
                                </ul>
                            </div>
                        </li>
                        <li class="col_12">
                            <div class="_cell" style="border-left: 0;">
                                <p class="t_center">※부가세 10% 별도 –총 대관료의 10% 부과</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25 mt_md_45 mb_15">시설이용 지침</h3>
                <div class="bg_color_2 ptb_60 plr_60 ptb_md_40 plr_md_20 ">
                    <ul class="list_title fw_300">
                        <li>
                            <strong><i class="icon_cal2">달력</i><span class="fs_20 fs_md_26 ml_10">예약</span></strong>
                            <div class="tc_sub">
                                예약은 상시 가능, 대관 승인 후 3일 이내 대관사용료 미납부시 통보 없이 예약취소, 환불규정 숙지
                            </div>
                        </li>
                        <li>
                            <strong><i class="icon_money">달러</i><span class="fs_20 fs_md_26 ml_10">추가비용</span></strong>
                            <div class="tc_sub">
                                <ul class="ul_list_dash">
                                    <li>해당 성수기 기간에만 토요일, 일요일 대강당 대관료 총금액 (추가시간 및 냉·난방비, 에어바운스 전기료, 프로젝터사용료 포함)의 30% 할증 적용하며, 비성수기 기간에는 주말할증 미적용  
                                    <span class="tc_1">* 성수기 시즌: 11월 ~ 2월</span></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <strong><i class="icon_time">시간</i><span class="fs_20 fs_md_26 ml_10">시간규정</span></strong>
                            <div class="tc_sub">
                                기준시간 초과사용 시 1시간 미만은 1시간으로 계산 (무대설치 및 리허설 시간은 따로 제공하지 않음)
                            </div>
                        </li>
                        <li>
                            <strong><i class="icon_check">체크</i><span class="fs_20 fs_md_26 ml_10">대여가능</span></strong>
                            <div class="tc_sub">
                                <ul class="ul_list_dash">
                                    <li>에어바운스 사용 시 별도의 전기료 5,000원/개 부과</li>
                                    <li>빔 프로젝터 10.000원/1시간, 그랜드 피아노 50,000원/1회</li>
                                    <li>유선(무선X)마이크 3대, 음향, 조명, 화이트보드</li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <strong><i class="icon_bubble">말풍선</i><span class="fs_20 fs_md_26 ml_10">기타사항</span></strong>
                            <div class="tc_sub">
                                대기실 사용 시 대강당 내에 있는 대기실만 사용 가능하며 제 2출입구 앞 대기금지 
                            </div>
                        </li>
                        <li>
                            <strong><i class="icon_phon">전화</i><span class="fs_20 fs_md_26 ml_10">문의전화</span></strong>
                            <div class="tc_sub">
                                02-2147-5323 문화체육팀
                            </div>
                        </li>
                    </ul>
                </div>
                <h2 class="c_tit_2 mt_95">시설대관 방법 및 비용</h2>
                <h3 class="c_tit_3 t_bef_middot c1 mt_25  mb_15 fw_400">수강료 감면규정</h3>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">수강료 감면규정의 구분, 대상자, 할인율, 증빙서류</caption>
                        <colgroup>
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>대상자</th>
                            <th>할인율</th>
                            <th>증빙서류</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span  class="fw_600 tc_b">다둥이</span></td>
                            <td>9세 ~ 24세의 송파구 거주 3자녀<br> 혹은 이상의 청소년</td>
                            <td>수강료의 30% (월 1개 프로그램)</td>
                            <td>다둥이카드, 등본</td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">한부모가족</span></td>
                            <td>9세 ~ 24세 청소년</td>
                            <td></td>
                            <td>한부모가족증명서, 등본</td>

                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">국가유공자</span></td>
                            <td>본인 (배우자 또는 자녀)</td>
                            <td></td>
                            <td>국가유공자증, 등본 (혹은 가족관계증명서)</td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">장애인</span></td>
                            <td>본인</td>
                            <td></td>
                            <td>복지카드</td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">기초생활수급자</span></td>
                            <td>9세 ~ 24세 청소년</td>
                            <td>수강료의 100% (월1개 및 5만원 이하 프로그램)</td>
                            <td>수급자증명서, 등본</td>
                        </tr>
                        <tr>
                            <td rowspan="2"><span  class="fw_600 tc_b">체능단</span></td>
                            <td>체능단 단원</td>
                            <td>정규프로그램 30%할인</td>
                            <td rowspan="2"></td>
                        </tr>
                        <tr>
                            <td>체능단 학부모</td>
                            <td>정규프로그램 30% 할인<br>헬스1개월 40,000원</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <p class="mtb_10">
                                    ※ 감면 제외프로그램 : 유아체능단, 대안학교, 노래대학프로그램
                                    <span class="tc_point"> 단, 기구필라테스는 10% 할인 적용(모든 할인대상자 적용)</span><br>
                                    -헬스장 장기이용 할인혜택과 위의 감면혜택은 중복으로 할인 불가
                                </p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_45  mb_15 fw_400">프로그램 환불규정</h3>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">프로그램 환불규정의 구분, 내용</caption>
                        <colgroup>
                            <col width="25%">
                            <col width="75%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>내용</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span  class="fw_600 tc_b">개강일 이전</span></td>
                            <td class="t_left">
                                <p class="mlr_20">수강료 전액환불</p>
                            </td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">개강일 이후 수업당일 포함</span></td>
                            <td class="t_left">
                                <ul class="ul_list_dash mtb_10 mlr_20">
                                    <li> 당월 수강료의 수수료 10%와 환불신청일까지의 수강료 일할공제한 금액 환불</li>
                                    <li> 14일 이후 환불신청 시 해당 월 제외 후 수수료 10% 공제한 금액 환불</li>
                                    <li> 개강 후 접수하거나 할인된 금액으로 접수한 경우에도 위와 같이 환불</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">인원미달 폐강</span></td>
                            <td class="t_left">
                                <p class="mlr_20">수강료 전액환불</p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="t_left">
                                <ul class="ul_list_dash mtb_10 mlr_20">
                                    <li> 수강료 전액환불은 결제카드 지참 후 카드 환불</li>
                                    <li> 개강일 이후 환불 접수 시 10일 이내 계좌입금 환불(필히 자필로 환불신청서 작성)</li>
                                    <li> 온라인 접수의 경우 개강일 이전까지 전화로 환불 신청 가능</li>
                                    <li> 송파청소년센터의 환불규정은 공정거래위원회 소비자분쟁해결기준에 준합니다. </li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h3 class="c_tit_3 t_bef_middot c1 mt_45  mb_15 fw_400">프로그램 연기 및 변경</h3>
                <div class="table_box mt_25 mb_20 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">프로그램 연기 및 변경의 구분, 내용</caption>
                        <colgroup>
                            <col width="25%">
                            <col width="75%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>내용</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span  class="fw_600 tc_b">연기</span></td>
                            <td class="t_left">
                                <ul class="ul_list_dash mtb_10 mlr_20">
                                    <li> 연기는 3개월 이상 헬스프로그램만 해당하며 매월 1회, 최대 한 달까지 연기 신청 가능</li>
                                    <li> 연기 신청 후 환불 불가 </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td><span  class="fw_600 tc_b">변경</span></td>
                            <td class="t_left">
                                <ul class="ul_list_dash mtb_10 mlr_20">
                                    <li>매월 개강일부터 일주일까지 신청 가능</li>
                                    <li>동일 강사의 타 시간 강좌로 단 1회에 한함</li>
                                    <li>변경 신청 후 환불 불가</li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div><!-- sub_con : e -->
</div>
