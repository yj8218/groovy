<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/style1.css" />

<style type="text/css">
.fileUL {
	list-style-type: none;
}
.fleft{
	float: left;
}
.tcenter{
	text-align: center;
}
.bnone{
	border: none;
}
#fileItemTapLi{
	padding: 30px auto; 
	background-color: rgba(190, 190, 190, 0.1);  
	margin: 30px auto; 
	font-weight: bold; 
	width: 100%;
	color: black;
	font-size: 11pt;
}
#list- {
	display: inline-block;
	height: 20px;
	width: 100%;
	padding: 30px auto;
}
#search{
	border: solid 1px gray; 
	padding: 2px 12px 2px 8px;
	display: inline-block; 
	width: auto;
	background-color: #ffffff;
	border-radius: 10px;
	
}
#addFolder{
	display: inline-block; 
	float: right; 
	margin: 15px 0 15px 10px; 
	background-color: #6449fc;
}
#download{
	display: inline-block; 
	float: right; 
	margin: 15px 0 ; 
	background-color: rgba(200, 200, 200, 1);  
	color: black;
}
#option{
	color: #6449fc;
}

li:hover{
	background-color: rgba(153, 102, 255, 0.1);  
	border: solid 1px #9966FF;
	cursor: pointer;
	
	
}
#fileLayerUl{
	font-size: 11pt;
}
.colsize1{width: 120px;}
.colsize2{width: 100px;}
.colsize3{width: 50px;}

#empOption{
}

select{
	width: 100px;
	height: 30px;
	padding-left: 10px;
	font-size: 14px;
	color: black;
	border: 1px solid rgba(200, 200, 200, 1);
	border-radius: 3px;
	
	-webkit-appearance: none; /* 화살표 없애기 for chrome*/
	appearance: none; /* 화살표 없애기 공통*/
	background:url(<%=ctxPath%>/resources/images/yuhr/down.png) no-repeat 97% 50%/20px auto;
}

.op{
	color: #9966FF;
	font-weight: bold;
}
input{
	width: 80px;
}
th, td{
	padding: 7px 0 0 3px;
}
#orderby{
	height: 50px;
	text-align: right;
}
#select_order{
	width: 130px;
}
#tbl_viewEmp{
	width: 45%; 
	border: solid 2px #9966FF;
}
#goSearch{
	border: solid 1px #9966FF;
	float: right;
	margin: 0 10px 10px 0;
	padding: 3px 4px;
	border-radius: 30px;
}
a#goSearch:hover{
	cursor: pointer;
	background-color: rgba(200, 200, 200, 0.3);
	
}
#tbl_result{
	margin-bottom: 100px;
	width: 100%;
	
}
.commuteList{
	margin: 5px 0;
	vertical-align: middle;
	border-bottom: solid 1px rgba(200, 200, 200, 0.3);
	
}
.commuteList:hover{
	cursor: pointer;
	background-color: rgba(153, 102, 255, 0.1);  
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
});

// function declaration


</script>


<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">



		<table id="tbl_viewEmp" >
			
			<tr >
				<th>기간조회</th>
				<td>
					<input type="text" value="시작일">&nbsp;~&nbsp;
					<input type="text" value="마지막일">
				</td>
			</tr>
			
			<tr >
				<th></th>
				<td>
					<a id="goSearch" onclick="" >조회하기</a>
				</td>
			</tr>
			
		</table>
	
	<div id="orderby">
		<div>
			<select id="select_order">
				<option class="op">최근등록순</option>
			</select>
		</div>
	</div>
	
	<h2 class="mb-5">${requestScope.pk_empnum }님의 근태관리</h2>
	<table id="tbl_result" class="tcenter" >
		<tr id="fileItemTapLi">
			<th colspan="1" ></th>
			<th colspan="4" style="border: solid 1px gray;">출퇴근기록</th>
			<th colspan="4" style="border: solid 1px gray;">근태</th>
		</tr>
		<tr id="fileItemTapLi">	
			<th class="colsize3">번호</th>
			<th class="colsize2">근무날짜</th>
			<th class="colsize1">출근시각</th>
			<th class="colsize1">퇴근시각</th>
			<th class="colsize1">근무시간</th>
			<th class="colsize3">지각</th>
			<th class="colsize3">조기퇴근</th>
			<th class="colsize3">퇴근미체크</th>
			<th class="colsize3">결근</th>
		</tr>
		
		
		<c:if test="${not empty requestScope.OneCommuteStatus }">
			<c:forEach var="OneInfoMap" items="${requestScope.OneCommuteStatus }" varStatus="status">
		
			<tr class="commuteList" onclick="getOneCommuteInfo('${InfoMap.pk_empnum}')">
				<td>${status.count }</td>
				<td>${OneInfoMap.TODAY }</td>
				<td>${OneInfoMap.startwork }</td>
				<td>${OneInfoMap.endwork }</td>
				<td>${OneInfoMap.TODAYWORKEDTIME }</td>
				<td>${OneInfoMap.LATE }</td>
				<td>${OneInfoMap.EARLY_ENDCHECK }</td>
				<td>${OneInfoMap.NO_ENDCHECK }</td>
				<td>${OneInfoMap.NO_WORKDAY }</td>
			</tr>
		
			</c:forEach>
		</c:if>
	</table>
	
        
<%--	
	<c:if test="${not empty boardvo}">
	++ 반복문
--%>
		
	
	
		
		
	
<%--		
	</c:if>
--%>
<%-- 
	<c:if test="${empty boardvo}">
		<div style="padding: 50px 0; font-size: 16pt; color: red;">존재하지 않습니다.</div>
	</c:if>
--%>
	


</div>
</div>