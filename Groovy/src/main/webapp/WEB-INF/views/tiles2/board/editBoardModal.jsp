<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

	ul#taskStatus {
		display: inline-block; 
		width: 90%;
		padding-left: 0;	
	}
	ul#taskStatus li {
		display: inline-block;
		border: solid 1px lightgray;
		border-radius: 40px;
		width: 18%;
		padding: 5px;
		text-align: center;
	}
	
	 input:focus {outline:none;}
	 textarea:focus {outline:none;}
	
	/* === 정보수정  modal css 시작=== */
	
	   #editBoardModal div.modal-body input[type=text]
	,  #editBoardModal div.modal-body select
	,  #editBoardModal div.modal-body textarea {
	  width: 100%;
	  padding: 12px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	  resize: vertical;
	}
	  #editBoardModal div.modal-body label {
	  padding: 12px 12px 12px 0;
	  display: inline-block;
	}
	
	  #editBoardModal div.modal-body input[type=submit] {
	  /* background-color: #04AA6D; */
	  color: white;
	  padding: 12px 20px;
	  border: none;
	  border-radius: 4px;
	  cursor: pointer;
	  float: right;
	}
	
	 #editBoardModal div.modal-body input[type=submit]:hover {
	  /* background-color: #45a049; */
	}
	
	  #editBoardModal div.modal-body {
	  border-radius: 5px;
	 /*  background-color: #f2f2f2; */
	  padding: 20px;
	}
	
	
	/* Clear floats after the columns */
	  #editBoardModal div.modal-body .row:after {
	  content: "";
	  display: table;
	  clear: both;
	}


/* === 정보수정  modal css 끝 === */
	
	
</style>

<script type="text/javascript">

	
	/* $('#editBoardModal').on('hidden.bs.modal', function (e) {
		   $(this).find('form')[0].reset(); 
		/*   $("table").get(0).reset(); */
	/* 	}); */


	$(document).ready(function() {
		
		<%-- === #166. 스마트 에디터 구현 시작 === --%>
	 	//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "smarteditor2",
	        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        },
	         fOnAppLoad: function(){
	        	$("iframe").css("width","100%").css("height","300px");
	        } 
	    });
	    
	   // editBoardModal(index, pk_board_seq);
	 //   editBoardModal(pk_board_seq);
	   
	    
	    
		$("textarea").keydown(function() {
			const content = $(this);
			content[0].style.height = 'auto';
			
			const contentHeight = content.prop('scrollHeight');
			content.css('height', contentHeight);
		});
		/* 
		$(document).on("click", ".my_close", function() {
			$('table')[0].reset();
		});
		 */
		
		
		$("div.addTask").click(function() {
			let html = "";
			
			html += "<tr>"
				  + "	<td>"
				  + "		<div class='mt-3'>"	
				  + "			<i class='far fa-calendar'></i>"
				  + "			<a style='text-decoration: underline;'>시작일 추가</a>"
				  + "		</div>"	
				  + "	</td>"
				  + "</tr>"
				  + "<tr>"
				  + "	<td>"
				  + "		<div class='mt-3'>"	
				  + "			<i class='far fa-calendar'></i>"
				  + "			<a style='text-decoration: underline;'>마감일 추가</a>"
				  + "		</div>"	
				  + "	</td>"
				  + "</tr>"
				  + "<tr>"
				  + "	<td>"
				  + "		<div class='mt-3'>"	
				  + "			<i class='far fa-flag'></i>"
				  + "			<a style='text-decoration: underline;'>우선순위 추가</a>"
				  + "		</div>"	
				  + "	</td>"
				  + "</tr>"
			      
			$("tbody#addTr").after(html);
			$("tr#removeTr").remove();
		});
		
		

		  
		    
		  

		    
		    <%-- === 스마트 에디터 구현 끝 === --%>
		  
		  
			  // 글쓰기버튼
			  $("button#btnEditEnd").click(function(){
				  
				
				  
				  
				  
				  <%-- === 스마트 에디터 구현 시작 === --%>
				 	//id가 smarteditor2인 textarea에 에디터에서 대입
			        obj.getById["smarteditor2"].exec("UPDATE_CONTENTS_FIELD", []);
				  <%-- === 스마트 에디터 구현 끝 === --%>
				  
				  // 글제목 유효성 검사
				  const subject = $("input#title_edit").val().trim();
				  if(subject == "") {
					  alert("글제목을 입력하세요!!");
					  return;
				  }
				  
				  // 글내용 유효성 검사(스마트에디터 사용 안 할시)
				
				  const content = $("textarea#smarteditor2").val().trim();
				  if(content == "") {
					  alert("글내용을 입력하세요!!");
					  return;
				  }
				
				
				<%-- === 스마트에디터 구현 시작 === --%>
				// 스마트에디터 사용시 무의미하게 생기는 p태그 제거
				 var contentval = $("textarea#smarteditor2").val();
				        
		         // === 확인용 ===
		         // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
		         // "<p>&nbsp;</p>" 이라고 나온다.
		        
		         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
		         // 글내용 유효성 검사 
		         if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		        	 alert("글내용을 입력하세요!!");
		        	 return;
		         }
			        
			     // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
			        contentval = $("textarea#smarteditor2").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
			     /*    
			                대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
			        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
			                     그리고 뒤의 gi는 다음을 의미합니다.

			        	g : 전체 모든 문자열을 변경 global
			        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
			     */    
			        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
			        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
			        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
			    
			        $("textarea#smarteditor2").val(contentval);
			     
			     // alert(contentval);
				 <%-- === 스마트에디터 구현 끝 === --%>
				  
				  /* // 글암호 유효성 검사
				  const pw = $("input#pw_edit").val();
				  if(pw == "") {
					  alert("글암호를 입력하세요!!");
					  return;
				  } */
				  
				  // 폼(form)을 전송(submit)
				  const frm = document.editFrm;
				  frm.method = "POST";
				  frm.action = "<%= ctxPath%>/editBoardEnd.groovy";
				  frm.submit();
			  });
			  
			  
			  $('.modal').on('hidden.bs.modal', function (e) {
					$(this).find('form')[0].reset();
				}); 
				
		
	}); // end of $(document).ready(function() {})


	/* function editBoardModal(pk_board_seq){
		const title = $("#title").text();
		 $('input[name=title_edit]').attr('value',title);
	}
	 */
	 
</script>

<%-- modal_게시글 작성 --%>
<div class="modal fade" id="editBoardModal"  tabindex="-1" role="dialog" aria-labelledby="historyModalLabel" aria-hidden="true">
  	<div class="modal-dialog modal-dialog-centered modal-lg">
  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
    	<div class="modal-content" style="height: 700px; ">
    		<!-- Modal header -->
			<div class="modal-header" style="border:none;">
				<h5 class="modal-title">글 수정</h5>
				<button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				
				<div class="tab-content">
					<%-- Tab panes(글) --%>
				  	<div class="tab-pane container active py-3" id="text">
				    	<!-- <form name="textFrm"> -->
				    	<form name="editFrm" enctype="multipart/form-data">
				    		<table class="w-100 writezone">
				    			<tr>
									<td>
										<input type="hidden" name="fk_empnum" value="${sessionScope.loginuser.pk_empnum}" />
										<input type="hidden" name="name" value="${sessionScope.loginuser.name}" readonly />
										 <input type="text" name="pk_board_seq" value="${requestScope.boardvo.pk_board_seq}" /> 
									</td>
								</tr>
				    			
				    			<tr style="border-bottom: solid 1px lightgray; outline: none;">
				    				<td>
				    					
										   <input type="text" name="b_subject" id="title_edit"  placeholder="제목" size="100" style="font-size: 15pt; font-weight: bold; border:0px;"/> 
										
				    				</td>
				    			</tr>
				    			<tr>
									<td>
										<textarea style="width: 100%; height: 350px;" name="b_content" id="smarteditor2"></textarea>
									</td>
				    			</tr>
				    			<%-- === #150. 파일첨부 타입 추가하기 === --%>
								<tr>
									<td>
										<input type="file" name="attach" /> 
									</td>
								</tr>
								
								<!-- <tr>
									<td>
										<input type="password" name="b_pw" id="pw_edit" placeholder="글암호를 입력하세요." /> 
									</td>
								</tr> -->
								

				    		</table>
				    			<%-- === #143. 답변글쓰기가 추가된 경우 시작 === --%>
								<input type="hidden" name="fk_seq" value="${requestScope.fk_seq}" />
								<input type="hidden" name="groupno" value="${requestScope.groupno}" />
								<input type="hidden" name="depthno" value="${requestScope.depthno}" />
								<%-- ===  답변글쓰기가 추가된 경우 끝            === --%>
								
				    	</form>
				  	</div>
				  	<%-- Tab panes(업무) --%>
				  	<div class="tab-pane container py-3" id="task">
				    	<form name="taskFrm">
				    		<table class="w-100">
				    			<thead>
						    		<tr style="border-bottom: solid 1px lightgray; outline: none;">
					    				<td>
					    					<input type="text" name="title" id="taskTitle" placeholder="제목을 입력하세요." style="font-size: 16pt; width: 100%; border: none;" />
					    				</td>
					    			</tr>
					    		</thead>
					    		<tbody id="addTr">
					    			<tr>
					    				<td>
					    					<div class="mt-3">
						    					<i class="fas fa-history"></i>
						    					<ul id="taskStatus" style="list-style: none;" align=left;>
						    						<li>요청</li>
						    						<li>진행</li>
						    						<li>피드백</li>
						    						<li>완료</li>
						    						<li>보류</li>
						    					</ul>
					    					</div>
					    				</td>
					    			</tr>
					    			<tr>
					    				<td>
					    					<i class="far fa-user"></i>
					    					<input type="text" style="border: solid 1px lightgray; border-radius: 5px;" placeholder="담당자 추가"/>
					    				</td>
					    			</tr>
					    			<tr id="removeTr">
					    				<td>
					    					<div class="mt-3 addTask">
							    				<i class="fas fa-plus"></i>
							    				<span>항목추가입력</span>
						    				</div>
					    				</td>
					    			</tr>
				    			</tbody>
				    			<tr>
				    				<td>
				    					<textarea class="w-100 mt-3" style="min-height: 100px; resize: none; border: none;" placeholder="내용을 입력하세요"></textarea>
				    				</td>
				    			</tr>
			    			</table>
				    	</form>
				  	</div>
				  	<%-- Tab panes(일정) --%>
				  	<div class="tab-pane container py-3" id="schedule">
				    	<form name="scheduleFrm">
				    		<table class="w-100">
					    		<tr style="border-bottom: solid 1px lightgray; outline: none;">
				    				<td>
				    					<input type="text" name="title" id="scheduleTitle" placeholder="제목을 입력하세요." style="font-size: 16pt; width: 100%; border: none;" />
				    				</td>
				    			</tr>
			    			</table>
				    	</form>
				  	</div>
				  	<%-- Tab panes(할일) --%>
				  	<div class="tab-pane container py-3" id="todo">
				    	<form name="todoFrm">
				    		<table class="w-100">
					    		<tr style="border-bottom: solid 1px lightgray; outline: none;">
				    				<td>
				    					<input type="text" name="title" id="todoTitle" placeholder="제목을 입력하세요." style="font-size: 16pt; width: 100%; border: none;" />
				    				</td>
				    			</tr>
				    			<tr>
				    				<td>
				    					<input type="text" class="w-100 mt-3" style="height: 40px;" placeholder="할 일 추가 (Enter 또는 Tab)/최대 60자" />
				    				</td>
				    			</tr>
			    			</table>
				    	</form>
				  	</div>
			  	</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer" style="border:none;">
				<button  id="btnEditEnd" type="button" class="btn text-white w-25 my-3" style="background-color: #6449fc;">수정완료</button>
				
			</div>
    	</div>
  	</div>
</div>