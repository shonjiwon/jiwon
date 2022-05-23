<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '조직도 > 송파쌤이란 > 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
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
                        <a href="#" class="deapth_tit" title="선택">송파쌤이란</a>
                        <ul>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/senior/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/senior/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/senior/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">조직도</a>
                        <ul>
                            <li><a href="/ssem/senior/ssem/vision.do">비전</a></li>
                            <li><a href="/ssem/senior/ssem/organ.do">조직도</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <div class="text_con ">
            <h3 class="mt_80 mb_50 tit font_sc">송파쌤이란?</h3>
            <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
                <h4 class="text_hide">탭</h4>
                <a href="#" class="tab_m">조직도<i class="icon_arrow_down_w ml_60">다운</i></a>
                <ul class="tab tab_2"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                    <li  class="tab_item"><a href="/ssem/senior/ssem/vision.do">비전</a></li>
                    <li  class="tab_item on"><a href="/ssem/senior/ssem/organ.do">조직도</a></li>
                </ul>
            </div><!-- tab_box //-->
            <div class="wrap">
                <div class="row">
                    <div class="organ_info_box">
                        <img class="organ_info" src="/ssem/resources/img/sub/youth/organ.png" alt="구청장 미래전략국장 교육협력과 교육정책팀 스마트평생교육팀 학교지원팀 독서문화팀">
                        <img class="organ_info_m" src="/ssem/resources/img/sub/youth/organ_m.png" alt="구청장 미래전략국장 교육협력과 교육정책팀 스마트평생교육팀 학교지원팀 독서문화팀">
                    </div>
                </div>
            </div>
            <div class="wrap mb_100">
                <h4 class="tit2 mt_100 mb_50">조직현황</h4>
                <div class="table_box tabel_box_mob_or_chart mt_15 fs_18 fs_md_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">조직도의 부서명, 팀, 직위, 성명, 연락처, 담당업무</caption>
                        <colgroup>
                            <col style="width:10%">
                            <col style="width:15%">
                            <col style="width:15%">
                            <col style="width:10%">
                            <col style="width:10%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>부서명</th>
                            <th>팀</th>
                            <th>직위</th>
                            <th>성명</th>
                            <th>연락처</th>
                            <th>담당업무</th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr> <td>송파구청    </td><td>                  </td><td>구청장 </td><td>    박성수 </td><td>        02-2147-2360   </td><td class="t_left">  송파구 구정 총괄</td></tr>
                            <tr> <td>미래전략국  </td><td>                  </td><td>국장   </td><td>      김기범 </td><td>        02-2147-2045   </td><td class="t_left">  미래전략국 업무 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 교육협력과        </td><td>과장   </td><td>      김성수 </td><td>        02-2147-2363   </td><td class="t_left">  교육협력과 업무 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 혁신교육팀        </td><td>팀장   </td><td>      김선희 </td><td>        02-2147-2365   </td><td class="t_left">  혁신교육팀 업무 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>팀장   </td><td>      정유석 </td><td>        02-2147-2453   </td><td class="t_left">  스마트평생교육팀 업무 및 송파쌤 교육포털 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 학교지원팀        </td><td>팀장   </td><td>      구은영 </td><td>        02-2147-2369   </td><td class="t_left">  교육경비 보조사업 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 독서문화팀        </td><td>팀장   </td><td>      민정민 </td><td>        02-2147-2371   </td><td class="t_left">  독서문화팀 업무 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 혁신교육팀        </td><td>주무관 </td><td>     이보람 </td><td>       02-2147-2380   </td><td class="t_left">  민∙관∙학 거버넌스 구축∙운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 혁신교육팀        </td><td>주무관 </td><td>     채양우 </td><td>       02-2147-2388   </td><td class="t_left">  혁신교육지구 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 혁신교육팀        </td><td>주무관 </td><td>     서예솔 </td><td>       02-2147-2366   </td><td class="t_left">  학교폭력예방, 고교-대학 연계</td></tr>
                            <tr> <td>교육협력과  </td><td> 혁신교육팀        </td><td>주무관 </td><td>     김건아 </td><td>       02-2147-2457   </td><td class="t_left">  학교로 찾아가는 인물도서관 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     구보배 </td><td>       02-2147-2374   </td><td class="t_left">  평생학습동아리 운영관리</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     안청 </td><td>         02-2147-2383   </td><td class="t_left">  송파쌤 인물도서관 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     양정은 </td><td>       02-2147-2375   </td><td class="t_left">  송파쌤 교육포털 구축 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     이서현 </td><td>       02-2147-2368   </td><td class="t_left">  송파쌤 미래교육센터 운영 총괄</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     박민기 </td><td>       02-2147-2452   </td><td class="t_left">  송파샘 악기도서관 및 음악창작소 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     김영식 </td><td>       02-2147-2471   </td><td class="t_left">  송파쌤 온라인 영상컨텐츠 기획∙관리</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     장현준 </td><td>       02-2147-2376   </td><td class="t_left">  평생교육 종합계획 수립 및 대외 평가 추진</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     전연정 </td><td>       02-2147-2381   </td><td class="t_left">  송파쌤 진학학습지원센터 기획∙운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     김정아 </td><td>       02-2147-2454   </td><td class="t_left">  평생학습원 교육운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 스마트평생교육팀   </td><td>주무관 </td><td>     조현수 </td><td>       02-2147-2458   </td><td class="t_left">  동네배움터 기획운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 학교지원팀        </td><td>주무관 </td><td>     김순옥 </td><td>       02-2147-2372   </td><td class="t_left">  초∙중∙고학교 교육경비 종합계획∙집행</td></tr>
                            <tr> <td>교육협력과  </td><td> 학교지원팀        </td><td>주무관 </td><td>     전소영 </td><td>       02-2147-2373   </td><td class="t_left">  송파구 인재육성 장학재단 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 학교지원팀        </td><td>주무관 </td><td>     김유미 </td><td>       02-2147-2379   </td><td class="t_left">  유치원 자율선택 사업 교부 및 정산</td></tr>
                            <tr> <td>교육협력과  </td><td> 독서문화팀        </td><td>주무관 </td><td>     박지선 </td><td>       02-2147-2377   </td><td class="t_left">  구립도서관 건립</td></tr>
                            <tr> <td>교육협력과  </td><td> 독서문화팀        </td><td>주무관 </td><td>     박정화 </td><td>       02-2147-2378   </td><td class="t_left">  구립도서관 예산 및 운영</td></tr>
                            <tr> <td>교육협력과  </td><td> 독서문화팀        </td><td>주무관 </td><td>     박다윤 </td><td>       02-2147-2370   </td><td class="t_left">  사립작은도서관 운영</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
