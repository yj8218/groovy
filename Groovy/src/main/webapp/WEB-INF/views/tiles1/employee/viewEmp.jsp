<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.colsize1{width: 150px;}
.colsize2{width: 130px;}

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
	width: 65%; 
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
.date{
	width:100px;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	
	// 뷰단에 값을 고정시키기 위함
	$("select[name='dept']").val( ${requestScope.dept} );
	$("select[name='spot']").val( ${requestScope.spot} );
	$('input#date_start').val('${requestScope.date_start}');
	$('input#date_end').val('${requestScope.date_end}');
	$("select[name='resign_status']").val( ${requestScope.resign_status} );
	$("select[name='search_item']").val( '${requestScope.search_item}' );
	$("input#search_value").val( '${requestScope.search_value}' );
	
	
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
	//     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
		$(function() {
      //모든 datepicker에 대한 공통 옵션 설정
      $.datepicker.setDefaults({
    	  dateFormat: 'yy-mm-dd'  //Input Display Format 변경
          ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
          ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
          ,changeYear: true        //콤보박스에서 년 선택 가능
          ,changeMonth: true       //콤보박스에서 월 선택 가능                
          ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
          ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
          ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
          ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
          ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
          ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
          ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
          ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
          ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
  });

    //input을 datepicker로 선언
    $("input#date_start").datepicker();                    
    $("input#date_end").datepicker();
      
    // startday의 초기값을 오늘 날짜로 설정
    $('input#startday').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

});// end of $(function() 
	
	
	
});

// Function Declaration

function goSearch(){
	$("span#dateCheckResult").html("");
	$("span#searchCheckResult").html("");
	
	const date_start = $("input#date_start").val();
	const date_end = $("input#date_end").val();
	
	const regExp = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
	
	if(date_start.trim() != "" || date_end.trim() != "" ){ // 둘중에 하나라도 날짜 입력값이 있으면
		if( !regExp.test(date_start) || !regExp.test(date_end) ){
			$("span#dateCheckResult").html("형식에 맞게 날짜를 입력해주세요(예: yyyy-mm-dd)");
			return;
		}
		else if(date_start > date_end){
			$("span#dateCheckResult").html("마지막일은 시작일보다 이후여야 합니다.");
			return;
		}
	}
	
	const search_value = $("input#search_value").val();
	if(search_value.trim() != "" && $("select[name='search_item']").val() == ""){// 검색입력값은 입력했는데, 기준을 고르지 않았을때
		$("span#searchCheckResult").html("검색기준을 선택해주세요");
		return;
	}
	
//	alert("값이 넘어감");
	
	
	const frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "viewEmp.groovy"; // 자기자신한테 간다.
	frm.submit();
	
}

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
    <form name="searchFrm">
		<table id="tbl_viewEmp">
			
			<tr >
				<th>선택조건</th>
				<td>
					<select name="dept">
						<option value="">부서</option>
						<c:forEach var="dept" items="${requestScope.departments }">
							<option class="op" value="${dept.pk_deptnum }">${dept.deptnamekor }</option>
						
						</c:forEach>
					</select>
					<select name="spot">
						<option value="">직급</option>
						<c:forEach var="spot" items="${requestScope.spots }">
							<option class="op" value="${spot.pk_spotnum }" >${spot.spotnamekor }</option>
							
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<th>입사기간</th>
				<td>
				<input type="text" class="date" name="date_start" id="date_start" placeholder="시작일">&nbsp;~&nbsp;
				<input type="text" class="date" name="date_end" id="date_end" placeholder="마지막일">
				<span id="dateCheckResult"></span>
				</td>
			</tr>
			
			<tr>
				<th>재직여부</th>
				<td>
					<select name="resign_status">
						<option value="">재직구분</option>
						<option class="op" value="0">재직</option>
						<option class="op" value="1">퇴사</option>
					</select>
				</td>
			</tr>
			
			<tr >
				<th style="width: 100px; ">검색</th>
				<td>
					<select name="search_item">
						<option class="op" value="">검색기준</option>
						<option class="op" value="name">이름</option>
						<option class="op" value="pk_empnum">사번</option>
					</select>
					<div class="input-group ml-2" id="search" >
					<!-- 돋보기 이미지, 나중에 이미지 다운받고 i 태그로 바꾸기 -->
					<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				 		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
						<input name="search_value" id="search_value" type="text" placeholder="입력" autocomplete="off" maxlength="20" class="bnone" >			
					</div>
						<span id="searchCheckResult"></span>
				</td>
			</tr>
			
			<tr >
				<th></th>
				<td>
					<a id="goSearch" onclick="goSearch()" >조회하기</a>
				</td>
			</tr>
			
		</table>
	</form>
	
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
	
	<h2>관리자 전용 사원조회</h2>
	<table id="tbl_result" class="tcenter">
		<tr id="fileItemTapLi">	
			<th class="colsize2">번호</th>
			<th class="colsize1">사원번호</th>
			<th class="colsize2">이름</th>
			<th class="colsize2">부서</th>
			<th class="colsize2">직급</th>
			<th class="colsize2">재직구분</th>
			<th class="colsize1">입사일</th>
			<th class="colsize1">연락처</th>
			<th class="colsize1">이메일</th>
		</tr>
		
		<!--  ++ 관리자로 로그인 했을때만 볼수있게 처리 -->
		<c:if test="${empty requestScope.emps }">
			<tr class="" >
				<td colspan="12">조회결과가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${not empty requestScope.emps }">
			<c:forEach var="emp" items="${requestScope.emps }" varStatus="status">
				<tr class="">
				
					<td>${status.count }</td>
					<td>${emp.pk_empnum }</td>
					<td>${emp.name }</td>
					<td>${emp.deptnamekor }</td>
					<td>${emp.spotnamekor }</td>
					<c:if test="${emp.resignationstatus == 0 }">
						<td>재직</td>
					</c:if>
					<c:if test="${emp.resignationstatus != 0 }">
						<td>퇴사</td>
					</c:if>
					<td>${emp.startday }</td>
					<td>${emp.phone }</td>
					<td>${emp.email }</td>
					
				</tr>
			</c:forEach>
			
			
		</c:if>
		
	</table>
	
	<%-- 페이지바 보여주는 곳! --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar }
	</div>
        
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