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
        $(document).prop('title', '법률ㆍ세무 상담 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        tableMoHtmlInit('#moTable') //sub.js ul 태그만 모바일용 태그 생성;

        $('#my_item').click(function(){
            if ($("#my_item").is(":checked")) {
                $("#searchVal2").val("Y");
            } else {
                $("#searchVal2").val("N");
            }
            $("#page").val("1");
            $("#frm").submit();
        });

        $('#btn_insert').click(function(){
            modalMsg("운영준비 중입니다.<br> 상담 게시글 등록 시 현재는 답변이 어려우며<br>정식 운영시 안내해 드리겠습니다.", 'locurl', "/ssem/senior/lawtax/law_counsel_inscr.do");
        });
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual foreverEdu_st_6"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    법률ㆍ세무 상담
                </h2>
                <p class="tit_sub">
                    <strong>“송파쌤이 여러분의 고민을 도와 드리겠습니다.”</strong>
                    온라인법률세무상담은 구민들의 궁금증을 해소하기 위한 맞춤형 상담 게시판입니다.<br>궁금하신 사항이 있으시면 전문가에게 무료 상담 받아 보세요.
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
            <a href="#" class="tab_m">법률상담<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_2"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/senior/lawtax/law_counsel_list.do">법률상담</a></li>
                <li class="tab_item"><a href="/ssem/senior/lawtax/tax_counsel_list.do">세무상담</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_50">법률상담</h4>

        <div class="wrap">
            <div>
                <div class="law_info_box">
                    <img src="/ssem/resources/img/sub/senior/law_icon.png" alt="법률상담">
                    <%--<img class="coach_info_m" src="/ssem/resources/img/sub/youth/icon_m_coaching_info.png" alt="온라인코칭쌤사용설명">--%>
                    <div class="ml_30 mt_55 va_t m_coach_text">
                        <p class="t_bef_middot c5 fs_18 mb_15">본 공간은 각종 법률적 문의사항에 대한 답변 서비스를 제공하여 구민 권익구제 강화를 위해 마련된 공간으로, <span class="fw_600" style="color:#1fb593;">송파구청 홈페이지 회원으로 가입되어 있는 송파구민만 이용 가능합니다.</span></p>
                        <p class="t_bef_middot c5 fs_18 mb_15">운영기준을 다음과 같이 안내 드리오니 충분히 숙지하신 후 이용 바랍니다.</p>
                        <p class="fs_18 mb_15">- 신청기간: 월 ~ 금 (공휴일 제외) 08:00 ~ 22:00</p>
                        <p class="fs_18 mb_15">- 신청건수: 일인당 분야별 <span class="fw_600" style="color:#1fb593;">1달에 1건</span></p>
                        <p class="fs_18 mb_15">- 답변기한: 신청한 일로부터 <span class="fw_600" style="color:#1fb593;">최대 2주 이내</span></p>
                        <p class="fs_18 mb_15">
                            - 법률문의 신청을 하실 경우 답변자가 내용을 쉽게 파악할 수 있도록 사실관계를 명확하게 작성하시되, 타인ㆍ타 기관 등의 개인정보 및 사생활이 노출될 수 있는 상황에 관한 내용은
                              <br>&nbsp;&nbsp;&nbsp;자제해주시기 바랍니다. (※ 법률관련 내용이 아닐 경우 답변이 어려움을 양지해 주시기 바랍니다.)
                        </p>
                        <p class="fs_18 mb_15">
                            - 법률문의에 대한 답변내용은 답변자(변호사) 개인의 법률적 의견으로 그 대강의 방향을 제시하는 것이므로 참고자료로 활용하시기 바라며, 보다 더 자세한 상담을 원하실 경우 무료법률상담
                            <br>&nbsp;&nbsp;&nbsp;(방문ㆍ전화)을 이용하여 주시기 바랍니다.
                        </p>
                        <p class="fs_18 mb_15">&nbsp;</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="data_search ptb_30 fs_20 fs_md_26 fs_md_24 mt_60"><!--Data Search-->
            <form name="frm" id="frm" method="post" action="/ssem/senior/lawtax/law_counsel_list.do">
                <input type="hidden" name="page" id="page" value="${page}"/>
                <input type="hidden" name="searchKind2" id="searchKind2" value="L"/>
                <input type="hidden" name="searchVal3" id="searchVal3" value="${loginVo.user_id}"/>
                <input type="hidden" name="searchVal2" id="searchVal2" value="${searchVal2}"/>
                <div class="wrap_1250 plr_40">
                    <div class="row">
                        <div class="col_5 col_md_12">
                            <div class="sel_box" style="max-width: 100% !important;">
                                <select title="분야" id="searchKind" name="searchKind">
                                    <option value="">진행상태 선택</option>
                                    <option value="A" <c:if test="${searchKind eq 'A'}">selected="selected"</c:if>>신청</option>
                                    <option value="P" <c:if test="${searchKind eq 'P'}">selected="selected"</c:if>>처리중</option>
                                    <option value="O" <c:if test="${searchKind eq 'O'}">selected="selected"</c:if>>답변완료</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_3 col_md_5">
                            <div class="fm_cal">
                                <div class="fm_inp fm_date">
                                    <input type="text" class="inp" id="searchSDate" name="searchSDate" title="시작일" value="${searchSDate}" placeholder="신청일">
                                    <button type="button" class="fm_date_btn">
                                        <i class="icon_cal">달력</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col_1 col_md_2">
                            <div class="dash">~</div>
                        </div>
                        <div class="col_3 col_md_5">
                            <div class="fm_cal">
                                <div class="fm_inp fm_date">
                                    <input type="text" class="inp" id="searchEDate" name="searchEDate" title="종료일" value="${searchEDate}" placeholder="신청일">
                                    <button type="button" class="fm_date_btn">
                                        <i class="icon_cal">달력</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col_12 col_md_12 pl_md_0 pt_md_20">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" title="검색어" placeholder="제목으로 검색하세요." id="searchVal" name="searchVal" value="${searchVal}">
                                </div>
                                <button type="submit" class="data_search_btn" id="btn_search">
                                    <i class="icon_search">검색</i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="wrap text_con fs_20 fs_md_26 mt_50 mb_15 mb_100">
            <div class="btnArea">
                <div class="left">
                    <span class="fw_500 tc">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건
                </div>
                <div class="right">
                    <%--<a href="#none" class="btn btn_line_color_5 btn_md_auto">내글보기</a>--%>
                    <label class="fm_ch act_uiRdCh mr_20">
                        <input type="checkbox" id="my_item" <c:if test="${searchVal2 eq 'Y'}">checked="checked"</c:if>><span class="ml_5">내글보기</span>
                    </label>
                    <a href="#none" class="btn btn_color_5 btn_md_auto" id="btn_insert">글쓰기</a>
                </div>
            </div>
            <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24" id="moTable"> <!--table_list_ul-->
                <ul>
                    <li class="t_head fs_20">
                        <section class="table">
                            <div class="col wid_60 screen_md_hide">접수번호</div>
                            <div class="col">제목</div>
                            <div class="col wid_250">작성자</div>
                            <div class="col wid_250">진행상태</div>
                            <div class="col wid_250">신청일</div>
                        </section>
                    </li>
                    <c:if test="${fn:length(itemList) == 0}">
                        <li>
                            <section>
                                <!--data : s-->
                                <div class="noDate t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘법률상담’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                                <!--data : e-->
                            </section>
                        </li>
                    </c:if>
                    <c:set var="lno" value="0"/>
                    <c:forEach items="${itemList}" var="item" varStatus="status">
                        <c:set var="lno">${lno + 1}</c:set>
                        <li class="wa_ba">
                            <a href="/ssem/senior/lawtax/law_counsel_view.do?lawtax_idx=${item.lawtax_idx}">
                                <section class="table">
                                    <div class="col wid_60 screen_md_hide"><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></div>
                                    <div class="col"><img src="/ssem/resources/img/sub/foreverEdu/lock.png"> ${item.title}</div>
                                    <div class="col wid_250"><p class="ellip_1">${item.apy_nm}</p></div>
                                    <div class="col wid_250">
                                            <c:choose>
                                                <c:when test="${item.status eq 'A'}">신청</c:when>
                                                <c:when test="${item.status eq 'P'}">처리 중</c:when>
                                                <c:when test="${item.status eq 'O'}">답변완료</c:when>
                                            </c:choose>
                                    </div>
                                    <div class="col wid_250">${fn:substring(item.reg_dt, 0, 10)}</div>
                                </section>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div><!--table_list_ul//-->
            <common:pageLink name="pageholder"/>
        </div>
    </div>
</div>
