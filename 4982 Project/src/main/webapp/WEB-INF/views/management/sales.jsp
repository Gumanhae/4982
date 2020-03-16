<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title> 메출 현황 </title>
<style>
#a {
	float: right;
	width: 80%;
	height: 100%
}

#b {
	font-family: THE행복열매;
	font-weight: bolder;
	text-align: left;
	font-size: 40px;
}

#c {
	border: 1px solid black;
	text-align: left;
	width: 100%;
	margin: 5px;
}
#myChart{
	display:block;
}
#showDiv {
	height : 30px;
}
#showYear {
	padding-top : 2px;
}
#showOption {
	padding-bottom : 2px;
}
</style>
<script>
function createChart(dataList){
	var ctx = document.getElementById('myChart').getContext('2d');
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: ['1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월'],
	        datasets: [{
	            label: '주요 현황',
	            data: dataList,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 0.5
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true
	                }
	            }]
	        }
	    }
	});
}
function loadingChart(years,types){
	$.ajax({
		url : "/fontExample/api/statistics/chart?year="+years+"&type="+types,
		method : "get",
		success : function(result){
			createChart(result)
		}
	})
}
$(function(){
	$.ajax({
		url : "/fontExample/api/statistics/today",
		method : "get",
		success : function(result){
			var $PT = $("#PT");
			$("<td>").text(result[0].dealAmount).appendTo($PT);
			$("<td>").text(result[0].dealCount).appendTo($PT);
			$("<td>").text(result[0].joinCount).appendTo($PT);
			$("<td>").text(result[0].visitCount).appendTo($PT);
		}
	})
	$.ajax({
		url : "/fontExample/api/statistics",
		method : "get",
		success : function(result){
			console.log(result);
			var $PM = $("#PM");
			var amount = 0;
			var deal = 0;
			var join = 0;
			var visit = 0;
			$.each(result,function(idx,statis){
				amount = amount + statis.dealAmount;
				deal = deal + statis.dealCount;
				join = join + statis.joinCount;
				visit = visit + statis.visitCount;
			})
			$("<td>").text(amount).appendTo($PM);
			$("<td>").text(deal).appendTo($PM);
			$("<td>").text(join).appendTo($PM);
			$("<td>").text(visit).appendTo($PM);
		}
	})
	loadingChart($("#showYear").val(),$("#showOption").val());
	$("#showYear").on("change",function(){
		loadingChart($("#showYear").val(),$("#showOption").val());
	})
	$("#showOption").on("change",function(){
		loadingChart($("#showYear").val(),$("#showOption").val());
	})
})
</script>
</head>
<body>
	<div id="content">
		<div>
			<jsp:include page="/WEB-INF/views/management/managementpage.jsp" />
		</div>
		<div id="a">
			<div id="b"> 매출 현황 </div>
			<div id="c"></div>
	<table class="table table-striped">
		<thead>
			<tr><th colspan="5">오늘의 현황</th></tr>
		</thead>
		<tbody>
			<tr><td>매출</td><td>결제건수</td><td>회원가입</td><td>방문자</td></tr>
			<tr id="PT"></tr>
		</tbody>
		<thead>
			<tr><th colspan="5">전체 현황</th></tr>
		</thead>
		<tbody>
			<tr><td>매출</td><td>결제건수</td><td>회원가입</td><td>방문자</td></tr>
			<tr id="PM"></tr>
		</tbody>
	</table>
	<div id="showDiv">
		<select id="showYear">
			<option value="2018">2018</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
		</select>
		<select id="showOption">
			<option value="1">방문자수</option>
			<option value="2">가입자수</option>
			<option value="3">거래횟수</option>
			<option value="4">거래금액</option>
		</select>
	</div>
		<canvas id="myChart" width="400" height="200"></canvas>
		</div>
	</div>
</body>
</html>