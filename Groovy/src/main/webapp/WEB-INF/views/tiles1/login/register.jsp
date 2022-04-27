<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	String ctxPath = request.getContextPath();
%>   


<style type="text/css" >
	div.container {
		width: 100%;
		margin: 0 auto;
		
	}
	
	form[name="registerFrm"] {
		width: 586px;
		margin: 0 auto;
	}
	
	span.title {
		display: inline-block;
	    margin-bottom: 10px;
	    padding: 3px 0;
	    font-size: 16px;
	    color: #333;
	    font-weight: 700;
	    text-align: left;
	}

	
	input.requiredInfo {
	    width: 586px;
	    height: 52px;
	    border: 1px solid #ddd;
	    -webkit-border-radius: 8px;
	    border-radius: 8px;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	    padding-left: 20px;
	}
	
	div#agreeCheck {
		margin-top: 20px;
	}
	
	a.agree {
		font-weight: bold;
		color: #623ad6;
	}
	
	a.agree:hover {
		cursor: pointer;
	}
	
	button#goRegister {
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
	
	button#goRegister:hover {
		font-weight: bold;
		filter: brightness(90%);
		cursor: pointer;
	}
	
</style>


<script type="text/javascript">	
	$(document).ready(function(){
		
		
	});
</script>



<div class="container">
<%--
EMPNUM               NUMBER(10)    
PK_USERID            VARCHAR2(20)  
PWD                  VARCHAR2(200) 
NAME                 VARCHAR2(20)  
ADDRESS              VARCHAR2(100) 
DETAILADDRESS        VARCHAR2(100) 
EXTRAADDRESS         VARCHAR2(100) 
POSTCODE             VARCHAR2(20)  
PHONE                VARCHAR2(200) 
EMAIL                VARCHAR2(200) 
BIRTHDAY             DATE          
GENDER               VARCHAR2(10)  
REGISTERDAY          DATE          
STARTDAY             DATE          
RESIGNATIONSTATUS    NUMBER(1)     
RESIGNATIONDAY       DATE          
FK_VSTATUS           NUMBER(1)     
FK_DEPTNUM           NUMBER        
FK_SPOTNUM           NUMBER        
EMPPICTURENAME       VARCHAR2(20)  
SALARY               NUMBER(20) 
 --%> 
 
 
   
   <h1 align="center">사원 등록</h1>
       <form name="registerFrm">
       	 <span class="title">이름</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
       	 	    
         <br><br>
         <span class="title">이메일</span><br>
         <input type="email" class="requiredInfo" id="email" name="email" size="20" maxlength="20" required placeholder="example@gmail.com" />
                  
         <br><br>
         <span class="title">아이디(사원번호)</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">비밀번호</span><br>
         <input type="password" class="requiredInfo" id="pwd" name="pwd" size="20" maxlength="20" required placeholder="비밀번호 입력"/>
         
         <br><br>
         <span class="title">입사일자</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">부서명</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">연봉</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">주소</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">생일</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         <br><br>
         <span class="title">성별</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
         
         
         
         
                  
         
         
         <div id = "registerBtn">
            <button id="goRegister">등록</button>
            <button id="goRegister">취소</button>
         </div>
      </form>
</div>


