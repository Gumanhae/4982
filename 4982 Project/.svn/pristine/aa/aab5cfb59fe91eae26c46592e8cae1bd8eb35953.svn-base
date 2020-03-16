<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
   var isLogin = false;
   var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">                          <!--  로그인 했을 때 실행  -->
   <sec:authentication property="principal.username" var="user" /> <!-- principal 로그인 되어 있는 정보  -->
   <script>
      isLogin = true;             
      loginId = '${user}';
   </script>
 <script>
 $(function(){
		printData();
	    $.ajax({
	        url: "/fontExample/api/point",
	        method: 'get',
	        success : function(result) {
	           $("#myPoint").text(result);
	        }
	     })
		$("#charge").on("click",function(){
			location.href = "/fontExample/charge"
		})
})

 function printData(){
     $("#username").text(loginId+"님"); // 화면이 띄워지면 로그인을 뿌린다
  }


 </script>
 </sec:authorize>
<style>
* {
	margin: 0;
	padding: 0;
}

.nav_wrapper {
	display: inline-block;
	text-align: center;
}

#logo {
	position: relative;
}
.searchClass {
	display: inline-block;
	border : 3px solid #ffb6c1;
	height : 40px;
	line-height: 40px;
}
#searchForm {
	overflow: hidden;
	height: 34px;
}
#searchOption {
	height: 26px;
	float : left;
	border : none;
	border-bottom : solid 2px #ffb6c1;
	margin: 2px 4px 4px 4px;
}
#search_input {
	float: left;
	display: block;
	width: 400px;
	height: 34px;
	border : 0;
	padding-left : 15px;
}
#searchBtn {
	height: 34px;
	border : 0;
	color : #ffb6c1;
	float : right;
}
#search_input:focus, #searchBtn:focus {
	outline: none;
}
.nav span{
	margin-right: 10px;
}
#p_logo{
	width: 20px;
	height: 20px;
	float : right;
}
#charge {
	border-radius : 30px;
	background-color : #ffb6c1;
	color : white;
	font-weight: bold;
}
#username,
#p_logo,
#myPoint {
	margin-top : 8px;
}
</style>
</head>
<body>
	<div class="nav">
		<div class="nav_wrapper">
			<a href="/fontExample"><img id="logo" src="resources/logo.png"></a>
			<div class="searchClass" id="search">
				<form action="/fontExample/productList" method="get" id="searchForm">
					<select id="searchOption" name="type">
						<option value="name">제품명</option>
						<option value="tag">태그</option>
					</select>
					<input id="search_input" type="text" placeholder="찾고 싶은 상품을 검색해보세요!"
						name="search">
					<button class="btn btn-default" id="searchBtn">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</form>
			</div>
		</div>
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<span style="float: right;"><button id="charge" type="button" class="btn btn-default">충전하기</button></span>	
			<span id="myPoint" style="float: right;"></span>
			<img src="resources/p_logo.PNG" id="p_logo"><span id="username" style="float: right;">
			</span>
		</sec:authorize>	
	</div>
</body>
</html>