<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재시스템</title>

<style type="text/css">

div#editBoard {
	margin-top: 70px;
}

div#editBoard li {
	list-style: none;
	margin: 20px;
	display: inline-block;
}

div.approvalEdit {
	border: solid 1px #6449FC;
	width: 220px;
	height: 140px;
    cursor: pointer;
    display: inline-flex;
    border-radius: 10px;
    color: #6449FC;
}

span#title {
	font-weight: bold;
	font-size: 12pt;
	padding-left: 20px;
}

i.fas {
	padding : 20px 10px 20px 20px;
}

span#category {
	margin-left: 20px;
}

div.approvalEdit:hover {
	background-color: #6449FC;
	color:white;
	cursor: pointer;
}



</style>

<%-- Required meta tags --%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<%-- Bootstrap CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<%-- Bootstrap Icons --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<%-- Font Awesome 5 Icons --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<%-- Optional JavaScript --%>

	<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
	
<script type="text/javascript">	
	$(document).ready(function(){
		
		// 비품 신청
		$("a#1").click(function () {
			location.href="<%= ctxPath%>/equipmentEdit.groovy";
		})
		
		// 경조비 신청
		$("a#2").click(function () {
			alert("준비중입니다.");
			<%-- location.href="<%= ctxPath%>/expensesEdit.groovy"; --%>
		})
		
		// 출장비 신청
		$("a#3").click(function () {
			location.href="<%= ctxPath%>/businessCostEdit.groovy";
		})
		
		// 식비 사용 내역
		$("a#4").click(function () {
			location.href="<%= ctxPath%>/foodExpensesEdit.groovy";
		})
		
		// 휴가 신청
		$("a#5").click(function () {
			location.href="<%= ctxPath%>/vacationEdit.groovy";
		})
		
		// 휴직 신청
		$("a#6").click(function () {
			location.href="<%= ctxPath%>/absenceEdit.groovy";
		})
		
		// 신규 프로젝트 신청
		$("a#7").click(function () {
			location.href="<%= ctxPath%>/newProjectEdit.groovy";
		})
		
	});
	
	
</script>

</head>
<body>

<div id="container">

<div>전자결재시스템</div>
<h4>작성하기</h4>


<div id="editBoard">
	<ul>
		<c:forEach var="appvo" items="${requestScope.approvalList }">
			<li>
				<div class="approvalEdit">
					<a id="${appvo.apl_no }">
					  <span id="category">${appvo.apl_categoryname }</span><br>
					  <i class="${appvo.apl_img }"></i><span id="title">${appvo.apl_name}</span>
					</a>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>



</div>

</body>
</html>