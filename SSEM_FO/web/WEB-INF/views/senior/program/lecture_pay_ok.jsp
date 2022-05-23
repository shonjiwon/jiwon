<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-12
  Time: 오전 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '통합프로그램신청 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js
        tableInit(); //sub.js table.half pc높이 맞춤
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_9"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit font_sc">
                    통합프로그램신청
                </h2>

                <p class="tit_sub">
                    청소년의 적성과 재능에 맞는 길을 찾아주는<br>
                    열린교육 송파쌤, 청소년 교육
                </p>
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
                        <a href="#" class="deapth_tit" title="선택">통합프로그램신청</a>
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
        <div class="wrap">
            <div class="row">
                <div class="col_8 offset_2 t_center">
                    <h3 class="mt_100 mb_50 tit font_sc dp_ind">통합프로그램신청</h3>
                </div>
            </div>
        </div>
        <div class="wrap">
            <div class="completion_box t_center">
                <img src="/ssem/resources/img/sub/completion_img.png" alt="완료">

                <h5 class="fs_30 mt_15">결제가 완료되었습니다.</h5>
                <p class="fs_20 mt_5">
                    신청하신 내역은 마이페이지에서 확인 가능 합니다.<br>
                    결제취소 및 변경은 담당자에게 문의해 주세요.(☎ 02-123-4567)
                </p>
                <a href="/ssem/senior/mypage/program_list.do" class="btn mt_25">마이페이지</a>
            </div>
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">프로그램 정보</h5>
            <div class="table_box_ul fs_18 fs_md_24"><!--table_box-->
                <ul>
                    <li class="table ">
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
                        <div class="th wid_230">주소
                        </div>
                        <div class="td">
                            <span class="dp_inp va_m mr_10">${lectureVo.place.addr} ${lectureVo.place.addr2}</span>
                            <!--
                                2020.10.26 : start
                                .act_popup_map_open > sub.js
                            -->
                            <a href="https://map.kakao.com/?q=${lectureVo.place.addr}" class="btn btn_color_t btn_small btn_auto screen_md_hide" target="_blank">지도보기</a>
                            <!--2020.10.26 : end-->
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육기간
                        </div>
                        <div class="td">${fn:substring(lectureVo.start_dt, 0, 10)} ~ ${fn:substring(lectureVo.end_dt, 0, 10)}
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">교육시간
                        </div>
                        <div class="td">${lectureVo.dt_str} ${lectureVo.start_time}~${lectureVo.end_time}
                        </div>
                    </li>

                    <li class="table half">
                        <div class="td wid_p_50 p_0 line_none_bottom">
                            <div class="table">
                                <div class="th wid_230">수강료</div>
                                <div class="td">
                                    <fmt:formatNumber value="${lectureVo.fee}" pattern="##,###"/>원
                                    <c:if test="${lectureVo.fee_detail ne '' && lectureVo.fee_detail ne null}">
                                        (${lectureVo.fee_detail})
                                    </c:if>
                                </div>
                            </div>
                            <div class="table">
                                <div class="th wid_230">결제방법</div>
                                <div class="td">
                                    <c:choose>
                                        <c:when test="${lectureVo.pay_type eq 'I'}">
                                            온라인결제
                                        </c:when>
                                        <c:otherwise>
                                            현장결제
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="table half">
                        <div class="th wid_230">감면대상</div>
                        <div class="td">
                            <ul class="ul_list_dash">
                                <c:forEach items="${lectureVo.array_discount}" var="discount" varStatus="status">
                                    <li>${discount.rate}% (${discount.tgt_name})</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                    <li class="table">
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
            <h5 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">신청자 정보</h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">신청자 정보의 신청자 이름, 휴대폰 번호, 주소</caption>
                    <tbody>
                    <tr>
                        <th class="wid_230">신청자 이름</th>
                        <td>${lectureApyVo.apy_name}</td>
                    </tr>
                    <tr>
                        <th class="wid_230">휴대폰 번호</th>
                        <td>
                            ${lectureApyVo.apy_mob_no}
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">주소</th>
                        <td>(${lectureApyVo.postcode}) ${lectureApyVo.apy_addr1} ${lectureApyVo.apy_addr2}</td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <c:if test="${lectureApyVo.apy_ref ne null}">
            <h5 class="fs_18 fs_md_30 fw_500 fw_md_500 ptb_20 mt_20">
                <label class="fm_ch act_uiRdCh">
                    <input type="checkbox" name="ch_1" disabled checked><span class="ml_5">교육대상이 미성년 자제인 경우 선택해 주세요.</span>
                </label>

            </h5>
            <div class="table_box fs_18 fs_md_24"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">교육대상이 미성년 자제인 경우 정보의 신청자와의 관계, 교육대상자 이름, 휴대전화</caption>
                    <tbody class="disabled">
                    <tr>
                        <th class="wid_230">신청자와의 관계</th>
                        <td>
                                ${lectureApyVo.apy_ref}
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">교육대상자 이름</th>
                        <td>
                                ${lectureApyVo.apy_real_name}
                        </td>
                    </tr>
                    <tr>
                        <th class="wid_230">휴대전화</th>
                        <td>
                                ${lectureApyVo.apy_ref_mob_no}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div><!--table_box //-->
            </c:if>
            <div class="table_box fs_18 fs_md_24 mt_60"><!--table_box-->
                <table class="table">
                    <caption class="text_hide">결제정보의 결제금액, 감면대상</caption>
                    <tbody class="disabled">
                    <tr>
                        <th class="wid_230">결제금액</th>
                        <td>
                            <strong class="tc_1 fs_20"><fmt:formatNumber value="${lectureApyVo.pay_sum}" pattern="##,###"/>원</strong>
                        </td>
                    </tr>
                    <c:if test="${lectureApyVo.discount_idx ne 0 && lectureApyVo.discount_idx ne null}">
                    <tr>
                        <th class="wid_230">감면대상</th>
                        <td>
                            ${discountVo.rate}% (${discountVo.tgt_name})
                        </td>
                    </tr>
                    </c:if>
                    </tbody>
                </table>
            </div><!--table_box //-->
            <div class="btn_box mt_50 mb_100 pb_30 t_center">
                <a href="/ssem/senior/program/lecture_list.do" class="btn btn_long btn_big t_center mr_15">확인</a>
                <a href="/ssem/senior/mypage/program_list.do" class="btn btn_long btn_big btn_color_1 t_centermr_20 ">프로그램신청 보기</a>
            </div>

        </div>
    </div>
    <!--
        강의장소보기
        Event > sub.js
        close_btn : click > sub.js
    -->
    <%--<div class="popup_wrap_st3" id="popup1">
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
    </div>--%>
</div>
