<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<style type="text/css">

div.sideCalList {
  height: 100%;
  width: 230px;
  padding-right: 0;
  position: fixed;
  z-index: 100;
  top: 0;
  left: 0;  
  background-color: #eee;
  border-right: 1px solid #555;
  overflow-x: hidden;
  padding-top: 45px;
  color: #333;
  
}

div.sideCalList > ul {
padding: 0;
}

div.sideCalList > ul > li {
  border-bottom: 1px solid #ddd;
}


div.sideCalList div.mainlogo{
 border-bottom: solid 0.8px #595959; 
 
 border-top: solid 0.8px #eee;
}



div.comCalTitle, div.myCalTitle, div.shareCalTitle {

  
	position: relative;
   padding: 11px 20px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
}

div.comCalTitle i.ico-arrow, div.myCalTitle i.ico-arrow, div.shareCalTitle i.ico-arrow {
 position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%) rotate(-180deg);
    font-style: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased; 
}


div.comCalTitle.active .ico-arrow, div.myCalTitle.active i.ico-arrow, div.shareCalTitle.active i.ico-arrow  {
    -webkit-transform: translateY(-50%);
    transform: translateY(-50%);
}


div.comCalList {
margin: 0 0 12px 0;
overflow: inherit;

}

div.comCalList ul {
	display: inline-block;
    width: 100%;
    margin: 0;
    color: #333;
    padding-left: 0;
}

div.comCalList ul li:first-child {
	margin-top: 0px;
}

div.comCalList ul li {
	margin-top: 6px;
	line-height: 20px;
    padding: 0 20px;
}

div.comCalList ul li div {
	height: auto;
    margin: 0;
}

div.comCalList ul li div span {
	 margin-left: 0;
	  font-size: 13px;
	  color: #333;
	  margin-bottom: 0;
}



div.comCalList p, div.myCalList p, div.shareCalList p {
margin: 0;
}




div.myCalList {
margin: 0 0 12px 0;
overflow: inherit;

}

div.myCalList ul {
	display: inline-block;
    width: 100%;
    margin: 0;
    color: #333;
    padding-left: 0;
}

div.myCalList ul li:first-child {
	margin-top: 0px;
}

div.myCalList ul li {
	margin-top: 6px;
	line-height: 20px;
    padding: 0 20px;
}

div.myCalList ul li div {
	height: auto;
    margin: 0;
}

div.myCalList ul li div span {
	 margin-left: 0;
	  font-size: 13px;
	  color: #333;
	   margin-bottom: 0;
}






div.shareCalList {
margin: 0 0 12px 0;
overflow: inherit;

}

div.shareCalList ul {
	display: inline-block;
    width: 100%;
    margin: 0;
    color: #333;
    padding-left: 0;
}

div.shareCalList ul li:first-child {
	margin-top: 0px;
}

div.shareCalList ul li {
	margin-top: 6px;
	line-height: 20px;
    padding: 0 20px;
}

div.shareCalList ul li div {
	height: auto;
    margin: 0;
}

div.shareCalList ul li div span {
	 margin-left: 0;
	  font-size: 13px;
	  color: #333;
	   margin-bottom: 0;
}



a.sideBtn{
    position: fixed;
    top: 45%;
    left: 214px;
    width: 30px;
    height: 30px;
    border: 1px solid #555;
    border-radius:4px;
    box-sizing: border-box;
    text-align: center;
    z-index: 200;
	background: #fff;
    border: 1px solid #555;
    color: #555;
    
   
}


a.sideBtn.open{
	background: #fff;
    border: 1px solid #555;
    color: #595959;
    
    
}


a.sideBtn:after{
   position: relative;
   bottom: 4px;
    font-size: 24px;
    content: "\e900";
    font-family: fcicons!important;
   
}



a.sideBtn.open:after{
 	content: "\e901";
}

a.sideBtn:hover, a.sideBtn:hover+div.sideCalList {
	 border-color: #6449fc; 
}





div.sideCalList input[type=checkbox] {
    display:none;
}
div.sideCalList input[type=checkbox] + label { 
    cursor: pointer; 
    padding-left: 23px; 
    background-repeat: no-repeat;
    
    position: relative;
    top: 3px;
    width: 16px;
    height: 16px;
    
    margin-bottom:0;
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-off.svg');
    

       
}

div.sideCalList input[type=checkbox]:checked + label {
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-on.svg');
}
div.sideCalList input[type=checkbox]:disabled + label {
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-off.svg');
}











</style>

<script type="text/javascript">
var calendar;
$(document).ready(function(){
	
	//sideCalList 시작//

	// === 사내 캘린더에 사내캘린더 소분류 보여주기 ===
	showCompanyCal();

	// === 내 캘린더에 내캘린더 소분류 보여주기 ===
	showmyCal();

	// === 사내캘린더 체크박스 전체 선택/전체 해제 === //
	$("input:checkbox[id=allComCal]").click(function(){
		var bool = $(this).prop("checked");
		$("input:checkbox[name=com_smcatgono]").prop("checked", bool);
	});// end of $("input:checkbox[id=allComCal]").click(function(){})
	
	
	// === 내캘린더 체크박스 전체 선택/전체 해제 === //
	$("input:checkbox[id=allMyCal]").click(function(){		
		var bool = $(this).prop("checked");
		$("input:checkbox[name=my_smcatgono]").prop("checked", bool);
	});// end of $("input:checkbox[id=allMyCal]").click(function(){})
			
	
	
	$("div.comCalTitle").click(function() {
		$("div.comCalList").toggle();
		$("div.comCalTitle").toggleClass("active");
	});//end of $("div.comCalTitle").click(function() 
		
	$("div.myCalTitle").click(function() {
		$("div.myCalList").toggle();
		$("div.myCalTitle").toggleClass("active");
	});//end of $("div.myCalTitle").click(function()
	
	$("div.shareCalTitle").click(function() {
		$("div.shareCalList").toggle();
		$("div.shareCalTitle").toggleClass("active");
	});//end of $("div.shareCalTitle").click(function()
	
	
	// === 사내캘린더 에 속한 특정 체크박스를 클릭할 경우 === 
	$(document).on("click","input:checkbox[name=com_smcatgono]",function(){	
		var bool = $(this).prop("checked");
		
		if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
			
			var flag=false;
			
			$("input:checkbox[name=com_smcatgono]").each(function(index, item){
				var bChecked = $(item).prop("checked");
				
				if(!bChecked){     // 체크되지 않았다면 
					flag=true;     // flag 를 true 로 변경
					return false;  // 반복을 빠져 나옴.
				}
			}); // end of $("input:checkbox[name=com_smcatgono]").each(function(index, item){})

			if(!flag){ // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
                $("input#allComCal").prop("checked",true); // 사내캘린더 체크박스에 체크를 한다.
			}
			
			var com_smcatgonoArr = document.querySelectorAll("input.com_smcatgono");
		    
			com_smcatgonoArr.forEach(function(item) {
		         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
		         //	 console.log(item);
		        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
		         });
		    });// end of com_smcatgonoArr.forEach(function(item) {})

		}
		
		else {
			   $("input#allComCal").prop("checked",false);
		}
		
	});// end of $(document).on("click","input:checkbox[name=com_smcatgono]",function(){})
	
	
	// === 내캘린더 에 속한 특정 체크박스를 클릭할 경우 === 
	$(document).on("click","input:checkbox[name=my_smcatgono]",function(){	
		var bool = $(this).prop("checked");
		
		if(bool){ // 체크박스에 클릭한 것이 체크된 것이라면 
			
			var flag=false;
			
			$("input:checkbox[name=my_smcatgono]").each(function(index, item){
				var bChecked = $(item).prop("checked");
				
				if(!bChecked){    // 체크되지 않았다면 
					flag=true;    // flag 를 true 로 변경
					return false; // 반복을 빠져 나옴.
				}
			}); // end of $("input:checkbox[name=my_smcatgono]").each(function(index, item){})

			if(!flag){	// 내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 	
                $("input#allMyCal").prop("checked",true); // 내캘린더 체크박스에 체크를 한다.
			}
			
			var my_smcatgonoArr = document.querySelectorAll("input.my_smcatgono");
		      
			my_smcatgonoArr.forEach(function(item) {
				item.addEventListener("change", function() {   // "change" 대신에 "click" 을 해도 무방함.
				 // console.log(item); 
					calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
		        });
		    });// end of my_smcatgonoArr.forEach(function(item) {})

		}
		
		else {
			   $("input#allMyCal").prop("checked",false);
		}
		
	});// end of $(document).on("click","input:checkbox[name=my_smcatgono]",function(){})
	

	// 검색할 때 필요한 datepicker
	// 모든 datepicker에 대한 공통 옵션 설정
    $.datepicker.setDefaults({
         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true        // 콤보박스에서 년 선택 가능
        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
    });
	
    // input 을 datepicker로 선언
    $("input#fromDate").datepicker();                    
    $("input#toDate").datepicker();
    	    
    // From의 초기값을 한달전 날짜로 설정
    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
    
    // To의 초기값을 오늘 날짜로 설정
//  $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
	
    // To의 초기값을 한달후 날짜로 설정
    $('input#toDate').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
	
	// ==== 풀캘린더와 관련된 소스코드 시작(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //
	var calendarEl = document.getElementById('calendar');
        
	calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        selectable: true,
	    editable: false,
	    headerToolbar: {
	    	  left: 'prev next',
	          /* center: 'title', dayGridMonth dayGridWeek dayGridDay 'prev next' */
	          right: 'today'
	    },
	    dayMaxEventRows: true, // for all non-TimeGrid views
	    views: {
	      timeGrid: {
	        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay\
	      }
	    },
	    

	    <%--
	    // ===================== DB 와 연동하는 법 시작 ===================== //
    	events:function(info, successCallback, failureCallback) {
	
	    	 $.ajax({
                 url: '<%= ctxPath%>/schedule/selectSchedule.groovy',
                 data:{"fk_empnum":$('input#fk_empnum').val()},
                 dataType: "json",
                 success:function(json) {
                	 /*
                	    json 의 값 예
                	    [{"enddate":"2021-11-26 18:00:00.0","fk_lgcatgono":"2","color":"#009900","pk_scheduleno":"1","fk_smcatgono":"4","subject":"파이널 프로젝트 코딩","startdate":"2021-11-08 09:00:00.0","fk_empnum":"seoyh"},{"enddate":"2021-11-29 13:50:00.0","fk_lgcatgono":"1","color":"#990008","pk_scheduleno":"2","fk_smcatgono":"7","subject":"팀원들 점심식사","joinuser":"leess,eomjh","startdate":"2021-11-29 12:50:00.0","fk_empnum":"seoyh"},{"enddate":"2021-12-02 20:00:00.0","fk_lgcatgono":"1","color":"#300bea","pk_scheduleno":"3","fk_smcatgono":"11","subject":"팀원들 뒤풀이 여행","joinuser":"leess,eomjh","startdate":"2021-12-01 09:00:00.0","fk_empnum":"seoyh"}]
                	 */
                	 var events = [];
                     if(json.length > 0){
                         
                             $.each(json, function(index, item) {
                                    var startdate = moment(item.startdate).format('YYYY-MM-DD HH:mm:ss');
                                    var enddate = moment(item.enddate).format('YYYY-MM-DD HH:mm:ss');
                                    var subject = item.subject;
                              
                                   // 사내 캘린더로 등록된 일정을 풀캘린더 달력에 보여주기 
                                   // 일정등록시 사내 캘린더에서 선택한 소분류에 등록된 일정을 풀캘린더 달력 날짜에 나타내어지게 한다.
                                   if( $("input:checkbox[name=com_smcatgono]:checked").length <= $("input:checkbox[name=com_smcatgono]").length ){
	                                   
	                                   for(var i=0; i<$("input:checkbox[name=com_smcatgono]:checked").length; i++){
	                                	  
	                                		   if($("input:checkbox[name=com_smcatgono]:checked").eq(i).val() == item.fk_smcatgono){
	   			                               //  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=com_smcatgono]:checked").eq(i).val());
	                                			   events.push({
	   			                                	            id: item.pk_scheduleno,
	   			                                                title: item.subject,
	   			                                                start: startdate,
	   			                                                end: enddate,
	   			                                        	    url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno,
	   			                                                color: item.color,
	   			                                                cid: item.fk_smcatgono  // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
	   			                                   }); // end of events.push({})
	   		                                   }
	                                	   
	                                   }// end of for
	                                 
                                   }// end of if
                                    
                                  
                                  // 내 캘린더로 등록된 일정을 풀캘린더 달력에 보여주기
                                  // 일정등록시 내 캘린더에서 선택한 소분류에 등록된 일정을 풀캘린더 달력 날짜에 나타내어지게 한다.
                                  if( $("input:checkbox[name=my_smcatgono]:checked").length <= $("input:checkbox[name=my_smcatgono]").length ){
	                                   
	                                   for(var i=0; i<$("input:checkbox[name=my_smcatgono]:checked").length; i++){
	                                	  
	                                		   if($("input:checkbox[name=my_smcatgono]:checked").eq(i).val() == item.fk_smcatgono && item.fk_empnum == "${sessionScope.loginuser.pk_empnum}" ){
	   			                               //  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=my_smcatgono]:checked").eq(i).val());
	                                			   events.push({
	   			                                	            id: item.pk_scheduleno,
	   			                                                title: item.subject,
	   			                                                start: startdate,
	   			                                                end: enddate,
	   			                                        	    url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno,
	   			                                                color: item.color,
	   			                                                cid: item.fk_smcatgono  // 내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
	   			                                   }); // end of events.push({})
	   	                                    }
	                                   }// end of for
                                   
                                   }// end of if

                                 
                                  // 공유받은 캘린더(다른 사용자가 내캘린더로 만든 것을 공유받은 경우임)
                                  if (item.fk_lgcatgono==1 && item.fk_empnum != "${sessionScope.loginuser.pk_empnum}" && (item.joinuser).indexOf("${sessionScope.loginuser.pk_empnum}") != -1 ){  
                                        
  	                                   events.push({
  	                                	   			id: "0",  // "0" 인 이유는  배열 events 에 push 할때 id는 고유해야 하는데 위의 사내캘린더 및 내캘린더에서 push 할때 id값으로 item.scheduleno 을 사용하였다. item.scheduleno 값은 DB에서 1 부터 시작하는 시퀀스로 사용된 값이므로 0 값은 위의 사내캘린더나 내캘린더에서 사용되지 않으므로 여기서 고유한 값을 사용하기 위해 0 값을 준 것이다. 
  	                                                title: item.subject,
  	                                                start: startdate,
  	                                                end: enddate,
  	                                        	    url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno,
  	                                                color: item.color,
  	                                                cid: "0"  // "0" 인 이유는  공유받은캘린더 에서의 체크박스의 value 를 "0" 으로 주었기 때문이다.
  	                                   }); // end of events.push({})
  	                                   
  	                           		}// end of if
                                
                             }); // end of $.each(json, function(index, item) {})
                         }                             
                         
                      // console.log(events);                       
                         successCallback(events);                               
                  },
				  error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			      }	
                                            
          }); // end of $.ajax()
        
        }, // end of events:function(info, successCallback, failureCallback) {}
        --%>
        // ===================== DB 와 연동하는 법 끝 ===================== //
        
		// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
        dateClick: function(info) {
      	 // alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
      	   /*  $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기 */
      	    $("form > input[name=chooseDate]").val(info.dateStr);
      	    
      	    var frm = document.dateFrm;
      	    frm.method="POST";
      	    frm.action="<%= ctxPath%>/schedule/insertSchedule.groovy";
      	   /*  frm.submit(); */
      	  },
      	  
      	 // === 사내캘린더, 내캘린더, 공유받은캘린더의 체크박스에 체크유무에 따라 일정을 보여주거나 일정을 숨기게 하는 것이다. === 
    	 eventDidMount: function (arg) {
	            var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
	            // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스임
	            
	            arr_calendar_checkbox.forEach(function(item) { // item 이 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스 중 하나인 체크박스임
		              if (item.checked) { 
		            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 한 경우 라면
		                
		            	if (arg.event.extendedProps.cid === item.value) { // item.value 가 체크박스의 value 값이다.
		                	// console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
		                	// console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);
		                    
		                	arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
		                }
		              } 
		              
		              else { 
		            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 해제한 경우 라면
		                
		            	if (arg.event.extendedProps.cid === item.value) {
		            		// console.log("일정을 숨기는 cid : "  + arg.event.extendedProps.cid);
		                	// console.log("일정을 숨기는 체크박스의 value값(item.value) : " + item.value);
		                	
		            		arg.el.style.display = "none"; // 풀캘린더에서 일정을  숨긴다.
		                }
		              }
	            });// end of arr_calendar_checkbox.forEach(function(item) {})
	      }
	});
    
	calendar.render();  // 풀캘린더 보여주기
  
  	var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
  	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스임
  
	arr_calendar_checkbox.forEach(function(item) {
		item.addEventListener("change", function () {
	    // console.log(item);
	 	calendar.refetchEvents(); // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
	  });
	});
  	
  	//==== 풀캘린더와 관련된 소스코드 끝(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //

	// 검색 할 때 엔터를 친 경우
	$("input#searchWord").keyup(function(event) {
		if(event.keyCode == 13){ 
	 		goSearch();
		}
	});//end of $("input#searchWord").keyup(function(event)
 
	//FullCalendar.Calendar(
	// 모달 창에서 입력된 값 초기화 시키기 //
	$("button.modal_close").on("click", function() {
		var modal_frmArr = document.querySelectorAll("form[name=modal_frm]");
	 	for(var i=0; i<modal_frmArr.length; i++) {
	  		modal_frmArr[i].reset();
	 	}
	});//end of $("button.modal_close").on("click", function()
  
	/* 		
	//==== 달력에 '일' 제거 ==== //		
	$('a.fc-daygrid-day-number').each(function(index) {
		const day = $(this).text().replace("일","");
		$(this).text(day);
	});//end of $('a.fc-daygrid-day-number').each(function(index)
	*/
	
	//==== 년도월 select 생성 시작 ==== //
	$(".fc-prev-button").after("<div class='fc-title'></div>");
		//<button class='monthsBtn'>56</button>	
		//<ul class='monthsList'></ul>
	
 	buildMonthList();
 	
 	const label = document.querySelector('.monthsBtn');
	const options = document.querySelectorAll('.months');
	var saveDay = calendar.getDate();	
 	
	$("li.months").on('click', function() {
		console.log($(this).children().val());
		calendar.gotoDate($(this).children().val());
		//buildMonthList();
	});//end of $('#months').on('change', function() 
			
	//buildMonthList(); 
		

	// 클릭한 옵션의 텍스트를 라벨 안에 넣음
	const handleSelect = function(item) {
	  label.innerHTML = item.textContent;
	  //$("div.fc-title").removeClass("active");
	  //label.parent().removeClass("active");
	  label.parentNode.classList.remove('active');
	}//end of const handleSelect = function(item)
 	
	// 옵션 클릭시 클릭한 옵션을 넘김
	options.forEach(function(option) {
	  option.addEventListener('click', function(){handleSelect(option)})
	})//end of options.forEach(function(option)
	 	
	// 라벨을 클릭시 옵션 목록이 열림/닫힘
	label.addEventListener('click', function() {
	  if(label.parentNode.classList.contains('active')) {
	    label.parentNode.classList.remove('active');
	  } else {
	    label.parentNode.classList.add('active');
	  }
	});//end of label.addEventListener('click', function()
	
	$("button.fc-prev-button").click(function() {
		var showDay;
		saveDay = moment(saveDay).add(-1, "month").format("YYYY-MM");
		showDay = moment(saveDay).format("YYYY년 MM월");
		label.innerHTML = showDay;
	});//end of $("button.fc-prev-button").click(function()
	
	$("button.fc-next-button").click(function() {
		saveDay = moment(saveDay).add(+1, "month").format("YYYY-MM");
		showDay = moment(saveDay).format("YYYY년 MM월");
		label.innerHTML = showDay;
	});//end of $("button.fc-next-button").click(function()
		
	//==== 년도월 select 생성 끝==== //
	
	//==== 월주일 select 생성 시작 ==== //
	
	$(".fc-today-button").before("<div class='month-week-day'></div>");
	buildMWD();
	
	const mwdBtn = document.querySelector('.mwdBtn');
	const mwd = document.querySelectorAll('.mwd');
	
	// 클릭한 옵션의 텍스트를 라벨 안에 넣음
	const handleSelect2 = function(item) {
		mwdBtn.innerHTML = item.textContent;
		mwdBtn.parentNode.classList.remove('active');
	}//end of const handleSelect = function(item)
 	
	// 옵션 클릭시 클릭한 옵션을 넘김
	mwd.forEach(function(mwd) {
		mwd.addEventListener('click', function(){handleSelect2(mwd)})
	})//end of options.forEach(function(option)
	 	
	// 라벨을 클릭시 옵션 목록이 열림/닫힘
	mwdBtn.addEventListener('click', function() {
	  if(mwdBtn.parentNode.classList.contains('active')) {		 
		mwdBtn.parentNode.classList.remove('active'); 
	  } else {
		  mwdBtn.parentNode.classList.add('active');
	  }
	});//end of label.addEventListener('click', function()
	
	
	
	$("li.mwd").click(function() {
		const mwdChoice = $(this).text();
		if(mwdChoice == "월"){
			calendar.changeView('dayGridMonth');
		}else if(mwdChoice == "주"){
			calendar.changeView('dayGridWeek');
		}else{
			calendar.changeView('dayGridDay');
		}
	});//end of $("li.mwd").click(function()
			
	//==== 월주일 select 생성 끝 ==== //	
	 $("div#optionList").hide();
	
	
	$("button#option").click(function() {
		$("div#optionList").toggle();
	});//end of $("li.mwd").click(function()
	
	$("i.fa-search").click(function() {
		goSearch();		
	});//end of $("li.mwd").click(function()
		
			
	$("a.sideBtn").click(function() {
			$("div.sideCalList").toggle();
			$("a.sideBtn").toggleClass("open");
			/* $("a.sideBtn").html("열기"); */
	});//end of $("a.sideBtn").click(function()
			
			
			
			
			
			
}); // end of $(document).ready(function(){})

//~~~~~~~ Function Declartion ~~~~~~~

// === 년월 select 표시 ===
function buildMonthList() {
	$("div.fc-title").empty();
	//$("ul.monthsList").empty();
	var month = calendar.getDate();
	var initial = moment(month).format("YYYY-MM");
	initial = moment(month).add(-2, "month").format("YYYY-MM");
	
	var button = document.createElement("button");
	button.className = "monthsBtn";
	var text = document.createTextNode(moment(month).format("YYYY년 MM월"));
	button.appendChild(text);
	//$("div.fc-title").prepend(button);
	$("div.fc-title").append(button);
	
	var ul = document.createElement("ul");
	ul.className = "monthsList";
	$("div.fc-title").append(ul);
	
	for(var i = 0; i < 5; i++) {
		var li = document.createElement("li");
		li.id = (moment(initial).format("YYYY-MM"));
		li.className = "months";
		
		var a = document.createElement("a");
		a.value = moment(initial).format("YYYY-MM-01");
		a.text = moment(initial).format("YYYY년 MM월");
		a.selected = initial === moment(month).format("YYYY-MM");
		
		$("ul.monthsList").append(li);
		$("li#"+moment(initial).format("YYYY-MM")).append(a);
		
		initial = moment(initial).add(1, "month").format("YYYY-MM");
	}
}//end of function buildMonthList()	


function buildMWD() {
	
	var button = document.createElement("button");
	button.className = "mwdBtn";
	var text = document.createTextNode("월");
	button.appendChild(text);
	$("div.month-week-day").append(button);
	
	var ul = document.createElement("ul");
	ul.className = "mwdList";
	$("div.month-week-day").append(ul);
	
	var li = document.createElement("li");
	li.id = "month";
	li.className = "mwd";
	text = document.createTextNode("월");
	li.appendChild(text);
	$("ul.mwdList").append(li);
	
	li = document.createElement("li");
	li.id = "week";
	li.className = "mwd";
	text = document.createTextNode("주");
	li.appendChild(text);
	$("ul.mwdList").append(li);
	
	li = document.createElement("li");
	li.id = "day";
	li.className = "mwd";
	text = document.createTextNode("일");
	li.appendChild(text);
	$("ul.mwdList").append(li);
	
}//end of function buildMonthList()	

// === 사내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
function addComCalendar(){
	$('#modal_addComCal').modal('show'); // 모달창 보여주기	
}// end of function addComCalendar(){}
		
// === 사내 캘린더 추가 모달창에서 추가 버튼 클릭시 ===
function goAddComCal(){
	if($("input.add_com_smcatgoname").val().trim() == ""){
 		  alert("추가할 사내캘린더 소분류명을 입력하세요!!");
 		  return;
 	}
 	else {
 		 $.ajax({
 			 url: "<%= ctxPath%>/schedule/addComCalendar.groovy",
 			 type: "post",
 			 data: {"com_smcatgoname": $("input.add_com_smcatgoname").val(), 
 				    "fk_empnum": "${sessionScope.loginuser.pk_empnum}"},
 			 dataType: "json",
 			 success:function(json){
 				 if(json.n != 1){
  					alert("이미 존재하는 '사내캘린더 소분류명' 입니다.");
  					return;
  				 }
 				 else if(json.n == 1){
 					 $('#modal_addComCal').modal('hide'); // 모달창 감추기				
 					 alert("사내 캘린더에 "+$("input.add_com_smcatgoname").val()+" 소분류명이 추가되었습니다.");
 					 
 					 $("input.add_com_smcatgoname").val("");
 					 showCompanyCal();  // 사내 캘린더 소분류 보여주기
 				 }
 			 },
 			 error: function(request, status, error){
  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    	     }	 
 		 });
 	  }
	
}// end of function goAddComCal(){}

// === 사내 캘린더에서 사내캘린더 소분류  보여주기  === //
function showCompanyCal(){
	$.ajax({
		 url:"<%= ctxPath%>/schedule/showCompanyCalendar.groovy",
		 type:"get",
		 dataType:"json",
		 success:function(json){
				 var html = "";
				 if(json.length > 0){
					 html += "<li>";
					 
					 $.each(json, function(index, item){
						 html += "<div>";
						 html += "<p>";
						 html += "<input type='checkbox' name='com_smcatgono' class='calendar_checkbox com_smcatgono' value='"+item.pk_smcatgono+"' checked id='com_smcatgono_"+index+"'/>";
						 html += "<label for='com_smcatgono_"+index+"'></label><span>"+item.smcatgoname+"</span>";
						
						
					
						 <%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다. 
						 if("${sessionScope.loginuser.fk_pcode}" =='3' && "${sessionScope.loginuser.fk_dcode}" == '4') { --%>
						 <%-- if("${sessionScope.loginuser.gradelevel}" =='10') {--%>
							 html += "<button class='btn_edit' data-target='editCal' onclick='editComCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-edit'></i></button></td>";  
							 html += "<button class='btn_edit delCal' onclick='delCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-trash'></i></button></td>";
						<%-- }--%>
						 
						 html += "</p>";
						 html += "</div>";	 
					 });
				 	 
					 html += "</li>";	
				 }
				 $("div.comCalList > ul").append(html);
		},
		error: function(request, status, error){
	           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }	 	
	});

}// end of function showCompanyCal()

// === 사내 캘린더내의 서브캘린더 수정 모달창 나타나기 === 
function editComCalendar(pk_smcatgono, smcatgoname){
	$('#modal_editComCal').modal('show'); // 모달 보이기
	$("input.edit_com_smcatgono").val(pk_smcatgono);
	$("input.edit_com_smcatgoname").val(smcatgoname);
}// end of function editComCalendar(pk_smcatgono, smcatgoname){}
		
// === 사내 캘린더내의 서브캘린더 수정 모달창에서 수정하기 클릭 === 
function goEditComCal(){
	
	if($("input.edit_com_smcatgoname").val().trim() == ""){
  		  alert("수정할 사내캘린더 소분류명을 입력하세요!!");
  		  return;
  	}
  	else{
		$.ajax({
			url:"<%= ctxPath%>/schedule/editCalendar.groovy",
			type: "post",
			data:{"pk_smcatgono":$("input.edit_com_smcatgono").val(), 
				  "smcatgoname": $("input.edit_com_smcatgoname").val(), 
				  "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
				  "caltype":"2"  // 사내캘린더
			     },
			dataType:"json",
			success:function(json){
				if(json.n == 0){
   					alert($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
   					return;
   				 }
				if(json.n == 1){
					$('#modal_editComCal').modal('hide'); // 모달 숨기기
					alert("사내 캘린더명을 수정하였습니다.");
					showCompanyCal();
				}
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
  	  }
	
}// end of function goEditComCal(){}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	

// === 내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
function addMyCalendar(){
	$('#modal_addMyCal').modal('show');	
}// end of function addMyCalendar(){}
	

// === 내 캘린더 추가 모달창에서 추가 버튼 클릭시 === 
function goAddMyCal(){
	
	if($("input.add_my_smcatgoname").val().trim() == ""){
 		  alert("추가할 내캘린더 소분류명을 입력하세요!!");
 		  return;
 	}
	else {
 		  $.ajax({
 			 url: "<%= ctxPath%>/schedule/addMyCalendar.groovy",
 			 type: "post",
 			 data: {"my_smcatgoname": $("input.add_my_smcatgoname").val(), 
 				    "fk_empnum": "${sessionScope.loginuser.pk_empnum}"},
 			 dataType: "json",
 			 success:function(json){
 				 
 				 if(json.n!=1){
 					alert("이미 존재하는 '내캘린더 소분류명' 입니다.");
 					return;
 				 }
 				 else if(json.n==1){
 					 $('#modal_addMyCal').modal('hide'); // 모달창 감추기
 					 alert("내 캘린더에 "+$("input.add_my_smcatgoname").val()+" 소분류명이 추가되었습니다.");
 					 
 					 $("input.add_my_smcatgoname").val("");
 				 	 showmyCal(); // 내 캘린더 소분류 보여주기
 				 }
 			 },
 			 error: function(request, status, error){
  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    	     }	 
 		 });
 	  }
	
}// end of function goAddMyCal(){}

// === 내 캘린더에서 내캘린더 소분류 보여주기  === //
function showmyCal(){
	$.ajax({
		 url:"<%= ctxPath%>/schedule/showMyCalendar.groovy",
		 type:"get",
		 data:{"fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		 dataType:"json",
		 success:function(json){
			 var html = "";

			 if(json.length > 0){
				 html += "<li>";
				 
				 $.each(json, function(index, item){
					 html += "<div>";
					 html += "<p>";
					 html += "<input type='checkbox' name='my_smcatgono' class='calendar_checkbox my_smcatgono' value='"+item.pk_smcatgono+"' checked id='my_smcatgono_"+index+"'/>";
					 html += "<label for='my_smcatgono_"+index+"'></label><span>"+item.smcatgoname+"</span>";
					
					 html += "<button class='btn_edit' data-target='editCal' onclick='editComCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-edit'></i></button></td>";  
					 html += "<button class='btn_edit delCal' onclick='delCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-trash'></i></button></td>";
			
					 html += "</p>";
					 html += "</div>";	 
				});
			 	 
				 html += "</li>";	
			 }
			 $("div.myCalList > ul").append(html);
				 	 
		 },
		 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }	 	
	});

}// end of function showmyCal()

// === 내 캘린더내의 서브캘린더 수정 모달창 나타나기 === 
function editMyCalendar(pk_smcatgono, smcatgoname){
	$('#modal_editMyCal').modal('show');  // 모달 보이기
	$("input.edit_my_smcatgono").val(pk_smcatgono);
	$("input.edit_my_smcatgoname").val(smcatgoname);
}// end of function editMyCalendar(pk_smcatgono, smcatgoname){}
	
// === 내 캘린더내의 서브캘린더 수정 모달창에서 수정 클릭 === 
function goEditMyCal(){
	
	if($("input.edit_my_smcatgoname").val().trim() == ""){
		  alert("수정할 내캘린더 소분류명을 입력하세요!!");
		  return;
	}
  	else{
		 $.ajax({
			url:"<%= ctxPath%>/schedule/editCalendar.groovy",
			type: "post",
			data:{"pk_smcatgono":$("input.edit_my_smcatgono").val(), 
				  "smcatgoname": $("input.edit_my_smcatgoname").val(), 
				  "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
				  "caltype":"1"  // 내캘린더
				  },
			dataType:"json",
			success:function(json){
				if(json.n == 0){
					alert($("input.edit_com_smcatgoname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
   					return;
   				 }
				if(json.n == 1){
					$('#editMyCal').modal('hide'); // 모달 숨기기
					alert("내캘린더명을 수정하였습니다.");
					showmyCal(); 
				}
			},
			 error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
  	  }
	
}// end of function goEditMyCal(){}
	

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//		

// === (사내캘린더 또는 내캘린더)속의 소분류 카테고리 삭제하기 === 
function delCalendar(pk_smcatgono, smcatgoname){ // pk_smcatgono => 캘린더 소분류 번호, smcatgoname => 캘린더 소분류 명
	
	var bool = confirm(smcatgoname + " 캘린더를 삭제 하시겠습니까?");
	
	if(bool){
		$.ajax({
			url:"<%= ctxPath%>/schedule/deleteSubCalendar.groovy",
			type: "post",
			data:{"pk_smcatgono":pk_smcatgono},
			dataType:"json",
			success:function(json){
				if(json.n==1){
					alert(smcatgoname + " 캘린더를 삭제하였습니다.");
					location.href="javascript:history.go(0);"; // 페이지 새로고침
				}
			},
			error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		});
	}
	
}// end of function delCalendar(pk_smcatgono, smcatgoname){}

// === 검색 기능 === //
function goSearch(){

	if( $("#fromDate").val() > $("#toDate").val() ) {
		alert("검색 시작날짜가 검색 종료날짜 보다 크므로 검색할 수 없습니다.");
		return;
	}
    
	if( $("select#searchType").val()=="" && $("input#searchWord").val()!="" ) {
		alert("검색대상 선택을 해주세요!!");
		return;
	}
	
	if( $("select#searchType").val()!="" && $("input#searchWord").val()=="" ) {
		alert("검색어를 입력하세요!!");
		return;
	}
	
   	var frm = document.searchScheduleFrm;
    frm.method="get";
    frm.action="<%= ctxPath%>/schedule/searchSchedule.groovy";
    frm.submit();
	
}// end of function goSearch(){}

</script>




<a href="#" id="sideBtn" class="sideBtn"></a>

<!-- 사이드바 시작 -->

<div class="sideCalList">

	<div  align="center" class="mainlogo">
		<a href="<%=ctxPath%>/index.groovy"><img src="<%= ctxPath%>/resources/images/common/로고그루비.png"  alt="로고"  /></a>
	</div>
	
	<ul>
    	<li>
			<div class="comCalTitle">
				<input type="hidden" value="${sessionScope.loginuser.pk_empnum}" id="fk_empnum"/>
				<span>사내 캘린더</span>
				<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	
	     		<c:if test="${sessionScope.loginuser.fk_pcode =='3' && sessionScope.loginuser.fk_dcode == '4' }"> --%>
	     		<%--<c:if test="${sessionScope.loginuser.gradelevel =='10'}"> --%> 
		 			<button class="btn_edit" onclick="addComCalendar()">
		 				<i class='fas'>&#xf055;</i>
		 			</button>
		 		<%--</c:if>--%> 
			<%--</c:if>	--%> 
				<i class="ico-arrow active fas">&#xf078;</i>
			</div>
			
			<div class="comCalList">
 				<ul>
					<li>
						<div>
							<p>
								<input type="checkbox" checked id="allComCal" class="calendar_checkbox"/><label for="allComCal"></label><span>전체</span>
								
							</p>
						</div>
					</li>
		        </ul>
		    </div>
		</li>
		
		<li>
			<div class="myCalTitle">
				<span>내 캘린더</span>
				<button class="btn_edit" onclick="addMyCalendar()">
					<i class='fas'>&#xf055;</i>
				</button>
				<i class="ico-arrow active fas">&#xf078;</i>
			</div>
			
			<div class="myCalList">
		        <ul>
		            <li>
		                <div>
		                    <p>
		                    	<input type="checkbox" checked id="allMyCal" class="calendar_checkbox"/><label for="allMyCal"></label><span>전체</span>
		                    </p>
		                </div>
		            </li>
		        </ul>
			 </div>
		</li>
		
		<li>
			<div class="shareCalTitle">
				<span>공유받은 캘린더</span>
				<i class="ico-arrow active fas">&#xf078;</i>
			</div>
			
			<div class="shareCalList">
		        <ul>
		            <li>
		                <div>
		                    <p>
		                    	<input type="checkbox" checked id="sharedCal" class="calendar_checkbox" value="0"/><label for="sharedCal"></label><span>전체</span>
		                    </p>
		                </div>
		            </li>
		        </ul>
			 </div>
		</li>
		      
    </ul>	
</div>




























<div>
	
	<!-- <h3>일정 관리</h3> -->





	<div id="wrapper2">
		<div id="searchPart" style="float: left;">
			<form name="searchScheduleFrm">
				<div style=" position: relative; align-items: center;">
				
					<i class="fas fa-search"></i>
					<input type="text" id="searchWord" value="" name="searchWord"/>
					<button type="button" id="option">옵션</button>
					
					<div id="optionList" style="display: inline-block;">
						<input type="text" id="fromDate" name="startdate" readonly="readonly">
	            		<input type="text" id="toDate" name="enddate" readonly="readonly">
						<select id="searchType"name="searchType">
							<option value="">검색선택</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
							<option value="joinuser">공유자</option>
						</select>		
					</div>	
					<!-- 	
					<select id="sizePerPage" name="sizePerPage" style="height: 30px;">
						<option value="">보여줄개수</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
					 -->
					<input type="hidden" name="fk_empnum" value="${sessionScope.loginuser.pk_empnum}"/>
					<!-- <button type="button" class="btn_normal" style="display: inline-block;" onclick="goSearch()">검색</button>  -->
				</div>
			</form>
		</div>			
	    <%-- 풀캘린더가 보여지는 엘리먼트  --%>
		<div id="calendar" style="margin: 50px 0 50px 0;" ></div>
	</div>
		
</div> 



<%-- === 사내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addComCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
      		<!-- Modal header -->
      		<div class="modal-header">
        		<h4 class="modal-title">사내 캘린더 추가</h4>
        		<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      		</div>
      
      		<!-- Modal body -->
      		<div class="modal-body">
       			<form name="modal_frm">
       				<table style="width: 100%;" class="table table-bordered">
		     			<tr>
		     				<td style="text-align: left; ">소분류명</td>
		     				<td><input type="text" class="add_com_smcatgoname"/></td>
		     			</tr>
		     			<tr>
		     				<td style="text-align: left;">만든이</td>
		     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
		     			</tr>
     				</table>
       			</form>	
      		</div>
      
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goAddComCal()">추가</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>
      
		</div>
	</div>
</div>



<%-- === 사내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editComCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
    
			<!-- Modal header -->
			<div class="modal-header">
		  		<h4 class="modal-title">사내 캘린더 수정</h4>
			  	<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
			</div>
      
			<!-- Modal body -->
			<div class="modal-body">
			 	<form name="modal_frm">
			 		<table style="width: 100%;" class="table table-bordered">
						<tr>
							<td style="text-align: left; ">소분류명</td>
							<td><input type="text" class="edit_com_smcatgoname"/><input type="hidden" value="" class="edit_com_smcatgono"></td>
						</tr>
						<tr>
							<td style="text-align: left;">만든이</td>
							<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
						</tr>
					</table>
			 	</form>	
			</div>
      
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditComCal()">수정</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>

    	</div>	
	</div>
</div>
	



<%-- === 내 캘린더 추가 Modal === --%>
<div class="modal fade" id="modal_addMyCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
    	<div class="modal-content">
      
			<!-- Modal header -->
			<div class="modal-header">
				<h4 class="modal-title">내 캘린더 추가</h4>
				<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
			</div>
      
			<!-- Modal body -->
			<div class="modal-body">
			    <form name="modal_frm">
			 		<table style="width: 100%;" class="table table-bordered">
						<tr>
							<td style="text-align: left; ">소분류명</td>
							<td><input type="text" class="add_my_smcatgoname" /></td>
						</tr>
						<tr>
							<td style="text-align: left;">만든이</td>
							<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td> 
						</tr>
					</table>
				</form>
			</div>
      
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="addMy" class="btn btn-success btn-sm" onclick="goAddMyCal()">추가</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>
    	</div>
  	</div>
</div>

<%-- === 내 캘린더 수정 Modal === --%>
<div class="modal fade" id="modal_editMyCal" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
    
			<!-- Modal header -->
			<div class="modal-header">
				<h4 class="modal-title">내 캘린더 수정</h4>
				<button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
			</div>
	      
			<!-- Modal body -->
			<div class="modal-body">
				<form name="modal_frm">
			 		<table style="width: 100%;" class="table table-bordered">
						<tr>
							<td style="text-align: left; ">소분류명</td>
							<td><input type="text" class="edit_my_smcatgoname"/><input type="hidden" value="" class="edit_my_smcatgono"></td>
						</tr>
						<tr>
							<td style="text-align: left;">만든이</td>
							<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.name}</td>
						</tr>
					</table>
			 	</form>
			</div>
      
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goEditMyCal()">수정</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>
      
    	</div>
  	</div>
</div>

<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	

