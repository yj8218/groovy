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
		width: 400px;
		height: 500px;
		display: inline-block;
		margin: 20px;
		border-radius: 7px;
		overflow: auto;
		padding: 20px;
		text-align: left;
	}
	
	div#employeeList {
		border: solid 1px grey;
		width: 400px;
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
	
	button.btn_person {
		height: 37px;
		vertical-align: middle;
		background-color: #6449FC; 
		color: white;
		margin-bottom: 7px;
		border: none;
		border-radius: 3px;
		margin-right: 20px;
		width: 100px;
	}
	
	button.btn_person:hover {
		cursor: pointer;
		font-weight: bold;
		color: white;
		background-color: #b3b3ff;
	}
	
	div#btn {
		text-align: center;
	}

	div#body {
		text-align: center;
	}
	
	div.employeeList{
		
	}

	/* 부스트랩 아코디언   */
.accordion {
  padding-left: 20px;
  color: #444;
  cursor: pointer;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  font-weight: bold; 
}

.panel {
  padding: 0 18px;
  display: none;
  background-color: white;
  overflow: hidden;
  text-align: left;
}

a.employee {
	display: block;
	color: black;
}

a.employee:hover {
	text-decoration: none;
	cursor: pointer;
}

div#add_approver {
	margin-bottom: 20px;
}

div#approver, div#reference {
	border: solid 1px grey;
	padding: 10px;
	border-radius: 7px;
	
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

	
	
	
	let html = "";
	let id = 0;
	$("a.employee").click(function () {
		
		if(!($("div#approver").text()).includes($(this).text()) ) {
		
			html +=	"<div id='id"+id+"'>"+$(this).html()+"<input type='button' class='chk_cancel' value='삭제' onclick=\"$('div#id"+id+"').remove()\"/></div><br>";
			id++;
			
			$("div#approver").html(html);
		} else {
			alert("중복하여 등록할 수 없습니다.");		
		}
		
	})

	$("div#approver").html(html);
	
	
}); // end of $(document).ready(function()

function remove() {
	const div = document.getElementById('my_div');
	div.remove();
}		
		
		
function add_approver() {
    const box = document.getElementById("add_approver");
    const newP = document.createElement('p');
    newP.innerHTML = "<input type='text'> <input type='button' value='삭제' onclick='remove_approver(this)'>";
    box.appendChild(newP);
}

function add_reference() {
    const box = document.getElementById("add_reference");
    const newP = document.createElement('p');
    newP.innerHTML = "<input type='text' class='add_approver'> <input type='button' value='삭제' onclick='remove_reference(this)'>";
    box.appendChild(newP);
}

function remove_approver(obj) {
    document.getElementById("add_approver").removeChild(obj.parentNode);
}

function remove_reference(obj) {
    document.getElementById("add_reference").removeChild(obj.parentNode);
}


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
			<div style="font-weight: bold; margin: 20px; font-size: 20px;">회원목록</div>
			<dl>
				<dt class="accordion">회계</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.accountEmployeeList }">
						<a class="employee">
							<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
							<span>${empvo.name }</span>
							<span>(${empvo.pk_empnum })</span>
							<input type="hidden" id="${empvo.pk_empnum }" value="${empvo.pk_empnum }"/>
						</a>
					</c:forEach>	
				</dd>
			</dl>		
			<br>
			<dl>
				<dt class="accordion">영업</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.salesEmployeeList }">
						<a class="employee">
							<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
							<span>${empvo.name }</span>
							<span>(${empvo.pk_empnum })</span>
							<input type="hidden" id="${empvo.pk_empnum }" value="${empvo.pk_empnum }"/>
						</a>
					</c:forEach>
				</dd>
			</dl>
			<br>		
			<dl>
				<dt class="accordion">인사</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.personnelEmployeeList }">
						<a class="employee">
							<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
							<span>${empvo.name }</span>
							<span>(${empvo.pk_empnum })</span>
							<input type="hidden" id="${empvo.pk_empnum }" value="${empvo.pk_empnum }"/>
						</a>
					</c:forEach>	
				</dd>
			</dl>
			<br>		
			<dl>
				<dt class="accordion">총무</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.managerEmployeeList }">
						<a class="employee">
							<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
							<span>${empvo.name }</span>
							<span>(${empvo.pk_empnum })</span>
							<input type="hidden" id="${empvo.pk_empnum }" value="${empvo.pk_empnum }"/>
						</a>
					</c:forEach>	
				</dd>
			</dl>		
			
		</div>
	
		<!-- <div id="inputEmployee">
			<div>승인자(아래로 승인가능)</div>
			<div id="approver">
			    <form>
			        <div id="add_approver" class="box">
			            <input type="text" class="my-3 add_approver"> <input class="btn_add my-3" type="button" value="추가" onclick="add_approver()">
			        </div>
			    </form>
			</div>
			
			<div>참조자</div>
			<div id="reference">
				<form>
			        <div id="add_reference" class="box">
			            <input type="text" class="my-3"> <input class="btn_add my-3" type="button" value="추가" onclick="add_reference()">
			        </div>
			    </form>
			</div>
		</div>
	</div> -->
	
	
		<div id="inputEmployee">
			<label for="approver_chk">승인자</label>
			<div id="approver"></div>
			
			<label for="reference_chk">참조자</label>
			<div id="reference"></div>
		</div>
		
	</div>
		
	<div id="btn">
		<button type="button"  class="btn_person">신청하기</button>
		<button type="button"  class="btn_person" onclick="javascript:window.close()">취소</button>
	</div>

</div>

</body>
</html>