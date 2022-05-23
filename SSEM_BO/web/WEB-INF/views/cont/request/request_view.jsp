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
        $("#btn_update").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.work_type, "업무종류")){return false;}
            if(!fnIsValidRequired(frm.tel_no, "연락처")){return false;}
            if(!fnIsValidRequired(frm.title, "제목")){return false;}
            if(!fnIsValidRequired(frm.cont, "내용")){return false;}

            $("#frm").submit();
        });

        // 첨부파일 추가
        $("#btn_add").click(function(){
            return false;
        });

        $("#btn_delete").click(function(){
            modalMsg("삭제 하시겠습니까?", 'yesorno', delete_frm);
        });

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssemadmin/file/file_delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: "atch_file_id=" + del_id_arr[0] + "&file_num=" + del_id_arr[1],
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        if (data !== true) {
                            alert("삭제에 실패하였습니다.");
                        } else {
                            alert("삭제하였습니다.");
                            location.href = "?req_idx=${requestVo.req_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });
    });

    function delete_frm() {
        document.delfrm.submit();
    }
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
        <form name="delfrm" id="delfrm" action="/ssemadmin/cont/request/request_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="req_idx" value="${requestVo.req_idx}">
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/request/request_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="req_idx" value="${requestVo.req_idx}">
            <c:choose>
                <c:when test="${adminLoginVo.type eq 'S'}">
                    <table>
                        <colgroup>
                            <col style="width:15%">
                            <col style="width:35%">
                            <col style="width:15%">
                            <col style="width:20%">
                            <col style="width:10%">
                            <col style="width:5%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="required">구분</th>
                            <td colspan="5">
                                <select name="gbn_cd">
                                    <option value="1" <c:if test="${requestVo.gbn_cd eq '1'}">selected="selected"</c:if>>신청</option>
                                    <option value="2" <c:if test="${requestVo.gbn_cd eq '2'}">selected="selected"</c:if>>신청확인</option>
                                    <option value="3" <c:if test="${requestVo.gbn_cd eq '3'}">selected="selected"</c:if>>처리중</option>
                                    <option value="4" <c:if test="${requestVo.gbn_cd eq '4'}">selected="selected"</c:if>>처리완료</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="required">업무종류</th>
                            <td colspan="5">
                                <select name="work_type">
                                    <option value="1" <c:if test="${requestVo.work_type eq '1'}">selected="selected"</c:if>>콘텐츠</option>
                                    <option value="2" <c:if test="${requestVo.work_type eq '2'}">selected="selected"</c:if>>기능개선</option>
                                    <option value="3" <c:if test="${requestVo.work_type eq '3'}">selected="selected"</c:if>>오류하자</option>
                                    <option value="4" <c:if test="${requestVo.work_type eq '4'}">selected="selected"</c:if>>기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>교육기관</th>
                            <td colspan="5">${requestVo.grp_name}</td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td colspan="5">${requestVo.reg_nm}</td>
                        </tr>
                        <tr>
                            <th class="required">연락처</th>
                            <td colspan="5"><input type="text" class="wid350" name="tel_no" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${requestVo.tel_no}"> <span class="co_red">예) 0212345678</span></td>
                        </tr>
                        <tr>
                            <th>요청 URL</th>
                            <td colspan="5"><input type="text" class="wid750" name="url" value="${requestVo.url}"> <span class="co_red"> http:// 또는 https:// 가 포함된 url을 입력해 주세요.</span></td>
                        </tr>
                        <tr>
                            <th class="required">제목</th>
                            <td colspan="5"><input type="text" class="wid100per" name="title" value="${requestVo.title}"></td>
                        </tr>
                        <tr>
                            <th class="required">내용</th>
                            <td colspan="5">
                                <textarea name="cont" class="textarea wid100per" cols="100%" rows="6" title="내용">${requestVo.cont}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="5">
                                <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                                <ul id="file_ul">
                                    <li class="mb5" style="display:none">
                                        <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                        <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                                    </li>
                                </ul>
                                    <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                                <c:forEach items="${requestVo.fileList}" var="item" varStatus="status">
                                    <c:if test="${item != null}">
                                        <div class="imgArea">
                                <span>
                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                </span>
                                            <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>${requestVo.reg_id}</td>
                            <th>작성일</th>
                            <td>${requestVo.reg_dt}</td>
                            <th>조회수</th>
                            <td>${requestVo.cnt}</td>
                        </tr>
                        <tr>
                            <th>최종수정자</th>
                            <td>${requestVo.up_id}</td>
                            <th>최종수정일</th>
                            <td colspan="3">${requestVo.up_dt}</td>
                        </tr>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${requestVo.reg_id eq adminLoginVo.admin_id and requestVo.gbn_cd eq '1'}">
                            <table>
                                <colgroup>
                                    <col style="width:15%">
                                    <col style="width:35%">
                                    <col style="width:15%">
                                    <col style="width:20%">
                                    <col style="width:10%">
                                    <col style="width:5%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th class="required">구분</th>
                                    <td colspan="5">
                                        신청
                                        <input type="hidden" name="gbn_cd" value="${requestVo.gbn_cd}">
                                    </td>
                                </tr>
                                <tr>
                                    <th class="required">업무종류</th>
                                    <td colspan="5">
                                        <select name="work_type">
                                            <option value="1" <c:if test="${requestVo.work_type eq '1'}">selected="selected"</c:if>>콘텐츠</option>
                                            <option value="2" <c:if test="${requestVo.work_type eq '2'}">selected="selected"</c:if>>기능개선</option>
                                            <option value="3" <c:if test="${requestVo.work_type eq '3'}">selected="selected"</c:if>>오류하자</option>
                                            <option value="4" <c:if test="${requestVo.work_type eq '4'}">selected="selected"</c:if>>기타</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>교육기관</th>
                                    <td colspan="5">${requestVo.grp_name}</td>
                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td colspan="5">${requestVo.reg_nm}</td>
                                </tr>
                                <tr>
                                    <th class="required">연락처</th>
                                    <td colspan="5"><input type="text" class="wid350" name="tel_no" oninput="this.value = this.value.replace(/[^0-9]/g, '');" value="${requestVo.tel_no}"> <span class="co_red">예) 0212345678</span></td>
                                </tr>
                                <tr>
                                    <th>요청 URL</th>
                                    <td colspan="5"><input type="text" class="wid750" name="url" value="${requestVo.url}"> <span class="co_red"> http:// 또는 https:// 가 포함된 url을 입력해 주세요.</span></td>
                                </tr>
                                <tr>
                                    <th class="required">제목</th>
                                    <td colspan="5"><input type="text" class="wid100per" name="title" value="${requestVo.title}"></td>
                                </tr>
                                <tr>
                                    <th class="required">내용</th>
                                    <td colspan="5">
                                        <textarea name="cont" class="textarea wid100per" cols="100%" rows="6" title="내용">${requestVo.cont}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>첨부파일</th>
                                    <td colspan="5">
                                        <a href="#" class="btn sml grey" id="btn_add">첨부파일추가</a>
                                        <ul id="file_ul">
                                            <li class="mb5" style="display:none">
                                                <input type="file" name="attfile" id="attfile#" class="wid350 mgt10" />
                                                <a href="#" class="btn sml red mgl10 btn_del">삭제</a>
                                            </li>
                                        </ul>
                                        <%--<span>(파일형식 : jpg, jpge, png, gif / 사이즈 : 000*000)</span>--%>
                                        <c:forEach items="${requestVo.fileList}" var="item" varStatus="status">
                                            <c:if test="${item != null}">
                                                <div class="imgArea">
                                                <span>
                                                <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                                </span>
                                                    <a href="#" id="btn_file_del_${item.atch_file_id}_${item.file_num}" class="btn_del">x</a>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td>${requestVo.reg_id}</td>
                                    <th>작성일</th>
                                    <td>${requestVo.reg_dt}</td>
                                    <th>조회수</th>
                                    <td>${requestVo.cnt}</td>
                                </tr>
                                <tr>
                                    <th>최종수정자</th>
                                    <td>${requestVo.up_id}</td>
                                    <th>최종수정일</th>
                                    <td colspan="3">${requestVo.up_dt}</td>
                                </tr>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <table>
                                <colgroup>
                                    <col style="width:15%">
                                    <col style="width:35%">
                                    <col style="width:15%">
                                    <col style="width:20%">
                                    <col style="width:10%">
                                    <col style="width:5%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th class="required">구분</th>
                                    <td colspan="5">
                                        <c:choose>
                                            <c:when test="${requestVo.gbn_cd eq '1'}">신청</c:when>
                                            <c:when test="${requestVo.gbn_cd eq '2'}">신청확인</c:when>
                                            <c:when test="${requestVo.gbn_cd eq '3'}">처리중</c:when>
                                            <c:when test="${requestVo.gbn_cd eq '4'}">처리완료</c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="required">업무종류</th>
                                    <td colspan="5">
                                        <c:choose>
                                            <c:when test="${requestVo.work_type eq '1'}">콘텐츠</c:when>
                                            <c:when test="${requestVo.work_type eq '2'}">기능개선</c:when>
                                            <c:when test="${requestVo.work_type eq '3'}">오류하자</c:when>
                                            <c:when test="${requestVo.work_type eq '4'}">기타</c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>교육기관</th>
                                    <td colspan="5">${requestVo.grp_name}</td>
                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td colspan="5">${requestVo.reg_nm}</td>
                                </tr>
                                <tr>
                                    <th class="required">연락처</th>
                                    <td colspan="5">${requestVo.tel_no}</td>
                                </tr>
                                <tr>
                                    <th>요청 URL</th>
                                    <td colspan="5">${requestVo.url}</td>
                                </tr>
                                <tr>
                                    <th class="required">제목</th>
                                    <td colspan="5">${requestVo.title}</td>
                                </tr>
                                <tr>
                                    <th class="required">내용</th>
                                    <td colspan="5">
                                        <textarea name="cont" class="textarea wid100per" cols="100%" rows="6" title="내용" readonly>${requestVo.cont}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>첨부파일</th>
                                    <td colspan="5">
                                        <c:forEach items="${requestVo.fileList}" var="item" varStatus="status">
                                            <c:if test="${item != null}">
                                                <div class="imgArea">
                                                    <span>
                                                    <a style="text-decoration: underline;" href="/ssemadmin/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}">${item.file_ori_nm}</a>
                                                    </span>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>작성자</th>
                                    <td>${requestVo.reg_id}</td>
                                    <th>작성일</th>
                                    <td>${requestVo.reg_dt}</td>
                                    <th>조회수</th>
                                    <td>${requestVo.cnt}</td>
                                </tr>
                                <tr>
                                    <th>최종수정자</th>
                                    <td>${requestVo.up_id}</td>
                                    <th>최종수정일</th>
                                    <td colspan="3">${requestVo.up_dt}</td>
                                </tr>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="javascript:history.back();" class="btn">목록</a>
            </div>
            <div class="right">
                    <c:choose>
                        <c:when test="${adminLoginVo.type eq 'S'}">
                            <a href="#none" class="btn grey" id="btn_update">수정</a>
                            <a href="#none" class="btn red" id="btn_delete">삭제</a>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${requestVo.reg_id eq adminLoginVo.admin_id and requestVo.gbn_cd eq '1'}">
                                <a href="#none" class="btn grey" id="btn_update">수정</a>
                                <a href="#none" class="btn red" id="btn_delete">삭제</a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
            </div>
        </div>
    </article>
</div>

