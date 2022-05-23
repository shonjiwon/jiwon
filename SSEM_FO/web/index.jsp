<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-09-29
  Time: 오전 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
  <title> 송파쌤 </title>
  <meta charset="utf-8">

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <meta property="og:title" content="송파쌤">
  <meta property="og:url" content="">
  <meta property="og:image" content="">
  <meta property="og:description" content="세상에서 가장큰 학교 송파쌤(SSEM)">

  <meta property="title" content="송파쌤">
  <meta property="url" content="">
  <meta property="image" content="">
  <meta property="description" content="세상에서 가장큰 학교 송파쌤(SSEM)">

  <link rel="shortcut icon" href="/ssem/resources/img/favicon.png">
  <link rel="shortcut icon" type="image/x-icon" href="/ssem/resources/img/favicon.ico">
  <link rel="icon" type="image/x-icon" href="/ssem/resources/img/favicon.ico">

  <!--style -->
  <link rel="stylesheet" type="text/css" href="/ssem/resources/css/reset.css"/>
  <link rel="stylesheet" type="text/css" href="/ssem/resources/css/common.css"/>
  <link rel="stylesheet" type="text/css" href="/ssem/resources/css/intro.css"/>

  <!--js -->
  <script src="/ssem/resources/js/jquery-3.4.1.min.js"></script>
  <script src="/ssem/resources/js/common.js"></script>
  <script src="/ssem/resources/js/jquery.ellipsis.min.js"></script>
  <script src="/ssem/resources/js/ui.js"></script>
  <script type='text/javascript'>
    var _bwa = [];
    _bwa.push(['setCollectorUrl', 'https://www.songpa.go.kr/blueworks/api']);
    _bwa.push(['setCustomerId', 'songpa']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript';
    g.src='/ssem/resources/js/blueworksWebAgent-2.0-min.js';
    g.async=g.defer=true;
    s.parentNode.insertBefore(g, s);
  </script>

  <!--lib / aniNum-->
  <script src="/ssem/resources/lib/aniNum/jquery.animateNumber.js"></script>

  <!-- style: sub page -->
  <link rel="stylesheet" href="/ssem/resources/lib/jquery-ui/jquery-ui.css">
  <script src="/ssem/resources/lib/jquery-ui/jquery-ui.js"></script>

  <!--[if lt IE 10]>
  <link rel="stylesheet" type="text/css" href="/ssem/resources/css/ie_9.css"/>
  <![endif]-->

</head>
<body class="_load">
<script type="text/javascript">
    $(document).ready(function() {
        // 공통 - 검색 /////////////////////////////////////////////////
        $("#btn_search").click(function(){
            // 소속 검색 조건 정리
            var future = $("#section1").attr("style");
            if(future === 'display: block;') {
                goSearch("future");
                return;
            }
            var life = $("#section2").attr("style");
            if(life === 'display: block;') {
                goSearch("life");
                return;
            }
            goSearch("all");
        });

        $("#searchVal").on("keyup", function(event) {
            if (event.keyCode === 13) {
                // 소속 검색 조건 정리
                var future = $("#section1").attr("style");
                if(future === 'display: block;') {
                    goSearch("future");
                    return;
                }
                var life = $("#section2").attr("style");
                if(life === 'display: block;') {
                    goSearch("life");
                    return;
                }
                goSearch("all");
            }
        });
        /////////////////////////////////////////////////////////////////
    });

    function goSearch(type) {
        if(type === 'future') {
            $("#frm").attr("action", "/ssem/youth/search/search.do");
        } else if (type === 'life') {
            $("#frm").attr("action", "/ssem/senior/search/search.do");
        } else {
            $("#frm").attr("action", "/ssem/intro/search/youth_search.do");
        }
        $("#frm").submit();
    }
</script>

<%--<div class="bg-video-wrap">
  <video muted="muted" autoplay class="video" id="video">
    <source src="/ssem/resources/img/sample/sample_video.mp4" type="video/mp4" />
  </video>
  <div class="overlay">
    <img src="/ssem/resources/img/intro/logo3.png" alt="송파쌤 SSEM" class="logo3">
    <div class="btn_box">
      <button type="button" id="btnPlay"><img src="/ssem/resources/img/intro/play.png" alt="시작"></button>
      <button type="button" id="btnStop"><img src="/ssem/resources/img/intro/stop.png" alt="중지"></button>
    </div>
    <button type="button" id="btnClose"><img src="/ssem/resources/img/intro/close.png" alt="영상 닫기"></button>
  </div>
</div>--%>

<div id="container"><!-- container - container -->
  <div class="intro_bg future">
    <div class="bg future_1"></div>
    <div class="bg future_2"></div>
    <div class="bg future_3"></div>
    <div class="bg future_4"></div>
    <div class="bg future_5"></div>
  </div>

  <div class="intro_bg life">
    <div class="bg life_1"></div>
    <div class="bg life_2"></div>
    <div class="bg life_3"></div>
    <div class="bg life_4"></div>
    <div class="bg life_5"></div>
  </div>

  <div id="header">
    <div class="wrap">
      <h1>
        <a href="/ssem/youth/ssem/vision.do">
          <img src="/ssem/resources/img/intro/intro_logo.png" alt="송파쌤 SSEM" class="logo1">
          <img src="/ssem/resources/img/intro/intro_logo_w.png" alt="송파쌤 SSEM" class="logo2">
        </a>
      </h1>
      <form id="frm" name="frm" method="post">
      <div class="search_box">
        <div class="fm_inp">
          <input type="text" name="query" id="query" class="inp" title="프로그램 제목을 입력해주세요" placeholder="프로그램 제목을 입력해주세요">
        </div>
        <button type="submit" id="btn_search"><i class="icon_search_bk">검색</i></button>
      </div>
     </form>
    </div>
    <div class="intro_btn_wrap">
      <button type="button" id="introBtn1" data-section="#section1" data-type-name="future"  class="future intro_btn intro_btn_act screen_md_hide"><img src="/ssem/resources/img/intro/btn_item_1.png" alt="미래교육 Future education"></button>
      <button type="button" id="introBtn2" data-section="#section2" data-type-name="life"  class="intro_btn intro_btn_act life  screen_md_hide"><img src="/ssem/resources/img/intro/btn_item_2.png" alt="평생교육 lifelong education"></button>

      <a href="/ssem/youth/main/main.do" data-section="#section1" data-type-name="future" class=" future intro_btn screen_hide dp_md_inb"><img src="/ssem/resources/img/intro/btn_item_1.png" alt="미래교육 Future education"></a>
      <a href="/ssem/senior/main/main.do" data-section="#section2" data-type-name="life"  class="intro_btn life screen_hide dp_md_inb" ><img src="/ssem/resources/img/intro/btn_item_2.png" alt="평생교육 lifelong education"></a>
    </div>

    <div class="intro_btn_wrap_2">
      <button type="button" class="future intro_btn screen_md_hide" id="my_songpa"><img src="/ssem/resources/img/intro/btn_item_3.png" alt="나의 송파쌤 My Songpa SSEM"></button>
      <button type="button" class="intro_btn life screen_md_hide" id="coaching_ssem"><img src="/ssem/resources/img/intro/btn_item_4.png" alt="온라인 코칭쌤 Online Coaching SSEM"></button>

      <a href="/ssem/youth/mypage/pwd_confirm.do" class=" future intro_btn screen_hide dp_md_inb"><img src="/ssem/resources/img/intro/btn_item_3.png" alt="나의 송파쌤 My Songpa SSEM"></a>
      <a href="/ssem/youth/coach/coach_list.do" class="intro_btn life screen_hide dp_md_inb" ><img src="/ssem/resources/img/intro/btn_item_4.png" alt="온라인 코칭쌤 Online Coaching SSEM"></a>
    </div>

    <div class="title_box t_center future" data-type="future">
      <h1 class="tc_w fw_200 font_sc">
        Dive into <b class="fw_600">Youth Campus SSEM </b><br/>
        <span>송파쌤은 <b class="fw_600">청소년의 꿈과 미래</b>에 함께합니다.</span>
      </h1>
      <div class="t_center">
        <a href="/ssem/youth/main/main.do" class="btn btn_auto"><i class="icon_home">홈</i> 미래교육 전체보기</a>
      </div>
    </div>

    <div class="title_box t_center life" data-type="life">
      <h1 class="tc_w fw_200 font_sc">
        <b class="fw_600">Life-long Campus SSEM </b>Connected <br/>
        <span>송파쌤은 <b class="fw_600">교육을 통한 풍요로운 삶을</b> 지원합니다.</span>
      </h1>
      <div class="t_center">
        <a href="/ssem/senior/main/main.do" class="btn btn_auto"><i class="icon_home">홈</i> 평생교육 전체보기</a>
      </div>
    </div>
  </div>
  <div id="section1" class="section"  data-type="future">
    <div class="intro_footer fs_18">
      <div class="wrap">
        <div class="if_box row">
          <div class="if_item_wrap col_3 st_1">
            <a href="/ssem/youth/campus/person_lib_main.do" class="if_item" data-type="future">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_future_icon_01.png" alt="인물도서관 아이콘">
                <span class="if_tit">인물도서관</span>
                <span class="if_text">
                  송파의 전문가, 마을인재,<br>
                  기업들이 ‘인물도서’로 참여하여<br>
                  자라나는 청소년들이 올바르게<br>
                  성장할 수 있도록 돕는<br>
                  멘토링 플랫폼
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_2">
            <a href="/ssem/youth/campus/instrum_lib_main.do" class="if_item" data-type="future">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_future_icon_02.png" alt="악기도서관 아이콘">
                <span class="if_tit">악기도서관</span>
                <span class="if_text">
                  ‘1인 1악기-음악을 즐기는 송파’<br>
                  누구나 악기를 경험할 수 있도록<br>
                  악기를 대여하고 음악 창작 등<br>
                  다양한 음악활동을 지원하는<br>
                  복합 음악 문화 공간
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_3">
            <a href="/ssem/youth/campus/future_main.do" class="if_item" data-type="future">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_future_icon_03.png" alt="송파미래교육센터 아이콘">
                <span class="if_tit">송파미래교육센터</span>
                <span class="if_text">
                  4차 산업혁명 시대를 맞이하여<br>
                  코딩, VR, 드론 등 첨단기술교육<br>
                  지원을 통해 창의인재를<br>
                  양성하기 위한 교육플랫폼
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_4">
            <a href="/ssem/youth/campus/self_main.do" class="if_item" data-type="future">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_future_icon_04.png" alt="진학학습지원센터 아이콘">
                <span class="if_tit">진학학습지원센터</span>
                <span class="if_text">
                  학습상담 및 코칭 프로그램을<br>
                  제공하여 자기주도형 창의 인재를<br>
                  지원하는 학습관
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_5">
            <a href="/ssem/dream/main/dream_main.do" class="if_item" data-type="future">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_future_icon_05.png" alt="진로직업체험센터 아이콘">
                <span class="if_tit">진로직업체험센터</span>
                <span class="if_text">
                  배움을 디자인 하는 송파 비전아래<br>
                  민관학이 마을교육공동체를<br>
                  실현하고 아동청소년의<br>
                  건강한 성장과 발달을 지원
                </span>
              </span>
            </a>
          </div>
        </div>
      </div>
    </div>
    <a href="#introHideBtn1" class="btn_back" data-type-name="future" ><img src="/ssem/resources/img/intro/icon_back.png" alt="페이지 돌아가기"> </a>
  </div>

  <div id="section2" class="section"  data-type="life">
    <div class="intro_footer fs_18">
      <div class="wrap">
        <div class="if_box row">
          <div class="if_item_wrap col_3 st_6">
            <a href="/ssem/senior/forever/history.do" class="if_item" data-type="life">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_life_icon_01.png" alt="평생학습도시 아이콘">
                <span class="if_tit">평생학습도시</span>
                <span class="if_text">
                  세계속의 글로벌 평생학습도시, 송파구!<br>
                  배움의 의지가 있다면<br>
                  누구나 원하는 교육을 받을 수 있고,<br>
                  배움이 지역으로 환원되는<br>
                  선순환 평생학습도시
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_7">
            <a href="/ssem/senior/forever/learning_status.do" class="if_item" data-type="life">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_life_icon_02.png" alt="평생학습원 아이콘">
                <span class="if_tit">평생학습원</span>
                <span class="if_text">
                  누구나, 원하는 교육을<br>
                  받을 수 있는 곳,<br>
                  배움의 바람이 불어,<br>
                  나눔의 꽃을 피우는 평생배움터
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_8">
            <a href="/ssem/senior/forever/center_self_hall.do" class="if_item" data-type="life">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_life_icon_03.png" alt="자치회관 아이콘">
                <span class="if_tit">자치회관</span>
                <span class="if_text">
                  주민들의 건전한<br>
                  문화여가활동의 장,<br>
                  평생교육의 장, 자치활동의<br>
                  장으로서의 다양한<br>
                  교육 프로그램을 제공
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_9">
            <a href="/ssem/senior/forever/center_woman_hall.do" class="if_item" data-type="life">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_life_icon_04.png" alt="여성교실 아이콘">
                <span class="if_tit">여성교실</span>
                <span class="if_text">
                  여성의 건전한 여가활동과<br>
                  사회참여 기회를 지원하기 위한<br>
                  취미∙건강강좌 및<br>
                  창업∙취업을 위한 강좌
                </span>
              </span>
            </a>
          </div>
          <div class="if_item_wrap col_3 st_10">
            <a href="/ssem/senior/forever/center_ict_hall.do" class="if_item" data-type="life">
              <span class="if_text_wrap">
                <img src="/ssem/resources/img/intro/intro_life_icon_05.png" alt="정보화교육 아이콘">
                <span class="if_tit">정보화교육</span>
                <span class="if_text">
                  디지털 정보격차를 해소하고<br>
                  생활 속 활용능력을<br>
                  배양하기 위한 실용 중심 IT교육
                </span>
              </span>
            </a>
          </div>
        </div>
      </div>
    </div>
    <a href="#introHideBtn2" class="btn_back" data-type-name="life" ><img src="/ssem/resources/img/intro/icon_back.png" alt="페이지 돌아가기"> </a>
  </div>

  <div class="fs_16 t_center footer">
    COPYRIGHT @ Songpa-gu ALL RIGHT RESERVED.
  </div>
</div><!-- container: e-->


<script>
  // PC, MOBILE 구별
  function deviceCheck() {
      var pcDevice = "win16|win32|win64|mac|macintel";
      // 접속한 디바이스 환경
      if ( navigator.platform ) {
          if ( pcDevice.indexOf(navigator.platform.toLowerCase()) < 0 ) {
              return "mo";
          } else {
              return "pc";
          }
      }
  }

  if(deviceCheck() == "pc"){
      var vid = document.getElementById("video");

      function playVid() {
          vid.play();
      }

      function pauseVid() {
          vid.pause();
      }
      var moveTime = setInterval(function(){
          if($(".video").prop("ended")){
              //영상종료 후 진행할 함수 입력부분
              clearInterval(moveTime);
              $(".bg-video-wrap").fadeOut(200, function(){
                  $(".bg-video-wrap").remove();
              });
          }
      },200);

  }else if(deviceCheck() == "mo"){
      $('.bg-video-wrap').remove();
  }



  $(function(){

      /*2020.12.04 : s*/
      $(document).on('click', '#btnPlay',function(){
          playVid();
          $('#btnPlay').hide();
          $('#btnStop').show();
      });
      $(document).on('click', '#btnStop',function(){
          pauseVid();
          $('#btnStop').hide();
          $('#btnPlay').show();
      });
      /*2020.12.04 : e*/

      $(document).on('click', '#btnClose',function(){
          $(".bg-video-wrap").fadeOut(200, function(){
              $(".bg-video-wrap").remove();
          });
      });

      $(document).on('click', '#my_songpa',function(){
        location.href = "/ssem/youth/mypage/pwd_confirm.do";
      });

      $(document).on('click', '#coaching_ssem',function(){
        location.href = "/ssem/youth/coach/coach_list.do";
      });

      $(document).on('click', '.intro_btn_act',function(e){
          var wid = window.innerWidth;
          e.preventDefault();
          act_intro_btn( $(this).data('section'), $(this).data('type-name'))
      });

      $(document).on('mouseenter', '.if_item',function(){
          act_intro_bg( $(this).closest('.if_item_wrap').index(), $(this).data('type') );
      });
      $(document).on('mouseleave', '.if_item',function(){
          act_intro_bg_off( $(this).closest('.if_item_wrap').index(), $(this).data('type') );
      });
      $(document).on('click', '.btn_back',function(){
          act_back_btn( $(this).attr('href'), $(this).data('type-name'));
      });
  });

  function act_intro_btn(idName, type){
      $( idName ).fadeIn(300).focus();
      $('#header .intro_btn_wrap').hide();
      $('#header .intro_btn_wrap_2').hide();
      $('#container').css("min-height", "56.25rem");
      $('[data-type='+type+']').show();
      $('.logo1').hide();
      $('.footer').hide();
      $('.logo2').show();
      $('.intro_bg.'+type).addClass('on');
  }
  function act_back_btn(idName, type){
      $( '#header .intro_btn_wrap_2').show().focus();
      $( '#header .intro_btn_wrap').show();
      $('[data-type='+type+']').hide();
      $('.intro_bg.'+type).removeClass('on');
      $('.section').hide();
      $('.logo2').hide();
      $('.logo1').show();
      $('.footer').show();

      location.reload();
  }
  function act_intro_bg(ind, type){
      $('.'+type).find('.bg').eq(ind).siblings().removeClass('on');
      $('.'+type).find('.bg').eq(ind).addClass('on');
  }
  function act_intro_bg_off(ind, type){
      $('.'+type).find('.bg').eq(ind).removeClass('on');
  }
</script>
</body>
</html>
