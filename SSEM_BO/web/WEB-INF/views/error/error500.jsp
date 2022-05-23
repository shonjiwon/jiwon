<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<title>송파쌤</title>
	<meta charset="utf-8">

	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">


	<style>

		@font-face {
			font-family: 'teko';
			src: url('https://cdn.jsdelivr.net/npm/typeface-teko@1/files/teko-latin-500.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}

		@font-face {
			font-family: 'metropolis';
			src: url('https://cdn.jsdelivr.net/npm/fontsource-metropolis@3.0.1/files/metropolis-all-500-normal.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}
		@font-face {
			font-family: 'Noto Sans Korean';
			src: url('https://cdn.jsdelivr.net/npm/noto-sans-kr@0.1.1/fonts/NotoSans-Regular.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}
		:root { font-size: 16px; }
		@media all and (max-width: 1024px) { :root { font-size: 13px; } }
		@media all and (max-width: 767px) { :root { font-size: 11px; } }
		@media all and (max-width: 501px) { :root { font-size: 8px; } }
		@media all and (max-width: 374px) { :root { font-size: 7px; } }

		html, body, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video { margin: 0; padding: 0; border: 0; outline: 0; font-size: 100%; vertical-align: baseline; background: transparent; }
		article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
		blockquote, q { quotes: none; }
		blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
		a { margin: 0; padding: 0; font-size: 100%; vertical-align: baseline; background: transparent; color: #222; }
		/* change colours to suit your needs */
		ins { background-color: #ff9; color: #000; text-decoration: none; }
		/* change colours to suit your needs */
		mark { font-style: italic; line-height: initial; }
		del { text-decoration: line-through; }
		abbr[title], dfn[title] { border-bottom: 1px dotted; cursor: help; }
		table { border-collapse: collapse; border-spacing: 0; }
		/* change border colour to suit your needs */
		hr { display: block; height: 1px; border: 0; border-top: 1px solid #cccccc; margin: 1em 0; padding: 0; }
		input, select { vertical-align: middle; }
		select { font-family: inherit; -webkit-appearance: none; -moz-appearance: none; appearance: none; }
		select::-ms-expand { display: none; }
		ul, ol, li { list-style: none; }
		input { font-family: inherit; -webkit-appearance: none; -moz-appearance: none; appearance: none; }
		/* input box color */
		input:-webkit-autofill { -webkit-box-shadow: 0 0 0 30px #ffffff inset; -webkit-t-fill-color: #000000; }
		input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus, input:-webkit-autofill:active { transition: background-color 5000s ease-in-out 0s; }
		textarea { font-family: inherit; }
		button { font-family: inherit; background: transparent; border: none; box-shadow: none; border-radius: 0; padding: 0; overflow: visible; cursor: pointer; }
		button:focus { outline: none; }
		img { -ms-interpolation-mode: bicubic !important; }
		html { font-size: 100%; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; letter-spacing: -0.05em; }
		a { text-decoration: none; color: inherit; }
		* { box-sizing: border-box; }
		*:before, *:after { box-sizing: border-box; }
		body{
			background-color: #eeeeee;
		}
		a.btn, input[type='button'].btn, input[type='submit'].btn, button.btn { position: relative; overflow: hidden; display: inline-block; text-decoration: none; padding: 0 1.25rem; width: 11.25rem; height: 3.75rem; font-size: 1rem; line-height: 3.75rem; text-align: center; vertical-align: middle; cursor: pointer; background: #ffffff; color: #222222; border: 1px solid #dddddd; -moz-transition: all 0.2s ease-out; -webkit-transition: all 0.2s ease-out; -ms-transition: all 0.2s ease-out; -o-transition: all 0.2s ease-out; transition: all 0.2s ease-out; }
		a.btn:active, input[type='button'].btn:active, input[type='submit'].btn:active, button.btn:active { background: #ffffff; color: #222222; border: 1px solid #999999; }
		a.btn:active, input[type='button'].btn:active, input[type='submit'].btn:active, button.btn:active { -moz-transform: scale(0.97); -webkit-transform: scale(0.97); -ms-transform: scale(0.97); -o-transform: scale(0.97); transform: scale(0.97); }
		a.btn > *, input[type='button'].btn > *, input[type='submit'].btn > *, button.btn > * { display: inline-block; vertical-align: middle !important; line-height: 1.5; margin-top: -0.25rem; }

		/*btn_size*/
		.btn.btn_round { border-radius: 3.125em; }

		.error_box { background-color: #eeeeee; padding-top: 7.1875rem; font-family:'Noto Sans Korean', sans-serif;}
		.error_box .text_box { width: 100%; text-align: center; font-size: 1.375rem; color: #555555; }
		.error_box .text_box .error_tit { margin-top: 4.0625rem; color: #16c1f3; font-size: 8.75rem; font-family: 'teko', 'Roboto', 'Noto Sans Korean', sans-serif; letter-spacing: 0.1em; line-height: 1; }
		.error_box .text_box .error_sub { font-family: 'metropolis', 'Roboto', 'Noto Sans Korean', sans-serif; font-size: 1.875rem; line-height: 1; color: #222222; }
		.error_box .text_box .error_sub + p{padding-top: 2rem; padding-bottom: 1em;}
		.error_box .text_box .btn { font-size: 1.25rem; height: 3.125rem; min-width: 10.625rem; width: auto; line-height: 3rem; background-color: #b1b5ba; border-color: #b1b5ba; color: #ffffff; }
		.error_box .text_box .btn:hover { background-color: #16c1f3; border-color: #16c1f3; }

		@media all and (max-width: 767px) { .error_box img { float: none; margin-left: auto; margin-right: auto; max-width: 23.89236rem; }
			.error_box .img_box { margin-top: 3.12727rem; width: 100%; float: none; }
			.error_box .text_box { width: 100%; float: none; margin-right: 0%; font-size: 2.00145rem; }
			.error_box .text_box .error_sub { font-size: 2.50182rem; }
			.error_box .text_box .btn { font-size: 1.87636rem; height: 3.75273rem; padding: 0 2rem; line-height: 3.62764rem; } }

	</style>

</head>
<body>
<div class="error_box"><!-- error_box -->
	<div class="wrap clearfix">
		<div class="text_box float_right text_box">
			<h2 class="error_tit">500</h2>
			<p class="error_sub">Internal Server Error</p>
			<p class="mt_30">요청하신 페이지를 찾을 수 없습니다.</p>
			<a href="javascript:history.back();" class="mt_30 btn btn btn_round">이전페이지</a>
		</div>
	</div>
</div><!-- error_box : e -->
</body>
</html>
