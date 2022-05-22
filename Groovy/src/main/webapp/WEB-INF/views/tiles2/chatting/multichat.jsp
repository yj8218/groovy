<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	#sidebar {
	    display: none;
	    position: fixed;
	    top: 0;
	    right: 0;
	    background-color: white;
	    width: 300px;
	    height: 100vh;
	    text-align: center;
	    padding: 20px;
	}
	 
	.emphasized { box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;}
	
	.scrollover { -ms-overflow-style: none; } 
	.scrollover::-webkit-scrollbar { display:none; }

	.msgImg{
		width: 150px;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		// 웹브라우저의 주소창의 포트까지 가져옴
		const url = window.location.host;
		//const url = 'localhost:9090';
	//	alert("url : " + url);
		// url : 221.155.187.235:9090
		
		// '/' 부터 오른쪽에 있는 모든 경로
		const pathname = window.location.pathname;
	//	alert("pathname : " + pathname);
		// pathname : /board/chatting/multichat.action
		
		// "전체 문자열".lastIndexOf("검사할 문자"); 
		const appCtx = pathname.substring(0, pathname.lastIndexOf("/"));
	//	alert("appCtx : " + appCtx);
		// appCtx : /groovy/chatting
		
		const root = url + appCtx;
	//	alert("root : " + root);
		// root : 221.155.187.235:9090/groovy/chatting
		
		// 웹소켓통신을 하기 위해서는 http://을 사용하는 것이 아니라 ws://을 사용해야 한다.
		// "/multichatstart.action"에 대한 것은 /WEB-INF/spring/config/websocketContext.xml 파일에 있는 내용이다.
		const wsUrl = "ws://" + root + "/multichatstart.groovy";

	//	alert("wsUrl : " + wsUrl);
		// wsUrl : ws://221.155.187.235:9090/board/chatting/multichatstart.groovy
		
		const websocket = new WebSocket(wsUrl);
		// 즉, const websocket = new WebSocket(ws://221.155.187.235:9090/board/chatting/multichatstart.action); 이다.
		
		// >> ====== !!중요!! Javascript WebSocket 이벤트 정리 ====== << //
	   	/*   
	   		-------------------------------------
	                  이벤트 종류               설명
	        -------------------------------------
	        onopen        WebSocket 연결
	        onmessage     메시지 수신
	        onerror       전송 에러 발생
	        onclose       WebSocket 연결 해제
	    */   
	    
	   	let messageObj = {};	// 자바스크립트 객체 생성함.
	   	
	   	// === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
	   	websocket.onopen = function() {
	   		
	   		if(${requestScope.isPersonalChat}) {
		   		messageObj = {message : "채팅방에 입장했습니다",
		   					  type: "one",
		   					  to: "${requestScope.pk_empnum}"};	// 자바스크립트에서 객체의 데이터값 초기화
			}
			else {
				messageObj = {message : "채팅방에 입장했습니다",
							  type : "all",
							  to : "all"};
			}
	   		
	   		websocket.send(JSON.stringify(messageObj));
	   		// JSON.stringify(자바객체) 는 자바객체를 JSON 표기법의 문자열(string)로 변환한다
	   	};
	   	
	   	// === 메시지 수신시 콜백함수 정의하기 === //
	   	websocket.onmessage = function(event) {
	   		
	   		if(event.data != null && event.data.type != '') {
		   		// event.data는 수신되어진 메시지이다. 즉, 지금은「엄정화 이순신 」 이다.
		        if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") { 
		            $("div#connectingUserList").html(event.data);
		        }
		        else {
		        	// event.data 는 수신받은 채팅 문자이다.
		            $("div#chatMessage").append(event.data);
		            $("div#chatMessage").append("<br/>");
		            $("div#chatMessage").scrollTop(99999999);
		        }
	   		}
	   		else { // 파일 업로드한 경우 업로드한 파일을 채팅방에 보여준다.
	   			
	   		// 위에서 자신이 보낸 메시지를 웹소켓으로 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다.
                const now = new Date();
                let ampm = "오전 ";
                let hours = now.getHours();
                
                if(hours > 12) {
                   hours = hours - 12;
                   ampm = "오후 ";
                }
                
                if(hours == 0) {
                   hours = 12;
                }
                
                if(hours == 12) {
                   ampm = "오후 ";
                }
                
                let minutes = now.getMinutes();
              	if(minutes < 10) {
                 	minutes = "0"+minutes;
              	}
              
                const currentTime = ampm + hours + ":" + minutes;
	   			
	   			var url = URL.createObjectURL(new Blob([event.data]));
	   			let html = "<div style='display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'><img class='msgImg' src='" + url + "'></div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>";
	   			$("div#chatMessage").append(html);
	            $("div#chatMessage").append("<br/>");
	            $("div#chatMessage").scrollTop(99999999);
	            $("input#fileUpload").val("");
	            
	            $("#sidebar").hide();
	            $("#sidebar").removeClass("emphasized");
	   		}
	   	};
	   	
	   	// === 웹소켓 연결 해제시 콜백함수 정의하기 === //
		websocket.onclose = function() {
	   		
	   	};	   	
	   	
	   	// === 메시지 입력후 엔터하기 === //
	   	$("input#message").keyup(function(key) {
	   		if(key.keyCode == 13) {
	   			$("input#btnSendMessage").click();
	   		}
	   	});
	   	
	   	// === 메시지 보내기 === //
	   	$("input#btnSendMessage").click(function() {
	   		
	   		if($("input#message").val() != "") {
	   			
	   			// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
                // 자바스크립트에서 replaceAll 은 없다.
                // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
                // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
                
                let messageVal = $("input#message").val();
	   			messageVal = messageVal.replace(/<script/gi, "&lt;script");
	   			// 스크립트 공격을 막으려고 한 것임.
	   			
	   			if(${requestScope.isPersonalChat}) {
			   		messageObj = {message : messageVal,
			   					  type: "one",
			   					  to: "${requestScope.pk_empnum}"};	// 자바스크립트에서 객체의 데이터값 초기화
				}
				else {
					messageObj = {message : messageVal,
								  type : "all",
								  to : "all"};
				}
	   			
	   			websocket.send(JSON.stringify(messageObj));
	   			// JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다.
	   			
	   			// 위에서 자신이 보낸 메시지를 웹소켓으로 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다.
                const now = new Date();
                let ampm = "오전 ";
                let hours = now.getHours();
                
                if(hours > 12) {
                   hours = hours - 12;
                   ampm = "오후 ";
                }
                
                if(hours == 0) {
                   hours = 12;
                }
                
                if(hours == 12) {
                   ampm = "오후 ";
                }
                
                let minutes = now.getMinutes();
              	if(minutes < 10) {
                 	minutes = "0"+minutes;
              	}
              
                const currentTime = ampm + hours + ":" + minutes;
                
               	$("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
                
                $("div#chatMessage").scrollTop(999999999);
                $("input#message").val("");
                $("input#message").focus();
	   		}
	   	}); // end of $("input#btnSendMessage").click(function() {})
	   	
	   	///////////////////////////////////////////////////////////////////////////////
		
		var target = $("#sidebar");
		// 메뉴버튼 클릭시 사이드바 보이기
		$(document).on("click", "#chatMenu", function(e) {
			target.show();
			target.addClass("emphasized");
		});
		
		// 사이드바 외부 클릭시 사이드바 감추기
		$(document).mouseup(function(e) {
			if($("#sidebar").has(e.target).length == 0) {
				target.hide();
				target.removeClass("emphasized");
			}
		});
	   	
		
		// 파일 전송하기
		$("#btnSendFile").click(function() {
			var file = document.querySelector("#fileUpload").files[0];
			var fileReader = new FileReader();
			fileReader.onload = function() {
				var param = {
					type: "fileUpload",
					file: file,
					message: "파일을 전송합니다",
					to: "all"
				};
				
			    arrayBuffer = this.result;
			
				console.log(arrayBuffer);
				websocket.send(arrayBuffer); //파일 소켓 전송
			};
			fileReader.readAsArrayBuffer(file);
		}); // end of $("#btnSendFile").click(function() {})
		
	}); // end of $(document).ready(function() {})
	
	
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10 offset-md-1">
		
			<!-- 상단바 -->
			<div class="navBox" style="border-bottom: solid 1px lightgray; height: 50px; padding: 10px;">
				<table style="width: 95%; margin: auto; vertical-align: center;">
					<tr>
						<td align="center">
							<c:if test="${requestScope.isPersonalChat eq true}">
								<label class="ml-5" style="font-weight: bold;">개인 채팅방</label>
							</c:if>
							<c:if test="${requestScope.isPersonalChat ne true}">
								<label class="ml-5" style="font-weight: bold;">그룹 채팅방</label>
							</c:if>
						</td>
						<td align="right"><i id="chatMenu" class="fas fa-bars"></i></td>
					</tr>
				</table>
			</div>
			
	<!-- 메뉴바 -->
			<div id="sidebar">
				<nav id="menu">
					
				    <span>현재접속자명단:</span>
				    <div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
				    <br/><br/><br/><br/><br/><br/><br/><br/>
				   <input type="file" id="fileUpload"/>
				   <input type="button" id="btnSendFile" class="btn btn-outline-secondary w-100 mt-2" value="파일 전송" />
				   <br/><br/><br/><br/><br/><br/><br/><br/>
				   <input type="button" class="btn btn-danger btn-sm my-3 mx-3" onClick="javascript:window.close()" value="채팅방나가기" />
				</nav>
			</div>
			
		   
		   <div id="chatMessage" class="scrollover" style="max-height: 500px; overFlow: auto; margin: 10px 0; margin-bottom: 100px;"></div>
			<div id="inputChat" style="background-color: #faf9f9; border-top: solid 1px lightgray; height: 100px; padding: 0 20px; position: fixed; bottom: 0; left: 0; width: 100%; display: table;">	
			   <div style="display: table-cell; vertical-align: middle;">
			   		<input type="text"   id="message" class="form-control" placeholder="메시지 내용" style="padding-right: 50px; height: 50px;"/>
			   		<input type="button" id="btnSendMessage" class="btn btn-outline-secondary btn-sm" value="전송" style="position: absolute; right: 30px; bottom: 32px; height: 35px;"/>
			   </div>
			</div>
		</div>
	</div>
</div>