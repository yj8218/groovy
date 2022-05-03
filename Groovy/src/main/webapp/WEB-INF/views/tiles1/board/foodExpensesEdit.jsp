<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식비사용내역</title>

<style type="text/css">

div#container {
	margin-left: 50px;
	width: 60%;
	position: relative;
	display: inline-block;
	float: left;
}

div.title {
	margin-top: 50px;
}

span.title {
	font-size: 16pt;
	font-weight: bold;
	margin: 10px 5px;
}

form[name="foodExpensesEdit"]{
	margin-top: 20px;
}

div.box {
	margin-top: 20px;
}

input.box {
	height: 38px;
	width: 100%;
	border-radius: 5px;
	border: solid 1px grey;
}

label {
	font-weight: bold;
	font-size: 12pt;
}

button.btn {
	width: 120px;
	border: solid 1px grey;
	margin: 30px;
	background-color: #6449FC;
	color: white;
}

div#btn {
	text-align: center;
	margin: 0 auto;
}

button.btn:hover {
	font-weight: bold;
	color: white;
	background-color: #b3b3ff;
}

div#approvePerson {
	border: solid 1px grey;
	width: 300px;
	height: 500px;
    border-radius: 10px;
    display: inline-block;
    padding: 30px;
}

button#approvePersonAdd {
	margin: 30px auto;
}

</style>

	<%-- Required meta tags --%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<%-- Bootstrap CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<%-- Bootstrap Icons --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<%-- Font Awesome 5 Icons --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<%-- Optional JavaScript --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" >
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 

<script type="text/javascript">
	
$(document).ready(function(){

	$("input#datepicker").datepicker({
        dateFormat: 'yy-mm-dd'  //Input Display Format 변경
       ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
       ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
       ,changeYear: true        //콤보박스에서 년 선택 가능
       ,changeMonth: true       //콤보박스에서 월 선택 가능                
    // ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
    // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
    // ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    // ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
       ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
       ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
       ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
       ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
       ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
     //,minDate: '-100Y' //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
     //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)           
	 // ,yearRange: 'c-120:c+0' 
		,allowInvalid: true
	  //,minDate: '1900-01-01'
	  //,maxDate: new Date() // 만약 오늘 날짜까지만 설정하는 경우

	});                    
   
	//초기값을 오늘 날짜로 설정
	$('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	//////////////////////////////////////
	
});	
	
	
// 팝업창 띄우기 (사람 선택창)
function approvePerson() {
	// 승인참조 선택 띄우기
	const url = "<%= request.getContextPath()%>/approvePersonAdd.groovy";
	
	// 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const pop_width = 900;
	const pop_height = 800;
	const pop_left = Math.ceil( ((window.screen.width)-pop_width)/2 ); 
	const pop_top = Math.ceil( ((window.screen.height)-pop_height)/2 );
	
	window.open(url, "approvePersonAdd",
			   	"left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height );
}	
	
	
</script>

</head>
<body>

	
<div id="container">
		
		<div class="title">
			<i class="fas fa-hamburger fa-2x"></i> <span class="title">식비사용내역</span>
		</div>

		<div class="title">작성 시 영수증을 첨부해주세요.</div>
		
		<form name="foodExpensesEdit">
			<div class="box">
				<label>사용 날짜</label><br>
				<input type="text" id="datepicker" name="foodExpensesDate" size="50" class="box" autocomplete="off" />
			</div>
	
			<div class="box">
				<label>사용 금액</label><br>
				<input type="text" name="foodExpensesCost" size="50" class="box" autocomplete="off" />
			</div>
			
			<div class="box">
				<label>식사 인원</label><br>
				<input type="text" name="foodExpensesPersonCnt" size="50" class="box" autocomplete="off" placeholder="숫자을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>비고</label><br>
				<input type="text" name="foodExpensesETC" size="50" class="box" autocomplete="off" placeholder="내용을 입력하세요."/>
			</div>
			
			<div class="box">
				<label>점부파일</label><br>
				<input type="file" name="fileUpload" size="50" />
			</div>
			
			<div id="btn" class="box">
				<button type="button"  class="btn">신청하기</button>
				<button type="button"  class="btn" onclick="javascript:location.href='<%= ctxPath%>/approvalView.groovy'">취소</button>
			</div>

		</form>
	
</div>
		
<div id="approvePerson" style="margin: 70px;">
	<span id="title">승인, 참조대상</span><br>
	<button type="button" class="btn" id="approvePersonAdd" onclick="approvePerson();">등록하기</button>
	<div id="employeeList"></div>
</div> 

</body>
</html>