<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
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
.colsize1{width: 45%;}
.colsize2{width: 100px;}

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
	padding: 7px 0 0 9px;
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
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	
});


</script>


<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">

<%--
TBL_EMPLOYEE 에서
EMPNUM          v     NUMBER(10)    
NAME            v     VARCHAR2(20)  
PHONE           v     VARCHAR2(200) 
EMAIL           v     VARCHAR2(200) 
FK_VSTATUS      d     NUMBER(1)     휴가상태(0,1)
EMPPICTURENAME  v     VARCHAR2(20)  직원사진

TBL_DEPARTMENT 에서
DEPTNAMEKOR 부서이름

TBL_SPOT에서
SPOTNAMEKOR 직위이름

TBL_VACATION 에서
PK_VSTATUS	휴가상태
VTYPE		휴가종류

검색조건
부서별
직위별
사번기준
 --%> 
<div style="border: solid 1px gray; height: 120px; width: 100%;">
홈바
</div>

		<table id="tbl_viewEmp">
			
			<tr >
				<th>부서선택</th>
				<td>
					<select>
						<option >부서</option>
						<option class="op">부서1</option>
						<option class="op">부서2</option>
					</select>
				</td>
			</tr>
			
			<tr >
				<th>기간조회</th>
				<td>
					<input type="text" value="시작일">&nbsp;~&nbsp;
					<input type="text" value="마지막일">
				</td>
			</tr>
			
			<tr >
				<th style="width: 100px;">검색</th>
				<td >
					<select>
						<option class="op">검색조건</option>
						<option class="op">이름</option>
						<option class="op">사번</option>
					</select>
					<div class="input-group ml-2" id="search" >
					<!-- 돋보기 이미지, 나중에 이미지 다운받고 i 태그로 바꾸기 -->
					<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				 		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
						<input type="text" placeholder="입력" autocomplete="off" maxlength="20" class="bnone" >			
					</div>
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
				<option class="op">사번순</option>
				<option class="op">이름순</option>
				<option class="op">근무일수순</option>
			</select>
		</div>
	</div>
	
	<h2 class="mb-5">근무통계</h2>
	<table id="tbl_result" class="tcenter">
		<tr id="fileItemTapLi">
			<th colspan="1" ></th>
			<th colspan="4" style="border: solid 1px gray;">이름/부서</th>
			<th colspan="4" style="border: solid 1px gray;">근태</th>
			<th colspan="2" style="border: solid 1px gray;">근무</th>
		</tr>
		<tr id="fileItemTapLi">	
			<th class="colsize2">번호</th>
			<th class="colsize2">사원번호</th>
			<th class="colsize2">이름</th>
			<th class="colsize2">부서</th>
			<th class="colsize2">재직구분</th>
			<th class="colsize2">지각</th>
			<th class="colsize2">조기퇴근</th>
			<th class="colsize2">퇴근미체크</th>
			<th class="colsize2">결근</th>
			<th class="colsize2">근무일수</th>
			<th class="colsize2">근무시간</th>
		</tr>
		
		<!--  ++ 관리자로 로그인 했을때만 볼수있게 처리 -->
		<c:if test="${empty requestScope.commStatusList }">
			<tr class="" >
				<td colspan="12">근무통계 조회결과가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${not empty requestScope.commStatusList }">
			<c:forEach var="commStatus" items="${requestScope.commStatusList }" varStatus="status">
		
			<tr class="">
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
				<td>5</td>
				<td>${commStatus.late }</td>
				<td>${commStatus.early_endcheck }</td>
				<td>${commStatus.no_endcheck }</td>
				<td>${commStatus.no_workday }</td>
				<td>${commStatus.total_workingday }</td>
				<td>${commStatus.total_workingtime }</td>
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