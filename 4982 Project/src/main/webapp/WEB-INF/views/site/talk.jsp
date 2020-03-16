<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<sec:authorize access="isAuthenticated()">                          <!--  로그인 했을 때 실행  -->
   <sec:authentication property="principal.username" var="user3" /> <!-- principal 로그인 되어 있는 정보  -->
</sec:authorize>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script>
	loginId = '${user}';
	$(document).ready(function(){
		var no = location.search.substr(4);
		console.log(loginId);
		$.ajax({
			url : "/fontExample/api/findTalker/"+no,
			method :"get",
			success:function(result){
				if(result.username == loginId){
					findseller(result.seller);	
				}else if(result.seller == loginId){
					findbuyer(result.username);
				}
			}
		})
		function findbuyer(username){
			console.log(username);
			var param = {
					username : username
			}
			$.ajax({
				url:"/fontExample/api/findbuyer",
				method : "get",
				data : param,
				success : function(result){
					$("#telSpan").text("구매자 전화번호");
					$("#tel").text(result.tel);
				}
			})
		}
		function findseller(username){
				console.log(username);
				var param = {
						username : username
				}
				$.ajax({
					url:"/fontExample/findseller",
					method : "get",
					data : param,
					success : function(result){
						$("#telSpan").text("판매자 전화번호 : ");
						$("#snsSpan").text("판매자 카톡아이디 : ");
						$("#sns").text(result.sns);
						$("#tel").text(result.tel);
					}
				})
		}
	})
</script>
<script>
var loginId = '${user3}'
	var wsocket;
	$(function(){
		// 연결버튼 누르면 서버측 웹소켓에 연결
		$("#connect").on("click",function(){
			wsocket = new WebSocket("ws://localhost:8081/fontExample/talked");
			wsocket.onopen = function(){
				console.log(wsocket)
				alert("서버에 연결이 되었습니다.");
			}
			wsocket.onclose = function(){
				alert("서버와 연결이 종료되었습니다");
			}
			wsocket.onmessage = function(result){
				$("#chatArea").append(result.data + "<br>");
			}
		});
		// talk 텍스트 상자에 키보드로 입력했을 때 , event객체는 자바스크립트가 알아서 생성
		$("#talk").on("keypress", function(e){
			if(e.keyCode==13){
				var msg = $("#talk").val();
				wsocket.send(loginId + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +msg);
				$("#talk").val("");
			}
		});
		
	});
</script>
<style>
#chatArea {
	text-align:center;
	border: 1px solid black;
	height: 600px;
	margin-left : 200px;
	margin-right : 200px;
	margin-bottom : 5px;
	width : 800px;
}
#talkMain{
	margin-top : 10px;
}
.sellerInfo {
	text-align: left;
	float: left;
}
#rightDiv {
	text-align: right;
	float: right;
}
#aaaa {
	overflow: hidden;
	width : 800px;
	margin-left : 200px;
}
#tel {
	margin-right : 5px;
}
</style>
</head>
<body>
<div id="talkMain">
	<div id="chatArea"></div>
	<div id="aaaa">
		<div class="sellerInfo">
			<span id="telSpan"></span>
			<div id="tel"></div>
		</div>
		<div class="sellerInfo">
			<span id="snsSpan"></span>
			<div id="sns"></div>
		</div>
		<div id="rightDiv">
			<input type="text" id="talk">
			<button id="connect">연결</button>
			<button id="close">종료</button>
		</div>
	</div>
</div>
</body>
</html>


