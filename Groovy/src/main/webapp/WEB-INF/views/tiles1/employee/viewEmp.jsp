<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	padding: 2px 4px;
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
				<th>선택조건</th>
				<td>
					<select>
						<option >부서</option>
						<option class="op">부서1</option>
						<option class="op">부서2</option>
					</select>
					<select>
						<option >직급</option>
						<option class="op">직급1</option>
						<option class="op">직급2</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th>입사기간</th>
				<td>
				<input type="text" value="시작일">&nbsp;~&nbsp;
				<input type="text" value="마지막일">
				</td>
			</tr>
			
			<tr>
				<th>재직여부</th>
				<td>
					<select>
						<option >재직구분</option>
						<option class="op">재직여부1</option>
						<option class="op">재직여부2</option>
					</select>
				</td>
			</tr>
			
			<tr >
				<th style="width: 100px; ">검색</th>
				<td>
					<select>
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
				<option class="op">직급순</option>
			</select>
		</div>
	</div>
	
	<h2>조직도? 및 사원조회</h2>
	<table id="tbl_result" class="tcenter">
		<tr id="fileItemTapLi">	
			<th class="colsize2">번호</th>
			<th class="colsize2">사원번호</th>
			<th class="colsize2">이름</th>
			<th class="colsize2">부서</th>
			<th class="colsize2">직급</th>
			<th class="colsize2">재직구분</th>
			<th class="colsize2">입사일</th>
			<th class="colsize2">퇴사일</th>
			<th class="colsize2">연락처</th>
			<th class="colsize2">이메일</th>
			<th class="colsize2">휴가상태</th>
			<th class="colsize2">비고</th>
		</tr>
		<tr class="">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>5</td>
			<td>6</td>
			<td>7</td>
			<td>8</td>
			<td>9</td>
			<td>10</td>
			<td>11</td>
			<td>12</td>
		</tr>
		<tr class="">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>5</td>
			<td>6</td>
			<td>7</td>
			<td>8</td>
			<td>9</td>
			<td>10</td>
			<td>11</td>
			<td>12</td>
		</tr>
		<tr class="">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>5</td>
			<td>6</td>
			<td>7</td>
			<td>8</td>
			<td>9</td>
			<td>10</td>
			<td>11</td>
			<td>12</td>
		</tr>
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