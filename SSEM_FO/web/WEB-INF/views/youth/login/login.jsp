<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-25
  Time: 오후 8:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '로그인 > 미래교육 > 송파쌤');

        commonInit(); //common.js
        subInit();   //sub.js

        $("#password").on("keyup", function(event) {
            if (event.keyCode === 13) {
                goSubmit();
            }
        });
    });

    function goSubmit() {
        let frm = document.frm;

        if (!fnIsValidRequired(frm.user_id, "아이디")) {
            return;
        }
        if (!fnIsValidRequired(frm.password, "비밀번호")) {
            return;
        }

        frm.user_id.value = frm.user_id.value.trim();
        frm.password.value = frm.password.value.trim();

        frm.submit();
    }
</script>
<div class="contents" id="contents">
    <div class="login_wrap">
        <form name="frm" id="frm" method="post" action="/ssem/youth/login/login.do">
            <input type="hidden" name="return_url" id="return_url" value="${return_url}" />
            <div class="login_box fs_18 fs_md_26">
                <h2 class="fs_40 fs_md_46">로그인</h2>
                <p class="fs_20 fs_md_26 mr mt_15">송파구청 홈페이지에서 사용하는 아이디로 <br class="screen_hide screen_md_show">로그인 해주세요.</p>
                <ul class="mt_20 fs_md_26 t_left login_from">
                    <li><span class="label">아이디</span> <span class="fm_inp inp_full"><input type="text" name="user_id" id="user_id" title="아이디" class="inp" placeholder="아이디를 입력해주세요."></span></li>
                    <li><span class="label">비밀번호</span> <span class="fm_inp inp_full"><input type="password" name="password" id="password" title="비밀번호" class="inp" placeholder="비밀번호를 입력해주세요."></span> </li>
                </ul>
                <a href="javascript:goSubmit();" class="btn btn_color_1 mt_20 btn_login">로그인</a>

                <ul class="login_link fw_300 pt_25 tc_sub">
                    <li><a href="https://www.songpa.go.kr/www/joinStep0Form.do?url=https://www.songpa.go.kr/www/index.do" target="_blank">회원가입</a></li>
                    <li><a href="https://www.songpa.go.kr/www/findIdForm.do?url=https://www.songpa.go.kr/www/index.do" target="_blank">아이디 찾기</a></li>
                    <li><a href="https://www.songpa.go.kr/www/findPasswordForm.do?url=https://www.songpa.go.kr/www/index.do" target="_blank">비밀번호 찾기</a></li>
                </ul>

                <div class="bg_color_4 fw_300 ptb_40 plr_50 t_left mt_65 login_info">
                    <ul>
                        <li>※ 송파쌤 홈페이지는 송파구청의 회원정보를 통합 사용하고있습니다.</li>
                        <li>※ 회원가입과 아이디/비밀번호 찾기는 송파구청 홈페이지로 이동합니다.</li>
                    </ul>
                </div>
            </div>
        </form>
    </div>
</div>
