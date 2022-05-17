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
<title>비품신청</title>

<style type="text/css">

div#container {
	margin-left: 50px;
	width: 60%;
	position: relative;
	display: inline-block;
	float: left;
}

div.title {
	margin-top: 50px;
}

span.title {
	font-size: 16pt;
	font-weight: bold;
	margin: 10px 5px;
}

div.box {
	margin-top: 20px;
}

input.box {
	height: 38px;
	width: 100%;
	border-radius: 5px;
	border: solid 1px grey;
}

label {
	font-weight: bold;
	font-size: 12pt;
}

button.app_btn {
	width: 120px;
	border: solid 1px grey;
	margin: 30px;
	background-color: #6449FC;
	color: white;
	height: 37px;
	border-radius: 7px;
	
}

div#app_btn {
	text-align: center;
	margin: 0 auto;
}

button.app_btn:hover {
	font-weight: bold;
	color: white;
	background-color: #b3b3ff;
}

div#approvePerson {
	border: solid 1px grey;
	width: 300px;
	height: 500px;
    border-radius: 10px;
    display: inline-block;
    padding: 30px;
}

button#approvePersonAdd {
	margin: 30px auto;
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
	
	
	
	
}); // $(document).ready(function()
	
	
function cancel() {
	location.href='<%= ctxPath%>/approvalView.groovy';
}
	
function goEpuipment() {
	
	const frm = document.equipmentEditFrm;
	frm.action = "goEpuipment.groovy";
	frm.method = "post";
	frm.submit();
	
}	
	
</script>

</head>
<body>

	
<div id="container">
		
		<div class="title">
			<i class="fas fa-file-alt fa-2x"></i> <span class="title">비품신청</span>
		</div>

		<div class="title">일하는데 필요한 물품을 신청해주세요 !</div>
		
		<form name="equipmentEditFrm">
			<div class="box">
				<label>품명</label><br>
				<input type="text" name="productName" size="50" class="box" autocomplete="off" placeholder="내용을 입력하세요."/>
			</div>
	
			<div class="box">
				<label>상품정보(링크)</label><br>
				<input type="text" name="productLink" size="50" class="box" autocomplete="off" placeholder="내용을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>수량</label><br>
				<input type="text" name="productCnt" size="50" class="box" autocomplete="off" placeholder="숫자을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>단가</label><br>
				<input type="text" name="productCost" size="50" class="box" autocomplete="off" placeholder="금액을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>금액</label><br>
				<input type="text" name="productMoney" size="50" class="box" autocomplete="off" placeholder="금액을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>사유</label><br>
				<input type="text" name="productInfo" size="50" class="box" autocomplete="off" placeholder="내용을 입력하세요."/>
			</div>
			<!-- 
			<div class="box">
				<label>결재선</label><br>
				<div id="box">
					<input type="text" name="approvePerson" size="50" class="box" autocomplete="off" placeholder="내용을 입력하세요."/><input type="button" value="추가" onclick="add_textbox();" />
				</div>
			</div>
			 -->
			<div id="app_btn" class="box">
				<button type="button"  class="app_btn" onclick="goEpuipment()">신청하기</button>
				<button type="button"  class="app_btn" onclick="cancel()">취소</button>
				<!-- history.back(); -->
			</div>

	
		</form>
	
</div>

</body>
</html>