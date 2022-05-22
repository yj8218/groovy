<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #172. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
 // System.out.println("serverIP : " + serverIP);
 // serverIP : 211.238.142.72
   
   // String serverIP = "211.238.142.72"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
 // System.out.println("portnumber : " + portnumber);
 // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
 // System.out.println("serverName : " + serverName);
 // serverName : http://211.238.142.72:9090 
%>

<style type="text/css">
{box-sizing: border-box;}



/* --헤더 옮김-- */
div#myProfileCard div.card-body ul{
	margin:0;
	padding:0;
}

div#myProfileCard div.card-body ul li i {
    width: 40px;
    height: 40px;
    text-align: center;
}
div#myProfileCard div.card-body ul li span {
    width: 280px;
    padding: 0 0 0 10px;
    display: inline-block;
    border-bottom: 1px solid #eee;
}

a#stopwatch{
	color: #f1f1f1;
    font-size: 16px;
    font-weight: 700;
    position: relative;
  /*  top:-4px; */
   padding-left: 10px;
    
    
}
button#startBtn{
    height: 30px;
    width: 80px;
    padding: 0 20px;
    margin-left: 20px;
    background: #6449fc;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    font-size: 13px;
    color: #fff;
    text-align: center;
    border: 0;
    margin-bottom: 5px;
}

button#endBtn{
	height: 30px;
    width: 80px;
    padding: 0 20px;
    margin-left: 20px;
    background: #ff4444;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    font-size: 13px;
    color: #fff;
    text-align: center;
    border: 0;
    margin-bottom: 5px;
   

}
span#span_start{
color: #f1f1f1;
    font-size: 16px;
    font-weight: 700;
    position: relative;
  top:-4px;
    margin-left: 10px;
}
span#span_end{
color: #f1f1f1;
    font-size: 16px;
    font-weight: 700;
    position: relative;
   top:-4px;
     margin-left: 10px;
}

.fa-sitemap:before {
    
    font-size: 22px;
    position: relative;
 	top: 4px;
}

.myprofile-photo{
width: 40px;
    height: 40px;
    margin: 0 10px 0 0;
    display: inline-block;
    -webkit-border-radius: 16px;
    border-radius: 16px;
    background-size: cover;
}

/* --헤더 옮김 끝-- */

/* 헤더 ass 사이드로수정 */
div.sidenav .bottom-left {
  position: absolute;
  bottom: 8px;
  left: 16px;
}

div.sidenav strong.user-name{
	display: block;
    line-height: 21px;
   /*  color: #555; */
    max-width: 140px;
    font-size: 15px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-weight: bold;
}

div.sidenav li.infoList {

	position: relative;
    min-height: 19px;
    margin-top: 13px;
    cursor: pointer;
    font-size: 16px;
}
div.sidenav li.infoList:hover{
	 font-weight: bold;
}

div.sidenav .topnav {
  overflow: hidden;
  /* background-color: #f1f1f1; */
}



div.sidenav .tab button.active {
  border-bottom: 3px solid #111;
  font-weight: 700;
  color: black;
}
#expander{ width:100%; height:6px; background-color:#999;}



/* Style the tab */
div.sidenav .tab {
  overflow: hidden;
  
}

/* Style the buttons inside the tab */
div.sidenav .tab button {
  background-color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  font-size: 13px;
  width: 60px;
  height:30px;
  font-weight: 700;
  color: gray;
}

/* Style the tab content */
 div.sidenav .tabcontent{
  display: none;
  padding: 10px 20px;
}

div.sidenav button#btnChat{
	
    margin-left: 4px;
    width: auto;
    height: 30px;
    background: #6449fc;
    color: #fff;
    border-color: #6449fc;
	border-radius: 4px;
	font-size: 14px;
}




div.sidenav .layer_pop {
    display: none;
    position: fixed;
  	width: 220px;
    min-width: 218px;
    padding: 14px;
   /*  position: absolute; */
    top: 100px;
   /*  right: 30px; */
    background: #fff;
    border: 1px solid #777;
    -webkit-border-radius: 8px;
    border-radius: 8px;
    text-align: left;
    color: #555;
    left: 230px;
    color: #f1f1f1 !important;
    background-color: #2c2a34 !important;
    border: solid 1px #595959;
    border-radius: 0;
    height: 210px;
    

}



/* Add styles to the form container */
div.sidenav .myinfo-container {
  padding: 5px; 
  /* background-color: white; */
  height: 100%;
  width: 100%;
  color: #f1f1f1;
  
}



/* Add some hover effects to buttons */
div.sidenav .myinfo-container {
  opacity: 1; 
}

div.sidenav .myprofile-photo{
	width: 40px;
    height: 40px;
    margin: 0 10px 0 0;
    display: inline-block;
   
    -webkit-border-radius: 16px;
    border-radius: 16px;
    background-size: cover;

}


/* 헤더 사이드 수정 끝 */


</style>
<script type="text/javascript">


//  "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.

// >>> 출퇴근 관련(1) 시작 by 혜림 //
let isStartWorkClicked = false;
let isEndWorkClicked = false;
let timerId;
let time = 0;
let hour, min, sec;

$(document).ready(function() {
	
	$('sidenav .modal-backdrop').last().css("z-index", "9999");
	
    $('[data-toggle="tooltip"]').tooltip();
    $('#myProfileCard').appendTo("body");


    getUserInfo();

    $('sidenav .modal').on('hidden.bs.modal', function(e) {
        $(this).find('form')[0].reset();
        $(this).find('form[name="editFrm"]')[0].reset();
        $(this).find('form[name="registerFrm"]')[0].reset();

    });

    // >>> 출퇴근 관련(2) 시작 by 혜림 //

    const stopwatch = document.getElementById("stopwatch");

    //  		$("#time_startwork").text('${requestScope.WorkTime.startwork}');
    $("#time_endwork").text('${requestScope.WorkTime.endwork}');

    if ('${requestScope.WorkTime.endwork}' != '') {
        // 퇴근 또 못찍게 버튼 막기, 스톱워치 그만
        $("button#endBtn").attr("disabled", true);

    }


    // 스톱워치 기록을 유지시켜주는 용도
    $.ajax({
        url: "<%=ctxPath%>/getStartWorkTime.groovy",
        type: "POST",
        dataType: "JSON",
        success: function(json) {
            // 				alert(json.startWorkTime.startwork);

            let startWorkTime = json.startWorkTime.startwork; // 출근 시각
            let endWorkTime = json.startWorkTime.endwork; // 퇴근 시각

            if (startWorkTime != null) {

                const startWorkTime_hh = startWorkTime.substr(0, 2);
                const startWorkTime_mi = startWorkTime.substr(3, 2);
                const startWorkTime_ss = startWorkTime.substr(6, 2);

                startworktime = new Date(); // 출근 시각 Date() 객체

                startworktime.setHours(startWorkTime_hh, startWorkTime_mi, startWorkTime_ss);
                // Sat May 21 2022 13:11:10 GMT+0900 (한국 표준시)

                // 현재시각과 출근시각 차이 구하기
                const now = new Date(); // 현재 시각 Date() 객체

                let gaptimegapBySec = (now.getTime() - startworktime.getTime()) / 1000; // 초단위
                time = gaptimegapBySec;

                if (timerId != null) {
                    clearTimeout(timerId);
                }

                if (endWorkTime != null) { // 퇴근기록이 있으면 스톱워치 멈춤

                    const endWorkTime_hh = endWorkTime.substr(0, 2);
                    const endWorkTime_mi = endWorkTime.substr(3, 2);
                    const endWorkTime_ss = endWorkTime.substr(6, 2);

                    endWorkTime = new Date();
                    endWorkTime.setHours(endWorkTime_hh, endWorkTime_mi, endWorkTime_ss);

                    gaptimegapBySec = (endWorkTime.getTime() - startworktime.getTime()) / 1000; // 초단위
                    time = gaptimegapBySec;

                    $("#time_endwork").text(json.startWorkTime.endwork);

                    printTime();
                    stopClock();
                } else { // 퇴근기록이 없으면 스톱워치 계속
                    startClock();
                }

                $("#time_startwork").text(json.startWorkTime.startwork);
            }

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });


    // 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지만 확인하는 용도
    $.ajax({
        url: "<%=ctxPath%>/isClickedStartBtn.groovy",
        data: {
            "pk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        type: "POST",
        dataType: "JSON",
        success: function(json) {
            	alert(json.isClicked);
            // 출근버튼 찍었으면 출근버튼 비활성화
            const isClicked = json.isClicked;
            
            if (isClicked.countStart == 1) { // 출근 찍은 경우
                $("button#startBtn").attr("disabled", true);
                isStartWorkClicked = true;
            }
            if (isClicked.countEnd == 1) { // 퇴근 찍은 경우
                $("button#endBtn").attr("disabled", true);
                isEndWorkClicked = true;
            }
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
    // 출퇴근 관련(2) 끝 by 혜림  <<< //


}); // end of $(document).ready(function(){} --------------



$(document).mouseup(function(e) {
    if ($(".header-form-popup").has(e.target).length === 0) {
        $(".header-form-popup").hide();
    }
});

/* ESC 키 누를시 팝업 닫기 */
$(document).keydown(function(e) {
    //keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;

    if (code == 27) { // 27은 ESC 키번호
        $('.header-form-popup').hide();
    }
});

$(document).mouseup(function(e) {
    if ($(".layer_pop").has(e.target).length === 0) {
        $(".layer_pop").hide();
    }
});

/* ESC 키 누를시 팝업 닫기 */
$(document).keydown(function(e) {
    //keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;

    if (code == 27) { // 27은 ESC 키번호
        $('.layer_pop').hide();
    }
});

function openChatTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

function openAlarmTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}



function OpenOrganizationForm() {
    document.getElementById("myForm").style.display = "block";
}

function closeForm() {
    document.getElementById("myForm").style.display = "none";
}

function OpenChatForm() {
    document.getElementById("myForm2").style.display = "block";
}

function closeForm2() {
    document.getElementById("myForm2").style.display = "none";
}

function OpenMyMenu() {
    document.getElementById("myForm").style.display = "block";

}

function OpenAlarmForm() {
    document.getElementById("myForm3").style.display = "block";
}

function closeForm3() {
    document.getElementById("myForm3").style.display = "none";
}

function OpenMyinfoForm() {
    document.getElementById("myForm4").style.display = "block";
}

function closeForm4() {
    document.getElementById("myForm4").style.display = "none";
}

function myProfileCard() {
    //document.getElementById("myForm4").style.display = "none";
    document.getElementById("myProfileCard").style.display = "block";

}


function myProfileCard2() {
    //document.getElementById("myProfileCard").style.display = "none"; 
    //$("div.myProfileCard2").empty();
    $('#myProfileCard').modal('hide');

}

//================================ ●●● 로그인한 유저 정보 불러오기 ●●●================================//
function getUserInfo() {

    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
    //alert("나와봐"+pk_empnum);


    $.ajax({
        url: "<%=ctxPath%>/getUserInfo.groovy",
        data: {
            "pk_empnum": pk_empnum
        },
        type: "GET",
        dataType: "JSON",
        success: function(json) {
            //		alert(json.emppicturename);
            const imgUrl = "<%=ctxPath %>/resources/images/프로필사진/" + json.emppicturename;
            //$("#empImg").attr("src", imgUrl);
            $("img.userimg").attr("src", imgUrl);
            //	alert("나와"+json.pk_empnum);
            $("td#td_pk_empnum").html(json.pk_empnum);
            $("td#td_name").html(json.name);
            $("td#td_birthday").html(json.birthday);

            if (json.gender == 1) {
                $("td#td_gender").html("남자");
            } else {
                $("td#td_gender").html("여자");
            }

            //	$("td#td_address").html("("+json.postcode+") "+json.address+"&nbsp;"+json.detailaddress);
            $("span#my_postcode").html(json.postcode);
            $("span#my_address").html(json.address)
            $("span#my_detailAddress").html(json.detailaddress);
            $("span#my_extraAddress").html(json.extraaddress);

            $("span#span_phone").html(json.phone);
            $("td#td_phone").html(json.phone);

            $("span#span_email").html(json.email);
            $("td#td_email").html(json.email);

            // 부서 직위
            /*		$("span#m_deptnamekor").html(json.deptnamekor);
            		$("span#m_spotnamekor").html(json.spotnamekor);
            		
            		$("span#m_startday").html(json.startday);
            		
            	
            		$("span#m_salary").html(json.salary.toLocaleString('en'));
            	*/

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    }); // end of $.ajax 
}

//================================ ●●● 연락처 수정 ●●●================================//
function mobileEdit(pk_empnum) {
    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";

    const origin_myphone = $("#td_phone").html();
    //alert("testorigin:"+ origin_myphone);
    const myphone = $("#td_phone").text();
    //alert("test1:"+myphone); 

    $("a#btn_mobileEdit").hide(); // "후기수정" 글자 감추기
    $('input[name=myphone]').attr('value', myphone);
    // "후기수정" 을 위한 엘리먼트 만들기 
    let html = "<input id='edit_textarea' type='text' val='' name='myphone' required placeholder='연락처' style='height: 25px; width: 200px'/>";
    html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_OK' onclick='isExistEmailCheck()'><span>확인</span></button></div>";
    html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_NO'><span>취소</span></button></div>";

    // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  

    $("#td_phone").html(html);
    $('input[name=myphone]').attr('value', myphone);
    // 수정취소 버튼 클릭시 
    $("button#btnPhoneUpdate_NO").click(function() {
        $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기  
        $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
    });

    // 수정완료 버튼 클릭시 
    $("button#btnPhoneUpdate_OK").click(function() {
        alert(pk_empnum); // 수정할 사원 번호 
        alert($('input[name=myphone]').val()); // 수정할 제품후기 내용
        const new_phone = $('input[name=myphone]').val();

        $.ajax({
            url: "<%= ctxPath%>/myPhoneEditEnd.groovy",
            type: "POST",
            data: {
                "pk_empnum": pk_empnum,
                "myphone": $('input[name=myphone]').val()
            },
            dataType: "JSON",
            success: function(json) { // {"n":1} 또는 {"n":0}
                if (json.isSuccess) {
                    alert("변경되었습니다.")
                    $("#td_phone").html(new_phone);
                    $("span#span_phone").html(new_phone);
                    $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
                } else {
                    alert("수정이 실패되었습니다.");
                    $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기
                    $("span#span_phone").html(origin_myphone);
                    $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });

} //end of function mobileEdit(pk_empnum){}---------------------------- 


//================================ ●●● 이메일 수정 ●●●================================//
function emailEdit(pk_empnum) {

    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";

    const origin_myemail = $("#td_email").html();
    //alert("testorigin:"+ origin_myphone);
    const myemail = $("#td_email").text();
    //alert("test1:"+myphone); 

    $("a#btn_emailEdit").hide(); // "후기수정" 글자 감추기
    $('input[name=myemail]').attr('value', myemail);
    // "후기수정" 을 위한 엘리먼트 만들기 
    let html = "<form name='editFrm' class='editFrm'><input id='edit_textarea' type='email' val='' name='myemail'  required placeholder='이메일' style='height: 25px; width: 200px'/><span id='emailCheck' class='error' style='color: red; font-size: 12px;'>올바른 이메일 형식이 아닙니다.</span>";
    html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_OK'><span>확인</span></button></div>";
    html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnEmailUpdate_NO'><span>취소</span></button></div></form>";

    // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  

    $("#td_email").html(html);
    $('input[name=myemail]').attr('value', myemail);
    $('span#emailCheck').hide();

    //isExistEmailCheck();
    //////////

    // 아이디가 email 제약 조건 
    $("input#edit_textarea").blur(() => {
        const $target = $(event.target);

        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
        // 이메일 정규표현식 객체 생성

        const bool = regExp.test($target.val());

        if (!bool) { // !bool == false 이메일이 정규표현식에 위배된 경우
            // 입력하지 않거나 공백만 입력했을 경우

            //	$target.next().show();
            // 	또는
            $target.parent().find(".error").show();

        } else {
            // bool == true 이메일이 정규표현식에 맞는 경우
            //	$target.next().hide();
            // 	또는
            $target.parent().find(".error").hide();
        }
    });
    ////////////

    // 수정취소 버튼 클릭시 
    $("button#btnEmailUpdate_NO").click(function() {
        $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기  
        $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
    });

    // 수정완료 버튼 클릭시 
    $("button#btnEmailUpdate_OK").click(function() {
        //     alert(pk_empnum); // 수정할 사원 번호 
        //    alert($('input[name=myemail]').val()); // 수정할 제품후기 내용
        const new_email = $('input[name=myemail]').val();

        // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
        let flagBool = false;

        $("input[name=myemail]").each((index, item) => {
            const data = $(item).val().trim();
            if (data == "") {
                flagBool = true;
                return false;
                /*
                   for문에서의 continue; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return true; 이고,
                   for문에서의 break; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return false; 이다.
                */
            }
        });

        if (flagBool) {
            alert("필수입력란은 모두 입력하셔야 합니다.");
            return; // 종료
        }


        const $target = $("input#edit_textarea");

        // 이메일 정규표현식 객체 생성
        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);

        const bool = regExp.test($target.val());

        if (!bool) { // 이메일 정규표현식에 위배시
            $("form.editFrm :input").prop("disabled", true);
            $target.prop("disabled", false);

            $target.next().show();
            $target.focus();
            //$("span#emailCheck").show();

            b_flagemailduplicateClick = false;
        } else { // 이메일정규표현식에 통과시
            $("form.registerFrm :input").prop("disabled", false);
            $target.next().hide();

            b_flagemailduplicateClick = true;

            $.ajax({
                url: "<%= ctxPath%>/empDuplicatedCheck.groovy",
                data: {
                    "checkColumn": "email",
                    "checkValue": $target.val()
                },
                success: function(text) {

                    const json = JSON.parse(text); // JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환

                    // 이메일 중복검사 결과가 -> true 면 중복된거고, false 면 중복안된것


                    if (json.isDuplicatedInfoVal) { // 중복인경우

                        // 세션에 올라온 email 과 입력해준 email 이 같은 경우 (즉, 이메일을 새로이 변경하지 않고 그대로 사용할 경우)
                        if (origin_myemail == $("input#edit_textarea").val()) {
                            alert($("input#edit_textarea").val() + " 은 사용가능합니다");
                            emailEditEnd(new_email);

                        } else {
                            // 이메일을 새로이 변경한 경우인데 입력한 email 이 이미 사용중 이라면
                            alert($("input#edit_textarea").val() + " 은 이미 사용중이므로 사용불가 합니다.");
                            $("input#edit_textarea").val("");

                        }

                    } else { // 중복아닌경우
                        $("span#emailCheck").html($("input#edit_textarea").val() + " 은 사용가능한 이메일입니다").css("color", "green");
                        emailEditEnd(new_email);

                    }
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            }); // end of ajax
        }


    });



    function emailEditEnd(new_email) {

        $.ajax({
            url: "<%= ctxPath%>/myEmailEditEnd.groovy",
            data: {
                "pk_empnum": pk_empnum,
                "myemail": $('input[name=myemail]').val()
            },
            dataType: "JSON",
            success: function(json) {

                //  const json = JSON.parse(text); // JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환

                if (json.isSuccess) {
                    alert("변경되었습니다.")
                    $("#td_email").html(new_email);
                    $("span#span_email").html(new_email);
                    $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 

                } else {
                    alert("수정이 실패되었습니다.");
                    $("#td_email").html(origin_myemail); // 원래의 제품후기 엘리먼트로 복원하기
                    $("span#span_email").html(origin_myemail);
                    $("a#btn_emailEdit").show(); // "후기수정" 글자 보여주기 
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);

            }
        }); // end of ajax
    }

} //end of function emailEdit(pk_empnum){}------------------

//이메일 중복여부 검사하기
// 2. 이메일 입력칸 유효성검사 및 중복검사
/* function isExistEmailCheck() { */
$("img#emailCheck").click(function() {
    const $target = $("input#edit_textarea");

    // 이메일 정규표현식 객체 생성
    const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);

    const bool = regExp.test($target.val());

    if (!bool) { // 이메일 정규표현식에 위배시
        $("form.editFrm :input").prop("disabled", true);
        $target.prop("disabled", false);

        $target.next().show();
        $target.focus();
        $("span#emailcheck").html("");

        b_flagemailduplicateClick = false;
    } else { // 이메일정규표현식에 통과시
        $("form.registerFrm :input").prop("disabled", false);
        $target.next().hide();

        b_flagemailduplicateClick = true;

        $.ajax({
            url: "<%= ctxPath%>/empDuplicatedCheck.groovy",
            data: {
                "checkColumn": "email",
                "checkValue": $target.val()
            },
            success: function(text) {

                const json = JSON.parse(text); // JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환

                // 이메일 중복검사 결과가 -> true 면 중복된거고, false 면 중복안된것
                if (json.isDuplicatedInfoVal) { // 중복인경우
                    alert($("input#edit_textarea").val() + " 은 이미 사용중인 이메일입니다");
                    $("input#edit_textarea").val("");
                } else { // 중복아닌경우
                    alert($("input#edit_textarea").val() + " 은 사용가능한 이메일입니다");
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        }); // end of ajax
    }
}); // end of $("img#empnumCheck").click(function(){



//================================ ●●● 주소 수정 ●●●================================//
function addressEdit(pk_empnum) {

    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
    const origin_addr = $("#td_address").html();
    //alert("testorigin:"+ origin_addr);
    const origin_mypostcode = $("span#my_postcode").html();
    const origin_myaddress = $("span#my_address").html();
    const origin_myetailAddress = $("span#my_detailAddress").html();
    const origin_myextraAddress = $("span#my_extraAddress").html();
    //alert("testorigin:"+ origin_myaddress);

    const mypostcode = $("span#my_postcode").text();
    const myaddress = $("span#my_address").text();
    const mydetailAddress = $("span#my_detailAddress").text();
    const myextraAddress = $("span#my_extraAddress").text();
    //alert("mypostcode:"+mypostcode);

    $("a#btn_addressEdit").hide(); // "후기수정" 글자 감추기

    // "후기수정" 을 위한 엘리먼트 만들기 
    let html = "<tr><td style='border: 0px;'><input id='edit_postcode'      class='addr'   type='text' val='' name='mypostcode' size='6' maxlength='5' required placeholder='우편번호' style='height: 25px; width: 200px'/></td><td style='border: 0px;'><img id='zipcodeSearch' src='<%=ctxPath %>/resources/images/common/b_zipcode.gif' style='vertical-align: middle;' /></td></tr>" +
        "<tr><td style='border: 0px;'><input id='edit_address'       class='addr'   type='text' val='' name='myaddress'  maxlength='20' size='40' required placeholder='주소' style='height: 25px; width: 200px'/></td>" +
        "<td style='border: 0px;'><input id='edit_detailAddress' class='addr'   type='text' val='' name='mydetailAddress'  size='40' required placeholder='상세주소'  style='height: 25px; width: 200px'/></td></tr>" +
        "<tr><td style='border: 0px;'><input id='edit_extraAddress'                 type='text' val='' name='myextraAddress'  size='40' required placeholder='추가주소' style='height: 25px; width: 200px'/></td>";
    html += "<td style='border: 0px;'><div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnAddrUpdate_OK'><span>확인</span></button></div>";
    html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnAddrUpdate_NO'><span>취소</span></button></div></td></tr>";

    // 수정 버튼 누르면 뜰 input 태그들에 값 넣어주기
    $("#td_address").html(html);
    $('input[name=mypostcode]').attr('value', mypostcode);
    $('input[name=myaddress]').attr('value', myaddress);
    $('input[name=mydetailAddress]').attr('value', mydetailAddress);
    $('input[name=myextraAddress]').attr('value', myextraAddress);

    //우편 번호 찾기 선택 시 
    $("img#zipcodeSearch").click(function() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("edit_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("edit_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('edit_postcode').value = data.zonecode;
                document.getElementById("edit_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("edit_detailAddress").focus();
            }
        }).open();

    });


    // 수정취소 버튼 클릭시 
    $("button#btnAddrUpdate_NO").click(function() {
        $("#td_address").html(origin_addr); // 원래의 제품후기 엘리먼트로 복원하기  
        $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
    });

    // 수정완료 버튼 클릭시 
    $("button#btnAddrUpdate_OK").click(function() {
        //alert(pk_empnum); // 수정할 사원 번호 
        //alert($('input[name=mypostcode]').val()); // 수정할 제품후기 내용
        const new_postcode = $('input[name=mypostcode]').val();
        const new_address = $('input[name=myaddress]').val();
        const new_detailAddress = $('input[name=mydetailAddress]').val();
        const new_extraAddress = $('input[name=myextraAddress]').val();


        // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
        let flagBool = false;

        $("input.addr").each((index, item) => {
            const data = $(item).val().trim();
            if (data == "") {
                flagBool = true;
                return false;
                /*
                   for문에서의 continue; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return true; 이고,
                   for문에서의 break; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return false; 이다.
                */
            }
        });

        if (flagBool) {
            alert("필수입력란은 모두 입력하셔야 합니다.");
            return; // 종료
        }

        $.ajax({
            url: "<%= ctxPath%>/myAddressEditEnd.groovy",
            type: "POST",
            data: {
                "pk_empnum": pk_empnum,
                "mypostcode": $('input[name=mypostcode]').val(),
                "myaddress": $('input[name=myaddress]').val(),
                "mydetailAddress": $('input[name=mydetailAddress]').val(),
                "myextraAddress": $('input[name=myextraAddress]').val()
            },
            dataType: "JSON",
            success: function(json) { // {"n":1} 또는 {"n":0}
                if (json.isSuccess) {
                    alert("변경되었습니다.")
                    $("#td_address").html(origin_addr);
                    $("span#my_postcode").html(new_postcode); // 수정된 엘리먼트 넣기
                    $("span#my_address").html(new_address);
                    $("span#my_detailAddress").html(new_detailAddress);
                    $("span#my_extraAddress").html(new_extraAddress);
                    $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
                } else {
                    alert("수정이 실패되었습니다.");
                    $("#td_address").html(origin_addr); // 원래의 제품후기 엘리먼트로 복원하기  
                    $("a#btn_addressEdit").show(); // "후기수정" 글자 보여주기 
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });

} //end of function addressEdit(pk_empnum){}------------------------




//================================ ●●● 비밀번호 수정 ●●●================================//
function pwdEdit(pk_empnum) {

    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
    var loginpwd = "${sessionScope.loginuser.pwd}";
    const origin_mypwd = $("#td_pwd").html();

    $("a#btn_pwdEdit").hide(); // "비밀번호 수정" 글자 감추기

    // "비번수정" 을 위한 엘리먼트 만들기 
    let html = "<table><tr class=''>비밀번호는 8~16자의 영문 대소문자,숫자,특수문자를  포함해야 합니다.</tr><tr>";
    html += "<th style='border: 0px;'><label for='originpwd'>현재 비밀번호&nbsp;<span id='star'>*</span></label></th>";
    html += "<td style='border: 0px;'><input type='password' class='requiredInfo' id='originpwd' name='originpwd' size='20' maxlength='20' required placeholder='비밀번호를 입력해주세요' /><span class='error'  style='color: red;'>암호가 올바르지 않습니다.</span></td>";
    html += "</tr>";
    html += "<th style='border: 0px;'><label for='mypwd'>비밀번호&nbsp;<span id='star'>*</span></label></th>";
    html += "<td style='border: 0px;'><input type='password' class='requiredInfo' id='mypwd' name='mypwd' size='20' maxlength='20' required placeholder='비밀번호를 입력해주세요' /><span class='error' style='color: red;'>암호가 올바르지 않습니다.</span></td>";
    html += "</tr>";
    html += "<tr>";
    html += "<th style='border: 0px;'><label class='title' for='pwdcheck'>비밀번호확인&nbsp;<span id='star'>*</span></label></th>";
    html += "<td style='border: 0px;'><input type='password' class='requiredInfo' id='pwdCheck' size='20' maxlength='20' required placeholder='비밀번호를 다시 입력해주세요'  /><span class='error' style='color: red;' >암호가 일치하지 않습니다.</span></td>";
    html += "</tr></table>";
    html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPwdUpdate_OK'><span>확인</span></button></div>";
    html += "<div style='display: inline-block; float:right;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPwdUpdate_NO'><span>취소</span></button></div>";

    // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  

    $("#td_pwd").html(html);

    $("span.error").hide();
    /*
	     // 아이디가 originpwd 제약 조건 
	    	$("input#originpwd").blur(() => {
	 	   		const $target = $(event.target);
	 	   		
	 	   		const originpwd = $target.val();
	 	   		
	 	   		
	 	   		ㅇ
	 	 	  	if(originpwd != loginpwd){ // 기존암호 확인값이 다른 경우
	 	   			$target.prop("disabled",false);
	 	   			$("input#originpwd").prop("disabled",false);
	 	   			
	 	   		//	$target.next().show();
	 	   		// 	또는
	 	   			$target.parent().find(".error").show();
	 	   			
	 	   		} else {
	 	   			// 암호와 암호확인값이 같은 경우
	 	   			//	$target.next().hide();
	 	   			// 	또는
	 	   			$target.parent().find(".error").hide();
	 	   		}
	 	   	}); 
	      */

    // 아이디가 pwd 제약 조건 
    $("input#mypwd").blur(() => {
        const $target = $(event.target);

        const regExp = new RegExp(/^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
        // 영어대/소문자 , 숫자, 특수기호를 모두 사용한 8글자 이상 16자 이하로 구성된 정규표현식

        const bool = regExp.test($target.val());

        if (!bool) { // !bool == false 암호가 정규표현식에 위배된 경우
            // 입력하지 않거나 공백만 입력했을 경우
            $target.prop("disabled", false);
            //	$target.next().show();
            // 	또는
            $target.parent().find(".error").show();

        } else {
            // bool == true 암호가 정규표현식에 맞는 경우
            $target.parent().find(".error").hide();
        }

    });

    // 아이디가 pwdcheck 제약 조건 패스워드 확인 검사
    $("input#pwdCheck").blur(() => {
        const $target = $(event.target);
        const mypwd = $("input#mypwd").val();
        const pwdcheck = $target.val();

        if (pwdcheck != mypwd) { // 암호와 암호확인값이 다른 경우 
            $target.prop("disabled", false);
            $("input#mypwd").prop("disabled", false);

            //	$target.next().show();
            // 	또는
            $target.parent().find(".error").show();

        } else {
            // 암호와 암호확인값이 같은 경우
            //	$target.next().hide();
            // 	또는
            $target.parent().find(".error").hide();
        }
    });

    // $('input[name=myemail]').attr('value',myemail);
    // 수정취소 버튼 클릭시 
    $("button#btnPwdUpdate_NO").click(function() {
        $("#td_pwd").html(origin_mypwd); // 원래의 제품후기 엘리먼트로 복원하기  
        $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
    });

    // 수정완료 버튼 클릭시 
    $("button#btnPwdUpdate_OK").click(function() {
        alert(pk_empnum); // 수정할 사원 번호 
        alert($('input[name=mypwd]').val()); // 수정할 제품후기 내용
        const new_pwd = $('input[name=mypwd]').val();



        // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
        let flagBool = false;

        $("input.requiredInfo").each((index, item) => {
            const data = $(item).val().trim();
            if (data == "") {
                flagBool = true;
                return false;
                /*
                   for문에서의 continue; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return true; 이고,
                   for문에서의 break; 와 동일한 기능을 하는것이 
                   each(); 내에서는 return false; 이다.
                */
            }
        });

        if (flagBool) {
            alert("필수입력란은 모두 입력하셔야 합니다.");
            return; // 종료
        }



        $.ajax({
            url: "<%= ctxPath%>/myPwdEditEnd.groovy",
            type: "POST",
            data: {
                "pk_empnum": pk_empnum,
                "originpwd": $('[name=originpwd]').val(),
                "mypwd": $('[name=mypwd]').val()
            },
            dataType: "JSON",
            success: function(json) { // {"n":1} 또는 {"n":0}
                if (json.isSuccess) {
                    alert("변경되었습니다.")
                    $("#td_pwd").html(origin_mypwd); // 원래의 제품후기 엘리먼트로 복원하기  
                    $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
                } else {
                    alert("수정이 실패되었습니다.");
                    $("#td_pwd").html(origin_mypwd); // 원래의 제품후기 엘리먼트로 복원하기  
                    $("a#btn_pwdEdit").show(); // "후기수정" 글자 보여주기 
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });

} //end of function pwdEdit(pk_empnum){}------------------


//================================ ●●● 연락처 수정 ●●●================================//
function mobileEdit(pk_empnum) {
    var pk_empnum = "${sessionScope.loginuser.pk_empnum}";

    const origin_myphone = $("#td_phone").html();
    //alert("testorigin:"+ origin_myphone);
    const myphone = $("#td_phone").text();
    //alert("test1:"+myphone); 

    $("a#btn_mobileEdit").hide(); // "후기수정" 글자 감추기
    $('input[name=myphone]').attr('value', myphone);
    // "후기수정" 을 위한 엘리먼트 만들기 
    let html = "<tr><td style='border: 0px;'><input id='edit_textarea' type='text' val='' name='myphone' required placeholder='연락처' style='height: 25px; width: 200px'/></td>";
    html += "<td style='border: 0px;'><div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_OK'><span>확인</span></button></div>";
    html += "<div style='display: inline-block;  font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnPhoneUpdate_NO'><span>취소</span></button></div></td></tr>";

    // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  

    $("#td_phone").html(html);
    $('input[name=myphone]').attr('value', myphone);
    // 수정취소 버튼 클릭시 
    $("button#btnPhoneUpdate_NO").click(function() {
        $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기  
        $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
    });

    // 수정완료 버튼 클릭시 
    $("button#btnPhoneUpdate_OK").click(function() {
        alert(pk_empnum); // 수정할 사원 번호 
        alert($('input[name=myphone]').val()); // 수정할 제품후기 내용
        const new_phone = $('input[name=myphone]').val();

        $.ajax({
            url: "<%= ctxPath%>/myPhoneEditEnd.groovy",
            type: "POST",
            data: {
                "pk_empnum": pk_empnum,
                "myphone": $('input[name=myphone]').val()
            },
            dataType: "JSON",
            success: function(json) { // {"n":1} 또는 {"n":0}
                if (json.isSuccess) {
                    alert("변경되었습니다.")
                    $("#td_phone").html(new_phone);
                    $("span#span_phone").html(new_phone);
                    $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
                } else {
                    alert("수정이 실패되었습니다.");
                    $("#td_phone").html(origin_myphone); // 원래의 제품후기 엘리먼트로 복원하기
                    $("span#span_phone").html(origin_myphone);
                    $("a#btn_mobileEdit").show(); // "후기수정" 글자 보여주기 
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

    });

} //end of function updateMyReview(index, review_seq){}----------------------


function uploadFile(pk_empnum) {
    var form = $('#FILE_FORM')[0];
    var formData = new FormData(form);
    formData.append("fileObj", $("#input-file")[0].files[0]);

    $.ajax({
        url: "<%= ctxPath%>/myphotoEdit.groovy",
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(result) {
            alert("업로드 성공!!");
        }
    });

    var options = {
        dataType: "text", //결과
        success: function(responseText) {
            alert("업로드 성공!!");
        },
        error: function(e) {
            e.responseText();
        }
    };


    $("#FILE_FORM").ajaxForm(options).submit();
}


// 출퇴근 관련(3) 시작 by 혜림  <<< //
function startwork() {

    $.ajax({
        url: "<%=ctxPath%>/startWork.groovy",
        data: {
            "pk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        type: "POST",
        dataType: "JSON",
        success: function(json) {

            $.ajax({
                url: "<%=ctxPath%>/isClickedStartBtn.groovy",
                data: {
                    "pk_empnum": "${sessionScope.loginuser.pk_empnum}"
                },
                type: "POST",
                dataType: "JSON",
                success: function(json) {
                    	alert(json.isClicked);
                    	const isClicked = json.isClicked;
                    // 출근버튼 찍었으면 출근버튼 비활성화
                    if (isClicked.countStart == 1) { // 출근 찍은 경우
                        $("button#startBtn").attr("disabled", true);
                        isStartWorkClicked = true;
                    }
                    if (isClicked.countEnd == 1) { // 퇴근 찍은 경우
                        $("button#endBtn").attr("disabled", true);
                        isEndWorkClicked = true;
                    }

                    let today = new Date();

                    let hours = today.getHours(); // 시
                    let minutes = today.getMinutes(); // 분
                    let seconds = today.getSeconds(); // 초
                    //let milliseconds = today.getMilliseconds(); // 밀리초
                    //let html = hours + ':' + minutes + ':' + seconds + ':' + milliseconds;

                    if (Number(hours) < 10) {
                        hours = "0" + hours;
                    }
                    if (Number(minutes) < 10) {
                        minutes = "0" + minutes;
                    }
                    if (Number(seconds) < 10) {
                        seconds = "0" + seconds;
                    }
                    let html = hours + ':' + minutes + ':' + seconds;



                    $("#time_startwork").html(html);

                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });

            // 출근 시각에 대한 근태체크
            startCommuteCheck();

        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
    startClock();
    //document.getElementById("start").onclick();
}


function startCommuteCheck() {

    $.ajax({
        url: "<%=ctxPath%>/checkStartCommuteStatus.groovy",
        data: {
            "pk_empnum": "${sessionScope.loginuser.pk_empnum}"
        },
        type: "POST",
        dataType: "JSON",
        success: function(json) {
            // 현재 넘어오는 값 없음
        },
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

}

function endwork() {

    if (isStartWorkClicked == false) { // 출근 버튼을 아직 안누른 상태라면
        alert("출근을 먼저 해주세요");
        return false;

    } else { // 출근 버튼을 누른 경우
        // 자 이제 퇴근합시다

        $.ajax({
            url: "<%=ctxPath%>/endWork.groovy",
            data: {
                "pk_empnum": "${sessionScope.loginuser.pk_empnum}"
            },
            type: "POST",
            dataType: "JSON",
            success: function(json) {
                // 현재 넘어오는 값 없음
                let today = new Date();

                let hours = today.getHours(); // 시
                let minutes = today.getMinutes(); // 분
                let seconds = today.getSeconds(); // 초
                //let milliseconds = today.getMilliseconds(); // 밀리초

                //let html = hours + ':' + minutes + ':' + seconds + ':' + milliseconds;
                if (Number(hours) < 10) {
                    hours = "0" + hours;
                }
                if (Number(minutes) < 10) {
                    minutes = "0" + minutes;
                }
                if (Number(seconds) < 10) {
                    seconds = "0" + seconds;
                }
                let html = hours + ':' + minutes + ':' + seconds;
                $("#time_endwork").html(html);

            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

        // 퇴근 또 못찍게 버튼 막기
        $("button#endBtn").attr("disabled", true);

    }
    stopClock();
    //document.getElementById("stop").onclick();
}


function printTime() {
    time++;
    stopwatch.innerText = getTimeFormatString();
}

//시계 시작 - 재귀호출로 반복실행
function startClock() {
    printTime();
    stopClock();
    timerId = setTimeout(startClock, 1000);
}

//시계 중지
function stopClock() {
    if (timerId != null) {
        clearTimeout(timerId);
    }
}

// 시간(int)을 시, 분, 초 문자열로 변환
function getTimeFormatString() {
    hour = parseInt(String(time / (60 * 60)));
    min = parseInt(String((time - (hour * 60 * 60)) / 60));
    sec = time % 60;

    return String(hour).padStart(2, '0') + ":" + String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
}
// 출퇴근 관련(3) 끝 by 혜림  <<< //


		
		
	
</script>
 
 
<!-- 사이드바 시작 -->
<div class="sidenav" style="background-color:#2c2a34; ">

    <div align="center" class="mainlogo borderline" style=" color:white;  border-bottom: solid 0.8px #595959; "><a href="<%=ctxPath%>/index.groovy"><img src="<%= ctxPath%>/resources/images/common/로고그루비.png" alt="로고" /></a></div>

    <table class="tableMyinfo" style="border-bottom: solid 0.8px #595959; width: 100%; height: 85px; ">
        <tr>
            <td rowspan="2" style="padding-left: 20px; width: 45%;">
                <a class="iconbar" onclick="OpenMyinfoForm()" type="button"><img class="myprofile-photo" style="width: 60px; height: 60px;" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}" alt="icon-myprofile" /></a>
            </td>
            <td style="font-size: 18px; padding-top: 5px;">
                <span class="dept" style="color: #f1f1f1;">
                    <c:choose>
                        <c:when test="${sessionScope.loginuser.deptnamekor eq '임원'}">${sessionScope.loginuser.deptnamekor}진</c:when>
                        <c:when test="${sessionScope.loginuser.deptnamekor ne '임원'}">${sessionScope.loginuser.deptnamekor}부</c:when>
                    </c:choose>
                </span>
                <span class="spot" style="color: #f1f1f1;">
                    ${sessionScope.loginuser.spotnamekor}
                </span>
            </td>
        </tr>
        <tr>
            <td style="padding-bottom: 10px;">
                <strong class="user-name" style="color: #f1f1f1; font-size:18px;">${sessionScope.loginuser.name}</strong>
            </td>
        </tr>
    </table>

    <div class="timer" style="border-bottom: solid 0.8px #595959; padding: 12px 0 ;">
        <table style="width: 100%">
            <tr>
                <td style="width: 40%">
                    <button id="startBtn" onclick="javascript:startwork('${sessionScope.loginuser.pk_empnum}'); ">출근</button>
                </td>
                <td>
                    <span id="span_start"><span id="time_startwork"></span></span>
                </td>
            <tr>
                <td style="width: 40%">
                    <button id="endBtn" onclick="javascript:endwork('${sessionScope.loginuser.pk_empnum}'); ">퇴근</button>
                </td>
                <td>
                    <span id="span_end"><span id="time_endwork"></span></span>
                </td>
            <tr>
                <td style="width: 40%; text-align: center;">
                    <span id="span_end" style="margin-left: 20px; top:0;">근무시간</span>
                </td>
                <td>
                    <a id="stopwatch">00:00:00</a>
                </td>
            </tr>
        </table>
    </div>




    <!-- <div style="margin: 15px 25.5px;">
  		<div class="btn_newpjt" ><i class="fas fa-expand"></i>새 프로젝트</div>
  	</div> -->




    <div class="side-header" style="border-bottom: solid 0.8px #595959; padding-bottom: 10px; margin-bottom: 0px">
        <a href="<%=ctxPath%>/scheduleManagement.groovy"><i class="far fa-calendar"></i>스케줄러</a>
        <a href="<%=ctxPath%>/showOneCommuteStatus.groovy"><i class="fas fa-user-clock"></i>내 근태관리</a>
        <a href="<%=ctxPath%>/employeeChart.groovy"><i class="fas fa-network-wired"></i>조직도</a>
        <a class="iconbar" onclick=" OpenOrganizationForm()" type="button" id="organizationTopButton " style="display: inline-block; "><i class="far fa-address-book"></i>사원조회</a>

        <!--   <a href="#contact"><i class="fas fa-ellipsis-v"></i>더보기</a> -->
    </div>


    <ul class="scroll" style="list-style: none; height:max-content; padding: 0  0  3px 0 ; overflow-y:scroll; width:227px;  margin-bottom: 0px; ">
        <!-- 
	  <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#demo"><a style="cursor: pointer; ">모아보기</a></div>
		  <div id="demo" class="collapse">
				<ul class="list" style="list-style: none; ">
					<li>
						<a  href="#"><i class="fas fa-list-ul"></i>전체 업무</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-align-left"></i>간트차트</a>
					</li>
					<li>
						<a href="#"><i class="far fa-calendar"></i>캘린더</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-archive"></i>파일함</a>
					</li>
					<li>
						<a href="#"><i class="far fa-bookmark"></i>북마크</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-at"></i>나를 언급</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-user-edit"></i>내 게시물</a>
					</li>
				</ul>
			</div>
	    </li>
	     -->
        <!--   
	    <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#recent_update"><a style="cursor: pointer; ">최근 업데이트</a></div>
		  <div id="recent_update" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="#"><i class="fas fa-square"></i>공개프로젝트</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>'groovy'업무공유방</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>플로우 이용 가이드</a>
					</li>
					<li>
						<a href="#"><i class="fas fa-square"></i>1:1 문의하기</a>
					</li>
				</ul>
			</div>
	    </li>
	    
	     -->
        <!-- ============================================================================================================== 덕노 -->
        <li class="borderline">
            <div class="accord" data-toggle="collapse" data-target="#myApproval"><a style="cursor: pointer; "><i class="fas fa-balance-scale"></i>결재관리</a></div>
            <div id="myApproval" class="collapse">
                <ul style="list-style: none;">
                    <li>
                        <a href="<%=ctxPath%>/approvalView.groovy"><i class="far fa-file-alt"></i>기안하기</a>
                    </li>

                    <li>
                        <a href="<%=ctxPath%>/myApproval.groovy"><i class="far fa-check-square"></i>내 기안내역 조회</a>
                    </li>

                    <li>
                        <a href="<%=ctxPath%>/waitApproval.groovy"><i class="far fa-file-word"></i>결재 대기 문서</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/endApproval.groovy"><i class="far fa-paper-plane"></i>결재 수신 문서</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/referenceApproval.groovy"><i class="far fa-file"></i>결재 참조 문서</a>
                    </li>

                </ul>
            </div>
        </li>

        <%-- <li class="borderline">
		  <div class="accord" data-toggle="collapse" data-target="#apprver"><a style="cursor: pointer; ">개인 결재 문서함</a></div>
		  <div id="apprver" class="collapse">
				<ul style="list-style: none;">
					<li>
						<a href="<%=ctxPath%>/waitApproval.groovy"><i class="fas fa-tag"></i>결재 대기 문서</a>
        </li>
        <li>
            <a href="<%=ctxPath%>/endApproval.groovy"><i class="fas fa-tag"></i>결재 수신 문서</a>
        </li>
        <li>
            <a href="<%=ctxPath%>/referenceApproval.groovy"><i class="fas fa-tag"></i>참조 문서</a>
        </li>
    </ul>
</div>
</li>
--%>

<!-- ============================================================================================================== 혜림 -->
<c:if test="${sessionScope.loginuser.fk_spotnum == 0 || sessionScope.loginuser.fk_spotnum >= 7}">
<li class="borderline">
    <div class="accord" data-toggle="collapse" data-target="#admin"><a style="cursor: pointer; "><i class="fas fa-user-cog"></i>어드민</a></div>
    <div id="admin" class="collapse">
        <ul style="list-style: none;">
            <li>
                <a href="<%=ctxPath%>/register.groovy"><i class="fas fa-user-plus"></i>사원등록</a>
            </li>
            <li>
                <a href="<%=ctxPath%>/viewEmp.groovy"><i class="fas fa-user-friends"></i>사원정보</a>
            </li>
            <li>
                <a href="<%=ctxPath%>/worktime.groovy"><i class="fas fa-user-clock"></i>근태관리</a>
            </li>
            <li>
                <a href="<%=ctxPath%>/adminApproval.groovy"><i class="fas fa-user-tag"></i>결재관리</a>
            </li>
        </ul>
    </div>
</li>
</c:if>

</ul>


<div style="border-bottom: solid 0.8px #595959;"></div>

<!-- ============================================================================================================== 끝 -->

<!-- 	
	<ul class="borderline side-foot" style="list-style: none; cursor: pointer; padding: 0;">
		<li>
			<a><i class="far fa-address-book"></i>직원초대</a>
		</li>
		<li>
			<a><i class="fas fa-user-cog"></i>어드민</a>
		</li>
	</ul>
	
	 -->


<div class="header-form-popup" id="myForm">
    <article action="" class="header-form-container">
        <div style="padding: 15px 20px; margin-bottom: 6px; font-size: 18px; font-weight:bold;">
            <strong>조직도</strong>
            <button type="button" class="btn cancel" onclick="closeForm()"><i class="fas fa-times icon-search"></i></button>
        </div>
        <div style="display:block;">

            <!-- 조직도 리스트 -->
            <label for="name" style="font-size: 14px; margin-left:20px;"><b>그루비</b></label>
            <div style="display:flex; padding: 0 20px; margin: 10px 0;">
                <form><input id="organizationInput" type="text" class="searchInput all-setup-input-type-1" placeholder="이름, 소속, 전화번호 검색" autocomplete="off" name="name phone deptnamekor" required>
                	  <input type="text" style="display:none;">
                </form>
            </div>

            <!-- 조직도리스트 넣기 -->
            <!-- 3 setup a container element -->
            <div id="jstree" class="scroll" style="width: 100%; padding-bottom: 40px; height: 600px; overflow:auto;  "></div>
        </div>
    </article>
</div>


<!-- ●●● 유저정보 팝업 ●●●================================-->
<div class="myinfo-popup layer_pop" id="myForm4">

    <div class="myinfo-container" style="vertical-align: middle; padding: auto;">

        <ul style="list-style: none; margin:0; padding:0;">
            <li style="display: flex; padding-bottom: 12px; font-size: 16px;" >
                <img class="userimg myprofile-photo" alt="icon-myprofile" style="width: 50px; height: 50px;" />
                <div style="display: inline-block; box-sizing: border-box;">
                    <strong class="user-name" style="font-size: 18px;">${sessionScope.loginuser.name}</strong>
                    <span class="dept">

                        <c:choose>
                            <c:when test="${sessionScope.loginuser.deptnamekor eq '임원'}">${sessionScope.loginuser.deptnamekor}진</c:when>
                            <c:when test="${sessionScope.loginuser.deptnamekor ne '임원'}">${sessionScope.loginuser.deptnamekor}부</c:when>
                        </c:choose>
                    </span>
                    <span class="spot">
                        ${sessionScope.loginuser.spotnamekor}

                    </span>
                </div>

            </li>
            <li class="infoList"><a style="color: #f1f1f1 !important ;" onclick="getUserInfo()" href="" data-toggle="modal" data-target="#myProfileCard"><i class="far fa-user"></i> 내 프로필</a></li>
            <li class="infoList"><a style="color: #f1f1f1 !important ;" href="#" data-toggle="modal" data-target="#myProfileCard2"><i class="fas fa-cog"></i> 환경설정</a></li>
            <li class="infoList"><a style="color: #f1f1f1 !important ;" href="<%=ctxPath%>/logout.groovy"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>

        </ul>

    </div>

</div>
<!-- ●●● 유저정보 팝업 ●●●================================-->


<!-- ●●● 유저정보 팝업 => [유저프로필카드]  ●●●================================-->
<div class="modal animate" id="myProfileCard">
    <div class="modal-dialogs">
        <div class="card" id="headerCard" style="width:400px; display: block; ">

            <div class="card " style="display: block; ">

                <div style=" position: relative; ">
                    <img class="userimg card-img-top rounded" alt="Card image" style="width:100%; height: 350px; overflow: hidden;" />
                    <div class="bottom-left" style="color: white; font-weight:bold; font-size: 18px;">${sessionScope.loginuser.name}</div>
                </div>

                <div class="card-body">
                    <ul style="list-style: none;">
                        <li>
                            <i class="far fa-envelope"></i>
                            <span id="span_email"></span>
                        </li>
                        <li>
                            <i class="fas fa-mobile-alt"></i>
                            <span id="span_phone"></span>
                        </li>
                    </ul>
                </div>

                <div class="btn-probottom">
                    <button class="btn-chat js-btn-chat btn-bottom" style=" cursor: pointer !important; pointer-">
                        채팅
                        <i class="far fa-comments"></i>
                    </button>
                    <button class="btn-modi js-btn-modi btn-bottom" onclick="myProfileCard2()" data-toggle="modal" data-target="#myProfileCard2" style=" cursor: pointer;">
                        정보수정
                        <i class="far fa-address-card"></i>
                    </button>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- ●●● 유저정보 팝업 => 유저프로필카드 => [회원정보수정] ●●●================================-->
<div class="modal" id="myProfileCard2" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; background: rgba(0,0,0,.6); "data-backdrop="false">
    <div class="modal-content animate" style="position: relative; max-width: 850px; min-height: 490px; max-height: 600px; border-radius: 20px; box-shadow: 20px 20px 30px rgb(0 0 0 / 20%);     margin: 0 auto">
        <div class="modal-header" style="background-color: #6449fc;">
            <span style="color: white; font-weight: bold; font-size: 15pt;"><i class="fas fa-id-card-alt"></i>내 정보수정</span>
            <button type="button" class="btn  btn-dark" data-dismiss="modal">Close</button>
        </div>


        <div class="modal-body scroll" style="width: 100%; overflow:auto;  ">
            <form action="<%=ctxPath%>/MyInfoEdit.groovy">

                <!-- <form name="InfoFrm"> -->
                <div>
                    <table id="tbl_myInfo" class="table">
                        <tr>
                            <th style="width: 100px;">사원번호</th>
                            <td id="td_pk_empnum"><span id="span_pk_empnum"></span></td>
                            <td rowspan="4" style="border-left: 1px solid #dee2e6;">
                                <form id="FILE_FORM" method="post" enctype="multipart/form-data" action="<%=ctxPath%>/myphotoEdit.groovy">
                                    <div style="vertical-align: middle;">
                                        <img class="rounded userimg" style="width:150px; height:auto; overflow: hidden;" />
                                        <label href="javascript:uploadFile();" className="input-file-button" for="input-file" type="button" id="emppicturename" name="attach" style="cursor: pointer;"><i class="far fa-edit"></i></label>
                                        <input type="file" id="input-file" style="display : none;" />
                                    </div>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td id="td_name"></td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td id="td_birthday"></td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td id="td_gender"></td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td id="td_address">(<span id="my_postcode"></span>)&nbsp;<span id="my_address"></span>&nbsp;<span id="my_detailAddress"></span>&nbsp;<span id="my_extraAddress"></span></td>
                            <td><a onclick="addressEdit(${sessionScope.loginuser.pk_empnum})" id="btn_addressEdit" type="button"><i class="far fa-edit"></i></a></td>
                        </tr>
                        <tr class="myphone">
                            <th>연락처</th>
                            <td id="td_phone"></td>
                            <td id="myphone2"><a id="btn_mobileEdit" onclick="mobileEdit(${sessionScope.loginuser.pk_empnum})" type="button"><i class="far fa-edit"></i></a></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td id="td_email"></td>
                            <td><a id="btn_emailEdit" onclick="emailEdit(${sessionScope.loginuser.pk_empnum})" type="button"><i class="far fa-edit"></i></a></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td id="td_pwd">
                                <table>
                                    <tr class=''><strong>비밀번호 재설정이 가능합니다.</strong></tr><br />
                                    <tr><span>비밀번호는 8~16자의 영문 대소문자,숫자,특수문자를 포함해야 합니다.</span></tr>
                                </table>
                            </td>
                            <td><a id="btn_pwdEdit" onclick="pwdEdit(${sessionScope.loginuser.pk_empnum})" type="button"><i class="far fa-edit"></i></a></td>
                        </tr>
                        <tr>
                            <th>부서</th>
                            <td>${sessionScope.loginuser.deptnamekor}</td>
                        </tr>
                        <tr>
                            <th>직위</th>
                            <td>${sessionScope.loginuser.spotnamekor}</td>
                        </tr>
                        <tr>
                            <th>입사일자</th>
                            <td>${sessionScope.loginuser.startday}</td>
                        </tr>
                        <tr>
                            <th>월급</th>
                            <td>${sessionScope.loginuser.salary}</td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>



    </div>
</div>
<!-- ●●● 유저정보 팝업 => 유저프로필카드 => [회원정보수정] ●●●================================-->



</div>
 <!-- 상단 네비게이션 끝 --> 
 
 
<script src="<%= ctxPath%>/resources/jstree/dist/jstree.min.js"></script>
<script>

// jstree로  조직도 나타내기

$(function() {
	
	
	
	
	
		    $.ajax({
		       
		        type: "GET",
		        url: "<%= ctxPath%>/getOrganization.groovy",
		        dataType: "json",
		        success: function (json) {
		        	createJSTree(json);
		        },

		        error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
		    });            
 }); //end of $(function() {})---------------

function createJSTree(jsondata) {  
	 
	$('#jstree').bind("loaded.jstree", function (e, data) {
        $('#jstree').jstree("open_all"); //WORKS FINE
    }).jstree({ 
		'themes' : {
			/* 'name' : "default-dark", */
            "theme" : "default", 
            "dots" : false,
           /*  "icon" : false  */
		},
		'plugins' : ["wholerow","search", "themes","types"],
		 "types" : {
             "default": {
                 <%-- "icon" :"<%= ctxPath%>/resources/images/common/로고그루비.png" 
                 <!--icon을 원하는 이미지로 만들때--> --%>
             }
         },

		'core' : {
		    'data' :  jsondata
		},
		
		 'search': {
			 show_only_matches: true,
		     search_callback: function (searchString, node) {
		            if (node.parent != "#" && node.text.toUpperCase().includes(searchString.toUpperCase()) == true) {
		                return node;
		            }
		        }
		 }
		
	
	});
	
	 var to = false; $('#organizationInput').keyup(function () { if(to) { clearTimeout(to); } to = setTimeout(function () { var v = $('#organizationInput').val(); $('#jstree').jstree(true).search(v); }, 250); });
	 
} //end of function createJSTree(jsondata) { }--------------


</script>