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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title> 나의 문의 내역 </title>
<sec:authorize access="isAuthenticated()">                          <!--  로그인 했을 때 실행  -->
	<sec:authentication property="principal.username" var="user" /> <!-- principal 로그인 되어 있는 정보  -->
</sec:authorize>
<script>
function printList(result) {
	var $body = $("#list");
	$.each(result.inquiryPage, function(idx, mr) {
		var $tr = $("<tr>").appendTo($body);
		$("<td>").attr("class", "mr.no").text(mr.no).appendTo($tr);
		var $td = $("<td>").appendTo($tr);
		$("<a>").text(mr.title).attr("href",
				"/fontExample/inquiry_read?no=" + mr.no).appendTo($td);
		$("<td>").text(mr.username).appendTo($tr);
		$("<td>").attr("class","type_no").text(mr.type_no).appendTo($tr);
		if (mr.process == 0) {
			$("<td>").text("대기중").appendTo($tr);
		} else if (mr.process == 1) {
			$("<td>").text("답변완료").appendTo($tr);
		}
	});
}
function printPage(page, writer) {
	var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));

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

	var writerParam = '';
	if (writer != undefined)
		writerParam = '&writer=' + writer;
	if (blockNo > 1) {
		var $li = $("<li>").attr("class", "previous").appendTo($ul);
		$("<a>").attr(
				"href",
				"/fontExample/myinquiry?pageno=" + (startPage - 1)).text("앞으로").appendTo($li);
	}
	for (var i = startPage; i <= endPage; i++) {
		if (i == page.pageno) {
			var $li = $("<li>").attr("class", "active").appendTo($ul);
			$("<a>").attr("href",
					"/fontExample/myinquiry?pageno=" + i).text(
					i).appendTo($li);
		} else {
			var $li = $("<li>").appendTo($ul);
			$("<a>").attr("href",
					"/fontExample/myinquiry?pageno=" + i).text(
					i).appendTo($li);
		}
	}

	if (endPage < cntOfPage) {
		var $li = $("<li>").attr("class", "next").appendTo($ul);
		$("<a>").attr(
				"href",
				"/fontExample/myinquiry?pageno=" + (endPage + 1)).text("다음으로").appendTo($li);
	}
}
$(function() {
	var username = '${user}';
	var params = {
			username : username,
			pageno : location.search.substr(8)
	}
	$.ajax({
		url : "/fontExample/api/inquiryMyAllRead",
		method : "get",
		data : params,
		success : function(result, status, xhr) {
			printList(result);
			printPage(result);
			console.log(result);
		},
		error : function(xhr) {
			console.log(xhr.status);
		}
	});
});
</script>
<style type="text/css">

#myinquiry_a {
	float: right;
	width: 80%;
	height: 100%;
	/* 	margin-top: 30px;
	width: 820px;
	height: 1000px; */
}

#myinquiry_b {
	font-family: THE행복열매;
	font-weight: bolder;
	text-align: left;
	font-size: 40px;
}

#myinquiry_c {
	border: 1px solid black;
	text-align: left;
	width: 100%;
	margin: 5px;
}

.table th, #list {
	text-align: center;
	font-weight: bold;
}
</style>
</head>
<body>
	<div>
		<div>
			<jsp:include page="/WEB-INF/views/member/myPageMenu.jsp" />
		</div>
	<div id="myinquiry_a">
		<div id="myinquiry_b">My 문의 페이지</div>
		<div id="myinquiry_c"></div>
		<table class="table table-hover">
			<colgroup>
				<col width="5%">
				<col width="65%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>문의 제목</th>
					<th>작성자</th>
					<th id="type_no">문의 유형</th>
					<th>처리 상태</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
		<div id="paging" style="text-align: center;"></div>
	</div>
	</div>
</body>
</html>