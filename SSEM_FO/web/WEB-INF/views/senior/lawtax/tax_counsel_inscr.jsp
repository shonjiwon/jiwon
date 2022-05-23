<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-24
  Time: 오후 3:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '글쓰기 > 법률ㆍ세무 상담 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        mainInit();   //main.js

        //서브만
        uiInti();       //ui.js
        subInit()       //sub.js

        $("#btn_list").click(function(){
            modalMsg("세무상담 리스트 화면으로 이동하시겠습니까?", 'yesorno', list_frm);
        });

        $("#btn_insert").click(function(){
            modalMsg("세무상담 상세 내용을 등록하시겠습니까?", 'yesorno', insert_frm);
        });
    });

    function list_frm() {
        location.href = "/ssem/senior/lawtax/tax_counsel_list.do";
    }

    function insert_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.title, "제목")){return false;}
        if(!fnIsValidRequired(frm.cont, "상담내용")){return false;}

        if(frm.agree_yn.value === 'N') {
            modalMsg("개인정보의 수집 및 이용에 대한 동의를 선택해 주세요.", "notice", "");
            return;
        }

        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_7"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    법률ㆍ세무 상담
                </h2>
                <p class="tit_sub">
                    <strong>“송파쌤이 여러분의 고민을 도와 드리겠습니다.”</strong>
                    온라인법률 세무상담은 구민들의 궁금증을 해소하기 위한 맞춤형 상담 게시판입니다.<br>궁금하신 사항이 있으시면 전문가에게 무료 상담 받아 보세요.
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
                        <a href="#" class="deapth_tit" title="선택">법률ㆍ세무 상담</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
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
        <h3 class="mt_80 mb_50 tit font_sc">법률ㆍ세무 상담</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">세무상담<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_2"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/senior/lawtax/law_counsel_list.do">법률상담</a></li>
                <li class="tab_item on"><a href="/ssem/senior/lawtax/tax_counsel_list.do">세무상담</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">세무상담</h4>

        <div class="wrap">
            <div>
                <div class="law_info_box">
                    <img src="/ssem/resources/img/sub/senior/tax_icon.png" alt="세무상담">
                    <%--<img class="coach_info_m" src="/ssem/resources/img/sub/youth/icon_m_coaching_info.png" alt="온라인코칭쌤사용설명">--%>
                    <div class="ml_30 mt_55 va_t m_coach_text">
                        <p class="t_bef_middot c5 fs_18 mb_15">본 공간은 각종 <span class="fw_600" style="color:#1fb593;">세금</span> 문의사항에 대한 답변 서비스를 제공하여 구민 권익구제를 위해 마련된 공간으로, <span class="fw_600" style="color:#1fb593;">송파구청 홈페이지 회원으로 가입되어 있는 송파구민만 이용 가능합니다.</span></p>
                        <p class="t_bef_middot c5 fs_18 mb_15">운영기준을 다음과 같이 안내 드리오니 충분히 숙지하신 후 이용 바랍니다.</p>
                        <p class="fs_18 mb_15">- 상담분야 : 지방세 및 국세</p>
                        <p class="fs_18 mb_15">- 신청시간 : 월 ~ 금(공휴일 제외) 08:00 ~ 22:00</p>
                        <p class="fs_18 mb_15">- 신청건수: <span class="fw_600" style="color:#1fb593;">일인당 1달에 1건</span></p>
                        <p class="fs_18 mb_15">- 답변기한: 신청한 날로부터 2주 이내 (단 법인세ㆍ종합소득세ㆍ부가가치세 신고 마감기간에는 답변이 지연될 수 있습니다.)</p>
                        <p class="fs_18 mb_15">
                            - 상담시 유의사항 : <span class="fw_600" style="color:#1fb593;">온라인 상담 게시판에서는 예상 세액을 대신 계산해드리거나, 절세 컨설팅 서비스를 제공해드리지 않습니다. 또한 질의가 부적절하다고 판단되는 경우, 답변이 제한될 수 있습니다.</span>
                        </p>
                        <p class="fs_18 mb_15">
                            <span class="fw_600" style="color:#1fb593;">- 온라인 상담은 법적효력을 갖는 유권해석(결정, 판단)이 아니므로 각종 신고, 불복청구 등의 증가자료로서의 효력은 없으며 사실관계에 따라 적용될 수 있습니다.</span>
                        </p>
                        <p class="fs_18 mb_15">&nbsp;</p>
                    </div>
                </div>
            </div>
        </div>

        <form name="frm" id="frm" action="/ssem/senior/lawtax/tax_counsel_inscr.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="gbn" id="gbn" value="T"/>
            <input type="hidden" name="apy_id" id="apy_id" value="${loginVo.user_id}"/>
            <input type="hidden" name="reg_id" id="reg_id" value="${loginVo.user_id}"/>
            <input type="hidden" name="apy_nm" id="apy_nm" value="${loginVo.user_nm}"/>
            <input type="hidden" name="apy_email" id="apy_email" value="${loginVo.email}"/>
            <input type="hidden" name="apy_mob_no" id="apy_mob_no" value="${loginVo.moblphon}"/>
            <input type="hidden" name="apy_addr" id="apy_addr" value="${loginVo.adres} ${loginVo.detail_adres}"/>
            <section class="text_con wrap fs_20 fs_md_26  pb_100 mb_15">
                <h2 class="c_tit_2 mt_15 mb_25">회원 기본 정보</h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 이름, 전화번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 ID</th>
                            <td>${loginVo.user_id}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${loginVo.user_nm}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">휴대폰 번호</th>
                            <td>${loginVo.moblphon}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">이메일</th>
                            <td>${loginVo.email}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">주소</th>
                            <td>${loginVo.adres} ${loginVo.detail_adres}</td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <h2 class="c_tit_2 mt_45 mb_25 clearfix">
                    <span class="dp_inb float_left">법률 상담</span>
                    <span class="dp_inb float_right fs_18 fs_md_24 tc_point">*필수입력</span>
                </h2>
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">등록 신청 작성폼의 동아리명, 분야, 창립일, 소속기관, 회원수, 모임주기 및 요일, 모임장소, 동아리 소개, 주요활동, 제출서류 첨부</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>제목</th>
                            <td>
                                <div class="fm_inp inp_full"><input type="text" class="inp" name="title" id="title" title="제목"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>상담내용</th>
                            <td>
                                <div class="fm_tf mr_lg_0">
                                    <textarea class="act_word_cnt fw_300" onkeyup="calcWordLng(1000)" data-max-word="1000" title="상담내용" name="cont" id="cont" rows="6"></textarea>
                                    <span class="fw_200 fs_18 word_cnt_wrap"><b class="now_cnt fw_200">0</b> / 1000</span>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                <div class="agree_box mt_60 fs_18 fs_md_24"><!--agree_box-->
                    <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보의 수집 및 이용 동의</p>
                    <ul class="ul_list_dot mb_20 tc_sub fw_300">
                        <li>개인정보의 수집 및 이용 목적 : 세금문의의 신청 내용 확인 및 답변, 필요시 관리</li>
                        <li>개인정보 수집 항목 : 성명, 연락처(휴대전화), 이메일, 주소</li>
                        <li>개인정보 보유 및 이용기간 : 게시물 삭제를 별도 요청한 경우, 수집/이용목적을 달성 하거나 보유/이용기간이 종료한 경우, 사업 폐지 등의 사유발생시 당해 개인정보를 지체 없이 파기합니다.</li>
                        <li>정보주체는 개인정보의 수집ㆍ이용목적에 대한 동의를 거부할 수 있으며, 동의 거부 시 본 홈페이지에서 제공하는 서비스 이용에 제한이 있습니다.</li>
                        <li>답변내용은 송파구청의 공식의견이 아닌, 신청자가 질의한 내용을 기반으로 한 전문가의 개인의견이므로 답변과 관련하여 송파구 및 전문가(세무사)는 법률책임을 지지 않습니다.</li>
                    </ul>
                    <div>
                        <p class="pb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">개인정보수집 및 이용목적에 동의하십니까?</p>
                        <label class="fm_rd act_uiRdCh mr_20">
                            <input type="radio" name="agree_yn" id="agree_y" value="Y"><span>동의</span>
                        </label>
                        <label class="fm_rd act_uiRdCh">
                            <input type="radio" name="agree_yn" id="agree_n" value="N" checked><span>미동의</span>
                        </label>
                    </div>
                </div><!--agree_box //-->

                <div class="wrap mt_30">
                    <div class="row">
                        <div class="info_col">
                            <div class="info_item_box ml_35">
                                <img src="/ssem/resources/img/sub/youth/icon_notice.png" alt="알림">
                                <span class="fw_600">관리부서</span>&nbsp;&nbsp;<span class="fw_200">|&nbsp;&nbsp;세무2과</span>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="fw_600">담당자</span>&nbsp;&nbsp;<span class="fw_200">|&nbsp;&nbsp;신영주</span>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <br class="screen_hide screen_lg_show"><span class="fw_600">전화번호</span>&nbsp;&nbsp;<span class="fw_200">|&nbsp;&nbsp;02-2147-2648(세무상담)</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn_box mt_50  pb_30 t_center">
                    <button type="button" class="btn btn_long btn_big mr_15" id="btn_list">목록</button>
                    <button type="button" class="btn btn_long btn_big mr_15 btn_color_5" id="btn_insert">등록</button>
                </div>
            </section>
        </form>
    </div>
</div>
