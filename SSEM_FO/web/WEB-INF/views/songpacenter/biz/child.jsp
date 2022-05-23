<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).prop('title', '유아체능단 > 주요사업 > 송파청소년센터 > 송파쌤');

        commonInit(); //common.js
        uiInti();       //ui.js

        subInit()       //sub.js
    });
</script>
<div class="contents" id="contents">
    <div class="sub_visual youth_st_3"><!-- sub_visual -->
        <div class="wrap por">
            <div class="al_text_box">
                <h2 class="tit t_center tv_center font_sc">
                    주요사업
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
                        <a href="/ssem/songpacenter/biz/youth.do" class="deapth_tit" title="선택">주요사업</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/intro/intro.do">기관소개</a></li>
                            <li><a href="/ssem/songpacenter/program/program_list.do">프로그램 신청</a></li>
                            <li><a href="/ssem/songpacenter/biz/youth.do">주요사업</a></li>
                            <li><a href="/ssem/songpacenter/place/intro.do">시설안내</a></li>
                            <li><a href="/ssem/songpacenter/news/notice_list.do">고객지원</a></li>
                        </ul>
                    </li>
                    <li class="deapth_1">
                        <a href="#" class="deapth_tit" title="선택">유아체능단</a>
                        <ul>
                            <li><a href="/ssem/songpacenter/biz/youth.do">청소년사업</a></li>
                            <li><a href="/ssem/songpacenter/biz/child.do">유아체능단</a></li>
                            <li><a href="/ssem/songpacenter/biz/alternative.do">대안학교</a></li>
                            <li><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
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
            <a href="#" class="tab_m">유아체능단<i class="icon_arrow_down_w ml_60">다운</i></a>
            <ul class="tab tab_4"> <!-- tab_3 ~ tab_8 :  min : 3개 ~  max : 8개 -->
                <li class="tab_item"><a href="/ssem/songpacenter/biz/youth.do">청소년사업</a></li>
                <li class="tab_item on"><a href="/ssem/songpacenter/biz/child.do" title="선택">유아체능단</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/alternative.do">대안학교</a></li>
                <li class="tab_item"><a href="/ssem/songpacenter/biz/life.do">생활체육 및 교육문화</a></li>
            </ul>
        </div><!-- tab_box //-->
        <section class="text_con fs_20 fs_md_26  pb_100 mb_15">
            <h1 class="tit2 mt_100 mb_50">유아체능단</h1>
            <div class="sub_info_visual youth_st_3 mt_md_50"> <!---sub_info_visual-->
                <div class="wrap tc_w fw_200">
                    <div class="sub_info_visual_text_box t_center"><span class="text_hide">어린이 공부하는 이미지</span></div>
                </div>
            </div><!---sub_info_visual //-->
            <div class="wrap">
                <h2 class="c_tit_2 mt_85 mt_md_75">소개</h2>
                <p class="mt_25 middot">유아교육을 기반으로 한 예체능, 영어교육 등 창의적이고 다양한 교육 프로그램 진행을 통한 유아들의 건강한 성장발달 지원</p>
                <p class="mt_25 middot">지적, 정서적, 신체적으로 건강한 아이로 성장 할 수 있도록 다양한 교육프로그램을 운영하고, 자기주도적이고 창의적인 민주시민으로 성장 할 수 있도록 알맞은 환경을 제공</p>

                <h2 class="c_tit_2 mt_85 mt_md_75">입단대상 및 정원</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">입단대상 및 정원의 연려, 정원 안내</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>연령</th>
                            <td><p class="mtb_10 fw_500 tc_b">7세</p></td>
                            <td><p class="mtb_10 fw_500 tc_b">6세</p></td>
                            <td><p class="mtb_10 fw_500 tc_b">5세</p></td>
                        </tr>
                        <tr>
                            <th>정원</th>
                            <td><p class="mtb_10">20명</p></td>
                            <td><p class="mtb_10">20명</p></td>
                            <td><p class="mtb_10">20명</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h2 class="c_tit_2 mt_85 mt_md_75">교육기관</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">교육기관의 학기, 교육일정, 교육시간</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="38%">
                            <col width="38%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>학기</th>
                            <th>교육일정</th>
                            <th>교육시간</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><p class="mtb_10 fw_500 tc_b">1학기</p></td>
                            <td><p>3월 ~ 7월 (*상세 기간 전화 문의)
                            <td rowspan="2"><p>10:00 ~ 15:00</p></td>
                        </tr>
                        <tr>
                            <td><p class="mtb_10 fw_500 tc_b">2학기</p></td>
                            <td><p>8월 ~ 2월 (*상세 기간 전화 문의)</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h2 class="c_tit_2 mt_85 mt_md_75">접수방법</h2>
                <div class="table_box mt_25 fs_18 fs_md_20 fs_sm_26 t_center">
                    <table class="st_2">
                        <caption class="text_hide">접수방법의 접수절차, 제출서류, 교육비 납부, 납부장소</caption>
                        <colgroup>
                            <col width="24%">
                            <col width="76%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>접수절차</th>
                            <td><p class="mtb_10">전화상담 &rarr; 원서교부 &rarr; 원서제출 &rarr; 원서비, 입단비 납부</p></td>
                        </tr>
                        <tr>
                            <th>제출서류</th>
                            <td><p class="mtb_10">입단원서, 증명사진 1장, 주민등록등본, 개인 정보 제공동의서, 단원 개별 카드</p></td>
                        </tr>
                        <tr>
                            <th>교육비 납부</th>
                            <td><p class="mtb_10">교육비, 교재비 납부( 연령 별 상이)</p></td>
                        </tr>
                        <tr>
                            <th>납부장소</th>
                            <td><p class="mtb_10">1층 안내데스크</p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h2 class="c_tit_2 mt_95 mt_md_75">교육내용</h2>
                <ul class="row row_p_23 mt_25  fs_20 fs_md_22 fs_sm_26 ls_75">
                    <li class="col_4 col_lg_6 col_sm_12">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img04.jpg" alt="정규교육 프로그램">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">정규교육 프로그램</strong>
                                유아교육(한글, 수, 미술, 음률, 과학), 영어, 놀이수학,
                                한자, 유아체육, 인라인, 음악줄넘기, 태권도,
                                리듬체조, 발레, 오르프, 발표력, 독서지도 등
                            </p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_sm_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img05.jpg" alt="방과후 프로그램">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">방과후 프로그램</strong>
                                미술, 과학, 찰흙, 주산암산, 동화구연,
                                축구, 아트클레이 등
                            </p>
                        </div>
                    </li>
                    <li class="col_4 col_lg_6 col_sm_12 mt_lg_40">
                        <div class="yb_box">
                            <div class="img_box">
                                <img src="/ssem/resources/img/sub/youth/business_img06.jpg" alt="기타 프로그램">
                            </div>
                            <p class="text_box"><strong class="fs_24 fs_md_26 fs_sm_30 mb_10">기타 프로그램</strong>
                                체험학습(월1회), 스페셜데이, 생일잔치,
                                공개수업, 운동회, 학부모상담 등
                            </p>
                        </div>
                    </li>
                </ul>
                <h2 class="c_tit_2 mt_95 mt_md_75">문의</h2>
                <p class="mt_25 middot">02-2147-5326~9  문화체육팀 유아체능단</p>
            </div>
        </section>
    </div>
</div>
