<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	body {background-color: #f2f2f2;}

	table.tbl_boardInCard td {padding: 10px;}
	
	.fas, .far {margin-right: 10px;}
	
	label.btn_inputFile {
		padding: 5px;
		background-color: transparent;
		border: solid 1px lightgray;
		border-radius: 5px;
		cursor: pointer;
	}
	
	div#fixedTab {
		padding: 30px 30px 0px 30px;
	
		position: fixed;
		top: 45px;
    	left: 230px;
    	
    	width: 100%;
    	height: 145px;
    	background-color: white;
    	border-bottom: solid 1px lightgray;
    	
    	z-index: 1;
	}
	
	div#content {margin-top: 150px;}
	
	div.inputfileDiv {position: relative;}
	
	div.inputfileDiv #inputfile {
		position: absolute;
		left: 100px;
		top: 5px;
	}
	
	div.feedAll {box-shadow: 1px 1px 5px lightgray;}
	
	div#inputFileDiv {
		position: relative;
		display: inline-block;
	}
	
	div.prjSetting a {font-size: 10pt;}
	
	div.emotion a {display: inline;}
	
	table#tblEmpList i {color: #c6c6c6;}
	table#tblEmpList i:hover, div#groupchat:hover {color: #6449fc; cursor: pointer;}
	
	a#showAllEmployee {
		display: inline-block;
		font-size: 10pt; 
		margin-right: 5px; 
		cursor: pointer; 
		text-decoration: none;
		color: black;
	}
	
	button#groupchat {border: none; width: 100%; height: 100%; background-color: transparent;}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		showEmpByDept();
		
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
			var openchatConfirm = confirm("프로젝트 채팅방을 개설하시겠습니까?\n프로젝트 참여자가 모두 참여하는 채팅방입니다.");
			
			if(openchatConfirm) {
				alert("프로젝트 참여자 모두와 단체 채팅하기 => 팝업창");
				openChat();
			}
		});
		
		// 개인 채팅방 개설
		$("table#tblEmpList i").click(function() {
			const name = $(this).parent().prev().find('span.name').text();
			const pk_empnum = $(this).parent().prev().find("input#pk_empnum").val();
			
			$.ajax({
				url:"<%= ctxPath %>/openPersonalChat.groovy",
				type:"GET",
				data:{"pk_empnum":pk_empnum},
				dataType:"JSON",
				success:function(json) {
					var url = "<%= ctxPath %>/openPersonalChatEnd.groovy?name=" + json.name;
		            var popup_name = "openChat";
		            var option = "width = 450, height = 650, top = 300, left = 600";
					
					window.open(url, popup_name, option);
				},
				error: function(request, status, error) {
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // $.ajax({})
		});
		
		// 프로젝트 참여자 프로필 보기
		$("td.empProfile").click(function() {
			
			const name = $(this).find('span.name').text();
			const pk_empnum = $(this).find('input#pk_empnum').val();
			
			$.ajax({
				url:"<%= ctxPath %>/showEmpProfile.groovy",
				type:"GET",
				data:{"pk_empnum":pk_empnum},
				dataType:"JSON",
				success:function(json) {
					$('div#showEmpProfileModal').modal();
					
					$("div#showEmpProfileModal .modal-header").css({'background-image':'url("<%= ctxPath %>/resources/images/common/profile-default.png")',
																	'background-repeat':'no-repeat',
																	'background-size':'100%'});
					$("div#empName").html(json.name);
					$("td#email").html(json.email);
					$("td#phone").html(json.phone);
				},
				error: function(request, status, error) {
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // $.ajax({})
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
								html += "	<td class='empProfile' style='cursor: pointer;'>";
								html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/common/profile-default.png' style='width: 40px; border-radius: 15px;'>";
								html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
								html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>"	
								html += "	</td>";
								html += "	<td align='right'>";
								html += "		<span style='background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;'>{직책}</span>";
								html += "		<i class='fas fa-ellipsis-v ml-2' data-toggle='dropdown'></i>";
								html += "		<div class='dropdown-menu prjSetting my-0 py-0'>";
								html += "			<a class='dropdown-item' href=''>내보내기</a>";
								html += "			<a class='dropdown-item' href=''>{직책}해제</a>";
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
		
		$("a#dept").click(function() {
			
			const $target = $(event.target);
			const pk_deptnum = $target.next().val();
			const deptnameeng = $target.next().next().val();
			
			$.ajax({
				url:"<%= ctxPath %>/showEmpByDept.groovy",
				type:"POST",
				data:{"pk_deptnum":pk_deptnum},
				dataType:"JSON",
				success:function(json) {
					
					let html = "<table class='tblEmpList' id='tblEmpList' style='width: 100%;'>";
					
					$.each(json, function(index, item) {
						html += "<tr style='border-bottom: solid 1px #eee;'>";
						html += "	<td class='empProfile' style='cursor: pointer;'>";
						html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/common/profile-default.png' style='width: 40px; border-radius: 15px;'";
						html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
						html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>";
						html += "	</td>";
						html += "	<td align='right'>";
						html += "		<i class='far fa-comment-dots fa-lg'></i>";
						html += "	</td>";
						html += "</tr>";
					});
				
					html += "</table>"
					
					$("div#"+deptnameeng).html(html);
				},
				error: function(request, status, error) {
                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
			});
		});
		
	}); // end of $(document).ready(function() {})
	
	
	function showEmpByDept() {
		
		const length = ${requestScope.empvoList.size()};
	}
	
</script>
<%-- final_html --%>
<div id="fixedTab">
	<%-- 프로젝트 색상 / 프로젝트 제목 / 공개여부 / 프로젝트 설명 / 멤버 초대 / 검색  --%>
	<%-- 프로젝트 색상 --%>
	<div id="prjColor" data-toggle="modal" data-target="#prjColorPickerModal" style="width: 50px; height: 50px; background-color: blue; border-radius: 10px; display: inline-block;"></div>
	<%-- 프로젝트 제목 --%>
	<div id="prjTitle" style="display: inline-block; margin-left: 10px;">
		<i class="far fa-star"></i>
		<i class="fas fa-ellipsis-v" data-toggle="dropdown"></i>
		<div class="dropdown-menu prjSetting my-0 py-0">
			<a class="dropdown-item bg-dark text-white">프로젝트 번호<span class="ml-5">1312117</span></a>
	      	<a class="dropdown-item" href=""><i class="fas fa-paint-roller"></i>색상 설정</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-tag"></i>프로젝트 폴더 설정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-bell"></i>알림 설정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-eye-slash"></i>숨김</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-clipboard-check"></i>프로젝트 템플릿 설정</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-sign-out-alt"></i>프로젝트 나가기</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-pencil-alt"></i>프로젝트 수정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-trash-alt"></i>프로젝트 삭제</a>
	    </div>
		<span style="font-weight: bold; font-size: 16pt;">프로젝트 제목</span>
		<p>프로젝트 설명</p>
	</div>
</div>

<div id="content" style="display: flex;">
	<div style="margin: auto; width: 90%;">
		<div class="row">
			<div id="home_board" class="col-lg-9">
				<%-- Tab panes(홈) 
				<div class="tab-content">
				  	<div class="tab-pane container active" id="home">
				--%>
		  		<div>
					<h5>게시글작성</h5>
					<div id="writeBoard" class="card border-dark mb-3" data-toggle="modal" onclick="writeBoardModal()">
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
				</div>
				<div>
					<h5>전체</h5>
					<%-- 반복 --%>
					<div class="card mb-4 feedAll">
						<div class="card-body">
					    	<table style="width: 95%; margin: auto; padding: 10px;" class="tbl_boardInCard mb-3">
					    		<thead>
					    			<tr>
										<td>
											<i class="far fa-user-circle"></i>
											사용자명 / 작성일자
										</td>
										<td align="right">
											<i class="fas fa-thumbtack"></i>	<%-- 상단고정 --%>
											<i class="fas fa-ellipsis-v" data-toggle="dropdown"></i>	<%-- 설정 --%>
											<div class="dropdown-menu">
										      	<a class="dropdown-item" href="#"><i class="far fa-trash-alt"></i>삭제</a>
										      	<a class="dropdown-item" href="#"><i class="fas fa-external-link-alt"></i>다른 프로젝트에 복사</a>
										      	<a class="dropdown-item" href="#"><i class="far fa-clone"></i>링크 복사</a>
										    </div>
										</td>
									</tr>
					    		</thead>
					    		<tbody>
					    			<tr>
										<td colspan="2" style="font-size: 18pt;">게시글 제목</td>
									</tr>
									<tr style="border-top: solid 1px lightgray; border-bottom: solid 1px lightgray; height: 150px;">
										<td colspan="2">게시글 내용(글 탭을 선택한 경우)</td>
									</tr>
									<tr>
										<td style="width: 50%;">
											<i class="far fa-meh-blank" data-toggle="dropdown"></i>좋아요&nbsp;&nbsp;&nbsp;
											<div class="dropdown-menu emotion">
												<a class="dropdown-item" href=""><i class="far fa-smile-beam"></i><span>좋아요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-kiss-beam"></i><span>부탁해요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-sad-tear"></i><span>힘들어요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-grin-stars"></i><span>훌륭해요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-grin-hearts"></i><span>감사해요</span></a>
											</div>
											<i class="far fa-bookmark"></i>북마크
											<%-- <i class="fas fa-bookmark"></i> 북마크 설정했을때 --%>
										</td>
										<td align="right">댓글(댓글수) / 읽음(조회수)</td>
									</tr>
					    		</tbody>
					    	</table> 	
					  	</div>
					  	<div class="card-footer" align="center">
					  		<i class="far fa-user-circle"></i>
							<input type="text" class="form-control" style="display: inline-block; width: 90%;" placeholder="댓글 입력" />
							<label class="btn_inputFile" for="inputFile"><i class="fas fa-paperclip ml-2"></i></label>
							<input type="file" id="inputFile" style="display: none;"/>
					  	</div>
			        </div>
				</div>
		  	</div>
		  	
			<%-- 프로젝트 참여자 목록 --%>
			<div id="memberlist" class="col-lg-3" style="position: fixed; right: 30px; top: 216px; width: 350px;">
				<div class="row">
					<div class="col-lg-6"><h6 style="display: inline-block; margin-left: 5px;">참여자<span class="text-muted ml-2">${requestScope.empvoList.size()}</span></h6></div>
					<div class="col-lg-6" align="right"><a id="showAllEmployee" data-toggle="modal" data-target="#showAllEmpModal">전체보기</a></div>
				</div>
				<div class="card mb-3">
					<div class="card-body" style="padding-bottom: 0; height: 550px; overflow: auto; overflow-x: hidden;">
				    <%-- <table class="tblEmpList" id="tblEmpList" style="width: 100%;">
				    		<tr>
				    			<th>프로젝트관리자(직책)</th>
				    		</tr>
				    		반복
				    		<c:forEach var="empvo" items="${requestScope.empvoList}" end="8">
				    		<tr style="border-bottom: solid 1px #eeeeee;">
				    			<td class="empProfile" style="cursor: pointer;">
				    				<img class="my-2 mr-2" src="<%= ctxPath %>/resources/images/common/profile-default.png" style="width: 40px; border-radius: 15px;">
				    				<span class="name font-weight-bold">${empvo.name}</span>
				    				<input type="hidden" id="pk_empnum" value="${empvo.pk_empnum}"/>
				    			</td>
				    			<td align="right">
				    				<i class="far fa-comment-dots fa-lg"></i>
				    			</td>
				    		</tr>
				    		</c:forEach> 
				    	</table> --%>
				    	<c:forEach var="deptvo" items="${requestScope.deptvoList}" varStatus="status">
				    	<div>
				    		<a id="dept" data-toggle="collapse" href="#${deptvo.deptnameeng.replaceAll(' ', '')}" aria-expanded="false" aria-controls="${deptvo.deptnameeng.replaceAll(' ', '')}">${deptvo.deptnamekor}</a>
				    		<input type="hidden" id="pk_detpnum" value="${deptvo.pk_deptnum}" />
				    		<input type="hidden" id="deptnameeng" value="${deptvo.deptnameeng.replaceAll(' ', '')}" />
				    	</div>
				    	<div class="collapse dept" id="${deptvo.deptnameeng.replaceAll(' ', '')}">
				    		부서별
				    	</div>
				    	</c:forEach>
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
					    			<td class="empProfile" style="cursor: pointer;">
					    				<img class="my-2 mr-2" src="<%= ctxPath %>/resources/images/common/profile-default.png" style="width: 40px; border-radius: 15px;">
					    				<span class="name font-weight-bold">${empvo.name}</span>
					    				<input type="hidden" id="pk_empnum" value="${empvo.pk_empnum}"/>
					    			</td>
					    			<td align="right">
					    				<span style="background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;">{직책}</span>
					    				<i class="fas fa-ellipsis-v ml-2" data-toggle="dropdown"></i>
					    				<div class="dropdown-menu prjSetting my-0 py-0">
					    				<!-- c:if로 로그인 유저 이름과 목록 상의 이름이 동일한 경우에는 내보내기가 아니라 나가기로 보여주어야 함. -->
					    				<!-- name은 c:set으로 설정해두기 -->
									      	<a class="dropdown-item" href="">내보내기</a>
									      	<a class="dropdown-item" href="">{직책}해제</a>
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
						<button type="button" class="btn btn-light" data-dismiss="modal" style="border: solid 1px #eee; width: 40%;">채팅</button>
						<button type="button" class="btn btn-light" style="border: solid 1px #eee; width: 40%;">정보수정</button>
					</div>
		    	</div>
		  	</div>
		</div>
		
		<jsp:include page="../tiles2/board/writeBoardModal.jsp"></jsp:include>
	</div>
</div>