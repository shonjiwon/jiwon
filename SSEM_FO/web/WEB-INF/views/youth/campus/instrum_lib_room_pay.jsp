<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-23
  Time: 오전 5:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script language="javascript" src="https://xpayvvip.tosspayments.com/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '대관신청 > 악기도서관 > 온라인 캠퍼스 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_cancel").click(function(){
            modalMsg("대관신청을 취소하시겠습니까??", 'yesorno', cancel_frm);
        });

        $("#btn_pay").click(function(){
            $("#pay_method").val($('input:radio[name=pay_method_str]:checked').val());

            if(isMobile()) {
                lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', 'iframe', null, "350", "600");
            } else {
                lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', 'iframe', null, "", "");
            }
            //lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', LGD_window_type, null, "", "");
        });
    });

    function cancel_frm() {
        $("#frm_cancel").submit();
    }

    function payment_return() {
        var fDoc;
        fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
        if (fDoc.document.getElementById('LGD_RESPCODE').value === "0000") {
            document.getElementById("LGD_PAYKEY_RESULT").value = fDoc.document.getElementById('LGD_PAYKEY').value;
            document.getElementById("pay_result").submit();
        } else {
            alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
            closeIframe();
        }
    }
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_2"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    악기도서관
                </h2>

                <p class="tit_sub fw_200">
                    <strong>“1인 1악기”</strong>
                    청소년과 주민들이 쉽게 악기를 접하고 <br class="screen_hide screen_sm_show"> 체험할 수 있도록 악기를 테마로 한 교육문화복합<br class="screen_hide screen_sm_show">  플랫폼을 구축하여<br class="screen_sm_hide">
                    구민들이 부담 없이 <br class="screen_hide screen_sm_show"> 다양한 예술적 소양과 적성을 계발할 수 있도록 <br class="screen_hide screen_sm_show"> 지원하는 플랫폼입니다.
                </p>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul>
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">온라인 캠퍼스</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">온라인 캠퍼스</a></li>
                            <li><a href="/ssem/youth/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/youth/magnet/intro.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/ssem/youth/center/broad_acamedy.do">교육지원</a></li>
                            <li><a href="/ssem/youth/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/youth/coach/coach_list.do">온라인 코칭쌤</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/person_lib_main.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/future_main.do">미래교육센터</a></li>
                            <li><a href="/ssem/youth/campus/self_main.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/dream/main/dream_main.do" target="_blank">송파진로 체험지원센터(꿈마루)</a></li>
                            <li><a href="/ssem/youth/campus/songpa_vision.do">송파혁신교육지구</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">대관신청</a>
                        <ul>
                            <li><a href="/ssem/youth/campus/instrum_lib_main.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_room_list.do">대관신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                            <li><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">악기도서관</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">악기대여<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_6"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_intro.do">소개 및 이용안내</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_rental_list.do">악기대여</a></li>
                <li class="tab_item on"><a href="/ssem/youth/campus/instrum_lib_room_list.do" title="선택">대관신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_program_list.do">프로그램 신청</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_donate_insert.do">악기기증</a></li>
                <li class="tab_item"><a href="/ssem/youth/campus/instrum_lib_review_list.do">갤러리</a></li>
            </ul>
        </div><!-- tab_box //-->
        <h4 class="tit2 mt_100 mb_30">대관신청내역확인</h4>
        <form method="post" name="pay_result" id="pay_result" action="/ssem/youth/campus/instrum_lib_room_payment.do" enctype="multipart/form-data">
            <input type="hidden" name="CST_PLATFORM" value="<spring:message code="CST_PLATFORM"/>"/>
            <input type="hidden" name="CST_MID" value="${LGD_MID}"/>
            <input type="hidden" name="LGD_PAYKEY" id="LGD_PAYKEY_RESULT"/>
            <input type="hidden" name="rental_fty_apy_idx" value="${rentalFtyApyVo.rental_fty_apy_idx}"/>
            <input type="hidden" name="rental_fty_idx" value="${rentalFtyApyVo.rental_fty_idx}"/>
            <input type="hidden" name="pay_method" id="pay_method"/>
        </form>
        <form name="frm_cancel" id="frm_cancel" method="post" action="/ssem/youth/campus/instrum_lib_room_cancel.do" enctype="multipart/form-data">
            <input type="hidden" name="rental_fty_apy_idx" value="${rentalFtyApyVo.rental_fty_apy_idx}"/>
        </form>
        <div class="wrap"><!--wrap-->
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">신청자 정보</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table half">
                        <div class="th wid_230">예약자명</div>
                        <div class="td">${rentalFtyApyVo.apy_name}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">휴대폰 번호</div>
                        <div class="td">${rentalFtyApyVo.apy_mob_no}</div>
                    </li>
                </ul>
            </div><!--table_box //-->

            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">예약정보</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="th wid_230">대관시설</div>
                        <div class="td">${rentalFtyVo.name}</div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">결제금액</div>
                        <div class="td"><span class="tc_5 fw_600"><fmt:formatNumber value="${rentalFtyApyVo.pay_sum}" pattern="##,###"/>원</span></div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">예약날짜</div>
                        <div class="td">${fn:substring(rentalFtyApyVo.resv_dt, 0, 10)}</div>
                    </li>
                    <li class="table">
                        <div class="th wid_230">예약시간</div>
                        <div class="td">
                            <c:if test="${rentalFtyApyVo.h9 eq 'Y'}">[09:00 ~ 10:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h10 eq 'Y'}"> [10:00 ~ 11:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h11 eq 'Y'}"> [11:00 ~ 12:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h12 eq 'Y'}"> [12:00 ~ 13:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h13 eq 'Y'}"> [13:00 ~ 14:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h14 eq 'Y'}"> [14:00 ~ 15:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h15 eq 'Y'}"> [15:00 ~ 16:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h16 eq 'Y'}"> [16:00 ~ 17:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h17 eq 'Y'}"> [17:00 ~ 18:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h18 eq 'Y'}"> [18:00 ~ 19:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h19 eq 'Y'}"> [19:00 ~ 20:00]</c:if>
                            <c:if test="${rentalFtyApyVo.h20 eq 'Y'}"> [20:00 ~ 21:00]</c:if>
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">결제선택</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table">
                        <div class="th wid_230">결제수단</div>
                        <div class="td">
                            <label class="fm_rd act_uiRdCh mr_20">
                                <input type="radio" name="pay_method_str" id="pay_method_a" value="A" checked><span>신용카드</span>
                            </label>
                            <label class="fm_rd act_uiRdCh">
                                <input type="radio" name="pay_method_str" id="pay_method_b" value="B"><span>실시간 계좌이체</span>
                            </label>
                        </div>
                    </li>
                </ul>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="#none" class="btn btn_long btn_big btn_color_5 t_center mr_20" id="btn_pay">결제하기</a>
                <a href="#none" class="btn btn_long btn_big t_center" id="btn_cancel">취소하기</a>

                <form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="/ssem/lgdacom/jsp/payres.jsp">
                    <input type="hidden" name="CST_PLATFORM" id="CST_PLATFORM" value="${CST_PLATFORM}"/>
                    <input type="hidden" name="CST_MID" id="CST_MID" value="${LGD_MID}"/>
                    <input type="hidden" name="LGD_MID" id="LGD_MID" value="${LGD_MID}"/>
                    <input type="hidden" name="LGD_OID" id="LGD_OID" value="${payVo.LGD_OID}"/>
                    <input type="hidden" name="LGD_AMOUNT" id="LGD_AMOUNT" value="${rentalFtyApyVo.pay_sum}"/>
                    <input type="hidden" name="LGD_BUYER" id="LGD_BUYER" value="${rentalFtyApyVo.apy_name}"/>
                    <input type="hidden" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="${rentalFtyVo.name}"/>
                    <input type="hidden" name="LGD_BUYEREMAIL" id="LGD_BUYEREMAIL" value=""/>
                    <input type="hidden" name="LGD_CUSTOM_SKIN" id="LGD_CUSTOM_SKIN" value="red"/>
                    <input type="hidden" name="LGD_CUSTOM_PROCESSTYPE" id="LGD_CUSTOM_PROCESSTYPE" value="TWOTR"/>
                    <input type="hidden" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value="${payVo.LGD_TIMESTAMP}"/>
                    <input type="hidden" name="LGD_HASHDATA" id="LGD_HASHDATA" value="${payVo.LGD_HASHDATA}"/>
                    <input type="hidden" name="LGD_RETURNURL" id="LGD_RETURNURL" value="<spring:message code="LGD_RETURNURL"/>"/>
                    <input type="hidden" name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY" value=""/>
                    <input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" value="IFRAME"/>
                    <input type="hidden" name="LGD_WINDOW_VER" id="LGD_WINDOW_VER" value="2.5"/>
                    <input type="hidden" name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE" value="iframe"/>
                    <input type="hidden" name="LGD_OSTYPE_CHECK" id="LGD_OSTYPE_CHECK" value=""/>
                    <%--<input type="hidden" name="LGD_ACTIVEXYN" id="LGD_ACTIVEXYN" value=""/>--%>
                    <input type="hidden" name="LGD_VERSION" id="LGD_VERSION" value="JSP_Non-ActiveX_Standard"/>
                    <input type="hidden" name="LGD_DOMAIN_URL" id="LGD_DOMAIN_URL" value="xpayvvip"/>
                    <input type="hidden" name="LGD_CASNOTEURL" id="LGD_CASNOTEURL" value="<spring:message code="LGD_CASNOTEURL"/>"/>
                    <input type="hidden" name="LGD_RESPCODE" id="LGD_RESPCODE" value=""/>
                    <input type="hidden" name="LGD_RESPMSG" id="LGD_RESPMSG" value=""/>
                    <input type="hidden" name="LGD_PAYKEY" id="LGD_PAYKEY" value=""/>
                    <input type="hidden" name="LGD_ENCODING" id="LGD_ENCODING" value="UTF-8"/>
                    <input type="hidden" name="LGD_ENCODING_RETURNURL" id="LGD_ENCODING_RETURNURL" value="UTF-8"/>
                </form>
            </div>
        </div><!--wrap//-->
    </div>
</div>
