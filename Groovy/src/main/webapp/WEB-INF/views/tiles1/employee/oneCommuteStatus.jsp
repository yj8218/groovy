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
.pad{
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
	width: 50%; 
	border-radius: 10px;
	border-style: hidden;
	box-shadow: 0 0 0 3px #6449fc;
	background-color: rgba(204, 204, 255, 0.1); 
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
	background-color: rgba(153, 102, 255, 0.1);  
}
div#pageBar{
	width: 70%; 
	margin: 20px auto 150px auto; 
}
li:hover{
	background-color: rgba(153, 102, 255, 0.1);  
	border: solid 1px #9966FF;
	cursor: pointer;
	text-decoration: none;
}
.li_w70{
	display:inline-block; 
	width:70px; 
	font-size:14pt;
}
.li_w60{
	display:inline-block; 
	width:60px; 
	font-size:14pt;
}
.li_w30{
	display:inline-block; 
	width:30px; 
	font-size:14pt;
}
a {
	color: #6449fc; 
	text-decoration: none;
}
a:hover{
	text-decoration: none;
}
.li_border{
	border: solid 1px #6449fc; 
	border-radius: 5px;
	margin: 0 2px;
}


</style>
<script type="text/javascript">
$(document).ready(function(){
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
	$(function() {
  		$.datepicker.setDefaults({
	    	  dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	          ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	          ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	          ,changeYear: true        //콤보박스에서 년 선택 가능
	          ,changeMonth: true       //콤보박스에서 월 선택 가능                
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

// function declaration
function goSearch() {
	
	// 날짜입력 유효성검사
	
	// 전송
	const frm = document.dataFrm;
	frm.action = "<%= ctxPath%>/showOneCommuteStatus.groovy"; 
	frm.method = "POST";
	frm.submit();
	
}

</script>


<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">



		<form name="dataFrm">
		<table id="tbl_viewEmp" >
			<tr >
				<th class="pad">기간조회</th>
				<td class="pad">
					<input type="text" id="date_start" name="date_start" placeholder="시작일">&nbsp;~&nbsp;
					<input type="text" id="date_end" name="date_end" placeholder="마지막일">
				</td>
			</tr>
			<tr >
				<th class="pad"></th>
				<td class="pad">
					<a id="goSearch" onclick="goSearch()" >조회하기</a>
				</td>
			</tr>
		</table>
		</form>		
	
	<div id="orderby">
		<div> 
		<%-- 다른 페이지들과 간격을 맞추기 위한 div --%>
		</div>
	</div>
	
	<h2 class="mb-5">${requestScope.loginuser.name }님의 근태관리</h2>
	<table id="tbl_result" class="tcenter" >
		<tr id="fileItemTapLi" >
			<th class="pad" colspan="1" ></th>
			<th class="pad" colspan="4" style="border: solid 1px gray;">출퇴근기록</th>
			<th class="pad" colspan="4" style="border: solid 1px gray;">근태</th>
		</tr>
		<tr id="fileItemTapLi" >	
			<th class="colsize3 pad">번호</th>
			<th class="colsize2 pad">근무날짜</th>
			<th class="colsize1 pad">출근시각</th>
			<th class="colsize1 pad">퇴근시각</th>
			<th class="colsize1 pad">근무시간</th>
			<th class="colsize3 pad">지각</th>
			<th class="colsize3 pad">조기퇴근</th>
			<th class="colsize3 pad">퇴근미체크</th>
			<th class="colsize3 pad">결근</th>
		</tr>
		
		<c:if test="${empty requestScope.OneCommuteStatus }">
			<tr class="commuteList" >
				<td colspan="9" class="pad">근태 기록이 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${not empty requestScope.OneCommuteStatus }">
			<c:forEach var="OneInfoMap" items="${requestScope.OneCommuteStatus }" varStatus="status">
		
			<tr class="commuteList" >
				<td class="pad">${(5 * (requestScope.currentShowPageNo-1))+ status.count }</td>
				<td class="pad">${OneInfoMap.TODAY }</td>
				<td class="pad">${OneInfoMap.startwork }</td>
				<td class="pad">${OneInfoMap.endwork }</td>
				<td class="pad">${OneInfoMap.TODAYWORKEDTIME }</td>
				<td class="pad">${OneInfoMap.LATE }</td>
				<td class="pad">${OneInfoMap.EARLY_ENDCHECK }</td>
				<td class="pad">${OneInfoMap.NO_ENDCHECK }</td>
				<td class="pad">${OneInfoMap.NO_WORKDAY }</td>
			</tr>
		
			</c:forEach>
		</c:if>
	</table>

	<%-- 페이지바 보여주는 곳! --%>
	<div align="center" id="pageBar" >
		${requestScope.pageBar }
	</div>

</div>
</div>