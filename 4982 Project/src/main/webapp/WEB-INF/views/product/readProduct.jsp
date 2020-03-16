<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<title>Insert title here</title>
	
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user" />
	<script>
		isLogin = true;
		loginId = '${user}';
	</script>
</sec:authorize>

<script>
var no;
var seller;
function printProduct(product) {
	$("#topimg").attr("src", product.image);
	$("#productName").text(product.name);
	$("#productPrice").text(product.price);
	$("#productCnt").text(product.quantity);
	$("#productDate").text(product.product_date);
	$("#img0").attr("src", product.image);
}

function comma(str){
	str = String(str);
	str = str.replace(/,/g,"")
	$("#productinfo").append(str);
}

function printSell(sell){
	$("#productArea").text(sell.area);
	//$("#img0").attr("src", sell.img);
	comma(sell.infomation);
}

function printtrust(member){
	$("#membertrust").text(member.trust);
}

function printSeller(seller){
	$("#sellerimg").attr("src", seller.sellerimage);
	$("#sellerName").text(seller.sellername);
	$("#sellerUsername").text(seller.username);
	$("#sellercount").text(seller.count);
	seller = seller.username;
}

	function printPage(page) {
		$("#delete").remove();
		var $ul = $("<ul>").attr("class", "pagination pagination-sm").attr("id","delete").appendTo($("#rdpdpaging"));
		var cntOfPage = Math.floor(page.totalcount / page.pagesize);
		if (page.totalcount % page.pagesize != 0)
			cntOfPage++;

		var blockSize = 5;
		var blockNo = Math.floor(page.pageno / blockSize) + 1;
		if (page.pageno % blockSize == 0)
			blockNo--;
		var startPage = (blockNo - 1) * blockSize + 1;
		var endPage = startPage + blockSize - 1;
		if (endPage > cntOfPage)
			endPage = cntOfPage;

		if (blockNo > 1) {
			var $li = $("<li>").attr("class", "leejeon").appendTo($ul);
			$("<span>").attr("id","pagingiqId").attr("class", "pagingiq").val(startPage-1).text("◁").appendTo($li);
		}
		for (var i = startPage; i <= endPage; i++) {
			if (i == page.pageno) {
				var $li = $("<li>").attr("class", "actbtn").appendTo($ul);
				$("<span>").attr("id","pagingiqId").attr("class", "pagingiq").val(i).text(i).appendTo($li);
			} else {
				var $li = $("<li>").appendTo($ul);
				$("<span>").attr("id","pagingiqId").attr("class", "pagingiq").val(i).text(i).appendTo($li);
			}
		}

		if (endPage < cntOfPage) {
			var $li = $("<li>").attr("class", "rashisa").appendTo($ul);
			$("<span>").attr("id","pagingiqId").attr("class","pagingiq").val(endPage + 1).text("▷").appendTo($li);
		}
		$(".pagingiq").on("click", function(){

			loadInquiry(no,$(this).val())
		});
	}
	function printInquiry(inquiry){
		for(var i=0; i<5; i++){
			var $id="#productInquiry" + i;
			var $ansbtnid = "#ansbtnid" +  i;
			$($id).text("");
			$($ansbtnid).val("작동안됨");
		}
		$.each(inquiry.productInquiryPage, function(idx, rst){
			var $id="#productInquiry" + idx;
			var $ansbtnid = "#ansbtnid" + idx;
			$($id).text(rst.question);
			$($ansbtnid).val(rst.no);
		})
	}

	function printAnswer(answer){
		$.each(answer.productInquiryPage, function(idx, rst){
			var $id = "#productAnswer" + idx;
			$($id).text(rst.answer);
		})
	}
	
	function declaraion(seller){
		/*
		var declarationData = {
				username : seller
		};
		*/
		no = location.search.substr(3);
		location.href = "/fontExample/declaration?" + no;
	}
	
	function buy(){
		var buyData = {"no" : location.search.substr(1)};
		$.ajax({				
			url: "/fontExample/api/cachecheck",
			method: "post",
			data: buyData,
			success: function(result, textStatus, response){
				location.href = "/fontExample/cachecheck?"+result;
			}
		})
	}
	
	function loadInquiry(no,pageno){
		var params = {
				no : no,
				pageno : pageno
		}
		$.ajax({
			url: "/fontExample/api/ProductInquiryPage",
			method: "get",
			data : params,
			async:false,
			success: function(rst){
				printInquiry(rst);
				printAnswer(rst);
				printPage(rst);
			}
		});
	}
	
	function insertInquiry() {
		var formData = new FormData(document.getElementById("QnA"));
		var data = {
				question : $("#question").val(),
				productNo : no
		};
		console.log(data)
		$.ajax({
			url : "/fontExample/api/ProductInQuestion",
			method : "post",
			data : data,
			success : function(result, textStatus, response) {
				loadInquiry(no,1);
			},
			error : function(xhr) {
				console.log("에러 코드 :" + xhr.status);
				console.log("에러 메시지 :" + xhr.responseText);
			}
		})
	}
	function insertAnswer(inqno,inqanswer){
		var param = {
				no : inqno,
				answer : inqanswer
		}
		$.ajax({
			url : "/fontExample/api/ProductInAnswer",
			method : "post",
			data : param,
			success : function(result, textStatus, response) {
				loadInquiry(no,1);
			},
			error : function(xhr) {
				console.log("에러 코드 :" + xhr.status);
				console.log("에러 메시지 :" + xhr.responseText);
			}
		})
	}
	function addFavorite(){
		var favoriteparam = {
				productNo : no
			};
		$.ajax({
			url: "/fontExample/api/favorite",
			method: "post",
			data: favoriteparam,
			success: function(result, textStatus, response){
				alert(result)
			}
		})
	}
	
	$(function(){
		var seller2;
		no = location.search.substr(8);
		$.ajax({
			url: "/fontExample/api/readProduct/" + no,
			method: "get",
			success: function(result) {
				printProduct(result);
				printSell(result);
				printSeller(result);
				printtrust(result);
				
				seller2 = result.username;
				console.log(seller2);
			}
		});
		var tagParams = {
				_method : "put",
				productNo : no
		}
		$.ajax({
			url : "/fontExample/api/tag",
			method : "post",
			data : tagParams,
			success : function(result){
				var $tagList = ""
				$.each(result,function(idx,tag){
					$tagList = $tagList + " #" + tag
				})
				$("#productTag").text($tagList);
			}
		})
		loadInquiry(no,1);
		$("#sellinfoimg").on("click", function(){
			var popupX = (window.screen.width/2)-(500/2);
			var popupY = (window.screen.height/2)-(400/2);
			window.open("http://localhost:8081/fontExample/sellerpopup?no="+no, '_blinck', 'width=500, height=400, left='+popupX+',top='+popupY);
		});
		
		
		
		$(".pagingiq").on("click", function(){
			loadInquiry(no,$(this).val())
		});0
		
		$("#buybtn").on("click", function(){
			if(isLogin==true)
				buy();
			else
				alert("로그인이 필요합니다.")
		});
		
		$("#sgbtn").on("click", function(){
			if(isLogin==true)
				declaraion();
			else
				alert("로그인이 필요합니다.")
		});
		
		$("#likebtnn").on("click", function(){
			if(isLogin==true)
				addFavorite();
			else
				alert("로그인이 필요합니다.")
		})
		
		$("#qbtn").on("click", function(){
			if(isLogin==true)
				insertInquiry();
			else
				alert("로그인이 필요합니다.")
		})
		
		$(".subtn").on("click", function(){
			console.log(loginId);
			console.log(seller2);
			if(seller2==loginId){
				var selectid = $(this).attr('id').substring(8);
				if(selectid==0){
					insertAnswer($(this).val(),$("#answer0").val())
				}
				else if(selectid==1){
					insertAnswer($(this).val(),$("#answer1").val())
				}
				else if(selectid==2){
					insertAnswer($(this).val(),$("#answer2").val())
				}
				else if(selectid==3){
					insertAnswer($(this).val(),$("#answer3").val())
				}
				else if(selectid==4){
					insertAnswer($(this).val(),$("#answer4").val())
				}
			}
			else{
				alert("판매자 외에는 답변을 남기실 수 없습니다.")
			}
		})
	})
</script>
	<style>
		* {
			margin: 0 auto;
			padding: 0;
		}

		#infomain {
			overflow: hidden;
		}

		#topimg {
			width: 100%;
			height: 100%;
		}

		#topimgdiv {
			float: left;
			width: 40%;
			height: 240px;
			border: 1px solid pink;
		}

		#topinfo {
			float: right;
			width: 60%;
			height: 240px;
			border: 1px solid pink;
			text-align: left;
			padding: 5px;
			padding-left : 15px;
		}

		.pfont {
			font-weight: 900;
		}

		.clbtn {
			background-color: #ffb6c1;
			color: white;
			height: 30px;
			font-weight: bold;
			width: 33%;
			border: none;
			padding: 3px;
			display: inline-block;
		}

		.clbtn:hover {
			color: white;
			text-decoration: none;
		}

		.clbtn:visited {
			color: white;
			text-decoration: none;
		}

		#likebtnn {
			background-color: rgb(255, 132, 166);
			color: white;
			height: 30px;
			font-weight: bold;
			width: 25%;
			border: none;
			display: inline-block;
			padding: 5px;
			margin-right : 14px;
		}

		#buybtn {
			background-color: rgb(255, 158, 186);
			color: white;
			height: 30px;
			font-weight: bold;
			width: 25%;
			border: none;
			display: inline-block;
			padding: 5px;
		}

		#sgbtn {
			background-color: rgb(255, 121, 136);
			color: white;
			height: 30px;
			font-weight: bold;
			width: 25%;
			border: none;
			padding: 5px;
			display: inline-block;
		}

		#likebtnn:hover {
			color: white;
			text-decoration: none;
		}

		#buybtn:hover {
			color: white;
			text-decoration: none;
		}

		#sgbtn:hover{
			color: white;
			text-decoration: none;
		}
		
		#sgbtn:visited{
			color: white;
			text-decoration: none;
		}

		#likebtnn:visited{
			color: white;
			text-decoration: none;
		}

		#buybtn:visited{
			color: white;
			text-decoration: none;
		}

		#sibal {
			text-align: center;
		}

		#infobtn {
			text-align: center;
			float: right;
			width: 100%;
		}

		#infomain2 {
			width: 100%;
		}

		.infoimg {
			border: 1px solid aliceblue;
			width: 80%;
			height: 50%;
			padding: 10px;
		}

		#infotextread {
			width: 80%;
		}
		#sellinfo{
			width:100%;
			height: 280px;
			background-color: rgb(255, 241, 242);
		}
		#sellinfoimg{
			float: left;
			width: 35%;
			padding-top : 50px;
		}
		#sellinfotext{
			float: right;
			margin-top : 60px;
			width : 65%;
		}
		#sellerimg{
			width: 150px;
			height: 150px;
			margin-bottom : 5px;
			cursor: pointer;
		}
		#sellinfotext2{
			text-align: left;
			font-weight: 900;
		}
		#selltext10{
			width: 100%;
			height:10%;
			padding: 5px;
		}
		#sellh3{
			text-align: left;
			margin-left : 10px;
			margin-top : 10px;
			margin-right : 10px;
			padding-bottom : 5px;
			border-bottom : 1px solid black;
			font-weight : bold;
		}
		#qnadiv{
			width: 100%;
			height: 90px;
		}
		#productqna{
			width: 100%;
			height:10%;
			padding: 5px;
		}
		#producth3{
			text-align: left;
		
		}
		
		.sustyle{
			width: 90%;
			height: 30px;
		}
		
		.subtn{
			background-color: rgb(255, 121, 136);
			color: white;
			height: 30px;
			font-weight: bold;
			width: 5%;
			border: none;
			padding: 5px;
			display: inline-block;
		}
		#qbtn{
			background-color: rgb(255, 121, 136);
			color: white;
			height: 30px;
			font-weight: bold;
			width: 5%;
			border: none;
			padding: 5px;
			display: inline-block;
		}
		details{
			text-align: left;
			padding-left: 20px;
			padding-right: 20px;
		}
		#anisibal{
			text-align: left;
			padding-left: 20px;
			padding-right: 20px;
		}
		#sibaldiv{
			width: 100%;
			
		}
		.pagecolor{
			color:red;
		}
		#pagingiqId {
			color: hotpink;
		}
		#topinfoUl {
			margin-top : 20px;
		}
	</style>
<script>
</script>
</head>

<body>
	<div id="infomain">
		<div id="topimgdiv">
			<img src="" id="topimg">
		</div>
		<div id="topinfo">
			<ul id="topinfoUl">
				<li>
					<p class="pfont">제　품　명 :　<span id="productName"></span></p>
				</li>
				<li>
					<p class="pfont">가　　　격 :　<span id="productPrice"></span></p>
				</li>
				<li>
					<p class="pfont">수　　　량 :　<span id="productCnt"></span></p>
				</li>
				<li>
					<p class="pfont">거 래 지 역 :　<span id="productArea"></span></p>
				</li>
				<li>
					<p class="pfont">태　　　그 :　<span id="productTag"></span></p>
				</li>
				<li>
					<p class="pfont">등　록　일 :　<span id="productDate"></span></p>
				</li>
				<li id="sibal">
					<div>
						<button id="sgbtn">신고하기</button>　
						<button id="likebtnn">즐겨찾기</button>
						<button id="buybtn" onclick="buy()">구매하기</button>
					</div>
				</li>
			</ul>
		</div>
		<div id="infobtn">
			<a href="#infomain2" class="clbtn">상세 정보</a>
			<a href="#sellinfo" class="clbtn">판매자 정보</a>
			<a href="#productqna" class="clbtn">제품 문의</a>
		</div>
		<div id="infomain2">
			<img src="" class="infoimg" id="img0">
		</div>
		<div id="infotextread">
			<span id="productinfo">
				
			</span>
		</div>
		<hr>
		<div id="sellinfo">
			<div id="selltext10">
				<h3 id="sellh3">판매자 정보</h3>
			</div>
			<div id="sellinfoimg">
					<img src="" id="sellerimg">
				<p>*프로필 사진을 클릭하면 판매자 정보로 이동합니다.</p>
			</div>
			<div id="sellinfotext">
				<ul id="sellinfotext2">
					<li>스　토　어　명　:　<span id="sellerName"></span></li><br>
					<li>판　　매　　자　:　<span id="sellerUsername"></span></li><br>
					<li>신　　뢰　　도　:　<span id="membertrust"></span></li><br>
					<li>판　매　횟　수　:　<span id="sellercount"></span></li>
				</ul>
			</div>
		</div>
		<hr>
		<div id="qnadiv">
			<div id="productqna">
				<h3 id="producth3">제품 문의</h3>
				<hr style="border: 1px solid pink">
			</div>			
		</div>
		<div id="sibaldiv">
			<div id="anisibal">
		<form id="QnA">
				<input type="hidden" id="no" name="no">
				<input type="text" class="sustyle" id="question" name="question" placeholder="문의하실 사항을 입력하세요">　　　<button type="button" id="qbtn">작성</button>
		</form>
				<hr>
				<form id="answer">
				<p><span id="productInquiry0"></span></p>
				<details>
					<summary>답글</summary>
					<input type="hidden" id="no" name="no">
					<p><span id="productAnswer0"></span></p>
					<input type="text" placeholder="문의는 포도가 먹고시푼데" class="sustyle" id="answer0" name="answer">
					<button type="button" class="subtn" id="ansbtnid0">작성</button>
				</details>
				
				<hr>
				<p><span id="productInquiry1"></span></p>
				<details>
					<summary>답글</summary>
					<p><span id="productAnswer1"></span></p>
					<input type="hidden" id="no" name="no">
					<input type="text" placeholder="어머니 호 박 고 구 마" class="sustyle" id="answer1" name="answer">
					<button type="button" class="subtn" id="ansbtnid1">작성</button>
				</details>
				
				<hr>
				<p><span id="productInquiry2"></span></p>
				<details>
					<summary>답글</summary>
					<p><span id="productAnswer2"></span></p>
					<input type="text" placeholder="자살 방지 센터 1393" class="sustyle" id="answer2" name="answer">
					<button type="button" class="subtn" id="ansbtnid2">작성</button>
				</details>
				<hr>
				<p><span id="productInquiry3"></span></p>
				<details>
					<summary>답글</summary>
					<p><span id="productAnswer3"></span></p>
					<input type="text" placeholder="왜 나를 괴롭히나" class="sustyle" id="answer3" name="answer">
					<button type="button" class="subtn" id="ansbtnid3">작성</button>
				</details>
				<hr>
				<p><span id="productInquiry4"></span></p>
				<details>
					<summary>답글</summary>
					<p><span id="productAnswer4"></span></p>
					<input type="text" placeholder="굿 아이 디어 껄껄" class="sustyle" id="answer4" name="answer">
					<button type="button" class="subtn" id="ansbtnid4">작성</button>
				</details>
				<hr>
				</form>
				<div>
			<div style="text-align: center;" id="rdpdpaging">
			</div>
		</div>
			</div>
		</div>
	</div>
</body>

</html>