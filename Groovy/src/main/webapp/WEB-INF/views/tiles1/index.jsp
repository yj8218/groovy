<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	
	ul.tab_home li a, ul.tab_Modal li a {
		text-decoration: none;
		color: black;
	}
	
	ul.tab_home li a.active, ul.tab_Modal li a.active {border-bottom: solid 3px purple;}
	
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

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
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
		
		$("i.fa-thumbtack").click(function() {
			alert("상단 고정 클릭 => 상단 고정 하기");
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
		
	}); // end of $(document).ready(function() {})
	
	
	function writeBoardModal() {
		$("div#writeBoardModal").modal();
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
	<ul class="nav tab_home">
	  	<li class="nav-item">
	    	<a class="nav-link active" data-toggle="tab" href="#home">홈</a>
	  	</li>
	  	<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#menu1">업무</a>
	  	</li>
	  	<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#menu2">간트차트</a>
	  	</li>
	  	<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#menu3">캘린더</a>
	  	</li>
	  	<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#menu4">파일</a>
	  	</li>
	  	<li class="nav-item">
	    	<a class="nav-link" data-toggle="tab" href="#menu5">알림</a>
	  	</li>
	</ul>
</div>

<div id="content" style="display: flex;">
	<div style="margin: auto; width: 90%;">
		<div class="row">
			<div id="home_board" class="col-lg-9" >
				<%-- Tab panes(홈) --%>
				<div class="tab-content">
				  	<div class="tab-pane container active" id="home">
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
				  	<%-- Tab panes(업무) --%>
				  	<div class="tab-pane container" id="menu1">
				    	<h4>업무</h4>
				  	</div>
				  	<%-- Tab panes(간트차트 : _blank, 화면 상 탭이 선택되진 않아서 필요없음) --%>
				  	<div class="tab-pane container" id="menu2">
				    	<h4>간트차트</h4>
				  	</div>
				  	<%-- Tab panes(캘린더) --%>
				  	<div class="tab-pane container" id="menu3">
				    	<h4>캘린더</h4>
				  	</div>
				  	<%-- Tab panes(파일) --%>
				  	<div class="tab-pane container" id="menu4">
				    	<h4>파일</h4>
				  	</div>
				  	<%-- Tab panes(알림) --%>
				  	<div class="tab-pane container" id="menu5">
				    	<h4>알림</h4>
				  	</div>
				</div>	
			</div>
			
			<%-- 프로젝트 참여자 목록 --%>
			<div id="memberlist" class="col-lg-3">
				<h5>참여자{참여자수}</h5>
				<div class="card mb-3">
					<div class="card-body">
				    	<table style="width: 100%;">
				    		<tr>
				    			<th>프로젝트관리자(직책)</th>
				    		</tr>
				    		<%-- 반복 --%>
				    		<tr>
				    			<td>
				    				<i class="far fa-user-circle"></i>
				    				{이름}
				    			</td>
				    			<td align="right">
				    				<i class="far fa-comment-dots"></i>
				    			</td>
				    		</tr>
				    	</table>
				  	</div>
				  	<div class="card-footer" align="center" style="padding: 0; height: 50px;">
				  		<table class="w-100 h-100">
				  			<tr align="center">
				  				<td class="w-50" style="border-right: solid 1px lightgray;">
				  					<i class="far fa-comment-dots"></i>
				  					채팅
				  				</td>
				  				<td>
				  					<i class="fas fa-video"></i>
				  					화상회의
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
		
		<jsp:include page="../tiles2/board/writeBoardModal.jsp"></jsp:include>
	</div>
</div>