<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-16
  Time: 오후 12:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        // 검색 조건중 소속 정보가 있는 경우
        let group_idx = '${adminLoginVo.group_idx}';
        if(group_idx !== '') {
            let select_val = group_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_list.do?group_idx=" + select_val + "&sdate=${sdate}",
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#prg_date').text("프로그램선택시 자동입력");
                        $('#lecture_idx').children().remove();
                        html += '<option value="">선택하세요</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['lecture_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#lecture_idx').append(html);
                    }
                });
            }
        }
        // 동선택시 기준년월에 따른 프로그램 리스트 표시
        $('#group_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_list.do?group_idx=" + select_val + "&sdate=${sdate}",
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#prg_date').text("프로그램선택시 자동입력");
                        $('#lecture_idx').children().remove();
                        html += '<option value="">선택하세요</option>';
                        $.each(data,function(key,v) {
                            html += '<option value="' + v['lecture_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#lecture_idx').append(html);
                    }
                });
            } else {
                $('#prg_date').text("프로그램선택시 자동입력");
                $('#lecture_idx').children().remove();
                html += '<option value="">선택하세요</option>';
                $('#lecture_idx').append(html);
            }
        });

        $('#lecture_idx').change(function() {
            let select_val = $(this).val();
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/program_date.do?lecture_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#prg_date').text(data);
                    }
                });
            } else {
                $('#prg_date').text("프로그램선택시 자동입력");
            }
        });

        $('#btn_insert').click(function() {
            let frm = document.frm;

            if(!fnIsValidRequired(frm.group_idx, "동별")){return false;}

            if(frm.auto_check.value !== 'Y') {
                alert("자동입력 선택 후 저장해 주세요");
                return false;
            }

            $("#frm").submit();
        });

        $('#btn_auto').click(function() {
            let frm = document.frm;

            if(frm.man_cnt.value !== '' && frm.woman_cnt.value !== '') {
                $('#tot_student_cnt').text(Number(frm.man_cnt.value) + Number(frm.woman_cnt.value));
            }

            if(frm.lecturer_hourly_fee.value !== '' && frm.lecture_hour.value !== '' && frm.operate_cnt.value !== '') {
                $('#pay_teacher').text(numberWithCommasString(Number(frm.lecturer_hourly_fee.value) * Number(frm.lecture_hour.value) * Number(frm.operate_cnt.value)));
            }

            if(frm.man_cnt.value !== '' && frm.woman_cnt.value !== '' && frm.tuition_monthly_fee.value !== '') {
                var fee = (Number(frm.man_cnt.value) + Number(frm.woman_cnt.value)) * Number(frm.tuition_monthly_fee.value);
                if(frm.reduce5_cost.value !== '') { fee -= Number(frm.reduce5_cost.value); }
                if(frm.reduce10_cost.value !== '') { fee -= Number(frm.reduce10_cost.value); }
                if(frm.reduce15_cost.value !== '') { fee -= Number(frm.reduce15_cost.value); }
                if(frm.reduce20_cost.value !== '') { fee -= Number(frm.reduce20_cost.value); }
                if(frm.reduce25_cost.value !== '') { fee -= Number(frm.reduce25_cost.value); }
                if(frm.reduce30_cost.value !== '') { fee -= Number(frm.reduce30_cost.value); }
                if(frm.reduce50_cost.value !== '') { fee -= Number(frm.reduce50_cost.value); }
                if(frm.reduce100_cost.value !== '') { fee -= Number(frm.reduce100_cost.value); }

                $('#tot_fee').text(numberWithCommasString(fee));
            }

            if(frm.lecturer_fund_cost.value !== '' && frm.lecturer_exist_cost.value !== '') {
                $('#sum_fee').text(numberWithCommasString(Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value)));
                $('#tax_income').text(numberWithCommasString( (Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value)) * 0.03));
                $('#tax_resi').text(numberWithCommasString( ((Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value)) * 0.03)*0.1));
                $('#tot_tax').text(numberWithCommasString( (Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value)) * 0.03 + (((Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value))) * 0.03)*0.1 ));

                var fee = (Number(frm.man_cnt.value) + Number(frm.woman_cnt.value)) * Number(frm.tuition_monthly_fee.value);
                if(frm.reduce5_cost.value !== '') { fee -= Number(frm.reduce5_cost.value); }
                if(frm.reduce10_cost.value !== '') { fee -= Number(frm.reduce10_cost.value); }
                if(frm.reduce15_cost.value !== '') { fee -= Number(frm.reduce15_cost.value); }
                if(frm.reduce20_cost.value !== '') { fee -= Number(frm.reduce20_cost.value); }
                if(frm.reduce25_cost.value !== '') { fee -= Number(frm.reduce25_cost.value); }
                if(frm.reduce30_cost.value !== '') { fee -= Number(frm.reduce30_cost.value); }
                if(frm.reduce50_cost.value !== '') { fee -= Number(frm.reduce50_cost.value); }
                if(frm.reduce100_cost.value !== '') { fee -= Number(frm.reduce100_cost.value); }

                $('#pay_fee').text(numberWithCommasString( Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value) - ((Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value)) * 0.03 + (((Number(frm.lecturer_fund_cost.value) + Number(frm.lecturer_exist_cost.value))) * 0.03)*0.1) ));
                $('#tot_fund').text(numberWithCommasString( fee - Number(frm.lecturer_fund_cost.value)));
            }

            frm.auto_check.value = "Y";
        });
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
            <div class="left" style="width:40%">
                <span class="co_red">*합계 등 일부 항목은 [자동입력] 버튼을 클릭하면 자동계산되어 표시됩니다.</span><br/>
                <span class="co_red">*데이터입력 및 수정 -> [자동입력] -> [저장]</span>
            </div>
            <div class="right" style="width:80%">
                <div class="tblMsg ta_r">
                    <a href="#none" class="btn sml blue mgl20" id="btn_auto">자동입력</a>
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/self/new_program_profit_inscr.do" method="post" enctype="multipart/form-data">
            <input type="hidden" class="wid150" id="auto_check" name="auto_check">
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
                    <select id="group_idx" name="group_idx" class="wid150" <c:if test="${adminLoginVo.type ne 'S'}">disabled</c:if>>
                        <option value="">선택하세요.</option>
                        <c:forEach items="${dongList}" var="dong" varStatus="status">
                            <option value="${dong.group_idx}" <c:if test="${adminLoginVo.group_idx eq dong.group_idx}">selected="selected"</c:if>>${dong.name}</option>
                        </c:forEach>
                    </select>
                </td>
                <th>기간(기준년월)</th>
                <td>
                    ${sdate}
                    <input type="hidden" class="wid150" id="standard_yymm" name="standard_yymm" value="${sdate}">
                </td>
            </tr>
            <tr>
                <th>구분</th>
                <td>
                    <select class="wid150" id="div_cd" name="div_cd">
                        <option value="">선택</option>
                        <option value="1">문화여가</option>
                        <option value="2">인문교양</option>
                    </select>
                </td>
                <th>프로그램</th>
                <td>
                    <select class="wid250" id="lecture_idx" name="lecture_idx">
                        <option value="">선택</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>교육기간</th>
                <td><span class="co_red" id="prg_date">프로그램선택시 자동입력</span></td>
                <th>수강인원</th>
                <td>
                    남 <input type="text" class="wid50" id="man_cnt" name="man_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    여 <input type="text" class="wid50" id="woman_cnt" name="woman_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>수강인원(합계)</th>
                <td>
                    <span class="co_red" id="tot_student_cnt">자동입력</span>
                </td>
                <th>계층별 참여인원</th>
                <td>
                    성인남성 <input type="text" class="wid50" id="adult_man_cnt" name="adult_man_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;
                    성인여성 <input type="text" class="wid50" id="adult_woman_cnt" name="adult_woman_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;
                    청소년아동 <input type="text" class="wid50" id="youth_cnt" name="youth_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;
                    노인 <input type="text" class="wid50" id="oldman_cnt" name="oldman_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>비과세여부</th>
                <td>
                    <input type="radio" name="tax_exemption" id="tax_exemption_n" value="N" checked>
                    <label for="tax_exemption_n">N</label>
                    <input type="radio" name="tax_exemption" id="tax_exemption_y" value="Y">
                    <label for="tax_exemption_y">Y</label>
                </td>
                <th>수강료(월)</th>
                <td>
                    <input type="text" class="wid150" id="tuition_monthly_fee" name="tuition_monthly_fee" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>강사료(시간당)</th>
                <td>
                    <input type="text" class="wid150" id="lecturer_hourly_fee" name="lecturer_hourly_fee" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>강의시간</th>
                <td>
                    <input type="text" class="wid150" id="lecture_hour" name="lecture_hour"> 1시간=1, 1시간30분=1.5
                </td>
            </tr>
            <tr>
                <th>운영횟수</th>
                <td>
                    <input type="text" class="wid150" id="operate_cnt" name="operate_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>당초책정강사료</th>
                <td>
                    <span class="co_red" id="pay_teacher">자동입력</span>
                </td>
            </tr>
            <tr>
                <th>감액자(5%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce5_cnt" name="reduce5_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce5_cost" name="reduce5_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>감액자(10%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce10_cnt" name="reduce10_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce10_cost" name="reduce10_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>감액자(15%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce15_cnt" name="reduce15_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce15_cost" name="reduce15_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>감액자(20%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce20_cnt" name="reduce20_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce20_cost" name="reduce20_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>감액자(25%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce25_cnt" name="reduce25_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce25_cost" name="reduce25_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>감액자(30%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce30_cnt" name="reduce30_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce30_cost" name="reduce30_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>감액자(50%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce50_cnt" name="reduce50_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce50_cost" name="reduce50_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>감액자(100%)</th>
                <td>
                    인원 <input type="text" class="wid50" id="reduce100_cnt" name="reduce100_cnt" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    금액 <input type="text" class="wid150" id="reduce100_cost" name="reduce100_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>수강료징수액</th>
                <td>
                    <span class="co_red" id="tot_fee">자동입력</span>
                </td>
                <th>강사료(기금)</th>
                <td>
                    <input type="text" class="wid150" id="lecturer_fund_cost" name="lecturer_fund_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
            </tr>
            <tr>
                <th>강사료(구비)</th>
                <td>
                    <input type="text" class="wid150" id="lecturer_exist_cost" name="lecturer_exist_cost" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                </td>
                <th>강사료(합계)</th>
                <td>
                    <span class="co_red" id="sum_fee">자동입력</span>
                </td>
            </tr>
            <tr>
                <th>강사료 세액(소득세)</th>
                <td>
                    <span class="co_red" id="tax_income">자동입력</span>
                </td>
                <th>강사료 세액(주민세)</th>
                <td>
                    <span class="co_red" id="tax_resi">자동입력</span>
                </td>
            </tr>
            <tr>
                <th>강사료 세액(합계)</th>
                <td>
                    <span class="co_red" id="tot_tax">자동입력</span>
                </td>
                <th>지급 강사료</th>
                <td>
                    <span class="co_red" id="pay_fee">자동입력</span>
                </td>
            </tr>
            <tr>
                <th>적급기금</th>
                <td colspan="3">
                    <span class="co_red" id="tot_fund">자동입력</span>
                </td>
            </tr>
            </tbody>
        </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
                <a href="/ssemadmin/cont/self/new_program_profit_list.do" class="btn">목록</a>
            </div>
        </div>
    </article>
</div>
