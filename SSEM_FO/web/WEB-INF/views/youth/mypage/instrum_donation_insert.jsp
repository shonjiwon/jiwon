<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-06
  Time: 오후 6:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '악기기증 > 악기도서관 > 나의 송파쌤 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit();   //sub.js

        tableInit(); //sub.js table.half pc높이 맞춤

        $("#btn_submit").click(function(){
            modalMsg("수정하시겠습니까?", 'yesorno', update_frm);
        });

        $("#btn_cancel").click(function(){
            modalMsg("인물도서 등록 신청을 취소하시겠습니까?", 'yesorno', cancel_frm);
        });

        $("#btn_print").click(function(){
            window.print();
        });

        // 파일 삭제 버튼 클릭시
        $("a[id^=btn_file_del_]").click(function(){
            let del_id_arr = $(this).attr("id").replace("btn_file_del_", "").split('_');
            if(confirm("삭제 하시겠습니까?")){
                $.ajax({
                    url: '/ssem/file/file_delete.do',
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
                            location.href = "?instrum_dnt_idx=${instrumDntVo.instrum_dnt_idx}";
                        }
                    }
                });
            }else{
                return false;
            }
            return false;
        });
    });

    function cancel_frm() {
        document.frm_cancel.submit();
    }

    function update_frm() {
        var frm = document.frm;

        if(!fnIsValidRequired(frm.mob_1, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_2, "휴대폰번호")){return false;}
        if(!fnIsValidRequired(frm.mob_3, "휴대폰번호")){return false;}

        if(!fnIsValidRequired(frm.instrum_name, "악기명")){return false;}

        $("#dnt_mob_no").val(frm.mob_1.value + '-' + frm.mob_2.value + '-' + frm.mob_3.value);

        $("#frm").submit();
        //frm.submit();
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
                        <a href="#" class="deapth_tit" title="선택">악기도서관</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/youth/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/youth/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/youth/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/youth/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/youth/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/youth/mypage/survey_list.do">설문조사 참여/결과</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">악기기증</a>
                        <ul>
                            <li><a href="/ssem/youth/mypage/instrum_rental_list.do">악기대여</a></li>
                            <li><a href="/ssem/youth/mypage/room_rental_list.do">대관신청</a></li>
                            <li><a href="/ssem/youth/mypage/instrum_donation_list.do">악기기증</a></li>
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
    <div class="sub_con st_1 mypage_st"><!-- sub_con -->
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <!--2020.11.05 : s-->
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m act">악기도서관<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/youth/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <!--2020.11.05 : e-->
        <h4 class="tit2 mt_95 mb_50">악기도서관</h4>
        <div class="mypage_tab_box fs_20 fs_md_26"><!-- mypage_tab : s -->
            <h4 class="text_hide">3뎁스 탭</h4>
            <ul class="tab tab_3">
                <li class="tab_item"><a href="/ssem/youth/mypage/instrum_rental_list.do">악기대여</a></li>
                <li class="tab_item"><a href="/ssem/youth/mypage/room_rental_list.do">대관신청</a></li>
                <li class="tab_item on"><a href="/ssem/youth/mypage/instrum_donation_list.do">악기기증</a></li>
            </ul>
        </div><!-- mypage_tab : end -->
        <section class="text_con fs_20 fs_md_26 pb_100 mb_15 mt_50">
            <div class="wrap">
                <h1 class="c_tit_1 mt_90">악기기증</h1>
                <h2 class="c_tit_2 ptb_15 clearfix">회원 기본 정보</h2>
                <form name="frm_cancel" id="frm_cancel" action="/ssem/youth/mypage/instrum_donation_cancel.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="instrum_dnt_idx" value="${instrumDntVo.instrum_dnt_idx}" />
                </form>
                <form name="frm" id="frm" action="/ssem/youth/mypage/instrum_donation_insert.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="instrum_dnt_idx" value="${instrumDntVo.instrum_dnt_idx}" />
                    <input type="hidden" name="dnt_mob_no" id="dnt_mob_no" />
                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">회원 기본 정보의 신청자 이름, 휴대전화 번호</caption>
                        <tbody>
                        <tr>
                            <th class="wid_300">신청자 이름</th>
                            <td>${instrumDntVo.dnt_name}</td>
                        </tr>
                        <tr>
                            <th class="wid_300">휴대전화 번호</th>
                            <td>
                                <div class="fm_phon">
                                <span class="sel_box" title="휴대전화 앞번호">
                                    <select name="mob_1" id="mob_1" title="휴대전화 앞번호">
                                        <option value="">선택</option>
                                        <option value="010" <c:if test="${instrumDntVo.mob_1 eq '010'}">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test="${instrumDntVo.mob_1 eq '011'}">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test="${instrumDntVo.mob_1 eq '016'}">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test="${instrumDntVo.mob_1 eq '017'}">selected="selected"</c:if>>017</option>
                                        <option value="019" <c:if test="${instrumDntVo.mob_1 eq '019'}">selected="selected"</c:if>>019</option>
                                    </select>
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_2" id="mob_2" title="휴대전화 중간번호" data-inp-type="number" maxlength="4" value="${instrumDntVo.mob_2}">
                                </span>
                                    <span class="dash">-</span>
                                    <span class="fm_inp">
                                    <input type="text" class="inp" name="mob_3" id="mob_3" title="휴대전화 끝번호" data-inp-type="number" maxlength="4" value="${instrumDntVo.mob_3}">
                                </span>
                                </div>
                                <span class="dp_inb tc_sub fs_16 fs_md_22">※ 휴대폰 번호를 확인 후 수정해주세요.</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->

                <!--2020.11.04:s-->
                <h2 class="c_tit_2 ptb_15 mt_50 clearfix">
                    <span class="dp_inb float_left">신청 정보</span>
                    <span class="dp_inb mt_10 float_right fs_18 fs_md_24 fw_200"><span class="tc_point">*</span>필수입력</span>
                </h2>
                <!--2020.11.04:e-->

                <div class="table_box fs_18 fs_md_24"><!--table_box-->
                    <table class="table">
                        <caption class="text_hide">신청 정보의 기증상태, 악기명, 악기유형, 악기명, 악기유형, 악기구입년도, 사진등록, 신청일 </caption>
                        <tbody>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>기증상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${instrumDntVo.status eq 'A'}"><span class="my_tc_2">기증신청</span></c:when>
                                    <c:when test="${instrumDntVo.status eq 'R'}"><span class="my_tc_1">기증확인</span></c:when>
                                    <c:when test="${instrumDntVo.status eq 'O'}"><span class="my_tc_4">기증완료</span></c:when>
                                    <c:when test="${instrumDntVo.status eq 'C'}"><span class="my_tc_3">기증취소</span></c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기명</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="instrum_name" id="instrum_name" title="악기명" value="${instrumDntVo.instrum_name}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기유형</th>
                            <td>
                            <span class="sel_box">
                                <select title="악기유형" name="gubun" id="gubun">
                                    <option value="A" <c:if test="${instrumDntVo.gubun eq 'A'}">selected="selected"</c:if>>건반악기</option>
                                    <option value="B" <c:if test="${instrumDntVo.gubun eq 'B'}">selected="selected"</c:if>>관악기</option>
                                    <option value="C" <c:if test="${instrumDntVo.gubun eq 'C'}">selected="selected"</c:if>>타악기</option>
                                    <option value="D" <c:if test="${instrumDntVo.gubun eq 'D'}">selected="selected"</c:if>>현악기</option>
                                    <option value="E" <c:if test="${instrumDntVo.gubun eq 'E'}">selected="selected"</c:if>>MIDI장비</option>
                                    <option value="K" <c:if test="${instrumDntVo.gubun eq 'K'}">selected="selected"</c:if>>국악기</option>
                                    <option value="Z" <c:if test="${instrumDntVo.gubun eq 'Z'}">selected="selected"</c:if>>기타</option>
                                </select>
                            </span>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300"><span class="point">*</span>악기구입년도</th>
                            <td>
                                <div class="fm_inp mr_10"><input type="text" class="inp" name="pc_year" id="pc_year" title="악기구입년도" value="${instrumDntVo.pc_year}"></div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">사진등록</th>
                            <td>
                                <div class="fm_file_btn act_uiFileBtn">
                                    <input type="file" name="attfile" id="attfile#" accept="image/*" title="파일 첨부">
                                    <button type="button" class="btn btn_line">파일 찾기</button>
                                    <input type="text" class="inp" readonly="" title="파일 이름">
                                </div>
                                <p class="tc_sub fs_16 fs_md_22 mt_5">(파일형식 : jpg, jpge, bmp, gif / 사이즈 : 000*000)</p>

                                <div class="file_box">
                                    <c:forEach items="${instrumDntVo.fileList}" var="item" varStatus="status">
                                        <a href="/ssem/file/fileDown.do?atchFileId=${item.atch_file_id}&amp;fileNum=${item.file_num}" class="file_name">${item.file_ori_nm}</a>
                                        <a type="button" class="btn" id="btn_file_del_${item.atch_file_id}_${item.file_num}">삭제</a>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bg_1">
                                <p class="ptb_20 fw_500 fs_20 fs_md_26 fw_md_400 tc_b">
                                    악기설명 및 기증사연</p>
                                <div class="fm_tf mb_20">
                                    <textarea name="cont" id="cont">${instrumDntVo.cont}</textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="wid_300">신청일</th>
                            <td>
                                ${instrumDntVo.reg_dt}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><!--table_box //-->
                </form>
                <div class="btn_box mypage_btn_box mt_50 pb_30 t_center t_md_right">
                    <div class="row">
                        <c:choose>
                            <c:when test="${instrumDntVo.status eq 'A'}">
                                <div class="col_6 offset_3 offset_md_0 col_md_9">
                                    <button type="button" class="btn btn_long btn_big btn_md_auto mr_10" id="btn_submit">저장</button>
                                    <button type="button" class="btn btn_long btn_big btn_md_auto ml_10 ml_md_0" id="btn_cancel">신청 취소</button>
                                </div>
                                <div class="col_3 t_right">
                                    <a href="/ssem/youth/mypage/instrum_donation_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="t_right">
                                    <a href="/ssem/youth/mypage/instrum_donation_list.do" class="btn btn_short btn_big ml_md_10">목록</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
