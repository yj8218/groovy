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
  		$('#jstree').jstree(true).refresh();	
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
	
	
	 //로그인한 유저 정보 불러오기
	function getUserInfo(){
		
		var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
		//alert("나와봐"+pk_empnum);
		
		$.ajax({
			url:"<%=ctxPath%>/getUserInfo.groovy",
			data:{"pk_empnum":pk_empnum },
			type:"GET",
			dataType:"JSON",
			success:function(json){
		//		alert(json.emppicturename);
				<%-- const imgUrl = "<%=ctxPath %>/resources/images/프로필사진/"+json.emppicturename; --%>
		//		$("#empImg").attr("src", imgUrl);

				alert("나와"+json.pk_empnum);
				span_pk_empnum
			//	$("span#span_pk_empnum").html(json.pk_empnum);
				$("td#td_pk_empnum").html(json.pk_empnum);
				$("td#td_name").html(json.name);
				$("td#td_birthday").html(json.birthday);
				
				if(json.gender == 1){
					$("td#td_gender").html("남자");
				}else{
					$("td#td_gender").html("여자");
				}
				
				//$("td#td_age").html(json.age);
				
				//$("td#td_postcode").html(json.postcode);
				$("td#td_address").html("("+json.postcode+") "+json.address+"&nbsp;"+json.detailaddress);
				//$("td#td_detailaddress").html(json.detailaddress);
				
				$("td#td_phone").html(json.phone);
				$("td#td_email").html(json.email);
				
				// 부서 직위
		/*		$("span#m_deptnamekor").html(json.deptnamekor);
				$("span#m_spotnamekor").html(json.spotnamekor);
				
				$("span#m_startday").html(json.startday);
				
				
				if(json.resignationstatus == 0){
					$("span#m_resignationstatus").html("재직");
				}else{
					$("span#m_resignationstatus").html("퇴직");
				}
				
				$("span#m_resignationday").html(json.resignationday);
				
				if(json.fk_vstatus == 0){
					$("span#m_fk_vstatus").html("근무중");
				}else{
					$("span#m_resignationstatus").html("휴가중");
				}
				
				
				$("span#m_salary").html(json.salary.toLocaleString('en'));
			*/	
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
		});// end of $.ajax 
	 }	
	// 연락처 수정
    function mobileEdit(pk_empnum){
    	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
		
    	const origin_myphone = $("#td_phone").html();
    	//alert("testorigin:"+ origin_myphone);
		const myphone = $("#td_phone").text();
		//alert("test1:"+myphone); 
		
 	      $("a#btn_mobileEdit").hide(); // "후기수정" 글자 감추기
 	      $('input[name=myphone]').attr('value',myphone);
 	      // "후기수정" 을 위한 엘리먼트 만들기 
 	      let html = "<input id='edit_textarea' type='text' val='' name='myphone' style='height: 25px; width: 200px'/>";
 	          html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_OK'><span>확인</span></button></div>";
 	          html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_NO'><span>취소</span></button></div>";  
 	          
 	      // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  
 	     
 	      $("#td_phone").html(html); 
 	      $('input[name=myphone]').attr('value',myphone);
 	      // 수정취소 버튼 클릭시 
 	      $("button#btnPhoneUpdate_NO").click(function(){
 	         $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기  
 	         $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
 	      });
 	      
 	      // 수정완료 버튼 클릭시 
 	      $("button#btnPhoneUpdate_OK").click(function(){
 	         alert(pk_empnum); // 수정할 사원 번호 
 	         alert($('input[name=myphone]').val()); // 수정할 제품후기 내용
 	         const new_phone = $('input[name=myphone]').val();
 	         
 	         $.ajax({
 	            url:"<%= ctxPath%>/myPhoneEditEnd.groovy",
 	            type:"POST",
 	            data:{"pk_empnum":pk_empnum
 	                ,"myphone":$('input[name=myphone]').val()},
 	            dataType:"JSON",
 	            success:function(json) { // {"n":1} 또는 {"n":0}
 	               if(json.isSuccess) {
 	            	  alert("변경되었습니다.")
 	            	  $("#td_phone").html(new_phone); // 원래의 제품후기 엘리먼트로 복원하기  
 	         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
 	               }
 	               else {
 	                  alert("수정이 실패되었습니다.");
 	                  $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기  
	         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
 	               }
 	            },
 	            error: function(request, status, error){
 	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	            }   
 	         });
 	         
 	      });
 	   
    }//end of function updateMyReview(index, review_seq){}---------------------- 
	
    
    //이메일 수정
    
    function emailEdit(pk_empnum){
    	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
    	
    	const origin_myemail = $("#td_email").html();
    	//alert("testorigin:"+ origin_myphone);
		const myemail = $("#td_email").text();
		//alert("test1:"+myphone); 
		
 	      $("a#btn_emailEdit").hide(); // "후기수정" 글자 감추기
 	      $('input[name=myemail]').attr('value',myemail);
 	      // "후기수정" 을 위한 엘리먼트 만들기 
 	      let html = "<input id='edit_textarea' type='email' val='' name='myemail' style='height: 25px; width: 200px'/>";
 	          html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_OK'><span>확인</span></button></div>";
 	          html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_NO'><span>취소</span></button></div>";  
 	          
 	      // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  
 	     
 	      $("#td_email").html(html); 
 	      $('input[name=myemail]').attr('value',myemail);
 	      // 수정취소 버튼 클릭시 
 	      $("button#btnEmailUpdate_NO").click(function(){
 	         $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기  
 	         $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
 	      });
 	      
 	      // 수정완료 버튼 클릭시 
 	      $("button#btnEmailUpdate_OK").click(function(){
 	         alert(pk_empnum); // 수정할 사원 번호 
 	         alert($('input[name=myemail]').val()); // 수정할 제품후기 내용
 	         const new_email = $('input[name=myemail]').val();
 	         
 	         $.ajax({
 	            url:"<%= ctxPath%>/myEmailEditEnd.groovy",
 	            type:"POST",
 	            data:{"pk_empnum":pk_empnum
 	                ,"myemail":$('input[name=myemail]').val()},
 	            dataType:"JSON",
 	            success:function(json) { // {"n":1} 또는 {"n":0}
 	               if(json.isSuccess) {
 	            	  alert("변경되었습니다.")
 	            	  $("#td_email").html(new_email); // 원래의 제품후기 엘리먼트로 복원하기  
 	         		  $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
 	               }
 	               else {
 	                  alert("수정이 실패되었습니다.");
 	                  $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기  
	         		  $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
 	               }
 	            },
 	            error: function(request, status, error){
 	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	            }   
 	         });
 	         
 	      });
    	
    }//end of function picEdit(pk_empnum){}------------------------

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
	        					<img class="myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-myprofile"  />
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
	        				<li class="infoList"><a style="color: #555 !important ;"   href="" data-toggle="modal" data-target="#myModal"><i class="far fa-user"></i> 내 프로필</a></li>
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
					        <button class="btn-modi js-btn-modi btn-bottom"  onclick="getUserInfo()" data-toggle="modal" data-target="#myModal2" style=" cursor: pointer;" >
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
     

     <div class="modal-body scroll" style="width: 100%; overflow:auto;  ">
        <form action="<%=ctxPath%>/MyInfo.groovy"> 
        <div>
         	<img class="rounded" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  style="width:100px; height: 100px; overflow: hidden;" />
         	<a onclick="picEdit()"  type="button" ><i class="far fa-edit"></i></a>
        </div>
        <!-- <form name="InfoFrm"> -->
        <div>
	        <table id="tbl_myInfo table">
	        	
			      <tr>
			        <th>사원번호</th>
			        <td id="td_pk_empnum"><span id="span_pk_empnum"></span></td>
			        
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
			        <td id="td_address"></td>
			        <td><a onclick="picEdit(pk_empnum)"  type="button" ><i class="far fa-edit"></i></a></td>
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
			        <td><strong>비밀번호 재설정이 가능합니다.</strong>
						<span>비밀번호 입력 (8~20자 영문, 숫자, 특수문자 조합)</span>
						<button>비밀번호 재설정</button> 
					</td>
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
			
		    
		    
	
 }); 

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
	 
} 
</script>

  