<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-05
  Time: 오후 8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '개인정보처리방침 > 잠실청소년센터 > 송파쌤');

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
                    개인정보처리방침
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
                        <a href="#" class="deapth_tit" title="선택">개인정보처리방침</a>
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
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">개인정보처리방침</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 pb_100 mb_15">
            <h2 class="c_tit_2 mt_25 mb_10">송파구청 개인정보 처리방침</h2>
            <p class="mb_20">
                송파구청은 개인정보보호법 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련된 고충을 신속하고 원활하게 처리할 수 있도록<br class="pc"> 개인정보처리방침을 수립·공개합니다.
            </p>
            <p  class="mb_40">
                이 방침은 별도의 설명이 없는 한, 송파구에서 처리하는 모든 개인정보파일에 적용됩니다. 다만 소관업무 처리를 위해<br class="pc">
                부서에서 별도의 개인정보 처리방침을 제정, 시행하는 경우에는 그에 따르고, 해당부서에서 운영하는 홈페이지에 게시함을 알려드립니다.
            </p>

            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제1조. 개인정보의 처리 목적</p>
                    <p>송파구는 다음의 목적을 위해 개인정보를 처리합니다. 수집한 개인정보는 목적 외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 「개인정보보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행하겠습니다.</p>
                    <ul class="ul_list_num">
                        <li>홈페이지 회원관리<br> 회원가입 및 회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 부정이용방지, 비인가 사용방지, 가입의사 확인, 만14세 미만 아동 개인정보 수집 시<br>법정대리인 동의여부 확인, 불만처리 등 민원처리, 이벤트 및 뉴스레터, 고지사항 전달 등을 목적으로 개인정보를 처리</li>
                        <li>공공서비스 제공<br> 자치행정, 교통, 도시계획, 주택건축, 보건복지, 교육, 문화예술, 환경관리 등 주민생활과 밀접한 공공서비스 제공을 목적으로 개인정보를 처리</li>
                        <li>민원사무처리<br> 발급민원, 민원상담, 부과·징수, 체납관리 등과 관련된 민원처리를 목적으로 개인정보를 처리</li>
                        <li>개인영상정보처리기기 운영<br> 범죄 예방 및 수사, 시설안전 및 화재예방, 교통단속, 교통정보의 수집·분석 및 제공 등을 목적으로 개인영상정보를 처리</li>
                    </ul>
                </div>

                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제2조. 개인정보의 처리·보유기간 및 항목</p>
                    <ul class="ul_list_num2">
                        <li>송파구에서 처리하는 개인정보는 수집·이용 목적으로 명시한 범위 내에서 처리하며, 법령에 따른 개인정보 보유기간 또는 정보주체로부터 수집할 때 동의 받은 보유기간 동안 안전하게 보관합니다.</li>
                        <li>송파구에서 운영중인 각 개인정보파일의 처리목적 및 보유기간, 처리하는 개인정보 항목 등은 개인정보보호 포털(www.privacy.go.kr) → 민원마당 → 개인정보열람 등 요구 → 개인정보파일 목록검색 메뉴에서 검색 및 확인이 가능합니다. <a href="https://www.privacy.go.kr/wcp/dcl/per/personalInfoFileList.do?searchInsttCode=3230000" target="_blank">(바로가기)</a></li>
                    </ul>
                </div>

                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제3조. 개인정보의 제3자 제공에 관한 사항</p>
                    <ul class="ul_list_num2">
                        <li> 송파구는 다음의 경우 개인정보를 수집한 목적 범위에서 개인정보를 제3자에게 제공합니다.
                            <ul class="ul_list_num">
                                <li>정보주체의 동의를 받은 경우</li>
                                <li>법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우</li>
                                <li>법령 등에서 정하는 소관업무의 수행을 위하여 불가피한 경우</li>
                                <li>정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우</li>
                            </ul>
                        </li>
                        <li>송파구는 당초 수집 목적과 합리적으로 관련된 범위에서 정보주체에게 불이익이 발생하는지 여부, 암호화 등 안전성 확보에 필요한 조치를 하였는지 여부 등을 고려하여 대통령령으로 정하는 바에 따라 정보주체의 동의 없이 개인정보를 제공할 수 있습니다.</li>
                        <li>송파구는 원칙적으로 정보주체의 개인정보를 수집·이용 목적으로 명시한 범위 내에서 처리하며, 다음의 경우를 제외하고는 정보주체의 사전 동의 없이는 본래의 목적 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다.
                            <ul class="ul_list_num">
                                <li>정보주체로부터 별도의 동의를 받는 경우</li>
                                <li>법률에 특별한 규정이 있는 경우</li>
                                <li>정보주체 또는 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우</li>
                                <li>개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우</li>
                                <li>조약, 그 밖의 국제협정의 이행을 위하여 외국정보 또는 국제기구에 제공하기 위하여 필요한 경우</li>
                                <li>범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우</li>
                                <li>법원의 재판업무 수행을 위하여 필요한 경우</li>
                                <li>형 및 감호, 보호처분의 집행을 위하여 필요한 경우</li>
                            </ul>
                        </li>
                        <li>송파구로부터 개인정보를 제공받은 자는 정보주체로부터 별도의 동의를 받거나 다른 법률에 특별한 규정이 있는 경우를 제외하고는 다시 제3자에게 제공할 수 없습니다.</li>
                        <li>각각의 개인정보에 대한 제3자 제공사항은 다음 경로를 통하여 확인하실 수 있습니다.<br> 개인정보보호 포털(www.privacy.go.kr) → 민원마당 → 개인정보열람 등 요구 → 개인정보파일 목록검색 메뉴에서 검색 → 기관명에 “송파구” 입력 후 조회<a href="https://www.privacy.go.kr/wcp/dcl/per/personalInfoFileList.do" target="_blank">(바로가기)</a></li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제4조. 개인정보의 처리 위탁</p>
                    <p>송파구는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</p>
                    <ul class="ul_list_num">
                        <li>개인정보처리 위탁 현황</li>
                        <li>송파구는 위탁계약 체결 시 개인정보보호법 제26조에 따른 준수사항을 위탁계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</li>
                        <li>위탁업무의 내용이나 수탁자가 변경될 경우에는 개인정보처리방침을 통하여 공개하도록 하겠습니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제5조. 정보주체 및 법정대리인의 권리·의무 및 그 행사방법</p>
                    <p>정보주체(만14세 미만인 경우에는 법정대리인을 말함)는 자신의 개인정보에 대해 다음과 같은 권리를 행사할 수 있습니다.</p>
                    <ul class="ul_list_num2">
                        <li>개인정보 열람요구 : 개인정보보호법 제35조(개인정보의 열람)에 따라 열람을 요구할 수 있습니다. 단, 다음 사항의 경우 열람 등이 제한될 수 있습니다.
                            <ul class="ul_list_num">
                                <li>법률에 따라 열람이 금지되거나 제한되는 경우</li>
                                <li>다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우</li>
                                <li>공공기관이 다음 각 목의 어느 하나에 해당하는 업무를 수행할 때 중대한 지장을 초래하는 경우
                                    <ul class="ul_list_kr">
                                        <li>조세의 부과·징수 또는 환급에 관한 업무</li>
                                        <li>「초·중등교육법」 및 「고등교육법」에 따른 각급 학교, 「평생교육법」에 따른 평생교육시설, 그 밖의 다른 법률에 따라 설치된 고등교육기관에서의 성적 평가 또는 입학자 선발에 관한 업무</li>
                                        <li>학력·기능 및 채용에 관한 시험, 자격 심사에 관한 업무</li>
                                        <li>보상금·급부금 산정 등에 대하여 진행 중인 평가 또는 판단에 관한 업무</li>
                                        <li>다른 법률에 따라 진행 중인 감사 및 조사에 관한 업무</li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>개인정보 정정·삭제 요구 : 개인정보보호법 제36조(개인정보의 정정·삭제)에 따라 정정·삭제를 요구할 수 있습니다. 다만, 다른 법령에서 그 개인정보가 수집대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.</li>
                        <li>개인정보 처리정지 요구 : 개인정보보호법 제37조(개인정보의 처리정지 등)에 따라 처리정지를 요구할 수 있습니다. 단 아래에 해당하는 경우에는 법 제37조 2항에 의하여 처리정지요구를 거절할 수 있습니다.
                            <ul class="ul_list_num">
                                <li>법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우</li>
                                <li>다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우</li>
                                <li>공공기관이 개인정보를 처리하지 아니하면 다른 법률에서 정하는 소관업무를 수행할 수 없는 경우</li>
                                <li>개인정보를 처리하지 아니하면 정보주체와 약정한 서비스를 제공하지 못하는 등 계약의 이행이 곤란한 경우로써 정보주체가 그 계약의 해지 의사를 명확하게 밝히지 아니한 경우</li>
                            </ul>
                        </li>
                        <li>개인정보 열람 등 요구방법 : 개인정보보호 포털(www.privacy.go.kr)을 통해 온라인 신청 또는 송파구청 2층 민원여권과를 통해 오프라인 신청을 할 수 있습니다.</li>
                    </ul>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1 mt_30">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2">
                            <caption class="text_hide"> 개인정보 열람 등 요구방법의 온라인(인터넷), 오프라인 안내</caption>
                            <colgroup>
                                <col style="width:50%" />
                                <col style="width:50%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>온라인(인터넷)</th>
                                <th>오프라인(서면)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="va_t t_left">
                                    <ul class="ul_list_num mtb_15 ml_20">
                                        <li>개인정보종합지원포털(www.privacy.go.kr) 접속</li>
                                        <li>민원마당 > 개인정보열람 등 요구안내 > [개인정보 열람 등 요구] 클릭</li>
                                        <li>본인인증(I-PIN 인증 / 휴대폰 인증)</li>
                                        <li>[개인정보파일 목록검색]을 통해 대상기관 선택</li>
                                        <li>신청유형 선택(개인정보 열람, 정정,·삭제, 처리정지 중 택 1)</li>
                                        <li>요구서 작성 후 민원창구</li>
                                    </ul>
                                </td>
                                <td class="va_t t_left">
                                    <ul class="ul_list_num mt_15 ml_20">
                                        <li>[개인정보 열람 요구서]를 작성하여 송파구청 민원여권과로 제출</li>
                                        <li>청구주체 확인을 위하여 주민등록증·운전면허증·여권등 신분증명서를 제시하여야 함</li>
                                    </ul>
                                    <p class="ml_20">※ 만일, 대리인을 통하여 신청할 경우에는 [위임장]을 제출해야 함.</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <p class="mt_20">※ [개인정보보호법 시행규칙 별지 제8호] 개인정보(열람, 정정·삭제, 처리정지) 요구서 <a href="/ssem/resources/download/privacy_1.hwp" class="btn btn_small btn_color_t ml_5">다운로드</a></p>
                    <p class="mt_5">※ [개인정보보호법 시행규칙 별지 제11호] 위임장 <a href="/ssem/resources/download/privacy_2.hwp" class="btn btn_small btn_color_t ml_5">다운로드</a></p>
                    <p class="mt_5">※ 개인정보 열람 등 요구절차</p>
                    <div class="line_box mt_10">
                        <img src="/ssem/resources/img/sub/pri_grp_img.jpg" alt="개인정보파일목록 검색 1. 알림창구, 청구 주체 확인 및 개인정보 열람 범위 확인, 1-1 열람결정 통지 (허용/제한/연기), 열람 1-2. 열람결정 통지(거부) 2. 정정 삭제, 처리정지 청구, 청구 주체 확인 및 개인정보 정정 삭제, 처리정지 범위 확인, 개인정보 정정 삭제, 처리정지 제한사항 확인,  2-1 정정  삭제, 처리정지 결과 통지, 2-2 정정 삭제, 처리정지 제한사항 통지 (거절, 타 법령곤련사항 등)">
                    </div>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제6조. 개인정보의 파기 절차 및 방법</p>
                    <p>송파구는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 해당 개인정보를 지체없이 파기합니다. 다만, 다른 법률에 따라 보존하여야 하는 경우에는 그러하지 않습니다.</p>
                    <ul class="ul_list_num">
                        <li>정보주체로부터 동의 받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, <br class="pc">해당 개인정보(또는 개인정보파일)는 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.</li>
                        <li>파기절차 : 파기 사유가 발생한 개인정보 선정 후, 파기계획 수립 및 분야별 개인정보보호 책임자의 승인하에 파기</li>
                        <li>파기방법 : 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록·저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제7조. 개인정보의 안전성 확보 조치</p>
                    <p>송파구는 개인정보의 안전성 확보를 위해 관리적·기술적·물리적 조치를 합니다.</p>
                    <ul class="ul_list_num">
                        <li>내부관리계획의 수립 및 시행 <br>송파구는 개인정보보호를 위해 내부관리계획을 수립하고 시행합니다.</li>
                        <li>개인정보의 암호화 <br>이용자의 개인정보 중 고유식별번호, 바이오정보, 비밀번호 등 중요정보는 암호화된 상태로 저장 관리되고 있습니다.</li>
                        <li>해킹 등에 대비한 기술적 대책 <br>해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적, 물리적으로 감시 및 차단하고 있습니다.</li>
                        <li>개인정보처리시스템 접근제한 <br>개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단접근을 통제하고 있습니다.</li>
                        <li>접속기록의 보관 및 위변조 방지 <br>개인정보처리시스템에 접속한 기록(웹 로그, 요약정보 등)을 최소 2년 이상 보관·관리하고 있으며, 접속기록이 위변조 및 도난, 분실되지 않도록 관리하고 있습니다.</li>
                        <li>비인가자에 대한 출입 통제 <br>개인정보를 보관하고 있는 개인정보시스템의 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.</li>
                        <li>문서보안을 위한 잠금장치 사용 <br>개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다.</li>
                        <li>개인정보 취급 직원의 최소화 및 교육 <br>개인정보를 취급하는 직원을 지정하고 최소화하고 있으며, 관련 규정 및 법규 등을 준수하도록 주기적인 교육을 하고 있습니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제8조. 인터넷 접속정보파일 등 개인정보를 자동으로 수집하는 장치의 설치·운영 및 거부에 관한 사항</p>

                    <ul class="ul_list_num">
                        <li>송파구 홈페이지 회원가입 및 이용 시 아래와 같은 정보가 자동으로 수집됩니다.<br>
                            - 접속로그<br>
                            - 쿠키<br>
                            - 접속IP정보<br>
                            - 홈페이지 접근경로<br>
                        </li>
                        <li>수집되는 정보의 용도<br>
                            자동수집된 정보는 부정이용 방지, 비인가 사용방지, 통계분석 등에 사용됩니다.
                        </li>
                        <li>쿠키<br>
                            송파구는 개인 맞춤서비스 제공 및 회원식별과 로그인 상태를 유지하기 위해서 이용자에 대한 정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다. 쿠키는 웹사이트 서버가 이용자의 브라우저에게전송하는 소량의 정보로서 이용자 컴퓨터의 하드디스크에 저장됩니다.
                        </li>
                        <li>쿠키 설치에 대한 선택권<br>
                            홈페이지 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 웹 브라우저에서 옵션을 조정함으로써 모든 쿠키를 허용/거부하거나, 쿠키가 저장될때마다 확인을 거치도록 할 수 있습니다. 다만, 쿠키 설치를 거부할 경우 사용이 불편해지며 일부 서비스 이용에 어려움이 있을 수 있습니다.<br>
                            [쿠키 설치 허용 여부를 지정하는 방법]<br>
                            - Internet Explorer의 경우 : 웹 브라우저 상단의 도구메뉴 > 인터넷옵션 > 개인정보 > 설정<br>
                            - Chrome의 경우 : 웹브라우저 우측의 설정메뉴 > 개인정보 및 보안
                        </li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제9조. 개인정보보호 책임자 및 담당자 연락처</p>
                    <ul class="ul_list_num">
                        <li>개인정보보호 책임자 : 송파구 행정안전국장 서명호 (02-2147-2040)</li>
                        <li>개인정보보호 담당자 : 정보통신과 김경욱 (02-2147-2411)</li>
                        <li>개인정보보호 분야별 책임자 : 개인정보를 처리하는 각 운영부서의 장</li>
                    </ul>
                </div>

                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제10조. 권익침해 구제방법</p>
                    <p>정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다. 아래기관은 송파구청과는 별개의 기관으로서 송파구청의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다.</p>
                    <ul class="ul_list_num">
                        <li>개인정보침해신고센터(한국인터넷진흥원 운영)
                            <ul class="ul_list_kr">
                                <li>소관업무 : 개인정보 침해사실 신고, 상담 신청</li>
                                <li>홈페이지 : privacy.kisa.or.kr</li>
                                <li>전화 : (국번없이 ) 118</li>
                                <li>주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터</li>
                            </ul>
                        </li>
                        <li> 개인정보분쟁조정위원회
                            <ul class="ul_list_kr">
                                <li>소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정(민사적 해결)</li>
                                <li>홈페이지 : www.kopico.go.kr</li>
                                <li>전화 : (국번없이 ) 1833-6972</li>
                                <li>주소 : (03171) 서울특별시 종로구 세종대로 209 정부서울청사 4층</li>
                            </ul>
                        </li>
                        <li>개인정보보호 종합지원 포털 (개인정보보호위원회 운영)
                            <ul class="ul_list_kr">
                                <li>소관업무 : 개인정보보호 교육, 상담 신청, 자료제공, 기술지원</li>
                                <li>홈페이지 : www.privacy.go.kr</li>
                                <li>전화 : 02-6952-8650</li>
                            </ul>
                        </li>
                        <li>경찰청 사이버안전국
                            <ul class="ul_list_kr">
                                <li>소관업무 : 개인정보 침해 관련 형사사건 문의 및 신고</li>
                                <li>홈페이지 : www.cyber.go.kr</li>
                                <li>전화 : (국번없이) 182(사이버범죄)</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제11조 영상정보처리기기의 설치 근거 및 설치 목적</p>
                    <p>송파구는 개인정보보호법 제25조제1항에 따라 다음과 같은 목적으로 영상정보처리기기를 설치·운영 합니다.</p>
                    <ul class="ul_list_num">
                        <li> 법령에서 구체적으로 허용하고 있는 경우</li>
                        <li> 범죄의 예방 및 수사를 위하여 필요한 경우</li>
                        <li> 시설안전 및 화재 예방을 위하여 필요한 경우</li>
                        <li> 교통단속을 위하여 필요한 경우</li>
                        <li> 교통정보의 수집 · 분석 및 제공을 위하여 필요한 경우</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제12조 영상정보처리기기 운영 현황 및 처리방법</p>
                    <p>송파구에서 운영 중인 영상정보처리기기의 설치위치, 설치대수, 설치목적 및 촬영범위는 아래와 같습니다.</p>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2">
                            <caption class="text_hide">영상정보처리기기 운영 현황 설치위치, 설치목적, 대수, 촬영범위, 담당부서 안내</caption>
                            <colgroup>
                                <col style="width:20%" />
                                <col style="width:20%" />
                                <col style="width:7%" />
                                <col />
                                <col style="width:20%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>설치위치</th>
                                <th>설치목적</th>
                                <th>대수</th>
                                <th>촬영범위</th>
                                <th>담당부서</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td>구청사 내외 76대<br><a href="download">(파일참조)</a></td><td>범죄예방, 시설관리</td><td>76</td><td>구청사 로비, 복도, 회의실,주차장, 청사 외곽 등</td><td>총무과</td></tr>
                            <tr><td rowspan="4" class="line_right">송파구 관내 1047개소<br><a href="download">(파일참조)</a></td><td>방범</td><td>1957</td><td>100m 이내</td><td rowspan="4">재난안전과</td></tr>
                            <tr><td>문화재관리</td><td>83</td><td>100m 이내</td></tr>
                            <tr><td>치수관리</td><td>112</td><td>30m 이내</td></tr>
                            <tr><td>주정차단속</td><td>222</td><td>단속지역이내</td></tr>
                            <tr><td>송파구 관내 48개소<br><a href="download">(파일참조)</a></td><td>무단투기단속</td><td>48</td><td>단속지역 이내</td><td>자원순환과</td></tr>
                            <tr><td>송파구청 7층사회복지과 사무실</td><td>범죄예방, 시설안전</td><td>4</td><td>복도, 출입구, 사무실, 상담실</td><td>사회복지과</td></tr>
                            <tr><td>송파구청 6층주거사업과 사무실</td><td>보안 및 시설관리</td><td>4</td><td>주거사업과 사무실</td><td>주거사업과</td></tr>
                            <tr><td>송파구청 2층민원여권과 사무실</td><td>범죄예방, 시설관리,민원담당공무원보호</td><td>7</td><td>민원여권과 민원실 내부</td><td>민원여권과</td></tr>
                            <tr><td>올림픽로 326보건소 사무실</td><td>보안 및 시설관리</td><td>9</td><td>보건소 건물 내부</td><td>보건위생과</td></tr>
                            <tr><td>충민로184<br>(송파구 치매안심센터)</td><td>보안 및 시설관리</td><td>16</td><td>주차장, 가족소모임실, 가족카페,<br>검진실, 로비, 로비후문, 쉼터,<br>작업치료실, 프로그램실,<br>지하사무실</td><td rowspan="2">의약과</td></tr>
                            <tr><td>양산로5<br>(송파구 정신건강복지센터)</td><td>보안 및 시설관리</td><td>4</td><td>프로그램실 출입구,<br>프로그램실 내부</td></tr>
                            <tr><td>송파대로37길 77<br>(송파 책 박물관)</td><td>보안 및 시설관리</td><td>97</td><td>1층 : 출입구, 로비<br>2층 : 로비, 전시실, 야외정원옥상계단실, 엘리베이터앞, 옥상, 주차장, 기계실, 전기실화장실 앞, 야외세면대,안내데스크체험전시실, 오픈스튜디오, 2층 전시실</td><td>송파책박물관</td></tr>
                            <tr><td>양산로5<br>(송파구 보건지소)</td><td>청사 보안 및 화재 예방 등 시설관리</td><td>10</td><td>보건지소 건물 내부(엘리베이터, 민원안내실, 각층 복도 등) 및 외부 주차장</td><td>보건지소</td></tr>
                            <tr><td>백제고분로242<br>(송파구 의회)</td><td>보안 및 시설관리</td><td>16</td><td>각층 로비, 지하</td><td>의회사무국</td></tr>
                            <tr><td>백제고분로 392<br>(송파1동 주민센터)</td><td>보안 및 시설관리</td><td>10</td><td>1층 : 민원실, 출입구, 장애인주차구역<br>2층 : 새마을문고, 북카페,<br>4층 : 식당승강기 내부</td><td>송파1동 주민센터</td></tr>
                            <tr><td>중대로 16<br>(문정2동 주민센터)</td><td>보안 및 시설관리</td><td>16</td><td>1층 : 정문, 민원실, 주민등록보관실, 새마을문고2층 : 복도, 서고외부 : 주차장</td><td>문정2동 주민센터</td></tr>
                            <tr><td>오금로53길 32<br>(거여1동 주민센터)</td><td>보안 및 시설관리</td><td>3</td><td>1층 : 민원실, 직원실 지하1층 헬스장</td><td>거여1동 주민센터</td></tr>
                            <tr><td>양재대로 925<br>(가락1동 주민센터)</td><td>보안 및 시설관리</td><td>23</td><td>1층: 복도, 민원실, 사무실2층: 카페, 복도, 사무실3층: 계단, 복도, 강당지하: 기계실, 복도주차장: 2대</td><td>가락1동주민센터</td></tr>
                            <tr><td>새말로19길 6<br>(장지동 주민센터)</td><td>보안 및 시설관리</td><td>8</td><td>동청사 입구, 1층 : 민원실, 로비, 인감실, 지하1층 : 헬스장, 헬스장 입구, 2층 : 계단</td><td>장지동 주민센터</td></tr>
                            <tr><td>올림픽로 159<br>(잠실2동 주민센터)</td><td>보안 및 시설관리</td><td>9</td><td>1층민원실, 2층북카페,후문통로, 외부주차장 </td><td>잠실2동 주민센터</td></tr>
                            <tr><td>양재대로 1232<br>(오륜동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>1층:민원실2대2층:복도1대지하:복도1대</td><td>오륜동 주민센터</td></tr>
                            <tr><td>천호대로152길 7<br>(풍납1동 주민센터</td><td>보안 및 시설관리</td><td>6</td><td>1층 : 민원실, 주민등록실, 청사입구, 청사보조입구2층헬스장, 3층복도</td><td>풍납1동주민센터</td></tr>
                            <tr><td>올림픽로4길 7 2층<br>(잠실7동 주민센터)</td><td>보안 및 시설관리</td><td>2</td><td>민원실,서고</td><td>잠실7동 주민센터</td></tr>
                            <tr><td>잠실로 51-31<br>(잠실3동 주민센터)</td><td>보안 및 시설관리</td><td>2</td><td>1층민원실 및 사무실</td><td>잠실3동 주민센터</td></tr>
                            <tr><td>석촌호수로155<br>(잠실3동 자치회관 2관)</td><td>보안 및 시설관리</td><td>6</td><td>1층 : 건물 내부 복도, 주출입구, 지하1층 : 복도, 헬스장3층 : 복도주차장</td><td>잠실3동 주민센터</td></tr>
                            <tr><td>마천로287<br>(마천2동 주민센터)</td><td>보안 및 시설관리</td><td>5</td><td>1층 : 민원실, 출입문(후문), 2층 : 입구</td><td>마천2동 주민센터</td></tr>
                            <tr><td>동남로 116<br>(문정1동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>1층 : 민원실, 탕비실, 후문, 외부 무인택배함</td><td>문정1동주민센터</td></tr>
                            <tr><td>송이로 32<br>(송파2동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>1층 : 민원실, 주민등록실, 출입구2층 : 로비</td><td>송파2동 주민센터</td></tr>
                            <tr><td>토성로 64<br>(풍납2동 주민센터)</td><td>보안 및 시설관리</td><td>3</td><td>2층 : 민원실, 인감실주차장</td><td>풍납2동주민센터</td></tr>
                            <tr><td>위례성대로16길 22<br>(방이1동 주민센터)</td><td>보안 및 시설관리</td><td>6</td><td>1층 : 민원실, 문서고, 후문입구,주차장, 청사측면</td><td>방이1동 주민센터</td></tr>
                            <tr><td>올림픽로35길 16<br>(잠실4동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>1층 : 민원실 및 사무실지하 : 헬스장 복도</td><td>잠실4동 주민센터</td></tr>
                            <tr><td>백제고분로15길 9<br>(잠실본동 주민센터)</td><td>보안 및 시설관리</td><td>3</td><td>1층민원실</td><td>잠실본동주민센터</td></tr>
                            <tr><td>위례광장로 210<br>(위례동 주민센터)</td><td>보안 및 시설관리</td><td>35</td><td>1층 : 민원실, 로비<br>2층 : 복도<br>3층 : 복도, 다목적실 4,<br>5층 : 도서관, 지하주차장, 주민센터 외부</td><td>위례동주민센터</td></tr>
                            <tr><td>올림픽로35길 120<br>(잠실6동 주민센터)</td><td>보안 및 시설관리</td><td>2</td><td>청사 입구, 자치회관 입구, 민원실</td><td>잠실6동 주민센터</td></tr>
                            <tr><td>송파대로28길 39<br>(가락본동 주민센터)</td><td>보안 및 시설관리</td><td>11</td><td>지하헬스장1층 : 민원실, 문고2층 : 계단, 복도</td><td>가락본동 주민센터</td></tr>
                            <tr><td>마천로 303<br>(마천1동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>1층 : 민원실, 출입구청사 외부, 지하출입구</td><td>마천1동 주민센터</td></tr>
                            <tr><td>백제고분로37길 16<br>(석촌동 주민센터)</td><td>보안 및 시설관리</td><td>30</td><td>1층 : 청사 입구, 어린이집<br>2층 : 민원실<br>3층 : 복도<br>4층 : 다목적실<br>5층 : 도서관 </td><td>석촌동 주민센터</td></tr>
                            <tr><td>동남로20길 6<br>(가락2동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>민원실, 상담실 및 청사 입구</td><td>가락2동 주민센터</td></tr>
                            <tr><td>중대로25길 5<br>(오금동 주민센터)</td><td>보안 및 시설관리</td><td>4</td><td>민원실, 부출입구, 청사 외부, 주차장</td><td>오금동 주민센터</td></tr>
                            <tr><td>거마로2길 19<br>(거여2동 주민센터)</td><td>보안 및 시설관리</td><td>16</td><td>지하1층 : 주차장, 헬스장1층 : 민원실, 주차장2층:복도,3층:강당</td><td>거여2동 주민센터</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <p class="mt_40"> 송파구는 개인영상정보를 보호하고 개인영상정보와 관련한 불만을 처리하기 위하여 아래와 같이 개인영상정보 관리책임자를 두고 있습니다.</p>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2">
                            <caption class="text_hide">개인영상정보 관리책임자 설치위치, 관리부서, 대수, 관리책임자, 접근권한자 안내 </caption>
                            <colgroup>
                                <col style="width:20%">
                                <col style="width:15%">
                                <col style="width:5%">
                                <col style="width:10%">
                                <col style="width:10%">
                                <col style="width:10%">
                                <col style="width:10%">
                                <col style="width:10%">
                                <col style="width:10%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th rowspan="2" class="line_right">설치위치</th>
                                <th rowspan="2" class="line_right">관리부서</th>
                                <th rowspan="2" class="line_right">대수</th>
                                <th colspan="3">관리책임자</th>
                                <th colspan="3">접근권한자</th>
                            </tr>
                            <tr>
                                <th>직위</th>
                                <th>성명</th>
                                <th>연락처</th>
                                <th>직위</th>
                                <th>성명</th>
                                <th>연락처</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td>구청사 내외 16개소<br><a href="download">(파일참조)</a></td><td>총무과</td><td>76</td><td>총무과장</td><td>형성구</td><td>2147-2123</td><td>주무관</td><td>이현철</td><td >2147-2132</td></tr>
                            <tr><td rowspan="6" class="line_right">송파구 관내 1047개소<br><a href="download">(파일참조)</a></td><td rowspan="6" class="line_right">재난안전과</td><td>446</td><td>공원녹지과장</td><td>정상범</td><td>2147-3383</td><td>주무관</td><td>김길오</td><td >2147-3393</td></tr>
                            <tr><td>294</td><td>교통과장</td><td>황영록</td><td>2147-3123</td><td>주무관</td><td>최수진</td><td >2147-3140</td></tr>
                            <tr><td>1217</td><td>재난안전과장</td><td>김지봉</td><td>2147-3093</td><td>주무관</td><td>김영호</td><td >2147-3111</td></tr>
                            <tr><td>83</td><td>역사문화재과장</td><td>강재원</td><td>2147-2002</td><td>주무관</td><td>임창국</td><td >2147-2013</td></tr>
                            <tr><td>112</td><td>치수과장</td><td>이인규</td><td>2147-3343</td><td>주무관</td><td>김선대</td><td >2147-3370</td></tr>
                            <tr><td>222</td><td>주차관리과장</td><td>윤인호</td><td>2147-3193</td><td>주무관</td><td>우점자</td><td >2147-3213</td></tr>
                            <tr><td>송파구 관내 48개소<br><a href="download">(파일참조)</a></td><td>자원순환과</td><td>48</td><td>자원순환과장</td><td>황준철</td><td>2147-2843</td><td>주무관</td><td>김선수</td><td >2147-2865</td></tr>
                            <tr><td>송파구청 7층<br>사회복지과 사무실</td><td>사회복지과</td><td>4</td><td>사회복지과장</td><td>김선경</td><td>2147-2723</td><td>주무관</td><td>박민경</td><td >2147-2727</td></tr>
                            <tr><td>송파구청 6층<br>주거사업과 사무실</td><td>주거사업과</td><td>4</td><td>주거사업과장</td><td>지부근</td><td>2147-2883</td><td>주무관</td><td>최윤설</td><td >2147-2887</td></tr>
                            <tr><td>송파구청 2층<br>민원여권과 사무실</td><td>민원여권과</td><td>7</td><td>민원여권과장</td><td>조강수</td><td>2147-2293</td><td>주무관</td><td>임주희</td><td >2147-2296</td></tr>
                            <tr><td>올림픽로 326보건소 사무실</td><td>보건위생과</td><td>9</td><td>보건위생과장</td><td>금미경</td><td>2147-3423</td><td>주무관</td><td>박꽃나래</td><td >2147-3444</td></tr>
                            <tr><td>충민로184<br>(송파구 치매안심센터)</td><td rowspan="2" class="line_right">의약과</td><td>16</td><td rowspan="2" class="line_right">의약과장</td><td rowspan="2" class="line_right">김경선</td><td rowspan="2" class="line_right">2147-3524</td><td>주무관</td><td>이효구</td><td >2147-5056</td></tr>
                            <tr><td>양산로5<br>(송파구 정신건강복지센터)</td><td>4</td><td>주무관</td><td>구휴정</td><td >2147-5041</td></tr>
                            <tr><td>송파대로37길 77<br>(송파 책 박물관)</td><td>송파책박물관</td><td>97</td><td>관장</td><td>강재원</td><td>2147-2002</td><td>주무관</td><td>김아름</td><td >2147-2501</td></tr>
                            <tr><td>양산로5<br>(송파구 보건지소)</td><td>보건지소</td><td>10</td><td>보건지소장</td><td>김병선</td><td>2147-4856</td><td>주무관</td><td>현해연</td><td >2147-4860</td></tr>
                            <tr><td>백제고분로242<br>(송파구 의회)</td><td>의회사무국</td><td>16</td><td>의회사무국장</td><td>인금철</td><td>2147-3641</td><td>주무관</td><td>김명광</td><td >2147-3649</td></tr>
                            <tr><td>백제고분로 392<br>(송파1동 주민센터)</td><td>송파1동 주민센터</td><td>10</td><td>동장</td><td>박득용</td><td>2147-4303</td><td>주무관</td><td>김건우</td><td >2147-4307</td></tr>
                            <tr><td>중대로 16<br>(문정2동 주민센터)</td><td>문정2동 주민센터</td><td>16</td><td>동장</td><td>박찬옥</td><td>2147-4543</td><td>주무관</td><td>변인섭</td><td >2147-4546</td></tr>
                            <tr><td>오금로53길 32<br>(거여1동 주민센터)</td><td>거여1동 주민센터</td><td>3</td><td>동장</td><td>조재현</td><td>2147-4063</td><td>주무관</td><td>배요천</td><td >2147-4068</td></tr>
                            <tr><td>양재대로 925<br>(가락1동 주민센터)</td><td>가락1동주민센터</td><td>23</td><td>동장</td><td>한명원</td><td>2147-4453</td><td>주무관</td><td>김용일</td><td >2147-4467</td></tr>
                            <tr><td>새말로19길 6<br>(장지동 주민센터)</td><td>장지동 주민센터</td><td>8</td><td>동장</td><td>노핵</td><td>2147-4573</td><td>주무관</td><td>선혜리</td><td >2147-4598</td></tr>
                            <tr><td>올림픽로 159<br>(잠실2동 주민센터)</td><td>잠실2동 주민센터</td><td>9</td><td>동장</td><td>정용석</td><td>2147-4633</td><td>주무관</td><td>정다니</td><td >2147-4641</td></tr>
                            <tr><td>양재대로 1232<br>(오륜동 주민센터)</td><td>오륜동 주민센터</td><td>4</td><td>동장</td><td>이진희</td><td>2147-4240</td><td>주무관</td><td>성영기</td><td >2147-4246</td></tr>
                            <tr><td>천호대로152길 7<br>(풍납1동 주민센터</td><td>풍납1동주민센터</td><td>6</td><td>동장</td><td>박근</td><td>2147-4003</td><td>주무관</td><td>안성화</td><td >2147-4008</td></tr>
                            <tr><td>올림픽로4길 7 2층<br>(잠실7동 주민센터)</td><td>잠실7동 주민센터</td><td>2</td><td>동장</td><td>금달호</td><td>2147-4753</td><td>주무관</td><td>김민선</td><td >2147-4758</td></tr>
                            <tr><td>잠실로 51-31<br>(잠실3동 주민센터)</td><td>잠실3동 주민센터</td><td>2</td><td>동장</td><td>공연규</td><td>2147-4663</td><td>주무관</td><td>홍은선</td><td >2147-4672</td></tr>
                            <tr><td>석촌호수로155<br>(잠실3동 자치회관 2관)</td><td>잠실3동 주민센터</td><td>6</td><td>동장</td><td>공연규</td><td>2147-4663</td><td>주무관</td><td>홍은선</td><td >2147-4672</td></tr>
                            <tr><td>마천로287<br>(마천2동 주민센터)</td><td>마천2동 주민센터</td><td>5</td><td>동장</td><td>조태선</td><td>2147-4153</td><td>주무관</td><td>박희진</td><td >2147-4163</td></tr>
                            <tr><td>동남로 116<br>(문정1동 주민센터)</td><td>문정1동주민센터</td><td>4</td><td>동장</td><td>이강석</td><td>2147-4513</td><td>주무관</td><td>김가을</td><td >2147-4522</td></tr>
                            <tr><td>송이로 32<br>(송파2동 주민센터)</td><td>송파2동 주민센터</td><td>4</td><td>동장</td><td>장광원</td><td>2147-4333</td><td>주무관</td><td>강수빈</td><td >2147-4349</td></tr>
                            <tr><td>토성로 64<br>(풍납2동 주민센터)</td><td>풍납2동주민센터</td><td>3</td><td>동장</td><td>임병찬</td><td>2147-4033</td><td>주무관</td><td>강사영</td><td >2147-4040</td></tr>
                            <tr><td>위례성대로16길 22<br>(방이1동 주민센터)</td><td>방이1동 주민센터</td><td>6</td><td>동장</td><td>김명진</td><td>2147-4183</td><td>주무관</td><td>김보영</td><td >2147-4192</td></tr>
                            <tr><td>올림픽로35길 16<br>(잠실4동 주민센터)</td><td>잠실4동 주민센터</td><td>4</td><td>동장</td><td>이상필</td><td>2147-4693</td><td>주무관</td><td>이윤주</td><td >2147-4698</td></tr>
                            <tr><td>백제고분로15길 9<br>(잠실본동 주민센터)</td><td>잠실본동주민센터</td><td>3</td><td>동장</td><td>박종길</td><td>2147-4603</td><td>주무관</td><td>박슬빈</td><td >2147-4607</td></tr>
                            <tr><td>위례광장로 210<br>(위례동 주민센터)</td><td>위례동주민센터</td><td>35</td><td>동장</td><td>이은주</td><td>2147-4951</td><td>주무관</td><td>김성원</td><td >2147-4959</td></tr>
                            <tr><td>올림픽로35길 120<br>(잠실6동 주민센터)</td><td>잠실6동 주민센터</td><td>2</td><td>동장</td><td>정영자</td><td>2147-4723</td><td>주무관</td><td>이종언</td><td >2147-4734</td></tr>
                            <tr><td>송파대로28길 39<br>(가락본동 주민센터)</td><td>가락본동 주민센터</td><td>11</td><td>동장</td><td>이석우</td><td>2147-4423</td><td>주무관</td><td>이수인</td><td >2147-4432</td></tr>
                            <tr><td>마천로 303<br>(마천1동 주민센터)</td><td>마천1동 주민센터</td><td>4</td><td>동장</td><td>오미자</td><td>2147-4123</td><td>주무관</td><td>이용섭</td><td >2147-4128</td></tr>
                            <tr><td>백제고분로37길 16<br>(석촌동 주민센터)</td><td>석촌동 주민센터</td><td>30</td><td>동장</td><td>이한희</td><td>2147-4363</td><td>주무관</td><td>이수민</td><td >2147-4368</td></tr>
                            <tr><td>동남로20길 6<br>(가락2동 주민센터)</td><td>가락2동 주민센터</td><td>4</td><td>동장</td><td>안재승</td><td>2147-4483</td><td>주무관</td><td>김유나</td><td >2147-4492</td></tr>
                            <tr><td>중대로25길 5<br>(오금동 주민센터)</td><td>오금동 주민센터</td><td>4</td><td>동장</td><td>김석종</td><td>2147-4273</td><td>주무관</td><td>김덕우</td><td >2147-4295</td></tr>
                            <tr><td>거마로2길 19(거여2동 주민센터)</td><td>거여2동 주민센터</td><td>16</td><td>동장</td><td>이남규</td><td>2147-4093</td><td>주무관</td><td>안홍기</td><td >2147-4096</td></tr>
                            </tbody>
                        </table>
                    </div>
                    <p class="mt_40"> 영상정보의 촬영시간, 보관기간, 보관장소 및 처리방법은 아래와 같습니다.</p>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2">
                            <caption class="text_hide">영상정보 설치위치, 대수, 영상 보관장소, 촬영시간, 보관기간, 보관장소, 처리방법 안내</caption>
                            <colgroup>
                                <col sylte="width:30%">
                                <col sylte="width:5%">
                                <col sylte="width:25%">
                                <col sylte="width:10%">
                                <col sylte="width:15%">
                                <col sylte="width:*">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>설치위치</th>
                                <th>대수</th>
                                <th>영상 보관장소</th>
                                <th>촬영시간</th>
                                <th>보관기간</th>
                                <th>처리방법</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr><td>구청사 내외 16개소<br><a href="download">(파일참조)</a></td><td>76</td><td>종합상황실</td><td>24시간</td><td>10~15일</td><td  rowspan="40">개인영상정보의 목적 외 이용, 제3자 제공, 파기, 열람 등 요구에 관한 사항을 기록·관리하고, 보관기간 만료 시 복원이 불가능한 방법으로 영구삭제(출력물의 경우 파쇄 또는 소각)합니다.</td></tr>
                            <tr><td>송파구 관내 1047개소<br><a href="download">(파일참조)</a></td><td>2374</td><td>CCTV통합관제센터</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>송파구 관내 48개소<br><a href="download">(파일참조)</a></td><td>48</td><td>CCTV 내부</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>송파구청 7층<br>사회복지과 사무실</td><td>4</td><td>상담실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>송파구청 6층<br>주거사업과 사무실</td><td>4</td><td>주거사업과</td><td>24시간</td><td>40일</td></tr>
                            <tr><td>송파구청 2층민원여권과 사무실</td><td>7</td><td>민원여권과</td><td>24시간</td><td>10~15일</td></tr>
                            <tr><td>올림픽로 326보건소 사무실</td><td>9</td><td>보건소 당직실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>충민로184(송파구 치매안심센터)</td><td>16</td><td>지하사무실 서고</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>양산로5(송파구 정신건강복지센터)</td><td>4</td><td>보건지소 2층센터사무실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td rowspan="3" class="line_right">송파대로37길 77(송파 책 박물관)</td><td>68</td><td>지하1층 방재실</td><td rowspan="3" class="line_right">24시간</td><td>30일</td></tr>
                            <tr><td>7</td><td>안내데스크</td><td>30일</td></tr>
                            <tr><td>22</td><td>지하1층 자료실</td><td>270일</td></tr>
                            <tr><td>양산로5(송파구 보건지소)</td><td>10</td><td>1층 사무실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>백제고분로242(송파구 의회)</td><td>16</td><td>1층 안내실(보안실)</td><td>24시간</td><td>10일</td></tr>
                            <tr><td>백제고분로 392(송파1동 주민센터)</td><td>10</td><td>1층 주민등록실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>중대로 16(문정2동 주민센터)</td><td>16</td><td>문정2동 주민센터</td><td>24시간</td><td>28일</td></tr>
                            <tr><td>오금로53길 32(거여1동 주민센터)</td><td>3</td><td>1층 직원실</td><td>24시간</td><td>21일(자동삭제)</td></tr>
                            <tr><td>양재대로 925(가락1동 주민센터)</td><td>23</td><td>1층 MDF실</td><td>24시간</td><td>21일</td></tr>
                            <tr><td>새말로19길 6(장지동 주민센터)</td><td>8</td><td>1층 탕비실</td><td>24시간</td><td>15일</td></tr>
                            <tr><td>올림픽로 159(잠실2동 주민센터)</td><td>9</td><td>1층 직원실</td><td>24시간</td><td>30일(자동삭제)</td></tr>
                            <tr><td>양재대로 1232(오륜동 주민센터)</td><td>4</td><td>1층 서고</td><td>24시간</td><td>&nbsp;&nbsp;30일</td></tr>
                            <tr><td>천호대로152길 7(풍납1동 주민센터</td><td>6</td><td>1층 직원실</td><td>24시간</td><td>21일(자동삭제)</td></tr>
                            <tr><td>올림픽로4길 7 2층(잠실7동 주민센터)</td><td>2</td><td>2층 서고</td><td>24시간</td><td>72일</td></tr>
                            <tr><td>잠실로 51-31(잠실3동 주민센터)</td><td>2</td><td>사무실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>석촌호수로155(잠실3동 자치회관 2관)</td><td>6</td><td>잠실3동자치회관2관</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>마천로287(마천2동 주민센터)</td><td>5</td><td>1층 직원실</td><td>24시간</td><td>30일(자동삭제)</td></tr>
                            <tr><td>동남로 116(문정1동 주민센터)</td><td>4</td><td>1층 탕비실</td><td>24시간</td><td>25일</td></tr>
                            <tr><td>송이로 32(송파2동 주민센터)</td><td>4</td><td>1층 직원실</td><td>24시간</td><td>30일(자동삭제)</td></tr>
                            <tr><td>토성로 64(풍납2동 주민센터)</td><td>3</td><td>2층 인감실</td><td>24시간(움직임 감지시)</td><td>약 90일</td></tr>
                            <tr><td>위례성대로16길 22(방이1동 주민센터)</td><td>6</td><td>1층 문서고</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>올림픽로35길 16(잠실4동 주민센터)</td><td>4</td><td>1층 사무실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>백제고분로15길 9(잠실본동 주민센터)</td><td>3</td><td>1층 민원대 뒤</td><td>24시간(움직임 감지시)</td><td>14일</td></tr>
                            <tr><td>위례광장로 210(위례동 주민센터)</td><td>35</td><td>청사 감시실</td><td>24시간</td><td>30일</td></tr>
                            <tr><td>올림픽로35길 120(잠실6동 주민센터)</td><td>2</td><td>2층 인감서고</td><td>24시간</td><td>57일</td></tr>
                            <tr><td>송파대로28길 39(가락본동 주민센터)</td><td>11</td><td>청사 내 CCTV 기록장치</td><td>24시간(움직임 감지시)</td><td>30일(자동삭제)</td></tr>
                            <tr><td>마천로 303(마천1동 주민센터)</td><td>4</td><td>1층 사무실</td><td>24시간(움직임 감지시)</td><td>25일</td></tr>
                            <tr><td>백제고분로37길 16(석촌동 주민센터)</td><td>30</td><td>청사 내 CCTV 기록장치(지하1층)</td><td>24시간(움직임 감지시)</td><td>30일(자동삭제)</td></tr>
                            <tr><td>동남로20길 6(가락2동 주민센터)</td><td>4</td><td>1층 민원실 기기보관함</td><td>24시간</td><td>30일(자동삭제)</td></tr>
                            <tr><td>중대로25길 5(오금동 주민센터)</td><td>4</td><td>1층 인감실</td><td>24시간</td><td>14~21일(자동삭제)</td></tr>
                            <tr><td>거마로2길 19(거여2동 주민센터)</td><td>16</td><td>1층 동장실</td><td>24시간</td><td>30일</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">13조. 개인영상정보의 확인방법 및 장소에 관한 사항</p>
                    <ul class="ul_list_num st_2">
                        <li>개인영상정보에 관하여 열람 또는 존재확인·삭제를 원하는 경우 언제든지 영상정보 처리기기 관리책임자에게 요구하실 수 있습니다. 단, 귀하가 촬영된 개인영상정보 및 명백히 정보주체의 급박한 생명, 신체, 재산의 이익을 위하여 필요한 개인영상정보에 한정됩니다.</li>
                        <li>제12조제2항의 관리책임자 또는 관리담당자에게 미리 연락하고, 담당부서를 방문하시면 확인 가능합니다.</li>
                    </ul>
                    <p> ※ 별지 제2호 서식 <a href="/ssem/resources/download/privacy_3.hwp" class="btn btn_small btn_color_t ml_5">다운로드</a></p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">14조. 정보주체의 영상정보 열람 등 요구에 대한 조치</p>
                    <ul class="ul_list_num st_2">
                        <li> 송파구는 개인영상정보에 관하여 열람 또는 존재확인 · 삭제를 요구받은 경우 지체 없이 필요한 조치를 하겠습니다.</li>
                        <li> 다음 각 호의 경우에는 정보주체의 개인영상정보 열람 등 요구를 거부할 수 있습니다. 이 경우 관리책임자는 10일 이내에 서면 등으로 거부 사유를 정보주체에게 통지합니다.
                            <ul class="ul_list_num">
                                <li>범죄수사·공소유지·재판수행에 중대한 지장을 초래하는 경우</li>
                                <li>개인영상정보의 보관기간이 경과하여 파기한 경우</li>
                                <li>열람 등 요구에 대하여 필요한 조치를 취함으로써 타인의 사생활권이 침해될 우려가 큰 경우</li>
                                <li>기타 정보주체의 열람 등 요구를 거부할 만한 정당한 사유가 존재하는 경우</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">15조. 협약에 따른 영상관리</p>
                    <p>송파구는 개인의 영상정보가 안전하게 관리될 수 있도록 아래와 같이 관계 법령 및 협약에 따라 영상정보를 관리하고 있습니다.</p>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2" cellspacing="0" cellpadding="0">
                           <caption class="text_hide">영상정보의 협약기관, 담당자, 연락처 안내</caption>
                            <colgroup>
                                <col width="33.3%">
                                <col width="33.3%">
                                <col width="33.3%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th class="first">협약기관</th>
                                <th>담당자</th>
                                <th>연락처</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="first">송파경찰서</td>
                                <td>생활안전과 담당</td>
                                <td >02-3402-6455</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <p>※협약내용: 관내 영상정보처리기기의 영상정보를 범죄 수사자료로 활용</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">16조. 영상정보처리기기 설치 및 관리 등의 위탁에 관한 사항</p>
                    <p>송파구는 아래와 같이 영상정보처리기기 설치 및 관리 등을 위탁하고 있으며, 관계 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.</p>
                    <p class="mt_20 screen_hide screen_md_show fs_md_20 t_right tc_1">오른쪽으로 스크롤 해주세요 &gt;</p>
                    <div class="table_box mt_20 mt_md_0">
                        <table class="st_2" cellspacing="0" cellpadding="0">
                            <caption  class="text_hide">영상정보처리기기 설치 및 관리 등의 위탁에 관한 사항의 연번, 부서명, 업무내용 안내 </caption>
                            <colgroup>
                                <col width="5%">
                                <col width="15%">
                                <col width="*">
                                <col width="15%">
                                <col width="15%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th rowspan="2" class="first line_right">연번</th>
                                <th rowspan="2" class="line_right">부서명</th>
                                <th rowspan="2" class="line_right">업무내용</th>
                                <th colspan="2">수탁업체</th>
                            </tr>
                            <tr>
                                <th>업체명</th>
                                <th>연락처</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="first">1</td>
                                <td>재난안전과</td>
                                <td>CCTV 및 통합관제센터 유지보수</td>
                                <td>㈜윈투스시스템</td>
                                <td >2147-4659</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <p>※협약내용: 관내 영상정보처리기기의 영상정보를 범죄 수사자료로 활용</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">17조. 영상정보의 안전성 확보조치</p>
                    <p>송파구에서 처리하는 영상정보는 암호화 조치 등을 통하여 안전하게 관리되고 있습니다. 또한 본 기관은 개인영상정보보호를 위한 관리적 대책으로서 개인정보에 대한 접근권한을 차등부여하고 있고, 개인영상정보의 위·변조 방지를 위하여 개인영상정보의 생성일시, 열람 시 열람 목적·열람자·열람 일시 등을 기록하여 관리하고 있습니다. 이 외에도 개인영상정보의 안전한 물리적 보관을 위하여 잠금장치를 설치하고 있습니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">18조. 개인정보처리방침의 변경에 관한 사항</p>
                    <p>분야별로 관리되는 개인정보파일의 추가, 삭제, 정정 등이 발생하는 경우 별도의 고지를 생략합니다. 이 개인정보 처리방침은 2020년 9월 16일부터 적용되며, 이전의 개인정보 처리방침은 아래에서 확인할 수 있습니다.</p>
                    <p> ※ 이전 방침 바로가기 <a href="/ssem/resources/download/privacy_4.zip" class="btn btn_small btn_color_t ml_5">다운로드</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
