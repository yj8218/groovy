<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>로그인</title>
	
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />
	
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
	
	<script type="text/javascript">	
		$(document).ready(function(){
			
			
		});
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
</head>
<body>
<div class="container">
   <div class="logo">
       <img class="logo" src="<%= ctxPath %>/resources/images/common/logo.png" />
   </div>
   <h1 align="center">로그인</h1>
       <form name="loginFrm">
         <div id = "IdPasswd">
            <input type="text" id="loginUserid" class="LOGIN" name="userid" size="30" placeholder="사원번호" ><br><br>
         
            <input type="password" id="loginPwd" class="LOGIN" name="pwd" size="30" placeholder="비밀번호"><br><br>
         </div>
         <div id = "link">
            <a href="">아이디 찾기</a>&nbsp;
            <a href="">비밀번호 찾기</a>&nbsp;
            <a href="">회원가입</a><br>
         </div>
         <div id = "loginbutton">
            <button id="goLogin">로그인</button>
         </div>
         <div id = "idScan">
            <input type="checkbox" id="keep" class="input_keep" value="off" /><label for="keep" class="input_keep">아이디 저장</label>
         </div>
      </form>
      
</div>
</body>
</html>