<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #172. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
 // System.out.println("serverIP : " + serverIP);
 // serverIP : 211.238.142.72
   
   // String serverIP = "211.238.142.72"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
 // System.out.println("portnumber : " + portnumber);
 // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
 // System.out.println("serverName : " + serverName);
 // serverName : http://211.238.142.72:9090 
%>
<!-- 조직도 -->
<link rel="stylesheet" href="<%= ctxPath%>/resources/jstree/dist/themes/default-dark/style.min.css" />
<link rel="stylesheet" href="<%= ctxPath%>/resources/jstree/dist/themes/default/style.min.css" />
										  
<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function(){
	  	$('[data-toggle="tooltip"]').tooltip();   
	  	$('#myModal').appendTo("body"); 
	  
	});
	
	
	$(document).mouseup(function (e){
		if($(".form-popup").has(e.target).length === 0){
			$(".form-popup").hide();
		}
	});
	
	/* ESC 키 누를시 팝업 닫기 */
	$(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 
	    if (code == 27) { // 27은 ESC 키번호
	        $('.form-popup').hide();
	    }
	});
	
	$(document).mouseup(function (e){
		if($(".layer_pop").has(e.target).length === 0){
			$(".layer_pop").hide();
		}
	});
	
	/* ESC 키 누를시 팝업 닫기 */
	$(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 
	    if (code == 27) { // 27은 ESC 키번호
	        $('.layer_pop').hide();
	    }
	});
	
	function openChatTab(evt, tabName) {
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(tabName).style.display = "block";
		  evt.currentTarget.className += " active";
	}
	
	function openAlarmTab(evt, tabName) {
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(tabName).style.display = "block";
		  evt.currentTarget.className += " active";
	}
		
	
	
	function OpenOrganizationForm() {
  		document.getElementById("myForm").style.display = "block";
	}

	function closeForm() {
  		document.getElementById("myForm").style.display = "none";
	}
	
	function OpenChatForm(){
		document.getElementById("myForm2").style.display = "block"; 
	}
	function closeForm2() {
  		document.getElementById("myForm2").style.display = "none";
	}
	
	function OpenMyMenu(){
		document.getElementById("myForm").style.display = "block"; 
		
	}
	
	function OpenAlarmForm(){
		document.getElementById("myForm3").style.display = "block"; 
	}
	function closeForm3() {
  		document.getElementById("myForm3").style.display = "none";
	}
	
	function OpenMyinfoForm(){
		document.getElementById("myForm4").style.display = "block"; 
	}
	function closeForm4() {
  		document.getElementById("myForm4").style.display = "none";
	}
	
	
	
	
</script>
 
 <!-- 상단 네비게이션 시작 -->
<div class="header">
	<nav class=" navbar  d-flex justify-content-between navbar-expand-lg navbar-dark fixed-top" style="height: 60px; background-color:#2c2a34;">
 			<div  ></div>
 			
 			<div  style="display:flex;    position: relative;">
				<div class="searchBox" style="  display:flex; position: relative; align-items:center; ">
					<form id="searchPopupTopButton" class="main-search clearfix" style="display:flex;">
						<div class="main-search-box">
							<input type="text" class="cursor-pointer" placeholder="전체검색"  />
						</div>
						<button class="searchBtn" type="button">옵션</button>
					</form>
				</div>
        	</div>
        	
        	
        	
        	<div class="nav_right"> 
     <!-- 조직도 팝업 -->
        		<a class="iconbar" onclick=" OpenOrganizationForm()" type="button" id="organizationTopButton " data-toggle="tooltip" data-placement="bottom" title="조직도" style="display: inline-block; ">
                    <i class="fas fa-sitemap"></i>
                </a>
                
                
                <div class="form-popup" id="myForm">
					  	<article action="" class="form-container">
						    <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
							    <strong >조직도</strong>
							    <button type="button" class="btn cancel" onclick="closeForm()"><i class="fas fa-times icon-search"></i></button>
							</div>
							<div style="display:block;">
							
								<!-- 조직도 리스트 -->
							    <label for="name" style="font-size: 14px; margin-left:20px;"><b>그루비</b></label>
								<div style="display:flex; padding: 0 20px; margin: 10px 0;">
									<input id="organizationInput" type="text" class="searchInput all-setup-input-type-1" placeholder="이름, 소속, 전화번호 검색" autocomplete="off" name="name phone deptnamekor" required>
								</div>
								
								<!-- 조직도리스트 넣기 -->
								<!-- 3 setup a container element -->
								<div id="jstree" style="color:blue !important;"></div>
					    	</div>
					  	</article>
				</div>
				
				
				
      <!-- 채팅 --> 
                <a class="iconbar" onclick=" OpenChatForm()" type="button" data-toggle="tooltip" data-placement="bottom" title="채팅"><i class="fas fa-comment"></i></a>
                
                <div class="form-popup" id="myForm2" >
	                	<article action="" class="form-container">
						    <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
							    <strong >채팅</strong>
							    <button type="button" class="btn cancel" onclick="closeForm2()"><i class="fas fa-times icon-search"></i></button>
							</div>
							<div style="">
								<div style="margin:0 20px; border-bottom: solid 1px  #ddd;">
									<div class="tab" >
										  <button class="tablinks " onclick="openChatTab(event, 'chatting')">채팅</button>
										  <button class="tablinks" onclick="openChatTab(event, 'chatContact')">연락처</button>
									</div>
									<div style=" float:right;   top: -40px; position: relative;">
										<button id="btnChat"><img class="pr-1" src="<%= ctxPath%>/resources/images/common/icon-chat.png"  alt="icon-chat"  />새 채팅</button>
								    </div>
								</div>
								
								<div style="padding: 0 20px; margin: 10px 0;">
									<input id="chatInput" type="text" class="searchInput" placeholder="이름, 채팅방명 검색" autocomplete="off" name="name" required />
								</div>
								
								<div id="chatting" class="tabcontent" >
									<div  style= "padding: 7px 20px 20px 20px;">
										<ul  class="pjtList" style="   padding:5px 20px; ">
											<li class="department-item " >
									            <span style="cursor:pointer" class="group-tree-position-fix-type-1 department-name group-tree-position-fix-type-1">채팅채팅</span>
									        </li>
										</ul>
									</div>
								</div>
								
								<div id="chatContact" class="tabcontent">
								  <div    style= "padding: 7px 20px 20px 20px;">
									<ul  class="pjtList" style="   padding:5px 20px; ">
										<li class="department-item "  >
								          
								            <span style="cursor:pointer" class="group-tree-position-fix-type-1 department-name group-tree-position-fix-type-1">연락처연락처</span>
								        </li>
									</ul>
								</div>
								</div>
								
							</div>
						 </article>
                
				</div>
				
	<!-- 알림 -->
                <a class="iconbar" onclick="OpenAlarmForm()" type="button" id="alarmTopButton" data-toggle="tooltip" data-placement="bottom" title="알림">
	                <i class="fas fa-bell"></i>
	               
            	</a>
            	
            	<div class="form-popup" id="myForm3">
                	<article action="" class="form-container">
					    <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
					    <strong >알림</strong>
					    <button type="button" class="btn cancel" onclick="closeForm3()"><i class="fas fa-times icon-search"></i></button>
						</div>
						<div style="">
							<div style="margin:0 20px; border-bottom: solid 1px  #ddd;">
								<div class="tab"  >
								  
								  <button class="tablinks " onclick="openAlarmTab(event, 'noneChecked')">미확인</button>
								  <button class="tablinks" onclick="openAlarmTab(event, 'allAlarm')">전체</button>
									
								</div>
								<div style=" float:right;   top: -30px; position: relative;">
								<a href="#" id="btnAllRead" style="font-size: 13px; font-weight:700; color: #999 !important;">모두읽음</a>
							    </div>
							</div>
							
							<div style="padding: 0 20px; margin: 10px 0;">
								<div>
									<input id="alarmInput" type="text" class="searchInput all-setup-input-type-1" placeholder="검색" autocomplete="off" name="name" required>
								</div>
							</div>
							
							<div id="noneChecked" class="tabcontent" >
							  	<div    style= "padding: 7px 20px 20px 20px;">
									<ul  class="pjtList" style="   padding:5px 20px; ">
										<li class="department-item " dvsn-cd="1" depth="0"  >
								          
								            <span style="cursor:pointer" class="group-tree-position-fix-type-1 department-name group-tree-position-fix-type-1">미확인 알림</span>
								        </li>
									</ul>
								</div>
							</div>
							
							<div id="allAlarm" class="tabcontent">
								<div    style= "padding: 7px 20px 20px 20px;">
									<ul  class="pjtList" style="   padding:5px 20px; list-style:none;">
										<li class="department-item "  >
								            <span style="cursor:pointer" class="group-tree-position-fix-type-1 department-name group-tree-position-fix-type-1">전체알림목록</span>
								        </li>
									</ul>
								</div>
							</div>
							
						</div>
					 </article>
                
				</div>
            	
       <!-- 유저정보 -->
            	 
            	<a class="iconbar" onclick="OpenMyinfoForm()"  type="button" ><i class="fas fa-user-circle"></i></a>
        		
        		<div class="myinfo-popup layer_pop" id="myForm4">
        		
        			<div class="myinfo-container">
	        			
	        			<ul style="list-style: none; margin:0;">
	        				<li style="    display: flex;">
	        					<img class="myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-myprofile"  />
	        					<div style="display: inline-block; box-sizing: border-box;">
	        						<strong class="user-name" >${sessionScope.loginuser.name}</strong>
	        						<span class="dept">
	        							<c:choose>
	        							<c:when test="${sessionScope.loginuser.fk_deptnum eq '0'}">임원진</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_deptnum eq '1'}">회계부</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_deptnum eq '2'}">영업부</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_deptnum eq '3'}">인사부</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_deptnum eq '4'}">총무부</c:when>
	        							
	        							<c:otherwise></c:otherwise>
	        							</c:choose>
	        						</span>
	        						<span class="spot">
	        						<c:choose>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '0'}">관리자</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '1'}">인턴</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '2'}">사원</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '3'}">대리</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '4'}">과장</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '5'}">차장</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '6'}">부장</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '7'}">이사</c:when>
	        							<c:when test="${sessionScope.loginuser.fk_spotnum eq '8'}">사장</c:when>
	        							<c:otherwise></c:otherwise>
	        							</c:choose>
	        						</span>
	        					</div>
	        					
	        				</li>
	        				<li class="infoList"><a style="color: #555 !important ;"  href="#" data-toggle="modal" data-target="#myModal"><i class="far fa-user"></i> 내 프로필</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;"  href="#"><i class="fas fa-cog"></i> 환경설정</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;" href="<%=ctxPath%>/logout.groovy"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
	        				
	        			</ul>
	        			
        			</div>
        			
        		</div>
        	</div>
        	
	</nav>
</div>


 				<div class="modal" id="myModal"  >
        	       <div class="modal-dialogs"  >
	        	       <div class="card " style="display: block; ">
					   	<div style=" position: relative; ">
						    <img class="card-img-top rounded" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}" alt="Card image" style="width:100%; height: 350px; overflow: hidden;" />
						    <div class="bottom-left" style="color: white; font-weight:bold; font-size: 18px;">${sessionScope.loginuser.name}</div>
					    </div>
					    <div class="card-body">
					      <ul style="list-style: none;">
					      	<li>
					      		<i class="far fa-envelope"></i>
					      		<span>${sessionScope.loginuser.email}</span>
					      	</li>
					      	<li>
					      		<i class="fas fa-mobile-alt"></i>
					      		<span>${sessionScope.loginuser.phone}</span>
					      	</li>
					      	
					      </ul>
					    </div>
					    
					    <div class="btn-probottom">
					    	<button class="btn-chat js-btn-chat btn-bottom" style=" cursor: pointer !important; pointer-">
					        	채팅
					        	<i class="far fa-comments"></i>
					        </button>
					        <button class="btn-modi js-btn-modi btn-bottom"  data-toggle="modal" data-target="#myModal2" style=" cursor: pointer;" >
					       		정보수정
					            <i class="far fa-address-card"></i>
					        </button>
					     </div>
					  </div> 
        	    	</div>
				  </div>
				  
<!-- 회원정보수정 -->
<div class="modal" id="myModal2" style="position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background: rgba(0,0,0,.6);" >
 <div class="modal-content " style="position: relative; max-width: 850px; min-height: 490px; max-height: 600px; border-radius: 20px; border: 1px solid #777; box-shadow: 20px 20px 30px rgb(0 0 0 / 20%);     margin: 0 auto">
				      
    
     <div class="modal-header">
     	 환경설정
     	 
	       <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	  
     </div>
     

     <div class="modal-body "  >
        <form action="<%=ctxPath%>/MyInfoEdit.groovy">
		    <div class="row">
		      <div class="col-20">
		        <label for="pk_empnum">아이디</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="pk_empnum" name="pk_empnum" value="${sessionScope.loginuser.pk_empnum}" disabled="disabled">
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-20">
		        <label for="name">이름</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="name" name="name" value="${sessionScope.loginuser.name}">
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-20">
		        <label for="lname">부서</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="lname" name="lastname" value="${sessionScope.loginuser.deptnamekor}">
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-20">
		        <label for="lname">직책</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="lname" name="lastname" placeholder="Your last name.." value="${sessionScope.loginuser.spotnamekor}">
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-20">
		        <label for="lname">휴대폰 번호</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="lname" name="lastname" placeholder="Your last name.."  value="${sessionScope.loginuser.phone}">
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-20">
		        <label for="lname">이메일</label>
		      </div>
		      <div class="col-70">
		        <input type="text" id="email" name="email" placeholder="Your email"  value="${sessionScope.loginuser.email}">
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-20">
		        <label for="country">부서</label>
		      </div>
		      <div class="col-70">
		       	 <select class="requiredInfo" id="fk_deptnum" name="fk_deptnum" required style="width: 130px; padding: 8px;">
		         	<option value ="">부서선택</option>
		         	<c:forEach var="departments" items="${requestScope.departments}">
		         		<option value ="${departments.pk_deptnum}">${departments.deptnamekor}</option>
		         	</c:forEach>
			     </select>
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-20">
		        <label for="subject">Subject</label>
		      </div>
		      <div class="col-70">
		        <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>
		      </div>
		    </div>
		    <div class="row">
		      <input type="submit" value="Submit">
		    </div>
		 </form>
     </div>
 
     
     
   </div>
</div>
<!-- 상단 네비게이션 끝 -->


<script src="<%= ctxPath%>/resources/jstree/dist/jstree.min.js"></script>
<script>

 $(function() {
		
		//console.log("테스트2:");
		
		
		    $.ajax({
		       
		        type: "GET",
		        url: "<%= ctxPath%>/getOrganization.groovy",
		        dataType: "json",
		        success: function (json) {
		        	// console.log("테스트트4");
		        	createJSTree(json);
		            //console.log("테스트트");
		            //console.log("테스트트 :"+ json);
		          
		        },

		        error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
		    });            
		
		//console.log("테스트3");
		
	function createJSTree(jsondata) {  
		 
		$('#jstree').jstree({ 
			"themes" : {
				/* 'name' : "default-dark", */
	            "theme" : "classic", 
	            "dots" : false,
	            "icons" : false 
			},

			'core' : {
			    'data' :  jsondata
			
			    
			},
			'plugins' : ["search", "themes"]
		});
		var to = false; $('#organizationInput').keyup(function () { if(to) { clearTimeout(to); } to = setTimeout(function () { var v = $('#organizationInput').val(); $('#jstree').jstree(true).search(v); }, 250); });

		 
	} 
 }); 

</script>

  