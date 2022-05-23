<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-19
  Time: 오후 9:04
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
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>

    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10 of_h">
            <div class="left">
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <table>
            <colgroup>
                <col style="width:15%">
                <col style="width:35%">
                <col style="width:15%">
                <col style="width:35%">
            </colgroup>
            <tbody>
            <tr>
                <th class="required">동별</th>
                <td>
                    ${tracProgResultVo.dong_cd}
                </td>
                <th class="required">기간(기준년월)</th>
                <td>
                    ${tracProgResultVo.standard_yymm}
                </td>
            </tr>
            <tr>
                <th class="required">구분</th>
                <td>
                    ${tracProgResultVo.div_cd}
                </td>
                <th class="required">프로그램명</th>
                <td>
                    ${tracProgResultVo.prog_nm}
                </td>
            </tr>
            <tr>
                <th class="required">교육기간</th>
                <td>
                    ${tracProgResultVo.tracProgramVo.course_sdate} ~ ${tracProgResultVo.tracProgramVo.course_edate}
                </td>
                <th>수강인원</th>
                <td>
                    남 : ${tracProgResultVo.man_cnt}, 여 : ${tracProgResultVo.woman_cnt}
                </td>
            </tr>
            <tr>
                <th>수강인원(합계)</th>
                <td>
                    <c:out value="${tracProgResultVo.man_cnt + tracProgResultVo.woman_cnt}" />
                </td>
                <th>계층별 참여인원</th>
                <td>
                    성인남성: ${tracProgResultVo.adult_man_cnt}, 성인여성: ${tracProgResultVo.adult_woman_cnt}, 청소년아동: ${tracProgResultVo.youth_cnt}, 노인: ${tracProgResultVo.oldman_cnt}
                </td>
            </tr>
            <tr>
                <th>비과세 여부</th>
                <td>
                    ${tracProgResultVo.tax_exemption}
                </td>
                <th>수강료(월)</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.tuition_monthly_fee}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>강사료(시간당)</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.lecturer_hourly_fee}" pattern="##,###"/>
                </td>
                <th>강의시간</th>
                <td>
                    ${tracProgResultVo.lecture_hour} (1시간 = 1, 1시간 30분 = 1.5)
                </td>
            </tr>
            <tr>
                <th>운영횟수</th>
                <td>
                    ${tracProgResultVo.operate_cnt}
                </td>
                <th>당초책정강사료</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.lecturer_pay_amount}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>감액자(50%)</th>
                <td>
                    인원 : ${tracProgResultVo.reduce_cnt}, 금액 : <fmt:formatNumber value="${tracProgResultVo.reduce_cnt * (tracProgResultVo.tuition_monthly_fee * 0.5)}" pattern="##,###"/>
                </td>
                <th>감액자(100%)</th>
                <td>
                    인원 : ${tracProgResultVo.reduce100_cnt}, 금액 : <fmt:formatNumber value="${tracProgResultVo.reduce100_cnt * (tracProgResultVo.tuition_monthly_fee * 1.0)}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>수강료징수액</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.collect_amount}" pattern="##,###"/>
                </td>
                <th>강사료(기금)</th>
                <td>
                    -
                </td>
            </tr>
            <tr>
                <th>강사료(구비)</th>
                <td>
                    -
                </td>
                <th>강사료(합계)</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>강사료 세액(소득세)</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033}" pattern="##,###"/>
                </td>
                <th>강사료 세액(주민세)</th>
                <td>
                    <fmt:formatNumber value="${tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033 * 0.1}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>강사료 세액(합계)</th>
                <td>
                    <fmt:formatNumber value="${(tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033) + (tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033 * 0.1)}" pattern="##,###"/>
                </td>
                <th>지급 강사료</th>
                <td>
                    <fmt:formatNumber value="${(tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt) - ((tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033) + (tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt * 0.033 * 0.1))}" pattern="##,###"/>
                </td>
            </tr>
            <tr>
                <th>적립기금</th>
                <td colspan="3">
                    <fmt:formatNumber value="${tracProgResultVo.collect_amount - (tracProgResultVo.lecturer_hourly_fee * tracProgResultVo.lecture_hour * tracProgResultVo.operate_cnt)}" pattern="##,###"/>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="/ssemadmin/cont/self/old_program_profit_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
