<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		// 웹브라우저의 주소창의 포트까지 가져옴
		const url = window.location.host;
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
	   		
	   	//	alert("웹소켓 연결됨!!");
	   		
	   		$("div#chatStatus").text("정보: 웹소켓이 연결이 성공됨!!");
	   	/*	
	   		messageObj = {};	// 초기화
	   		messageObj.message = "채팅방에 <span style='color: red;'>입장</span> 했습니다";
	   		messageObj.type = "all";
	   		messageObj.to = "all";
	   	*/
	   		// 또는
	   		messageObj = {message : "채팅방에 <span style='color: red;'>입장</span> 했습니다",
	   					  type: "all",
	   					  to: "all"};	// 자바스크립트에서 객체의 데이터값 초기화
	   					  
	   		websocket.send(JSON.stringify(messageObj));
	   		// JSON.stringify(자바객체) 는 자바객체를 JSON 표기법의 문자열(string)로 변환한다
            /*
               	JSON.stringify({});                  // '{}'
         		JSON.stringify(true);                // 'true'
         		JSON.stringify('foo');               // '"foo"'
         		JSON.stringify([1, 'false', false]); // '[1,"false",false]'
         		JSON.stringify({ x: 5 });            // '{"x":5}'
            */
	   	};
	   	
	   	// === 메시지 수신시 콜백함수 정의하기 === //
	   	websocket.onmessage = function(event) {
	   		
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
	   	let isOnlyOneDialog = false;	// 귓속말 여부. true면 귓속말, false면 모두에게 공개
	   	
	   	$("input#btnSendMessage").click(function() {
	   		
	   		if($("input#message").val() != "") {
	   			
	   			// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
                // 자바스크립트에서 replaceAll 은 없다.
                // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
                // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
                
                let messageVal = $("input#message").val();
	   			messageVal = messageVal.replace(/<script/gi, "&lt;script");
	   			// 스크립트 공격을 막으려고 한 것임.
   			<%--
	   			messageObj = {message : messageVal,
	   						  type : "all",
	   						  to : "all"};
   			--%>
	   			// 또는
	   			messageObj = {};	// 자바스크립트 객체 생성함.
	   			messageObj.message = messageVal;
	   			messageObj.type = "all";
	   			messageObj.to = "all";
	   			
	   			const to = $("input#to").val();
	   			if(to != "") {
	   				messageObj.type = "one";
	   				messageObj.to = to;
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
                
                if(isOnlyOneDialog == false) { // 귓속말이 아닌 경우
                	$("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
                																																							/* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */			
                }
                else { // 귓속말인 경우. 글자색을 빨간색으로 함.
                	$("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
																																											/* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
                }
                
                $("div#chatMessage").scrollTop(999999999);
                
                $("input#message").val("");
                $("input#message").focus();
	   		}
	   		
	   	});
	   	
	   	///////////////////////////////////////////////////////////////////////////////
	   	
	   	// 귓속말대화끊기 버튼은 처음에는 보이지 않도록 한다.
	   	$("button#btnAllDialog").hide();
	   	
	   	// 아래는 귓속말을 위해서 대화를 나누는 상대방의 이름을 클릭하면 상대방이름의 웹소켓id 를 알아와서 input태그인 귓속말대상웹소켓.getId()에 입력하도록 하는 것.
	   	$(document).on("click", ".loginuserName", function() {
	   		
	   	/* 
	   		class loginuserName 은 
        	com.spring.chatting.websockethandler.WebsocketEchoHandler 의 
        	public void handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드내에
        	162번 라인에 기재해두었음.
     	*/
	   		const ws_id = $(this).prev().text();
	   		alert(ws_id);
	   		$("input#to").val(ws_id);
	   		
	   		$("span#privateWho").text($(this).text());
	   		$("button#btnAllDialog").show();
	   		$("input#message").css({'background-color':'black', 'color':'white'});
	   		$("input#message").attr("placeholder", "귓속말 메시지 내용");
	   		
	   		isOnlyOneDialog = true;	// 귓속말 대화임을 지정
	   	});
	   	
		// 귓속말대화끊기 버튼을 클릭한 경우에는 전체대상으로 채팅하겠다는 말이다.
		$("button#btnAllDialog").click(function() {
			$("input#to").val("");
			$("span#privateWho").text("");
			$("input#message").css({'background-color':'', 'color':''});
			$("input#message").attr("placeholder", "메시지 내용");
			$(this).hide();
			
			isOnlyOneDialog = false;	// 귓속말 대화가 아닌 모두에게 공개되는 대화임을 지정.
		});
	   	
	}); // end of $(document).ready(function() {})
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10 offset-md-1">
		
			<!-- 상단바 -->
			<div style="border-bottom: solid 1px lightgray; height: 50px; padding: 10px;">
				<table style="width: 95%; margin: auto; vertical-align: center;">
					<tr>
						<td align="left"><i id="chatSearch" class="fas fa-search"></i></td>
						<td align="center" style="font-weight: bold;">
							${requestScope.name}
							<!-- 1:n 채팅인 경우 채팅 인원 표시 (인원수) -->
						</td>
						<td align="right"><i id="chatMenu" class="fas fa-bars" onclick="openChatMenuBar()"></i></td>
					</tr>
				</table>
			</div>
			
			<!-- 메뉴바 
			<div id="chatMenuBar">
				<article action="" class="form-container">
					<h6>메뉴바에 들어갈 기능들</h6>
					<ul>
						<li>새채팅</li>
						<li>채팅 참여자 목록</li>
						<li>채팅 나가기<i class="fas fa-times"></i></li>
					</ul>
				</article>
			</div>
			-->
					
			<input type="button" class="btn btn-danger btn-sm my-3 mx-3" onClick="javascript:window.close()" value="채팅방나가기" />
		   <div id="chatStatus"></div>
		   <input type="hidden" id="to" placeholder="귓속말대상웹소켓.getId()"/>
		   <br/>
		          ♡ 귓속말대상 : <span id="privateWho" style="font-weight: bold; color: red;"></span>
		   <br>
		   <button type="button" id="btnAllDialog" class="btn btn-secondary btn-sm">귓속말대화끊기</button>
		   <br><br>
		       현재접속자명단:<br/>
		   <div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
		   
		   <div id="chatMessage" style="max-height: 500px; overFlow: auto; margin: 20px 0;"></div>
			<div id="inputChat" style="background-color: #faf9f9; border-top: solid 1px lightgray; height: 100px; padding: 0 20px; position: fixed; bottom: 0; left: 0; width: 100%; display: table;">	
			   <div style="display: table-cell; vertical-align: middle;">
			   		<input type="text"   id="message" class="form-control" placeholder="메시지 내용" style="padding-right: 50px; height: 50px;"/>
			   		<input type="button" id="btnSendMessage" class="btn btn-outline-secondary btn-sm" value="전송" style="position: absolute; right: 30px; bottom: 32px; height: 35px;"/>
			   </div>
			</div>
		</div>
	</div>
</div>