<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-14
  Time: 오전 7:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $("#C01").change(function() {
            if($("#C01").is(":checked")){
                $("#02").prop('checked', true);$("#03").prop('checked', true);$("#04").prop('checked', true);$("#05").prop('checked', true);$("#10").prop('checked', true);
            }else{
                $("#02").prop('checked', false);$("#03").prop('checked', false);$("#04").prop('checked', false);$("#05").prop('checked', false);$("#10").prop('checked', false);
            }
        });
        $("#C11").change(function() {
            if($("#C11").is(":checked")){
                $("#12").prop('checked', true);$("#14").prop('checked', true);
            }else{
                $("#12").prop('checked', false);$("#14").prop('checked', false);
            }
        });
        $("#C15").change(function() {
            if($("#C15").is(":checked")){
                $("#16").prop('checked', true);$("#17").prop('checked', true);$("#18").prop('checked', true);$("#19").prop('checked', true);$("#20").prop('checked', true);
                $("#21").prop('checked', true);$("#22").prop('checked', true);$("#91").prop('checked', true);
            }else{
                $("#16").prop('checked', false);$("#17").prop('checked', false);$("#18").prop('checked', false);$("#19").prop('checked', false);$("#20").prop('checked', false);
                $("#21").prop('checked', false);$("#22").prop('checked', false);$("#91").prop('checked', false);
            }
        });
        $("#C23").change(function() {
            if($("#C23").is(":checked")){
                $("#24").prop('checked', true);$("#25").prop('checked', true);$("#26").prop('checked', true);
            }else{
                $("#24").prop('checked', false);$("#25").prop('checked', false);$("#26").prop('checked', false);
            }
        });
        $("#C27").change(function() {
            if($("#C27").is(":checked")){
                $("#28").prop('checked', true);$("#29").prop('checked', true);$("#30").prop('checked', true);$("#107").prop('checked', true);$("#108").prop('checked', true);$("#109").prop('checked', true);
            }else{
                $("#28").prop('checked', false);$("#29").prop('checked', false);$("#30").prop('checked', false);$("#107").prop('checked', false);$("#108").prop('checked', false);$("#109").prop('checked', false);
            }
        });
        $("#C31").change(function() {
            if($("#C31").is(":checked")){
                $("#32").prop('checked', true);$("#41").prop('checked', true);$("#48").prop('checked', true);$("#52").prop('checked', true);$("#89").prop('checked', true);
            }else{
                $("#32").prop('checked', false);$("#41").prop('checked', false);$("#48").prop('checked', false);$("#52").prop('checked', false);$("#89").prop('checked', false);
            }
        });
        $("#C56").change(function() {
            if($("#C56").is(":checked")){
                $("#57").prop('checked', true);$("#63").prop('checked', true);$("#67").prop('checked', true);$("#71").prop('checked', true);$("#75").prop('checked', true);
            }else{
                $("#57").prop('checked', false);$("#63").prop('checked', false);$("#67").prop('checked', false);$("#71").prop('checked', false);$("#75").prop('checked', false);
            }
        });
        $("#C79").change(function() {
            if($("#C79").is(":checked")){
                $("#80").prop('checked', true);$("#81").prop('checked', true);$("#82").prop('checked', true);
            }else{
                $("#80").prop('checked', false);$("#81").prop('checked', false);$("#82").prop('checked', false);
            }
        });
        $("#C83").change(function() {
            if($("#C83").is(":checked")){
                $("#84").prop('checked', true);$("#85").prop('checked', true);$("#86").prop('checked', true);$("#92").prop('checked', true);$("#93").prop('checked', true);$("#94").prop('checked', true);$("#95").prop('checked', true);
            }else{
                $("#84").prop('checked', false);$("#85").prop('checked', false);$("#86").prop('checked', false);$("#92").prop('checked', false);$("#93").prop('checked', false);$("#94").prop('checked', false);$("#95").prop('checked', false);
            }
        });
        $("#C96").change(function() {
            if($("#C96").is(":checked")){
                $("#97").prop('checked', true);$("#98").prop('checked', true);$("#99").prop('checked', true);$("#100").prop('checked', true);$("#101").prop('checked', true);$("#102").prop('checked', true);
                $("#103").prop('checked', true);$("#104").prop('checked', true);$("#105").prop('checked', true);$("#106").prop('checked', true);
            }else{
                $("#97").prop('checked', false);$("#98").prop('checked', false);$("#99").prop('checked', false);$("#100").prop('checked', false);$("#101").prop('checked', false);$("#102").prop('checked', false);
                $("#103").prop('checked', false);$("#104").prop('checked', false);$("#105").prop('checked', false);$("#106").prop('checked', false);
            }
        });
        $("#C110").change(function() {
            if($("#C110").is(":checked")){
                $("#111").prop('checked', true);
            }else{
                $("#111").prop('checked', false);
            }
        });

        $("#btn_update").click(function(){
            var frm = document.frm;

            if(!fnIsValidRequired(frm.type, "관리자유형")){return false;}
            if(!fnIsValidRequired(frm.name, "그륩명")){return false;}

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
        <div class="tblMsg">
            <span class="co_red">*</span> 필수입력
        </div>
        <form name="frm" id="frm" action="/ssemadmin/cont/master/role_view.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="admin_rule_idx" id="admin_rule_idx" value="${adminRuleVo.admin_rule_idx}" />
            <table>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody>
                <tr>
                    <th class="required">관리자유형</th>
                    <td colspan="3">
                        <select class="wid200" name="type" id="type">
                            <option value="S" <c:if test="${adminRuleVo.type eq 'S'}">selected="selected"</c:if>>마스터관리자</option>
                            <option value="G" <c:if test="${adminRuleVo.type eq 'G'}">selected="selected"</c:if>>기관관리자</option>
                            <option value="N" <c:if test="${adminRuleVo.type eq 'N'}">selected="selected"</c:if>>일반관리자</option>
                            <option value="B" <c:if test="${adminRuleVo.type eq 'B'}">selected="selected"</c:if>>게시판관리자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="required">그룹명</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" id="name" name="name" value="${adminRuleVo.name}">
                    </td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                        <input type="text" class="wid100per" id="explain" name="explain" value="${adminRuleVo.explain}">
                    </td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td colspan="3">
                        <input type="radio" name="use_yn" id="use_y" value="Y" <c:if test="${adminRuleVo.use_yn eq 'Y'}">checked="checked"</c:if>>
                        <label for="use_y">사용</label>
                        <input type="radio" name="use_yn" id="use_n" value="N" <c:if test="${adminRuleVo.use_yn eq 'N'}">checked="checked"</c:if>>
                        <label for="use_n">미사용</label>
                    </td>
                </tr>
                <tr>
                    <th>최조등록자</th>
                    <td>${adminRuleVo.reg_id}</td>
                    <th>최초등록일</th>
                    <td>${adminRuleVo.reg_dt}</td>
                </tr>
                <tr>
                    <th>최종수정자</th>
                    <td>${adminRuleVo.up_id}</td>
                    <th>최종수정일</th>
                    <td>${adminRuleVo.up_dt}</td>
                </tr>
                <tr>
                    <th>세부권한</th>
                    <td colspan="3">
                        <table class="mgt10">
                            <colgroup>
                                <col style="width:20rem">
                                <col>
                            </colgroup>
                            <tbody>
                            <!-- 마스터 관리 -->
                            <tr>
                                <td rowspan="5">
                                    <input type="checkbox" name="menu_array" id="C01" value="1" title="마스터관리" <c:if test="${adminRuleVo.menuIndexVo.menu_1 eq 'Y'}">checked="checked"</c:if>><label for="C01">마스터관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="02" value="2" title="관리자관리" <c:if test="${adminRuleVo.menuIndexVo.menu_2 eq 'Y'}">checked="checked"</c:if>><label for="02">관리자관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="03" value="3" title="권한그룹관리" <c:if test="${adminRuleVo.menuIndexVo.menu_3 eq 'Y'}">checked="checked"</c:if>><label for="03">권한그룹관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="04" value="4" title="조직관리" <c:if test="${adminRuleVo.menuIndexVo.menu_4 eq 'Y'}">checked="checked"</c:if>><label for="04">조직관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="05" value="5" title="로그관리" <c:if test="${adminRuleVo.menuIndexVo.menu_5 eq 'Y'}">checked="checked"</c:if>><label for="05">로그관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="10" value="10" title="통계관리" <c:if test="${adminRuleVo.menuIndexVo.menu_10 eq 'Y'}">checked="checked"</c:if>><label for="10">통계관리</label>
                                </td>
                            </tr>
                            <!-- 메인 관리 -->
                            <tr>
                                <td rowspan="2">
                                    <input type="checkbox" name="menu_array" id="C11" value="11" title="메인관리" <c:if test="${adminRuleVo.menuIndexVo.menu_11 eq 'Y'}">checked="checked"</c:if>><label for="C11">메인관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="12" value="12" title="메인이미지관리" <c:if test="${adminRuleVo.menuIndexVo.menu_12 eq 'Y'}">checked="checked"</c:if>><label for="12">메인이미지관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="14" value="14" title="팝업관리" <c:if test="${adminRuleVo.menuIndexVo.menu_14 eq 'Y'}">checked="checked"</c:if>><label for="14">팝업관리</label>
                                </td>
                            </tr>
                            <!-- 통합 강좌 관리 -->
                            <tr>
                                <td rowspan="8">
                                    <input type="checkbox" name="menu_array" id="C15" value="15" title="통합프로그램관리" <c:if test="${adminRuleVo.menuIndexVo.menu_15 eq 'Y'}">checked="checked"</c:if>><label for="C15">통합프로그램관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="16" value="16" title="프로그램관리" <c:if test="${adminRuleVo.menuIndexVo.menu_16 eq 'Y'}">checked="checked"</c:if>><label for="16">프로그램관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="17" value="17" title="신청/접수관리" <c:if test="${adminRuleVo.menuIndexVo.menu_17 eq 'Y'}">checked="checked"</c:if>><label for="17">신청/접수관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="18" value="18" title="프로그램별교육생관리" <c:if test="${adminRuleVo.menuIndexVo.menu_18 eq 'Y'}">checked="checked"</c:if>><label for="18">프로그램별교육생관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="19" value="19" title="수강생관리" <c:if test="${adminRuleVo.menuIndexVo.menu_19 eq 'Y'}">checked="checked"</c:if>><label for="19">수강생관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="20" value="20" title="강사관리" <c:if test="${adminRuleVo.menuIndexVo.menu_20 eq 'Y'}">checked="checked"</c:if>><label for="20">강사관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="91" value="91" title="교육시설운영현황" <c:if test="${adminRuleVo.menuIndexVo.menu_91 eq 'Y'}">checked="checked"</c:if>><label for="91">교육시설운영현황</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="21" value="21" title="교육시설관리" <c:if test="${adminRuleVo.menuIndexVo.menu_21 eq 'Y'}">checked="checked"</c:if>><label for="21">교육시설관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="22" value="22" title="감면정보관리" <c:if test="${adminRuleVo.menuIndexVo.menu_22 eq 'Y'}">checked="checked"</c:if>><label for="22">감면정보관리</label>
                                </td>
                            </tr>
                            <!-- 마그넷스쿨관리 -->
                            <tr>
                                <td rowspan="3">
                                    <input type="checkbox" name="menu_array" id="C23" value="23" title="마그넷스쿨관리" <c:if test="${adminRuleVo.menuIndexVo.menu_23 eq 'Y'}">checked="checked"</c:if>><label for="C23">마그넷스쿨관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="24" value="24" title="배우고싶어요" <c:if test="${adminRuleVo.menuIndexVo.menu_24 eq 'Y'}">checked="checked"</c:if>><label for="24">배우고싶어요</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="25" value="25" title="배움공유채널" <c:if test="${adminRuleVo.menuIndexVo.menu_25 eq 'Y'}">checked="checked"</c:if>><label for="25">배움공유채널</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="26" value="26" title="강사신청목록" <c:if test="${adminRuleVo.menuIndexVo.menu_26 eq 'Y'}">checked="checked"</c:if>><label for="26">강사신청목록</label>
                                </td>
                            </tr>
                            <!-- 웹사이트관리 -->
                            <tr>
                                <td rowspan="6">
                                    <input type="checkbox" name="menu_array" id="C27" value="27" title="웹사이트관리" <c:if test="${adminRuleVo.menuIndexVo.menu_27 eq 'Y'}">checked="checked"</c:if>><label for="C27">웹사이트관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="28" value="28" title="공지사항관리" <c:if test="${adminRuleVo.menuIndexVo.menu_28 eq 'Y'}">checked="checked"</c:if>><label for="28">공지사항관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="29" value="29" title="FAQ관리" <c:if test="${adminRuleVo.menuIndexVo.menu_29 eq 'Y'}">checked="checked"</c:if>><label for="29">FAQ관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="30" value="30" title="설문조사관리" <c:if test="${adminRuleVo.menuIndexVo.menu_30 eq 'Y'}">checked="checked"</c:if>><label for="30">설문조사관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="107" value="107" title="온라인 코칭쌤 관리" <c:if test="${adminRuleVo.menuIndexVo.menu_107 eq 'Y'}">checked="checked"</c:if>><label for="107">온라인 코칭쌤 관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="108" value="108" title="온라인 코칭쌤 질문대기방 관리" <c:if test="${adminRuleVo.menuIndexVo.menu_108 eq 'Y'}">checked="checked"</c:if>><label for="108">온라인 코칭쌤 질문대기방 관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="109" value="109" title="법률ㆍ세무상담 관리" <c:if test="${adminRuleVo.menuIndexVo.menu_109 eq 'Y'}">checked="checked"</c:if>><label for="109">법률ㆍ세무상담 관리</label>
                                </td>
                            </tr>
                            <!-- 온라인캠퍼스 -->
                            <tr>
                                <td rowspan="5">
                                    <input type="checkbox" name="menu_array" id="C31" value="31" title="온라인캠퍼스" <c:if test="${adminRuleVo.menuIndexVo.menu_31 eq 'Y'}">checked="checked"</c:if>><label for="C31">온라인캠퍼스</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="32" value="32" title="인물도서관" <c:if test="${adminRuleVo.menuIndexVo.menu_32 eq 'Y'}">checked="checked"</c:if>><label for="32">인물도서관</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="41" value="41" title="악기도서관" <c:if test="${adminRuleVo.menuIndexVo.menu_41 eq 'Y'}">checked="checked"</c:if>><label for="41">악기도서관</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="48" value="48" title="미래교육센터" <c:if test="${adminRuleVo.menuIndexVo.menu_48 eq 'Y'}">checked="checked"</c:if>><label for="48">미래교육센터</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="52" value="52" title="진학학습지원센터" <c:if test="${adminRuleVo.menuIndexVo.menu_52 eq 'Y'}">checked="checked"</c:if>><label for="52">진학학습지원센터</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="89" value="89" title="송파혁신교육지구" <c:if test="${adminRuleVo.menuIndexVo.menu_89 eq 'Y'}">checked="checked"</c:if>><label for="89">송파혁신교육지구</label>
                                </td>
                            </tr>
                            <!-- 센터홈페이지 -->
                            <tr>
                                <td rowspan="5">
                                    <input type="checkbox" name="menu_array" id="C56" value="56" title="센터홈페이지" <c:if test="${adminRuleVo.menuIndexVo.menu_56 eq 'Y'}">checked="checked"</c:if>><label for="C56">센터홈페이지</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="57" value="57" title="송파진로체험지원센터(꿈마루)" <c:if test="${adminRuleVo.menuIndexVo.menu_57 eq 'Y'}">checked="checked"</c:if>><label for="57">송파진로체험지원센터(꿈마루)</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="63" value="63" title="송파청소년센터" <c:if test="${adminRuleVo.menuIndexVo.menu_63 eq 'Y'}">checked="checked"</c:if>><label for="63">송파청소년센터</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="67" value="67" title="마천청소년센터" <c:if test="${adminRuleVo.menuIndexVo.menu_67 eq 'Y'}">checked="checked"</c:if>><label for="67">마천청소년센터</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="71" value="71" title="잠실청소년센터" <c:if test="${adminRuleVo.menuIndexVo.menu_71 eq 'Y'}">checked="checked"</c:if>><label for="71">잠실청소년센터</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="75" value="75" title="미래교육센터 오금Hub" <c:if test="${adminRuleVo.menuIndexVo.menu_75 eq 'Y'}">checked="checked"</c:if>><label for="75">미래교육센터 오금Hub</label>
                                </td>
                            </tr>
                            <!-- 평생학습동아리관리 -->
                            <tr>
                                <td rowspan="3">
                                    <input type="checkbox" name="menu_array" id="C79" value="79" title="평생학습동아리관리" <c:if test="${adminRuleVo.menuIndexVo.menu_79 eq 'Y'}">checked="checked"</c:if>><label for="C79">평생학습동아리관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="80" value="80" title="동아리신청관리" <c:if test="${adminRuleVo.menuIndexVo.menu_80 eq 'Y'}">checked="checked"</c:if>><label for="80">동아리신청관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="81" value="81" title="활동현황관리" <c:if test="${adminRuleVo.menuIndexVo.menu_81 eq 'Y'}">checked="checked"</c:if>><label for="81">활동현황관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="82" value="82" title="활동소식관리" <c:if test="${adminRuleVo.menuIndexVo.menu_82 eq 'Y'}">checked="checked"</c:if>><label for="82">활동소식관리</label>
                                </td>
                            </tr>
                            <!-- 자치회관관리 -->
                            <tr>
                                <td rowspan="7">
                                    <input type="checkbox" name="menu_array" id="C83" value="83" title="자치회관관리" <c:if test="${adminRuleVo.menuIndexVo.menu_83 eq 'Y'}">checked="checked"</c:if>><label for="C83">자치회관관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="84" value="84" title="프로그램실적등록" <c:if test="${adminRuleVo.menuIndexVo.menu_84 eq 'Y'}">checked="checked"</c:if>><label for="84">프로그램실적등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="85" value="85" title="강사료신청" <c:if test="${adminRuleVo.menuIndexVo.menu_85 eq 'Y'}">checked="checked"</c:if>><label for="85">강사료신청</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="86" value="86" title="자원봉사활동비" <c:if test="${adminRuleVo.menuIndexVo.menu_86 eq 'Y'}">checked="checked"</c:if>><label for="86">자원봉사활동비</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="92" value="92" title="기금 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_92 eq 'Y'}">checked="checked"</c:if>><label for="92">기금 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="93" value="93" title="수입 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_93 eq 'Y'}">checked="checked"</c:if>><label for="93">수입 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="94" value="94" title="지출 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_94 eq 'Y'}">checked="checked"</c:if>><label for="94">지출 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="95" value="95" title="수입 및 지출내역" <c:if test="${adminRuleVo.menuIndexVo.menu_95 eq 'Y'}">checked="checked"</c:if>><label for="95">수입 및 지출내역</label>
                                </td>
                            </tr>
                            <!-- (구)자치회관관리 -->
                            <tr>
                                <td rowspan="10">
                                    <input type="checkbox" name="menu_array" id="C96" value="96" title="(구)자치회관관리" <c:if test="${adminRuleVo.menuIndexVo.menu_96 eq 'Y'}">checked="checked"</c:if>><label for="C96">(구)자치회관관리</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="97" value="97" title="(구)프로그램관리" <c:if test="${adminRuleVo.menuIndexVo.menu_97 eq 'Y'}">checked="checked"</c:if>><label for="97">(구)프로그램관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="98" value="98" title="(구)강사관리" <c:if test="${adminRuleVo.menuIndexVo.menu_98 eq 'Y'}">checked="checked"</c:if>><label for="98">(구)강사관리</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="99" value="99" title="(구)프로그램실적등록" <c:if test="${adminRuleVo.menuIndexVo.menu_99 eq 'Y'}">checked="checked"</c:if>><label for="99">(구)프로그램실적등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="100" value="100" title="(구)강사료신청" <c:if test="${adminRuleVo.menuIndexVo.menu_100 eq 'Y'}">checked="checked"</c:if>><label for="100">(구)강사료신청</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="101" value="101" title="(구)자원봉사활동비" <c:if test="${adminRuleVo.menuIndexVo.menu_101 eq 'Y'}">checked="checked"</c:if>><label for="101">(구)자원봉사활동비</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="102" value="102" title="(구)기금 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_102 eq 'Y'}">checked="checked"</c:if>><label for="102">(구)기금 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="103" value="103" title="(구)수강자 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_103 eq 'Y'}">checked="checked"</c:if>><label for="103">(구)수강자 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="104" value="104" title="(구)수입 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_104 eq 'Y'}">checked="checked"</c:if>><label for="104">(구)수입 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="105" value="105" title="(구)지출 등록" <c:if test="${adminRuleVo.menuIndexVo.menu_105 eq 'Y'}">checked="checked"</c:if>><label for="105">(구)지출 등록</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="106" value="106" title="(구)수입 및 지출내역" <c:if test="${adminRuleVo.menuIndexVo.menu_106 eq 'Y'}">checked="checked"</c:if>><label for="106">(구)수입 및 지출내역</label>
                                </td>
                            </tr>
                            <!-- 콘텐츠기능 수정요청 -->
                            <tr>
                                <td>
                                    <input type="checkbox" name="menu_array" id="C110" value="110" title="콘텐츠기능 수정요청" <c:if test="${adminRuleVo.menuIndexVo.menu_110 eq 'Y'}">checked="checked"</c:if>><label for="C110">콘텐츠기능 수정요청</label>
                                </td>
                                <td>
                                    <input type="checkbox" name="menu_array" id="111" value="111" title="콘텐츠기능 수정요청" <c:if test="${adminRuleVo.menuIndexVo.menu_111 eq 'Y'}">checked="checked"</c:if>><label for="80">콘텐츠기능 수정요청</label>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <div class="btnArea">
            <div class="left">
            </div>
            <div class="right">
                <a href="#none" class="btn red" id="btn_update">저장</a>
                <a href="/ssemadmin/cont/master/role_list.do" class="btn grey">목록</a>
            </div>
        </div>
    </article>
</div>
