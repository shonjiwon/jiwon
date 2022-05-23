<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-01
  Time: 오전 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '자주 묻는 질문 > 고객지원 > 송파쌤 > 평생교육 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js
        subInit()       //sub.js

        $(document).on('click', '.sl_itme a', function(e){
            e.preventDefault();

            var $lis  = $(this).parent('li').siblings();
            var $li   = $(this).parent('li');
            var ind   = $li.index();

            $lis.removeClass('on').find('a').attr('title', '드롭 비활성');
            $lis.find('.contents').stop().slideUp();

            $li.toggleClass(function(){
                if ( $( this ).is( ".on" ) ) {
                    $(this).find('a').attr('title', '드롭 비활성');
                } else {
                    $(this).find('a').attr('title', '드롭 활성');
                }
                return 'on';
            })
            $li.find('.contents').stop().slideToggle();
        });

        $(document).on('click', '.sl_itme .close_btn', function(){
            var $li   = $(this).parents('.sl_itme');
            $li.removeClass('on').find('a').attr('title', '드롭 비활성').focus();
            $li.find('.contents').stop().slideUp();
        });
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual st_11"><!-- sub_visual -->
        <div class="wrap por">
            <div class="sv_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    송파쌤(SSEM)
                </h2>
                <p class="tit_sub">
                    <strong>“세상에서 가장 큰 학교”</strong>
                    송파에서 나고 자라고 완성되는 <br>창의적 인재육성
                </p>
            </div>
        </div>
    </div>
    <div class="sub_nav_wrap"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav _right"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">송파쌤</a>
                        <ul>
                            <li><a href="/ssem/senior/forever/history.do">평생교육</a></li>
                            <li><a href="/ssem/senior/program/lecture_list.do">통합프로그램신청</a></li>
                            <li><a href="/ssem/senior/magnet/intro.do">마그넷 스쿨</a></li>
                            <li><a href="/ssem/senior/center/woman_culture.do">교육지원</a></li>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤</a></li>
                            <li><a href="/ssem/senior/lawtax/law_counsel_list.do">법률ㆍ세무 상담</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">고객지원</a>
                        <ul>
                            <li><a href="/ssem/senior/ssem/vision.do">송파쌤이란</a></li>
                            <li><a href="/ssem/senior/ssem/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/senior/ssem/survey_list.do">설문조사</a></li>
                            <li><a href="/ssem/senior/ssem/qna.do">고객지원</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- location_nav // -->
        </div>
    </div>
    <div class="sub_con st_5"><!-- sub_con -->
        <section class="text_con pb_100 mb_15">
            <h1 class="mt_100 mt_mb_80 mb_50 tit font_sc">고객지원</h1>
            <div class="wrap">
                <h2 class="fs_24 fs_md_30 fw_500 fw_md_500 ptb_20 mt_15">자주 묻는 질문</h2>
                <div class="slide_list fs_18 fs_md_26"><!--slide_list-->
                    <ul>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <li class="sl_itme">
                                <a href="javascript:void(0)" title="드롭 비활성">
                                    <section class="sl_top_box">
                                        <div>
                                            <i class="icon_q">질문</i>
                                        </div>
                                        <div class="fs_20 fs_md_28">
                                                ${item.title}
                                        </div>
                                    </section>
                                </a>
                                <div class="contents">
                                    <section class="sl_bottom_box">
                                        <div>
                                            <i class="icon_a">답변</i>
                                        </div>
                                        <div class="fw_300">
                                                ${item.cont}
                                        </div>
                                    </section>
                                    <button type="button" class="close_btn"><i class="icon_ql_up_b mr_5">업</i><span class="fs_16 fs_md_18">접기</span></button>
                                </div>
                            </li>
                        </c:forEach>
                    </ul> <!-- //bl -->
                </div><!--slide_list : e -->
            </div>
        </section>
    </div>
</div>
