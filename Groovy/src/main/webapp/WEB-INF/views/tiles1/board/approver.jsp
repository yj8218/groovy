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
		width: 60%;
		margin-left: 30px;
		/* margin: 0 auto; */
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
		height: 300px;
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
		height: 800px;
		display: inline-block;
		margin: 20px;
		border-radius: 7px;
		overflow: auto;
		float: left;
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
	
	div#btn_goApprover {
		text-align: center;
		margin-bottom: 70px;
	}

	div#body {
		text-align: center;
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

div.employee {
	display: block;
	color: black;
	margin-left: 20px;
}

a.employee:hover {
	text-decoration: none;
	cursor: pointer;
}

div#add_approver {
	margin-bottom: 20px;
}

div#approver {
	/* border: solid 1px grey; */
	padding: 10px;
	border-radius: 7px;
	
}

div.sort {
	margin: 5px;
}

input.chk_cancel {
	border: none;
	background-color: #6449FC;
	border-radius: 3px;
	color: white;
	
}


div#btn_addApprover, div#btn_addReference {
	display: inline-block;
	width:100px;
	height:300px;
	text-align: center;
	vertical-align: middle;
	margin: auto;
}

div#addPerson {
	display: inline-block;
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

let html = "";
let parent_submit = "";

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

	
	$("button#btn_addApprover").click(function() {
		
		var chk_arr = $("input.employee");
		var chk_data = []; 
		for( var i=0; i<chk_arr.length; i++ ) {
			if( chk_arr[i].checked == true ) { 
				chk_data.push(chk_arr[i].value); 
			} 
		}
		
		let str_approver = chk_data.join(',');
		
		$.ajax({
			  url:"<%= request.getContextPath()%>/addApprover.groovy",
			  data:{"str_approver":str_approver},
			  type:"POST",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  let appEmpList = json.appEmpList;
				  
				  for(let i=0; i<appEmpList.length; i++){
				  
					  html += '<div class="employee">'
						+'<span style="color: blue; font-weight: bold;">['+appEmpList[i].deptnamekor+']</span>'
						+'<span>'+appEmpList[i].name+'</span>'
						+'<span>('+appEmpList[i].pk_empnum+')</span>'
						+'<input type="hidden" class="approver_chk" value="'+appEmpList[i].pk_empnum+'" />'
						+'</div>'
				  
				  }

				  
				  $('div#approver').html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  } 
		        
		  })
		
		  chk_arr.prop("checked", false); 
		  
	});

	 
	// 
	$("button#btn_addReference").click(function() {
		
		var chk_arr = $("input.employee");
		var chk_data = []; 
		for( var i=0; i<chk_arr.length; i++ ) {
			if( chk_arr[i].checked == true ) { 
				chk_data.push(chk_arr[i].value); 
			} 
		}
		
		let str_approver = chk_data.join(',');
		
		$.ajax({
			  url:"<%= request.getContextPath()%>/addApprover.groovy",
			  data:{"str_approver":str_approver},
			  type:"POST",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  let appEmpList = json.appEmpList;
				  
				  for(let i=0; i<appEmpList.length; i++){
				  
					  html += '<div class="employee">'
						+'<span style="color: blue; font-weight: bold;">['+appEmpList[i].deptnamekor+']</span>'
						+'<span>'+appEmpList[i].name+'</span>'
						+'<span>('+appEmpList[i].pk_empnum+')</span>'
						+'<input type="hidden" class="reference_chk" value="'+appEmpList[i].pk_empnum+'" />'
						+'</div>'
				  
				  }

				  
				  $('div#reference').html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  } 
		        
		  })
		
	});
	 
	 
}); // end of $(document).ready(function()
 
 // 신청하기 버튼 클릭 시 
function goApprover() {
	
	let arr_approver_chk = $("input.approver_chk");
	let approver_data = []; 
	for( var i=0; i<arr_approver_chk.length; i++ ) {
		approver_data.push(arr_approver_chk[i].value); 
	}
	
	
	let str_approver_chk = approver_data.join(',');
	let pk_documentnum = $("input#approverDocnum").val();
	
	$.ajax({
		  url:"<%= request.getContextPath()%>/addApproverEnd.groovy",
		  data:{"str_approver_chk":str_approver_chk,
				"pk_documentnum":pk_documentnum  
		  },
		  type:"POST",
		  dataType:"JSON",
		  success:function(json){
			  
			  let success_approver = json.n;
			  
			  if(success_approver>0){
				  console.log(success_approver);
			  } else {
				  alert("승인자 신청에 실패하였습니다.");
			  }
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				const frm = document.documentnumFrm;
				frm.action = "<%= ctxPath%>/cancelApprover.groovy";
				frm.method = "post";
				frm.submit();
		  } 
	        
	  })
	  
	  
	let arr_reference_chk = $("input.reference_chk");
	let reference_data = []; 
	for( var i=0; i<arr_reference_chk.length; i++ ) {
		reference_data.push(arr_reference_chk[i].value); 
	}
	
	
	let str_reference_chk = reference_data.join(',');
	pk_documentnum = $("input#referenceDocnum").val();
	
	$.ajax({
		  url:"<%= request.getContextPath()%>/addReferenceEnd.groovy",
		  data:{"str_reference_chk":str_reference_chk,
				"pk_documentnum":pk_documentnum  
		  },
		  type:"POST",
		  dataType:"JSON",
		  success:function(json){
			  
			  let success_reference = json.n;
			  
			  if(success_reference>0){
				  console.log(success_reference);
			  } else {
				  alert("참조자 신청에 실패하였습니다.");
				  console.log(success_reference);
			  }
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				
				const frm = document.documentnumFrm;
				frm.action = "<%= ctxPath%>/cancelApprover.groovy";
				frm.method = "post";
				frm.submit();
		  } 
	        
	  })

	  
	  alert("신청이 완료되었습니다.");
	  
	  location.href = "<%= ctxPath %>/approvalView.groovy";	
	  
}


// 취소버튼 클릭 시 
function goCancel() {
	
	const frm = document.documentnumFrm;
	frm.action = "<%= ctxPath%>/cancelApprover.groovy";
	frm.method = "post";
	frm.submit();
	
	
}


</script>

</head>
<body>

<div id="container">

	<div id="title">승인 ·참조 대상 설정</div>
	<div id="searchEmployeeList">
		<select class="search">
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
					<c:forEach var="empvo" items="${requestScope.accountEmployeeList }" varStatus="i">
						<div class="employee">
							<input type="checkbox" class="employee" value="${empvo.pk_empnum }" id="acc${i.count }" name="acc${i.count }">
							<label for="acc${i.count }">
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</label>
						</div>
					</c:forEach>	
				</dd>
			</dl>		
			<br>
			<dl>
				<dt class="accordion">영업</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.salesEmployeeList }" varStatus="i">
						<div class="employee">
							<input type="checkbox" class="employee" value="${empvo.pk_empnum }" id="sales${i.count }" name="sales${i.count }">
							<label for="sales${i.count }">
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</label>
						</div>
					</c:forEach>
				</dd>
			</dl>
			<br>		
			<dl>
				<dt class="accordion">인사</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.personnelEmployeeList }" varStatus="i">
						<div class="employee">
							<input type="checkbox" class="employee" value="${empvo.pk_empnum }" id="person${i.count }" name="person${i.count }" >
							<label for="person${i.count }">
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</label>
						</div>
					</c:forEach>	
				</dd>
			</dl>
			<br>		
			<dl>
				<dt class="accordion">총무</dt>
				<dd class="panel">
					<c:forEach var="empvo" items="${requestScope.managerEmployeeList }" varStatus="i">
						<div class="employee">
							<input type="checkbox" class="employee" value="${empvo.pk_empnum }" id="manager${i.count }" name="manager${i.count }" >
							<label for="manager${i.count }">
								<span style="color: blue; font-weight: bold;">[${empvo.deptnamekor }]</span>
								<span>${empvo.name }</span>
								<span>(${empvo.pk_empnum })</span>
							</label>
						</div>
					</c:forEach>	
				</dd>
			</dl>		
			
		</div>
		
		<div id="addPerson">
			<div id="btn_addApprover">
				<button id="btn_addApprover">이동</button>
			</div>
			
			<div id="inputEmployee">
				<form name="approverFrm">
					<label for="approver_chk">승인자</label>
					<div id="approver"></div>
					<input type="hidden" id="approverDocnum" name="pk_documentnum" value="${requestScope.pk_documentnum }"/>
				</form>
			</div>
			<br>
			<div id="btn_addReference">
				<button id="btn_addReference">이동</button>
			</div>
			
			<div id="inputEmployee">
				<form name="referenceFrm">
					<label for="reference_chk">참조자</label>
					<div id="reference"></div>
					<input type="hidden" id="referenceDocnum" name="pk_documentnum" value="${requestScope.pk_documentnum }"/>
				</form>
			</div>
		</div>
	</div>
		
	<div id="btn_goApprover">
		<form name="documentnumFrm">
			<input type="hidden" name="pk_documentnum" value="${requestScope.pk_documentnum }"/>
			<button type="button"  class="btn_person" onclick="goApprover();">신청하기</button>
			<button type="button"  class="btn_person" onclick="goCancel();">취소</button>
		</form>
	</div>

</div>

</body>
</html>