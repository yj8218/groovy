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

	<style type="text/css">
	div.container {
		width: 100%;
		margin: 0 auto;
		
	}
	
	form[name="loginFrm"] {
		text-align: center;
		width: 500px;
		margin: 0 auto;
	}
	
	input.LOGIN {
		width: 486px;
	    height: 52px;
	    background: #fff;
	    border: 1px solid #ddd;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	    -webkit-border-radius: 8px;
	    border-radius: 8px;
	    padding-left: 20px;
	    font-size: 16px;
	}
	
	.input_keep:hover  {
		color: #623ad6;
		font-weight: bold;
		cursor: pointer;
	}
	
	div#idScan {
		display: block;
	    margin-top: 20px;
	    cursor: pointer;
	    font-size: 14px;
	    color: #333;
	    font-weight: 500;
	    text-align: left;
	}
	
	input#keep {
		cursor: pointer;
	    vertical-align: baseline;
	}
	
	button#goLogin {
		display: block;
	    color: #fff;
	    text-align: center;
	    background: #623ad6;
	    line-height: 52px;
	    height: 52px;
	    width: 100%;
	    -webkit-border-radius: 8px;
	    border-radius: 8px;
	    margin-top: 20px;
	    font-weight: 486px;
	    font-size: 16px;
	}	
	
	button#goLogin:hover {
		font-weight: bold;
		filter: brightness(90%);
		cursor: pointer;
	}
	
	div#link {
		font-weight: bold;
		color: #623ad6;
	}
	
	div#link:hover {
		cursor: pointer;
	}
	
	img.logo {
		height: 300px;
		width: 300px;
	}
	
	div.logo {
		text-align: center;
	}
	
	</style>
<div class="container">
   <div class="logo">
       <img class="logo" src="<%= ctxPath %>/resources/images/common/logo.png" />
   </div>
   <h1 align="center">로그인</h1>
       <form name="loginFrm">
         <div id = "IdPasswd">
            <input type="text" id="pk_empnum" class="LOGIN" name="pk_empnum" size="30" placeholder="사원번호" ><br><br>
         
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
            <input type="checkbox" id="keep" class="input_keep" value="off" /><label for="keep" class="input_keep">아이디 저장</label>
         </div>
      </form>
      
</div>