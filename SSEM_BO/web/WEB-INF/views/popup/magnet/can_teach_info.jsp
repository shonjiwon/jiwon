<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-15
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib uri="/WEB-INF/tlds/common.tld" prefix="common" %>
<script type="text/javascript">
    $(document).ready(function(){
    });
</script>
<section class="wrap pop">
    <div class="container">
        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>신청자 정보</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:15%">
                    <col style="width:15%">
                    <col style="width:15%">
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>이름</th>
                    <td>${teachStudyVo.apy_name}</td>
                    <th>신청자ID</th>
                    <td>${teachStudyVo.apy_id}</td>
                    <th>휴대폰번호</th>
                    <td>${teachStudyVo.apy_mob_no}</td>
                </tr>
                </tbody>
            </table>
        </article>

        <article class="contUnit tbl_area leftType">
            <div class="btnArea mgt0 mgb10 of_h">
                <div class="left">
                    <h3>강의정보</h3>
                </div>
                <div class="right">
                </div>
            </div>
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>교육분야</th>
                    <td>${teachStudyVo.code_name}</td>
                </tr>
                <tr>
                    <th>강의명</th>
                    <td>${teachStudyVo.name}</td>
                </tr>
                <tr>
                    <th>강의계획</th>
                    <td>${teachStudyVo.cont}</td>
                </tr>
                <tr>
                    <th>강의계획서</th>
                    <td>
                        <c:forEach items="${teachStudyVo.planFileList}" var="plan" varStatus="status">
                            <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${plan.atch_file_id}&amp;fileNum=${plan.file_num}">${plan.file_ori_nm}</a>
                                </span>
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>강의이력</th>
                    <td>
                        <c:forEach items="${teachStudyVo.careerFileList}" var="career" varStatus="status">
                            <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${career.atch_file_id}&amp;fileNum=${career.file_num}">${career.file_ori_nm}</a>
                                </span>
                            </div>
                        </c:forEach>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <div class="left">
                </div>
                <div class="right">
                    <a href="#none" class="btn grey" onclick="window.close();">닫기</a>
                </div>
            </div>
        </article>
    </div>
</section>
