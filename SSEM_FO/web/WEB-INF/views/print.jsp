<%--
  Created by IntelliJ IDEA.
  User: shlee
  Date: 2020-12-06
  Time: 오전 3:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="ko">
<head>
    <title> 송파쌤 </title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/ssem/resources/css/print.css">
    <script src="/ssem/resources/js/jquery-3.4.1.min.js"></script>
    <script>
        var shotit = function() {
            window.print();
            setTimeout(function(){
                self.close();
            }, 100);
        }

        window.onbeforeprint = zoomToA4;
        window.onafterprint = zoomNormal;

        var pixelsToPrint = 650;
        var bZoom = 1;

        function zoom(pxlToPrt) {
            if (pxlToPrt == 0) {
                document.body.style.zoom = 1;
            } else if (bZoom != 0) {
                var zoomRatio = pxlToPrt / document.body.scrollWidth;
                zoomRatio = (zoomRatio > 1) ? 1 : zoomRatio;
                document.body.style.zoom = zoomRatio;
            }
        }
        function zoomFit() {
            zoom(pixelsToPrint);
        }
        function zoomNormal() {
            zoom(0);
        }
        function zoomStatus(zoom) {
            bZoom = (zoom==0) ? 0 : 1;
        }
        function zoomToA4(direction) {
            pixelsToPrint = (directions==0) ? 650 : 975;
        }
    </script>
    <style>
        @font-face {
            font-family: 'Arita-buri-SemiBold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Arita-buri-SemiBold.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }


        body, html{font-family: 'Arita-buri-SemiBold', sans-serif;}
        body{
            opacity: 0;
            width: 200px;
        }

        #cert_print { width: 1000px; height: 1414px; margin: 60px 50px 0 15px; position: relative; }


        .cert_con_bg .bg{
            width: 1000px;
            height: 1414px;
            position: absolute;
            top: 0;
            left:0;
        }
        #cert_print .con_title{font-weight: 900; font-size: 69px; position: absolute; top:230px; text-align:center;width:100%}
        #cert_print .con_info_wrap{width: 640px; font-size: 24px; position: absolute; top:370px; left:50%; margin-left:-320px }
        #cert_print .con_info{width: 640px; font-size: 24px; min-height: 370px; margin-bottom:20px}
        #cert_print .con_info li{
            padding-left: 240px;
            margin-top: 20px;
        }
        #cert_print .con_info li .bullet{
            width: 15px;
            margin-top:10px;
            margin-left:-240px;
            vertical-align: top;
        }
        #cert_print .con_info li > span{
            vertical-align: top;
            display: inline-block;
            line-height: 1.5;
            max-width: 98%;
        }

        #cert_print .con_info li .con_info_title{
            display: inline-block;
            width: 170px;
            text-align: justify;
            height: 1.5em;
            overflow: hidden;
        }
        #cert_print .con_info li .con_info_title + span{
            display: inline-block;
            margin-left:4px;
            width: 30px;
            text-align: center;
        }
        #cert_print .con_info li .con_info_title::after{
            content:'';
            display:inline-block;
            width: 100%;
        }
        #cert_print .text_2{
            display: block; margin: 0 auto;
            width: 608px;;
        }
        #cert_print .text_3{
            display: inline-block;
            margin:30px auto 0;
            width: 430px;
        }
        #cert_print .stamp{
            display: inline-block;
            position: absolute;
            left:662px;
            top: 40px;
            width: 100px;
            z-index: 0;
        }
        #cert_print .con_footer{
            width: 100%;
            height:260px;
            position: absolute;
            left:0;
            bottom:0;
            font-size: 28px;
            text-align: center;
        }

        @media print {
            @page {margin:-0.8cm 0.45cm 0 0}
            html {margin:0 0 0 0.1cm}
            body{opacity: 1;}
            header, footer { display: none; }
        }
    </style>
</head>
<body onload="shotit()">
<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>
<div class="cert_con_inner" id="cert_print" >
    <div class="cert_con_bg">
        <img src="/ssem/resources/img/print/cert_print_bg.jpg" class="bg" alt="배경">

        <h1 class="con_title"><img src="/ssem/resources/img/print/cert_print_text1.jpg" class="text_1" alt="수료확인서"></h1>

        <div class="con_info_wrap">
            <ul class="con_info">
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">성 명</span><span>:</span>
                    <span>${lectureApyVo.apy_name}</span>
                </li>
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">생 년 월 일</span><span>:</span>
                    <span>${fn:substring(lectureApyVo.apy_birth, 0, 4)}년 ${fn:substring(lectureApyVo.apy_birth, 5, 7)}월 ${fn:substring(lectureApyVo.apy_birth, 8, 10)}일</span>
                </li>
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">교 육 분 야</span><span>:</span>
                    <span>${lectureVo.part_name}</span>
                </li>
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">프 로 그 램 명</span><span>:</span>
                    <span>${lectureVo.name}</span>
                </li>
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">교 육 기 관</span><span>:</span>
                    <span>${lectureVo.group.name}</span>
                </li>
                <li>
                    <img src="/ssem/resources/img/print/cert_print_bullet.jpg" class="bullet" alt="블릿">
                    <span class="con_info_title">교 육 기 간</span><span>:</span>
                    <span>${lectureVo.start_dt} ~ ${lectureVo.end_dt}</span>
                </li>
            </ul>
            <img src="/ssem/resources/img/print/cert_print_text2.jpg" class="text_2" alt="귀하는 위의 프로그램에 참여하여 교욱과정을 수료하였음을 확인합니다.">
        </div>
        <div class="con_footer">
            <p>${lectureVo.print_date}</p>
            <img src="/ssem/resources/img/print/cert_print_stamp.png" class="stamp" alt="수료확인서 도장">
            <img src="/ssem/resources/img/print/cert_print_text3.png" class="text_3" alt="수료확인서">
        </div>
    </div>
</div>
</body>
</html>
