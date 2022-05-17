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
<link rel="stylesheet" href="<%= ctxPath%>/resources/jstree/dist/themes/default/style.min.css" />
<style type="text/css">
{box-sizing: border-box;}



/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  top: 45px;
  right: 0;
  /* border: 1px solid #f1f1f1; */
  z-index: 9;
  width: 400px;
  bottom:auto;
  height: 100%;
  background-color: white;
  -webkit-box-shadow: -10px 10px 15px rgb(0 0 0 / 4%);
  box-shadow: -10px 10px 15px rgb(0 0 0 / 4%);
}

/* Add styles to the form container */
.form-container {
  padding: 10px;
  background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
  width: 100%;

}

/* Set a style for the submit/login button */
.form-container .btn {
  padding: 0; 
  border: none;
  cursor: pointer;
  opacity: 0.8;
  float:right;
}



/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}


div.nav_right > a{
	color:white ;  
}

.icons-search:before {
    position: absolute;
    top: 50%;
    left: 14px;
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
    color: #555;
    font-size: 16px;
}
div.searchBox{
	cursor: pointer;
	position:relative;
	background-color: #3f3c49;
	border: 1px solid #555;
	border-radius: 900px;
    color: #eee;
    font-size: 12px;
    margin: 0 auto;
}
form.main-search{
	padding: 0 20px 0 10px;
	
}

.main-search-box::before {
   font-family: "Font Awesome 5 Free"; 
    font-weight: 600;
    display: inline-block;
    content: "\f002";
    margin: 0 11px 0 0;
    vertical-align: middle;
    color:white;
}

.main-search input {
    padding-right: 10px;
    color: #fff; 
    font-size: 14px;
    background: 0 0;
    vertical-align: middle;
    max-width: 200px;
    cursor: pointer;
    border: 0;
    font-weight: bold;
}

.searchBtn {
    float: right;
    font-size: 12px;
    color: #ddd;
    background-color: transparent;
    border: 0;
}

.searchBtn::before {
    display: inline-block;
    content: "";
    width: 1px;
    height: 14px;
    margin: 0 14px 0 0;
    background: #555;
    vertical-align: middle;
}
input#organizationInput::before{
 	font-family: "Font Awesome 5 Free";
 	content: "\f002";
 	color: black;
 	font-weight: 600;
    display: inline-block;
}
input.searchInput{
	color: #6449fc;
    font-size: 13px;
    font-weight: 700;
    padding: 0 70px 0 38px; 
    border: 1px solid #ddd; 
    height: 34px; 
    border-radius: 4px;
    
}

ul.pjtList{
	padding:5px 20px;
}

ul.pjtList li:hover{
    background-color: #efebff;
    cursor: pointer;
    color: #6449fc;
    font-weight: 700;
}
ul.active{
    background-color: #efebff;
    cursor: pointer;
    color: #6449fc;
    font-weight: 700;
}




.topnav {
  overflow: hidden;
  /* background-color: #f1f1f1; */
}


/* .tab button:hover { 
  border-bottom: 3px solid #111;
} */

.tab button.active {
  border-bottom: 3px solid #111;
  font-weight: 700;
  color: black;
}
#expander{ width:100%; height:6px; background-color:#999;}



/* Style the tab */
.tab {
  overflow: hidden;
  
}

/* Style the buttons inside the tab */
.tab button {
  background-color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  font-size: 13px;
  width: 60px;
  height:30px;
  font-weight: 700;
  color: gray;
}

/* Style the tab content */
 .tabcontent{
  display: none;
  padding: 10px 20px;
}

button#btnChat{
	
    margin-left: 4px;
    width: auto;
    height: 30px;
    background: #6449fc;
    color: #fff;
    border-color: #6449fc;
	border-radius: 4px;
	font-size: 14px;
}








.layer_pop {
    display: none;
  position: fixed;
  	width: 220px;
    min-width: 218px;
    padding: 14px;
    position: absolute;
    top: 50px;
    right: 30px;
/*     z-index: 13; */
    background: #fff;
    border: 1px solid #777;
    -webkit-border-radius: 8px;
    border-radius: 8px;
    font-size: 13px;
    text-align: left;
    color: #555;
	height: 190px;
}

/* Add styles to the form container */
.myinfo-container {
  padding: 5px; 
  background-color: white;
  
}



/* Add some hover effects to buttons */
.myinfo-container {
  opacity: 1; 
}

.myprofile-photo{
	width: 40px;
    height: 40px;
    margin: 0 10px 0 0;
    display: inline-block;
    border: 1px solid #eee;
    -webkit-border-radius: 16px;
    border-radius: 16px;
    background-size: cover;

}

.myprofile-photo2{
	/* z-index: 1; */
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    height: 320px;
    width: 100%;
    background: linear-gradient(180deg,rgba(102,102,102,0) 45.31%,rgba(51,51,51,.6) 100%);
}
strong.user-name{
	display: block;
    line-height: 21px;
    color: #555;
    max-width: 140px;
    font-size: 15px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-weight: bold;
}

li.infoList {

	position: relative;
    min-height: 19px;
    margin-top: 9px;
    cursor: pointer;
    font-size: 14px;
}
li.infoList:hover{
	 font-weight: bold;
}

div#myModal{

    overflow-y: auto;
/*     -ms-overflow-y: hidden; */
/*     position: fixed; */
/*     z-index:1050; */
    right: 0;
    top:150px;
    left: 0;
     height: 100%;
   
}

div#myModal div.modal-dialogs{
	margin: 0 auto;
    padding-bottom: 15px;
  /*   z-index:1050;  */

    -webkit-border-radius: 10px;
    border-radius: 10px;
    background: #fff;
    height: 320px;
    width: 350px;

}

.bottom-left {
  position: absolute;
  bottom: 8px;
  left: 16px;
}
myModal div.card-body ul{
	margin:0;
	padding:0;
}

myModal div.card-body ul li i {
    width: 40px;
    height: 40px;
    text-align: center;
}
myModal div.card-body ul li span {
    width: 280px;
    padding: 0 0 0 10px;
    display: inline-block;
    border-bottom: 1px solid #eee;
}
div.btn-probottom {
	display: inline-block;
	justify-content: center;
	width:100%;
}


button.btn-bottom{
    width: 140px;
    height: 50px;
    padding: 0 20px;
    margin: 0 5px;
    position: relative;
    border: 1px solid #ddd;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: left;
    font-size: 13px;
    color: #555;
    line-height: 50px;
    cursor: pointer;
}

</style>
<script type="text/javascript">
	$(document).ready(function(){
	  	$('[data-toggle="tooltip"]').tooltip();   
	  	$('#myModal').appendTo("body"); 
	  	/* 
	  	$('ul.pjtList').click(function(){
	  		$( 'ul.pjtList' ).addClass( 'active' );
	  		
	  	}); */
	  	
	  	
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
                
                
                <div class="form-popup" id="myForm" >
					  	<article action="" class="form-container" >
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
								<div id="jstree" class="scroll" style="width: 100%; padding-bottom: 40px; height: 600px; overflow:auto;  " ></div>
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
										<ul  class="pjtList scroll" style="   padding:5px 20px; ">
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
            	 
            	<!-- <a class="iconbar" onclick="OpenMyinfoForm()"  type="button" ><i class="fas fa-user-circle"></i></a> -->
        		<a class="iconbar" onclick="OpenMyinfoForm()"  type="button" ><img class="myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-myprofile"  /></a>
        		<div class="myinfo-popup layer_pop" id="myForm4">
        		
        			<div class="myinfo-container">
	        			
	        			<ul style="list-style: none; margin:0;">
	        				<li style="    display: flex;">
	        					<img class="userimg myprofile-photo" alt="icon-myprofile"  />
	        					<div style="display: inline-block; box-sizing: border-box;">
	        						<strong class="user-name" >${sessionScope.loginuser.name}</strong>
	        						<span class="dept">
	        						
	        							<c:choose>
	        							<c:when test="${sessionScope.loginuser.deptnamekor eq '임원'}">${sessionScope.loginuser.deptnamekor}진</c:when>
	        							<c:when test="${sessionScope.loginuser.deptnamekor ne '임원'}">${sessionScope.loginuser.deptnamekor}부</c:when>
	        							</c:choose>
	        						</span>
	        						<span class="spot">
	        						${sessionScope.loginuser.spotnamekor}
	        						
	        						</span>
	        					</div>
	        					
	        				</li>
	        				<li class="infoList"><a style="color: #555 !important ;"    onclick="getUserInfo()" href="" data-toggle="modal" data-target="#myModal"><i class="far fa-user"></i> 내 프로필</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;"  href="#"><i class="fas fa-cog"></i> 환경설정</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;" href="<%=ctxPath%>/logout.groovy"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
	        				
	        			</ul>
	        			
        			</div>
        			
        		</div>
        	</div>
        	
	</nav>
</div>

<!-- 유저 프로필카드  -->
 				<div class="modal animate" id="myModal"  >
        	       <div class="modal-dialogs"  >

	        	       <div class="card" id="headerCard" style="width:400px; display: block; ">

	        	       <div class="card " style="display: block; ">

					   	<div style=" position: relative; ">
						    <img class="userimg card-img-top rounded" alt="Card image" style="width:100%; height: 350px; overflow: hidden;" />
						    <div class="bottom-left" style="color: white; font-weight:bold; font-size: 18px;">${sessionScope.loginuser.name}</div>
					    </div>
					    <div class="card-body">
					      <ul style="list-style: none;">
					      	<li>
					      		<i class="far fa-envelope"></i>
					      		<span id="span_email"></span>
					      	</li>
					      	<li>
					      		<i class="fas fa-mobile-alt"></i>
					      		<span id="span_phone"></span>
					      	</li>
					      	
					      </ul>
					    </div>
					    
					    <div class="btn-probottom">
					    	<button class="btn-chat js-btn-chat btn-bottom" style=" cursor: pointer !important; pointer-">
					        	채팅
					        	<i class="far fa-comments"></i>
					        </button>
					        <button class="btn-modi js-btn-modi btn-bottom" onclick="myModal()" data-toggle="modal" data-target="#myModal2" style=" cursor: pointer;" >
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
 <div class="modal-content animate" style="position: relative; max-width: 850px; min-height: 490px; max-height: 600px; border-radius: 20px; box-shadow: 20px 20px 30px rgb(0 0 0 / 20%);     margin: 0 auto">
				      
    
     <div class="modal-header" style="background-color: #6449fc;">
     	   <span style="color: white; font-weight: bold; font-size: 15pt;"><i class="fas fa-id-card-alt"></i>내 정보수정</span>
	       <button type="button" class="btn  btn-dark" data-dismiss="modal">Close</button>
     </div>
     

     <div class="modal-body scroll" style="width: 100%; overflow:auto;  ">
        <form action="<%=ctxPath%>/MyInfoEdit.groovy"> 
        
        <!-- <form name="InfoFrm"> -->
        <div>
	        <table id="tbl_myInfo" class="table">
	        	
			      <tr >
			        <th style="width: 100px;">사원번호</th>
			        <td id="td_pk_empnum"><span id="span_pk_empnum"></span></td>
			        <td rowspan="4" style="border-left: 1px solid #dee2e6;">
			        	<form id="FILE_FORM" method="post" enctype="multipart/form-data" action="<%=ctxPath%>/myphotoEdit.groovy">
				        	<div style="vertical-align: middle;">
					         	<img class="rounded userimg"  style="width:150px; height:auto; overflow: hidden;" />
					         	<label href="javascript:uploadFile();" className="input-file-button" for="input-file"   type="button" id="emppicturename" name= "attach" style="cursor: pointer;"><i class="far fa-edit"></i></label>
								<input type="file" id="input-file" style="display : none;"/> 
					        </div>
				        </form>
				    </td>
			      </tr>
			 	  <tr>
			        <th>이름</th>
			        <td id="td_name"></td>
			      </tr>
			      <tr>
			        <th>생년월일</th>
			        <td id="td_birthday"></td>
			      </tr>
			      <tr>
			        <th>성별</th>
			        <td id="td_gender"></td>
			      </tr>
			      <tr>
			        <th>주소</th>
			        <td id="td_address">(<span id="my_postcode"></span>)&nbsp;<span id="my_address"></span>&nbsp;<span id="my_detailAddress"></span>&nbsp;<span id="my_extraAddress"></span></td>
			        <td><a onclick="addressEdit(pk_empnum)" id ="btn_addressEdit" type="button" ><i class="far fa-edit"></i></a></td>
			      </tr>
			      <tr class="myphone">
			        <th>연락처</th>
			        <td id="td_phone"></td>
			        <td id="myphone2"><a id ="btn_mobileEdit" onclick="mobileEdit(pk_empnum)"  type="button" ><i class="far fa-edit"></i></a></td>
			      </tr>
			      <tr>
			        <th>이메일</th>
			        <td id="td_email"></td>
			        <td><a id ="btn_emailEdit" onclick="emailEdit(pk_empnum)"  type="button" ><i class="far fa-edit"></i></a></td>
			      </tr>
			      <tr>
			        <th>비밀번호</th>
			        <td id="td_pwd">
			        	<table><tr class=''><strong>비밀번호 재설정이 가능합니다.</strong></tr><br/>
			        	<tr><span>비밀번호는 8~16자의 영문 대소문자,숫자,특수문자를  포함해야 합니다.</span></tr></table>
					</td>
					<td><a id ="btn_pwdEdit" onclick="pwdEdit(pk_empnum)"  type="button" ><i class="far fa-edit"></i></a></td>
			      </tr>
			      <tr>
			        <th>부서</th>
			        <td >${sessionScope.loginuser.deptnamekor}</td>
			      </tr>
			      <tr>
			        <th>직위</th>
			        <td>${sessionScope.loginuser.spotnamekor}</td>
			      </tr>
			      <tr>
			        <th>입사일자</th>
			        <td>${sessionScope.loginuser.startday}</td>
			      </tr>
			      <tr>
			        <th>월급</th>
			        <td>${sessionScope.loginuser.salary}</td>
			      </tr>
			 </table>
			 </div>     
		 </form>
     </div>
 
     
     
   </div>
</div>
</div>
<!-- 상단 네비게이션 끝 -->


<script src="<%= ctxPath%>/resources/jstree/dist/jstree.min.js"></script>
<script>

// jstree로  조직도 나타내기

$(function() {
	
	
	
	
	
		    $.ajax({
		       
		        type: "GET",
		        url: "<%= ctxPath%>/getOrganization.groovy",
		        dataType: "json",
		        success: function (json) {
		        	createJSTree(json);
		        },

		        error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
		    });            
 }); //end of $(function() {})---------------

function createJSTree(jsondata) {  
	 
	$('#jstree').bind("loaded.jstree", function (e, data) {
        $('#jstree').jstree("open_all"); //WORKS FINE
    }).jstree({ 
		'themes' : {
			/* 'name' : "default-dark", */
            "theme" : "default", 
            "dots" : false,
           /*  "icon" : false  */
		},
		'plugins' : ["wholerow","search", "themes","types"],
		<%--  "types" : {
             "default": {
                 "icon" :"<%= ctxPath%>/resources/images/common/로고그루비.png" 
                 <!--icon을 원하는 이미지로 만들때-->
             }
         } --%>

		'core' : {
		    'data' :  jsondata
		},
		
		 'search': {
			 show_only_matches: true,
		     search_callback: function (searchString, node) {
		            if (node.parent != "#" && node.text.toUpperCase().includes(searchString.toUpperCase()) == true) {
		                return node;
		            }
		        }
		 }
		
	
	});
	
	 var to = false; $('#organizationInput').keyup(function () { if(to) { clearTimeout(to); } to = setTimeout(function () { var v = $('#organizationInput').val(); $('#jstree').jstree(true).search(v); }, 250); });
	 
} //end of function createJSTree(jsondata) { }--------------
</script>

  