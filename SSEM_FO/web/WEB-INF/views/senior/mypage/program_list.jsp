<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-03
  Time: 오전 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<%@ page import="com.ubintis.api.ApiTokenService" %>
<%@ page import="kr.go.songpa.ssem.model.TnUserInfoVo" %>
<%@ page import="com.ubintis.common.util.StrUtil" %>
<%
    String pni_token = "";
    String erorCode = "";
    String user_id = "";
    String local_ip = request.getRemoteAddr();

    TnUserInfoVo obj = (TnUserInfoVo)session.getAttribute("loginVo");

    if(obj != null) {
        user_id = StrUtil.NVL( obj.getUser_id() );
        ApiTokenService service = new ApiTokenService();
        erorCode = service.createToken( user_id, local_ip );
        if("".equals( erorCode ) ) {
            pni_token = service.getPni_token();
        }
    }
%>

<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '프로그램 신청 > 프로그램 확인 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableMoHtmlInit('#moTable') //sub.js ul 태그만 모바일용 태그 생성;

        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            goSearch();
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSearch();
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch() {
        let frm = document.frm;

        if(frm.searchSDate.value > frm.searchEDate.value) {
            modalMsg("시작일자는 종료일자보다 클수 없습니다.", 'notice', '');
            return false;
        }

        $("#page").val("1");
        $("#frm").submit();
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_mypage"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc line_none">
                    나의 송파쌤
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">프로그램 확인</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/senior/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/senior/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/senior/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/senior/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">프로그램 신청</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/senior/mypage/attend_list.do">교육이수 현황</a></li>
                            <li><a href="/ssem/senior/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                            <c:if test="${loginVo.teacher_yn eq 'Y'}">
                                <li><a href="/ssem/senior/mypage/teacher_history_list.do">강의이력 조회</a></li>
                            </c:if>
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
    <div class="sub_con st_5 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m"><span class="tab_middle">프로그램 확인<i class="icon_arrow_down_w ml_60">다운</i></span></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <h4 class="tit2 mt_95 mb_50">프로그램 확인</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item on"><a href="/ssem/senior/mypage/program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/attend_list.do">교육이수 현황</a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/teacher_love_list.do">강사 만족도 평가</a></li>
                <c:if test="${loginVo.teacher_yn eq 'Y'}">
                    <li class="tab_item"><a href="/ssem/senior/mypage/teacher_history_list.do">강의이력 조회</a></li>
                </c:if>
            </ul>
        </div><!-- mypage_tab : end -->
        <form name="frm" id="frm" method="post" action="/ssem/senior/mypage/program_list.do">
            <input type="hidden" name="page" id="page" value="${page}"/>
        <div class="data_search ptb_30 fs_20  fs_md_26 fs_md_24"><!--Data Search-->
            <form action="" onsubmit="return false;">
                <div class="wrap_1250 plr_40">
                    <div class="row_24">
                        <div class="col_6 col_md_12 pr_20">
                            <!--
                                sel_box select class="placeholder"
                                [option value= ""] placeholder 컬러
                            -->
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchKind4" id="searchKind4" title="교육기관 선택" class="placeholder">
                                    <option value="">교육기관 선택</option>
                                    <c:forEach items="${groupList}" var="group" varStatus="status">
                                        <option value="${group.group_idx}" <c:if test="${searchKind4 eq group.group_idx}">selected="selected"</c:if>>${group.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col_5 col_md_12">
                            <div class="sel_box sel_full sel_md_short">
                                <select id="searchVal6" name="searchVal6" title="교육분야" class="placeholder">
                                    <option value="">교육분야 선택</option>
                                    <c:forEach items="${codeList}" var="code" varStatus="status">
                                        <option value="${code.code_idx}" <c:if test="${searchVal6 eq code.code_idx}">selected="selected"</c:if>>${code.cd_val}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col_6 col_md_12 pl_20 pr_20 pl_md_0 line_md_top">
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchKind2" id="searchKind2" title="신청상태" class="placeholder">
                                    <option value="">신청상태 선택</option>
                                    <option value="1" <c:if test="${searchKind2 eq '1'}">selected="selected"</c:if>>신청</option>
                                    <option value="2" <c:if test="${searchKind2 eq '2'}">selected="selected"</c:if>>대기신청</option>
                                    <option value="3" <c:if test="${searchKind2 eq '3'}">selected="selected"</c:if>>신청취소</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_7 col_md_12 line_md_top ">
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchKind3" id="searchKind3" title="결제상태" class="placeholder">
                                    <option value="">결제상태 선택</option>
                                    <option value="1" <c:if test="${searchKind3 eq '1'}">selected="selected"</c:if>>입금대기</option>
                                    <option value="2" <c:if test="${searchKind3 eq '2'}">selected="selected"</c:if>>결제완료</option>
                                    <option value="3" <c:if test="${searchKind3 eq '3'}">selected="selected"</c:if>>결제취소</option>
                                    <option value="4" <c:if test="${searchKind3 eq '4'}">selected="selected"</c:if>>환불신청</option>
                                    <option value="5" <c:if test="${searchKind3 eq '5'}">selected="selected"</c:if>>환불처리</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row_24 mt_10">
                        <div class="col_5 col_md_6 pr_20">
                            <div class="sel_box sel_full sel_md_short">
                                <select name="searchKind" id="searchKind" title="기간" class="placeholder">
                                    <option value="">기간 선택</option>
                                    <option value="ALL" <c:if test="${searchKind eq 'ALL'}">selected="selected"</c:if>>전체</option>
                                    <option value="1" <c:if test="${searchKind eq '1'}">selected="selected"</c:if>>교육기간</option>
                                    <option value="2" <c:if test="${searchKind eq '2'}">selected="selected"</c:if>>접수기간</option>
                                </select>
                            </div>
                        </div>
                        <div class="col_9 col_md_18">
                            <div class="row_15">
                                <div class="col_7">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchSDate" name="searchSDate" title="시작일" value="${searchSDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col_1">
                                    <div class="dash">~</div>
                                </div>
                                <div class="col_7">
                                    <div class="fm_cal">
                                        <div class="fm_inp fm_date mr_10">
                                            <input type="text" class="inp" id="searchEDate" name="searchEDate" title="종료일" value="${searchEDate}">
                                            <button type="button" class="fm_date_btn">
                                                <i class="icon_cal">달력</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col_10 col_md_24 pl_20 pl_md_0 line_md_top">
                            <div class="data_search_word_box">
                                <div class="fm_inp inp_full">
                                    <input class="inp" title="검색어" placeholder="프로그램명 또는 강사명으로 검색하세요." id="searchVal" name="searchVal" value="${searchVal}">
                                </div>
                                <button type="button" class="data_search_btn" id="btn_search">
                                    <i class="icon_search">검색</i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div><!--Data Search-->
        </form>
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <p class="t_right"><span class="fw_500 tc">총</span> <fmt:formatNumber value="${totalCount}" pattern="##,###"/>건</p>
                <div class="table_list_ul mt_10 fs_18 fs_lg_16 fs_md_24" id="moTable">
                    <ul>
                        <li class="t_head fs_20">
                            <section class="table">
                                <div class="col wid_60 screen_md_hide">NO</div>
                                <div class="col wid_150">교육기관</div>
                                <div class="col wid_100">교육분야</div>
                                <div class="col wid_220">프로그램명</div>
                                <div class="col wid_100">온라인 강의실</div>
                                <div class="col wid_220">교육기간</div>
                                <div class="col wid_220">접수기간</div>
                                <!-- <div class="col ">신청번호</div> -->
                                <div class="col wid_120">신청일</div>
                                <div class="col wid_100">신청상태</div>
                                <div class="col wid_100">결제상태</div>
                            </section>
                        </li>
                        <c:if test="${fn:length(itemList) == 0}">
                            <li class="_moInit noDate">
                                <div class="t_center">
                                    <img src="/ssem/resources/img/common/noDate.png" alt="데이터 없음" />
                                    <p  class="mt_30 fs_30"><span class="fw_600">‘프로그램 확인’</span> 에 대한 검색결과가 없습니다.</p>
                                </div>
                            </li>
                        </c:if>
                        <c:set var="lno" value="0"/>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <c:set var="lno">${lno + 1}</c:set>
                            <li class="wa_ba">

                                    <section class="table">
                                        <div class="col wid_60 screen_md_hide"><fmt:formatNumber value="${totalCount - ((page - 1) * listSize + (lno - 1))}" pattern="##,###"/></div>
                                        <div class="col wid_150">${item.lectureVo.group.name}</div>
                                        <div class="col wid_100">${item.lectureVo.part_name}</div>
                                        <div class="col wid_220">
                                            <a href="/ssem/senior/mypage/program_view.do?lecture_apy_idx=${item.lecture_apy_idx}"><p class="ellip_1 link_line">${item.lectureVo.name}</p></a>
                                        </div>
                                        <div class="col wid_100"><c:if test='${item.apy_status eq "1"}'><a href="https://www.songpa.go.kr/ssemlms/landing.do?lno=${item.lectureVo.lecture_idx}&gno=${item.lectureVo.group_idx}&pni_token=<%=pni_token%>" class="btn btn_small btn_color_1" style="display:inline-block; width: 5em; height: 2.5em;" target="_blank">입장</a></c:if></div>
                                        <div class="col wid_220">${item.lectureVo.start_dt} ~ ${item.lectureVo.end_dt}</div>
                                        <div class="col wid_220">${fn:substring(item.lectureVo.reg_start_st, 0, 10)} ~ ${fn:substring(item.lectureVo.reg_end_dt, 0, 10)}</div>
                                        <!-- <div class="col ">SSEM_${item.lecture_apy_idx}</div> -->
                                        <div class="col wid_120">${fn:substring(item.reg_dt, 0, 10)}</div>
                                        <div class="col wid_100">
                                            <c:choose>
                                                <c:when test="${item.apy_status eq '1'}"><span class="my_tc_1">신청</span></c:when>
                                                <c:when test="${item.apy_status eq '2'}"><span class="my_tc_2">대기신청</span></c:when>
                                                <c:when test="${item.apy_status eq '3'}"><span class="my_tc_3">신청취소</span></c:when>
                                                <c:otherwise> - </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col wid_100">
                                            <c:choose>
                                                <c:when test="${item.pay_status eq '1'}">입금대기</c:when>
                                                <c:when test="${item.pay_status eq '2'}">결제완료</c:when>
                                                <c:when test="${item.pay_status eq '3'}">결제취소</c:when>
                                                <c:when test="${item.pay_status eq '4'}">환불신청</c:when>
                                                <c:when test="${item.pay_status eq '5'}">환불처리</c:when>
                                                <c:when test="${item.pay_status eq '6'}">무료신청</c:when>
                                                <c:otherwise> - </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </section>

                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <common:pageLink name="pageholder"/>
            </div>
        </section>
    </div>
</div>
