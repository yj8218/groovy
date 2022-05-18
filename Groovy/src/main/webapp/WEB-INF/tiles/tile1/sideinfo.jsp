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
















</style>
<script type="text/javascript">

		
		
	
</script>
 
 
<!-- 사이드바 시작 -->
<div class="sidenav" style="background-color:#2c2a34; ">
	<div  align="center" class="mainlogo borderline" style=" color:white;  border-bottom: solid 0.8px #595959; "><a href="<%=ctxPath%>/index.groovy"><img src="<%= ctxPath%>/resources/images/common/로고그루비.png"  alt="로고"  /></a></div>
	<div style="margin: 15px 25.5px;">
  		<div class="btn_newpjt" ><i class="fas fa-expand"></i>새 프로젝트</div>
  	</div>
  	<div class="mb-3 side-header">
	  <a href="<%=ctxPath%>/schedule/scheduleManagement.groovy"><i class="fas fa-house-user"></i>스케줄러</a>
	  <a href="<%=ctxPath%>/showOneCommuteStatus.groovy"><i class="fas fa-tag"></i>내 근태관리</a>	
	  <a href="<%=ctxPath%>/orgChart.groovy"><i class="fas fa-tag"></i>조직도</a>
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
	    
	    
	    <!-- ============================================================================================================== 덕노 -->
	    <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#myApproval"><a style="cursor: pointer; ">결재하기</a></div>
		  <div id="myApproval" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="<%=ctxPath%>/approvalView.groovy"><i class="fas fa-tag" style="color: red;"></i>기안하기</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/myApproval.groovy"><i class="fas fa-tag"></i>내 기안내역 조회</a>
					</li>
				</ul>
			</div>
	    </li>
	    
	     <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#apprver"><a style="cursor: pointer; ">개인 결재 문서함</a></div>
		  <div id="apprver" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="<%=ctxPath%>/waitApproval.groovy"><i class="fas fa-tag"></i>결재 대기 문서</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/endApproval.groovy"><i class="fas fa-tag"></i>결재 수신 문서</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/referenceApproval.groovy"><i class="fas fa-tag"></i>참조 문서</a>
					</li>
				</ul>
			</div>
	    </li>
		
	
	    <!-- ============================================================================================================== 혜림 -->
	    <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#admin"><a style="cursor: pointer; ">어드민</a></div>
		  <div id="admin" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="<%=ctxPath%>/register.groovy"><i class="fas fa-tag" style="color: red;"></i>사원등록</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/viewEmp.groovy"><i class="fas fa-tag"></i>사원정보</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/worktime.groovy"><i class="fas fa-tag"></i>근태관리</a>
					</li>
					<li>
						<a href="<%=ctxPath%>/commutebutton.groovy"><i class="fas fa-tag"></i>임시</a>
					</li>
				</ul>
			</div>
	    </li>
	
	
	
	
	</ul>
	
	<!-- ============================================================================================================== 끝 -->
	
	
	<ul class="borderline side-foot" style="list-style: none; cursor: pointer; padding: 0;">
		<li>
			<a><i class="far fa-address-book"></i>직원초대</a>
		</li>
		<li>
			<a><i class="fas fa-user-cog"></i>어드민</a>
		</li>
	</ul>
	
	
</div>
  
   <!-- 상단 네비게이션 끝 -->
   

  