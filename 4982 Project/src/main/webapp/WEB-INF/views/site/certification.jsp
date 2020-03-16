<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<script>
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script>
	var random_number = 0;
	$(document)
			.ready(
					function() {
						$("#serviceview").click(function() {
											var url = "serviceview";
											var name = "서비스이용약관";
											var option = "width = 620, height = 600, top = 100, left = 200, location = no";
											window.open(url, name, option);
										});
						$("#privacy").click(function() {
											var url = "privacy";
											var name = "개인정보수집";
											var option = "width = 620, height = 600, top = 100, left = 200, location = no";
											window.open(url, name, option);
										});
						$("#uniqueIdentification").click(function() {
											var url = "uniqueIdentification";
											var name = "고유식별";
											var option = "width = 620, height = 600, top = 100, left = 200, location = no";
											window.open(url, name, option);
										});
						$("#newsAgency").click(function() {
											var url = "newsAgency";
											var name = "통신사이용약관";
											var option = "width = 620, height = 600, top = 100, left = 200, location = no";
											window.open(url, name, option);
										});
						$("#certification_number_button").click(function() {
											var name = $("#name").val();
											var chk_radio = document
													.getElementsByName('agency');
											var radio_result = false;
											for (var i = 0; i < 3; i++) {
												console.log(chk_radio[i].checked == true);
												if (chk_radio[i].checked == true) {
													radio_result = true;
													break;
												}
											}
											var conditions = document
													.getElementsByName('conditions');
											var conditions_result = false;
											for (var i = 0; i < 3; i++) {
												console
														.log(conditions[i].checked == true);
												if (conditions[i].checked == true) {
													conditions_result = true;
												} else {
													conditions_result = false;
												}
											}
											var phone_number = $("#tel").val();
											if (name == "") {
												alert("이름을 입력해주세요");
											} else if (phone_number == "") {
												alert("휴대폰 번호를 입력해주세요");
											} else if (!radio_result) {
												alert("통신사를 선택해주세요");
											} else if (!conditions_result) {
												alert("약관을 동의해주세요");
											} else {
												random_number = Math.floor(Math.random() * 100000) + 1;
												console.log(random_number);
											}
										});
						$("#certification_button").click(function() {
											var certification_number = $("#certification_number").val();
											if (certification_number == random_number) {
												var pageName = location.search.substr(1);
												console.log(pageName);
												if (pageName == "withdrawal") {
													$.ajax({
																url : "/fontExample/api/findId",
																method : 'get',
																data : $(
																		"#findInfo")
																		.serialize(),
																success : function(result) {
																	opener.document.location.href = "/fontExample/withdrawal?"+ result;
																	window.close();
																},
																error : function(
																		xhr) {
																	alert("등록된 사용자가 없습니다.");
																	window
																			.close();
																}
															})
												} else if (pageName == "findPwd") {
													$.ajax({
																url : "/fontExample/api/changePwd",
																method : 'post',
																data : $("#findInfo").serialize(),
																success : function(result) {
																	opener.document.location.href = "/fontExample/notLoginChangePwd?username = " + result;
																	window.close();
																},
																error : function(
																		xhr) {
																	alert("등록된 사용자가 없습니다.");
																	window
																			.close();
																}
															})

												} else if (pageName == "findId") {
													$.ajax({
																url : "/fontExample/api/findId",
																method : 'get',
																data : $(
																		"#findInfo")
																		.serialize(),
																success : function(result) {
																	opener.document.location.href = "/fontExample/findId?" + result;
																	window.close();
																},
																error : function(xhr) {
																	alert("등록된 사용자가 없습니다.");
																	window
																			.close();
																}
															})
												}
											} else {
												alert("인증번호를 확인해주세요");
											}

										});
					});
</script>

<style>
* {
	margin: 0 auto;
	padding: 0;
}

h2 {
	text-align: center;
}

#certification_main {
	text-align: center;
	width: 600px;
}

ul {
	background: #F8F8F8;
	width: 500px;
	text-align: center;
}

.certification_textAll {
}

li {
	list-style: none;
}

#foot {
	font-size: 10px;
}

#certification_infotext {
	width: 380px;
}

.certification_left {
	text-align: left;
}

p {
	font-size: 12px;
}

#certification_button, #certification_number_button {
	width: 120px;
	height: 30px;
	border-radius: 4px;
	background-color: #ffb6c1;
	font-weight: bold;
	color: white;
	border: none;
	display: inline-block;
	margin-top : 4px;
	margin-bottom : 4px;
	margin-left : 35px;
}
.certiFormDIv {
	text-align: left;
	margin-left : 8px;
}
#findInfo {
	width : 380px;
	border : 2px solid #DDDDDD;
	padding : 5px;
	padding-top : 7px;
}
#name {
	width : 100px;
	margin-left : 48.4px;
	margin-bottom : 6px;
}
#date {
	width : 130px;
	margin-left : 20px;
	margin-top : 6px;
	margin-bottom : 7px;
}
#tel {
	width : 100px;
	margin-left : 4px;
}
#certification_number {
	width : 100px;
	margin-left : 18px;
}
#skt {
	margin-left : 10px;
}
#skt,
#kt,
#lg {
	margin-right : 5px;
}
#sktSpan,
#ktSpan {
	margin-right : 35px;
}
#certification_foot {
	margin-top : 6px;
	margin-bottom : 6px;
	overflow : hidden;
	width : 230px;
}
.footInput {
	float : left;
}
#serviceview,
#privacy,
#uniqueIdentification,
#newsAgency {
	border-radius: 4px;
	font-size : 10px;
	background-color : white;
	color: black;
	border: none;
	display: inline-block;
	margin-left : 5px;
}
#footSpanService {
	margin-left : 17.5px;
}
#footSpanUniQue {
	margin-left : 27px;
}
#footSpanNews {
	margin-left : 13px;
}
#footSpanService,
#footSpanUniQue,
#footSpanNews,
#footSpanPrivacy {
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="certification_main">
		<h2>
			<img src="resources/logo.png" id="logo">
		</h2>

		<div id="certification_infotext">
			<h3 class="certification_left">휴대폰 본인인증</h3>
			
			<p class="certification_left">정확한 본인의 성명, 생년월일, 성별과 휴대폰 정보를 입력해
				주십시오.</p>
			
				<form id="findInfo">
					<div class="certiFormDIv">
						<label class="certification_left">성명</label>
						<input id="name" name="name" type="text" class="certification_textAll">
					</div>
					<div class="certiFormDIv">
						<label class="certification_left">생년월일</label>
						<input type="date" id="date" name="date" class="certification_textAll">
					</div>
					<div class="certiFormDIv">
						<label class="certification_left">이동 통신사</label>
						<input type="radio" id="skt" name="agency" value="skt">
						<span id="sktSpan">SKT</span>
						<input type="radio" name="agency" id="kt" value="kt">
						<span id="ktSpan">KT</span>
						<input type="radio" name="agency" id="lg" value="lg">
						<span>LG</span>
					</div>
					<div class="certiFormDIv">
						<label class="certification_left">핸드폰 번호</label>
						<input type="text" class="certification_textAll" id="tel" name="tel">
						<button id="certification_number_button">인증번호 발송</button>
					</div>
					<div class="certiFormDIv">
						<label class="certification_left">인증 번호</label>
						<input type="number" class="certification_textAll" id="certification_number" name="certification_number">
						<button id="certification_button" type="submit">인증</button>
					</div>
				</form>
			
		</div>
		<div id="certification_foot">
			<div>
				<input class="footInput" type="checkbox" name="conditions" value="">
				<span id="footSpanService">서비스 이용약관동의</span>
				<button type="button" name="" id="serviceview">전문보기</button>
			</div>
			<div>	
				<input class="footInput" type="checkbox" name="conditions" value="">
				<span id="footSpanPrivacy">개인정보이용동의</span>
				<button type="button" name="" id="privacy">전문보기</button>
			</div>
			<div>
				<input class="footInput" type="checkbox" name="conditions" value="">
				<span id="footSpanUniQue">고유식별정보처리동의</span>
				<button type="button" name="" id="uniqueIdentification">전문보기</button>
			</div>
			<div>
				<input class="footInput" type="checkbox" name="conditions" value="">
				<span id="footSpanNews">통신사이용약관동의</span>
				<button type="button" name="" id="newsAgency">전문보기</button>
			</div>
		</div>
		
	</div>
</body>
</html>