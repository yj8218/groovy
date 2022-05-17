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

div#myProfileCard div.card-body ul{
	margin:0;
	padding:0;
}

div#myProfileCard div.card-body ul li i {
    width: 40px;
    height: 40px;
    text-align: center;
}
div#myProfileCard div.card-body ul li span {
    width: 280px;
    padding: 0 0 0 10px;
    display: inline-block;
    border-bottom: 1px solid #eee;
}

</style>
<script type="text/javascript">
	let b_flagEmailDuplicateClick = false;
	let b_flagEmailDuplicateClick2 = false;
	//  "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.

	
	
	$(document).ready(function(){
	  	$('[data-toggle="tooltip"]').tooltip();   
	  	$('#myProfileCard').appendTo("body"); 


	  	getUserInfo();
	  	
	});
	
	
	$(document).mouseup(function (e){
		if($(".header-form-popup").has(e.target).length === 0){
			$(".header-form-popup").hide();
		}
	});
	
	/* ESC 키 누를시 팝업 닫기 */
	$(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 
	    if (code == 27) { // 27은 ESC 키번호
	        $('.header-form-popup').hide();
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
	
	function myProfileCard(){
		document.getElementById("myProfileCard").style.display = "block"; 
		
	}
	
	
	 //================================ ●●● 로그인한 유저 정보 불러오기 ●●●================================//
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
				const imgUrl = "<%=ctxPath %>/resources/images/프로필사진/"+json.emppicturename; 
				//$("#empImg").attr("src", imgUrl);
				$("img.userimg").attr("src", imgUrl);
			//	alert("나와"+json.pk_empnum);
				$("td#td_pk_empnum").html(json.pk_empnum);
				$("td#td_name").html(json.name);
				$("td#td_birthday").html(json.birthday);
				
				if(json.gender == 1){
					$("td#td_gender").html("남자");
				}else{
					$("td#td_gender").html("여자");
				}
				
				//	$("td#td_address").html("("+json.postcode+") "+json.address+"&nbsp;"+json.detailaddress);
				$("span#my_postcode").html(json.postcode);
				$("span#my_address").html(json.address)
				$("span#my_detailAddress").html(json.detailaddress);
				$("span#my_extraAddress").html(json.extraaddress);
				
				$("span#span_phone").html(json.phone); 
				$("td#td_phone").html(json.phone);
				
				$("span#span_email").html(json.email);
				$("td#td_email").html(json.email);
				
				// 부서 직위
		/*		$("span#m_deptnamekor").html(json.deptnamekor);
				$("span#m_spotnamekor").html(json.spotnamekor);
				
				$("span#m_startday").html(json.startday);
				
			
				$("span#m_salary").html(json.salary.toLocaleString('en'));
			*/	
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
		});// end of $.ajax 
	 }	
	 
	//================================ ●●● 연락처 수정 ●●●================================//
   	function mobileEdit(pk_empnum){
	   	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
			
	   	const origin_myphone = $("#td_phone").html();
	   	//alert("testorigin:"+ origin_myphone);
			const myphone = $("#td_phone").text();
			//alert("test1:"+myphone); 
			
		      $("a#btn_mobileEdit").hide(); // "후기수정" 글자 감추기
		      $('input[name=myphone]').attr('value',myphone);
		      // "후기수정" 을 위한 엘리먼트 만들기 
		      let html = "<input id='edit_textarea' type='text' val='' name='myphone' required placeholder='연락처' style='height: 25px; width: 200px'/>";
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
		            	  $("#td_phone").html(new_phone); 
		            	  $("span#span_phone").html(new_phone); 
		         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
		               }
		               else {
		                  alert("수정이 실패되었습니다.");
		                  $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기
		                  $("span#span_phone").html(origin_myphone); 
		         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
		               }
		            },
		            error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }   
		         });
		         
		      });
		   
   	}//end of function mobileEdit(pk_empnum){}---------------------------- 
	
   
   	//================================ ●●● 이메일 수정 ●●●================================//
   	function emailEdit(pk_empnum){
   	
	   	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
	   	
	   	const origin_myemail = $("#td_email").html();
	   	//alert("testorigin:"+ origin_myphone);
			const myemail = $("#td_email").text();
			//alert("test1:"+myphone); 
			
		      $("a#btn_emailEdit").hide(); // "후기수정" 글자 감추기
		      $('input[name=myemail]').attr('value',myemail);
		      // "후기수정" 을 위한 엘리먼트 만들기 
		      let html = "<input id='edit_textarea' type='email' val='' name='myemail'  required placeholder='이메일' style='height: 25px; width: 200px'/><span id='emailCheck' style='color: red; font-size: 12px;'>올바른 이메일 형식이 아닙니다.</span>";
		          html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_OK'><span>확인</span></button></div>";
		          html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_NO'><span>취소</span></button></div>";  
		          
		      // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  
		     
		      $("#td_email").html(html); 
		      $('input[name=myemail]').attr('value',myemail);
		      $('span#emailCheck').hide();
		      
		
		      
		      // 수정취소 버튼 클릭시 
		      $("button#btnEmailUpdate_NO").click(function(){
		         $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기  
		         $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
		      });
		      
		      // 수정완료 버튼 클릭시 
		      $("button#btnEmailUpdate_OK").click(function(){
		    //     alert(pk_empnum); // 수정할 사원 번호 
		     //    alert($('input[name=myemail]').val()); // 수정할 제품후기 내용
		         const new_email = $('input[name=myemail]').val();
		         
		     // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		 	    	let flagBool = false;
		 	    	
		 	    	$("input[name=myemail]").each( (index, item)=>{
		 	    		const data = $(item).val().trim();
		 	    		if(data == "") {
		 	    			flagBool = true;
		 	    			return false;
		 	    			/*
		 	    			   for문에서의 continue; 와 동일한 기능을 하는것이 
		 	    			   each(); 내에서는 return true; 이고,
		 	    			   for문에서의 break; 와 동일한 기능을 하는것이 
		 	    			   each(); 내에서는 return false; 이다.
		 	    			*/
		 	    		}
		 	    	});
		 	    	
		 	    	if(flagBool) {
		 	    		alert("필수입력란은 모두 입력하셔야 합니다.");
		 	    		return; // 종료
		 	    	}
		     
		     
				//////////////////////////////////				
					const $target = $("input#edit_textarea");
					
					// 이메일 정규표현식 객체 생성
			        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
					
				 	const bool = regExp.test($target.val());
					
				 	if(!bool){ // 이메일 정규표현식에 위배시
						$("input#edit_textarea").prop("disabled", true);
						$target.prop("disabled",false);
						
					    $target.next().show();
						$target.focus();
						$("span#emailCheck").html("");
						
						b_flagemailduplicateClick2 = false;
					}
					else{ // 이메일정규표현식에 통과시
						$("input#edit_textarea").prop("disabled", false);
						$target.next().hide();
						
						b_flagemailduplicateClick2 = true;
						
						$.ajax({
			        	      url:"<%= ctxPath%>/empDuplicatedCheck.groovy",
			        	      data:{"checkColumn":"email",
			        	    	  "checkValue":$target.val()},
			        	      success:function(text){
			        	    	  
			        	    	  const json = JSON.parse(text); // JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환
			        	    	  
			       	    	      // 이메일 중복검사 결과가 -> true 면 중복된거고, false 면 중복안된것
			           	    	  if(json.isDuplicatedInfoVal) { // 중복인경우
			           	    		  alert($("input#edit_textarea").val() +" 은 이미 사용중인 이메일입니다");
			           	    		  $("input#edit_textarea").val("");
			           	    	  }
			           	    	  else { // 중복아닌경우
			           	    		//alert($("input#edit_textarea").val() +" 은 사용가능한 이메일입니다");
			           	    	  }	  
			        	      },
			        	      error:function(request, status, error){
			        	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        	      }
			          	});// end of ajax
					}
				
				 	
				 /* 	if(!b_flagemailduplicateClick2){// 이메일 중복확인 버튼을 클릭하지 않았을 때
						alert("이메일 중복확인 버튼을 클릭하여 이메일 중복검사를 하세요");
						return; // 종료
					} */
				 	
		         /////////////////////////////////
		 	     
		     });   
		         
   	
   	}//end of function emailEdit(pk_empnum){}------------------

   

	//이메일 중복여부 검사하기
 function isExistEmailCheck() {
 	
 	$("span#emailCheckResult").hide();
 	
 	b_flagEmailDuplicateClick = true;
 	// 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
 	
 	// 첫번째 방법
 	$.ajax({
 		url:"<%= ctxPath%>/myEmailEditEnd.groovy",
 		type:"post",
 		data:{"pk_empnum":pk_empnum
            ,"myemail":$('input[name=myemail]').val()},
 		dataType:"json",
 		success:function(json) {
 			
 			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
 	 			const bool = regExp.test($("input#email").val());  	
 	 			
 	 				if(json.isSuccess) {	// 입력한 $("input#email").val() 값이 이미 사용중이라면
 	 					alert("변경되었습니다.")
  	            	  $("#td_email").html(new_email); // 원래의 제품후기 엘리먼트로 복원하기  
  	         		  $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
  	         		  $("span#span_email").html(new_email);
 	 				} else {	// 입력한 $("input#email").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
 	 				 alert("수정이 실패되었습니다.");
	                  $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기  
	         		  $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
 	 				}
 			
 		},
 		error: function(request, status, error){
 			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 		}
 	});		
 	
 }// end of function isExistEmailCheck() {}----------------------------------

   
   
   	//================================ ●●● 주소 수정 ●●●================================//
   function addressEdit(pk_empnum){
   
   	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
   	const origin_addr =  $("#td_address").html();
   	//alert("testorigin:"+ origin_addr);
   	const origin_mypostcode = $("span#my_postcode").html();
   	const origin_myaddress = $("span#my_address").html();
   	const origin_myetailAddress = $("span#my_detailAddress").html();
   	const origin_myextraAddress = $("span#my_extraAddress").html();
   	//alert("testorigin:"+ origin_myaddress);
		
   	const mypostcode = $("span#my_postcode").text();
   	const myaddress = $("span#my_address").text();
   	const mydetailAddress = $("span#my_detailAddress").text();
   	const myextraAddress = $("span#my_extraAddress").text();
		//alert("mypostcode:"+mypostcode);
			
			$("a#btn_addressEdit").hide(); // "후기수정" 글자 감추기
			
			// "후기수정" 을 위한 엘리먼트 만들기 
			let html = "<input id='edit_postcode'      class='addr'   type='text' val='' name='mypostcode' size='6' maxlength='5' required placeholder='우편번호' style='height: 25px; width: 200px'/><img id='zipcodeSearch' src='<%=ctxPath %>/resources/images/common/b_zipcode.gif' style='vertical-align: middle;' />"+
			 			 "<input id='edit_address'       class='addr'   type='text' val='' name='myaddress'  maxlength='20' size='40' required placeholder='주소' style='height: 25px; width: 200px'/>"+
			 			 "<input id='edit_detailAddress' class='addr'   type='text' val='' name='mydetailAddress'  size='40' required placeholder='상세주소'  style='height: 25px; width: 200px'/>"+
			 			 "<input id='edit_extraAddress'                 type='text' val='' name='myextraAddress'  size='40' required placeholder='추가주소' style='height: 25px; width: 200px'/>";
			     html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnAddrUpdate_OK'><span>확인</span></button></div>";
			     html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnAddrUpdate_NO'><span>취소</span></button></div>";  
			     
			 // 수정 버튼 누르면 뜰 input 태그들에 값 넣어주기
			$("#td_address").html(html); 
			$('input[name=mypostcode]').attr('value',mypostcode);
			$('input[name=myaddress]').attr('value',myaddress);
			$('input[name=mydetailAddress]').attr('value',mydetailAddress);
			$('input[name=myextraAddress]').attr('value',myextraAddress);
	      
			//우편 번호 찾기 선택 시 
			$("img#zipcodeSearch").click(function() {
				      new daum.Postcode({
			           oncomplete: function(data) {
			               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			               let addr = ''; // 주소 변수
			               let extraAddr = ''; // 참고항목 변수
			
			               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                   addr = data.roadAddress;
			               } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                   addr = data.jibunAddress;
			               }
			               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			               if(data.userSelectedType === 'R'){
			                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                       extraAddr += data.bname;
			                   }
			                   // 건물명이 있고, 공동주택일 경우 추가한다.
			                   if(data.buildingName !== '' && data.apartment === 'Y'){
			                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                   }
			                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                   if(extraAddr !== ''){
			                       extraAddr = ' (' + extraAddr + ')';
			                   }
			                   // 조합된 참고항목을 해당 필드에 넣는다.
			                   document.getElementById("edit_extraAddress").value = extraAddr;
			               
			               } else {
			                   document.getElementById("edit_extraAddress").value = '';
			               }
			
			               // 우편번호와 주소 정보를 해당 필드에 넣는다.
			               document.getElementById('edit_postcode').value = data.zonecode;
			               document.getElementById("edit_address").value = addr;
			               // 커서를 상세주소 필드로 이동한다.
			               document.getElementById("edit_detailAddress").focus();
			           }
			       }).open();
						
			});
	   
	   
	      // 수정취소 버튼 클릭시 
	      $("button#btnAddrUpdate_NO").click(function(){
	         $("#td_address").html(origin_addr); // 원래의 제품후기 엘리먼트로 복원하기  
	         $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
	      });
	      
	      // 수정완료 버튼 클릭시 
	      $("button#btnAddrUpdate_OK").click(function(){
	         //alert(pk_empnum); // 수정할 사원 번호 
	         //alert($('input[name=mypostcode]').val()); // 수정할 제품후기 내용
	         const new_postcode = $('input[name=mypostcode]').val();
	         const new_address = $('input[name=myaddress]').val();
	      	 const new_detailAddress = $('input[name=mydetailAddress]').val();
	      	 const new_extraAddress = $('input[name=myextraAddress]').val();
	         
	         
	 	     // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
	 	    	let flagBool = false;
	 	    	
	 	    	$("input.addr").each( (index, item)=>{
	 	    		const data = $(item).val().trim();
	 	    		if(data == "") {
	 	    			flagBool = true;
	 	    			return false;
	 	    			/*
	 	    			   for문에서의 continue; 와 동일한 기능을 하는것이 
	 	    			   each(); 내에서는 return true; 이고,
	 	    			   for문에서의 break; 와 동일한 기능을 하는것이 
	 	    			   each(); 내에서는 return false; 이다.
	 	    			*/
	 	    		}
	 	    	});
	 	    	
	 	    	if(flagBool) {
	 	    		alert("필수입력란은 모두 입력하셔야 합니다.");
	 	    		return; // 종료
	 	    	}
	 	    	
	         $.ajax({
	            url:"<%= ctxPath%>/myAddressEditEnd.groovy",
	            type:"POST",
	            data:{"pk_empnum":pk_empnum
	                ,"mypostcode":$('input[name=mypostcode]').val()
	             	,"myaddress":$('input[name=myaddress]').val()
	              	,"mydetailAddress":$('input[name=mydetailAddress]').val()
	               	,"myextraAddress":$('input[name=myextraAddress]').val()
	            },
	            dataType:"JSON",
	            success:function(json) { // {"n":1} 또는 {"n":0}
	               if(json.isSuccess) {
	            	  alert("변경되었습니다.")
	            	  $("#td_address").html(origin_addr);
	            	  $("span#my_postcode").html(new_postcode); // 수정된 엘리먼트 넣기
	            	  $("span#my_address").html(new_address); 
	            	  $("span#my_detailAddress").html(new_detailAddress); 
	            	  $("span#my_extraAddress").html(new_extraAddress); 
	         		  $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
	               }
	               else {
	                  alert("수정이 실패되었습니다.");
	                  $("#td_address").html(origin_addr); // 원래의 제품후기 엘리먼트로 복원하기  
	                  $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
	               }
	            },
	            error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }   
	         });
	         
	      });
   	
   }//end of function addressEdit(pk_empnum){}------------------------
   
   
   
   
   //================================ ●●● 비밀번호 수정 ●●●================================//
   function pwdEdit(pk_empnum){
   	
   	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
   	var loginpwd = "${sessionScope.loginuser.pwd}";
   	alert(loginpwd);
   	const origin_mypwd = $("#td_pwd").html();
   	alert("testorigin:"+ origin_mypwd);
		
   	//const myemail = $("#td_email").text();
		//alert("test1:"+myphone); 
		
	      $("a#btn_pwdEdit").hide(); // "비밀번호 수정" 글자 감추기
	     
	      // "비번수정" 을 위한 엘리먼트 만들기 
	      let html = "<table><tr class=''>비밀번호는 8~16자의 영문 대소문자,숫자,특수문자를  포함해야 합니다.</tr><tr>";
			  html += "<th><label for='originpwd'>현재 비밀번호&nbsp;<span id='star'>*</span></label></th>";
		   	  html += "<td><input type='password' class='requiredInfo' id='originpwd' name='originpwd' size='20' maxlength='20' required placeholder='비밀번호를 입력해주세요' /><span class='error'  style='color: red;'>암호가 올바르지 않습니다.</span></td>";
		   	  html += "</tr>";
	          html += "<th><label for='mypwd'>비밀번호&nbsp;<span id='star'>*</span></label></th>";
	    	  html += "<td><input type='password' class='requiredInfo' id='mypwd' name='mypwd' size='20' maxlength='20' required placeholder='비밀번호를 입력해주세요' /><span class='error' style='color: red;'>암호가 올바르지 않습니다.</span></td>";
	    	  html += "</tr>";
	    	  html += "<tr>";
	    	  html += "<th><label class='title' for='pwdcheck'>비밀번호확인&nbsp;<span id='star'>*</span></label></th>";
	    	  html += "<td><input type='password' class='requiredInfo' id='pwdCheck' size='20' maxlength='20' required placeholder='비밀번호를 다시 입력해주세요'  /><span class='error' style='color: red;' >암호가 일치하지 않습니다.</span></td>";
	    	  html += "</tr></table>";
	          html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPwdUpdate_OK'><span>확인</span></button></div>";
	          html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPwdUpdate_NO'><span>취소</span></button></div>";  
	          
	      // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  
	     
	      $("#td_pwd").html(html); 
	      
	      $("span.error").hide();
	      /*
	     // 아이디가 originpwd 제약 조건 
	    	$("input#originpwd").blur(() => {
	 	   		const $target = $(event.target);
	 	   		
	 	   		const originpwd = $target.val();
	 	   		
	 	   		
	 	   		
	 	 	  	if(originpwd != loginpwd){ // 기존암호 확인값이 다른 경우
	 	   			$target.prop("disabled",false);
	 	   			$("input#originpwd").prop("disabled",false);
	 	   			
	 	   		//	$target.next().show();
	 	   		// 	또는
	 	   			$target.parent().find(".error").show();
	 	   			
	 	   		} else {
	 	   			// 암호와 암호확인값이 같은 경우
	 	   			//	$target.next().hide();
	 	   			// 	또는
	 	   			$target.parent().find(".error").hide();
	 	   		}
	 	   	}); 
	      */
	      
 	     // 아이디가 pwd 제약 조건 
	    	$("input#mypwd").blur(() => {
	 	   		const $target = $(event.target);
	 	   		
	 	   		const regExp = new RegExp(/^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	 	   		// 영어대/소문자 , 숫자, 특수기호를 모두 사용한 8글자 이상 16자 이하로 구성된 정규표현식
	 	   		
	 	   		const bool = regExp.test($target.val());  
	 	   		
	 	   		if(!bool){ // !bool == false 암호가 정규표현식에 위배된 경우
	 	   			// 입력하지 않거나 공백만 입력했을 경우
	 	   			$target.prop("disabled",false);
	 	   		//	$target.next().show();
	 	   		// 	또는
	 	   			$target.parent().find(".error").show();
	 	   			
	 	   		} else {
	 	   			// bool == true 암호가 정규표현식에 맞는 경우
	 	   			$target.parent().find(".error").hide();
	 	   		}
	 	   	 
	    	}); 
	    	
	 	    // 아이디가 pwdcheck 제약 조건 패스워드 확인 검사
	 	   	$("input#pwdCheck").blur(() => {
	 	   		const $target = $(event.target);
	 	   		const mypwd = $("input#mypwd").val();
	 	   		const pwdcheck = $target.val();
	 	   		
	 	   		if(pwdcheck != mypwd){ // 암호와 암호확인값이 다른 경우 
	 	   			$target.prop("disabled",false);
	 	   			$("input#mypwd").prop("disabled",false);
	 	   			
	 	   		//	$target.next().show();
	 	   		// 	또는
	 	   			$target.parent().find(".error").show();
	 	   			
	 	   		} else {
	 	   			// 암호와 암호확인값이 같은 경우
	 	   			//	$target.next().hide();
	 	   			// 	또는
	 	   			$target.parent().find(".error").hide();
	 	   		}
	 	   	}); 

	     // $('input[name=myemail]').attr('value',myemail);
	      // 수정취소 버튼 클릭시 
	      $("button#btnPwdUpdate_NO").click(function(){
	         $("#td_pwd").html(origin_mypwd); // 원래의 제품후기 엘리먼트로 복원하기  
	         $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
	      });
	      
	      // 수정완료 버튼 클릭시 
	      $("button#btnPwdUpdate_OK").click(function(){
	         alert(pk_empnum); // 수정할 사원 번호 
	         alert($('input[name=mypwd]').val()); // 수정할 제품후기 내용
	         const new_pwd = $('input[name=mypwd]').val();
	         
	 	    

	 	     // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
	 	    	let flagBool = false;
	 	    	
	 	    	$("input.requiredInfo").each( (index, item)=>{
	 	    		const data = $(item).val().trim();
	 	    		if(data == "") {
	 	    			flagBool = true;
	 	    			return false;
	 	    			/*
	 	    			   for문에서의 continue; 와 동일한 기능을 하는것이 
	 	    			   each(); 내에서는 return true; 이고,
	 	    			   for문에서의 break; 와 동일한 기능을 하는것이 
	 	    			   each(); 내에서는 return false; 이다.
	 	    			*/
	 	    		}
	 	    	});
	 	    	
	 	    	if(flagBool) {
	 	    		alert("필수입력란은 모두 입력하셔야 합니다.");
	 	    		return; // 종료
	 	    	}
	 	    	
	 	   		
	         
	         $.ajax({
	            url:"<%= ctxPath%>/myPwdEditEnd.groovy",
	            type:"POST",
	            data:{"pk_empnum":pk_empnum
	            	,"originpwd":$('[name=originpwd]').val()
	                ,"mypwd":$('[name=mypwd]').val()},
	            dataType:"JSON",
	            success:function(json) { // {"n":1} 또는 {"n":0}
	               if(json.isSuccess) {
	            	  alert("변경되었습니다.")
	            	  $("#td_pwd").html(origin_mypwd);  // 원래의 제품후기 엘리먼트로 복원하기  
	         		  $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
	               }
	               else {
	                  alert("수정이 실패되었습니다.");
	                  $("#td_pwd").html(origin_mypwd);  // 원래의 제품후기 엘리먼트로 복원하기  
	         		  $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
	               }
	            },
	            error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }   
	         });
	         
	      });
   	
   }//end of function pwdEdit(pk_empnum){}------------------
   
   
   //================================ ●●● 연락처 수정 ●●●================================//
   function mobileEdit(pk_empnum){
   	var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
		
   	const origin_myphone = $("#td_phone").html();
   	//alert("testorigin:"+ origin_myphone);
		const myphone = $("#td_phone").text();
		//alert("test1:"+myphone); 
		
	      $("a#btn_mobileEdit").hide(); // "후기수정" 글자 감추기
	      $('input[name=myphone]').attr('value',myphone);
	      // "후기수정" 을 위한 엘리먼트 만들기 
	      let html = "<input id='edit_textarea' type='text' val='' name='myphone' required placeholder='연락처' style='height: 25px; width: 200px'/>";
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
	            	  $("#td_phone").html(new_phone); 
	            	  $("span#span_phone").html(new_phone); 
	         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
	               }
	               else {
	                  alert("수정이 실패되었습니다.");
	                  $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기
	                  $("span#span_phone").html(origin_myphone); 
	         		  $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
	               }
	            },
	            error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }   
	         });
	         
	      });
	   
   }//end of function updateMyReview(index, review_seq){}----------------------

   
   function uploadFile(pk_empnum){
       var form = $('#FILE_FORM')[0];
       var formData = new FormData(form);
       formData.append("fileObj", $("#input-file")[0].files[0]);

       $.ajax({
       	url:"<%= ctxPath%>/myphotoEdit.groovy",
                   processData: false,
                   contentType: false,
                   data: formData,
                   type: 'POST',
                   success: function(result){
                       alert("업로드 성공!!");
                   }
           });
       
       var options = {
               dataType:"text",//결과
               success:function(responseText){
                   alert("업로드 성공!!");
               }, error:function(e){e.responseText();}
           };
           
       
       $("#FILE_FORM").ajaxForm(options).submit();


   }
	
	
	
</script>
 
 <!-- =================상단 네비게이션 시작 =====================-->
<div class="header-header">
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
        	
        	
     <!-- ●●● 조직도 팝업 ●●●================================-->
        		<a class="iconbar" onclick=" OpenOrganizationForm()" type="button" id="organizationTopButton " data-toggle="tooltip" data-placement="bottom" title="조직도" style="display: inline-block; ">
                    <i class="fas fa-sitemap"></i>
                </a>
                
                
                <div class="header-form-popup" id="myForm" >
					  	<article action="" class="header-form-container" >
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
				
				
				
      <!-- ●●● 채팅 팝업 ●●●================================-->
                <a class="iconbar" onclick=" OpenChatForm()" type="button" data-toggle="tooltip" data-placement="bottom" title="채팅"><i class="fas fa-comment"></i></a>
                
                <div class="header-form-popup" id="myForm2" >
	                	<article action="" class="header-form-container">
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
				
	<!-- ●●● 알림 팝업 ●●●================================-->
                <a class="iconbar" onclick="OpenAlarmForm()" type="button" id="alarmTopButton" data-toggle="tooltip" data-placement="bottom" title="알림">
	                <i class="fas fa-bell"></i>
            	</a>
            	
            	<div class="header-form-popup" id="myForm3">
                	<article action="" class="header-form-container">
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
            	
       <!-- ●●● 유저정보 팝업 ●●●================================-->
            	<!-- <a class="iconbar" onclick="OpenMyinfoForm()"  type="button" ><i class="fas fa-user-circle"></i></a> -->
        		<a class="iconbar" onclick="OpenMyinfoForm()"  type="button" ><img class="myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-myprofile"  /></a>
        		<div class="myinfo-popup layer_pop" id="myForm4">
        		
        			<div class="myinfo-container" style="vertical-align: middle; padding: auto;">
	        			
	        			<ul style="list-style: none; margin:0; padding:0;">
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
	        				<li class="infoList"><a style="color: #555 !important ;"    onclick="getUserInfo()" href="" data-toggle="modal" data-target="#myProfileCard"><i class="far fa-user"></i> 내 프로필</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;"  href="#"><i class="fas fa-cog"></i> 환경설정</a></li>
	        				<li class="infoList"><a style="color: #555 !important ;" href="<%=ctxPath%>/logout.groovy"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
	        				
	        			</ul>
	        			
        			</div>
        			
        		</div>
        		
        	</div><!-- //div nav_right -->
        	
	</nav>


	<!-- ●●● 유저정보 팝업 => [유저프로필카드]  ●●●================================-->
		<div class="modal animate" id="myProfileCard"  >
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
					        <button class="btn-modi js-btn-modi btn-bottom" onclick="myProfileCard()" data-toggle="modal" data-target="#myProfileCard2" style=" cursor: pointer;" >
					       		정보수정
					            <i class="far fa-address-card"></i>
					        </button>
					     </div>
					     
		  			</div> 
				</div>
		 	</div>
		</div>
				  
	<!-- ●●● 유저정보 팝업 => 유저프로필카드 => [회원정보수정] ●●●================================-->
	<div class="modal" id="myProfileCard2" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; background: rgba(0,0,0,.6);" >
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
					      	<tr>
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

</div><!-- div.header 가 닫혔다. -->
 <!-- =================상단 네비게이션 끝 =====================-->


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

  