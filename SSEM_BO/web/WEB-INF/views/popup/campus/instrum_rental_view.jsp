<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-03
  Time: 오후 6:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function(){
        $("#btn_cancel").click(function(){
            modalMsg("예약취소는 PG사 결제취소와 연동되어 결제취소가 됩니다. 취소하시겠습니까?", 'yesorno', pay_cancel_frm);
        });

        $("#btn_close").click(function(){
            opener.location.reload();
            window.close();
        });
    });

    function pay_cancel_frm() {
        document.getElementById("frm_cancel").submit();
    }
</script>
<section class="wrap pop">
    <div class="container">
        <form method="post" name="frm_cancel" id="frm_cancel" action="/ssemadmin/cont/campus/instrum_rental_pay_cancel.do" enctype="multipart/form-data">
            <input type="hidden" name="CST_PLATFORM" value="service"/>
            <input type="hidden" name="CST_MID" value="${CST_MID}"/>
            <input type="hidden" name="LGD_TID" value="${rentalFtyApyVo.trade_code}"/>
            <input type="hidden" name="rental_fty_apy_idx" value="${rentalFtyApyVo.rental_fty_apy_idx}"/>
            <input type="hidden" name="rental_fty_idx" value="${rentalFtyApyVo.rental_fty_idx}"/>
        </form>
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>신청 정보</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:25%">
                    <col style="width:25%">
                    <col style="width:25">
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th>시설명</th>
                        <td>${rentalFtyApyVo.fty_name}</td>
                        <th>등록일시</th>
                        <td>${rentalFtyApyVo.reg_dt}</td>
                    </tr>
                    <tr>
                        <th>예약일</th>
                        <td>${fn:substring(rentalFtyApyVo.resv_dt, 0, 10)}</td>
                        <th>예약시간</th>
                        <td>
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
                        </td>
                    </tr>
                    <tr>
                        <th>예약자</th>
                        <td>${rentalFtyApyVo.apy_name}</td>
                        <th>휴대폰</th>
                        <td>${rentalFtyApyVo.apy_mob_no}</td>
                    </tr>
                    <tr>
                        <th>결제금액</th>
                        <td><fmt:formatNumber value="${rentalFtyApyVo.pay_sum}" pattern="##,###"/>원</td>
                        <th>결제수단</th>
                        <td>
                            <c:choose>
                                <c:when test="${rentalFtyApyVo.pay_method eq 'A'}">신용카드</c:when>
                                <c:when test="${rentalFtyApyVo.pay_method eq 'B'}">현금결제</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>결제상태</th>
                        <td>
                            <c:choose>
                                <c:when test="${rentalFtyApyVo.pay_status eq 'O'}">결제완료</c:when>
                                <c:when test="${rentalFtyApyVo.pay_status eq 'C'}">예약취소</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <th>결제완료 일시</th>
                        <td>${rentalFtyApyVo.pay_dt}</td>
                    </tr>
                    <tr>
                        <th>결제취소 일시</th>
                        <td colspan="3">
                            <c:choose>
                                <c:when test="${rentalFtyApyVo.pay_cancel_dt ne null}">${rentalFtyApyVo.pay_cancel_dt}</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>거래번호</th>
                        <td colspan="3">
                            ${rentalFtyApyVo.trade_code}
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <div class="left">
                    <c:if test="${rentalFtyApyVo.pay_cancel_dt eq null}">
                        <a href="#none" class="btn red" id="btn_cancel">예약취소</a>
                    </c:if>
                </div>
                <div class="right">
                    <a href="#none" class="btn grey" id="btn_close">닫기</a>
                </div>
            </div>
        </article>
    </div>
</section>
