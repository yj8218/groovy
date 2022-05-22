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
.colsize1{width: 45%;}
.colsize2{width: 110px;}
.colsize3{width: 20px;}
.colsize4{width: 90px;}

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
}
.commuteList{
	margin: 5px 0;
	vertical-align: middle;
	border-bottom: solid 1px rgba(200, 200, 200, 0.3);
}
.commuteList_nocursor{
	margin: 5px 0;
	vertical-align: middle;
	border-bottom: solid 1px rgba(200, 200, 200, 0.3);
}
.commuteList:hover{
	cursor: pointer;
	background-color: rgba(153, 102, 255, 0.1);  
}
.commuteList_nocursor:hover{
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
	// 뷰단에 값을 고정시키기 위함
	$("select[name='dept']").val( '${requestScope.dept}' );
	$('input#date_start').val('${requestScope.date_start}');
	$('input#date_end').val('${requestScope.date_end}');
	$("select[name='search_item']").val( '${requestScope.search_item}' );
	$("input#search_value").val( '${requestScope.search_value}' );
	$("select#select_order").val('${requestScope.select_order}');

	
	// select#select_order 선택시 재정렬
	$("select#select_order").bind("change", function(){
		
		goSearch();
		
	})// end of $("select#select_order").bind("change", function(){
	
	
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
function showOneCommuteStatusByAjax(pk_empnum, name){
	
	$.ajax({
		url:"<%=ctxPath%>/showOneCommuteStatusByAjax.groovy",
		data:{"pk_empnum":pk_empnum },
		type:"POST",
		dataType:"JSON",
		success:function(json){
			
			let html = "";
			
			if (json.OneCommuteStatus != null) {// 보여줄 결과값이 존재한다면
					
				$("#OneName").text(name);
				$.each(json.OneCommuteStatus, function(index, item){
					if(item.endwork == null){
						item.endwork = "-"	
					}
					if(item.TODAYWORKEDTIME == null){
						item.TODAYWORKEDTIME = "-"	
					}
					
					html += "<tr class='commuteList_nocursor' >";
				
					html += "<td class='tcenter' style='width:100px; padding:10px 0;'>"+(index+1)+"</td>"
					html += "<td class='tcenter' style='width:165px;'>"+item.TODAY+"</td>"
					html += "<td class='tcenter' style='width:156px;'>"+item.startwork+"</td>"
					html += "<td class='tcenter' style='width:156px;'>"+item.endwork+"</td>"
					html += "<td class='tcenter' style='width:156px;'>"+item.TODAYWORKEDTIME+"</td>"
					
					html += "<td class='tcenter' style='width:120px;'>"+item.LATE+"</td>"
					html += "<td class='tcenter' style='width:120px;'>"+item.EARLY_ENDCHECK+"</td>"
					html += "<td class='tcenter' style='width:120px;'>"+item.NO_ENDCHECK+"</td>"
					html += "<td class='tcenter' style='width:120px;'>"+item.NO_WORKDAY+"</td>"
					html += "</tr>"
				
				});
			}
			else{
				html += "<tr class='commuteList_nocursor' >";
				html += "<td colspan='9' class='tcenter' style='width:100px; padding:10px 0;'>조회된 근무기록 결과가 없습니다.</td>"
				html += "</tr>"
			}
			
			$("span#oneCommuteStatusResult").html(html);
	
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});// end of $.ajax 
	
}// end of function getOneEmpInfo()


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
	
	const frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "worktime.groovy"; // 자기자신한테 간다.
	frm.submit();
	
}// end of function goSearch()

</script>


<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">

<form name="searchFrm">
	<table id="tbl_viewEmp">
		
		<tr >
			<th>부서선택</th>
			<td>
				<select name="dept">
					<option value="">부서</option>
					<c:forEach var="dept" items="${requestScope.departments }">
						<option class="op" value="${dept.pk_deptnum }">${dept.deptnamekor }</option>
					
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr >
			<th>근무기간</th>
			<td>
				<input type="text" class="date" name="date_start" id="date_start" placeholder="시작일">&nbsp;~&nbsp;
				<input type="text" class="date" name="date_end" id="date_end" placeholder="마지막일">
				<span id="dateCheckResult"></span>
			</td>
		</tr>
		
		<tr >
			<th style="width: 100px;">검색</th>
			<td >
				<select name="search_item">
					<option class="op" value="">검색조건</option>
					<option class="op" value="name">이름</option>
					<option class="op" value="pk_empnum">사번</option>
				</select>
				<div class="input-group ml-2" id="search" >
				<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			 		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
					<input id="search_value" name="search_value" type="text" placeholder="입력" autocomplete="off" maxlength="20" class="bnone" >			
				</div>
			</td>
		</tr>
		
		<tr >
			<th></th>
			<td>
				<a id="goSearch" onclick="goSearch()" >조회하기</a>
			</td>
		</tr>
		
	</table>

	<div id="orderby">
		<div>
			<select id="select_order" name="select_order">
				<option class="op" value="" selected>최근등록순</option>
				<option class="op" value="total_late desc">지각많은순</option>
				<option class="op" value="total_early_endcheck desc">조기퇴근많은순</option>
				<option class="op" value="total_no_endcheck desc">퇴근미체크많은순</option>
				<option class="op" value="total_no_workday desc">결근많은순</option>
				<option class="op" value="totalworkingdays desc">근무일수많은순</option>
				<option class="op" value="totalworkedtime desc">근무시간많은순</option>
			</select>
		</div>
	</div>
</form>

<h2 class="mb-5">근무통계</h2>
<table id="tbl_result" class="tcenter">
	<tr id="fileItemTapLi">
		<th colspan="1"  ></th>
		<th colspan="4" style="border: solid 1px gray;">이름/부서</th>
		<th colspan="4" style="border: solid 1px gray;">근태</th>
		<th colspan="2" style="border: solid 1px gray;">근무</th>
	</tr>
	<tr id="fileItemTapLi">	
		<th class="" style="width: 72px; padding: 10px 0;">번호</th>
		
		<th class="" style="width: 142px;">사원번호</th>
		<th class="" style="width: 67px;">이름</th>
		<th class="" style="width: 67px;">부서</th>
		<th class="" style="width: 107px;">재직구분</th>
		
		<th class="" style="width: 87px;">지각</th>
		<th class="" style="width: 87px;">조기퇴근</th>
		<th class="" style="width: 87px;">퇴근미체크</th>
		<th class="" style="width: 87px;">결근</th>
		
		<th class="" style="width: 142px;">총 근무일수</th>
		<th class="" style="width: 162px;">총 근무시간</th>
	</tr>
	
	<c:if test="${empty requestScope.commuteStatusInfo }">
		<tr class="" >
			<td colspan="12">근무통계 조회결과가 없습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty requestScope.commuteStatusInfo }">
		<c:forEach var="InfoMap" items="${requestScope.commuteStatusInfo }" varStatus="status">
	
		<tr class="commuteList" onclick="showOneCommuteStatusByAjax('${InfoMap.pk_empnum}','${InfoMap.name}')" data-toggle="modal" data-target="#oneCommuteStatusInfo">
			<td style="padding: 10px 0;">${(5 * (requestScope.currentShowPageNo-1))+ status.count }</td>
			<td>${InfoMap.pk_empnum }</td>
			<td>${InfoMap.name }</td>
			<td>${InfoMap.deptnamekor }</td>
			<td>${InfoMap.resignationstatus }</td>
			<td>${InfoMap.total_late }</td>
			<td>${InfoMap.total_early_endcheck }</td>
			<td>${InfoMap.total_no_endcheck }</td>
			<td>${InfoMap.total_no_workday }</td>
			<td>${InfoMap.totalworkingdays}</td>
			<td>${InfoMap.totalworkedtime}</td>
		</tr>
	
		</c:forEach>
	</c:if>
</table>
	
<%-- 페이지바 보여주는 곳! --%>
<div align="center" id="pageBar" >
	${requestScope.pageBar }
</div>

<%-- 관리자가 보는 개인 근태관리 모달창 --%>
<div class="modal" id="oneCommuteStatusInfo">
	<div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel"><span id="OneName"></span>님의 근태관리</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <table class="tcenter" style="width: 100%;">
		<tr id="fileItemTapLi" >
			<th colspan="1" ></th>
			<th colspan="4" style="border: solid 1px gray;">출퇴근기록</th>
			<th colspan="4" style="border: solid 1px gray;">근태</th>
		</tr>
		<tr id="fileItemTapLi" style="font-size: 19px;">	
			<th class="" style="width: 70px;">번호</th>
			<th class="" style="width: 110px;">근무날짜</th>
			<th class="" style="width: 110px;">출근시각</th>
			<th class="" style="width: 110px;">퇴근시각</th>
			<th class="" style="width: 110px;">근무시간</th>
			<th class="" style="width: 80px;">지각</th>
			<th class="" style="width: 80px;">조기퇴근</th>
			<th class="" style="width: 80px;">퇴근미체크</th>
			<th class="" style="width: 80px;">결근</th>
		</tr>
		
	</table>
		<!--  여기 조회값 들어옴 -->
		<span id="oneCommuteStatusResult" ></span>
	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


</div>
</div>
