<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   	String ctxPath = request.getContextPath();

	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	
	int portnumber = request.getServerPort();
	
	String serverName = "http://" + serverIP + ":" + portnumber;
%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Outlined" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Sharp" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Two+Tone" rel="stylesheet"/>
<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/leejh/style.css" />

<style type="text/css">

</style>

<script type="text/javascript">

	
	$(document).ready(function() {

		 $("div.showBoardDetail").hide();
		
	    $(document).on("click", "div.card-header button.close", function(){
			$("div.showBoardDetail").empty();
			$("div.showBoardDetail").hide();
		});
	    $('#writeBoardModal').on('show.bs.modal', function (e) {
	    	$("div.showBoardDetail").hide();
		 });
	    $('#editBoardModal').on('show.bs.modal', function (e) {
	    	$("div.showBoardDetail").hide();
			  
		 });
	    
	    $('#writeBoardModal').on('hidden.bs.modal', function (e) {
	    	$("#content").empty();
	    });
		
	    
	    
		showEmpByDept();
		
		goReadBoard(1);
		
		
		//goViewComment(1);
		
		$("table.tblEmpList tr:last-child").css({'border-bottom':'none'});
		
		$("i.fa-thumbtack").click(function() {
			alert("상단 고정 클릭 => 상단 고정 하기");
		});
		
		// 프로젝트 즐겨찾기 토글
		$("i.fa-star").click(function() {
			if($(this).hasClass('far')) {
				$(this).removeClass('far');
				$(this).addClass('fas');
			}
			else {
				$(this).removeClass('fas');
				$(this).addClass('far');
			}
		});
		
		// 게시글 북마크 토글
		$("i.fa-bookmark").click(function() {
			if($(this).hasClass('far')) {
				$(this).removeClass('far');
				$(this).addClass('fas');
			}
			else {
				$(this).removeClass('fas');
				$(this).addClass('far');
			}
		}); // $("i.fa-bookmark").click(function() {})
		
		// 단체 채팅방 개설
		$("button#groupchat").click(function() {
			var openchatConfirm = confirm("프로젝트 채팅방을 개설하시겠습니까?\n현재 접속중인 직원 모두가 참여하는 채팅방입니다.");
			
			if(openchatConfirm) {
				const url = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
		        const popup_name = "multichat";
		        const option = "width = 450, height = 650, top = 300, left = 600";
				
				window.open("", popup_name, option);
				
				const frm = document.openGroupChatFrm;
				frm.target = popup_name;
				frm.action = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
				frm.method = "get";
				frm.submit();
			}
		});
		
		// 프로젝트 참여자명 검색 시 검색 목록 보여주기
		$("div#searchEmpList").hide();
		
		$("input#searchEmp").keyup(function() {
			
			const wordLength = $(this).val().trim().length;
			
			if(wordLength == 0) {
				$("div#searchEmpList").hide();
				$("div#defaultEmpList").show();
			}
			else {
				$.ajax({
					url:"<%= ctxPath %>/searchEmp.groovy",
					type:"POST",
					data:{"searchType":"name",
						  "searchWord":$("input#searchEmp").val()},
					dataType:"JSON",
					success:function(json) {
						
						let html = "";
						if(json.length > 0) { // 검색된 데이터가 있는 경우
							$.each(json, function(index, item) {
								html += "<tr style='border-bottom: solid 1px #eeeeee;'>";
								html += "	<td class='empProfile' style='cursor: pointer;' onclick='javascript:showEmpProfile(\""+item.pk_empnum+"\")'>";
								html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/프로필사진/"+ item.emppicturename +"' style='border-radius: 15px;'>";
								html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
								html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>"	
								html += "	</td>";
								html += "	<td align='right'>";
								html += "		<span style='background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;'>" + item.spotnamekor + "</span>";
								html += "		<i class='fas fa-ellipsis-v ml-2' data-toggle='dropdown'></i>";
								html += "		<div class='dropdown-menu prjSetting my-0 py-0'>";
								html += "			<a class='dropdown-item' href=''>내보내기</a>";
								html += "			<a class='dropdown-item' href=''>" + item.spotnamekor + "해제</a>";
								html += "		</div>";
								html += "	</td>";
								html += "</tr>";
							});
						}
						else {
							html += "<tr>";
							html += "	<td colspan='2' align='center'>검색 결과가 없습니다.</td>";
							html += "</tr>";
						}
						
						$("table#tblSearchEmpList").html(html);
						$("div#defaultEmpList").hide();
						$("div#searchEmpList").show();
					},
					error: function(request, status, error) {
	                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
				}); // end of $.ajax({})
			}
			
		}); // end of $("input#searchWord").keyup(function() {})
		
		
		// 부서별 직원 목록 보여주기
		$("a#dept").click(function() {
			
			const $target = $(event.target);
			const pk_deptnum = $target.next().val();
			const deptnameeng = $target.next().next().val();
			
			$.ajax({
				url:"<%= ctxPath %>/showEmpByDept.groovy",
				type:"GET",
				data:{"pk_deptnum":pk_deptnum},
				dataType:"JSON",
				success:function(json) {
					
					let html = "<table class='tblEmpList' id='tblEmpList' style='width: 100%;'>";
					
					$.each(json, function(index, item) {
						html += "<tr style='border-bottom: solid 1px #eee;'>";
						html += "	<td class='empProfile' style='cursor: pointer;' onclick='javascript:showEmpProfile(\""+item.pk_empnum+"\")'>";
						html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/프로필사진/"+ item.emppicturename +"' style='border-radius: 15px;'";
						html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
						html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>";
						html += "	</td>";
						html += "	<td align='right'>";
						html += "		<i class='far fa-comment-dots fa-lg' onclick='javascript:openPersonalChat(\""+item.pk_empnum+"\")'></i>";
						html += "	</td>";
						html += "</tr>";
					});
				
					html += "</table>";
					
					$("div#"+deptnameeng).html(html);
				},
				error: function(request, status, error) {
                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
			});
		});
		
		
		///////////////////////////////////////////////////////////////////
		
		// @@@@ 웹소켓 연결 @@@@ //
		// 웹브라우저의 주소창의 포트까지 가져옴
		const url = window.location.host;
	//	alert("url : " + url);
		// url : 221.155.187.235:9090
		
		// '/' 부터 오른쪽에 있는 모든 경로
		const pathname = window.location.pathname;
	//	alert("pathname : " + pathname);
		// pathname : /board/chatting/multichat.action
		
		// "전체 문자열".lastIndexOf("검사할 문자"); 
		const appCtx = pathname.substring(0, pathname.lastIndexOf("/"));
	//	alert("appCtx : " + appCtx);
		// appCtx : /groovy/chatting
		
		const root = url + appCtx;
	//	alert("root : " + root);
		// root : 172.30.1.42:9090/groovy
		
		// 웹소켓통신을 하기 위해서는 http://을 사용하는 것이 아니라 ws://을 사용해야 한다.
		// "/multichatstart.action"에 대한 것은 /WEB-INF/spring/config/websocketContext.xml 파일에 있는 내용이다.
		const wsUrl = "ws://" + root + "/websocketConnectEmp.groovy";
	//	alert("wsUrl : " + wsUrl);
		// wsUrl : ws://221.155.187.235:9090/board/websocketConnectEmp.groovy
		
		const websocket = new WebSocket(wsUrl);
		// 즉, const websocket = new WebSocket(ws://221.155.187.235:9090/board/chatting/websocketConnectEmp.groovy); 이다.
		
		// === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
	   	websocket.onopen = function() {
	   		
	   	};
		
		// === 메시지 수신시 콜백함수 정의하기 === //
	   	websocket.onmessage = function(event) {
	   		
	   		// event.data는 수신되어진 메시지이다.
	        if(event.data.substr(0,1)=="<" && event.data.substr(event.data.length-1)==">") { 
	            $("div#connectEmp").html(event.data);
	        }
	   	};
		
		/////////////////////////////////////////
		
		
		

$(document).on('keyup', 'form.comment-writer-container input.comment-writer-text', function (event) {
	if(event.keyCode == 13){ 
		const fk_board_seq = $("input.boardno").val();

		commentAdd(fk_board_seq);
	}
});
		



		 
		
		
		
		
	}); // end of $(document).ready(function() {})
	
	
	
	
	
function showEmpByDept() {
	
	const length = ${requestScope.empvoList.size()};
}
	

//프로필을 보여주는 메소드
function showEmpProfile(pk_empnum) {
	
	$.ajax({
		url:"<%= ctxPath %>/showEmpProfile.groovy",
		data:{"pk_empnum":pk_empnum},
		dataType:"JSON",
		success:function(json) {
			$('div#showAllEmpModal').modal('hide');
			$('div#showEmpProfileModal').modal();
			
			$("div#showEmpProfileModal .modal-header").css({'background-image':'url("<%= ctxPath %>/resources/images/프로필사진/'+json.emppicturename+'")',
															'background-repeat':'no-repeat',
															'background-size':'100%'});
			$("div#empName").html(json.name);
			$("td#email").html(json.email);
			$("td#phone").html(json.phone);
			$("button#goChat").attr("onClick", "openPersonalChat('" + pk_empnum + "');");
		},
		error: function(request, status, error) {
        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	}); // $.ajax({})
}
	
//개인 채팅을 활성화하는 메소드
function openPersonalChat(pk_empnum) {
	
	$.ajax({
		url:"<%= ctxPath %>/openPersonalChat.groovy",
		type:"GET",
		data:{"pk_empnum":pk_empnum},
		dataType:"JSON",
		success:function(json) {
			$('div#showEmpProfileModal').modal('hide');
			
		//	var url = "<%= ctxPath %>/openPersonalChatEnd.groovy?name=" + json.name;
		//	var url = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
            var popup_name = "openChat";
            var option = "width = 450, height = 650, top = 300, left = 600";
			
			window.open("", popup_name, option);
			
			const frm = document.openPersonalChatFrm;
			frm.target = popup_name;
			frm.action = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy?name=" + json.name;
			frm.method = "get";
			frm.submit();
		},
		error: function(request, status, error) {
        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	}); // $.ajax({})
}
	
/* 	function showtest(pk_board_seq){
		alert(pk_board_seq);
		
	} */
	
	  
	  // === 피드형 게시판 읽어오기  === //
	  function goReadBoard(CcurrentShowPageNo) {
		  $("div.showBoardDetail").hide();
		  $("div#feedAllbox").empty();
		  $.ajax({
			  url:"<%= request.getContextPath()%>/readBoard.groovy",
			  data:{"CcurrentShowPageNo":CcurrentShowPageNo},
			  dataType:"json",
			  success:function(json){
				  
				  let html = "";
				   if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						 	
						  
							//html += "<div class='card mb-4 feedAll' onclick='commentShow(\""+item.pk_board_seq+"\",1)'>";
							html += "<div class='card mb-4 feedAll'>";
							
							html += "<div class='card-body'>";
							html +=  "<table style='width: 95%; margin: auto; padding: 10px;' class='tbl_boardInCard mb-3'>";
							html +=  "<thead>";
							html +=  "<tr>";
							html +=  "<td style='vertical-align:middle;'>";
							html +=  "<a style='margin-right: 5px;'><img style='height:40px; width:40px;      border-radius: 16px;' class='writer-photo' src='<%= ctxPath%>/resources/images/프로필사진/"+item.emppicturename+"'  alt='icon-writerprofile'  /></a>";
							 html +=  "<strong id='write_name' style='vertical-align:middle; color:#555; margin-right: 5px;'>["+item.deptnamekor +" : "+item.spotnamekor+"] " + item.name + "</strong><span></span>  <span id='write_date' style='color:#aaa;'>"+ item.b_regdate + "</span>  ";
							html +=  "</td>";
						   	  
						   	  
						   
						 /*   	html +=  "<i class='fas fa-thumbtack'></i>"; */
						   	
						   <%-- 	html +=  "  	<a class='dropdown-item' href='<%=ctxPath%>/editBoard.groovy?pk_board_seq="+item.pk_board_seq+"'><i class='far fa-board-alt'></i>수정</a>"; --%>
						   if('${sessionScope.loginuser.pk_empnum}' == item.fk_empnum){
								html +=  "<td align='right'>";
							   html +=  "<i style='padding:10px; cursor:pointer; margin-left:5px;' class='fas fa-ellipsis-v' data-toggle='dropdown'></i>";
							   html +=  "<div class='dropdown-menu'>";
							   html +=  "  	<a class='dropdown-item'  onclick='editBoardModal("+index+","+item.pk_board_seq+")' data-toggle='modal' data-target='#editBoardModal' style=' cursor: pointer; '><i class='far fa-edit'></i>수정</a>";
							   html +=  "  	<a class='dropdown-item' onclick='delBoard("+item.pk_board_seq+")' href='#'><i class='far fa-trash-alt'></i>삭제</a>";
							   html +=  "</div>";
								html +=  "</td>";
						   } 
						   
						   
						  
						   	/* html +=  "  	<a class='dropdown-item' href='#'><i class='fas fa-external-link-alt'></i>다른 프로젝트에 복사</a>";
						   	html +=  "  	<a class='dropdown-item' href='#'><i class='far fa-clone'></i>링크 복사</a>"; */
						   
						   
						   	html +=  "</tr>";
						   	html +=  "</thead>";
						   	html +=  "<tbody>";
						   	html +=  "<tr>";
						   	html +=  "<td id='write_subject"+index+"' colspan='2' style='font-size: 18pt;'>"+ item.pk_board_seq+ item.b_subject + "</td>";
						   	html +=  "</tr>";
						   	html +=  "<tr style='border-top: solid 1px lightgray; border-bottom: solid 1px lightgray; height: 150px;'>";
						   	html +=  "<td id='write_content"+index+"' colspan='2'>"+ item.b_content + "</td>";
						   	html +=  "</tr>";
						   	
						    <%-- === 첨부파일이 있는 경우 === --%> 
							if(item.b_orgfilename != null){ // 로그인을 한 경우 a가 걸리고,
						   	html +=   '<tr><td  colspan="2"><i class="fas fa-paperclip"></i><a id="write_file'+index+'" href="<%= ctxPath%>/downloadfile.groovy?pk_board_seq='+item.pk_board_seq+'">'+item.b_orgfilename+'</a></td>  </tr>';
							}
							//alert(item.b_orgfilename);
					/* 	   	
						   	html +=  "<tr>";
						    html +=  "<td style='width: 50%;'>";
							html +=  "<i class='far fa-meh-blank' data-toggle='dropdown'></i>좋아요&nbsp;&nbsp;&nbsp;";
							
							html +=  "<div class='dropdown-menu emotion'>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-smile-beam'></i><span>좋아요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-kiss-beam'></i><span>부탁해요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-sad-tear'></i><span>힘들어요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-grin-stars'></i><span>훌륭해요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-grin-hearts'></i><span>감사해요</span></a>";
							html +=  "</div>";
							html +=  "<i class='far fa-bookmark'></i>북마크";
							html +=  "<i class='fas fa-bookmark'></i> 북마크 설정했을때";
							html +=  "</td>";
							html +=  "<td align='right'>댓글(댓글수) / 읽음(조회수)</td>";
							html +=  "</tr>"; */
							html +=  "</tbody>";
							
							html += '<tbody></tbody>'; /* <ul class="card-footer-group"></ul> */
							
							html +=  "</table> 	";
							html +=  "</div>";
							 
							html +=  "<div class='card-footer' height: 300px; align='center' style=' cursor:pointer;' onclick='goBoardView(\""+item.pk_board_seq+"\",1)'>";
							
							html +=  "상세보기</div>";
							 
							html += "</div>";
							
							 
					   });
					  const fkboardseq = $("input[name=fk_board_seqq]").val();
					  console.log(fkboardseq);
					  /* commentShow(item.pk_board_seq,1); */
						//$("div#feedAllbox").html(html);
					
					
					  
				  }
				  else {
					  html += "<div>등록된 댓글이 없습니다.</div>";
	              
					//  $("div#feedAllbox").append(html); 
				  }
				   
				   $(document).on('keyup', 'input.comment-Content', function (event) {
						if(event.keyCode == 13){ 
							const fk_board_seq = $("input.fkboardseq").val();

							alert(fk_board_seq);
							goAddComment(fk_board_seq);
						}
					});
				   
				   
				   $("div#feedAllbox").html(html);
				   makeCBoardPageBar(CcurrentShowPageNo);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
			  
			  
			  //$("div#feedAllbox").html(html); 
			  
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	  
	  
	// === 리스트형 게시판 읽어오기  === //
	  function goReadBoardList(BcurrentShowPageNo) {
		  $("div.showBoardDetail").hide();
		  $.ajax({
			  url:"<%= request.getContextPath()%>/readBoardList.groovy",
			  type:"GET",
			  data:{"BcurrentShowPageNo":BcurrentShowPageNo},
			  dataType:"json",
			  success:function(json){
				  
				 let html = "";
				   if(json.length > 0) {
					   
					 
						  
						html += "<div class='card mb-4 feedAll'>";
						html += "<div class='card-body'>";
						html +=  "<table style='width: 95%; margin: auto; padding: 10px;' class='tbl_boardInCard mb-3'>";
						html +=  "<thead>";
						html +=  "<tr><th style='width: 70px;  text-align: center;'>글번호</th>";
						
						html +=   '<th style="width: 360px; text-align: center;">제목</th>';
						html +=   '<th style="width: 70px;  text-align: center;">성명</th>';
						html +=   '<th style="width: 150px; text-align: center;">날짜</th>';
						/* html +=   '<th style="width: 70px;  text-align: center;">조회수</th>'; */
						
					   	html +=  "</tr>";
					   	html +=  "</thead>";
					   	html +=  "<tbody>";
					   	
					   	
					  $.each(json, function(index, item){
	
						   	html +=  "<tr id='tablehover' style='cursor: pointer;' onclick='javascript:goBoardView("+item.pk_board_seq+")'>";
						   	html +=  "<td id='list_seq"+index+"'  style='text-align: center;'>"+ (json.length - index)+ "</td>";
						   	html +=  "<td id='list_subject"+index+"'  ><span class='list_subject' >"+ item.b_subject+"</span>"; 
						   	${boardvo.subject}
						    <%-- === 첨부파일이 있는 경우 === --%> 
							if(item.b_orgfilename != null){ // 로그인을 한 경우 a가 걸리고,
						   	html +=   '<i class="fas fa-paperclip"></i>';
							}
							html += "</td>";
						   	
						   	html +=  "<td id='list_writer"+index+"' style='text-align: center;' >"+ item.name + "</td>";
						   	html +=  "<td id='list_date"+index+"'  style='text-align: center;'>"+ item.b_regDate + "</td>";
						   	html +=  "</tr>";
						   	
					   });
					  
						html +=  "</tbody>";
						html += '<tbody id="commentDisplay">';
						
							//commentShow(item.pk_board_seq);
						
						html += '</tbody>';
						html +=  "</table> ";
						html +=  "</div>";
						html +=  "</div>";
						
					  
					  
				  }
				  else {
					  html += "<div>등록된 글이 없습니다.</div>";
	              
				  	  //$("div#feedAllbox").html(html); 
				  }
				   
				   $("div#feedAllbox").html(html); 
					  makeBoardPageBar(BcurrentShowPageNo);
				   //commentShow(pk_board_seq,1);
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
			  
			  
			 
			  
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	  
//자세히보기
function goBoardView(pk_board_seq) {

	 $.ajax({
         url: "<%= ctxPath%>/goBoardView.groovy",
         data:{"pk_board_seq":pk_board_seq},
         dataType: "json",
         success:function(json) {
        	 
        var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
        var regdate = moment(json.map.B_REGDATE).format('YYYY-MM-DD HH:mm'); 
        let html = "";

         html += '<div class="card-header">';
         html += '<h3 class="card-title">';
         html += '<i><span class="material-icons-outlined"> bookmark_border </span></i>';/* <!-- 아이콘 --> */
         html += '<span class="js-project-title-button">게시글-'+pk_board_seq+'</span>';/*  <!-- 대분류캘린더-소분류캘린더 --> */
         html += '</h3>';
         html += '<button type="button" class="close">';
         html += '<span class="material-icons-outlined"> close </span>';
         html += '</button>';
         html += '</div>';
   	
         html += '<div class="card-body">';
         html += '<div class="card-scroll">';
 		
         html += '<div class="card-body-top">';
   	 		
         html += '<div class="card-author">';
         html += '<span class="card-profileImg">';
         
      /*    if(json.map.EMPPICTURENAME != null){ */
         	html += '<a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+json.map.EMPPICTURENAME+'"  alt="icon-writerprofile"  /></a>';
        /*  } */
         
         html += '</span>';/* <!-- 프로필이미지 --> */
         html += '<dl class="card-author-info">';
         html += '<dt>';
         html += '<strong class="author-name"> ['+json.map.DEPTNAMEKOR+' : '+json.map.SPOTNAMEKOR+'] '+json.map.NAME+'</strong>';/* <!-- 작성자이름 -->	  */  		
         html += '<span class="author-date">'+regdate+'</span>';/* <!-- 작성시간 --> */
         html += '</dt>';
         html += '</dl>';
         html += '</div>';
   	 			
         html += '<div>';
         
 				
         if('${sessionScope.loginuser.pk_empnum}' == json.map.FK_EMPNUM){
        	 html += '<div class="card-option">';
        
         html += '<button type="button" class="card-edit" onclick="editBoardModal('+pk_board_seq+')" data-toggle="modal" data-target="#editBoardModal" >수정</button>';
         html += '<button type="button" class="card-delete" onclick="delBoard('+pk_board_seq+')">삭제</button>';
         html += '</div>';
         }
        
         html += '</div>';
         
         html += '</div>';
  
         html += '<div class="card-body-bottom">';
         html += '<div class="card-schedule-title-area">';
         html += '<h4 class="card-schedule-title">'+json.map.B_SUBJECT+'</h4>'; /* <!-- 제목 --> */
         html += '<div class="card-schedule-day">';
         html += '</div>';
         html += '</div>';
         html += '</div>';
 		
         html += '<div class="card-container">';
         html += '<div class="card-content">';
 				
         html += '<div class="card-content2">';
         html += '<ul class="card-content-group">';	
 				
         html += '<li>';
         html += '<div class="card-content-title"><i class="icon-text"></i></div>';
         html += '<div class="card-content-memo">';
         html += '<span class="memo-span"><div>'+json.map.B_CONTENT+'</div></span>';
         html += '</div>';
         html += '</li>';

         if(json.map.B_ORGFILENAME != null){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-file-download"></i></div>';
	         html += '<div class="card-content-download">';
	         html += '<span class="download-span"><a href="<%= ctxPath%>/downloadfile.groovy?pk_board_seq='+json.map.PK_BOARD_SEQ+'">'+json.map.B_ORGFILENAME+'</a></span>';
	         html += '</div>';
	         html += '</li>';
	         
         }

         html += '</ul>';
         html += '</div>';

         html += '</div>';
         html += '</div>';
 		
         html += '<div class="card-footer">';
         /* html += '<div class="comment-header"></div>'; */
         
         html += '<ul class="card-footer-group">';
 	/* 			
         html += '<li class="card-footer-li">';
 			               
         html += '<div class="comment-user-profile">';
         html += '<span class="comment-user-profile-span"></span>';
         html += '</div>';
 			            
         html += '<div class="comment-container">';
         html += '<div class="comment-user-area">';
         html += '<div class="comment-user">';
         html += '<span class="comment-user-name">김영준</span>';
         html += '<span class="comment-user-position"></span>';
         html += '<span class="record-date">2022-05-14 07:26</span>'; 
         html += '</div>';
 			                    
         html += '<div class="comment-writer-menu">';
         html += '<button type="button" class="comment-edit">수정</button>';
         html += '<button type="button" class="comment-delete">삭제</button>';
         html += '</div>'; 
         html += '</div>';
 			                
         html += '<div class="comment-content">';
         html += '<div class="comment-text-area">';
	     html += '<div class="comment-text"><div>댓글</div></div>';
	 	 html += '</div>';	
         html += '</div>'; 
         html += '</div>';

	     html += '</li>'; 
	     
	      */
		 html += '</ul>';
		 html += '<div class="comment-header"></div>';
		 html += '</div>';

		 html += '<div class="card-footer2">';
		 html += '<div class="comment-writer-profile">';
		 html += '<span class="comment-writer-profile-span"><a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-writerprofile"  /></a></span>';
		 html += '</div>';

         html += '<form class="comment-writer-container">';
         html += '<fieldset>';
	  /*    html += '<div class="comment-writer-text" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>'; */
		 html += '<input type="text" class="comment-writer-text"  placeholder="댓글등록은 Enter키 입니다.">';
		 html += '<input type="text" style="display:none;">';
		/*  html += '<input type="hidden" class="boardno">'; */
		 html += '</fieldset>';                     
		 html += '</form>';
         html += '</div>';
		        	 
		        /*  <div class="card showBoardDetail"> */
		 
         $(".boardno").val(pk_board_seq);      
      
        /* 
         if(json.map.ADDRESSNAME != "-"){
         	$("div.card-content-map").hide();
         	showMap(json.map.ADDRESSNAME);
         } */
        
         $("div.showBoardDetail").html(html);
         commentShow(pk_board_seq,1);
         
         $("div.showBoardDetail").show();
        
         ////////////////////
         },
         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
         
   });
}	  
	  
	
	  // 특정 글을 수정하는 함수
	  function editBoardModal(index, pk_board_seq){
		  $("div.showBoardDetail").hide();
		  //input 안에 원래 데이터 요소들을 넣어요~~
		  
		  const orgin_subject_text = $("td#write_subject"+index).text(); 
		  $('input#title_edit').attr('value',orgin_subject_text);
		 
		  const origin_content = $("td#write_content"+index).html(); // 원래의 제품후기 엘리먼트
	 	   //alert(origin_content);   
	 	  const orgin_content_text = $("td#write_content"+index).text(); // 원래의 제품후기 내용 
	 	  //alert(orgin_content_text);
		  $('input[name="pk_board_seq"]').attr('value',pk_board_seq); 
		  
		  const b_orgfilename = $("a#write_file"+index).text();
		  
		  document.getElementById("b_content").value = orgin_content_text;

		 //  oEditors.getById["smarteditor2"].exec("PASTE_HTML", orgin_content_text); //내용밀어넣기
	  }
	  
	  
	  // 특정 글을 삭제하는 함수
	    function delBoard(pk_board_seq){
	       
	       const bool = confirm("정말로 글을 삭제하시겠습니까?");
	    //  console.log("bool => " + bool); // bool => true , bool => false
	       
	       if(bool) {
	       
	          $.ajax({
	             url:"<%= ctxPath%>/delBoard.groovy",
	             type:"POST",
	             data:{"pk_board_seq":pk_board_seq,
	            	 "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
	            	 },
	            
	             dataType:"JSON",
	             success:function(json) { // {"n":1} 또는 {"n":0}
	                if(json.isSuccess) {
	                   alert("글 삭제가 성공되었습니다.");
	                   location.reload();
	                   
	                }
	                else {
	                   alert("글 삭제가 실패했습니다.");
	                }
	             },
	             error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	             }
	          });
	       
	       }
	    
	    
	    
	       
	    }// end of function delMyReview(review_seq) {}--------------------------  
	    
	  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~댓글구역~~~~~~~~~~~~~	    
	 	// == 댓글쓰기 == 
	    function goAddComment(fk_board_seq,index){
	  	  
	    	const content = $("input#comment-Content"+index).val();
	    	alert("내용"+content);
	   	 alert("말해줘:"+fk_board_seq);
	   	 
	 	   $.ajax({
	 		   url:"<%= ctxPath%>/boardCommentAdd.groovy",
	 		   type:"POST",
	 		   data:{"fk_board_seq":fk_board_seq,
	 			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
	 			   "name":"${sessionScope.loginuser.name}",
	 			   "content":content },
	 		   dataType:"JSON", 
	 		   success:function(json){
	 			   
	 		  	if(json.n == 1){
	 		  		$("input#comment-Content"+index).val("");
	 		  		commentShow(fk_board_seq,1);   
	 		  	}else{
	 		  		alert("댓글쓰기 실패");
	 		  	}
	 			   
	 	 
	 		   },
	 		   error: function(request, status, error){
	 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 		   }
	 	   });	   
	 	   ///////////
	    	
	    	
	    	/* 
	  	  const commentContent = $("input.comment-Content").val().trim();
	  	  if(commentContent == "") {
	  		  alert("댓글 내용을 입력하세요!!");
	  		  return; // 종료
	  	  }
	  		  goAddWrite_noAttach(); */
	  	
	  	  
	    }// end of function goAddWrite() {}--------------------
	    
function commentAdd(fk_board_seq){
	
	   const content = $("input.comment-writer-text").val();
	 
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentAdd.groovy",
		   type:"POST",
		   data:{"fk_board_seq":fk_board_seq,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
			   "name":"${sessionScope.loginuser.name}",
			   "content":content },
		   dataType:"JSON", 
		   success:function(json){
			   
		  	if(json.n == 1){
		  		$("input.comment-writer-text").val("");
		  		commentShow(fk_board_seq,1);   
		  	}else{
		  		alert("댓글쓰기 실패");
		  	}
			   
	 
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
} // end of function commentAdd(fk_board_seq) {}---------------



function commentShow(fk_board_seq, currentShowPageNo){
	
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentShow.groovy",
		   type:"GET",
		   data:{"fk_board_seq":fk_board_seq,
			   "currentShowPageNo":currentShowPageNo},
		   dataType:"JSON", 
		   success:function(json) {
			   
			  
	  			if(json.length>0){
	  				
	  				let html = ""
					   $.each(json, function(index, item) {
						   var regdate = moment(item.regdate).format('YYYY-MM-DD HH:mm');
					 
						     html += '<li class="card-footer-li" id="commentid-'+item.pk_cmt_seq+'">';
 			               
					         html += '<div class="comment-user-profile">';
					         html += '<span class="comment-user-profile-span"><a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+item.emppicturename+'"  alt="icon-writerprofile"  /></a></span>';
					         html += '</div>';
					 			            
					         html += '<div class="comment-container">';
					         html += '<div class="comment-user-area">';
					         html += '<div class="comment-user">';
					         html += '<span class="comment-user-name">['+item.deptnamekor+' : '+item.spotnamekor+'] '+item.name+'</span>';
					         html += '<span class="comment-user-position"></span>';
					         html += '<span class="record-date">'+regdate+'</span>'; 
					         html += '</div>';
					 		if('${sessionScope.loginuser.pk_empnum}' == item.fk_empnum){
					 			 html += '<div class="comment-writer-menu">';
						         html += '<button type="button" class="comment-edit" onclick="commentEdit('+fk_board_seq+','+item.pk_cmt_seq+')">수정</button>';
						         html += '<button type="button" class="comment-delete" onclick="commentDel('+fk_board_seq+','+item.pk_cmt_seq+')">삭제</button>';
						         html += '</div>'; 
					 		}
					        
					         
					         html += '</div>';
					 			                
					         html += '<div class="comment-content">';
					         html += '<div class="comment-text-area">';
						     html += '<div class="comment-text"><div>'+item.content+'</div></div>';
						 	 html += '</div>';	
					         html += '</div>'; 
					         html += '</div>';

						     html += '</li>'; 
					   });
					   $("ul.card-footer-group").html(html);
					   $("ul.commentDisplay").html(html);
					   makeCommentPageBar(fk_board_seq, currentShowPageNo);
	  			}

		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------




function commentEdit(fk_board_seq,pk_cmt_seq){
	
   let html ="";
   html += '<input type="text" class="comment-writer-text"  placeholder="입력 Enter 입니다.">';
   html += '<input type="text" style="display:none;">';
   const backuptext = $("li#commentid-"+pk_cmt_seq+" div.comment-text div").text();

   $("li#commentid-"+pk_cmt_seq+" div.comment-text-area").html(html);
   $("li#commentid-"+pk_cmt_seq+" input.comment-writer-text").val(backuptext);
  
   $("div.card-footer2").hide();
   
   html ="";
   html += '<button type="button" class="comment-cancell" onclick="commentEditCancell('+fk_board_seq+')">취소</button>';
   $("li#commentid-"+pk_cmt_seq+" div.comment-writer-menu").html(html);
   
   
	$(document).on('keyup', 'li#commentid-'+pk_cmt_seq+' input.comment-writer-text', function (event) {
		if(event.keyCode == 13){ 
			 const contentEdit = $("li#commentid-"+pk_cmt_seq+" input.comment-writer-text").val();
			 
			 $.ajax({
				   url:"<%= ctxPath%>/boardCommentEdit.groovy",
				   type:"POST",
				   data:{"fk_board_seq":fk_board_seq,
					   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
					   "pk_cmt_seq":pk_cmt_seq,
					   "content":contentEdit},
				   dataType:"JSON", 
				   success:function(json) {
					   
				  	if(json.n == 1){
				  		   alert("댓글수정 성공");
				  		 commentShow(fk_board_seq,1); 
						   $("div.card-footer2").show();
				  	}else{
				  		alert("댓글수정 실패");
				  	}
					   
			 
				   },
				   error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				   }
			   });	
			 

		}
	});
	
   

	   
}// end of function  commentEdit(fk_board_seq,pk_cmt_seq){

function commentDel(fk_board_seq,pk_cmt_seq){
	
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentDel.groovy",
		   type:"POST",
		   data:{"fk_board_seq":fk_board_seq,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
			   "pk_cmt_seq":pk_cmt_seq},
		   dataType:"JSON", 
		   success:function(json) {
			   
		  	if(json.n == 1){
		  		   alert("댓글삭제 성공");
		  		 commentShow(fk_board_seq,1);   
		  	}else{
		  		alert("댓글삭제 실패");
		  	}
			   
	 
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------


function commentEditCancell(fk_board_seq){
	
	commentShow(fk_board_seq,1); 
    $("div.card-footer2").show();
}
	    

//////////

function makeCommentPageBar(fk_board_seq, currentShowPageNo) {

<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
$.ajax({
  url:"<%= ctxPath%>/getBoardCommentTotalPage.groovy",
  data:{"fk_board_seq":fk_board_seq,
	    "sizePerPage":"3"},

  dataType:"JSON",
  success:function(json){
	 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
	 
	 if(json.totalPage > 0) {
		 // 댓글이 있는 경우 
		 
		 const totalPage = json.totalPage;
		 
		 let pageBarHTML = "<ul>";
		 
		 const blockSize = 5;
	//	 const blockSize = 2;
		 
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		                 1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
		   [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
		   [맨처음][이전]  21 22 23
		*/
		 
		 let loop = 1;
		 /*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
	    

	     if(typeof currentShowPageNo == "string") {
	    	 currentShowPageNo = Number(currentShowPageNo);
	     }
	     
	     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	     let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
	     /*
	       currentShowPageNo 가 3페이지 이라면 pageNo 는 1 이 되어야 한다.
	       ((3 - 1)/10) * 10 + 1;
	       ( 2/10 ) * 10 + 1;
	       ( 0.2 ) * 10 + 1;
	       Math.floor( 0.2 ) * 10 + 1;  // 소수부가 있을시 Math.floor(0.2) 은 0.2 보다 작은 최대의 정수인 0을 나타낸다.
	       0 * 10 + 1 
	       1
	       
	       currentShowPageNo 가 11페이지 이라면 pageNo 는 11 이 되어야 한다.
	       ((11 - 1)/10) * 10 + 1;
	       ( 10/10 ) * 10 + 1;
	       ( 1 ) * 10 + 1;
	       Math.floor( 1 ) * 10 + 1;  // 소수부가 없을시 Math.floor(1) 은 그대로 1 이다.
	       1 * 10 + 1
	       11
	       
	       currentShowPageNo 가 20페이지 이라면 pageNo 는 11 이 되어야 한다.
	       ((20 - 1)/10) * 10 + 1;
	       ( 19/10 ) * 10 + 1;
	       ( 1.9 ) * 10 + 1;
	       Math.floor( 1.9 ) * 10 + 1;  // 소수부가 있을시 Math.floor(1.9) 은 1.9 보다 작은 최대의 정수인 1을 나타낸다.
	       1 * 10 + 1
	       11
	    
	       
		    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
		    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
		    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
		    
		    currentShowPageNo         pageNo
		   ----------------------------------
		         1                      1 = ((1 - 1)/10) * 10 + 1
		         2                      1 = ((2 - 1)/10) * 10 + 1
		         3                      1 = ((3 - 1)/10) * 10 + 1
		         4                      1
		         5                      1
		         6                      1
		         7                      1 
		         8                      1
		         9                      1
		         10                     1 = ((10 - 1)/10) * 10 + 1
		        
		         11                    11 = ((11 - 1)/10) * 10 + 1
		         12                    11 = ((12 - 1)/10) * 10 + 1
		         13                    11 = ((13 - 1)/10) * 10 + 1
		         14                    11
		         15                    11
		         16                    11
		         17                    11
		         18                    11 
		         19                    11 
		         20                    11 = ((20 - 1)/10) * 10 + 1
		         
		         21                    21 = ((21 - 1)/10) * 10 + 1
		         22                    21 = ((22 - 1)/10) * 10 + 1
		         23                    21 = ((23 - 1)/10) * 10 + 1
		         ..                    ..
		         29                    21
		         30                    21 = ((30 - 1)/10) * 10 + 1
		         
		*/
	     
		// === [맨처음][이전] 만들기 === //
		pageBarHTML += "<li class='firstli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\"1\")'><span class='material-icons'> keyboard_double_arrow_left </span></a></li>";
		pageBarHTML += "<li class='previousli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+(pageNo-1)+"\")'><span class='material-icons'> keyboard_arrow_left </span></a></li>";
		
		if(pageNo != 1 ) {
			
			
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBarHTML += "<li class='numberli'>"+pageNo+"</li>";  
			}
			else {
				pageBarHTML += "<li class='numberli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {


			
		}
		pageBarHTML += "<li class='nextli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+pageNo+"\")'><span class='material-icons'> keyboard_arrow_right </span></a></li>";
		pageBarHTML += "<li class='lastli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+totalPage+"\")'><span class='material-icons'> keyboard_double_arrow_right </span></a></li>"; 
		 
		pageBarHTML += "</ul>";
		 
		$("div.comment-header").html(pageBarHTML);
	 }// end of if(json.totalPage > 0){}-------------------------------
	  
  },
  error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  }    
});

}// end of function makeCommentPageBar(currentShowPageNo) {}--------------------







function makeBoardPageBar(BcurrentShowPageNo) {

<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
$.ajax({
  url:"<%= ctxPath%>/getBoardTotalPage.groovy",
  data:{
	    "sizePerPage":"10"},
  type:"GET",
  dataType:"JSON",
  success:function(json){
	 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
	 
	 if(json.totalPage > 0) {
		 // 댓글이 있는 경우 
		 
		 const totalPage = json.totalPage;
		 
		 let pageBarHTML = "<ul>";
		 
		 const blockSize = 10;
	//	 const blockSize = 2;
		 
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		                 1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
		   [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
		   [맨처음][이전]  21 22 23
		*/
		 
		 let loop = 1;
		 /*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
	    

	     if(typeof BcurrentShowPageNo == "string") {
	    	 BcurrentShowPageNo = Number(BcurrentShowPageNo);
	     }
	     
	     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	     let pageNo = Math.floor( (BcurrentShowPageNo - 1)/blockSize ) * blockSize + 1;
	    

	     
		// === [맨처음][이전] 만들기 === //
		pageBarHTML += "<li class='firstli'><a href='javascript:goReadBoardList(\"1\")'><span class='material-icons'> keyboard_double_arrow_left </span></a></li>";
		pageBarHTML += "<li class='previousli'><a href='javascript:goReadBoardList(\""+(pageNo-1)+"\")'><span class='material-icons'> keyboard_arrow_left </span></a></li>";
		
		if(pageNo < 1) {
			pageNo = 1;
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == BcurrentShowPageNo) {
				pageBarHTML += "<li class='numberli'>"+pageNo+"</li>";  
			}
			else {
				pageBarHTML += "<li class='numberli'><a href='javascript:goReadBoardList(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo > totalPage ) {
			pageNo = totalPage;

			
		}
		pageBarHTML += "<li class='nextli'><a href='javascript:goReadBoardList(\""+pageNo+"\")'><span class='material-icons'> keyboard_arrow_right </span></a></li>";
		pageBarHTML += "<li class='lastli'><a href='javascript:goReadBoardList(\""+totalPage+"\")'><span class='material-icons'> keyboard_double_arrow_right </span></a></li>"; 
		 
		pageBarHTML += "</ul>";
		 
		$("div#paging-list").html(pageBarHTML);
	 }// end of if(json.totalPage > 0){}-------------------------------
	  
  },
  error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  }    
});

}// end of function makeCommentPageBar(currentShowPageNo) {}--------------------




function makeCBoardPageBar(CcurrentShowPageNo) {

<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
$.ajax({
  url:"<%= ctxPath%>/getBoardTotalPage.groovy",
  data:{
	    "sizePerPage":"10"},
  type:"GET",
  dataType:"JSON",
  success:function(json){
	 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
	 
	 if(json.totalPage > 0) {
		 // 댓글이 있는 경우 
		 
		 const totalPage = json.totalPage;
		 
		 let pageBarHTML = "<ul>";
		 
		 const blockSize = 10;
	//	 const blockSize = 2;
		 
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		                 1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
		   [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
		   [맨처음][이전]  21 22 23
		*/
		 
		 let loop = 1;
		 /*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
	    

	     if(typeof CcurrentShowPageNo == "string") {
	    	 CcurrentShowPageNo = Number(CcurrentShowPageNo);
	     }
	     
	     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	     let pageNo = Math.floor( (CcurrentShowPageNo - 1)/blockSize ) * blockSize + 1;
	    
	    /// console.log("pageNO"+pageNo);
	    // console.log("CcurrentShowPageNo:"+CcurrentShowPageNo);
	 	
	     
	     
	  // === [맨처음][이전] 만들기 === //
			pageBarHTML += "<li class='firstli'><a href='javascript:goReadBoard(\"1\")'><span class='material-icons'> keyboard_double_arrow_left </span></a></li>";
			pageBarHTML += "<li class='previousli'><a href='javascript:goReadBoard(\""+(pageNo-1)+"\")'><span class='material-icons'> keyboard_arrow_left </span></a></li>";
			
		if(pageNo < 1) {
			pageNo = 1;
		
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == CcurrentShowPageNo) {
				pageBarHTML += "<li class='numberli'>"+pageNo+"</li>";  
			}
			else {
				pageBarHTML += "<li class='numberli'><a href='javascript:goReadBoard(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo > totalPage ) {
			pageNo = totalPage;

			
		}
		pageBarHTML += "<li class='nextli'><a href='javascript:goReadBoard(\""+pageNo+"\")'><span class='material-icons'> keyboard_arrow_right </span></a></li>";
		pageBarHTML += "<li class='lastli'><a href='javascript:goReadBoard(\""+totalPage+"\")'><span class='material-icons'> keyboard_double_arrow_right </span></a></li>"; 
		 
		pageBarHTML += "</ul>";
		 
		$("div#paging-list").html(pageBarHTML);
	 }// end of if(json.totalPage > 0){}-------------------------------
	  
  },
  error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  }    
});

}// end of function makeCommentPageBar(currentShowPageNo) {}--------------------





	    
</script>

<div id="top_content" style="display: flex;">
	<div style="margin: auto; width: 90%;">
		<div class="row">
			<div id="home_board" class="col-lg-9">
					 <div id="writeBoard" class="card border-dark mb-3" data-toggle="modal" data-target="#writeBoardModal" > 
					  	
					  	<div class="card-header">
							<table class="w-100">
								<tr align=center>
									<th class="w-25"><span id="text"><i class="far fa-file-alt"></i>글</span></th>
									<th class="w-25"><span id="task"><i class="fas fa-list-ul"></i>업무</span></th>
									<th class="w-25"><span id="schedule"><i class="far fa-calendar"></i>일정</span></th>
									<th class="w-25"><span id="todo"><i class="far fa-check-square"></i>할일</span></th>						
								</tr>
							</table>
					  	</div>
					  	
					  	<div class="card-body text-dark">
							<table class="w-100">
								<tr> <%-- 선택 탭(글, 업무, 일정, 할일)마다 형식이 다름 --%>
									<td>내용을 입력하세요</td>
									<td align="right">
										<i class="fas fa-paperclip"></i>
										<i class="far fa-image"></i>
										<i class="fas fa-map-marker-alt"></i>
										<i class="fas fa-hashtag"></i>
										<i class="fas fa-at"></i>
									</td>
								</tr>
							</table>
					  	</div>
					  	
					</div>
				
				
					<!-- 글쓰기 Modal -->
					<div id="myWrite" class="modal fade" role="dialog">
					  <div class="modal-dialog">
					
					    <!-- Modal content-->
					    <div class="modal-content" style="width: 670px; min-height:548px; ">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						        <h4 class="modal-title">Modal Header</h4>
						      </div>
						      
						      
						      <div class="modal-body" class="card border-dark mb-3">
	
								  	<div class="card-header">
										<table class="w-100">
											<tr align=center>
												<th class="w-25"><span id="text"><i class="far fa-file-alt"></i>글</span></th>
												<th class="w-25"><span id="task"><i class="fas fa-list-ul"></i>업무</span></th>
												<th class="w-25"><span id="schedule"><i class="far fa-calendar"></i>일정</span></th>
												<th class="w-25"><span id="todo"><i class="far fa-check-square"></i>할일</span></th>						
											</tr>
										</table>
								  	</div>
								  	
								  	<form name="boardaddFrm" enctype="multipart/form-data">
									  	<div class="card-body text-dark">
											<table class="w-100">
												<tr>
													<th><input type="hidden" name="pk_empnum" value="${sessionScope.loginuser.pk_empnum}" />
														<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly />
													</th>
												</tr>
												<tr> <%-- 선택 탭(글, 업무, 일정, 할일)마다 형식이 다름 --%>
													<td><input id="postTitle" type="text" title="제목을 입력하세요" placeholder="제목을 입력하세요." autocomplete="off" data-required-yn="Y" class="js-post-title create-title-input" maxlength="100" ></td>
													
												</tr>
												<tr> 
													<td>내용을 입력하세요</td>
													
												</tr>
												<tr>
													<td align="right">
														<i class="fas fa-paperclip"></i>
														<i class="far fa-image"></i>
														<i class="fas fa-map-marker-alt"></i>
														<i class="fas fa-hashtag"></i>
														<i class="fas fa-at"></i>
													</td>
												</tr>
											</table>
									  	</div>
								  	</form>
						      </div>
						      
					      
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						      </div>
					    </div>  <!-- Modal content 끝-->
					
					  </div>
					</div><!-- 글쓰기 Modal 끝 -->
				
					<!-- 글피드 보기  -->
					<a type="button" onclick="goReadBoard(1)">글피드보기</a><a type="button"  onclick="goReadBoardList(1)">글목록보기</a>
					<div id="feedAllbox"></div>
					<!-- <div id="paging-feed"></div> -->
					<div id="paging-list"></div>
					
					
		  	</div>
		  	
			<%-- 프로젝트 참여자 목록 --%>
			<div id="memberlist" class="col-lg-3" style="position: fixed; right: 30px; top: 130px; width: 350px;">
				<div class="row">
					<div class="col-lg-6"><h6 style="display: inline-block; margin-left: 5px;">참여자<span class="text-muted ml-2">${requestScope.empvoList.size()}</span></h6></div>
					<div class="col-lg-6" align="right"><a id="showAllEmployee" data-toggle="modal" data-target="#showAllEmpModal">전체보기</a></div>
				</div>
				<div class="card mb-3">
					<div class="card-body scrollover" style="padding-bottom: 0; height: 500px; overflow: auto; overflow-x: hidden;">
				    <%--  	
				    	<c:forEach var="deptvo" items="${requestScope.deptvoList}" varStatus="status">
				    	<div>
				    		<a id="dept" class="text-muted" data-toggle="collapse" href="#${deptvo.deptnameeng.replaceAll(' ', '')}" aria-expanded="false" aria-controls="${deptvo.deptnameeng.replaceAll(' ', '')}">${deptvo.deptnamekor}</a>
				    		<input type="hidden" id="pk_detpnum" value="${deptvo.pk_deptnum}" />
				    		<input type="hidden" id="deptnameeng" value="${deptvo.deptnameeng.replaceAll(' ', '')}" />
				    	</div>
				    	<div class="collapse dept" id="${deptvo.deptnameeng.replaceAll(' ', '')}"></div>
				    	</c:forEach>
				  	--%>
				    	<div id="connectEmp"></div>
				  	</div>
				  	<div class="card-footer" align="center" style="padding: 0; height: 50px;">
				  		<table class="w-100 h-100">
				  			<tr align="center">
				  				<td class="w-50" style="border-right: solid 1px lightgray;">
				  					<button type="button" id="groupchat" onclick=""><i class="far fa-comment-dots"></i>채팅</button>
				  				</td>
				  			</tr>
				  		</table>
				  	</div>
				</div>
			</div>
		</div>
	
		<%-- modal_프로젝트 색상 설정 --%>
		<div class="modal fade" id="prjColorPickerModal">
		  	<div class="modal-dialog modal-dialog-centered">
		  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
		    	<div class="modal-content">
		    		<!-- Modal header -->
					<div class="modal-header" style="border: none;">
						<h5 class="modal-title">프로젝트 색상</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						Modal body....
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="border: none;">
						<button type="button" class="btn btn-light text-secondary w-25" data-dismiss="modal">취소</button>
						<button type="button" class="btn text-white w-25" style="background-color: #6449fc;">확인</button>
					</div>
		    	</div>
		  	</div>
		</div>
		
		<%-- modal_전체 프로젝트 참여자 목록 보기 --%>
		<div class="modal fade" id="showAllEmpModal">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content" style="height: 700px;">
					<!-- Modal header -->
					<div class="modal-header" style="border: none; height: 110px; position: relative;">
						<h5 class="modal-title">참여자 관리</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						
						<!-- 참여자 검색 -->
						<div style="position: absolute; top: 60px;">
							<div style="position: relative;">
								<i class="fas fa-search" style="position: absolute; left: 13px; top: 12px; opacity: 0.6;"></i>
								<input type="text" id="searchEmp" placeholder="참여자명으로 검색" style="width: 450px; height: 40px; border: solid 1px #eee; border-radius: 5px; padding-left: 40px;"/>
							</div>
						</div>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						
						<!-- 참여자 목록(기본_검색 X) -->
						<div id="defaultEmpList">
							<table class="tblEmpList" style="width: 100%;">
					    		<c:forEach var="empvo" items="${requestScope.empvoList}">
					    		<tr style="border-bottom: solid 1px #eeeeee;">
					    			<td class="empProfile" style="cursor: pointer;" onclick="javascript:showEmpProfile('${empvo.pk_empnum}')">
					    				<img class="my-2 mr-2" src="<%= ctxPath %>/resources/images/프로필사진/${empvo.emppicturename}" style="width: 40px; border-radius: 15px;">
					    				<span class="name font-weight-bold">${empvo.name}</span>
					    				<input type="hidden" id="pk_empnum" value="${empvo.pk_empnum}"/>
					    			</td>
					    			<td align="right">
					    				<span style="background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;">${empvo.spotnamekor}</span>
					    				<i class="fas fa-ellipsis-v ml-2" data-toggle="dropdown"></i>
					    				<div class="dropdown-menu prjSetting my-0 py-0">
					    				<!-- c:if로 로그인 유저 이름과 목록 상의 이름이 동일한 경우에는 내보내기가 아니라 나가기로 보여주어야 함. -->
					    				<!-- name은 c:set으로 설정해두기 -->
									      	<a class="dropdown-item" href="">내보내기</a>
									      	<a class="dropdown-item" href="">${empvo.spotnamekor}해제</a>
									    </div>
					    			</td>
					    		</tr>
				    			</c:forEach>
				    		</table>
						</div>
						<!-- 참여자 목록(검색 O) -->
						<div id="searchEmpList">
							<table id="tblSearchEmpList" class="tblEmpList" style="width: 100%;"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%-- modal_프로젝트 참여자 프로필 보기 --%>
		<div class="modal fade" id="showEmpProfileModal">
		  	<div class="modal-dialog modal-dialog-centered">
		    	<div class="modal-content" style="height: 600px; width: 350px;">
		    		<!-- Modal header -->
					<div class="modal-header" style="border: none; height: 300px; position: relative;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						
						<div id="empName" style="position: absolute; top: 260px; color: white; font-weight: bold; font-size: 16pt;"></div>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<table class="w-100">
							<tr style="border-bottom: solid 1px #eee;">
								<td><i class="far fa-envelope"></i></td>
								<td id="email"></td>
							</tr>
							<tr style="border-bottom: solid 1px #eee;">
								<td><i class="fas fa-mobile-alt"></i></td>
								<td id="phone"></td>
							</tr>
						</table>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="border: none; text-align: center;">
						<button type="button" id="goChat" class="btn btn-light" style="border: solid 1px #eee; width: 40%;">채팅</button>
						<button type="button" class="btn btn-light" style="border: solid 1px #eee; width: 40%;">정보수정</button>
					</div>
		    	</div>
		  	</div>
		</div>
		<jsp:include page="../tiles2/board/writeBoardModal.jsp"/> 
		<jsp:include page="../tiles2/board/editBoardModal.jsp"/>   
		
		
		
		
<!-- 카드 -->
<div class="card showBoardDetail" style="position: fixed;right: 30px; top:20px;"></div>
		
		
		
		
		
		<!--  -->
	</div>
</div>

<input type="hidden" class="boardno"/>	