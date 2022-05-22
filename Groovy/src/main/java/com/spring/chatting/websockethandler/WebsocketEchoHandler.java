package com.spring.chatting.websockethandler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.service.InterLimshService;

public class WebsocketEchoHandler extends TextWebSocketHandler {
	
	@Bean
	public ServletServerContainerFactoryBean createWebSocketContainer() {
		ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
		container.setMaxTextMessageBufferSize(500000);
		container.setMaxBinaryMessageBufferSize(500000);
		return container;
	}
	
	// === 웹소켓서버에 연결한 클라이언트 사용자들을 저장하는 리스트 === //
	private List<WebSocketSession> connectedUsers = new ArrayList<>();
	
	// === <loginuser.getPk_empnum(), wsession.getId()> === //
	private Map<Object, Object> connectedUsersId = new HashMap<>();
	
	// 웹소켓에서 파일 전송하기
	private static final String FILE_UPLOAD_PATH = "C:/";	// 파일 업로드 경로
	static int fileUploadIdx = 0;
	static String fileUploadSession = "";
	
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

	//	System.out.println("====> 웹채팅확인용 : " + wsession.getId() + "님이 접속했습니다.");
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
		String connectingUserName = "「";	// "「"은 자음 ㄴ을 하면 나온다.
        
        for (WebSocketSession webSocketSession : connectedUsers) {
            Map<String, Object> map = webSocketSession.getAttributes();
            /*
               webSocketSession.getAttributes(); 은 
               HttpSession에 setAttribute("키",오브젝트); 되어 저장되어진 값들을 읽어오는 것으로써,
                                  리턴값은  "키",오브젝트로 이루어진 Map<String, Object> 으로 받아온다.
            */ 
            EmployeeVO loginuser = (EmployeeVO)map.get("loginuser");  
            // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
            
            connectingUserName += loginuser.getName()+" "; 
            
        //    System.out.println("loginuser.getPk_empnum() => " + loginuser.getPk_empnum());
        //    System.out.println("webSocketSession.getId() => " + webSocketSession.getId());
            
            connectedUsersId.put(loginuser.getPk_empnum(), webSocketSession.getId());
        }// end of for--------------------
        
        connectingUserName += "」";
        
    //  System.out.println("확인용 connectingUserName : " + connectingUserName);
		// 확인용 connectingUserName : 「임성희 이순신 」
        
        for(WebSocketSession webSocketSession : connectedUsers) {
        	webSocketSession.sendMessage(new TextMessage(connectingUserName));
        } // end of for
        
        ///// ===== 웹소켓 서버에 접속시 접속자명단을 알려주기 위한 것 끝 ===== /////
	}
	
	// === 클라이언트가 웹소켓 서버로 메시지를 보냈을때의 Send 이벤트를 처리하기 ===
    /*
        handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드는 
                  클라이언트가 웹소켓서버로 메시지를 전송했을 때 자동으로 호출되는(실행되는) 메소드이다.
                  첫번째 파라미터  WebSocketSession 은  메시지를 보낸 클라이언트임.
                  두번째 파라미터  TextMessage 은  메시지의 내용임.
    */
	@Override
	public void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception {
		// >>> 파라미터 WebSocketSession wsession은  웹소켓서버에 접속한 클라이언트임. <<<
        // >>> 파라미터 TextMessage message 은  클라이언트 사용자가 웹소켓서버로 보낸 웹소켓 메시지임. <<<
		
		Map<String, Object> map = wsession.getAttributes();
		EmployeeVO loginuser = (EmployeeVO)map.get("loginuser");
        // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
        
        MessageVO messageVO = MessageVO.convertMessage(message.getPayload());

   //   System.out.println("~~~~ 확인용 messageVO.getMessage() => " + messageVO.getMessage());
        // ~~~~ 확인용 messageVO.getMessage() => 채팅방에 <span style='color: red;'>입장</span>했습니다
        
     //  System.out.println("~~~~ 확인용 messageVO.getType() => " + messageVO.getType());
        // ~~~~ 확인용 messageVO.getType() => all 또는 one
        
      //  System.out.println("~~~~ 확인용 messageVO.getTo() => " + messageVO.getTo());
        // ~~~~ 확인용 messageVO.getTo() => all 또는 1a
        
        Date now = new Date(); // 현재시각 
        String currentTime = String.format("%tp %tl:%tM",now,now,now); 
        // %tp              오전, 오후를 출력
        // %tl              시간을 1~12 으로 출력
        // %tM              분을 00~59 으로 출력
        
        for(WebSocketSession webSocketSession : connectedUsers) {
        	
        //	System.out.println(messageVO.getType());
        	
        	if("all".equals(messageVO.getType())) {
        		// 채팅할 대상이 "전체" 일 경우
                // 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보냄.
        		
        		if(!wsession.getId().equals(webSocketSession.getId())) {
        			// wsession 은 메시지를 보낸 클라이언트임.
                    // webSocketSession 은 웹소켓서버에 연결된 모든 클라이언트중 하나임.
                    // wsession.getId() 와  webSocketSession.getId() 는 자동증가되는 고유한 값으로 나옴
        			
        			webSocketSession.sendMessage(
        				new TextMessage("<span style='display: none;'>"+wsession.getId()+"</span>&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getName()+ "</span>]<br><div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all;'>"+ messageVO.getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+currentTime+"</div> <div>&nbsp;</div>")
        																																																																																		/* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
        			);
        		}
        	}
        	else { // 채팅할 대상이 "전체"가 아닌 특정대상(귓속말대상웹소켓.getId())인 경우
        		
        		String ws_id = (String)connectedUsersId.get(messageVO.getTo());
        		
        	//	System.out.println("확인용 ws_id => " + ws_id);
        	
        		if(webSocketSession.getId().equals(ws_id) && !wsession.getId().equals(webSocketSession.getId())) {
	        		webSocketSession.sendMessage(
	        			new TextMessage("<span style='display: none;'>"+wsession.getId()+"</span>&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getName()+ "</span>]<br><div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>"+ messageVO.getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+currentTime+"</div> <div>&nbsp;</div>")
	        																																																																									/* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
	    			);
	        		break;
        		}
        	}
        }
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
	
	
	// 파일 전송을 위한 메소드
	@Override
	public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		//바이너리 메시지 발송
		ByteBuffer byteBuffer = message.getPayload();
		String fileName = "test.jpg";
		File dir = new File(FILE_UPLOAD_PATH);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		File file = new File(FILE_UPLOAD_PATH, fileName);
		FileOutputStream out = null;
		FileChannel outChannel = null;
		try {
			byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
			out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다.
			outChannel = out.getChannel(); //채널을 열고
			byteBuffer.compact(); //파일을 복사한다.
			outChannel.write(byteBuffer); //파일을 쓴다.
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(out != null) { out.close(); }
				if(outChannel != null) { outChannel.close(); }
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		byteBuffer.position(0); //파일을 저장하면서 position값이 변경되었으므로 0으로 초기화한다.
		//파일쓰기가 끝나면 이미지를 발송한다.
		for (WebSocketSession webSocketSession : connectedUsers) {
			try {
				webSocketSession.sendMessage(new BinaryMessage(byteBuffer));
			} catch(IOException e) {
				e.printStackTrace();
			}
        }// end of for------------------------------------------
	}
	
}
