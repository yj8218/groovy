<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>


<script type="text/javascript">

	$(document).ready(function() {
		
		$("button#goLogin").click(function(){
			func_Login();
		});
		
		$("input#pwd").keydown(function(event){
			
			if(event.keyCode == 13){ //엔터를 했을 경우
				func_Login();
			}
				
		});
		
	});// end of $(document).ready(function(){})-------------

	
	//Function Declaration
	function func_Login(){
		const pk_empnum = $("input#pk_empnum").val(); 
	    const pwd = $("input#pwd").val(); 
	      
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
            <a href="">사원번호 찾기</a>&nbsp;
            <a href="">비밀번호 찾기</a>&nbsp;
            <a href="">회원가입</a><br>
         </div>
         <div id = "loginbutton">
            <button type="button" id="goLogin">로그인</button>
         </div>
         <div id = "idScan">
            <input type="checkbox" id="keep" class="input_keep" value="off" /><label for="keep" class="input_keep">아이디(사원번호) 저장</label>
         </div>
      </form>
      
</div>