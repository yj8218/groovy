<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.net.InetAddress" %>    
    
<%
   	String ctxPath = request.getContextPath();

	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	
	int portnumber = request.getServerPort();
	
	String serverName = "http://" + serverIP + ":" + portnumber;
%>


<script type="text/javascript">

	$(document).ready(function() {
		
		
		
		
		
		
 		if(localStorage.getItem("keep") != null){
		       var gab   = localStorage.getItem("keep");
		       $('#pk_empnum').attr('value', gab );
		       $('#keep').attr('checked', "checked");
		} 
		
		$("button#goLogin").click(function(){
			func_Login();
		});
		
		$("input#pwd").keydown(function(event){
			if(event.keyCode == 13){ //엔터를 했을 경우
				func_Login();
			}
				
		});
		// === 로컬스토리지(localStorage)에 저장된 key 가 "saveid" 인 pk_empnum 값을 불러와서 input 태그 pk_empnum 에 넣어주기 === //
		if( $("input:checkbox[id='keep']").prop("checked") ) {
		   localStorage.setItem('keep',$("input#pk_empnum").val());
		}
		else {
		   localStorage.removeItem('keep');
		}
		   
		////////////////////////////////////////////////////////////////////
	/* 	
		// === 로컬스토리지(localStorage)에 저장된 key 가 "saveid" 인 userid 값을 불러와서 input 태그 userid 에 넣어주기 === //
		const loginUserid = localStorage.getItem('keep');
		if(loginUserid != null){
			$("input#pk_empnum").val(loginUserid);
			$("input:checkbox[id='keep']").prop("checked",true);
		} */
		////////////////////////////////////////////////////////////////////
		
	});// end of $(document).ready(function(){})-------------

	
	//Function Declaration
	function func_Login(){
		const pk_empnum = $("input#pk_empnum").val().trim(); 
	//	alert(pk_empnum);
	    const pwd = $("input#pwd").val().trim(); 
	    
	    
	    if(pk_empnum.trim()=="") {
		    alert("사원번호를 입력하세요!!");
		   $("input#pk_empnum").val(""); 
		   $("input#pk_empnum").focus();
		   return; // 종료 
		}
		
		if(pwd.trim()=="") {
		   alert("비밀번호를 입력하세요!!");
		   $("input#pwd").val(""); 
		   $("input#pwd").focus();
		   return; // 종료 
		}
		
		/* if( $("input:checkbox[id='keep']").prop("checked") ) {
		    localStorage.setItem('keep',$("input#pk_empnum").val());
		}
		else {
		    localStorage.removeItem('keep');
		} */
		
		// 체크박스 선택 유무에 따라 아이디 저장 여부
	    if( $("input:checkbox[id='keep']").prop("checked") ){ 
		//  alert("아이디저장 체크를 하셨네요");
		
		   	localStorage.setItem('keep',$("input#pk_empnum").val());
	    }
	    else{
	    //	alert("아이디저장 체크를 해제 하셨네요");
	    	localStorage.removeItem('keep');
	    }
		<%-- <%= serverName %> --%>
		const frm = document.loginFrm;
		frm.action = "<%= ctxPath%>/loginEnd.groovy",
		frm.method = "POST";
		frm.submit();
		
	}//end of furnction func_Login()----------
	
	
</script>


<div class="container">
   <div class="logo">
       <img class="logo" src="<%= ctxPath %>/resources/images/common/logo.png" />
   </div>
   <h1 align="center">로그인</h1>
       <form name="loginFrm">
         <div id = "IdPasswd">
            <input type="text" id="pk_empnum" class="LOGIN" name="pk_empnum" size="30" placeholder="아이디(사원번호)" ><br><br>
         
            <input type="password" id="pwd" class="LOGIN" name="pwd" size="30" placeholder="비밀번호"><br><br>
         </div>
         <div id = "link">
            <!-- <a href="">사원번호 찾기</a>&nbsp; -->
            <a href="<%= ctxPath%>/findpwd.groovy">비밀번호 찾기</a>&nbsp;
           <!--  <a href="">회원가입</a><br> -->
         </div>
         <div id = "loginbutton">
            <button type="button" id="goLogin" >로그인</button>
         </div>
         <div id = "idScan">
            <input type="checkbox" id="keep" class="input_keep" value="off" /><label for="keep" class="input_keep">아이디(사원번호) 저장</label>
         </div>
      </form>
      
</div>