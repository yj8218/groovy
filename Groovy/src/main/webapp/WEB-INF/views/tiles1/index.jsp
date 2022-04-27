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
	
	ul.tab_home li a {
		text-decoration: none;
		color: black;
	}
	
	ul.tab_home li a.active {border-bottom: solid 3px purple;}
	
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

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("div#prjColor").click(function() {
			alert("프로젝트 색상 클릭 => 컬러 picker 모달 열기");
		});
		
	}); // end of $(document).ready(function() {})
	
</script>
<%-- final_html --%>
<div id="fixedTab">
	<%-- 프로젝트 색상 / 프로젝트 제목 / 공개여부 / 프로젝트 설명 / 멤버 초대 / 검색  --%>
	<%-- 프로젝트 색상 --%>
	<div id="prjColor" style="width: 50px; height: 50px; background-color: blue; border-radius: 10px; display: inline-block;"></div>
	<%-- 프로젝트 제목 --%>
	<div id="prjTitle" style="display: inline-block; margin-left: 10px;">
		<i class="far fa-star"></i>
		<i class="fas fa-ellipsis-v" data-toggle="dropdown"></i>
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
							<div id="writeBoard" class="card border-dark mb-3">
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
													<i class="far fa-meh-blank"></i>좋아요&nbsp;&nbsp;&nbsp;
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
												<td colspan="2">게시글 내용(업무 탭을 선택한 경우)</td>
											</tr>
											<tr>
												<td style="width: 50%;">
													<i class="far fa-meh-blank"></i>좋아요&nbsp;&nbsp;&nbsp;
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
												<td colspan="2">게시글 내용(일정 탭을 선택한 경우)</td>
											</tr>
											<tr>
												<td style="width: 50%;">
													<i class="far fa-meh-blank"></i>좋아요&nbsp;&nbsp;&nbsp;
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
												<td colspan="2">게시글 내용(일정 탭을 선택한 경우)</td>
											</tr>
											<tr>
												<td style="width: 50%;">
													<i class="far fa-meh-blank"></i>좋아요&nbsp;&nbsp;&nbsp;
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
		
	</div>
</div>