<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-10-28
  Time: 오후 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '고객광장 > 고객지원 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js

        $(document).on('click', '.ql_itme a', function(e){
            e.preventDefault();

            var $lis  = $(this).parent('li').siblings();
            var $li   = $(this).parent('li');
            var ind   = $li.index();

            $lis.removeClass('on').find('a').attr('title', '드롭 비활성');
            $lis.find('.contents').stop().slideUp();

            $li.toggleClass(function(){
                if ( $( this ).is( ".on" ) ) {
                    $(this).find('a').attr('title', '드롭 비활성')
                } else {
                    $(this).find('a').attr('title', '드롭 활성')
                }
                return 'on';
            })
            $li.find('.contents').stop().slideToggle();

        });

        $(document).on('click', '.ql_itme .close_btn', function(){
            var $li   = $(this).parents('.ql_itme');

            $li.removeClass('on').find('a').attr('title', '드롭 비활성');
            $li.find('.contents').stop().slideUp();
        });
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_5"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    고객지원
                </h2>
            </div>
        </div>
    </div><!-- sub_visual : e -->
    <div class="sub_nav_wrap bg_st_01"><!--sub_nav_wrap-->
        <div class="wrap wrap_md_p_0 clearfix_after">
            <div class="location_nav float_left"><!-- location_nav -->
                <h3 class="text_hide">네비게이션 바</h3>
                <ul class="deapth_cnt2">
                    <li class="home">HOME</li>
                    <li class="deapth_1">
                        <a href="/ssem/songpacenter/news/notice_list.do" class="deapth_tit" title="선택">고객지원</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">고객광장</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">공지사항</a></li>
                            <li><a href="/ssem/songpacenter/news/qna_list.do">고객광장</a></li>
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
    <div class="sub_con st_1"><!-- sub_con -->
        <div class="brd_line_box fs_20 fs_md_26 mt_10 mt_md_90"><!-- tab_box -->
            <h4 class="text_hide">탭</h4>
            <a href="#" class="tab_m">고객광장<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li  class="tab_item"><a href="/ssem/songpacenter/news/notice_list.do">공지사항</a></li>
                <li  class="tab_item on"><a href="/ssem/songpacenter/news/qna_list.do">고객광장</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con pb_100 mb_15">
            <h1 class="mt_100 mt_mb_80 mb_50 tit font_sc">고객광장</h1>

            <div class="wrap">
                <div class="questions_list fs_18 fs_md_26"><!--questions_list-->
                    <ul>
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <li class="ql_itme">
                                <a href="javascript:void(0)" title="드롭 비활성">
                                    <section class="ql_top_box">
                                        <div>
                                            <i class="icon_q">질문</i>
                                        </div>
                                        <div class="fs_20 fs_md_28">
                                            ${item.title}
                                        </div>
                                    </section>
                                </a>
                                <div class="contents">
                                    <section class="ql_bottom_box">
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
                </div><!--questions_list : e -->
            </div>
        </section>
    </div>
</div>
