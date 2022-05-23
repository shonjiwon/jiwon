<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-03
  Time: 오전 11:46
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
        $(document).prop('title', '프로그램 신청 > 프로그램 확인 > 나의 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        //감면 팝업 선택 버튼
        $(document).on('click', '#selectBtn', function(){
            if($("input[name='select_discount']").is(':checked')) {
                var discount_rate = $("input[name='select_discount']:checked").val();
                var checked_id = $("input[name='select_discount']:checked").attr('id');
                var selector = "#" + checked_id + "_txt";
                var discount_txt = $(selector).text();

                $('#select_discount_txt').text(discount_rate + "% (" + discount_txt + ")");
                $(this).parents('#popup2').find('.close_btn').trigger('click');

                // 감면정보에 따른 결제금액 계산
                var fee = Number(${lectureVo.fee});
                var rate = Number(discount_rate);
                var real_fee = fee - (fee * (rate / 100));

                $('#real_fee').text(comma(real_fee) + '원');
                $('#LGD_AMOUNT').val(real_fee);

                ajaxCall(checked_id, discount_rate);

            } else {
                alert("감면정보를 선택해주세요.")
            }
        });

        $(document).on('click', '#disSelectBtn', function(){
            $("input[name='select_discount']").prop("checked", false);
            $('#select_discount_txt').text("");
            $('#discount_idx').val("");
            $('#discount_rate').val("");

            // 감면정보에 따른 결제금액 웝복
            var fee = Number(${lectureVo.fee});
            $('#real_fee').text(comma(fee) + '원');
            $('#LGD_AMOUNT').val(fee);

            ajaxCall("", "");

            $(this).parents('#popup2').find('.close_btn').trigger('click');
        });

        $("#btn_print").click(function(){
            window.print();
        });

        $("#btn_pay").click(function(){
            if(isMobile()) {
                lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', 'iframe', null, "350", "600");
            } else {
                lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', 'iframe', null, "", "");
            }
        });

        $("#btn_pay_cancel").click(function(){
            modalMsg("결제 취소하시겠습니까?", 'yesorno', pay_cancel_frm);
        });

        $("#btn_apy_cancel").click(function(){
            modalMsg("신청 취소하시겠습니까?", 'yesorno', apy_cancel_frm);
        });

        $("#btn_apy_refund").click(function(){
            modalMsg("환불신청을 하시겠습니까?", 'yesorno', apy_refund_frm);
        });
    });

    function pay_cancel_frm() {
        document.getElementById("pay_cancel").submit();
    }

    function apy_cancel_frm() {
        document.getElementById("apy_cancel").submit();
    }

    function apy_refund_frm() {
        var frm = document.apy_refund;

        if(!fnIsValidRequired(frm.refund_mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.refund_mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.refund_mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.refund_cont, "환불요청정보")){return false;}

        $("#refund_mob_no").val(frm.refund_mob_1.value + '-' + frm.refund_mob_2.value + '-' + frm.refund_mob_3.value);

        document.getElementById("apy_refund").submit();
    }

    function ajaxCall(discount_idx, discount_rate) {
        // 감면정보 update
        var fee = $('#LGD_AMOUNT').val();

        // 감면정보 update
        $.ajax({
            url: "/ssem/ajax/discount_update.do?lecture_apy_idx=${lectureApyVo.lecture_apy_idx}&discount_idx=" + discount_idx + "&discount_rate=" + discount_rate + "&fee=" + fee,
            type: 'POST',
            dataType: 'json',
            xhrFields: {
                withCredentials: true
            },
            async   : false,
            success: function(data){
                if (data !== 0) {
                    $('#LGD_HASHDATA').val(data.lGD_HASHDATA);
                    $('#LGD_OID').val(data.lGD_OID);
                    $('#LGD_TIMESTAMP').val(data.lGD_TIMESTAMP);
                    console.log("success");
                } else {
                    console.log("failed");
                }
            }
        });
    }

    function comma(num){
        var len, point, str;
        num = num + "";
        point = num.length % 3 ;
        len = num.length;

        str = num.substring(0, point);
        while (point < len) {
            if (str != "") str += ",";
            str += num.substring(point, point + 3);
            point += 3;
        }
        return str;
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
    <form method="post" name="pay_result" id="pay_result" action="/ssem/senior/mypage/program_payment.do" enctype="multipart/form-data">
        <input type="hidden" name="CST_PLATFORM" value="service"/>
        <input type="hidden" name="CST_MID" value="${LGD_MID}"/>
        <input type="hidden" name="LGD_PAYKEY" id="LGD_PAYKEY_RESULT"/>
        <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
        <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}"/>
        <input type="hidden" name="discount_rate" id="discount_rate"/>
        <input type="hidden" name="discount_idx" id="discount_idx"/>
    </form>
    <form method="post" name="pay_cancel" id="pay_cancel" action="/ssem/senior/mypage/program_payment_cancel.do" enctype="multipart/form-data">
        <input type="hidden" name="CST_PLATFORM" value="service"/>
        <input type="hidden" name="CST_MID" value="${LGD_MID}"/>
        <input type="hidden" name="LGD_TID" value="${lectureApyVo.trade_code}"/>
        <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
        <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}"/>
    </form>
    <form method="post" name="apy_cancel" id="apy_cancel" action="/ssem/senior/mypage/program_apy_cancel.do" enctype="multipart/form-data">
        <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
        <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}"/>
    </form>
    <div class="sub_con st_5 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">프로그램확인<i class="icon_arrow_down_w ml_60">다운</i></a>
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
        <!--2020.11.05 : e-->
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
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90 mt_md_65">프로그램 신청</h1>

                <h2 class="c_tit_2 ptb_20 mt_20 mt_md_0 clearfix_after">
                    <span>프로그램 정보</span>
                    <ul class="program_btn_box">
                        <li><button type="button" id="btn_print"><i class="icon_print">프린트</i></button></li>
                    </ul>
                </h2>
                <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                    <ul>
                        <li class="table">
                            <div class="th wid_230">프로그램명</div>
                            <div class="td">${lectureVo.name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육분야</div>
                            <div class="td">${lectureVo.part_name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육대상</div>
                            <div class="td">
                                <c:forEach items="${lectureVo.array_tgt}" var="tgt" varStatus="status">
                                    <span class="item">${tgt}</span>
                                </c:forEach>
                            </div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육기관</div>
                            <div class="td">${lectureVo.group.name}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육장소</div>
                            <div class="td">${lectureVo.place.name}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">주소</div>
                            <div class="td">
                                <span class="dp_inp va_m mr_10">${lectureVo.place.addr} ${lectureVo.place.addr2}</span>
                                <!--
                                    2020.10.26 : start
                                    .act_popup_map_open > sub.js
                                -->
                                <br class="screen_hide screen_md_show">
                                <a href="https://map.kakao.com/?q=${lectureVo.place.addr}" class="btn btn_color_t btn_small btn_auto screen_md_hide" target="_blank">지도보기</a>
                                <!--2020.10.26 : end-->
                            </div>
                        </li>

                        <li class="table half">
                            <div class="th wid_230">교육기간</div>
                            <div class="td">${fn:substring(lectureVo.start_dt, 0, 10)} ~ ${fn:substring(lectureVo.end_dt, 0, 10)}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">교육시간</div>
                            <div class="td">${lectureVo.dt_str} ${lectureVo.start_time}~${lectureVo.end_time}</div>
                        </li>
                        <div class="table half">
                            <div class="th wid_230">수강료</div>
                            <div class="td"><fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                                <c:if test="${lectureVo.fee_detail ne '' && lectureVo.fee_detail ne null}">
                                    (${lectureVo.fee_detail})
                                </c:if>
                            </div>
                        </div>
                        <li class="table half">
                            <div class="th wid_230">정보화교육여부</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureVo.ict_yn eq 'Y'}">
                                        예
                                    </c:when>
                                    <c:otherwise>
                                        아니오
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">감면대상</div>
                            <div class="td">
                                <ul class="ul_list_dash mtb_10">
                                    <c:forEach items="${lectureVo.array_discount}" var="discount" varStatus="status">
                                        <li>${discount.rate}% (${discount.tgt_name})</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">결제방법</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureVo.pay_type eq 'I'}">
                                        온라인결제
                                    </c:when>
                                    <c:when test="${lectureVo.pay_type eq 'C'}">
                                        현장결제
                                    </c:when>
                                    <c:otherwise>
                                        무료
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                        <li class="table">
                            <div class="th wid_230">특이사항</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureVo.desc_txt eq '' || lectureVo.desc_txt eq null}">
                                        -
                                    </c:when>
                                    <c:otherwise>
                                        ${lectureVo.desc_txt}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">환불정책</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureVo.refund_txt eq '' || lectureVo.refund_txt eq null}">
                                        -
                                    </c:when>
                                    <c:otherwise>
                                        ${lectureVo.refund_txt}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                    </ul>
                </div><!--table_box //-->

                <h2 class="c_tit_2 ptb_20 mt_50 clearfix_after">신청 정보</h2>

                <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                    <ul>
                        <li class="table">
                            <div class="th wid_230">신청자 명
                            </div>
                            <div class="td">${lectureApyVo.apy_name}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">휴대전화</div>
                            <div class="td">${lectureApyVo.apy_mob_no}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">주소</div>
                            <div class="td">(${lectureApyVo.postcode}) ${lectureApyVo.apy_addr1} ${lectureApyVo.apy_addr2}</div>
                        </li>
                    </ul>
                </div>
                <c:if test="${lectureApyVo.apy_ref ne null}">
                <div class="mt_55 fs_18 fs_md_24">
                    <label class="fm_ch act_uiRdCh mr_20">
                        <!--2020.11.04 : s-->
                        <input type="checkbox" name="ch_1" class="ch_type" value="개인" checked disabled>
                        <!--2020.11.04 : e-->
                        <span>교육대상이 미성년 자제인 경우 선택해 주세요.</span>
                    </label>
                </div>
                <div class="table_box_ul fs_18 fs_md_24 mt_25"><!--table_box-->
                    <ul>
                        <li class="table">
                            <div class="th wid_230">신청자와의 관계
                            </div>
                            <div class="td">${lectureApyVo.apy_ref}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">교육대상자 이름</div>
                            <div class="td">${lectureApyVo.apy_real_name}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">휴대전화</div>
                            <div class="td">${lectureApyVo.apy_ref_mob_no}</div>
                        </li>
                    </ul>
                </div>
                </c:if>
                <h2 class="c_tit_2 ptb_20 mt_50 clearfix_after">접수 정보</h2>
                <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                    <ul>
                        <li class="table half">
                            <div class="th wid_230">신청방법</div>
                            <div class="td">${lectureVo.reg_method_str}</div>
                        </li>
                        <li class="table half">
                            <div class="th wid_230">신청일</div>
                            <div class="td">${fn:substring(lectureApyVo.reg_dt, 0, 16)}</div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">신청상태</div>
                            <div class="td">
                                <c:choose>
                                    <c:when test="${lectureApyVo.apy_status eq '1'}"><span class="my_tc_1">신청</span></c:when>
                                    <c:when test="${lectureApyVo.apy_status eq '2'}"><span class="my_tc_2">대기신청</span></c:when>
                                    <c:when test="${lectureApyVo.apy_status eq '3'}"><span class="my_tc_3">신청취소</span></c:when>
                                    <c:otherwise> - </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <li class="table">
                            <div class="th wid_230">결제금액</div>
                            <c:choose>
                                <c:when test="${lectureApyVo.pay_status eq '1'}">
                                    <div class="td" id="real_fee"><fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="td"><fmt:formatNumber value="${lectureApyVo.pay_sum}" pattern="##,###"/>원</div>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <c:choose>
                            <c:when test="${lectureApyVo.pay_status eq '1'}">
                                <li class="table">
                                    <div class="th wid_230">감면여부</div>
                                    <div class="td">
                                        <div class="mtb_10">
                                            <button type="button" data-popup-id="#popup2" class="act_popup btn btn_color_1 btn_small mt_10">감면 선택</button>
                                            <span class="ml_20" id="select_discount_txt"></span>
                                        </div>
                                    </div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제일자</div>
                                    <div class="td">-</div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제상태</div>
                                    <div class="td">
                                        <c:choose>
                                            <c:when test="${lectureApyVo.pay_status eq '1'}">입금대기</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '2'}">결제완료</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '3'}">결제취소</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '4'}">환불신청</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '5'}">환불처리</c:when>
                                            <c:otherwise> - </c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                            </c:when>
                            <c:when test="${lectureApyVo.pay_status eq '2' || lectureApyVo.pay_status eq '4' || lectureApyVo.pay_status eq '5'}">
                                <li class="table">
                                    <div class="th wid_230">감면여부</div>
                                    <div class="td">
                                        <c:if test="${lectureApyVo.discount_idx ne 0 && lectureApyVo.discount_idx ne null}">
                                            <div class="mtb_10">
                                                ${discountVo.rate}% ,
                                                ${discountVo.tgt_name} <br/>
                                                    <c:if test="${discountVo.dtl_txt ne null && discountVo.dtl_txt ne ''}">
                                                        (${discountVo.dtl_txt})
                                                    </c:if>
                                            </div>
                                        </c:if>
                                    </div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제일자</div>
                                    <div class="td">${fn:substring(lectureApyVo.pay_dt, 0, 16)}</div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제상태</div>
                                    <div class="td">
                                        <c:choose>
                                            <c:when test="${lectureApyVo.pay_status eq '1'}">입금대기</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '2'}">결제완료</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '3'}">결제취소</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '4'}">환불신청</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '5'}">환불처리</c:when>
                                            <c:otherwise> - </c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                                <li class="table">
                                    <div class="th wid_230">환불요청정보</div>
                                    <div class="td">
                                        <c:choose>
                                            <c:when test="${lectureApyVo.pay_status eq '4'}">
                                                <button type="button" data-popup-id="#popup3" class="act_popup btn btn_color_1 btn_small">환불신청수정</button>
                                            </c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '2'}">
                                                <c:choose>
                                                    <c:when test="${lectureApyVo.appv_cd eq '1'}">
                                                        <button type="button" data-popup-id="#popup3" class="act_popup btn btn_color_1 btn_small">환불신청</button>
                                                    </c:when>
                                                    <c:otherwise> - </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '5'}">
                                                <button type="button" data-popup-id="#popup3" class="act_popup btn btn_color_1 btn_small">환불신청보기</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </li>
                                <c:if test="${lectureApyVo.pay_status eq '4' || lectureApyVo.pay_status eq '5'}">
                                    <li class="table half">
                                        <div class="th wid_230">환불신청일</div>
                                        <div class="td">${fn:substring(lectureApyVo.refund_dt, 0, 16)}</div>
                                    </li>
                                    <li class="table half">
                                        <div class="th wid_230">환불처리일</div>
                                        <div class="td">${fn:substring(lectureApyVo.refund_ok_dt, 0, 16)}</div>
                                    </li>
                                </c:if>
                            </c:when>
                            <c:when test="${lectureApyVo.pay_status eq '3'}">
                                <li class="table">
                                    <div class="th wid_230">감면여부</div>
                                    <div class="td">
                                        <c:if test="${lectureApyVo.discount_idx ne 0 && lectureApyVo.discount_idx ne null}">
                                        <div class="mtb_10">
                                                ${discountVo.rate}% ,
                                                ${discountVo.tgt_name} <br/>
                                                    <c:if test="${discountVo.dtl_txt ne null && discountVo.dtl_txt ne ''}">
                                                        (${discountVo.dtl_txt})
                                                    </c:if>
                                        </div>
                                        </c:if>
                                    </div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제일자</div>
                                    <div class="td">${fn:substring(lectureApyVo.pay_dt, 0, 16)}</div>
                                </li>
                                <li class="table half">
                                    <div class="th wid_230">결제상태</div>
                                    <div class="td">
                                        <c:choose>
                                            <c:when test="${lectureApyVo.pay_status eq '1'}">입금대기</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '2'}">결제완료</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '3'}">결제취소</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '4'}">환불신청</c:when>
                                            <c:when test="${lectureApyVo.pay_status eq '5'}">환불처리</c:when>
                                            <c:otherwise> - </c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                                <li class="table">
                                    <div class="th wid_230">결제취소일</div>
                                    <div class="td">${fn:substring(lectureApyVo.pay_cancel_dt, 0, 16)}</div>
                                </li>
                            </c:when>
                        </c:choose>
                    </ul>
                </div>
                <div class="btn_box mt_50 t_right">
                    <c:choose>
                        <c:when test="${lectureApyVo.pay_status eq '1'}">
                            <c:if test="${lectureApyVo.apy_status ne '3'}">
                                <c:if test="${lectureVo.pay_type eq 'I' && lectureApyVo.apy_status eq '1'}">
                                    <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15 mr_15" id="btn_pay">결제하기</button>
                                </c:if>
                                <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15" id="btn_apy_cancel">신청취소</button>
                            </c:if>
                            <a href="/ssem/senior/mypage/program_list.do" class="btn btn_short btn_big t_center">목록</a>

                            <form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="/ssem/lgdacom/jsp/payres.jsp">
                                <input type="hidden" name="CST_PLATFORM" id="CST_PLATFORM" value="${CST_PLATFORM}"/>
                                <input type="hidden" name="CST_MID" id="CST_MID" value="${LGD_MID}"/>
                                <input type="hidden" name="LGD_MID" id="LGD_MID" value="${LGD_MID}"/>
                                <input type="hidden" name="LGD_OID" id="LGD_OID" value="${payVo.LGD_OID}"/>
                                <input type="hidden" name="LGD_BUYER" id="LGD_BUYER" value="${lectureApyVo.apy_name}"/>
                                <input type="hidden" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="${lectureVo.name}"/>
                                <input type="hidden" name="LGD_AMOUNT" id="LGD_AMOUNT" value="${lectureVo.fee}"/>
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
                        </c:when>
                        <c:when test="${lectureApyVo.pay_status eq '2'}">
                            <c:if test="${lectureApyVo.appv_cd eq '2'}">
                                <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15" id="btn_pay_cancel">결제취소</button>
                            </c:if>
                            <a href="/ssem/senior/mypage/program_list.do" class="btn btn_short btn_big t_center">목록</a>
                        </c:when>
                        <c:when test="${lectureApyVo.pay_status eq '5'}">
                            <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15" id="btn_apy_cancel">신청취소</button>
                            <a href="/ssem/senior/mypage/program_list.do" class="btn btn_short btn_big t_center">목록</a>
                        </c:when>
                        <c:when test="${lectureApyVo.pay_status eq '6'}">
                            <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15" id="btn_apy_cancel">신청취소</button>
                            <a href="/ssem/senior/mypage/program_list.do" class="btn btn_short btn_big t_center">목록</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/ssem/senior/mypage/program_list.do" class="btn btn_short btn_big t_center">목록</a>
                        </c:otherwise>
                    </c:choose>
                    <!--
                        환불신청
                        <a href="#"  class="btn btn_short btn_big t_center">목록</a>
                    -->
                    <!--
                        결제 후 미승인 상태 온라인 결제
                        <button type="button" class="btn btn_long btn_big btn_md_auto t_center mr_15 mr_15">결제취소</button>
                        <a href="#"  class="btn btn_short btn_big t_center">목록</a>
                    -->
                </div>
            </div>
        </section>
        </form>
    </div><!-- sub_con : e -->
    <!--
        Event > sub.js
        close_btn : click > sub.js
    -->
    <div class="popup_wrap_st3" id="popup1">
        <div class="popup_box">
            <div class="popup_top">
                <p>강의장소보기</p>
            </div>
            <div class="popup_con">
                <div class="table_box t_center">
                    <table class="st_2">
                        <caption class="text_hide">강의장소안내</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="76%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="t_left">교육장소</th>
                            <td><p class="mlr_20 t_left">송파 미래교육센터 1관</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">주소</th>
                            <td><p class="mlr_20 t_left">서울시 송파구 송파대로1 ,1 송파빌딩 1층</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">연락처</th>
                            <td><p class="mlr_20 t_left">02-2147-5322</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="popup_map mt_30">
                    <!--text 제거 : 임시-->
                    <p class="t_center ptb_55 fs_30">MAP</p>
                    <!--text 제거 : 임시-->
                </div>
            </div>
            <div class="popup_btn clearfix">
                <button type="button" class="btn float_left"><i class="icon_print mr_5">프린트</i><span class="fs_20 fs_md_26">인쇄</span></button>
                <button type="button" data-popup-id="#popup1" class="btn float_right btn_short close_btn"><span class="fs_20 fs_md_26">닫기</span></button>
            </div>
            <button class="close_btn" data-popup-id="#popup1"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>
    <!--
        Event > sub.js
        close_btn : click > sub.js
    -->
    <div class="popup_wrap_st3" id="popup3">
        <div class="popup_box">
            <div class="popup_top">
                <p>환불 신청</p>
            </div>
            <form method="post" name="apy_refund" id="apy_refund" action="/ssem/senior/mypage/program_apy_refund.do" enctype="multipart/form-data">
                <input type="hidden" name="lecture_apy_idx" value="${lectureApyVo.lecture_apy_idx}"/>
                <input type="hidden" name="lecture_idx" value="${lectureVo.lecture_idx}"/>
                <input type="hidden" name="refund_mob_no" id="refund_mob_no"/>
            <div class="popup_con">
                <p class="t_right"><span class="my_tc_3">*</span>필수입력</p>
                <div class="table_box t_center">
                    <table class="st_2">
                        <!--2020.11.04 : start-->
                        <caption class="text_hide">환불신청</caption>
                        <colgroup>
                            <col width="24%">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="t_left">신청자 명</th>
                            <td><p class="mlr_20 mlr_md_10 mtb_md_10 t_left">${loginVo.user_nm}</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">휴대전화</th>
                            <td class="t_left">
                                <div class="fm_phon mlr_20 mlr_md_10 mtb_md_10 mt_5">
                                <span class="sel_box" title="휴대전화 앞번호">
                                    <select name="refund_mob_1" id="refund_mob_1" title="휴대전화 앞번호">
                                        <option value="010" <c:if test="${lectureVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${lectureVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${lectureVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${lectureVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${lectureVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                    </select>
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="refund_mob_2" id="refund_mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${lectureVo.mob_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="refund_mob_3" id="refund_mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${lectureVo.mob_3}">
                                </span>
                                </div>
                                <p class="tc_sub fs_16 fs_md_22 t_left mlr_20 mlr_md_10 mtb_md_5">※ 휴대폰 번호를 확인 후 수정해주세요.</p>
                            </td>
                        </tr>

                        <tr>
                            <th class="t_left">주소</th>
                            <td ><p class="mlr_20 mlr_md_10 mtb_md_10 t_left">(${lectureApyVo.postcode}) ${lectureApyVo.apy_addr1} ${lectureApyVo.apy_addr2}</p></td>
                        </tr>
                        <tr>
                            <th class="t_left">환불금액</th>
                            <td ><p class="mlr_20 mlr_md_10 mtb_md_10 t_left"><fmt:formatNumber value="${lectureApyVo.pay_sum}" pattern="##,###"/>원</p></td>
                        </tr>

                        <tr>
                            <th class="t_left"><span class="my_tc_3 ">*</span>환불요청<br><span class="ml_5 dp_inb">정보</span></th>
                            <td>
                                <div class="fm_tf">
                                    <textarea id="tf2" class="act_word_cnt" name="refund_cont" id="refund_cont" onkeyup="calcWordLng(200)" data-max-word="200" placeholder="환불신청정보의 신청자의 은행, 계좌번호, 예금자명, 기타 정보를 입력해주세요. (은행 : OO은행, 계좌번호 : 1234-5678, 예금자명 : OOO)">${lectureApyVo.refund_cont}</textarea>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                        <!--2020.11.04 : end-->
                    </table>
                </div>
                <p class="fs_16 fs_md_22 mt_20 lh_16 fw_300 tc_sub">*환불처리는 환불신청 후 해당 담당자가 확인하여 개별적으로 연락하여 처리가 됩니다.</p>
            </div>
            </form>
            <div class="popup_btn clearfix">
                <div class="t_right">
                    <button type="button" data-popup-id="#popup3" class="btn btn_short btn_color_black mr_10" id="btn_apy_refund"><span class="fs_20 fs_md_26">신청</span></button>
                    <button type="button" data-popup-id="#popup3" class="btn btn_short close_btn"><span class="fs_20 fs_md_26">닫기</span></button>
                </div>
            </div>
            <button class="close_btn" data-popup-id="#popup3"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>



    <!--2020.11.04 : s-->

    <!--
        감면 선택
        Event > sub.js
        close_btn : click > sub.js
    -->
    <div class="popup_wrap_st3" id="popup2">
        <div class="popup_box wid_995">
            <div class="popup_top">
                <p>감면 선택</p>
            </div>
            <div class="popup_con">
                <p class="tc_sub fw_300 fs_18 mt_10 mb_20 t_center">감면대상이 있는 경우 선택 후 결제가 가능하며, 감면 적용은 담당자가 재확인 하는점 안내드립니다.</p>
                <div class="table_box t_center">
                    <table class="st_3">
                        <caption class="text_hide">강의장소안내</caption>
                        <colgroup>
                            <col width="10%">
                            <col width="">
                            <col width="20%">
                            <col width="20%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>선택</th>
                            <th>감면대상</th>
                            <th>상세조건</th>
                            <th>감면율(%)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${discountList}" var="discount" varStatus="status">
                            <tr>
                                <td>
                                    <label class="fm_ch act_uiRdCh">
                                        <input type="radio" name="select_discount" id="${discount.discount_idx}" value="${discount.rate}" title="선택">
                                    </label>
                                </td>
                                <td><p class=" t_left" id="${discount.discount_idx}_txt">${discount.tgt_name}</p></td>
                                <td>${discount.dtl_txt}</td>
                                <td>${discount.rate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="popup_btn clearfix">
                <!--아래 script 이벤트-->
                <button type="button" class="btn float_right btn_short btn_color_black" id="selectBtn"><span class="fs_20 fs_md_26">선택</span></button>
                <button type="button" class="btn float_left btn_short btn_color_2" id="disSelectBtn"><span class="fs_20 fs_md_26">해제</span></button>
            </div>
            <button class="close_btn" data-popup-id="#popup2"><i class="icon_close_bk">닫기</i></button>
        </div>
    </div>
</div>


