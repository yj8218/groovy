<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctxPath = request.getContextPath();
%>
<style type="text/css">


</style>


<script type="text/javascript">

let isStartWorkClicked = false;

$(document).ready(function(){
	
	// 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지만 확인하는 용도
	$.ajax({
		url:"<%=ctxPath%>/isClickedStartBtn.groovy",
		data:{"pk_empnum":"${sessionScope.loginuser.pk_empnum}" },
		type:"POST",
		dataType:"JSON",
		success:function(json){
		//	alert(json.isClickedStartBtn);
			// 출근버튼 찍었으면 출근버튼 비활성화
			if(json.isClickedStartBtn == 1){// 출근 찍은 경우
				$("button#startBtn").attr("disabled", true);
				isStartWorkClicked = true;
			}
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});
	
	
	
	
});

// function declaration
function startwork(){
	alert("출근");
	$.ajax({
		url:"<%=ctxPath%>/startWork.groovy",
		data:{"pk_empnum":"${sessionScope.loginuser.pk_empnum}" },
		type:"POST",
		dataType:"JSON",
		success:function(json){
			// reload 함으로써 isClickedStartBtn.groovy를 통해 출근 버튼도 막히고, isStartWorkClicked = true 가 되서 퇴근 버튼도 바로 찍히게 된다.
			location.reload();
			// 출근 시각에 대한 근태체크
			startCommuteCheck();
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});
}


function startCommuteCheck(){
	alert("출근 근태 체크");
	
	$.ajax({
		url:"<%=ctxPath%>/checkStartCommuteStatus.groovy",
		data:{"pk_empnum": "${sessionScope.loginuser.pk_empnum}" },
		type:"POST",
		dataType:"JSON",
		success:function(json){
			// 현재 넘어오는 값 없음
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});
	
}



function endwork(){
	
	if(isStartWorkClicked == false){// 출근 버튼을 아직 안누른 상태라면
		alert("출근 안찍음");
		return false;
		
	}else{// 출근 버튼을 누른 경우
		// 자 이제 퇴근합시다
		
		$.ajax({
			url:"<%=ctxPath%>/endWork.groovy",
			data:{"pk_empnum": "${sessionScope.loginuser.pk_empnum}" },
			type:"POST",
			dataType:"JSON",
			success:function(json){
				// 현재 넘어오는 값 없음
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
		});
		
		// 퇴근 또 못찍게 버튼 막기
		$("button#endBtn").attr("disabled", true);
		
		
	}
	
	alert("퇴근");
}


</script>

<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">

	<button id="startBtn" onclick="startwork('${sessionScope.loginuser.pk_empnum}')">출근</button>
	<button id="endBtn" onclick="endwork('${sessionScope.loginuser.pk_empnum}')">퇴근</button>

</div>
</div>