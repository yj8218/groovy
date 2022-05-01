<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
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
		$('.modal').on('hidden.bs.modal', function (e) {
		  $(this).find('table')[0].reset()
		});
		
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
		
	}); // end of $(document).ready(function() {})

</script>

<%-- modal_게시글 작성 --%>
<div class="modal fade" id="writeBoardModal" tabindex="-1" role="dialog" aria-labelledby="historyModalLabel" aria-hidden="true">
  	<div class="modal-dialog modal-dialog-centered">
  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
    	<div class="modal-content" style="height: 700px;">
    		<!-- Modal header -->
			<div class="modal-header" style="border:none;">
				<h5 class="modal-title">게시물 작성</h5>
				<button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<ul class="nav tab_Modal">
				  	<li class="nav-item w-25" align="center">
				    	<a class="nav-link active" data-toggle="tab" href="div#text"> <i class="far fa-file-alt"></i>글</a>
				  	</li>
				  	<li class="nav-item w-25" align="center">
				    	<a class="nav-link" data-toggle="tab" href="div#task"><i class="fas fa-list-ul"></i>업무</a>
				  	</li>
				  	<li class="nav-item w-25" align="center">
				    	<a class="nav-link" data-toggle="tab" href="div#schedule"><i class="far fa-calendar"></i>일정</a>
				  	</li>
				  	<li class="nav-item w-25" align="center">
				    	<a class="nav-link" data-toggle="tab" href="div#todo"><i class="far fa-check-square"></i>할일</a>
				  	</li>
				</ul>
				<div class="tab-content">
					<%-- Tab panes(글) --%>
				  	<div class="tab-pane container active py-3" id="text">
				    	<form name="textFrm">
				    		<table class="w-100">
				    			<tr style="border-bottom: solid 1px lightgray; outline: none;">
				    				<td>
				    					<input type="text" name="title" id="textTitle" placeholder="제목을 입력하세요." style="font-size: 16pt; width: 100%; border: none;" />
				    				</td>
				    			</tr>
				    			<tr>
				    				<td>
				    					<textarea class="w-100 mt-3" style="min-height: 100px; resize: none; border: none;" placeholder="내용을 입력하세요"></textarea>
				    				</td>
				    			</tr>
				    		</table>
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
				<button type="button" class="btn text-white w-25 my-3" style="background-color: #6449fc;">올리기</button>
			</div>
    	</div>
  	</div>
</div>