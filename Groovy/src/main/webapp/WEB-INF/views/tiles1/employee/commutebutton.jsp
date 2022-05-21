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
	
	$("#time_startwork").text('${requestScope.WorkTime.startwork}');
	$("#time_endwork").text('${requestScope.WorkTime.endwork}');
	
	if('${requestScope.WorkTime.endwork}' !=  ''){
		// 퇴근 또 못찍게 버튼 막기, 스톱워치 그만
		$("button#endBtn").attr("disabled", true);
		
	}
	/////////////////////////////////////////////////////////
	
	
	const stopwatch = document.getElementById("stopwatch");
	
	// 스톱워치 기록을 유지시켜주는 용도
	$.ajax({
		url:"<%=ctxPath%>/getStartWorkTime.groovy",
		type:"POST",
		dataType:"JSON",
		success:function(json){
//			alert(json.startWorkTime.startwork);
			// 13:11:10
			
			let startWorkTime = json.startWorkTime.startwork; // 출근 시각
			let endWorkTime = json.startWorkTime.endwork; // 퇴근 시각
			
			if(startWorkTime != null){
			
				const startWorkTime_hh = startWorkTime.substr(0,2);
				const startWorkTime_mi = startWorkTime.substr(3,2);
				const startWorkTime_ss = startWorkTime.substr(6,2);
				
				const endWorkTime_hh = endWorkTime.substr(0,2);
				const endWorkTime_mi = endWorkTime.substr(3,2);
				const endWorkTime_ss = endWorkTime.substr(6,2);
				
				startworktime = new Date(); // 출근 시각 Date() 객체
				
				startworktime.setHours(startWorkTime_hh, startWorkTime_mi, startWorkTime_ss);
				// Sat May 21 2022 13:11:10 GMT+0900 (한국 표준시)
				
				// 현재시각과 출근시각 차이 구하기
				const now = new Date(); // 현재 시각 Date() 객체
				
				let gaptimegapBySec = (now.getTime() - startworktime.getTime())/1000; // 초단위
				time = gaptimegapBySec;
				
				if (timerId != null) {
			        clearTimeout(timerId);
			    }
				
				if(endWorkTime != null){// 퇴근기록이 있으면 스톱워치 멈춤
					endWorkTime = new Date();
					endWorkTime.setHours(endWorkTime_hh, endWorkTime_mi, endWorkTime_ss);
					
					gaptimegapBySec = (endWorkTime.getTime() - startworktime.getTime())/1000; // 초단위
					time = gaptimegapBySec;
					
					printTime();
					stopClock();
				}else{// 퇴근기록이 없으면 스톱워치 계속
					startClock();
				}
			}
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});
	
	
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
	
	$.ajax({
		url:"<%=ctxPath%>/startWork.groovy",
		data:{"pk_empnum":"${sessionScope.loginuser.pk_empnum}" },
		type:"POST",
		dataType:"JSON",
		success:function(json){
			
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
	
	///////////////////////
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
//	console.log("timerId =>"+timerId);
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
        <button id="start" onclick="startClock()" style="visibility: hidden ;">start</button>
        <button id="stop" onclick="stopClock()" style="visibility: hidden;">stop</button>
        <button id="reset" onclick="resetClock()" style="visibility: hidden;">reset</button>
    </div>
    
    
    
	<button id="startBtn" onclick="javascript:startwork('${sessionScope.loginuser.pk_empnum}'); ">출근</button>
	<button id="endBtn" onclick="javascript:endwork('${sessionScope.loginuser.pk_empnum}'); ">퇴근</button>
	
	출근시각: <span id="time_startwork"></span>
	퇴근시각: <span id="time_endwork"></span>
</div>
</div>
</div>