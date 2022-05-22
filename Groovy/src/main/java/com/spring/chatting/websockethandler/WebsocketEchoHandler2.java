package com.spring.chatting.websockethandler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.service.InterLimshService;

public class WebsocketEchoHandler2 extends TextWebSocketHandler {

	// === 웹소켓서버에 연결한 클라이언트 사용자들을 저장하는 리스트 === //
	private List<WebSocketSession> connectedUsers = new ArrayList<>();
	
	// init-method
	public void init() throws Exception {}
		
	// === 클라이언트가 웹소켓서버에 연결했을때의 작업 처리하기 ===
	/*
      	afterConnectionEstablished(WebSocketSession wsession) 메소드는 
                       클라이언트가 웹소켓서버에 연결이 되어지면 자동으로 실행되는 메소드로서
      	WebSocket 연결이 열리고 사용이 준비될 때 호출되어지는(실행되어지는) 메소드이다.
	*/
	@Override		
	public void afterConnectionEstablished(WebSocketSession wsession) throws Exception {
		
		// >>> 파라미터 WebSocketSession wsession은 웹소켓서버에 접속한 클라이언트 사용자임. <<<
		
		// 웹소켓서버에 접속한 클라이언트의 IP Address 얻어오기
		/*
        	STS 메뉴의 
        	Run --> Run Configuration 
            	--> Arguments 탭
            	--> VM arguments 속에 맨 뒤에
            	--> 한칸 띄우고 -Djava.net.preferIPv4Stack=true을 추가한다.  
		*/
	
	//	System.out.println("====> 웹채팅확인용(ws2) : " + wsession.getId() + "님이 접속했습니다.");
        // ====> 웹채팅확인용 : 0님이 접속했습니다. 
        // ====> 웹채팅확인용 : 1님이 접속했습니다.
        // wsession.getId() 는 자동증가되는 고유한 숫자로 나옴.
		
		connectedUsers.add(wsession);
		
		///// ===== 웹소켓 서버에 접속시 접속자명단을 알려주기 위한 것 시작 ===== /////
        
		// Spring에서 WebSocket 사용시 먼저 HttpSession에 저장된 값들을 읽어와서 사용하기
		/*
                           먼저 /webapp/WEB-INF/spring/config/websocketContext.xml 파일에서
          	websocket:handlers 태그안에 websocket:handshake-interceptors에
            HttpSessionHandshakeInterceptor를 추가하면 WebSocketHandler 클래스를 사용하기 전에 
                           먼저 HttpSession에 저장되어진 값들을 읽어 들여 WebSocketHandler 클래스에서 사용할 수 있도록 처리해준다. 
        */
		String connectingUserName = "<form name='openPersonalChatFrm'><table class='tblEmpList' id='tblEmpList' style='width: 100%;'>";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
            Map<String, Object> map = webSocketSession.getAttributes();
            /*
               webSocketSession.getAttributes(); 은 
               HttpSession에 setAttribute("키",오브젝트); 되어 저장되어진 값들을 읽어오는 것으로써,
                                  리턴값은  "키",오브젝트로 이루어진 Map<String, Object> 으로 받아온다.
            */ 
            EmployeeVO loginuser = (EmployeeVO)map.get("loginuser");  
            // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
            
            connectingUserName += "<tr style='border-bottom: solid 1px #eee;'>";
            connectingUserName += "		<td class='empProfile' style='cursor: pointer;' onclick='javascript:showEmpProfile(\""+loginuser.getPk_empnum()+"\")'>";
            connectingUserName += "			<img class='my-2 mr-2' src='/groovy/resources/images/프로필사진/"+ loginuser.getEmppicturename() +"' style='border-radius: 15px;'>";
            connectingUserName += "			<span class='name font-weight-bold'>" + loginuser.getName() + "</span>";
            connectingUserName += "			<input type='hidden' id='pk_empnum' name='pk_empnum' value='" + loginuser.getPk_empnum() + "'/>";
            connectingUserName += "			<input type='hidden' name='isPersonalChat' value='true' />";
            connectingUserName += "		</td>";
            connectingUserName += "		<td align='right'>";
            connectingUserName += "			<i class='far fa-comment-dots fa-lg' onclick='javascript:openPersonalChat(\""+loginuser.getPk_empnum()+"\")'></i>";
            connectingUserName += "		</td>";
            connectingUserName += "</tr>";
        }// end of for--------------------
        
        connectingUserName += "</table></form>";
        
        connectingUserName += "<form name='openGroupChatFrm'>"; 
        connectingUserName += "		<input type='hidden' name='pk_empnum' value='all'/>";
        connectingUserName += "		<input type='hidden' name='isPersonalChat' value='false'/>";
        connectingUserName += "</form>";
        
    //  System.out.println("확인용 connectingUserName : " + connectingUserName);
        
        for(WebSocketSession webSocketSession : connectedUsers) {
        	webSocketSession.sendMessage(new TextMessage(connectingUserName));
        } // end of for
        
        ///// ===== 웹소켓 서버에 접속시 접속자명단을 알려주기 위한 것 끝 ===== /////
	}
	
	
	// === 클라이언트가 웹소켓서버와의 연결을 끊을때 작업 처리하기 ===
	/*
       	afterConnectionClosed(WebSocketSession session, CloseStatus status) 메소드는 
                 클라이언트가 연결을 끊었을 때 
                 즉, WebSocket 연결이 닫혔을 때(채팅페이지가 닫히거나 채팅페이지에서 다른 페이지로 이동되는 경우) 자동으로 호출되어지는(실행되어지는) 메소드이다.
    */
	@Override
    public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) throws Exception {
        // 파라미터 WebSocketSession wsession 은 연결을 끊은 웹소켓 클라이언트임.
        // 파라미터 CloseStatus 은 웹소켓 클라이언트의 연결 상태.
       
		Map<String, Object> map = wsession.getAttributes();
		EmployeeVO loginuser = (EmployeeVO)map.get("loginuser");
       
		connectedUsers.remove(wsession);
		// 웹소켓 서버에 연결되어진 클라이언트 목록에서 연결은 끊은 클라이언트는 삭제시킨다.
       
        for (WebSocketSession webSocketSession : connectedUsers) {
           
        	// 퇴장했다라는 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보내도록 한다.
        	if (!wsession.getId().equals(webSocketSession.getId())) { 
                webSocketSession.sendMessage(
                   new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [<span style='font-weight:bold;'>" +loginuser.getName()+ "</span>]" + "님이 <span style='color: red;'>퇴장</span>했습니다.")
                ); 
            }
        }// end of for------------------------------------------
       
 //     System.out.println("====> 웹채팅확인용 : 웹세션ID " + wsession.getId() + "이 퇴장했습니다.");
        
        
        ///// ===== 접속을 끊을시 접속자명단을 알려주기 위한 것 시작 ===== /////
        String connectingUserName = "「";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
            Map<String, Object> map2 = webSocketSession.getAttributes();
            EmployeeVO loginuser2 = (EmployeeVO)map2.get("loginuser");  
           // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
   
            connectingUserName += loginuser2.getName()+" "; 
        }// end of for------------------------------------------
        
        connectingUserName += "」";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
            webSocketSession.sendMessage(new TextMessage(connectingUserName));
        }// end of for------------------------------------------
        ///// ===== 접속을 끊을시 접속자명단을 알려주기 위한 것 끝 ===== /////
        
    }
	
}
