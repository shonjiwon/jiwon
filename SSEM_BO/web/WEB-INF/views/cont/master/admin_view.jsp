<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        // 휴대폰번호
        var mob_no = '${adminVo.mob_no}';
        if(mob_no !== '') {
            var jbSplit = mob_no.split('-');
            $("#mob_1").val(jbSplit[0]);
            $("#mob_2").val(jbSplit[1]);
            $("#mob_3").val(jbSplit[2]);
        }

        // 전화번호
        var tel_no = '${adminVo.tel_no}';
        if(tel_no !== '') {
            var jbSplit = tel_no.split('-');
            $("#tel_1").val(jbSplit[0]);
            $("#tel_2").val(jbSplit[1]);
            $("#tel_3").val(jbSplit[2]);
        }

        // 아이피
        var login_ip = '${adminVo.login_ip}';
        if(login_ip !== '') {
            var jbSplit = login_ip.split('.');
            $("#ip_1").val(jbSplit[0]);
            $("#ip_2").val(jbSplit[1]);
            $("#ip_3").val(jbSplit[2]);
            $("#ip_4").val(jbSplit[3]);
        }

        let p_idx = '${adminVo.p_idx}';
        let group_idx = '${adminVo.group_idx}';
        if(p_idx !== '' && group_idx !== '') {
            let select_val = p_idx;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            if (idx === Number(group_idx)) {
                                html += '<option value="' + v['group_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        }

        $('#p_idx').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/sub_group_list.do?p_idx=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#group_idx').children().remove();
                        html += '<option value="">선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['group_idx'];
                            html += '<option value="' + v['group_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#group_idx').append(html);
                    }
                });
            }
        });

        let type = '${adminVo.type}';
        let admin_rule_idx = '${adminVo.admin_rule_idx}';
        if(type !== '' && admin_rule_idx !== '') {
            let select_val = type;
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/admin_rule_list.do?type=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#admin_rule_idx').children().remove();
                        html += '<option value="">선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['admin_rule_idx'];
                            if (idx === Number(admin_rule_idx)) {
                                html += '<option value="' + v['admin_rule_idx'] + '" selected>' + v['name'] + '</option>';
                            } else {
                                html += '<option value="' + v['admin_rule_idx'] + '">' + v['name'] + '</option>';
                            }
                        });
                        $('#admin_rule_idx').append(html);
                    }
                });
            }
        }

        $('#type').change(function() {
            let select_val = $(this).val();
            let html = '';
            if(select_val !== '') {
                $.ajax({
                    url: "/ssemadmin/ajax/admin_rule_list.do?type=" + select_val,
                    type: 'POST',
                    dataType: 'json',
                    xhrFields: {
                        withCredentials: true
                    },
                    async   : false,
                    success: function(data){
                        $('#admin_rule_idx').children().remove();
                        html += '<option value="">선택</option>';
                        $.each(data,function(key,v) {
                            let idx = v['admin_rule_idx'];
                            html += '<option value="' + v['admin_rule_idx'] + '">' + v['name'] + '</option>';
                        });
                        $('#admin_rule_idx').append(html);
                    }
                });
            }
        })

        $("#btn_init_pwd").click(function() {
            modalMsg("비밀번호를 초기화 하시겠습니까?", 'yesorno', init_pwd);
        });

        $("#btn_update").click(function(){
            insert_frm();
        });

        $("#btn_delete").click(function(){
            $("#frm_del").submit();
        });
    });

    function init_pwd() {
        var frm = document.frm;

        // 비밀번호초기화
        $.ajax({
            url: "/ssemadmin/ajax/admin_init_pwd.do?admin_id=" + frm.admin_id.value + "&mob_no=${adminVo.mob_no}",
            type: 'POST',
            dataType: 'json',
            xhrFields: {
                withCredentials: true
            },
            async: false,
            success: function (data) {
                if (data == '1') {
                    modalMsg("비밀번호가 초기화되었습니다..", "notice", "");
                } else {
                    modalMsg("비밀번호 초기화에 실패하였습니다.", "notice", "");
                }
            }
        });
    }

    function insert_frm() {
        let frm = document.frm;

        if(!fnIsValidRequired(frm.p_idx, "소속")){return false;}
        if(!fnIsValidRequired(frm.group_idx, "기관/교육장")){return false;}
        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.tel_1, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.tel_2, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.tel_3, "전화번호")){return false;}
        if(!fnIsValidRequired(frm.email, "이메일")){return false;}
        if(!fnIsValidRequired(frm.type, "관리자유형")){return false;}
        if(!fnIsValidRequired(frm.admin_rule_idx, "관리자그룹")){return false;}
        if(!fnIsValidRequired(frm.ip_1, "아이피번호")){return false;}
        if(!fnIsValidRequired(frm.ip_2, "아이피번호")){return false;}
        if(!fnIsValidRequired(frm.ip_3, "아이피번호")){return false;}
        if(!fnIsValidRequired(frm.ip_4, "아이피번호")){return false;}

        if(!fnIsEmailAddr(frm.email)) {
            modalMsg("이메일을 올바른 형식으로 입력해 주세요.<br/>(예시:ssem@songpa.go.kr).", 'focus', '');
            return false;
        }

        $("#mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);
        $("#tel_no").val(frm.tel_1.value + '-' + frm.tel_2.value + '-' + frm.tel_3.value);
        $("#login_ip").val(frm.ip_1.value + '.' + frm.ip_2.value + '.' + frm.ip_3.value + '.' + frm.ip_4.value);

        $("#frm").submit();
    }
</script>
<div class="container">
    <article class="tit">
        <h2>${currentMenu.name}</h2>
        <p class="depth">HOME<span class="arrow">></span>${topMenu.name}<span class="arrow">></span>${currentMenu.name}</p>
    </article>
    <article class="contUnit tbl_area leftType">
        <div class="tblMsg">
            <span class="co_red">*</span> 필수입력
        </div>
        <form name="frm_del" id="frm_del" action="/ssemadmin/cont/master/admin_delete.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="admin_id" value="${adminVo.admin_id}"/>
        </form>
        <form name="frm" id="frm" action="/ssemadmin/cont/master/admin_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="admin_id" id="admin_id" value="${adminVo.admin_id}"/>
            <input type="hidden" name="name" id="name" value="${adminVo.name}"/>
            <input type="hidden" name="mob_no" id="mob_no" value="${adminVo.mob_no}"/>
            <input type="hidden" name="tel_no" id="tel_no" value="${adminVo.tel_no}"/>
            <input type="hidden" name="login_ip" id="login_ip" value="${adminVo.login_ip}"/>
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th>가입경로</th>
                    <td>
                        <c:choose>
                            <c:when test="${adminVo.apy_path eq 'M'}">마스터관리자</c:when>
                            <c:when test="${adminVo.apy_path eq 'U'}">가입요청</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <th>생성여부</th>
                    <td>
                        <input type="hidden" name="app_yn" id="app_yn" value="Y"/>
                        <c:choose>
                            <c:when test="${adminVo.app_yn eq 'Y'}">Y</c:when>
                            <c:when test="${adminVo.app_yn eq 'N'}">N</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td colspan="3">
                        <input type="radio" name="status" id="status_n" value="N" <c:if test="${adminVo.status eq 'N'}">checked="checked"</c:if>>
                        <label for="status_n">미사용</label>
                        <input type="radio" name="status" id="status_y" value="Y" <c:if test="${adminVo.status eq 'Y'}">checked="checked"</c:if>>
                        <label for="status_y">사용</label>
                        * 상태가 '사용'인 경우에만 해당 계정이 활성화(사용가능 상태) 됩니다.
                    </td>
                </tr>
                <tr>
                    <th class="required">이름</th>
                    <td colspan="3">
                        ${adminVo.name}
                    </td>
                </tr>
                <tr>
                    <th class="required">소속</th>
                    <td colspan="3">
                        <select id="p_idx" name="p_idx">
                            <c:forEach items="${masterGroupList}" var="item" varStatus="status">
                                <option value="${item.group_idx}" <c:if test="${item.group_idx eq adminVo.p_idx}">selected="selected"</c:if>>${item.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">기관/교육장</th>
                    <td colspan="3">
                        <select id="group_idx" name="group_idx">
                            <option value="">선택</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">아이디</th>
                    <td colspan="3">
                        ${adminVo.admin_id}
                    </td>
                </tr>
                <tr>
                    <th class="required">휴대폰번호</th>
                    <td colspan="3">
                        <input type="text" name="mob_1" id="mob_1" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="mob_2" id="mob_2" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="mob_3" id="mob_3" placeholder="휴대폰" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    </td>
                </tr>
                <tr>
                    <th class="required">전화번호</th>
                    <td colspan="3">
                        <input type="text" name="tel_1" id="tel_1" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="tel_2" id="tel_2" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        -
                        <input type="text" name="tel_3" id="tel_3" placeholder="전화번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                    </td>
                </tr>
                <tr>
                    <th class="required">이메일</th>
                    <td colspan="3">
                        <input type="text" name="email" id="email" class="wid350" placeholder="이메일" title="이메일" value="${adminVo.email}"/>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td colspan="3">
                        <span class="co_red"> * 최초 계성 생성 및 비밀번호 초기화 시, 임시 비밀번호가 자동으로 생성 됩니다.</span> <br/>
                        <span class="co_sky"> * 임시비밀번호 : ssem@+휴대폰번호 뒤4자리 + ! (예:ssem@1234).</span>
                        <c:if test="${adminVo.app_yn eq 'Y'}">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#none" class="btn sml grey" id="btn_init_pwd">비밀번호초기화</a>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th class="required">관리자유형</th>
                    <td colspan="3">
                        <select id="type" name="type" class="wid150">
                            <option value="">선택</option>
                            <option value="S" <c:if test="${adminVo.type eq 'S'}">selected="selected"</c:if>>마스터관리자</option>
                            <option value="G" <c:if test="${adminVo.type eq 'G'}">selected="selected"</c:if>>기관관리자</option>
                            <option value="N" <c:if test="${adminVo.type eq 'N'}">selected="selected"</c:if>>일반관리자</option>
                            <option value="B" <c:if test="${adminVo.type eq 'B'}">selected="selected"</c:if>>게시판관리자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">관리자그룹</th>
                    <td colspan="3">
                        <select class="wid200" id="admin_rule_idx" name="admin_rule_idx">
                            <option value="">선택</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">사용자 IP</th>
                    <td colspan="3">
                        <input type="text" name="ip_1" id="ip_1" placeholder="아이피번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        .
                        <input type="text" name="ip_2" id="ip_2" placeholder="아이피번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        .
                        <input type="text" name="ip_3" id="ip_3" placeholder="아이피번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        .
                        <input type="text" name="ip_4" id="ip_4" placeholder="아이피번호" class="wid100" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                        <br/>
                        <span class="co_red"> * 관리자 로그인시 사용되는 정보입니다. 정확하게 입력하지 않으시면 관리자 페이지 로그인이 제한될 수 있습니다.</span>
                    </td>
                </tr>
                <tr>
                    <th>가입요청일</th>
                    <td colspan="3">
                        ${adminVo.reg_dt}
                    </td>
                </tr><tr>
                    <th>최조수정일</th>
                    <td colspan="3">
                        ${adminVo.up_dt}
                    </td>
                </tr>

                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
                <a href="/ssemadmin/cont/master/admin_list.do" class="btn grey">목록</a>
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="#none" class="btn grey" id="btn_delete">삭제</a>
            </div>
        </div>
    </article>
</div>
