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


div.nav_right  a{
	color:white !important;
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
   /*  width: 14px;
    height: 14px; */
    margin: 0 11px 0 0;
    /* background: url(/flow-renewal/assets/images/icon-search-dark.png); */
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

</style>
<script type="text/javascript">
	$(document).ready(function(){
	  	$('[data-toggle="tooltip"]').tooltip();   
	  	$('#myModal').appendTo("body"); 
	});
	
		
		
	
	
	
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
	
</script>
 
 <!-- 상단 네비게이션 시작 -->
<div class="header_side">
<div class="header">
	<nav class=" navbar  d-flex justify-content-between navbar-expand-lg navbar-dark fixed-top" style="height: 45px; background-color:#2c2a34;">
 			<div  ></div>
 			<div  style="display:flex;    position: relative;">
			<!-- 
			<form id="searchZone" style="background-color:#999; border-radius: 50%; border: red;">
				<input />
			</form>
			 -->
			<!-- 
			 	<div class="searchBox" style="  display:flex; position: relative; align-items:center; ">
			  		<div style=" display:flex;  align-items:center;  position: relative; border-radius: 900px;  color: #bfbfbf; vertical-align: middle; background-color: #3f3c49; border: solid 1px #555; with: 309px; height: 30px;">
			     		<i class=" ml-2 mr-2 fas fa-search"></i> <input type="search"  placeholder="전체검색"  style="color:white; width:200px; border-right: 1px solid gray; background-color: #3f3c49;"  / > <a style="padding: 0 15px;">옵션</a>
			  		</div>
				</div> -->
				<div class="searchBox" style="  display:flex; position: relative; align-items:center; ">
					<form id="searchPopupTopButton" class="main-search clearfix" style="display:flex;">
						<div class="main-search-box">
							<input type="text" class="cursor-pointer" placeholder="전체검색" disabled>
						</div>
						<button class="searchBtn" type="button">옵션</button>
						
						
					</form>
				</div>
        	</div>
        	<div class="nav_right"> 
        		<a onclick=" OpenOrganizationForm()" type="button" id="organizationTopButton " data-toggle="tooltip" data-placement="bottom" title="조직도" style="display: inline-block; ">
                    <i class="fas fa-sitemap"></i>
                </a>
                <!-- 조직도 팝업 -->
                <div class="form-popup" id="myForm">
				  <article action="" class="form-container">
				    <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
				    <strong >조직도</strong>
				    <button type="button" class="btn cancel" onclick="closeForm()"><i class="fas fa-times icon-search"></i></button>
					</div>
					<div style="display:block;">
					<!-- 조직도 리스트 -->
				    <label for="name" style="font-size: 14px;"><b>그루비</b></label>
				    
				    <!-- <input type="text" placeholder="이름, 소속, 전화번호 검색" name="name" required> -->
					<!-- <i class="fas fa-search icon-search"></i> -->
					<input id="organizationInput" type="text" class="all-setup-input-type-1" placeholder="이름, 소속, 전화번호 검색" autocomplete="off" name="name" required>
				
				   
					</div>
				    
				  </article>
				</div>
                
                <a onclick=" OpenChatForm()" type="button" data-toggle="tooltip" data-placement="bottom" title="채팅"><i class="fas fa-comment"></i></a>
                
                <div class="form-popup" id="myForm2">
				  <article action="" class="form-container">
				    <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
				    <strong >채팅</strong>
				    <button type="button" class="btn cancel" onclick="closeForm2()"><i class="fas fa-times icon-search"></i></button>
					</div>
					<div style="display:block;">
					<!-- 채팅 리스트 -->
				    <label for="name" style="font-size: 14px;"><b>그루비</b></label>
				    
				    <!-- <input type="text" placeholder="이름, 소속, 전화번호 검색" name="name" required> -->
					<!-- <i class="fas fa-search icon-search"></i> -->
					<input id="chatInput" type="text" class="all-setup-input-type-1" placeholder="이름, 채팅방명 검색" autocomplete="off" name="name" required>
					</div>
				  </article>
				</div>
                <a type="button" id="alarmTopButton" data-toggle="tooltip" data-placement="bottom" title="알림">
	                <i class="fas fa-bell"></i>
	               
            	</a>
            	<a data-toggle="modal" data-target="#myModal" type="button" ><i class="fas fa-user-circle"></i></a>
        		
        		
        		<!-- The Modal -->
				  <div class="modal" id="myModal" >
				    <div class="modal-dialog"  >
				      <div class="modal-content">
				      
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">Modal Heading</h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        
				        <!-- Modal body -->
				        <div class="modal-body">
				          Modal body..
				        </div>
				        
				        <!-- Modal footer -->
				        <div class="modal-footer">
				          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				        </div>
				        
				      </div>
				    </div>
				  </div>
        		
        		
        	</div>
        	
	</nav>
</div>
<!-- 상단 네비게이션 끝 -->
<!-- 사이드바 시작 -->
<div class="sidenav" style="background-color:#2c2a34; ">
	<div  align="center" class="mainlogo borderline" style=" color:white;  border-bottom: solid 0.8px #595959; "><a href="#"><img src="<%= ctxPath%>/resources/images/로고그루비.png"  alt="로고"  /></a></div>
	<div style="margin: 15px 25.5px;">
  		<div class="btn_newpjt" ><i class="fas fa-expand"></i>새 프로젝트</div>
  	</div>
  	<div class="mb-3 side-header">
	  <a href="#about">
	  <i class="fas fa-house-user"></i>내 프로젝트</a>
	  <a href="#services"><i class="fas fa-search"></i>회사 공개 프로젝트</a>
	  <a href="#clients"><i class="fas fa-archive"></i>미분류</a>
	  <a href="#contact"><i class="fas fa-ellipsis-v"></i>더보기</a>
	</div>
	
	
  	<ul class="scroll" style="list-style: none; padding: 0  0  3px 0 ; overflow-y:scroll; width:227px;  margin-bottom: 40px; ">
	  <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#demo"><a style="cursor: pointer; ">모아보기</a></div>
		  <div id="demo" class="collapse">
				<ul class="list" style="list-style: none; ">
					<li>
						<a  href="#"><i class="fas fa-list-ul"></i>전체 업무</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-align-left"></i>간트차트</a>
					</li>
					<li>
						<a href="#"><i class="far fa-calendar"></i>캘린더</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-archive"></i>파일함</a>
					</li>
					<li>
						<a href="#"><i class="far fa-bookmark"></i>북마크</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-at"></i>나를 언급</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-user-edit"></i>내 게시물</a>
					</li>
				</ul>
			</div>
	    </li>
	    
	    <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#recent_update"><a style="cursor: pointer; ">최근 업데이트</a></div>
		  <div id="recent_update" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="#"><i class="fas fa-square"></i>공개프로젝트</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>'groovy'업무공유방</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>플로우 이용 가이드</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>1:1 문의하기</a>
					</li>
				</ul>
			</div>
	    </li>
	    
	    <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#pjt_folder"><a style="cursor: pointer; ">프로젝트 폴더</a></div>
		  <div id="pjt_folder" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="#"><i class="fas fa-tag" style="color: red;"></i>마케팅</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-tag"></i>디자인</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-tag"></i>엔지니어링</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-tag"></i>1:1 문의하기</a>
					</li>
				</ul>
			</div>
	    </li>
		
	</ul>
	
	<ul class="borderline side-foot" style="list-style: none; cursor: pointer; padding: 0;">
		<li>
			<a><i class="far fa-address-book"></i>직원초대</a>
		</li>
		<li>
			<a><i class="fas fa-user-cog"></i>어드민</a>
		</li>
	</ul>
	
	
</div>

</div>   
   <!-- 상단 네비게이션 끝 -->
   

  