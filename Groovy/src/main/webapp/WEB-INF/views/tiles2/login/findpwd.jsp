<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

	$(document).ready(function() {
		
		
		$("input#pwd").keydown(function(event){
			
			if(event.keyCode == 13){ //엔터를 했을 경우
				func_Login();
			}
				
		});
		
		
		// === 인증번호 숨기기 === //
		$("div#passwordFind").hide();
		
		// === 스피너 숨기기 === //
		/* $("div#spinner").hide();
		 */
		// === 새 비밀번호 숨기기 === //
		$("div#newPassword").hide();
		
		// === 취소 버튼 클릭시 팝업창 닫기 === //
		$("span#closeBtn").click(function() {
			window.close();
		});
		
		
		$("button#goFindPwd").click(function() {
			/* const pk_empnum = $("input#pk_empnum").val();  */
		   var pk_empnum = $("input#pk_empnum").val().trim();
		   var email = $("input#email").val().trim();
			
			
		    
			if(pk_empnum.trim()=="") {
			    alert("사원번호를 입력하세요!!");
			   $("input#pk_empnum").val(""); 
			   $("input#pk_empnum").focus();
			   return; // 종료 
			}
			
			if(email.trim()=="") {
			   alert("이메일를 입력하세요!!");
			   $("input#email").val(""); 
			   $("input#email").focus();
			   return; // 종료 
			}
			
			const frm = document.findPwdFrm;
			
			// === 스피너 보이기 === //
			/* $("div#spinner").show(); */
			
			$.ajax({
				url:"<%= ctxPath%>/sendCodeEmail.groovy",
				type:"POST",
				data:{"pk_empnum":pk_empnum,"email":email
					  },
				dataType:"JSON",
				success:function(json) {
					if(json.sendEmail) {
						alert("인증메일이 발송되었습니다.");
						$("div#beforeFind").hide();
					/* 	$("div#spinner").hide(); */
						$("div#newPassword").hide();
						
						$("div#passwordFind").show();
					}
					else {
						alert("해당하는 사원은 존재하지않습니다.");
						location.reload();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        	}
			});
			
			
		});// end of $("span#findBtn").click(function() { })
		
		
		// === 인증번호 확인 버튼 클릭 이벤트 === //
		$("span#btnCode").click(function() {
			
			var codeNo = $("input#codeNo").val().trim();
			
			if(codeNo == "") {
				alert("인증번호를 입력하세요!");
				return;
			}
			
			$.ajax({
				url:"<%= ctxPath%>/checkCode.groovy",
				type:"POST",
				data:{"codeNo":codeNo},
				dataType:"JSON",
				success:function(json) {
					if(json.isSuccess) {
						alert(json.message);
						$("div#beforeFind").hide();
						/* $("div#spinner").hide(); */
						$("div#passwordFind").hide();
						
						$("div#newPassword").show();
					}
					else {
						alert(json.message);
						window.close();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        	}
			});
		});// end of $("span#btnCode").click(function() {})
		
		
		// === 새비밀번호 입력할 경우 이벤트 === //
		$("span#newPasswordBtn").click(function() {
			var newPassword = $("input#newPassword").val().trim();
			var email = $("input#email").val().trim();
			var name = $("input#pk_empnum").val().trim();
			
			if(newPassword == "") {
				alert("비밀번호를 입력하세요.");
				return;
			}
			
			$.ajax({
				url:"<%= ctxPath%>/newPwdUpdate.groovy",
				type:"POST",
				data:{"newPassword":newPassword,
					  "email":email,
					  "pk_empnum":pk_empnum},
				dataType:"JSON",
				success:function(json) {
					if(json.isSuccess) {
						alert("비밀번호가 변경되었습니다.");
						window.close();
					}
					else {
						alert("비밀번호가 변경이 실패하였습니다. 다시 시도해주세요.");
						window.close();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        	}
			});
			
		});
		
	});// end of $(document).ready(function(){})-------------

	
	//Function Declaration
	
	
	
	
	
</script>


<div class="container">
   <div class="logo">
       <img class="logo" src="<%= ctxPath %>/resources/images/common/logo.png" />
   </div>
   <h1 align="center">비밀번호 찾기</h1>
   	<h5 align="center"> 기존 본인정보의 이메일을 입력하시면, 비밀번호 변경 메일을 발송해드립니다.</h5>
   	<div id= "beforeFind">
       <form name="findPwdFrm">
         <div id = "IdPasswd">
            <input type="text" id="pk_empnum" class="FINDPWD" name="pk_empnum" size="30" placeholder="아이디(사원번호)" ><br><br>
        
            <input type="email" id="email" class="EMAIL" name="email" size="30" placeholder="이메일"><br><br>
         </div>
        
         <div id = "findPwdbutton">
            <button type="button" id="goFindPwd">비밀번호 변경 이메일 받기</button>
         </div>
      </form>
     </div>
     
     
     <div id="passwordFind" >
	    <div class="mt-5">
	       <div class="form-row">
		    	<div class="col-2 col-lg-3"></div>
			    <div class="col-8 col-lg-6">
			       <label>인증번호</label>
			       <input type="password" class="form-control required mb-1" id="codeNo" placeholder="Enter Code" name="codeNo">
			    </div>
		   </div>
	    </div>
	    <div class="row justify-content-center mt-4">
		    <div class="col-9 col-lg-5">
		       <span id="btnCode" class="btn btn-primary" style="display:flex; margin: auto; width: 30%; justify-content: center;">확인</span>
		    </div>
	    </div>
    </div>
    
    <div id="newPassword" >
	    <div class="mt-5">
	       <div class="form-row">
		    	<div class="col-2 col-lg-3"></div>
			    <div class="col-8 col-lg-6">
			       <label>새 비밀번호</label>
			       <input type="password" class="form-control mb-1" id="newPassword" placeholder="Enter Password" name="newPassword">
			    </div>
		   </div>
	    </div>
	    <div class="row justify-content-center mt-4">
		    <div class="col-9 col-lg-5">
		       <span id="newPasswordBtn" class="btn btn-primary" style="display:flex; margin: auto; width: 30%; justify-content: center;">확인</span>
		    </div>
	    </div>
    </div>
      
</div>