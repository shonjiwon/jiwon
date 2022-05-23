<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-11-03
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '비밀번호 확인 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js
    });

    function goSubmit() {
        var frm = document.frm;

        if (!fnIsValidRequired(frm.password, "비밀번호")) {
            return;
        }

        frm.password.value = frm.password.value.trim();

        frm.submit();
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
                        <a href="#" class="deapth_tit" title="선택">비밀번호 확인</a>
                        <ul>
                            <li><a href="/ssem/senior/mypage/pwd_confirm.do">비밀번호 확인</a></li>
                            <li><a href="/ssem/senior/mypage/program_list.do">프로그램 확인</a></li>
                            <li><a href="/ssem/senior/mypage/hope_study_list.do">마그넷스쿨</a></li>
                            <li><a href="/ssem/senior/mypage/person_book_list.do">인물도서관</a></li>
                            <li><a href="/ssem/senior/mypage/instrum_rental_list.do">악기도서관</a></li>
                            <li><a href="/ssem/senior/mypage/online_counsel_list.do">진학학습지원센터</a></li>
                            <li><a href="/ssem/senior/mypage/circle_reg_list.do">평생학습동아리</a></li>
                            <li><a href="/ssem/senior/mypage/survey_list.do">설문조사 참여/결과</a></li>
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
        <h3 class="mt_100 mb_50 tit font_sc">나의 송파쌤</h3>
        <div class="tab_box fs_20 fs_md_26"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m"><span class="tab_middle">프로그램 확인<i class="icon_arrow_down_w ml_60">다운</i></span></a>
            <ul class="tab tab_7"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item on"><a href="/ssem/senior/mypage/program_list.do"><span class="tab_middle">프로그램 확인</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/hope_study_list.do"><span class="tab_middle">마그넷스쿨</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/person_book_list.do"><span class="tab_middle">인물도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/instrum_rental_list.do"><span class="tab_middle">악기도서관</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/online_counsel_list.do"><span class="tab_middle">진학학습지원센터</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/circle_reg_list.do"><span class="tab_middle">평생학습동아리</span></a></li>
                <li class="tab_item"><a href="/ssem/senior/mypage/survey_list.do"><span class="tab_middle">설문조사 참여/결과</span></a></li>
            </ul>
        </div>
        <form name="frm" id="frm" method="post" action="/ssem/senior/mypage/pwd_confirm.do">
            <input type="hidden" name="return_url" id="return_url" value="${return_url}" />
            <input type="hidden" name="user_id" id="user_id" value="${loginVo.user_id}" />
            <section class="text_con fs_20 fs_md_26  pb_100 mb_15 mt_100">
                <div class="wrap">
                    <div class="password_ok_wrap">
                        <div class="fs_24 fs_md_30 fw_500">
                            <p>개인정보 보호를 위해 비밀번호 확인이 필요합니다.</p>
                            <p>비밀번호를 입력해주세요.</p>
                        </div>
                        <div class="password_box">
                            <div class="fm_inp inp_full"><input type="password" name="password" id="password" title="비밀번호" class="inp" placeholder="비밀번호"></div>
                            <div class="fs_20 fs_md_26 mt_30">
                                <a href="javascript:goSubmit();" class="btn fs_auto btn_color_5">확인</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </form>
    </div>
</div>
