<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>승인 ·참조 대상 설정</title>

<style type="text/css">

	div#container {
		width: 100%;
		margin: 0 auto;
	}

	div#title {
		margin: 20px;
	}

	div#searchEmployeeList {
		margin: 20px;
		text-align: left;
		margin-left: 80px;
	}

	div#inputEmployee {
		border: solid 1px grey;
		width: 300px;
		height: 500px;
		display: inline-block;
		margin: 20px;
		border-radius: 7px;
		overflow: auto;
	}
	
	div#employeeList {
		border: solid 1px grey;
		width: 500px;
		height: 500px;
		display: inline-block;
		margin: 20px;
		border-radius: 7px;
		overflow: auto;
	}
	
	input[name="search"] {
		width: 300px;
		height: 37px;
		border-radius: 7px;
	}
	
	select.search {
		height: 37px;
		border-radius: 7px;
	}
	
	button.search {
		height: 37px;
		vertical-align: middle;
		background-color: #6449FC; 
		color: white;
		margin-bottom: 7px;
		border: none;
		width: 58px;
		border-radius: 3px;
	}
	
	button.search:hover {
		cursor: pointer;
		font-weight: bold;
		color: white;
		background-color: #b3b3ff;
	}
	
	button.btn {
		height: 30px;
		vertical-align: middle;
		background-color: #6449FC; 
		color: white;
		padding-bottom: 3%;
		margin: 10px;
	}
	
	button.btn:hover {
		cursor: pointer;
		font-weight: bold;
		color: white;
		background-color: #b3b3ff;
	}
	
	div#btn {
		text-align: center;
	}

	div#body {
		text-align: left;
	}
	
	div.employeeList{
		
	}

	/* 부스트랩 아코디언   */
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  border: none;
  text-align: left;
  width: 100%;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc; 
}

.panel {
  padding: 0 18px;
  display: none;
  background-color: white;
  overflow: hidden;
  text-align: left;
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
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" >
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css">
   

	<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 

<script type="text/javascript">

$(document).ready(function(){
	
// 회원목록 불러오는 아코디언
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}

});




</script>

</head>
<body>

<div id="container">

	<div id="title">승인 ·참조 대상 설정</div>
	<div id="searchEmployeeList">
		<select class="search">
			<option>부서명</option>
			<option>이름</option>
		</select>
		<input type="text" name="search" >
		<button type="button" class="search" >검색</button>
	</div>
	
	<div id="body">
	
		<div id="employeeList">
			<div>회원목록</div>
			<button class="accordion">회계</button>
					<div class="panel">
						<c:forEach var="empvo" items="${requestScope.accountEmployeeList }">
							<p>
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</p>
						</c:forEach>	
					</div>
			<br>		
			<button class="accordion">영업</button>
					<div class="panel">
						<c:forEach var="empvo" items="${requestScope.salesEmployeeList }">
							<p>
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</p>
						</c:forEach>	
					</div>
			<button class="accordion">인사</button>
					<div class="panel">
						<c:forEach var="empvo" items="${requestScope.personnelEmployeeList }">
							<p>
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</p>
						</c:forEach>	
					</div>
			<button class="accordion">총무</button>
					<div class="panel">
						<c:forEach var="empvo" items="${requestScope.managerEmployeeList }">
							<p>
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</p>
						</c:forEach>	
					</div>
		</div>
	
		<div id="inputEmployee">
			<div>선택된 사람</div>
		</div>
		
	</div>
		
	<div id="btn" class="box">
		<button type="button"  class="btn">신청하기</button>
		<button type="button"  class="btn" onclick="javascript:window.close()">취소</button>
	</div>

</div>

</body>
</html>