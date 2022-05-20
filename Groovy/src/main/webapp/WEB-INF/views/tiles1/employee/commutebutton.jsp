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
let timerId;
let time = 0;

let  hour, min, sec;

$(document).ready(function(){
	const stopwatch = document.getElementById("stopwatch");
	
	/////////////////////////////////////////////////////////
	
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
//	alert("출근");
	$.ajax({
		url:"<%=ctxPath%>/startWork.groovy",
		data:{"pk_empnum":"${sessionScope.loginuser.pk_empnum}" },
		type:"POST",
		dataType:"JSON",
		success:function(json){
			// reload 함으로써 isClickedStartBtn.groovy를 통해 출근 버튼도 막히고, isStartWorkClicked = true 가 되서 퇴근 버튼도 바로 찍히게 된다.
		//	location.reload();
			
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
					
					let today = new Date();   

					let hours = today.getHours(); // 시
					let minutes = today.getMinutes();  // 분
					let seconds = today.getSeconds();  // 초
					let milliseconds = today.getMilliseconds(); // 밀리초
					let html = hours + ':' + minutes + ':' + seconds + ':' + milliseconds;
					$("#time_startwork").html(html);
					

					
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		          }
			});
			
			
			// 출근 시각에 대한 근태체크
			startCommuteCheck();
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});
	//////////////////
	document.getElementById("start").onclick();
}


function startCommuteCheck(){
//	alert("출근 근태 체크");
	
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
				let today = new Date();   

				let hours = today.getHours(); // 시
				let minutes = today.getMinutes();  // 분
				let seconds = today.getSeconds();  // 초
				let milliseconds = today.getMilliseconds(); // 밀리초
				
				let html = hours + ':' + minutes + ':' + seconds + ':' + milliseconds;
				$("#time_endwork").html(html);
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
		});
		
		// 퇴근 또 못찍게 버튼 막기
		$("button#endBtn").attr("disabled", true);
		
		
	}
	
//	alert("퇴근");
	document.getElementById("stop").onclick();
}

function printTime() {
    time++;
    stopwatch.innerText = getTimeFormatString();
}

//시계 시작 - 재귀호출로 반복실행
function startClock() {
    printTime();
    stopClock();
    timerId = setTimeout(startClock, 1000);
}

//시계 중지
function stopClock() {
	console.log("timerId =>"+timerId);
    if (timerId != null) {
        clearTimeout(timerId);
    }
}

// 시계 초기화
function resetClock() {
    stopClock()
    stopwatch.innerText = "00:00:00";
    time = 0;
}

// 시간(int)을 시, 분, 초 문자열로 변환
function getTimeFormatString() {
    hour = parseInt(String(time / (60 * 60)));
    min = parseInt(String((time - (hour * 60 * 60)) / 60));
    sec = time % 60;

    return String(hour).padStart(2, '0') + ":" + String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
}
</script>

<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">
<div style="margin: 100px">
<h1 id="stopwatch" >
        00:00:00
    </h1>
    <div>
        <button id="start" onclick="startClock()" style="visibility: hidden;">start</button>
        <button id="stop" onclick="stopClock()" style="visibility: hidden;">stop</button>
        <button id="reset" onclick="resetClock()" style="visibility: hidden;">reset</button>
    </div>
    
    
    
	<button id="startBtn" onclick="javascript:startwork('${sessionScope.loginuser.pk_empnum}'); ">출근</button>
	<button id="endBtn" onclick="javascript:endwork('${sessionScope.loginuser.pk_empnum}'); ">퇴근</button>
	
	<span id="time_startwork"></span>
	<span id="time_endwork"></span>
</div>
</div>
</div>