<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원조회 페이지</title>

<style type="text/css">
.fileUL {list-style-type: none;}
.fleft{float: left;}
.tcenter{text-align: center;}
.bnone{border: none;}
#fileItemTapLi{
	padding: 30px auto; 
	background-color: rgba(190, 190, 190, 0.1);  
	margin: 30px auto; 
	font-weight: bold; 
	width: 100%;
	height: 50px;
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
input{width: 80px;}
th, td{padding: 7px 0 0 9px;}
#orderby{
	height: 50px;
	text-align: right;
}
#select_order{width: 130px;}
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
#tbl_result{margin-bottom: 100px;}
.date{width:100px;}
div#pageBar{
	width: 70%; 
	margin: 20px auto 150px auto; 
}
a{
	text-decoration: none !important;
	color: #6449fc;
}
.m_div{
	margin-bottom: 5px;
}
.empList{
	margin: 5px 0;
	vertical-align: middle;
	border-bottom: solid 1px rgba(200, 200, 200, 0.3);
	
}
.empList:hover{
	cursor: pointer;
	background-color: rgba(153, 102, 255, 0.1);  
}
.bgColor{
	background-color: rgba(153, 102, 255, 0.1);
}
</style>


<script type="text/javascript">
$(document).ready(function(){
	
	// 뷰단에 값을 고정시키기 위함
	$("select[name='dept']").val( '${requestScope.dept}' );
	$("select[name='spot']").val( '${requestScope.spot}' );
	$('input#date_start').val('${requestScope.date_start}');
	$('input#date_end').val('${requestScope.date_end}');
	$("select[name='resign_status']").val( '${requestScope.resign_status}' );
	$("select[name='search_item']").val( '${requestScope.search_item}' );
	$("input#search_value").val( '${requestScope.search_value}' );
	$("select#select_order").val('${requestScope.select_order}');
	
	// select#select_order 선택시 재정렬
	$("select#select_order").bind("change", function(){
		
		goSearch();
		
	})// end of $("select#select_order").bind("change", function(){
	
	
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
	
	const frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "viewEmp.groovy"; // 자기자신한테 간다.
	frm.submit();
	
}// end of function goSearch()


//ajax 로 한명의 사원 정보 select => 모달로 보여주기
function getOneEmpInfo(pk_empnum){
	
	$.ajax({
		url:"<%=ctxPath%>/getOneEmpInfo.groovy",
		data:{"pk_empnum":pk_empnum },
		type:"GET",
		dataType:"JSON",
		success:function(json){
			
			const imgUrl = "<%=ctxPath %>/resources/images/프로필사진/"+json.emppicturename;
			$("#empImg").attr("src", imgUrl);

	
			$("span#m_pk_empnum").html(json.pk_empnum);
			$("span#m_name").html(json.name);
			$("span#m_birthday").html(json.birthday);
			
			if(json.gender == 1){
				$("span#m_gender").html("남자");
			}else{
				$("span#m_gender").html("여자");
			}
			
			$("span#m_age").html(json.age);
			
			$("span#m_postcode").html(json.postcode);
			$("span#m_address").html(json.address);
			$("span#m_detailaddress").html(json.detailaddress);
			
			$("span#m_phone").html(json.phone);
			$("span#m_email").html(json.email);
			
			// 부서 직위
			$("span#m_deptnamekor").html(json.deptnamekor);
			$("span#m_spotnamekor").html(json.spotnamekor);
			
			$("span#m_startday").html(json.startday);

			
			if(json.resignationstatus == 0){
				$("span#m_resignationstatus").html("재직");
			}else{
				$("span#m_resignationstatus").html("퇴직");
			}
			
			$("span#m_resignationday").html(json.resignationday);
			
			if(json.fk_vstatus == 0){
				$("span#m_fk_vstatus").html("근무중");
			}else{
				$("span#m_resignationstatus").html("휴가중");
			}
			
			$("span#m_salary").html(json.salary.toLocaleString('en'));
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          }
	});// end of $.ajax
	
}// end of function getOneEmpInfo()

</script>
</head>

<body>

<div class="container-md" style="margin-top: 45px;">
<div class="project-detail-top clearfix">


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
		
	<div id="orderby">
		<div>
			<select id="select_order" name="select_order">
				<option class="op" value="pk_empnum desc" selected>사번 높은순</option>
				<option class="op" value="name asc">이름 가나다순</option>
				<option class="op" value="pk_spotnum desc">직급 높은순</option>
				<option class="op" value="startday desc">최근 입사일순</option>
			</select>
		</div>
	</div>
	
	</form>
	
	
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
		
		
		<c:if test="${empty requestScope.emps }">
			<tr class="" >
				<td colspan="12">조회결과가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${not empty requestScope.emps }">
			<c:forEach var="emp" items="${requestScope.emps }" varStatus="status">
				<tr class="empList"  onclick="getOneEmpInfo('${emp.pk_empnum}')" 
					data-toggle="modal" data-target="#exampleModal">
					<td>${(10 * (requestScope.currentShowPageNo-1))+ status.count }</td>
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
	<div align="center" id="pageBar" >
		${requestScope.pageBar }
	</div>


<!-- 모달팝업 -->
<div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document" style="width: 80%;">
    <div class="modal-content ">
      <div class="modal-header bgColor" >
        <h4 class="modal-title" id="exampleModalLabel" ><span id="m_name" style="font-weight: bold; margin-left: 40px;"></span>님의 상세 정보</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body" >
      <div style="padding-left: 40px;">
       		<img id="empImg" style=" width:140px; height:160px;">
     		<div style="float: right; margin: 0 185px 0 10px; border: solid 1px gray; border-radius: 10px; padding: 10px 15px;">
	      		<div class="m_div">사원번호 : <span id="m_pk_empnum" ></span></div>
	      		<div class="m_div">이름 : <span id="m_name" ></span></div>
	      		<div class="m_div">생년월일 : <span id="m_birthday"></span></div>
	      		<div class="m_div">성별 : <span id="m_gender"></span></div>
	      		<div class="m_div">나이 : <span id="m_age"></span>세</div>
	      		<div class="m_div">주소 : (<span id="m_postcode"></span>)&nbsp;
	      					<span id="m_address"></span>&#44;&nbsp;
	      					<span id="m_detailaddress"></span>
	      		</div>
	      		<div class="m_div">연락처 : <span id="m_phone"></span></div>
	      		<div class="m_div">이메일 : <span id="m_email"></span></div>
	      		<div class="m_div">부서 : <span id="m_deptnamekor" ></span></div>
		     	<div class="m_div">직위 : <span id="m_spotnamekor"></span></div>
		     	<div class="m_div">입사일자 : <span id="m_startday"></span></div>
		     	<div class="m_div">재직여부 : <span id="m_resignationstatus"></span>&nbsp;
			      					<span id="m_resignationday"></span>
			     </div>
		     	<div class="m_div">휴가상태 : <span id="m_fk_vstatus"></span></div>
		     	<div class="m_div">월급 : <span id="m_salary"></span></div>
     		</div>
     </div>
     
      </div>
      
      <div class="modal-footer bgColor" >
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background-color: rgba(153, 102, 255, 0.7);">Close</button>
      </div>
    </div>
  </div>
</div>
	
</div>
</div>

</body>
</html>