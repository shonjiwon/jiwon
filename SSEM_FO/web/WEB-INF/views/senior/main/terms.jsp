<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-05
  Time: 오후 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '이용약관 > 평생교육 > 송파쌤');

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
                    이용약관
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
                        <a href="#" class="deapth_tit" title="선택">이용약관</a>
                        <ul>
                            <li><a href="/ssem/senior/main/privacy.do">개인정보처리방침</a></li>
                            <li><a href="/ssem/senior/main/mail.do">이메일주소 무단수집거부</a></li>
                            <li><a href="/ssem/senior/main/copyright.do">저작권정책</a></li>
                            <li><a href="/ssem/senior/main/terms.do">이용약관</a></li>
                            <li><a href="/ssem/senior/main/sitemap.do">사이트맵</a></li>
                            <li><a href="/ssem/senior/main/family_site.do">패밀리사이트</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">이용약관</h3>
                </div>
            </div>
        </div>
        <div class="wrap text_con fs_20 fs_md_26 pb_100 mb_15">
            <h4 class="mt_25 mb_5 fw_500">제1장 총칙</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제1조 (목적)</p>
                    <p>이 약관은 서울특별시 송파구청 (이하 "송파구"라 합니다) 홈페이지(송파구에서 운영관리하는 온라인상의 모든 홈페이지를 지칭함)가 제공하는 통합회원 서비스(이하 "서비스"라 합니다)를 이용함에 있어 이용자와 송파구간의 권리ㆍ의무 및 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제2조 (약관의 효력 및 변경)</p>
                    <ul class="ul_list_num2">
                        <li>이 약관은 서비스 화면에 게시하거나 기타의 방법으로 공지함으로써 이용자에게 공시하고, 이에 동의한 이용자가 서비스에 가입함으로써 효력이 발생합니다.</li>
                        <li>송파구는 필요하다고 인정되는 경우 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 서비스 화면에 공지함으로써 이용자가 직접 확인할 수 있도록 할 것입니다.</li>
                        <li>이용자는 이 약관에 동의하지 않으실 경우 본인의 회원등록을 취소할 수 있으며,계속 사용하시는 경우에는 약관 변경에 동의한 것으로 간주되며 변경된 약관은 전항과 같은 방법으로 효력이 발생합니다.</li>
                        <li>이용자가 이 약관의 내용에 동의하는 경우 송파구의 서비스 제공행위 및 이용자의 서비스 이용행위에는 이 약관이 우선적으로 적용될 것입니다. 이 약관에 명시되지 않은 사항에 대해서는 전기통신기본법, 전기통신사업법, 정보통신망이용촉진및정보 보호등에관한법률, 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 프로그램 보호법 등 기타 대한민국의 관련법령과 상관습에 의합니다.</li>
                    </ul>
                </div>
            </div>

            <h4 class="mt_40 mb_5 fw_500">제2장 서비스 이용계약</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제4조 (이용계약의 성립)</p>
                    <p>이용계약은 이용자의 약관내용에 대한 동의와 이용자의 이용신청에 대한 송파구의 승낙으로 성립합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제5조 (이용신청)</p>
                    <p>이용신청은 서비스의 회원정보 화면에서 이용자가 송파구에서 요구하는 가입신청 양식에 개인의 신상정보를 기록하는 방식으로 신청합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제6조 (이용신청의 승낙)</p>
                    <ul class="ul_list_num2">
                        <li>송파구는 제5조에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙합니다.</li>
                        <li>송파구는 다음 각 호에 해당하는 경우에 대하여는 그 신청에 대한 제한 사유가 해소될 때까지 승낙을 유보 또는 일부 서비스 이용을 제한할 수 있습니다.
                            <ul class="ul_list_num">
                                <li>내용이 허위(차명, 비실명, 주민등록번호 도용 등)인 것으로 판명되거나, 그러하다고 의심할만한 합리적인 사유가 발생할 경우</li>
                                <li>기타 송파구가 필요하다고 인정되는 경우</li>
                            </ul>
                        </li>
                        <li>송파구는 다음에 해당하는 경우에는 이용신청을 승낙하지 아니할 수 있습니다.
                            <ul class="ul_list_num">
                                <li>본인의 실명으로 신청하지 않았을 때</li>
                                <li>다른 사람의 명의를 사용하여 신청하였을 때</li>
                                <li>신청서의 내용을 허위로 기재하였을 때</li>
                                <li>사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때</li>
                                <li>기타 송파구가 정한 이용신청 요건이 미비 되었을 때</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제7조 (계약사항의 변경)</p>
                    <p>회원은 회원정보관리를 통해 언제든지 자신의 정보를 열람하고 수정할 수 있습니다. 회원은 이용신청 시 기재한 사항이 변경되었을 때에는 수정을 하여야 하며, 수정하지 아니하여 발생하는 문제의 책임은 회원에게 있습니다.</p>
                </div>
            </div>

            <h4 class="mt_40 mb_5 fw_500">제3장 서비스 제공 및 이용</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제4조 (이용계약의 성립)</p>
                    <p>이용계약은 이용자의 약관내용에 대한 동의와 이용자의 이용신청에 대한 송파구의 승낙으로 성립합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제5조 (이용신청)</p>
                    <p>이용신청은 서비스의 회원정보 화면에서 이용자가 송파구에서 요구하는 가입신청 양식에 개인의 신상정보를 기록하는 방식으로 신청합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제8조 (서비스 이용)</p>
                    <ul class="ul_list_num2">
                        <li>송파구는 회원의 이용신청을 승낙한 때부터 서비스를 개시합니다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시합니다.</li>
                        <li>송파구의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공시하거나 회원에게 이를 통지합니다.</li>
                        <li>서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 다만, 송파구의 업무상 또는 기술상의 이유로 서비스가 일시 중지될 수 있고, 또한 정기점검 등 운영상의 목적으로 송파구가 정한 기간에는 서비스가 일시 중지될 수 있습니다. 이러한 경우 송파구는 사전 또는 사후에 이를 공지합니다.</li>
                        <li>회원에 가입한 후라도 일부 서비스 이용 시 서비스 제공자의 요구에 따라 특정 회원에게만 서비스를 제공할 수도 있습니다.</li>
                        <li>송파구는 서비스를 일정범위로 분할하여 각 범위 별로 이용가능 시간을 별도로 정할 수 있습니다. 이 경우 그 내용을 사전에 공지합니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제9조 (서비스의 변경, 중지 및 정보의 저장과 사용)</p>
                    <ul class="ul_list_num2">
                        <li>회원은 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 송파구의 관리범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실에 대해 송파구가 아무런 책임을 지지 않음에 동의합니다.</li>
                        <li>송파구가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일전에 고지 후 서비스를 중지할 수 있으며, 이 기간동안 회원이 고지내용을 인지하지 못한데 대하여 송파구는 책임을 부담하지 아니합니다. 상당한 이유가 있을 경우 위 사전 고지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 송파구는 책임을 부담하지 아니합니다.</li>
                        <li>송파구의 사정으로 서비스를 영구적으로 중단하여야 할 경우 제2항을 준용합니다. 다만, 이 경우 사전 고지기간은 1개월로 합니다.</li>
                        <li>송파구는 사전 고지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 회원 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.</li>
                        <li>송파구는 회원이 이 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 중지할 수 있습니다. 이 경우 송파구는 회원의 접속을 금지할 수 있으며, 회원이 게시한 내용의 전부 또는 일부를 임의로 삭제할 수 있습니다.</li>
                        <li>장기간 휴면 회원인 경우 안내 메일 또는 공지사항 발표 후 1주일간의 통지 기간을 거쳐 서비스 사용을 중지할 수 있습니다.</li>
                    </ul>
                </div>

                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제10조 (정보의 제공 및 광고의 게재)</p>
                    <ul class="ul_list_num2">
                        <li>송파구는 회원이 서비스 이용 중 필요가 있다고 인정되는 다양한 정보 및 광고에 대해서는 전자우편이나 서신우편, SMS(핸드폰 문자메시지), DM, 메신저 등의 방법으로 회원에게 제공할 수 있으며, 만약 원치 않는 정보를 수신한 경우 회원은 이를 수신거부 할 수 있습니다.</li>
                        <li>송파구는 서비스의 운용과 관련하여 서비스화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있으며, 송파구는 서비스를 이용하고자 하는 회원이 이 광고게재에 대하여 동의하는 것으로 간주합니다.</li>
                        <li>송파구는 서비스 상에 게재되어 있거나 서비스를 통한 광고주와의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제11조 (게시물 또는 내용물의 삭제)</p>
                    <ul class="ul_list_num2">
                        <li> 송파구는 회원이 게시하거나 등록하는 서비스 내의 모든 내용물이 다음 각 호의 경우에 해당된다고 판단되는 경우 사전 통지 없이 삭제할 수 있으며, 이에 대해 송파구는 어떠한 책임도 지지 않습니다.
                            <ul class="ul_list_num">
                                <li>송파구, 다른 회원 또는 제3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우</li>
                                <li>공공질서 및 미풍양속에 위반되는 내용인 경우</li>
                                <li>범죄적 행위에 결부된다고 인정되는 내용일 경우</li>
                                <li>제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
                                <li>서비스 성격에 부합하지 않는 정보의 경우</li>
                                <li>기타 관계 법령 및 송파구에서 정한 규정 등에 위배되는 경우</li>
                            </ul>
                        </li>
                        <li>송파구는 서비스에 게시된 내용을 사전 통지된 지 3일 이후 편집, 이동, 삭제할 수 있는 권리를 보유하며, 게시된 내용이 이 약관에 위배되거나 상용 또는 비합법적, 불건전한 내용일 경우 및 해지 회원이 게시한 게시물은 사전통보 없이 삭제할 수 있습니다.</li>
                        <li>송파구는 게시된 내용이 일정기간 이상 경과되어, 게시물로써의 효력을 상실하여 그 존치 목적이 불분명한 경우 공지사항 발표 후 1주일간의 통지기간을 거쳐 해당 게시물을 삭제할 수 있습니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제12조 (게시물의 저작권)</p>
                    <ul class="ul_list_num2">
                        <li>회원이 서비스 내에 게시한 게시물의 저작권은 회원에게 있으며, 송파구는 다른 서비스에서의 개재 등 활용할 수 있습니다.</li>
                        <li>회원의 게시물이 타인의 저작권, 프로그램 저작권 등을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 회원이 부담하여야 합니다.</li>
                        <li>회원은 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제13조 (송파구의 소유권)</p>
                    <ul class="ul_list_num2">
                        <li>송파구가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타권리는 송파구에게 소유권이 있습니다.</li>
                        <li>회원은 송파구가 명시적으로 승인한 경우를 제외하고는 제1항 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정행위, 상업적 이용행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</li>
                    </ul>
                </div>
            </div>
            <h4 class="mt_40 mb_5 fw_500">제4장 계약 당사자의 의무</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제14조 (회원의 의무 및 정보보안)</p>
                    <ul class="ul_list_num2">
                        <li>회원은 서비스 이용을 위해 가입할 경우 현재의 사실과 일치하는 완전한 정보 (이하 "가입정보"라 한다)를 제공하셔야 합니다. 또한 가입정보에 변경이 발생할 경우 즉시 갱신하셔야 합니다.</li>
                        <li>회원이 서비스 사용을 위한 가입절차를 완료하시면 아이디와 비밀 번호를 받게 됩니다. 회원의 아이디, 비밀번호 관리를 위해
                            <ul class="ul_list_num">
                                <li>회원의 승인 없이 비밀번호, 아이디가 사용되는 문제가 발생되면 즉시 송파구에 신고하셔야 하고</li>
                                <li>매 접속 종료 시 확실히 로그아웃을 하셔야 합니다.</li>
                            </ul>
                        </li>
                        <li>회원은 서비스를 이용하면서 다음과 같은 행위를 하지 않기로 동의합니다.
                            <ul class="ul_list_num">
                                <li>타인(소수를 포함)에게 위해를 가하는 행위 가. 타인의 ID, h4ASSWORD, 주민등록번호 도용 및 타인으로 가장하는 행위 나. 타인과의 관계를 허위로 명시하는 행위 다. 타인을 비방할 목적으로 사실 또는 허위의 사실을 적시하여 명예를 훼손하는 행위 라. 자기 또는 타인에게 재산상의 이익을 주거나 타인에게 손해를 가할 목적으로 허위의 정보를 유통시키는 행위 마. 수치심이나 혐오감 또는 공포심을 일으키는 말이나 음향, 글이나 화상 또는 영상을 계속하여 상대방에게 도달하게 하여 상대방의 일상적 생활을 방해하는 행위 바. 송파구의 사전 승낙 없이 서비스를 이용한 영리행위 사. 타인의 정보통신서비스 이용명의를 도용하여 사용하는 행위</li>
                                <li>불필요하거나 승인되지 않은 광고, 판촉물을 게재하거나, "정크 메일(junk mail)", "스팸(sh4am)", "행운의 편지(chain letters)", "도배글", "피라미드 조직" 등을 권유하거나 게시, 게재 또는 전자우편으로 보내는 행위</li>
                                <li>저속 또는 음란한 데이터, 텍스트, 소프트웨어, 음악, 사진, 그래픽, 비디오 메시지 등(이하 "컨텐츠")을 게시, 게재 또는 전자우편으로 보내는 행위</li>
                                <li>권리(지적재산권을 포함한 모든 권리)가 없는 컨텐츠를 게시, 게재 또는 전자우편으로 보내는 행위</li>
                                <li>컴퓨터 소프트웨어, 하드웨어, 전기통신 장비를 파괴, 방해 또는 기능을 제한하기 위한 소프트웨어 바이러스를 게시, 게재 또는 전자우편으로 보내는 행위</li>
                                <li>다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시, 게재, 전자우편으로 보내는 행위 등 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
                                <li>재물을 걸고 도박하거나 사행행위를 하는 행위</li>
                                <li>윤락행위를 알선하거나 음행을 매개하는 내용의 정보를 유통시키는 행위</li>
                                <li>기타 불법적이거나 부당한 행위</li>
                            </ul>
                        </li>
                        <li>회원은 이 약관 및 관계법령에서 규정한 사항을 준수하여야 합니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제14조 (회원의 의무 및 정보보안)</p>
                    <ul class="ul_list_num2">
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제15조 (송파구의 의무)</p>
                    <ul class="ul_list_num2">
                        <li>송파구는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시일에 서비스를 이용할 수 있도록 합니다.</li>
                        <li>송파구는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.</li>
                        <li>송파구가 제공하는 서비스로 인하여 회원에게 손해가 발생한 경우 그러한 손해가 송파구의 고의나 중과실에 기해 발생한 경우에 한하여 송파구에서 책임을 부담하며, 그 책임의 범위는 통상손해에 한합니다.</li>
                        <li>송파구는 회원으로부터 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 신속히 처리하여야 합니다. 다만, 신속한 처리가 곤란한 경우에는 회원에게 그 사유와 처리일정을 통보하여야 합니다.</li>
                        <li>송파구는 관련법령이 정하는 바에 따라서 회원 등록정보를 포함한 회원의 개인정보를 보호하기 위하여 노력합니다. 회원의 개인정보보호에 관해서는 관련법령 및 제 16조에 제시된 내용을 지킵니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제16조 (개인정보보호정책)</p>
                    <ul class="ul_list_num2">
                        <li>송파구는 이용 신청 시 회원이 제공하는 정보를 통하여 회원에 관한 정보를 수집하며, 회원의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스제공을 위한 목적으로 이용합니다.</li>
                        <li>송파구는 서비스 제공과 관련하여 취득한 회원의 정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호의 경우에는 그러하지 아니합니다.
                            <ul class="ul_list_num">
                                <li>관계 법령에 의하여 수사상의 목적으로 관계기관으로부터 요구가 있는 경우</li>
                                <li>정보통신윤리위원회의 요청이 있는 경우</li>
                                <li>기타 관계법령에서 정한 절차에 따른 요청이 있는 경우</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <h4 class="mt_40 mb_5 fw_500">제5장 계약해지</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제17조 (계약해지 및 이용제한)</p>
                    <ul class="ul_list_num2">
                        <li> 회원이 이용계약을 해지하고자 하실 때에는 회원 본인이 직접 인터넷을 통해 당 사이트에 해지 신청을 하여야 합니다.</li>
                        <li> 송파구는 보안 및 아이디 정책, 서비스의 원활한 제공 등과 같은 이유로 회원의 ID 및 h4ASSWORD 변경을 요구하거나 변경 할 수 있습니다.</li>
                        <li> 송파구는 회원이 다음 각 호에 해당하는 행위를 하였을 경우 사전통지 없이 이용계약을 해지할 수 있습니다.
                            <ul class="ul_list_num">
                                <li>비 실명가입, 주민등록번호의 도용 등 회원이 제공한 데이터가 허위임이 판명된 경우</li>
                                <li>범죄적 행위에 관련되는 경우</li>
                                <li>국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우</li>
                                <li>타인의 서비스 아이디 및 비밀 번호를 도용한 경우</li>
                                <li>타인의 명예를 손상시키거나 불이익을 주는 경우</li>
                                <li>같은 사용자가 다른 아이디로 이중 등록을 한 경우</li>
                                <li>서비스에 위해를 가하는 등 서비스의 건전한 이용을 저해하는 경우</li>
                                <li>기타 관련법령이나 송파구가 정한 이용조건에 위배되는 경우</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <h4 class="mt_40 mb_5 fw_500">제6장 기타</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제18조 (요금 및 유료정보)</p>
                    <p>서비스 이용은 기본적으로 무료입니다. 단, 서비스에서 정한 별도의 유료 정보와 유료서비스에 대해서는 그러하지 아니합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제19조 (양도금지)</p>
                    <p>회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</p>
                </div>
            </div>
            <h4 class="mt_40 mb_5 fw_500">제7장 손해배상 등</h4>
            <div class="etc_box_wrap fs_18 fs_md_24">
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제20조 (손해배상)</p>
                    <p>송파구는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동 손해가 송파구의 중대한 과실에 의한 경우를 제외하고 이에 대하여 책임을 부담하지 아니합니다.</p>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제21조 (면책조항)</p>
                    <ul class="ul_list_num">
                        <li>송파구는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.</li>
                        <li>송파구는 회원의 귀책사유로 인한 서비스이용의 장애에 대하여 책임을 지지 않습니다.</li>
                        <li>송파구는 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.</li>
                        <li>송파구는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">제22조 (관할법원)</p>
                    <ul class="ul_list_num">
                        <li>서비스 이용과 관련하여 송파구와 회원 사이에 분쟁이 발생한 경우, 송파구와 회원은 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 하여야 합니다.</li>
                        <li>제1항의 규정에도 불구하고 서비스 이용으로 발생한 분쟁에 대하여 소송이 제기될 경우 송파구 소재지를 관할하는 법원을 관할법원으로 합니다.</li>
                    </ul>
                </div>
                <div class="etc_box">
                    <p class="etc_tit fw_400 tc_b">부 칙</p>
                    <p>(시행일) 이 약관은 2007년 10월 1일부터 적용합니다.</p>
                </div>
            </div>
        </div>
    </div>
</div>
