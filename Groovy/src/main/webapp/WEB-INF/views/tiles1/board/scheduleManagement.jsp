<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- full calendar -->
<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<!-- daterangepicker -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
 
<!-- moment -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script> -->

<!-- kakaomap -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=270d7b5a731a4f55f663e5ed28f2f09b&libraries=services"></script>

<!-- googleicon -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">	
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Sharp" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Two+Tone" rel="stylesheet">

<!-- 개인CSS -->
<link href='<%=ctxPath %>/resources/css/kimyj/kimyj.css' rel='stylesheet' />
<style type="text/css">
</style>

<script type="text/javascript">
var calendar;
var label2;
var options2;
////////////////////////////////////////////////////////////////////////////////////////////////////////////
$(document).ready(function(){
	
//======================== 캘린더 공통 시작 ========================//	
	
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
	//$('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
	
    // To의 초기값을 한달후 날짜로 설정
    $('input#toDate').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
	
	// 모달 창에서 입력된 값 초기화 시키기 //
	$("button.modal_close").on("click", function() {
		var modal_frmArr = document.querySelectorAll("form[name=modal_frm]");
	 	for(var i=0; i<modal_frmArr.length; i++) {
	  		modal_frmArr[i].reset();
	 	}
	});//end of $("button.modal_close").on("click", function()
    
//======================== 캘린더 공통 끝 =========================//	    	
	
	
//======================== 캘린더 사이드 시작 ========================//
	
	// 사내 캘린더에 사내캘린더 소분류 보여주기
	showCompanyCal();

	// 내 캘린더에 내캘린더 소분류 보여주기 
	showmyCal();
	
	// 사내캘린더 체크박스 전체 선택/전체 해제
	$(document).on("click", "input:checkbox[name=allComCal]", function(){
		var bool = $(this).prop("checked");
		$("input:checkbox[name=com_smcatgono]").prop("checked", bool);
	});
	
	// 내캘린더 체크박스 전체 선택/전체 해제
	$(document).on("click", "input:checkbox[name=allMyCal]", function(){
		var bool = $(this).prop("checked");
		$("input:checkbox[name=my_smcatgono]").prop("checked", bool);
	});
	
	// 키보드로 사내 캘린더 추가
	$("input.add_com_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goAddComCal();
		}
	});
	
	// 키보드로 사내 캘린더 수정
	$("input.edit_com_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goEditComCal();
		}
	});
	
	// 키보드로 내 캘린더 추가			
	$("input.add_my_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goAddMyCal();
		}
	});
	
	// 키보드로 내 캘린더 수정
	$("input.edit_my_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goEditMyCal();
		}
	});
	
	// 사내 캘린더 캘린더 active 추가/해제
	$("div.comCalTitle").click(function() {
		$("div.comCalList").toggle();
		$("div.comCalTitle").toggleClass("active");
	});
	
	// 내 캘린더 캘린더 active 추가/해제	
	$("div.myCalTitle").click(function() {
		$("div.myCalList").toggle();
		$("div.myCalTitle").toggleClass("active");
	});
	
	// 공유 캘린더 캘린더 active 추가/해제
	$("div.shareCalTitle").click(function() {
		$("div.shareCalList").toggle();
		$("div.shareCalTitle").toggleClass("active");
	});
		
	// 사내캘린더 에 속한 특정 체크박스를 클릭할 경우
	$(document).on("click", "input:checkbox[name=com_smcatgono]", function() {
	    var bool = $(this).prop("checked");
	   
	    if (bool) { // 체크박스에 클릭한 것이 체크된 것이라면 

	        var flag = false;

	        $("input:checkbox[name=com_smcatgono]").each(function(index, item) {
	            var bChecked = $(item).prop("checked");

	            if (!bChecked) { // 체크되지 않았다면 
	                flag = true; // flag 를 true 로 변경
	                return false; // 반복을 빠져 나옴.
	            }
	        }); // end of $("input:checkbox[name=com_smcatgono]").each(function(index, item){})

	        if (!flag) { // 사내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 			
	            $("input#allComCal").prop("checked", true); // 사내캘린더 체크박스에 체크를 한다.
	        }

	    } else {
	        $("input#allComCal").prop("checked", false);
	    }

	});
	
	
	// 내캘린더 에 속한 특정 체크박스를 클릭할 경우
	$(document).on("click", "input:checkbox[name=my_smcatgono]", function() {
	    var bool = $(this).prop("checked");
		
	    if (bool) { // 체크박스에 클릭한 것이 체크된 것이라면 
	    	
	        var flag = false;

	        $("input:checkbox[name=my_smcatgono]").each(function(index, item) {
	            var bChecked = $(item).prop("checked");

	            if (!bChecked) { // 체크되지 않았다면 
	                flag = true; // flag 를 true 로 변경
	                return false; // 반복을 빠져 나옴.
	            }
	        }); // end of $("input:checkbox[name=my_smcatgono]").each(function(index, item){})

	        if (!flag) { // 내캘린더 에 속한 서브캘린더의 체크박스가 모두 체크가 되어진 경우라면 	
	            $("input#allMyCal").prop("checked", true); // 내캘린더 체크박스에 체크를 한다.
	        }
	    } else {
	        $("input#allMyCal").prop("checked", false);
	    }
	});
	
	//체크박스에 따른 캘린더 보여주기
	$(document).on("change", "input.my_smcatgono", function() {
		var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		calendar.refetchEvents();
		
	});
	
	//체크박스에 따른 캘린더 보여주기
	$(document).on("click", "input.com_smcatgono", function() {
		var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		calendar.refetchEvents();	
	});
	
	//체크박스에 따른 캘린더 보여주기
	$(document).on("click", "input#sharedCal", function() {	
		var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		calendar.refetchEvents();
	});	
 	
  	// 사이드바 토글
	$("a.sideBtn").click(function() {
	    $("div.sideCalList").toggle();
	    $("a.sideBtn").toggleClass("open");
	});
	
			
//======================== 캘린더 사이드 끝 ========================//			

//======================== 메인캘린더 시작 ========================//
	
	var calendarEl = document.getElementById('calendar');
       
	// 메인캘린더 
	calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    locale: 'ko',
	    selectable: true,
	    editable: false,
	    googleCalendarApiKey: 'AIzaSyDCwjlUWOcjVeJz1pk-cvkVovrZfz-kQQc',
	    headerToolbar: {
	        left: 'prev next',
	        //center: 'title', dayGridMonth dayGridWeek dayGridDay 'prev next'
	        right: 'today'
	    },
	    dayMaxEventRows: true, // for all non-TimeGrid views
	    views: {
	        timeGrid: {
	            dayMaxEventRows: 6 // adjust to 6 only for timeGridWeek/timeGridDay\
	        }
	    },
	    eventSources: [{
	            googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
	            className: 'koHolidays',
	            color: '#ED1A3D', 
	            textColor: '#FFF',
	            id: 'koHolidays'
	        }

	    ],
	    eventClick: function(event, jsEvent, view, info) {
	        var check = /[a-zA-Z]/gi;
	        if (event.event.id.match(check) != null) {
	            event.jsEvent.cancelBubble = true;
	            event.jsEvent.preventDefault();
	        }

	    },

	    // ===================== DB 와 연동하는 법 시작 ===================== //
	    events: function(info, successCallback, failureCallback) {

	        $.ajax({
	            url: '<%= ctxPath%>/selectSchedule.groovy',
	            data: {"fk_empnum": $('input#fk_empnum').val()},
	            dataType: "json",
	            success: function(json) {
	                var events = [];
	                if (json.length > 0) {

	                    $.each(json, function(index, item) {
	                        var startdate = moment(item.startdate).format('YYYY-MM-DD HH:mm:ss');
	                        var enddate = moment(item.enddate).format('YYYY-MM-DD HH:mm:ss');
	                        var subject = item.subject;

	                        // 사내 캘린더로 등록된 일정을 풀캘린더 달력에 보여주기 
	                        // 일정등록시 사내 캘린더에서 선택한 소분류에 등록된 일정을 풀캘린더 달력 날짜에 나타내어지게 한다.
	                        if ($("input:checkbox[name=com_smcatgono]:checked").length <= $("input:checkbox[name=com_smcatgono]").length) {

	                            for (var i = 0; i < $("input:checkbox[name=com_smcatgono]:checked").length; i++) {
	                                //console.log("사내" + item.fk_smcatgono);
	                                if ($("input:checkbox[name=com_smcatgono]:checked").eq(i).val() == item.fk_smcatgono) {
	                                    //  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=com_smcatgono]:checked").eq(i).val());
	                                    events.push({
	                                        id: item.pk_scheduleno,
	                                        title: item.subject,
	                                        start: startdate,
	                                        end: enddate,
	                                        url: "javascript:detailSchedule(" + item.pk_scheduleno + ")",
	                                        color: item.color,
	                                        cid: item.fk_smcatgono // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
	                                    }); // end of events.push({})
	                                }

	                            } // end of for

	                        } // end of if

	                        // 내 캘린더로 등록된 일정을 풀캘린더 달력에 보여주기
	                        // 일정등록시 내 캘린더에서 선택한 소분류에 등록된 일정을 풀캘린더 달력 날짜에 나타내어지게 한다.
	                        if ($("input:checkbox[name=my_smcatgono]:checked").length <= $("input:checkbox[name=my_smcatgono]").length) {

	                            for (var i = 0; i < $("input:checkbox[name=my_smcatgono]:checked").length; i++) {

	                                if ($("input:checkbox[name=my_smcatgono]:checked").eq(i).val() == item.fk_smcatgono && item.fk_empnum == "${sessionScope.loginuser.pk_empnum}") {
	                                    //  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=my_smcatgono]:checked").eq(i).val());
	                                    events.push({
	                                        id: item.pk_scheduleno,
	                                        title: item.subject,
	                                        start: startdate,
	                                        end: enddate,
	                                        url: "javascript:detailSchedule(" + item.pk_scheduleno + ")",
	                                        color: item.color,
	                                        cid: item.fk_smcatgono // 내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 

	                                    }); // end of events.push({})

	                                }
	                            } // end of for

	                        } // end of if

	                        // 공유받은 캘린더(다른 사용자가 내캘린더로 만든 것을 공유받은 경우임)
	                        if (item.fk_lgcatgono == 1 && item.fk_empnum != "${sessionScope.loginuser.pk_empnum}" && (item.joinuser).indexOf("${sessionScope.loginuser.pk_empnum}") != -1) {

	                            events.push({
	                                id: "0", // "0" 인 이유는  배열 events 에 push 할때 id는 고유해야 하는데 위의 사내캘린더 및 내캘린더에서 push 할때 id값으로 item.scheduleno 을 사용하였다. item.scheduleno 값은 DB에서 1 부터 시작하는 시퀀스로 사용된 값이므로 0 값은 위의 사내캘린더나 내캘린더에서 사용되지 않으므로 여기서 고유한 값을 사용하기 위해 0 값을 준 것이다. 
	                                title: item.subject,
	                                start: startdate,
	                                end: enddate,
	                                url: "javascript:detailSchedule(" + item.pk_scheduleno + ")",
	                                color: item.color,
	                                cid: "0" // "0" 인 이유는  공유받은캘린더 에서의 체크박스의 value 를 "0" 으로 주었기 때문이다.
	                            }); // end of events.push({})

	                        } // end of if

	                    }); // end of $.each(json, function(index, item) {})
	                }
                
	                // successCallback(events);  

					// 휴가리스트 추가
	                $.ajax({
	                    url: '<%= ctxPath%>/selectVacationlist.groovy',
	                    dataType: "json",
	                    success: function(json) {
	                        //var events = [];
	                        if (json.length > 0) {

	                            $.each(json, function(index, item) {
	                                var startdate = moment(item.vstartdate).format('YYYY-MM-DD HH:mm:ss');
	                                var enddate = moment(item.venddate).format('YYYY-MM-DD HH:mm:ss');
	                                var subject = item.vinfo;
	                               
	                                events.push({
	                                    id: item.pk_documentnum,
	                                    title: '[' + item.deptnamekor + ' : ' + item.spotnamekor + '] ' + item.name + ': ' + item.vtype,
	                                    start: startdate,
	                                    end: enddate,
	                                    color: '#49BEA8'
	                                }); // end of events.push({})

	                            });
	                        }
	                        //console.log(events);
	                        successCallback(events);
	                    },
	                    error: function(request, status, error) {
	                        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	                    }

	                }); // end of $.ajax()

	            },
	            error: function(request, status, error) {
	                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	            }

	        }); // end of $.ajax()

	    }, // end of events:function(info, successCallback, failureCallback) {}

	    // ===================== DB 와 연동하는 법 끝 ===================== //

	    // 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
	    dateClick: function(info) {
	    	
	        $('form.scheduleFrm').each(function() {
	            this.reset();
	        });
	        
	        $("li.mapLi").hide();
	        $("select.small_category").empty();
	        $("select.small_category").hide();
	        $("input.subject").css('color', '');
	        $("div.displayUserList").empty();

	        const endDay = info.dateStr + " 23:59";
	        $('input.selectDay').data('daterangepicker').setStartDate(info.dateStr);
	        $('input.selectDay').data('daterangepicker').setEndDate(endDay);

	        $('#modal_addSchedule').modal('show');
	    },

	    // 사내캘린더, 내캘린더, 공유받은캘린더의 체크박스에 체크유무에 따라 일정을 보여주거나 일정을 숨기게 하는 것이다.
	    eventDidMount: function(arg) {
	        var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox");
	        // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스임

	        arr_calendar_checkbox.forEach(function(item) { // item 이 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스 중 하나인 체크박스임
	            if (item.checked) {
	                //console.log("체크박스:" + item.value);
	                // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 한 경우 라면
	                //console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
	                //console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);
	                if (arg.event.extendedProps.cid === item.value) { // item.value 가 체크박스의 value 값이다.
	                    // console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
	                    // console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);

	                    arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
	                }
	            } else {
	                // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 해제한 경우 라면
	                if (arg.event.extendedProps.cid === item.value) {
	                    // console.log("일정을 숨기는 cid : "  + arg.event.extendedProps.cid);
	                    // console.log("일정을 숨기는 체크박스의 value값(item.value) : " + item.value);

	                    arg.el.style.display = "none"; // 풀캘린더에서 일정을  숨긴다.
	                }
	            }
	        }); // end of arr_calendar_checkbox.forEach(function(item) {})
	    }
	});
    
	calendar.render();  // 풀캘린더 보여주기
	
  	// 월주일 select 생성
	$(".fc-today-button").before("<div class='month-week-day'></div>");
	buildMWD();

	const mwdBtn = document.querySelector('.mwdBtn');
	const mwd = document.querySelectorAll('.mwd');
	
	// 클릭한 옵션의 텍스트를 라벨 안에 넣음
	const handleSelect2 = function(item) {
	    mwdBtn.innerHTML = item.textContent;
	    mwdBtn.parentNode.classList.remove('active');
	}
	
	// 옵션 클릭시 클릭한 옵션을 넘김
	mwd.forEach(function(mwd) {
	    mwd.addEventListener('click', function() {
	        handleSelect2(mwd)
	    })
	});
	
	// 라벨을 클릭시 옵션 목록이 열림/닫힘
	mwdBtn.addEventListener('click', function() {
	    if (mwdBtn.parentNode.classList.contains('active')) {
	        mwdBtn.parentNode.classList.remove('active');
	    } else {
	        mwdBtn.parentNode.classList.add('active');
	    }
	});
	
	$("li.mwd").click(function() {
	    const mwdChoice = $(this).text();
	    if (mwdChoice == "월") {
	        calendar.changeView('dayGridMonth');
	    } else if (mwdChoice == "주") {
	        calendar.changeView('dayGridWeek');
	    } else {
	        calendar.changeView('dayGridDay');
	        /*
	        calendar.changeView('list', {
	        	  start: '2022-05-01',
	        	  end: '2022-06-05',
	              title: '바보'
	        	});
	        */
	    }
	});
	
	$("div#optionList").hide();
	
	// 검색옵션 토글
	$("button#option").click(function() {
	    $("div#optionList").toggle();
	}); 
	
	// 검색아이콘 클릭
	$("i.fa-search").click(function() {
	    goSearch();
	});
	
	// 검색 할 때 엔터를 친 경우
	$("input#searchWord").keyup(function(event) {
		if(event.keyCode == 13){ 
	 		goSearch();
		}
	});
	
//======================== 메인캘린더 끝 ========================//			
	
//======================== 캘린더 등록 시작 ========================//	
	$("li.mapLi").hide();
	
	// 캘린더 소분류 카테고리 숨기기
	$("select.small_category").hide();
	
	// 파일input 길이 자동 조절
	$("input#filename").on('change', function(e){
		 var textObj = document.getElementById('filename');
		 
		 var resize = textObj.value.length;
		 if(Number(resize)>25 && Number(resize)<50){
			 resize = resize*5;
		 }else if(Number(resize)>50){
			 resize = resize*7;
		 }else if(Number(resize)==0){
			 resize = 69;
		 }else{
			 resize = resize*3;
		 }
		 $("input.upload-name").css('width',resize); 
	});
	
	// 투표기능 val()추가
	$(document).on("click", "input:checkbox[name=vote]", function(){
		var bool = $(this).prop("checked");
		if(bool){
			$(this).val("1");
			$("div.vote-group label").html('<span class="material-icons-outlined">check_circle</span>');
		}else{
			$(this).val("0");
			$("div.vote-group label").html('<span class="material-icons-outlined">radio_button_unchecked</span>');
		}	
	});
	
	// 지도검색
	$("input.place").keyup(function(event) {
	    if (event.keyCode == 13) {
	        var keyword = $("input#place").val();
	        searchPlaces(keyword);
	    }
	});

	//파일 업로드 
	$("input.upload-file").on('change', function() {
	    if (window.FileReader) {

	        if ($(this).val() == '' || $(this).val() == null) {
	            $("input.upload-name").val("파일선택");
	            return;
	        } else {
	            var filename = $(this)[0].files[0].name;
	        }

	    } else {
	        var filename = $(this).val().split('/').pop().split('\\').pop();
	    }
	    $(this).siblings('input.upload-name').val(filename);
	});

	// 캘린더 등록 날짜
	$("input.selectDay").daterangepicker({
	    locale: {
	        "separator": " ~ ", // 시작일시와 종료일시 구분자
	        "format": 'YYYY-MM-DD HH:mm', // 일시 노출 포맷
	        "applyLabel": "확인", // 확인 버튼 텍스트
	        "cancelLabel": "취소", // 취소 버튼 텍스트
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    },
	    timePicker: true, // 시간 노출 여부
	    showDropdowns: true, // 년월 수동 설정 여부
	    autoApply: true, // 확인/취소 버튼 사용여부
	    timePicker24Hour: false, // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    timePickerSeconds: false, // 초 노출 여부
	    singleDatePicker: false // 하나의 달력 사용 여부
	});

	// 캘린더 등록 날짜 CSS
	$("input.selectDay").on('show.daterangepicker', function(ev, picker) {
	    $(".yearselect").css("float", "left");
	    $(".monthselect").css("float", "right");
	    $(".cancelBtn").css({
	        'background-color': '#ff4444',
	        'color': '#fff',
	        'float': 'right',
	        'border': 'none'
	    });
	    $(".applyBtn").css({
	        'background-color': '#6449fc',
	        'border': 'none'
	    });
	});
	
	// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
	$("select.calType").change(function(){
		var fk_lgcatgono = $("select.calType").val();// 내캘린더이라면 1, 사내캘린더이라면 2 이다.
		if(fk_lgcatgono == 2){
		   	$("input#joinUserName").prop('readonly', true);
		   	$("input#joinUserName").attr("placeholder", "사내 캘린더는 공유자가 필요없습니다.");
		}else{
			$("input#joinUserName").prop('readonly', false);
			$("input#joinUserName").attr("placeholder", "일정을 공유할 회원명/사원번호를 입력하세요.");
		}
		selectCalType(fk_lgcatgono);
	});
	
	// 공유자 추가하기
	$("input#joinUserName").bind("keyup", function() {
	    var joinUserName = $(this).val();
	    //console.log("확인용 joinUserName : " + joinUserName);
	    $.ajax({
	        url: "<%= ctxPath%>/searchJoinUserList.groovy",
	        data: {
	            "joinUserName": joinUserName
	        },
	        dataType: "json",
	        async: false,
	        success: function(json) {
	            var joinUserArr = [];
	            if (json.length > 0) {

	                $.each(json, function(index, item) {
	                    var name = item.name;

	                    var pk_empnum = item.pk_empnum;
	                    if (name.includes(joinUserName) || pk_empnum.includes(joinUserName)) { // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
	                        // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
	                        joinUserArr.push(name + "(" + item.pk_empnum + ")");
	                    }

	                });

	                $("input.joinUserName").autocomplete({ // 참조 https://jqueryui.com/autocomplete/#default
	                    source: joinUserArr,
	                    select: function(event, ui) { // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
	                        //console.log("##" + ui.item.value)
	                        add_joinUser(ui.item.value); // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
	                        // ui.item.value 이  선택한이름 이다.
	                        return false;
	                    },
	                    focus: function(event, ui) {
	                        return false;
	                    }
	                });

	            } // end of if------------------------------------
	        } // end of success-----------------------------------
	    });
	});
	
	// x아이콘 클릭시 공유자 제거하기
	$(document).on('click', 'div.displayUserList > span.plusUser > i', function() {
	    var text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)

	    var bool = confirm("공유자 목록에서 " + text + " 회원을 삭제하시겠습니까?");
	    // 공유자 목록에서 이순신(leess/leesunsin@naver.com) 회원을 삭제하시겠습니까?

	    if (bool) {
	        $(this).parent().remove();
	    }
	});

	// 등록 버튼 클릭
	$(document).on('click', 'button#register', function() {
	    const day = $("input.selectDay").val();

	    var [startDate, endDate] = day.split(' ~ ');
	   	//console.log(startDate);
	    //console.log(endDate);

	    // 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
	    var sArr = startDate.split("-");
	    startDate = "";
	    for (var i = 0; i < sArr.length; i++) {
	        startDate += sArr[i];
	    }
	    var sArr = startDate.split(":");
	    startDate = "";
	    for (var i = 0; i < sArr.length; i++) {
	        startDate += sArr[i];
	    }

	    startDate = startDate.replace(/\s/gi, "");
	    //console.log(startDate);
	    var eArr = endDate.split("-");
	    var endDate = "";
	    for (var i = 0; i < eArr.length; i++) {
	        endDate += eArr[i];
	    }
	    var eArr = endDate.split(":");
	    endDate = "";
	    for (var i = 0; i < eArr.length; i++) {
	        endDate += eArr[i];
	    }
	    endDate = endDate.replace(/\s/gi, "");
	    
	    // 조회기간 시작일자가 종료일자 보다 크면 경고
	    if (Number(endDate) - Number(startDate) < 0) {
	        alert("종료일이 시작일 보다 작습니다.");
	        return;
	    }
	    
	    // 제목 유효성 검사
	    var subject = $("input#subject").val().trim();
	    if (subject == "") {
	        alert("제목을 입력하세요.");
	        return;
	    }

	    // 캘린더 선택 유무 검사
	    var calType = $("select.calType").val().trim();
	    if (calType == "") {
	        alert("캘린더 종류를 선택하세요.");
	        return;
	    }
	    
	 	// 내용 유무 검사
	    var content = $("textarea#content").val().trim();
	    if (content == "") {
	        alert("내용을 입력하세요. ");
	        return;
	    }

	    // 달력 형태로 만들어야 한다.(시작일과 종료일)
	    // 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
	    var sdate = startDate + "00";
	    var edate = endDate + "00";

	    $("input[name=startdate]").val(sdate);
	    $("input[name=enddate]").val(edate);

	    // 공유자 넣어주기
	    var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
	    var joinUserArr = new Array();

	    plusUser_elm.forEach(function(item, index, array) {
	        //console.log(item.innerText.trim());
	        joinUserArr.push(item.innerText.trim());
	    });

	    var joinuser = joinUserArr.join(", ");
	   
	    $("input[name=joinuser]").val(joinuser);

	    if ($("input[name=attach]").val() == "") {// 첨부파일이 없는 댓글쓰기인 경우
	        //alert("파일없음");
	        goAddSchedule_noAttach();

	    } else { // 첨부파일이 있는 댓글쓰기인 경우 
	        //alert("파일있음");
	        goAddSchedule_withAttach();
	    }

	});	
	
	// 색상 변경시 제목색상 변경
	$("input[name=color]").change(function() {
	    $("input.subject").css('color', $(this).val());
	});
	    
//======================== 캘린더 등록 끝 ========================//		  


//======================== 캘린더 상세보기 시작 ========================//	

	$("div.showSchedule").hide();
	
	//나가기 버튼 클릭시 데이터 초기화
	$(document).on("click", "div.card-header button.close", function() {
	    $("div.showSchedule").empty();
	    $("div.showSchedule").hide();
	});
	
	// 동의 투표 명단 공개
	$(document).on("click", "span.yesCnt", function() {
	    $("ul.vote-yes-ul").toggle('slow');
	});
	
	// 비동의투표 명단 공개
	$(document).on("click", "span.noCnt", function() {
	    $("ul.vote-no-ul").toggle('slow');
	});
	
	// 모름 투표 명단 공개
	$(document).on("click", "span.undefinedCnt", function() {
	    $("ul.vote-undefined-ul").toggle('slow');
	});
	
	// 댓글 등록
	$(document).on('keyup', 'form.comment-writer-container input.comment-writer-text', function(event) {
	    if (event.keyCode == 13) {
	        const fk_scheduleno = $("input.schedulenoShave").val();
	        commentAdd(fk_scheduleno);
	    }
	});
	
//======================== 캘린더 상세보기 끝 ========================//		 
	
//======================== 캘린더 수정 시작 ========================//	
	
	$(document).on('click', "button#editSchedule", function() {
	
	    const day = $("input.selectDay").val();
	
	    var [startDate, endDate] = day.split(' ~ ');
	    //console.log(startDate);
	    //console.log(endDate);
	
	    // 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
	    var sArr = startDate.split("-");
	    startDate = "";
	    for (var i = 0; i < sArr.length; i++) {
	        startDate += sArr[i];
	    }
	    var sArr = startDate.split(":");
	    startDate = "";
	    for (var i = 0; i < sArr.length; i++) {
	        startDate += sArr[i];
	    }
	
	    startDate = startDate.replace(/\s/gi, "");
	    //console.log(startDate);
	    var eArr = endDate.split("-");
	    var endDate = "";
	    for (var i = 0; i < eArr.length; i++) {
	        endDate += eArr[i];
	    }
	    var eArr = endDate.split(":");
	    endDate = "";
	    for (var i = 0; i < eArr.length; i++) {
	        endDate += eArr[i];
	    }
	    endDate = endDate.replace(/\s/gi, "");
	    //console.log(endDate);
	 
	    // 조회기간 시작일자가 종료일자 보다 크면 경고
	    if (Number(endDate) - Number(startDate) < 0) {
	        alert("종료일이 시작일 보다 작습니다.");
	        return;
	    }
	    
	    // 제목 유효성 검사
	    var subject = $("input#subject").val().trim();
	    if (subject == "") {
	        alert("제목을 입력하세요.");
	        return;
	    }
	
	    // 캘린더 선택 유무 검사
	    var calType = $("select.calType").val().trim();
	    if (calType == "") {
	        alert("캘린더 종류를 선택하세요.");
	        return;
	    }
	
	    // 내용 유무 검사
	    var content = $("textarea#content").val().trim();
	    if (content == "") {
	        alert("내용을 입력하세요. ");
	        return;
	    }
	
	    // 달력 형태로 만들어야 한다.(시작일과 종료일)
	    // 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
	    var sdate = startDate + "00";
	    var edate = endDate + "00";
	
	    $("input[name=startdate]").val(sdate);
	    $("input[name=enddate]").val(edate);
	
	    // 공유자 넣어주기
	    var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
	    var joinUserArr = new Array();
	
	    plusUser_elm.forEach(function(item, index, array) {
	        //	console.log(item.innerText.trim());
	        joinUserArr.push(item.innerText.trim());
	    });
	
	    var joinuser = joinUserArr.join(", ");
	    //console.log("공유자 => " + joinuser);
	  
	    $("input[name=joinuser]").val(joinuser);
	
	    if ($("input[name=attach]").val() == "") { // 첨부파일이 없는 댓글쓰기인 경우
	        //alert("파일없음");
	        goEditSchedule_noAttach();
	
	    } else { // 첨부파일이 있는 댓글쓰기인 경우 
	        // alert("파일있음");
	        goEditSchedule_withAttach();
	    }
	
	}); // end of $("button#register").click(function(){})--------------------
		
//======================== 캘린더 수정 끝 ========================//		

	
//======================== 미완성 시작 ========================//			
	/* 		
	//==== 달력에 '일' 제거 ==== //		
	$('a.fc-daygrid-day-number').each(function(index) {
		const day = $(this).text().replace("일","");
		$(this).text(day);
	});
	*/
	
	// 년도월 select 생성 시작
	
	$(".fc-prev-button").after("<div class='fc-title'></div>");
		//<button class='monthsBtn'>56</button>	
		//<ul class='monthsList'></ul>
	
 	buildMonthList();
 	
 	const label = document.querySelector('.monthsBtn');
	const options = document.querySelectorAll('.months');
	var saveDay = calendar.getDate();	
 	
	$(document).on('click',"li.months", function() {
		
		calendar.gotoDate($(this).children().val());
	});

	//buildMonthList(); 
	// 클릭한 옵션의 텍스트를 라벨 안에 넣음
	const handleSelect = function(item) {
		label.innerHTML = item.textContent;	 
		label.parentNode.classList.remove('active');
		//buildMonthList();
	}
 	
	// 옵션 클릭시 클릭한 옵션을 넘김
	
	options.forEach(function(option) {
	 // calendar.gotoDate(options.children().val());
	  option.addEventListener('click', function(){handleSelect(option)});
	  //buildMonthList();
	});
	 	
	// 라벨을 클릭시 옵션 목록이 열림/닫힘
	label.addEventListener('click', function() {
	  if(label.parentNode.classList.contains('active')) {
	    label.parentNode.classList.remove('active');
	  } else {
	    label.parentNode.classList.add('active');
	  }
	});
	
	$("button.fc-prev-button").click(function() {
		var showDay;
		saveDay = moment(saveDay).add(-1, "month").format("YYYY-MM");
		showDay = moment(saveDay).format("YYYY년 MM월");
		label.innerHTML = showDay;
	});
	
	$("button.fc-next-button").click(function() {
		saveDay = moment(saveDay).add(+1, "month").format("YYYY-MM");
		showDay = moment(saveDay).format("YYYY년 MM월");
		label.innerHTML = showDay;
	});
		
	// 년도월 select 생성 끝

//======================== 미완성 끝 ========================//	
		
}); // end of $(document).ready(function(){})
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//======================== 캘린더 사이드 시작 ========================//

// 사내 캘린더 소분류 추가를 위해 +아이콘 클릭시
function addComCalendar() {
    $("input.add_com_smcatgoname").val("");
    $('#modal_addComCal').modal('show'); // 모달창 보여주기	
} // end of function addComCalendar(){}

// 사내 캘린더 추가 모달창에서 추가 버튼 클릭시
function goAddComCal() {
    if ($("input.add_com_smcatgoname").val().trim() == "") {
        alert("추가할 사내캘린더 소분류명을 입력하세요!!");
        return;
    } else {
        $.ajax({
            url: "<%= ctxPath%>/addComCalendar.groovy",
            type: "post",
            data: {
                "com_smcatgoname": $("input.add_com_smcatgoname").val(),
                "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
            },
            dataType: "json",
            success: function(json) {
                if (json.n != 1) {
                    alert("이미 존재하는 '사내캘린더 소분류명' 입니다.");
                    return;
                } else if (json.n == 1) {
                    $('#modal_addComCal').modal('hide'); // 모달창 감추기				
                    alert("사내 캘린더에 " + $("input.add_com_smcatgoname").val() + " 소분류명이 추가되었습니다.");

                    $("input.add_com_smcatgoname").val("");
                    showCompanyCal(); // 사내 캘린더 소분류 보여주기
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }

} // end of function goAddComCal(){}


// 사내 캘린더에서 사내캘린더 소분류  보여주기 
function showCompanyCal() {
    $.ajax({
            url: "<%= ctxPath%>/showCompanyCalendar.groovy",
            type: "get",
            dataType: "json",
            success: function(json) {
                var html = "";
                if (json.length > 0) {
                    html += "<li>";

                    html += "<div>";
                    html += "<p>";
                    html += '<input type="checkbox" checked id="allComCal" name="allComCal" class="calendar_checkbox com_smcatgono"/><label for="allComCal"></label><span>전체</span>';
                    html += "</p>";
                    html += "</div>";

                    $.each(json, function(index, item) {
                            html += "<li>";

                            html += "<div>";
                            html += "<p>";
                            html += "<input type='checkbox' name='com_smcatgono' class='calendar_checkbox com_smcatgono' value='" + item.pk_smcatgono + "' checked id='com_smcatgono_" + index + "'/>";
                            html += "<label for='com_smcatgono_" + index + "'></label><span>" + item.smcatgoname + "</span>";

                            if('${sessionScope.loginuser.fk_spotnum}' == 0 || '${sessionScope.loginuser.fk_spotnum}' >= 7){
                            	  html += "<button class='btn_edit' data-target='editCal' onclick='editComCalendar(" + item.pk_smcatgono + ",\"" + item.smcatgoname + "\")'><i class='fas'><span class='material-icons-outlined'> edit_calendar </span></i></button></td>";
                                  html += "<button class='btn_edit delCal' onclick='delCalendar(" + item.pk_smcatgono + ",\"" + item.smcatgoname + "\")'><i class='fas'><span class='material-icons-outlined'> event_busy </span></i></button></td>";  
                            }
                                  
                                html += "</p>";
                                html += "</div>";
                                html += "</li>";
                            });

                    }
                    $("div.comCalList > ul").html(html);
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });

    } // end of function showCompanyCal()

    // 사내 캘린더내의 서브캘린더 수정 모달창 나타나기
    function editComCalendar(pk_smcatgono, smcatgoname) {
        $('#modal_editComCal').modal('show'); // 모달 보이기
        $("input.edit_com_smcatgono").val(pk_smcatgono);
        $("input.edit_com_smcatgoname").val(smcatgoname);
    } // end of function editComCalendar(pk_smcatgono, smcatgoname){}

    // 사내 캘린더내의 서브캘린더 수정 모달창에서 수정하기 클릭
    function goEditComCal() {

        if ($("input.edit_com_smcatgoname").val().trim() == "") {
            alert("수정할 사내캘린더 소분류명을 입력하세요!!");
            return;
        } else {
            $.ajax({
            
                url: "<%= ctxPath%>/editCalendar.groovy",
                type: "post",
                data: {
                    "pk_smcatgono": $("input.edit_com_smcatgono").val(),
                    "smcatgoname": $("input.edit_com_smcatgoname").val(),
                    "fk_empnum": "${sessionScope.loginuser.pk_empnum}",
                    "caltype": "2" // 사내캘린더
                },
                dataType: "json",
                success: function(json) {
                    if (json.n == 0) {
                        alert($("input.edit_com_smcatgoname").val() + "은(는) 이미 존재하는 캘린더 명입니다.");
                        return;
                    }
                    if (json.n == 1) {
                        $('#modal_editComCal').modal('hide'); // 모달 숨기기
                        alert("사내 캘린더명을 수정하였습니다.");
                        showCompanyCal();
                    }
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

    } // end of function goEditComCal(){}

    // 내 캘린더 소분류 추가를 위해 +아이콘 클릭시 
    function addMyCalendar() {
        $("input.add_my_smcatgoname").val("");
        $('#modal_addMyCal').modal('show');
    } // end of function addMyCalendar(){}


    // 내 캘린더 추가 모달창에서 추가 버튼 클릭시
    function goAddMyCal() {

        if ($("input.add_my_smcatgoname").val().trim() == "") {
            alert("추가할 내캘린더 소분류명을 입력하세요!!");
            return;
        } else {
            $.ajax({
                url: "<%= ctxPath%>/addMyCalendar.groovy",
                type: "post",
                data: {
                    "my_smcatgoname": $("input.add_my_smcatgoname").val(),
                    "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
                },
                dataType: "json",
                success: function(json) {
                    if (json.n != 1) {
                        alert("이미 존재하는 '내캘린더 소분류명' 입니다.");
                        return;
                    } else if (json.n == 1) {
                        $('#modal_addMyCal').modal('hide'); // 모달창 감추기
                        alert("내 캘린더에 " + $("input.add_my_smcatgoname").val() + " 소분류명이 추가되었습니다.");

                        $("input.add_my_smcatgoname").val("");
                        showmyCal(); // 내 캘린더 소분류 보여주기
                    }
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

    } // end of function goAddMyCal(){}

    // 내 캘린더에서 내캘린더 소분류 보여주기
    function showmyCal() {
        $.ajax({
            url: "<%= ctxPath%>/showMyCalendar.groovy",
            type: "get",
            data: {
                "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
            },
            dataType: "json",
            success: function(json) {
                var html = "";

                if (json.length > 0) {
                    html += "<li>";
                    html += "<div>";
                    html += "<p>";
                    html += '<input type="checkbox" checked id="allMyCal" name="allMyCal" class="calendar_checkbox my_smcatgono"/><label for="allMyCal"></label><span>전체</span>';
                    html += "</p>";
                    html += "</div>";
                    html += "</li>";
                    $.each(json, function(index, item) {
                        html += "<li>";
                        html += "<div>";
                        html += "<p>";
                        html += "<input type='checkbox' name='my_smcatgono' class='calendar_checkbox my_smcatgono' value='" + item.pk_smcatgono + "' checked id='my_smcatgono_" + index + "'/>";
                        html += "<label for='my_smcatgono_" + index + "'></label><span>" + item.smcatgoname + "</span>";

                        html += "<button class='btn_edit' data-target='editCal' onclick='editMyCalendar(" + item.pk_smcatgono + ",\"" + item.smcatgoname + "\")'><i class='fas'><span class='material-icons-outlined'> edit_calendar </span></i></button></td>";
                        html += "<button class='btn_edit delCal' onclick='delCalendar(" + item.pk_smcatgono + ",\"" + item.smcatgoname + "\")'><i class='fas'><span class='material-icons-outlined'> event_busy </span></i></button></td>";

                        html += "</p>";
                        html += "</div>";
                        html += "</li>";
                    });


                }
                $("div.myCalList > ul").html(html);

            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    } // end of function showmyCal()

    // 내 캘린더내의 서브캘린더 수정 모달창 나타나기
    function editMyCalendar(pk_smcatgono, smcatgoname) {
        $('#modal_editMyCal').modal('show'); // 모달 보이기
        $("input.edit_my_smcatgono").val(pk_smcatgono);
        $("input.edit_my_smcatgoname").val(smcatgoname);
    } // end of function editMyCalendar(pk_smcatgono, smcatgoname){}

    // 내 캘린더내의 서브캘린더 수정 모달창에서 수정 클릭
    function goEditMyCal() {

        if ($("input.edit_my_smcatgoname").val().trim() == "") {
            alert("수정할 내캘린더 소분류명을 입력하세요!!");
            return;
        } else {
            $.ajax({
                url: "<%= ctxPath%>/editCalendar.groovy",
                type: "post",
                data: {
                    "pk_smcatgono": $("input.edit_my_smcatgono").val(),
                    "smcatgoname": $("input.edit_my_smcatgoname").val(),
                    "fk_empnum": "${sessionScope.loginuser.pk_empnum}",
                    "caltype": "1" // 내캘린더
                },
                dataType: "json",
                success: function(json) {
                    if (json.n == 0) {
                        alert($("input.edit_com_smcatgoname").val() + "은(는) 이미 존재하는 캘린더 명입니다.");
                        return;
                    }
                    if (json.n == 1) {
                        $('#modal_editMyCal').modal('hide'); // 모달 숨기기

                        alert("내캘린더명을 수정하였습니다.");
                        showmyCal();
                    }
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

    } // end of function goEditMyCal(){}

 	//(사내캘린더 또는 내캘린더)속의 소분류 카테고리 삭제하기
    function delCalendar(pk_smcatgono, smcatgoname) { // pk_smcatgono => 캘린더 소분류 번호, smcatgoname => 캘린더 소분류 명

        var bool = confirm(smcatgoname + " 캘린더를 삭제 하시겠습니까?");

        if (bool) {
            $.ajax({
                url: "<%= ctxPath%>/deleteSubCalendar.groovy",
                type: "post",
                data: {
                    "pk_smcatgono": pk_smcatgono
                },
                dataType: "json",
                success: function(json) {
                    if (json.n == 1) {
                        alert(smcatgoname + " 캘린더를 삭제하였습니다.");
                        location.href = "javascript:history.go(0);"; // 페이지 새로고침
                    }
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }

    } //end of function delCalendar(pk_smcatgono, smcatgoname){}
    
    

//======================== 캘린더 사이드 끝 ========================//	

//======================== 메인캘린더 시작 ========================//

// 월주일 버튼 
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
	
}//end of function buildMWD()

//======================== 메인캘린더 끝 ========================//	

//======================== 캘린더 등록 시작 ========================//

// 지도검색
function searchPlaces(keyword) {

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    $("li.mapLi").show();
    
    // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
    var infowindow = new kakao.maps.InfoWindow({
        zIndex: 1
    });

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption);
    var imageSrc = '<%=ctxPath %>/resources/images/kimyj/map-mark.png', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(36, 36), // 마커이미지의 크기입니다
        imageOption = {
            offset: new kakao.maps.Point(18, 36)
        }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

    //마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 키워드로 장소를 검색합니다
    ps.keywordSearch(keyword, placesSearchCB);

    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();

            for (var i = 0; i < data.length; i++) {
                displayMarker(data[i]);
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            }

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            //alert('검색 결과가 존재하지 않습니다.');
            //return;
           
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(keyword, placesSearchCB2);

            function placesSearchCB2(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                    // LatLngBounds 객체에 좌표를 추가합니다
                    var bounds = new kakao.maps.LatLngBounds();

                    for (var i = 0; i < data.length; i++) {
                        displayMarker(data[i]);
                        bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                    }

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                    map.setBounds(bounds);
                }
            }

        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
            return;
        }
    }

    // 지도에 마커를 표시하는 함수입니다
    function displayMarker(place) {

        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x),
            image: markerImage
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            if (!place.place_name) {
                infowindow.setContent('<div style=" white-space:normal;  text-align:center;padding:6px; border: 1px solid #6449fc; color: #555;">' + place.address_name + '</div>');
            } else if (place.place_name && !place.phone) {
                infowindow.setContent('<div style=" white-space:normal; text-align:center;padding:6px; border: 1px solid #6449fc; color: #555;">' + place.place_name + ", " + place.address_name + '</div>');
            } else {
                infowindow.setContent('<div style=" white-space:normal; text-align:center;padding:6px; border: 1px solid #6449fc; color: #555;">' + place.place_name + ", " + place.address_name + ", " + place.phone + '</div>');
            }

            infowindow.open(map, marker);

            $("input.place_name").val(place.place_name);
            $("input.address_name").val(place.address_name);
            $("input.place_phone").val(place.phone);
            $("input.road_address_name").val(place.road_address_name);
            $("input.place_url").val(place.place_url);

        });
    }

} //end of function searchPlaces(keyword)

// 파일 있는 캘린더 등록
function goAddSchedule_withAttach() {

    var formData = $("form[name=scheduleFrm]").serialize();
    $("form[name=scheduleFrm]").ajaxForm({
        url: "<%= ctxPath%>/registerSchedule_end_withAttach.groovy",
        data: formData,
        type: "POST",
        enctype: "multipart/form-data",
        dataType: "JSON",
        success: function(json) {
            if (json.n == 1) {
                alert("일정 등록에 성공하였습니다.");
                $('form.scheduleFrm').each(function() {
                    this.reset();
                });
                $("select.small_category").empty();
                $("select.small_category").hide();

                $("div#modal_addSchedule").modal("hide");
                calendar.refetchEvents();
            } else {
                alert("일정 등록에 실패하였습니다.");
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

    $("form[name=scheduleFrm]").submit();

} //end of function goAddSchedule_withAttach()

// 파일없는 캘린더 등록
function goAddSchedule_noAttach() {

    var formData = $("form[name=scheduleFrm]").serialize();
    $.ajax({
        url: "<%= ctxPath%>/registerSchedule_end_noAttach.groovy",
        data: formData,
        type: "POST",
        dataType: "JSON",
        success: function(json) {
            if (json.n == 1) {
                alert("일정 등록에 성공하였습니다.");
                $('form.scheduleFrm').each(function() {
                    this.reset();
                });
                $("select.small_category").empty();
                $("select.small_category").hide();

                $("div#modal_addSchedule").modal("hide");
                calendar.refetchEvents()
            } else {
                alert("일정 등록에 실패하였습니다.");
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} //end of function goAddSchedule_noAttach()

//공유자를 넣어주는 함수
function add_joinUser(value) { // value 가 공유자로 선택한이름 이다.

    var plusUser_es = $("div.displayUserList > span.plusUser").text();
    //console.log(" => " + value);
    //console.log("확인용 plusUser_es => " + plusUser_es);

    if (plusUser_es.includes(value)) { // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
        alert("이미 추가한 회원입니다.");
    } else {
        $("div.displayUserList").append("<span class='plusUser'>" + value + "&nbsp;<i class='fas fa-times-circle'></i></span>");
    }

    $("input#joinUserName").val("");

} // end of function add_joinUser(value)


//캘린더 등록/수정시 대분류에 따른 소분류 보여주기
function selectCalType(fk_lgcatgono) {

    var fk_empnum = $("input[name=fk_empnum]").val(); // 로그인 된 사용자아이디

    if (fk_lgcatgono != "") { // 선택하세요 가 아니라면
        $.ajax({
            url: "<%= ctxPath%>/selectSmallCategory.groovy",
            data: {
                "fk_lgcatgono": fk_lgcatgono,
                "fk_empnum": fk_empnum
            },
            dataType: "json",
            async: false,
            success: function(json) {
                var html = "";
                if (json.length > 0) {

                    $.each(json, function(index, item) {
                        html += "<option value='" + item.pk_smcatgono + "'>" + item.smcatgoname + "</option>"
                    });
                    $("select.small_category").html(html);
                    $("select.small_category").show();
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    } else {
        // 선택하세요 이라면
        $("select.small_category").hide();
    }
} //end of function selectCalType(fk_lgcatgono)

//======================== 캘린더 등록 끝 ========================//	


//======================== 캘린더 상세보기 시작 ========================//	


// 캘린더 상세보기 지도 보여주기
function showMap(address) {
    $("div.card-content-map").show();

    var mapContainer = document.getElementById('card-content-map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption);

    var imageSrc = '<%=ctxPath %>/resources/images/kimyj/map-mark.png',
        imageSize = new kakao.maps.Size(48, 48), // 마커이미지의 크기입니다
        imageOption = {
            offset: new kakao.maps.Point(24, 48)
        }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

    //마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(address, function(result, status) {

        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords,
                image: markerImage
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:200px;text-align:center;padding:6px 0; border: 1px solid #6449fc; color: #555;">' + address + '</div>'
            });
            infowindow.open(map, marker);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.relayout();
            map.setCenter(coords);

        }
    });

} //end of function showMap(address)


//캘린더상세 보기
function detailSchedule(pk_scheduleno) {

    $.ajax({
        url: '<%= ctxPath%>/detailSchedule.groovy',
        data: {
            "pk_scheduleno": pk_scheduleno
        },
        dataType: "json",
        success: function(json) {

            voteTotalCnt(pk_scheduleno);
            voteTotalLoginCnt(pk_scheduleno);
            voteYesUser(pk_scheduleno);
            voteNoUser(pk_scheduleno);
            voteUndefinedUser(pk_scheduleno);


            var miniCalendarYM = moment(json.map.STARTDATE).format('YYYY-MM');
            var miniCalendarDD = moment(json.map.STARTDATE).format('DD');
            var regdate = moment(json.map.REGDATE).format('YYYY-MM-DD HH:mm');
            var week = ['일', '월', '화', '수', '목', '금', '토'];
            var startdate = moment(json.map.STARTDATE).format('YYYY-MM-DD');
            var startdate_day = week[new Date(json.map.STARTDATE).getDay()];
            var startdate_time = moment(json.map.STARTDATE).format('HH:mm');
            var enddate = moment(json.map.ENDDATE).format('YYYY-MM-DD');
            var enddate_day = week[new Date(json.map.ENDDATE).getDay()];
            var enddate_time = moment(json.map.ENDDATE).format('HH:mm');
            var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
            
            let html = "";
            html += '<div class="card-header">';
            html += '<h3 class="card-title">';
            html += '<i><span class="material-icons-outlined"> bookmark_border </span></i>'; 
            html += '<span class="js-project-title-button">' + json.map.LGCATGONAME + '-' + json.map.SMCATGONAME + '</span>'; 
            html += '</h3>';
            html += '<button type="button" class="close">';
            html += '<span class="material-icons-outlined"> close </span>';
            html += '</button>';
            html += '</div>';
            html += '<div class="card-body">';
            html += '<div class="card-scroll">';
            html += '<div class="card-body-top">';
            html += '<div class="card-author">';
            html += '<span class="card-profileImg">';
            html += '<img class="card-myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+json.map.EMPPICTURENAME+'" alt="icon-myprofile">';
            html += '</span>';  
            html += '<dl class="card-author-info">';
            html += '<dt>';
            html += '<strong class="author-name"> [' + json.map.DEPTNAMEKOR + ' : ' + json.map.SPOTNAMEKOR + '] ' + json.map.NAME + '</strong>'; 
            html += '<span class="author-date">' + regdate + '</span>'; 
            html += '</dt>';
            html += '</dl>';
            html += '</div>';
            html += '<div>';

            if ('${sessionScope.loginuser.pk_empnum}' == json.map.FK_EMPNUM) {
                html += '<div class="card-option">';
                html += '<button type="button" class="card-edit" onclick="scheduleEdit(' + pk_scheduleno + ')">수정</button>';
                html += '<button type="button" class="card-delete" onclick="scheduleDel(' + pk_scheduleno + ')">삭제</button>';
                html += '</div>';
            }

            html += '</div>';
            html += '</div>';
            html += '<div class="card-body-bottom">';
            html += '<div class="card-schedule-date">';
            html += '<strong class="card-month" style="color:' + json.map.COLOR + '">' + miniCalendarYM + '</strong><strong class="card-day" style="background-color:' + json.map.COLOR + '">' + miniCalendarDD + '</strong>';
            html += '</div>';
            html += '<div class="card-schedule-title-area">';
            html += '<h4 class="card-schedule-title">' + json.map.SUBJECT + '</h4>';
            html += '<div class="card-schedule-day">';
            html += '<span class="card-schedule-startDate">' + startdate + ' (' + startdate_day + '), ' + startdate_time + '</span>';
            html += '<span class="card-schedule-endDate">' + enddate + ' (' + enddate_day + '), ' + enddate_time + '</span>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '<div class="card-container">';
            html += '<div class="card-content">';
            html += '<div class="card-content2">';
            html += '<ul class="card-content-group">';
            html += '<li>';
            html += '<div class="card-content-title"><i class="icon-text"></i></div>';
            html += '<div class="card-content-memo">';
            html += '<span class="memo-span"><div>' + json.map.CONTENT + '</div></span>';
            html += '</div>';
            html += '</li>';
            
            if (json.map.ADDRESSNAME != "-") {
                html += '<li>';
                html += '<div class="card-content-title"><i class="icon-place"></i></div>';
                html += '<div class="card-content-place">';
                html += '<span class="place-span"><div>';
                
                if (json.map.PLACENAME != "-") {
                    html += json.map.PLACENAME + ' : ';
                }
                
                if (json.map.ADDRESSNAME != "-") {
                    html += json.map.ADDRESSNAME;
                }
                
                if (json.map.PLACEPHONE != "-") {
                    html += ' 번호 : ' + json.map.PLACEPHONE;
                }
                
                html += '</div><a  href="' + json.map.PLACEURL + '" target="_blank">상세보기</a></span>';
                html += '</div>';
                html += '</li>';
                html += '<li>';
                html += '<div class="card-content-title"></div>';
                html += '<div class="card-content-map" id="card-content-map">';
                html += '</div>';
                html += '</li>';
            }
            
            if (json.map.ORGFILENAME != "-" || json.map.PK_LGCATGONO == 2) {
                html += '<li>';
                html += '<div class="card-content-title"><i class="icon-file-download"></i></div>';
                html += '<div class="card-content-download">';
                html += '<span class="download-span"><a href="<%= ctxPath%>/downloadComment.groovy?pk_scheduleno=' + json.map.PK_SCHEDULENO + '">' + json.map.ORGFILENAME + '</a></span>';
                html += '</div>';
                html += '</li>';

            }
            
            if (json.map.JOINUSER != "-") {
                html += '<li>';
                html += '<div class="card-content-title"><i class="icon-share"></i></div>';
                html += '<div class="card-content-share">';
                html += '<span class="share-span"><div>' + json.map.JOINUSER + '</div></span>';
                html += '</div>';
                html += '</li>';

            }
            
            html += '</ul>';
            html += '</div>';

            if (json.map.VOTE == 1) {//참석유무
                html += '<div class="card-vote">';
                html += '<div class="vote-group">';
                html += '<div>';
                html += '<div class="vote-yes-group">';
                html += '<span class="yesCnt">';
                html += '<span>참석</span><em>0</em>';
                html += '</span>';
                html += '<ul class="vote-yes-ul">';
                html += '</ul>';
                html += '</div>';
                html += '<div class="vote-no-group">';
                html += '<span class="noCnt">';
                html += '<span>불참</span><em>0</em>';
                html += '</span>';
                html += '<ul class="vote-no-ul">';
                html += '</ul>';
                html += '</div>';
                html += '<div class="vote-undefined-group">';
                html += '<span class="undefinedCnt">';
                html += '<span>미정</span><em>0</em>';
                html += '</span>';
                html += '<ul class="vote-undefined-ul">';
                html += '</ul>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                html += '<button class="vote-btn-yes" onclick="voteYesAdd(' + json.map.PK_SCHEDULENO + ')">참석</button>';
                html += '<button class="vote-btn-no" onclick="voteNoAdd(' + json.map.PK_SCHEDULENO + ')">불참</button>';
                html += '<button class="vote-btn-undefined" onclick="voteUndefinedAdd(' + json.map.PK_SCHEDULENO + ')">미정</button>';
                html += '</div>';
            }
            
            html += '</div>';
            html += '</div>';
            html += '<div class="card-footer">';
            html += '<ul class="card-footer-group">';
            html += '</ul>';
            html += '<div class="comment-header"></div>';
            html += '</div>';
            html += '<div class="card-footer2">';
            html += '<div class="comment-writer-profile">';
            html += '<span class="comment-writer-profile-span">';
            html += '<img class="card-myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}" alt="icon-myprofile">';
            html += '</span>';
            html += '</div>';
            html += '<form class="comment-writer-container">';
            html += '<fieldset>';
            html += '<input type="text" class="comment-writer-text"  placeholder="댓글등록은 Enter키 입니다.">';
            html += '<input type="text" style="display:none;">';
            html += '</fieldset>';
            html += '</form>';
            html += '</div>';


            $(".schedulenoShave").val(pk_scheduleno);


            $("div.showSchedule").html(html);

            if (json.map.ADDRESSNAME != "-") {
                $("div.card-content-map").hide();
                showMap(json.map.ADDRESSNAME);
            }
            commentShow(pk_scheduleno, 1);

            $("div.showSchedule").show();

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
} //end of function detailSchedule(pk_scheduleno)


//동의 투표추가
function voteYesAdd(fk_scheduleno) {
    $("button.vote-btn-yes").css({
        'background': '#00b19c',
        'color': '#fff'
    });
    $("button.vote-btn-no").css({
        'background': '',
        'color': ''
    });
    $("button.vote-btn-undefined").css({
        'background': '',
        'color': ''
    });
    $("ul.vote-yes-ul").hide();
    $("ul.vote-no-ul").hide();
    $("ul.vote-undefined-ul").hide();


    $.ajax({
        url: "<%= ctxPath%>/voteYesAdd.groovy",
        type: "POST",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            //alert(json.msg);
            //swal(json.msg);
            voteTotalCnt(fk_scheduleno);

            voteYesUser(fk_scheduleno);
            voteNoUser(fk_scheduleno);
            voteUndefinedUser(fk_scheduleno);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });


} // end of function voteYesAdd(fk_scheduleno)

// 비동의 투표 추가
function voteNoAdd(fk_scheduleno) {
    $("button.vote-btn-no").css({
        'background': '#ff6b6b',
        'color': '#fff'
    });
    $("button.vote-btn-yes").css({
        'background': '',
        'color': ''
    });
    $("button.vote-btn-undefined").css({
        'background': '',
        'color': ''
    });
    $("ul.vote-yes-ul").hide();
    $("ul.vote-no-ul").hide();
    $("ul.vote-undefined-ul").hide();

    $.ajax({
        url: "<%= ctxPath%>/voteNoAdd.groovy",
        type: "POST",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            //alert(json.msg);
            //swal(json.msg);
            voteTotalCnt(fk_scheduleno);

            voteYesUser(fk_scheduleno);
            voteNoUser(fk_scheduleno);
            voteUndefinedUser(fk_scheduleno);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });


} // end of function voteNoAdd(fk_scheduleno)

// 몰라요 투표 추가
function voteUndefinedAdd(fk_scheduleno) {

    $("button.vote-btn-undefined").css({
        'background': '#777',
        'color': '#fff'
    });
    $("button.vote-btn-yes").css({
        'background': '',
        'color': ''
    });
    $("button.vote-btn-no").css({
        'background': '',
        'color': ''
    });
    $("ul.vote-yes-ul").hide();
    $("ul.vote-no-ul").hide();
    $("ul.vote-undefined-ul").hide();
    $.ajax({
        url: "<%= ctxPath%>/voteUndefinedAdd.groovy",
        type: "POST",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            //alert(json.msg);
            //swal(json.msg);
            voteTotalCnt(fk_scheduleno);

            voteYesUser(fk_scheduleno);
            voteNoUser(fk_scheduleno);
            voteUndefinedUser(fk_scheduleno);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });


} // end of function voteUndefinedAdd(fk_scheduleno)

// 투표 카운트
function voteTotalCnt(fk_scheduleno) {

    $.ajax({
        url: "<%= ctxPath%>/voteTotalCnt.groovy",
        type: "get",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            $("div.vote-group span.yesCnt em").html(json.map.YESCNT);
            $("div.vote-group span.noCnt em").html(json.map.NOCNT);
            $("div.vote-group span.undefinedCnt em").html(json.map.UNDEFINEDCNT);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function voteTotalCnt(fk_scheduleno)

// 본인투표 카운트
function voteTotalLoginCnt(fk_scheduleno) {

    $.ajax({
        url: "<%= ctxPath%>/voteTotalLoginCnt.groovy",
        type: "get",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            if (json.map.USERYESCNT == "1") {
                $("button.vote-btn-yes").css({
                    'background': '#00b19c',
                    'color': '#fff'
                });
                $("button.vote-btn-no").css({
                    'background': '',
                    'color': ''
                });
                $("button.vote-btn-undefined").css({
                    'background': '',
                    'color': ''
                });

            } else if (json.map.USERNOCNT == "1") {
                $("button.vote-btn-no").css({
                    'background': '#ff6b6b',
                    'color': '#fff'
                });
                $("button.vote-btn-yes").css({
                    'background': '',
                    'color': ''
                });
                $("button.vote-btn-undefined").css({
                    'background': '',
                    'color': ''
                });

            } else if (json.map.USERUNDEFINEDCNT == "1") {
                $("button.vote-btn-undefined").css({
                    'background': '#777',
                    'color': '#fff'
                });
                $("button.vote-btn-yes").css({
                    'background': '',
                    'color': ''
                });
                $("button.vote-btn-no").css({
                    'background': '',
                    'color': ''
                });

            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function voteTotalLoginCnt(fk_scheduleno)

// 동의 투표 인원 체크
function voteYesUser(fk_scheduleno) {

    $.ajax({
        url: "<%= ctxPath%>/voteYesUser.groovy",
        type: "get",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {

            let html = ""
            if (json.length > 0) {
                $("span.yesCnt").css({
                    'pointer-events': ''
                });

                $.each(json, function(index, item) {
                    html += '<li>';
                    html += '<div>' + item.name + '(' + item.fk_empnum + ')</div>';
                    html += '</div>';
                    html += '</li>';
                });

            } else {
                $("span.yesCnt").css({
                    'pointer-events': 'none'
                });

            }

            $("ul.vote-yes-ul").html(html);
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function voteYesUser(fk_scheduleno)

// 비동의 투표 인원 체크
function voteNoUser(fk_scheduleno) {

    $.ajax({
        url: "<%= ctxPath%>/voteNoUser.groovy",
        type: "get",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            let html = ""
            if (json.length > 0) {
                $("span.noCnt").css({
                    'pointer-events': ''
                });
                $.each(json, function(index, item) {
                    html += '<li>';
                    html += '<div>' + item.name + '(' + item.fk_empnum + ')</div>';
                    html += '</div>';
                    html += '</li>';
                });
            } else {
                $("span.noCnt").css({
                    'pointer-events': 'none'
                });
            }

            $("ul.vote-no-ul").html(html);

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function voteNoUser(fk_scheduleno)

// 몰라요 투표 인원 체크
function voteUndefinedUser(fk_scheduleno) {

    $.ajax({
        url: "<%= ctxPath%>/voteUndefinedUser.groovy",
        type: "get",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {
            let html = ""
            if (json.length > 0) {

                $("span.undefinedCnt").css({
                    'pointer-events': ''
                });
                $("span.undefinedCnt").on('click');
                $.each(json, function(index, item) {
                    html += '<li>';
                    html += '<div>' + item.name + '(' + item.fk_empnum+ ')</div>';
                    html += '</div>';
                    html += '</li>';
                });
            } else {

                $("span.undefinedCnt").css({
                    'pointer-events': 'none'
                });

            }
            $("ul.vote-undefined-ul").html(html);

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function voteUndefinedUser(fk_scheduleno)




//댓글 수정
function commentEdit(fk_scheduleno, commentseq) {

    let html = "";
    html += '<input type="text" class="comment-writer-text"  placeholder="입력 Enter 입니다.">';
    html += '<input type="text" style="display:none;">';
    const backuptext = $("li#commentid-" + commentseq + " div.comment-text div").text();

    $("li#commentid-" + commentseq + " div.comment-text-area").html(html);
    $("li#commentid-" + commentseq + " input.comment-writer-text").val(backuptext);

    $("div.card-footer2").hide();

    html = "";
    html += '<button type="button" class="comment-cancell" onclick="commentEditCancell(' + fk_scheduleno + ')">취소</button>';
    $("li#commentid-" + commentseq + " div.comment-writer-menu").html(html);


    $(document).on('keyup', 'li#commentid-' + commentseq + ' input.comment-writer-text', function(event) {
        if (event.keyCode == 13) {
            const contentEdit = $("li#commentid-" + commentseq + " input.comment-writer-text").val();

            $.ajax({
                url: "<%= ctxPath%>/commentEdit.groovy",
                type: "POST",
                data: {
                    "fk_scheduleno": fk_scheduleno,
                    "fk_empnum": "${sessionScope.loginuser.pk_empnum}",
                    "commentseq": commentseq,
                    "content": contentEdit
                },
                dataType: "JSON",
                success: function(json) {

                    if (json.n == 1) {
                        alert("댓글수정 성공");
                        commentShow(fk_scheduleno, 1);
                        $("div.card-footer2").show();
                    } else {
                        alert("댓글수정 실패");
                    }


                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });


        }
    });

} // end of function commentEdit(fk_scheduleno,commentseq)

// 댓글 삭제
function commentDel(fk_scheduleno, commentseq) {

    $.ajax({
        url: "<%= ctxPath%>/commentDel.groovy",
        type: "POST",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}",
            "commentseq": commentseq
        },
        dataType: "JSON",
        success: function(json) {

            if (json.n == 1) {
                alert("댓글삭제 성공");
                commentShow(fk_scheduleno, 1);
            } else {
                alert("댓글삭제 실패");
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function commentDel(fk_scheduleno,commentseq) 


// 댓글 수정 완료
function commentEditCancell(fk_scheduleno){	
	commentShow(fk_scheduleno,1); 
    $("div.card-footer2").show();
}

//댓글 등록
function commentAdd(fk_scheduleno) {

    const content = $("input.comment-writer-text").val();

    $.ajax({
        url: "<%= ctxPath%>/commentAdd.groovy",
        type: "POST",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}",
            "name": "${sessionScope.loginuser.name}",
            "content": content
        },
        dataType: "JSON",
        success: function(json) {

            if (json.n == 1) {
                $("input.comment-writer-text").val("");
                commentShow(fk_scheduleno, 1);
            } else {
                alert("댓글쓰기 실패");
            }

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function commentAdd(fk_scheduleno)

// 댓글 보여주기
function commentShow(fk_scheduleno, currentShowPageNo) {
 
    $.ajax({
        url: "<%= ctxPath%>/commentShow.groovy",
        type: "GET",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "currentShowPageNo": currentShowPageNo
        },
        dataType: "JSON",
        success: function(json) {


            if (json.length > 0) {

                let html = ""
                $.each(json, function(index, item) {
                    var regdate = moment(item.regdate).format('YYYY-MM-DD HH:mm');

                    html += '<li class="card-footer-li" id="commentid-' + item.commentseq + '">';

                    html += '<div class="comment-user-profile">';
                    html += '<span class="comment-user-profile-span">';
                    html += '<img class="card-myprofile-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+item.emppicturename+'" alt="icon-myprofile">';
                    html += '</span>';
                    html += '</div>';

                    html += '<div class="comment-container">';
                    html += '<div class="comment-user-area">';
                    html += '<div class="comment-user">';
                    html += '<span class="comment-user-name">[' + item.deptnamekor + ' : ' + item.spotnamekor + '] ' + item.name + '</span>';
                    html += '<span class="comment-user-position"></span>';
                    html += '<span class="record-date">' + regdate + '</span>';
                    html += '</div>';
                    if ('${sessionScope.loginuser.pk_empnum}' == item.fk_empnum) {
                        html += '<div class="comment-writer-menu">';
                        html += '<button type="button" class="comment-edit" onclick="commentEdit(' + fk_scheduleno + ',' + item.commentseq + ')">수정</button>';
                        html += '<button type="button" class="comment-delete" onclick="commentDel(' + fk_scheduleno + ',' + item.commentseq + ')">삭제</button>';
                        html += '</div>';
                    }


                    html += '</div>';

                    html += '<div class="comment-content">';
                    html += '<div class="comment-text-area">';
                    html += '<div class="comment-text"><div>' + item.content + '</div></div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';

                    html += '</li>';
                });
                $("ul.card-footer-group").html(html);

                makeCommentPageBar(fk_scheduleno, currentShowPageNo);
            }

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function commentShow(fk_scheduleno, currentShowPageNo)

//스케줄 삭제
function scheduleDel(pk_scheduleno) {
    $("div.showSchedule").empty();
    $("div.showSchedule").hide();

    $.ajax({
        url: "<%= ctxPath%>/scheduleDel.groovy",
        type: "POST",
        data: {
            "pk_scheduleno": pk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {

            if (json.n == 1) {
                alert("스케줄삭제 성공");
                calendar.refetchEvents();
            } else {
                alert("스케줄삭제 실패");
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function scheduleDel(pk_scheduleno)

//댓글 페이징
function makeCommentPageBar(fk_scheduleno, currentShowPageNo) {

    $.ajax({
        url: "<%= ctxPath%>/getCommentTotalPage.groovy",
        data: {
            "fk_scheduleno": fk_scheduleno,
            "sizePerPage": "3"
        },
        type: "GET",
        dataType: "JSON",
        success: function(json) {
            //console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);

            if (json.totalPage > 0) { // 댓글이 있는 경우 

                const totalPage = json.totalPage;

                let pageBarHTML = "<ul>";

                const blockSize = 5; // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.

                let loop = 1;

                if (typeof currentShowPageNo == "string") {
                    currentShowPageNo = Number(currentShowPageNo);
                }

                // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
                let pageNo = Math.floor((currentShowPageNo - 1) / blockSize) * blockSize + 1;
				
                // === [맨처음][이전] 만들기 === //
                pageBarHTML += "<li class='firstli'><a href='javascript:commentShow(\"" + fk_scheduleno + "\",\"1\")'></a></li>";
                pageBarHTML += "<li class='previousli'><a href='javascript:commentShow(\"" + fk_scheduleno + "\",\"" + (pageNo - 1) + "\")'></a></li>";

                if (pageNo != 1) {}

                while (!(loop > blockSize || pageNo > totalPage)) {

                    if (pageNo == currentShowPageNo) {
                        pageBarHTML += "<li class='numberli'>" + pageNo + "</li>";
                    } else {
                        pageBarHTML += "<li class='numberli'><a href='javascript:commentShow(\"" + fk_scheduleno + "\",\"" + pageNo + "\")'>" + pageNo + "</a></li>";
                    }

                    loop++;
                    pageNo++;

                } // end of while-----------------------


                // === [다음][마지막] 만들기 === //
                if (pageNo <= totalPage) {}
                pageBarHTML += "<li class='nextli'><a href='javascript:commentShow(\"" + fk_scheduleno + "\",\"" + pageNo + "\")'></a></li>";
                pageBarHTML += "<li class='lastli'><a href='javascript:commentShow(\"" + fk_scheduleno + "\",\"" + totalPage + "\")'></a></li>";

                pageBarHTML += "</ul>";

                $("div.comment-header").html(pageBarHTML);
            } // end of if(json.totalPage > 0){}-------------------------------

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} // end of function makeCommentPageBar(fk_scheduleno, currentShowPageNo) 
  
//======================== 캘린더 상세보기 끝 ========================//	

//======================== 캘린더 수정 시작 ========================//	

//캘린더 수정 지도 보여주기
function showMap2(address){
	$("li.mapLi").show();
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	var imageSrc = '<%=ctxPath %>/resources/images/kimyj/map-mark.png',
	imageSize = new kakao.maps.Size(48, 48), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(24, 48)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	  
	//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
  
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image: markerImage
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:200px;text-align:center;padding:6px 0; border: 1px solid #6449fc; color: #555;">'+address+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.relayout();
	        map.setCenter(coords);
	        
    } 
});   
	
}//end of function showMap2(address)

//스케줄 수정
function scheduleEdit(pk_scheduleno) {

    $('form.scheduleFrm').each(function() {
        this.reset();
    });
    $("li.mapLi").hide();
    $("select.small_category").empty();
    $("select.small_category").hide();
    $("input.subject").css('color', '');
    $("div.displayUserList").empty();

    $.ajax({
        url: "<%= ctxPath%>/scheduleEdit.groovy",
        type: "POST",
        data: {
            "pk_scheduleno": pk_scheduleno,
            "fk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        dataType: "JSON",
        success: function(json) {

            $("div.showSchedule").empty();
            $("div.showSchedule").hide();
            $("#modal_addSchedule h5.modal-title").text("일정수정");

            let html = "";
            html += '<button type="button" id="editSchedule" class="btn btn-success btn-sm btn_normal">수정</button>';
            html += '<button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>';
            $("#modal_addSchedule div.modal-footer").html(html);

            selectCalType(json.map.PK_LGCATGONO);

            $("#modal_addSchedule input#color").val(json.map.COLOR); //색상
            $("#modal_addSchedule input#subject").val(json.map.SUBJECT); //제목
            $("#modal_addSchedule input#subject").css({
                'color': json.map.COLOR
            }); //제목

            $("#modal_addSchedule textarea#content").val(json.map.CONTENT); //내용
            $("#modal_addSchedule select.calType").val(json.map.PK_LGCATGONO).prop("selected", true); //대분류
            $("#modal_addSchedule select.small_category").val(json.map.PK_SMCATGONO).prop("selected", true); //소분류
            $('#modal_addSchedule input.selectDay').data('daterangepicker').setStartDate(json.map.STARTDATE);
            $('#modal_addSchedule input.selectDay').data('daterangepicker').setEndDate(json.map.ENDDATE);
            $("#modal_addSchedule input#vote").val(json.map.VOTE);
            $("#modal_addSchedule input.eidt_pk_scheduleno").val(pk_scheduleno);

            if(json.map.PK_LGCATGONO == 2){
            	$("input#joinUserName").prop('readonly', true);
    		   	$("input#joinUserName").attr("placeholder", "사내 캘린더는 공유자가 필요없습니다.");
            }
            console.log(json.map.VOTE+","+$("#modal_addSchedule input#vote").val());
            if (json.map.VOTE == 1) {
                $("#modal_addSchedule input#vote").prop("checked", true);
                $("div.vote-group label").html('<span class="material-icons-outlined">check_circle</span>');
               
            } else {
                $("#modal_addSchedule input#vote").prop("checked", false);
                $("div.vote-group label").html('<span class="material-icons-outlined">radio_button_unchecked</span>');
            }

            if (json.map.ADDRESSNAME != "-") {
                $("#modal_addSchedule input#place").val(json.map.ADDRESSNAME); //지도
                $("#modal_addSchedule input.place_name").val(json.map.PLACENAME);
                $("#modal_addSchedule input.address_name").val(json.map.ADDRESSNAME);
                $("#modal_addSchedule input.place_phone").val(json.map.PLACEPHONE);
                $("#modal_addSchedule input.road_address_name").val(json.map.ROADADDRESSNAME);
                $("#modal_addSchedule input.place_url").val(json.map.PLACEURL);

                showMap2(json.map.ADDRESSNAME);

            }
            if (json.map.JOINUSER != "-") {

                let arr = json.map.JOINUSER.split(',');
                $.each(arr, function(index, item) {
                    let joinUserName = item.trim();
                    add_joinUser(joinUserName);

                });

            }
            if (json.map.FILENAME != "-") {
            	$("#modal_addSchedule input.upload-name").val(json.map.ORGFILENAME);
            }
            
          
            $('#modal_addSchedule').modal('show');
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });


} // end of function scheduleEdit(pk_scheduleno)

//파일 있는 캘린더 수정
function goEditSchedule_withAttach(){
	
	 var formData = $("form[name=scheduleFrm]").serialize();
	  $("form[name=scheduleFrm]").ajaxForm({
		 url: "<%= ctxPath%>/goEditSchedule_withAttach.groovy",
		data: formData,
		 type:"POST",
	 	  enctype:"multipart/form-data",
		  dataType:"JSON",
		 success:function(json){
			if(json.n == 1){
				alert("일정 수정에 성공하였습니다.");
				 $('form.scheduleFrm').each(function() {
		   		      this.reset();
		   		  	});
		        $("select.small_category").empty();
		        $("select.small_category").hide();
		        $("#modal_addSchedule h5.modal-title").text("일정등록");
		        let html = "";
	            html += '<button type="button" id="register" class="btn">등록</button>';
	            html += '<button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>';
	            $("#modal_addSchedule div.modal-footer").html(html);
	            $("#modal_addSchedule input#vote").val("0");
	            $("div.vote-group label").html('<span class="material-icons-outlined">radio_button_unchecked</span>');
				$("div#modal_addSchedule").modal("hide");
				/* calendar.changeView("dayGridMonth");//해당월 보여주기 수정필요 */
				calendar.refetchEvents();
			}else{
				alert("일정 수정에 실패하였습니다.");
			}
		 },
		 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }	 
	 });
	
	  $("form[name=scheduleFrm]").submit();
	
}//end of function goEditSchedule_withAttach()

// 파일 없는 캘린더 수정
function goEditSchedule_noAttach() {
    
    var formData = $("form[name=scheduleFrm]").serialize();
    $.ajax({
        url: "<%= ctxPath%>/goEditSchedule_noAttach.groovy",
        data: formData,
        type: "POST",
        dataType: "JSON",
        success: function(json) {
            if (json.n == 1) {
                alert("일정 수정에 성공하였습니다.");
                $('form.scheduleFrm').each(function() {
                    this.reset();
                });
                $("select.small_category").empty();
                $("select.small_category").hide();
                $("#modal_addSchedule h5.modal-title").text("일정등록");
		        let html = "";
	            html += '<button type="button" id="register" class="btn">등록</button>';
	            html += '<button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>';
	            $("#modal_addSchedule div.modal-footer").html(html);
	            $("#modal_addSchedule input#vote").val("0");
	            $("div.vote-group label").html('<span class="material-icons-outlined">radio_button_unchecked</span>');
                $("div#modal_addSchedule").modal("hide");
                /* calendar.changeView("dayGridMonth");//해당월 보여주기 수정필요 */
                calendar.refetchEvents()
            } else {
                alert("일정 수정에 실패하였습니다.");
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

} //end of function goEditSchedule_noAttach()

//======================== 캘린더 수정 끝 ========================//	

//======================== 미완성 시작 ========================//	

// 년월 select 표시
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

    for (var i = 0; i < 5; i++) {
    	const liday = moment(initial).format("YYYY-MM");
    	const aday = moment(initial).format("YYYY년 MM월");
    	
    	//let html ="";
    	//html += "<li id='"+liday+"' class='months'>";
    	//html += "<a>"+aday+"</a>"
    	//html += "</li>"
    	//$("ul.monthsList").append(html);
    	
    	
        var li = document.createElement("li");
        li.id = (moment(initial).format("YYYY-MM"));
        li.className = "months";

       	 var a = document.createElement("a");
        a.value = moment(initial).format("YYYY-MM-01");
        a.text = moment(initial).format("YYYY년 MM월");
        a.selected = initial === moment(month).format("YYYY-MM");

        $("ul.monthsList").append(li);
        $("li#" + moment(initial).format("YYYY-MM")).append(a);

        initial = moment(initial).add(1, "month").format("YYYY-MM");
    }
} //end of function buildMonthList()	

// 검색 기능
function goSearch() {

    if ($("#fromDate").val() > $("#toDate").val()) {
        alert("검색 시작날짜가 검색 종료날짜 보다 크므로 검색할 수 없습니다.");
        return;
    }

    if ($("select#searchType").val() == "" && $("input#searchWord").val() != "") {
        alert("검색대상 선택을 해주세요!!");
        return;
    }

    if ($("select#searchType").val() != "" && $("input#searchWord").val() == "") {
        alert("검색어를 입력하세요!!");
        return;
    }

    var frm = document.searchScheduleFrm;
    frm.method = "get";
    frm.action = "<%= ctxPath%>/searchSchedule.groovy";
    frm.submit();

} // end of function goSearch(){}

//======================== 미완성 끝 ========================//	

////////////////////////////////////////////////////////////////////////////////////////////////////////////
</script>


<%--=== 캘린더 사이드바 전환 버튼 ===--%>
<a href="#" id="sideBtn" class="sideBtn"></a>


<%--=== 캘린더 사이드바 ===--%>
<div class="sideCalList">
	<div align="center" class="mainlogo">
		<a href="<%=ctxPath %>/index.groovy"><img src="<%=ctxPath %>/resources/images/common/로고그루비.png" alt="로고" /></a>
	</div>
	<ul>
		<li>
		<div class="comCalTitle">
			<input type="hidden" value="${sessionScope.loginuser.pk_empnum}" id="fk_empnum"/>
			<span>사내 캘린더</span>
			 <c:if test="${sessionScope.loginuser.fk_spotnum == 0 || sessionScope.loginuser.fk_spotnum >= 7}">
			 	<button class="btn_edit" onclick="addComCalendar()">
					<i class='fas'><span class="material-icons-outlined"> add_circle_outline </span></i>
				</button>
			</c:if>
			<i class="ico-arrow active fas">&#xf078;</i>
		</div>
		<div class="comCalList">
			<ul>
				<li>
				<!--<div>
						<p>
							<input type="checkbox" checked id="allComCal" class="calendar_checkbox"/><label for="allComCal"></label><span>전체</span>
						</p>
					</div> -->
				</li>
			</ul>
		</div>
		</li>
		<li>
		<div class="myCalTitle">
			<span>내 캘린더</span>
			<button class="btn_edit" onclick="addMyCalendar()">
			<i class='fas'><span class="material-icons-outlined"> add_circle_outline </span></i>
			</button>
			<i class="ico-arrow active fas">&#xf078;</i>
		</div>
		<div class="myCalList">
			<ul>
				<li>
				<!--<div>
						<p>
							<input type="checkbox" checked id="allMyCal" class="calendar_checkbox"/><label for="allMyCal"></label><span>전체</span>
						</p>
					</div> -->
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
						<input type="checkbox" checked id="sharedCal" class="calendar_checkbox" value="0"/><label for="sharedCal"></label><span>표시</span>
					</p>
				</div>
				</li>
			</ul>
		</div>
		</li>
	</ul>
</div>


<%--=== 캘린더 상세페이지 ===--%>
<div class="card showSchedule"></div>

	
<%--=== 캘린더 ===--%>
<div>
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
						<select id="searchType" name="searchType">
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
		<%-- 풀캘린더가 보여지는 엘리먼트 --%>
		<div id="calendar" style="margin:50px 0 50px 0;">
		</div>
	</div>		
</div> 


<%--===사내 캘린더 추가 modal===--%>
<div class="modal fade" id="modal_addComCal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title">사내 캘린더 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="modal-body text-center">
                <form name="modal_frm">
                    <table class="table table-bordered">
                        <tr>
                            <td>
								소분류명
                            </td>
                            <td>
                                <input type="text" class="add_com_smcatgoname" placeholder="추가할 분류명을 입력하세요." />
                                <input type="text" style="display:none;">
                            </td>
                        </tr>
                        <tr>
                            <td>
								만든이
                            </td>
                            <td>
                                ${sessionScope.loginuser.name}
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" id="addCom" class="btn" onclick="goAddComCal()">추가</button>
                <button type="button" class="btn modal_close" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<%--===사내 캘린더 수정 modal===--%>
<div class="modal fade" id="modal_editComCal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title">사내 캘린더 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="modal-body text-center">
                <form name="modal_frm">
                    <table class="table table-bordered">
                        <tr>
                            <td>
								소분류명
                            </td>
                            <td>
                                <input type="text" class="edit_com_smcatgoname" placeholder="수정할 분류명을 입력하세요." /><input type="hidden" value="" class="edit_com_smcatgono">
                            	<input type="text" style="display:none;">
                            </td>
                        </tr>
                        <tr>
                            <td>
								만든이
                            </td>
                            <td>
                                ${sessionScope.loginuser.name}
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" id="addCom" class="btn" onclick="goEditComCal()">수정</button>
                <button type="button" class="btn modal_close" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<%--===내 캘린더 추가 modal===--%>
<div class="modal fade" id="modal_addMyCal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title">내 캘린더 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="modal-body text-center">
                <form name="modal_frm">
                    <table class="table table-bordered">
                        <tr>
                            <td>
								소분류명
                            </td>
                            <td>
                                <input type="text" class="add_my_smcatgoname" placeholder="추가할 분류명을 입력하세요." />
                            	<input type="text" style="display:none;">
                            </td>
                        </tr>
                        <tr>
                            <td>
								만든이
                            </td>
                            <td>
                                ${sessionScope.loginuser.name}
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" id="addCom" class="btn" onclick="goAddMyCal()">추가</button>
                <button type="button" class="btn modal_close" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<%--===내 캘린더 수정 modal===--%>
<div class="modal fade" id="modal_editMyCal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title">내 캘린더 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- Modal body -->
            <div class="modal-body text-center">
                <form name="modal_frm" class="modal_frm">
                    <table class="table table-bordered">
                        <tr>
                            <td>
 								소분류명
                            </td>
                            <td>
                                
                                <input type="text" class=edit_my_smcatgoname placeholder="수정할 분류명을 입력하세요." /><input type="hidden" value="" class="edit_my_smcatgono">
                            	<input type="text" style="display:none;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                               	 만든이
                            </td>
                            <td>
                                ${sessionScope.loginuser.name}
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" id="addCom" class="btn" onclick="goEditMyCal()">수정</button>
                <button type="button" class="btn modal_close" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<%--===캘린더 일정추가 modal===--%>
<div class="modal fade" id="modal_addSchedule" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title">일정등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <!-- Modal body -->
            <div class="modal-body text-center">
                <form name="scheduleFrm" class="scheduleFrm">
                    <div>
                        <div class="color-div title">
                            <input type="color" id="color" name="color" value="#6449fc" />
                        </div>
                        <div class="subject-div">
                            <input type="text" id="subject" name="subject" class="subject" placeholder="제목을 입력하세요." autocomplete="off" data-required-yn="Y" maxlength="100" data-empty-msg="제목을 입력하세요" />
                        </div>
                    </div>
                    <ul>
                        <li>
                            <div class="title">
                                <i class="icon-calendar"></i>
                            </div>
                            <div>
                                <input class="selectDay" />
                            </div>
                        </li>
                        <li>
                            <div class="title">
                                <i class="icon-select-calendar"></i>
                            </div>
                            <div>
                                <select class="calType schedule" name="fk_lgcatgono">
                                <option value="">선택하세요</option>
                                <option value="1">내 캘린더</option>
                                <c:if test="${sessionScope.loginuser.fk_spotnum == 0 || sessionScope.loginuser.fk_spotnum >= 7}">
                                	<option value="2">사내 캘린더</option>
                                </c:if>
                               
                                </select>
                                <select class="small_category schedule" name="fk_smcatgono">
                                </select>
                            </div>
                            <div class="vote-group">
                                <span>투표기능</span>
                                <input type="checkbox" id="vote" name="vote" class="vote_checkbox">
                                <label for="vote"><span class="material-icons-outlined"> radio_button_unchecked </span></label>
                            </div>
                        </li>
                        <li class="mapLi">
                            <div class="title">
                            </div>
                            <div id="map" class="map">
                            </div>
                        </li>
                        <li>
                            <div class="title">
                                <i class="icon-place"></i>
                            </div>
                            <div>
                                <input type="text" name="place" id="place" class="place" data-required-yn="Y" autocomplete="off" maxlength="500" placeholder="장소를 입력하세요 장소등록은 Enter키입니다." />
                            </div>
                        </li>
                        <li>
                            <div class="title">
                                <i class="icon-share"></i>
                            </div>
                            <div>
                                <input type="text" id="joinUserName" class="joinUserName" data-required-yn="Y" autocomplete="off" maxlength="500" placeholder="일정을 공유할 회원명/사원번호를 입력하세요." />
                                <div class="displayUserList">
                                </div>
                                <input type="hidden" name="joinuser" />
                            </div>
                        </li>
                        <li>
                            <div class="title">
                                <i class="icon-text"></i>
                            </div>
                            <div>
                                <textarea rows="10" cols="100" name="content" id="content" class="content" data-required-yn="Y" placeholder=" 내용을 입력하세요."></textarea>
                            </div>
                        </li>
                        <li>
                            <div class="title">
                                <i class="icon-file-upload"></i>
                            </div>
                            <div class="filebox">
                                <input type="file" id="filename" class="upload-file" name="attach">
                                <input class="upload-name" id="upload-name" value="파일선택" disabled="disabled">
                                <label for="filename"><span class="material-icons-outlined"> pageview </span></label>
                            </div>
                        </li>
                    </ul>
                    <input type="hidden" name="fk_empnum" value="${sessionScope.loginuser.pk_empnum}" />
                    <input type="hidden" name="startdate" />
                    <input type="hidden" name="enddate" />
                    <input type="hidden" name="pk_scheduleno" class="eidt_pk_scheduleno" />
                    <input type="hidden" name="placeName" class="place_name" />
                    <input type="hidden" name="addressName" class="address_name" />
                    <input type="hidden" name="placePhone" class="place_phone" />
                    <input type="hidden" name="roadAddressName" class="road_address_name" />
                    <input type="hidden" name="placeUrl" class="place_url" />
                </form>
            </div>
            
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" id="register" class="btn">등록</button>
                <button type="button" class="btn modal_close" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" class="chooseDate" />	
</form>	
<input type="hidden" class="schedulenoShave"/>	
