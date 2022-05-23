<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2021-12-19
  Time: 오전 5:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        add_file();

        $("#btn_insert").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.work_type, "업무종류")){return false;}
            if(!fnIsValidRequired(frm.tel_no, "연락처")){return false;}
            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.cont, "내용")){return false;}

            $("#frm").submit();
        });
    });
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="btnArea mgt0 mgb10">
            <div class="left">
            </div>
            <div class="right">
                <div class="tblMsg ta_r">
                    <span class="co_red">*</span> 필수입력
                </div>
            </div>
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/request/request_inscr.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="group_idx" id="group_idx" value="${adminLoginVo.group_idx}">
            <input type="hidden" name="reg_nm" id="reg_nm" value="${adminLoginVo.name}">
            <input type="hidden" name="gbn_cd" value="1">
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <%--<c:choose>
                    <c:when test="${adminLoginVo.type eq 'S'}">
                        <tr>
                            <th class="required">구분</th>
                            <td>
                                <select name="gbn_cd">
                                    <option value="1">신청</option>
                                    <option value="2">신청확인</option>
                                    <option value="3">처리중</option>
                                    <option value="4">처리완료</option>
                                </select>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="gbn_cd" value="1">
                    </c:otherwise>
                </c:choose>--%>
                <tr>
                    <th class="required">업무종류</th>
                    <td>
                        <select id="work_type" name="work_type">
                            <option value="">선택</option>
                            <option value="1">콘텐츠</option>
                            <option value="2">기능개선</option>
                            <option value="3">오류하자</option>
                            <option value="4">기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>교육기관</th>
                    <td>${adminLoginVo.grp_name}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${adminLoginVo.name}</td>
                </tr>
                <tr>
                    <th class="required">연락처</th>
                    <td><input type="text" class="wid350" name="tel_no" id="tel_no" placeholder="숫자만입력" oninput="this.value = this.value.replace(/[^0-9]/g, '');"> <span class="co_red">예) 0212345678</span></td>
                </tr>
                <tr>
                    <th>요청 URL</th>
                    <td><input type="text" class="wid750" name="url" id="url"> <span class="co_red"> http:// 또는 https:// 가 포함된 url을 입력해 주세요.</span></td>
                </tr>
                <tr>
                    <th class="required">제목</th>
                    <td><input type="text" class="wid100per" name="title" id="title"></td>
                </tr>
                <tr>
                    <th class="required">내용</th>
                    <td>
                        <textarea name="cont" id="cont" class="textarea wid100per" cols="100%" rows="6" title="내용"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                        <ul id="file_ul">
                            <li class="mb5" style="display:none">
                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                            </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/request/request_list.do" class="btn">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_insert">저장</a>
            </div>
        </div>
    </article>
</div>

