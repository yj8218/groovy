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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>

<!-- css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
 
<!-- js -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script> -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=234c62ec75f13db891af0691bfcdc606&libraries=services"></script>
	
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


div.modal-header {
    position: relative;
    height: 30px;
    padding: 3px 20px;
    margin-top: 13px;
    border-bottom: 0;
}


div.modal-header h5.modal-title{
    float: left;
    font-size: 16px;
    color: #333;
    
}


div.modal-header button.close {
    position: absolute;
    top: -5px;
    right: 20px;
}
div.modal-header button.close span {

font-family: icon-contents!important;
    font-style: normal;
    font-weight: 400;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    color: #333;
    
    font-size: 30px;
}

div.text-center table, div.text-center table td {
border: 0;
}

div.text-center {

padding-right: 40px;
}


div.text-center td:first-child {
 
    font-size: 16px;
    color: #333;
    padding: 5px 10px;
    width: 20%;
    height: 40px;
    vertical-align: middle;
    text-align: left;
    font-weight: 500;
    
}


div.text-center td:last-child {

    font-size: 16px;
    color: #333;
    padding: 5px 10px;
     width: 80%;
    height: 40px;
    vertical-align: middle;
    text-align: left;
   
}

div.text-center td:last-child input {

   width: 60%;
   border: 0;
   
}

div.text-center td:last-child input:hover, div.text-center td:last-child input:active {
outline: 0;
border-bottom: 1px solid #6449fc; 
   
}
div.text-center td:last-child input:not(:hover) {
outline: 0;
}

div.modal-footer {
border-top: 0;
    padding-right: 20px;


}

div.modal-footer button.btn {
/* position: relative;
    float: left; */
    height: 30px;
    width: 100px;
    padding: 0 20px;
    margin-left: 10px;
    background: #6449fc;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    font-size: 13px;
    color: #fff;
    text-align: center;
    border: 0;
}
div.modal-footer button.btn.modal_close{
background: #ff4444;
}



div#modal_addSchedule div.modal-body{
padding: 0;
margin: 0;
}

div#modal_addSchedule div.modal-content{
    position: relative;
    right: 20%;
    z-index: 5;
    width: 674px;
    margin: 30px auto 0 auto;
    background: #fff;
    box-sizing: border-box;
    box-shadow: 20px 20px 30px rgb(0 0 0 / 20%);
    border-radius: 10px;
}


div#modal_addSchedule form.scheduleFrm > div:first-child{
padding-right: 30px;
padding-left: 30px;
}

div#modal_addSchedule div.modal-content input.subject{
height: 62px;
    padding-top: 20px;
   width: 100%;
    padding-bottom: 15px;
    font-size: 18px;
    border-bottom: 1px solid #eee !important;
    resize: none;
    overflow-y: hidden;
        border-radius: 0;
    border: 0;
        line-height: normal;
    margin: 0;
 
    color: #6449fc;
  
}

div#modal_addSchedule input.subject:hover, div#modal_addSchedule input.subject:active, div#modal_addSchedule input.subject:not(:hover){
outline: 0;
}

div#modal_addSchedule i.icon-calendar{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-calendar.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}

div#modal_addSchedule ul div {
 display: inline-block;
 position: relative; 
    display: table-cell;
    height: 35px;
    vertical-align: middle;
    color: #333;
    text-align: left;
    font-size: 15px;
}
div#modal_addSchedule ul div.title{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
    width: 20px;
    padding: 7px 20px 0 0;
    color: #555;
    font-weight: 700;
    font-size: 14px;
}


div#modal_addSchedule ul {
margin: 0;
padding: 30px;
}
div#modal_addSchedule ul li{
display: table;
    width: 100%;
    table-layout: fixed;
    margin-bottom: 11px;
}
div#modal_addSchedule  input.selectDay{
border: 0;
width: 260px;
padding: 5px 2px;
margin-right: 12px;
border-bottom: 1px solid #555;
font-size: 15px;
-webkit-box-sizing: border-box;
-moz-box-sizing: border-box;
box-sizing: border-box;
cursor: pointer;
background-color: #fff;
}
    
div#modal_addSchedule input{
    border-radius: 0;
    border: 0;
    line-height: normal;
    margin: 0;
    color: #333;
} 


div#modal_addSchedule i.icon-select-calendar{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-select-calendar.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}
 
 
div#modal_addSchedule input#color{
 	width: 20px;
    height: 23.8px;
    background-color: transparent;
     padding: 0;
}

div#modal_addSchedule div.color-div, div#modal_addSchedule div.subject-div{
display: inline-block;
}
div#modal_addSchedule div.subject-div{
width: 93%;
}
div#modal_addSchedule div.color-div{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
    width: 20px;
    padding: 7px 18px 0 0;
    color: #555;
    font-weight: 700;
    font-size: 14px;

}

div#modal_addSchedule div.vote-group label{
margin:0;
   
    cursor: pointer;
        background-repeat: no-repeat;
   width: 16px;
    height: 16px;
    position: relative;
    top: 2.5px;
     background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-off.svg');

}
div#modal_addSchedule div.vote-group input[type=checkbox]:checked + label {
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-on.svg');
}

div#modal_addSchedule div.vote-group input[type=checkbox]:disabled + label {
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-radio-off.svg');
}



div#modal_addSchedule div.vote-group span{
 padding-right: 5px;
}

div#modal_addSchedule input.vote_checkbox{
display: none;
    box-sizing: border-box;
    padding: 0;
}
	 				 
div#modal_addSchedule i.icon-place{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-place.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}

div#modal_addSchedule div.map{
width:100%;
height:200px; 
display: block; 
}

div#modal_addSchedule i.icon-search{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-search.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
    vertical-align: top;
    margin-top: 9px;
    filter: invert(69%) sepia(6%) saturate(15%) hue-rotate(28deg) brightness(84%) contrast(86%);
}

div#modal_addSchedule i.icon-share{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-share.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}
div#modal_addSchedule i.icon-text{

    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-text.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}

div#modal_addSchedule input.place{
    width: 100%;
    max-width: 480px;
    height: 38px;
    line-height: 38px;
    padding: 0;
    color: #333;
    font-size: 15px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    width: 21%;
}

div#modal_addSchedule i.icon-file-upload{
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-file-upload.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}

div#modal_addSchedule input.upload-name{
	/* width: 100%; */
    max-width: 480px;
    height: 38px;
    line-height: 38px;
    padding: 0 10px 0 0;
    color: #333;
    font-size: 15px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
   background-color:transparent;
}

div#modal_addSchedule div.filebox label{
 	margin:0;
    width: 28px;
    height: 28px;
    line-height: 25px;
    cursor: pointer;
    text-align: center;
        box-sizing: content-box;
}
div#modal_addSchedule i.icon-file {
background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-file.svg')!important;
 width: 20px;
height: 20px; 
display: inline-block;
vertical-align: middle;
}

div#modal_addSchedule input.upload-file{
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
}



div#modal_addSchedule input.joinUserName{
    width: 100%;
    max-width: 480px;
    height: 38px;
    line-height: 38px;
    padding: 0 10px 0 0;
    color: #333;
    font-size: 15px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
}

div#modal_addSchedule input.joinUserName:hover, div#modal_addSchedule input.joinUserName:active, div#modal_addSchedule input.joinUserName:not(:hover){
outline: 0;
}
div#modal_addSchedule input.place:hover, div#modal_addSchedule input.place:active, div#modal_addSchedule input.place:not(:hover){
outline: 0;
}
div#modal_addSchedule textarea.content:hover, div#modal_addSchedule textarea.content:active, div#modal_addSchedule textarea.content:not(:hover){
outline: 0;
}
div#modal_addSchedule textarea.content{
  width: 100%;
  height: 100px;
    line-height: 38px;
    padding: 0 10px 0 0;
    color: #333;
    font-size: 15px;
    border: 0;
     resize: none;
}



div#modal_addSchedule ul>li:nth-child(5) div.title {
	 vertical-align: top;
	  padding-top: 9px;
}


div#modal_addSchedule ul>li:nth-child(6) div.title {
	 vertical-align: top;
	 padding-top: 9px;
}

div#modal_addSchedule select.calType.schedule{
border: 0;
 color: #333;
    font-size: 15px;
     margin-left: -4px;
}
div#modal_addSchedule select.calType.schedule:hover, div#modal_addSchedule select.calType.schedule:active, div#modal_addSchedule select.calType.schedule:not(:hover){
outline: 0;
}

div#modal_addSchedule select.small_category{
border: 0;
 color: #333;
    font-size: 15px;
 padding: 0 10px 0 0;
 margin-left: 10px;
}

div#modal_addSchedule select.small_category:hover, div#modal_addSchedule select.small_category:active, div#modal_addSchedule select.small_category:not(:hover){
outline: 0;
}

ul.ui-autocomplete {
z-index:2147483647;
color: #333;
width: 200px !important;
font-size: 15px;
line-height: 38px;

/* border-radius: 4px; */
border: 1px solid #6449fc !important;

max-height: 200px;
    overflow: scroll;
    -ms-overflow-style: none; 
    scrollbar-width: none; 
}
ul.ui-autocomplete::-webkit-scrollbar {
    display: none;
}

ul.ui-autocomplete li.ui-menu-item:first-child div:not(:hover){
background-color: white;
color: #333;
 border-bottom: 0;

}

ul.ui-autocomplete li.ui-menu-item:last-child div:not(:hover){
background-color: white;
color: #333;
 border-top: 0 ; 

}

ul.ui-autocomplete li.ui-menu-item:not(:last-child):not(:first-child) div:not(:hover){
background-color: white;
color: #333;
 border-top: 0; 
 border-bottom: 0;
}
 
ul.ui-autocomplete li.ui-menu-item div:focus, ul.ui-autocomplete li.ui-menu-item div:active, ul.ui-autocomplete li.ui-menu-item div:hover {
	background-color: rgba(0,0,0,0.5);
    color: #fff;
        border: 0; 
    /* border-radius: 4px; */
}

span.plusUser{
margin-right: 10px; 
}

<%-- i.fa-trash{
 background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-delete.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
}
  --%>
 div.modal-content{
 border-radius: 10px;
 box-shadow: 20px 20px 30px rgb(0 0 0 / 20%);
 box-sizing: border-box;
 
 }
  
  
  a.fc-daygrid-event{
    margin: 0;
    border-radius: 20px;
    cursor: pointer;
    margin-top: 2px;
  }
  div.fc-event-main-frame{
      height: 22px;
    line-height: 19px;
    font-size: 13px;
        padding-left: 13px;
        vertical-align: middle;
        
    
  }
  .fc-direction-ltr .fc-daygrid-event.fc-event-start{
      margin-left: 10px;
  }
  .fc-direction-ltr .fc-daygrid-event.fc-event-end{
  margin-right: 10px;
  }
  
 /*  ///////// */
 
 
 div.showSchedule{ 
 	width: 674px;
    height: 100%;
    min-height: auto;
    max-height: 100%;
    position: absolute;
    top: -20px;
    bottom: 0;
    right: -20px;
    z-index: 2;
    overflow: hidden;
    background: #f9f9f9;
    border-radius: 0;
    border-left: 1px solid #ccc;
        border: 1px solid #ccc;
    box-shadow: -10px 10px 15px rgb(0 0 0 / 4%);
    
    font-size: 14px;
    font-weight: 400;
 }
  
  div.showSchedule div.card-header{
  	overflow: hidden;
    padding: 12px 20px;
    height: 45px;
    background: #fff;
    border-bottom: 1px solid #eee;
  }
  
  div.showSchedule div.card-header h3{
  	float: left;
    width: 100%;
    font-size: 14px;
    color: #333;
    
    margin: 0;
    padding: 0;
  }
  div.showSchedule div.card-header h3 span {
 	 overflow: hidden;
   /*  display: inline-block; */
    max-width: 300px;
    text-overflow: ellipsis;
    white-space: nowrap;
    vertical-align: middle;
   margin-left: 5px;

  }
  div.showSchedule div.card-header button.close{
  	top: 8px;
    right: 20px;
        float: right;
    margin-top: 1px;
    position: absolute;
  }
  div.showSchedule div.card-header button.close span{
  /* font-family: icon-contents!important; */
    font-style: normal;
    /* font-weight: 400; */
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
  }
  
  div.showSchedule div.card-body{
  border-radius: 0;
  background: #faf9f9;
  
   flex: none;
    min-height: auto;
    padding: 0;
  
  }
  
  
  div.showSchedule div.card-scroll{
  	max-height: calc(100vh - 78px);
    overflow-y: auto;
    overflow-x: hidden;
    min-height: 100px;
    box-sizing: border-box;
	}
  
  
  div.showSchedule div.card-body-top{
 	 position: relative;
 	 display: flex;	
     -webkit-box-pack: justify;
     justify-content: space-between;
    padding: 14.5px 30px;
    background: #fff;

  }
  
  div.showSchedule div.card-author{
  -webkit-box-flex: 1;
    flex: 1;
    display: -webkit-box;
    display: flex;
    float: initial;
    width: calc(100% - 77px);
  }
  div.showSchedule span.card-profileImg{
	background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');
	width: 40px;
    height: 40px;
    display: inline-block;
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
     border-radius: 16px;
    cursor: pointer;
    box-sizing: border-box;
    vertical-align: middle;
  }
   div.showSchedule dl.card-author-info{
  
    display: -moz-box;
    display: flex;
    -webkit-box-flex: 1;
    flex: 1;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    flex-direction: column;
    -webkit-box-pack: center;
    justify-content: center;
    
     margin: 0;
    padding: 0;
    overflow: hidden;
    width: 70%;
    line-height: 18px;
    margin-left: 10px;
    vertical-align: middle;
    text-align: left;
    
    font-size: 14px;
    
   
   }
   
    div.showSchedule dl.card-author-info dt{
    display: flex;
    color: #555;
    line-height: 1.1;
    }
   
    div.showSchedule strong.author-name{
    
   overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inline-block;
    margin-right: 3px;
    vertical-align: middle;
    line-height: 18px;
    max-width: 70%;
    font-weight: 700;
    }
  
   div.showSchedule span.author-date{
       display: inline-block;
    min-width: 120px;
    margin: 2px 0 0 7px;
    color: #aaa;
    font-family: Roboto;
    vertical-align: middle;
    line-height: 1.1;
     font-weight: normal;
   }
   
   div.showSchedule div.card-option{
       display: flex;
   	 -webkit-box-align: center;
   	     align-items: center;
    -webkit-box-pack: justify;
        justify-content: flex-end;
    height: 40px;
   }
   
   div.showSchedule button.card-option-btn{
       margin: -1px 0 0 20px;
       padding: 4px 8px;
  
    vertical-align: middle;
    cursor: pointer;
        background-color: transparent;
        border-radius: 0;
    border: 0;
        color: #999;
        font-size: 100%;
    line-height: normal;
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-option.svg');
    width: 20px;
    height: 20px;
    

   }
   
    div.showSchedule button.card-option-btn span{
        width: 2px;
    height: 2px;
    background: #777;
    margin: 0;
    display: block;
    }
    
    div.showSchedule ul.card-option-ul{
    overflow: hidden;
    position: absolute;
    z-index: 1;
    top: 50px;
    right: 35px;
    background: #fff;
    border: 1px solid #555;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    border-radius: 6px;
    padding: 4px 0;

    }
    
   div.showSchedule li.card-option-li{
   display: block;
   position: relative;
   }
   
   div.showSchedule li.card-option-li a{
   	display: block;
    height: 19px;
    margin: 5px 0;
    padding: 0 14px;
    line-height: 19px;
    font-size: 13px;
    color: #555;
        text-decoration: none;
    
    cursor: pointer;
   }
   
   div.showSchedule li.card-option-li a i {
   display: inline-block;
    margin: -4px 6px 0 0;
    vertical-align: middle; 
   
    font-style: normal;
    font-weight: 400;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
     color: #999;
      width: 13px;
    height: 13px;
    filter: invert(66%) sepia(4%) saturate(26%) hue-rotate(338deg) brightness(94%) contrast(78%);
   }
   
   div.showSchedule li.card-option-li a i.icon-edit{
   background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-edit-13.svg');
   fill: blue;
   color: red;
   }
div.showSchedule li.card-option-li a i.icon-delete{
 background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-delete-13.svg');
}

div.showSchedule div.card-body-bottom{
position: relative;
    overflow: hidden;
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    width: 100%;
    height: auto;
    padding: 10px 30px 10px 30px;
    background: #fff;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    -moz-box-pack: justify;
    justify-content: space-between;
}

div.showSchedule div.card-schedule-date{
    display: table-cell;
    height: 74px;
    overflow: hidden;
    margin: 5px 20px 5px 0;
    width: 68px;
   
    border-radius: 6px;
  
    box-shadow: 0 0 6px rgb(0 0 0 / 10%);
    font-family: Roboto;
    text-align: center;
    vertical-align: middle;
}
div.showSchedule strong.card-month{
display: block;
    padding: 8px 0;
    font-size: 12px;
    color: #00b19c;
    
    height: 30px;
    line-height: 1;
    list-style-image: none;
    list-style-position: outside;
    list-style-type: none;
}

div.showSchedule strong.card-day{
	display: block;
    padding: 5px 0;
    font-size: 28px;
    color: #fff;
    background: #00b19c;
    height: 44px;
    line-height: 1;
    list-style-image: none;
    list-style-position: outside;
    list-style-type: none;
}

div.showSchedule div.card-schedule-title-area{
padding-left: 20px;

display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -webkit-flex-direction: column;
    -moz-box-orient: vertical;
    -moz-box-direction: normal;
    flex-direction: column;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
    -moz-box-pack: center;
    justify-content: center;
    -webkit-box-flex: 1;
    -webkit-flex: 1;
    -moz-box-flex: 1;
    flex: 1;
    width: 100%;
}

div.showSchedule h4.card-schedule-title{

    overflow: hidden;
    text-overflow: ellipsis;
    margin: 0;
    font-size: 18px;
    font-weight: 700;
    vertical-align: middle;
    word-break: break-word;
}

div.showSchedule div.card-schedule-day{
display: block;
margin-top: 10px;

}


div.showSchedule span.card-schedule-startDate{
font-family: Roboto;
    font-size: 16px;
    color: #333;


}
div.showSchedule span.card-schedule-endDate{
    display: inline-block;
font-family: Roboto;
    font-size: 16px;
    color: #333;
}

			
	div.showSchedule span.card-schedule-endDate:before{
    display: inline-block;
    content: "";
    width: 12px;
    height: 1px;
    margin: -2px 6px 0 3px;
    background: #333;
    vertical-align: middle;
}		  	 

div.showSchedule div.card-body-bottom:after {
    content: '';
    position: absolute;
    height: 1px;
    width: -webkit-calc(100% - 60px);
    width: calc(100% - 60px);
    left: 30px;
    bottom: 0;
    background: #eee;
}


div.showSchedule div.card-container{
    padding: 10px 0 20px;
    background: #fff;
}

div.showSchedule div.card-content{
font-size: 14px;
    word-break: break-word;
    line-height: 25px;
    color: #333;
    padding: 15px 30px 0;
}

div.showSchedule ul.card-content-group{
margin: 0;
    padding: 0;
    list-style: none;
}

div.showSchedule ul.card-content-group li {
    display: table;
    width: 100%;
    table-layout: fixed;
    margin-bottom: 11px;
        margin: 0;
    padding: 0;
    padding-left: 2px;
}

div.showSchedule div.card-content-title{
vertical-align: top;

    
        box-sizing: content-box;
    width: 20px;
    padding: 7px 20px 0 0;
    color: #555;
    font-weight: 700;
    font-size: 14px;
    margin-top: 30px;
    padding-top: 14px;
    word-break: break-all;
    
        position: relative;
        
            display: table-cell;
    height: 35px;

}

div.showSchedule i.icon-text{
background-image: url(/groovy/resources/images/kimyj/icon-text.svg)!important;
    width: 20px;
    height: 20px;
    position: absolute;
}

div.showSchedule div.card-content-memo{
margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    
    
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
    

}

div.showSchedule span.memo-span{
white-space: pre-wrap;
}

div.showSchedule span.memo-span a{

}

div.showSchedule div.card-vote{
display: block;
margin: 30px 0 0;
    padding: 30px 0 18px 0;
    border-top: 1px solid #eee;
    text-align: center;
    font-size: 0;

}
div.showSchedule button.vote-btn-yes{

    color: #00b19c;
 background-color: transparent;
    width: 74px;
    height: 34px;
    border: 1px solid #00b19c;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
    
        cursor: pointer;
            font-family: inherit;
        line-height: normal;
   
    margin: 0;
    padding: 0;
}

div.showSchedule button.vote-btn-no{
    line-height: normal;
    margin: 0;
padding: 0;

    color: #ff6b6b;
        margin-left: 20px;
        background-color: transparent;
            width: 74px;
    height: 34px;
        border: 1px solid #ff6b6b;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
    font-family: inherit;
    cursor: pointer;

}
	
div.showSchedule button.vote-btn-undefined{
    margin: 0;
    padding: 0;
 
  color: #777;
    margin-left: 20px;
    background-color: transparent;
        width: 74px;
    height: 34px;
 border: 1px solid #777;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
        cursor: pointer;
            line-height: normal;
    font-family: inherit;
}
	


div.showSchedule div.card-footer{
padding: 0;
border: 0;
border-radius: 0;
background: #f9f9f9;

}

div.showSchedule ul.card-footer-group{
color: #555;
    list-style: none;
    margin: 0;
    padding: 0;
    border-top: 1px solid #ddd;
}

div.showSchedule li.card-footer-li{
    margin: 0;
    padding: 0;

display: flex;
    margin-top: -1px;
    padding: 10px 30px;
    padding-top: 20px;
    border-bottom: 1px solid #eee;
}
}

div.showSchedule div.comment-user-profile{
    float: left;
}

div.showSchedule span.comment-user-profile-span{

	width: 40px;
    height: 40px;
        border-radius: 16px;


display: inline-block;
   
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
   
    cursor: pointer;
   
    box-sizing: border-box;
    vertical-align: middle;
    background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');


}	
			               
div.showSchedule div.comment-container{
display: block;

    
    position: relative;
   
    width: calc(100% - 52px);
    margin-left: 10px;
  
    box-sizing: border-box;
    float: left;

}

div.showSchedule div.comment-user-area{
width: 100%;
    line-height: 21px;
}
div.showSchedule div.comment-user-area:after{
    display: block;
    content: "";
    clear: both;
}
div.showSchedule div.comment-user{
float: left;
}
    
div.showSchedule span.comment-user-name{
    display: inline-block;
    font-weight: 700;
    font-size: 14px;
    color: #555;

}		
			                  
div.showSchedule span.comment-user-position	{
display: inline-block;
    font-size: 14px;
    color: #555;
}		 

div.showSchedule span.record-date{
display: inline-block;
    margin-top: -2px;
    font-size: 14px;
    font-family: Roboto;
    color: #999;
}			                     

div.showSchedule div.comment-writer-menu{
float: right;
}

div.showSchedule button.comment-edit{
margin: 0;
    padding: 0;
font-size: 14px;
    color: #999;
    cursor: pointer;
     display: inline-block;
   border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
   
}
div.showSchedule button.comment-delete{
margin: 0;
    padding: 0;
    display: inline-block;
    font-size: 14px;
    color: #999;
    cursor: pointer;
    
    border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
   
}

			                   
div.showSchedule div.comment-content{

}            
div.showSchedule div.comment-text-area{
}

div.showSchedule div.comment-text{
word-break: break-all;
    white-space: pre-wrap;
    line-height: 30px;
}	                
			              


div.showSchedule div.card-footer2{
overflow: hidden;
    padding: 14px 30px;
    
        position: sticky;
    bottom: 0;
    margin: 0;
    background: #faf9f9;
    
    box-shadow: 0 -2px 6px rgb(0 0 0 / 6%);
}


div.showSchedule div.comment-writer-profile{
    float: left;

}
div.showSchedule span.comment-writer-profile-span{
    cursor: default;
        width: 40px;
    height: 40px;
        border-radius: 16px;
        
        display: inline-block;
   
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
   background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');
    cursor: pointer;
   
    box-sizing: border-box;
    vertical-align: middle;


}
	
div.showSchedule form.comment-writer-container{
margin: 0;
    padding: 0;
display: block;

    position: relative;
   
    width: calc(100% - 52px);
    margin-left: 10px;
   
    box-sizing: border-box;
        float: left;

}

div.showSchedule form.comment-writer-container fieldset{
position: relative;
    border: 0;
       margin: 0;
    padding: 0;

}

div.showSchedule div.comment-writer-text{
width: 100%;
    padding: 11px 60px 11px 20px;
    min-height: 44px;
    background: #fff;
    border: 1px solid #ddd;
  
    border-radius: 4px;
   
    box-sizing: border-box;
    color: #555;
    word-break: break-all;
    white-space: pre-wrap;
    cursor: text;
}

div.showSchedule div.comment-writer-text:before {
	    display: block;
    content: attr(placeholder);
    color: #999;
}

div.showSchedule div.card-content-map{
width:100%;
height:200px; 
display: block; 
}

div.showSchedule i.icon-place{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-place.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}

div.showSchedule i.icon-file-download{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-file-download.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}
div.showSchedule div.card-content-place{
margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}
div.showSchedule span.place-span{
white-space: pre-wrap;
}
div.showSchedule span.place-span div{
display: inline-block;
}

div span.place-span a{
margin-left: 8px;
    color: #6449fc;
    line-height: 26px;
    text-decoration: underline;
    text-underline-position: under;
}
div.showSchedule div.card-content-download{
	margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}
div.showSchedule span.download-span{
white-space: pre-wrap;
}
div.showSchedule span.download-span a{
color: #6449fc;
text-decoration: underline;
text-underline-offset : 2px;
}

div.showSchedule h3.card-title i{
 background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-density.svg')!important;
    width: 20px;
    height: 20px;
    display: inline-block;
   filter: invert(17%) sepia(70%) saturate(15%) hue-rotate(316deg) brightness(90%) contrast(94%);
      vertical-align: middle;
}


div.showSchedule div.card-content-share{
	margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}

div.showSchedule span.share-span{
white-space: pre-wrap;
}

div.showSchedule i.icon-share{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-share.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}


div.showSchedule div.voteTotalCnt{
display: block;
    overflow: hidden;
       margin-bottom: 10px;
}
div.showSchedule span.yesCnt{
color: #00b695;
   
    font-size: 15px;
    
    line-height: 19px;
}

div.showSchedule span.noCnt{
    margin-left: 55px;
        color: #fb2a2a;
        
    font-size: 15px;
        line-height: 19px;
}
div.showSchedule span.undefinedCnt{
  margin-left: 55px;
        color: #999;
      
    font-size: 15px;
        line-height: 19px;
}

div.showSchedule span.yesCnt span{
color: #00b695;
line-height: 19px;
   font-size: 15px;
}

div.showSchedule span.noCnt span{
color: #fb2a2a;
line-height: 19px;
    font-size: 15px;
}
div.showSchedule span.undefinedCnt span{
color: #999;
line-height: 19px;
   font-size: 15px;
}


div.showSchedule div.voteTotalCnt em{
    margin-left: 2px;
    font-weight: 700;
    font-size: 16px;
       font-style: normal;
}

ul.yesul{
list-style: none;
    padding: 0;
    margin: 0;
    display: block;
    outline: 0;
    
    z-index: 2147483647;
    color: #333;
    width: 200px !important;
    font-size: 15px;
    line-height: 38px;
    /* border-radius: 4px; */
    border: 1px solid #6449fc !important;
    max-height: 200px;
    overflow: scroll;
    -ms-overflow-style: none;
    scrollbar-width: none;
    
    position: absolute;
    top: 0;
    left: 0;
    cursor: default;
    
        top: 363px;
    left: 350.5px;
    width: 480px;
    display: none;

}

ul.noul{
display:none;
  overflow: hidden;
     position: relative;
    z-index: 1;
    top: 50px;
    right: 35px;
    background: #fff;
    border: 1px solid #555;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    border-radius: 6px;
    padding: 4px 0;
    width: 100px;
    height: 100px;
}

ul.undefinedul{
display:none;
  overflow: hidden;
     position: relative;
    z-index: 1;
    top: 50px;
    right: 35px;
    background: #fff;
    border: 1px solid #555;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    border-radius: 6px;
    padding: 4px 0;
    width: 100px;
    height: 100px;
}





</style>

<!-- 카드2 -->

<script type="text/javascript">

function searchPlaces(keyword) {
	
	
	 if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	 
	
	$("li.mapLi").show();
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 

	// 키워드로 장소를 검색합니다
	ps.keywordSearch(keyword, placesSearchCB); 

	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	        
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	       /*  alert('검색 결과가 존재하지 않습니다.');
	        return;
	         */
	        
	        var geocoder = new kakao.maps.services.Geocoder();
	        geocoder.addressSearch(keyword,placesSearchCB2);
	        
	        function placesSearchCB2 (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();

			        for (var i=0; i<data.length; i++) {
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
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	       	console.log(place.place_name);
	    	console.log(place.address_name);
	    	console.log(place.phone);
	    	if (place.road_address_name) {
	    		console.log(place.road_address_name);
	    	}
	    	console.log(place.place_url);
	    	
	    
	        if(!place.place_name){
	        	infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.address_name + '</div>');
	        }else{
	        	infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name +", "+place.address_name+", "+place.phone+ '</div>');
	        }
	        
	        infowindow.open(map, marker);
	        
	        $("input.place_name").val(place.place_name);
	        $("input.address_name").val(place.address_name);
	        $("input.place_phone").val(place.phone);
	        $("input.road_address_name").val(place.road_address_name);
	        $("input.place_url").val(place.place_url);
	       
	        console.log($("input.place_name").val());
	    	console.log($("input.address_name").val());
	    	console.log($("input.place_phone").val());
	    	console.log($("input.place_url").val());
	    	//console.log($("input.road_address_name").val());
	        
	    });
	}


}//end of function searchPlaces(keyword)



var calendar;

$(document).ready(function(){
	
	 $("div.showSchedule").hide();
	
	$(document).on("click", "input:checkbox[name=vote]", function(){
		var bool = $(this).prop("checked");
		if(bool){
			$(this).val("1");
		}else{
			$(this).val("0");
		}	
	});// end of $("input:checkbox[id=allComCal]").click(function(){})
	
/////////////
 	$("li.mapLi").hide();
 	
	$("input.place").keyup(function(event) {
		if(event.keyCode == 13){ 
			
		var keyword = $("input#place").val();
		searchPlaces(keyword);
		}
	});

//////////////
	
	
	
	
	
	
	
	
	
	
	
	
	
	//파일 업로드 
	$("input.upload-file").on('change', function(){
        if(window.FileReader){
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }

        $(this).siblings('input.upload-name').val(filename);
    });
	
	
	$("input.selectDay").daterangepicker({
	    locale: {
	    "separator": " ~ ",                     // 시작일시와 종료일시 구분자
	    "format": 'YYYY-MM-DD HH:mm',     // 일시 노출 포맷
	    "applyLabel": "확인",                    // 확인 버튼 텍스트
	    "cancelLabel": "취소",                   // 취소 버튼 텍스트
	    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    },
	    timePicker: true,                        // 시간 노출 여부
	    showDropdowns: true,                     // 년월 수동 설정 여부
	    autoApply: true,                         // 확인/취소 버튼 사용여부
	    timePicker24Hour: false,                  // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    timePickerSeconds: false,                 // 초 노출 여부
	    singleDatePicker: false                   // 하나의 달력 사용 여부
	});
	 
	$("input.selectDay").on('show.daterangepicker', function (ev, picker) {
	   
	});



	
	//daterangepicker
	/* $("input.selectDay").daterangepicker(); */

	//sideCalList 시작//
	// === 사내 캘린더에 사내캘린더 소분류 보여주기 ===
	showCompanyCal();

	// === 내 캘린더에 내캘린더 소분류 보여주기 ===
	showmyCal();

	// === 사내캘린더 체크박스 전체 선택/전체 해제 === //
	$(document).on("click", "input:checkbox[name=allComCal]", function(){
		var bool = $(this).prop("checked");
		$("input:checkbox[name=com_smcatgono]").prop("checked", bool);
	});// end of $("input:checkbox[id=allComCal]").click(function(){})
	
	
	// === 내캘린더 체크박스 전체 선택/전체 해제 === //
	$(document).on("click", "input:checkbox[name=allMyCal]", function(){
		var bool = $(this).prop("checked");
		$("input:checkbox[name=my_smcatgono]").prop("checked", bool);
	});// end of $("input:checkbox[id=allMyCal]").click(function(){})
		
	//키보드로 캘린더 추가 및 수정
	$("input.add_com_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			
			goAddComCal();
		}
	});//end of $("input.add_com_smcatgoname").keyup(function(event)
	
	$("input.edit_com_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goEditComCal();
		}
	});//end of $("input.edit_com_smcatgoname").keyup(function(event) 
				
			
	$("input.add_my_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goAddMyCal();
		}
	});//end of $("input.add_my_smcatgoname").keyup(function(event)
	
	$("input.edit_my_smcatgoname").keyup(function(event) {
		if(event.keyCode == 13){ 
			goEditMyCal();
		}
	});//end of $("input.edit_my_smcatgoname").keyup(function(event)
			
	
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
	   			                                             url:"javascript:detailSchedule("+item.pk_scheduleno+")",
	   			                                        	   <%--  url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno, --%>
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
	   			                                                url:"javascript:detailSchedule("+item.pk_scheduleno+")",
	   			                                        	    <%--  url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno,  --%>
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
  	                                              url:"javascript:detailSchedule("+item.pk_scheduleno+")",
  	                                        	   <%--  url: "<%= ctxPath%>/schedule/detailSchedule.groovy?pk_scheduleno="+item.pk_scheduleno, --%>
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
        
        // ===================== DB 와 연동하는 법 끝 ===================== //
        
		// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
        dateClick: function(info) {
        	 $('form.scheduleFrm').each(function() {
   		      this.reset();
   		  	});
        	 $("li.mapLi").hide();
        	$("select.small_category").empty();
        	$("select.small_category").hide();
        	$("input.subject").css('color','');
        	$("div.displayUserList").empty();
        	
        	
      		const endDay = info.dateStr+" 23:59";
      		$('input.selectDay').data('daterangepicker').setStartDate(info.dateStr);
			$('input.selectDay').data('daterangepicker').setEndDate(endDay);
      	    
      	  	$('#modal_addSchedule').modal('show');  
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
			
			
	//일정등록//
	// 캘린더 소분류 카테고리 숨기기
	$("select.small_category").hide();
	
	// === *** 달력(type="date") 관련 시작 *** === //
	// 시작시간, 종료시간		
	var html="";
	for(var i=0; i<24; i++){
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else{
			html+="<option value="+i+">"+i+"</option>";
		}
	}// end of for----------------------
	
	$("select#startHour").html(html);
	$("select#endHour").html(html);
	
	// 시작분, 종료분 
	html="";
	for(var i=0; i<60; i=i+5){
		if(i<10){
			html+="<option value='0"+i+"'>0"+i+"</option>";
		}
		else {
			html+="<option value="+i+">"+i+"</option>";
		}
	}// end of for--------------------
	html+="<option value="+59+">"+59+"</option>"
	
	$("select#startMinute").html(html);
	$("select#endMinute").html(html);
	// === *** 달력(type="date") 관련 끝 *** === //
	
	// '종일' 체크박스 클릭시
	$("input#allDay").click(function() {
		var bool = $('input#allDay').prop("checked");
		
		if(bool == true) {
			$("select#startHour").val("00");
			$("select#startMinute").val("00");
			$("select#endHour").val("23");
			$("select#endMinute").val("59");
			$("select#startHour").prop("disabled",true);
			$("select#startMinute").prop("disabled",true);
			$("select#endHour").prop("disabled",true);
			$("select#endMinute").prop("disabled",true);
		} 
		else {
			$("select#startHour").prop("disabled",false);
			$("select#startMinute").prop("disabled",false);
			$("select#endHour").prop("disabled",false);
			$("select#endMinute").prop("disabled",false);
		}
	});
	
			
	// 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아와서 select 태그에 넣어주기 
	$("select.calType").change(function(){
		var fk_lgcatgono = $("select.calType").val();      // 내캘린더이라면 1, 사내캘린더이라면 2 이다.
		var fk_empnum = $("input[name=fk_empnum]").val();  // 로그인 된 사용자아이디
		
		if(fk_lgcatgono != "") { // 선택하세요 가 아니라면
			$.ajax({
					url: "<%= ctxPath%>/schedule/selectSmallCategory.groovy",
					data: {"fk_lgcatgono":fk_lgcatgono, 
						   "fk_empnum":fk_empnum},
					dataType: "json",
					success:function(json){
						var html ="";
						if(json.length>0){
							
							$.each(json, function(index, item){
								html+="<option value='"+item.pk_smcatgono+"'>"+item.smcatgoname+"</option>"
							});
							$("select.small_category").html(html);
							$("select.small_category").show();
						}
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
			});
		}
		
		else {
			// 선택하세요 이라면
			$("select.small_category").hide();
		}
		
	});
	
	
	// 공유자 추가하기
	$("input#joinUserName").bind("keyup",function(){
			var joinUserName = $(this).val();
		//	console.log("확인용 joinUserName : " + joinUserName);
			$.ajax({
				url:"<%= ctxPath%>/schedule/insertSchedule/searchJoinUserList.groovy",
				data:{"joinUserName":joinUserName},
				dataType:"json",
				success : function(json){
					var joinUserArr = [];
			//		console.log("이:"+json.length);
					if(json.length > 0){
						
						$.each(json, function(index,item){
							var name = item.name;
							var pk_empnum = item.pk_empnum;
							if(name.includes(joinUserName) || pk_empnum.includes(joinUserName)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
								                             // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
							   joinUserArr.push(name+"("+item.pk_empnum+")");
							}

						});
						
						$("input.joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
							source:joinUserArr,
							select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
								console.log("##"+ui.item.value)
								add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
								                                // ui.item.value 이  선택한이름 이다.
								return false;
					        },
					        focus: function(event, ui) {
					            return false;
					        }
						}); 
						
					}// end of if------------------------------------
				}// end of success-----------------------------------
			});
	});
	

	// x아이콘 클릭시 공유자 제거하기
	$(document).on('click','div.displayUserList > span.plusUser > i',function(){
			var text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
			
			var bool = confirm("공유자 목록에서 "+ text +" 회원을 삭제하시겠습니까?");
			// 공유자 목록에서 이순신(leess/leesunsin@naver.com) 회원을 삭제하시겠습니까?
			
			if(bool) {
				$(this).parent().remove();
			}
	});

	
	  $("input.selectDay").on('apply.daterangepicker', function(ev, picker) {
		  console.log(picker.startDate.format('YYYY-MM-DD'));
		  console.log(picker.endDate.format('YYYY-MM-DD'));
		  console.log($("input.selectDay").val());
		});
		    
	
	 //등록버튼 
	// 등록 버튼 클릭
	$("button#register").click(function(){
		
		const day = $("input.selectDay").val();
		
		var [startDate, endDate] = day.split(' ~ ');
		console.log(startDate);
		console.log(endDate);
		
		// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
		//var startDate = $("input#startDate").val();	
    	var sArr = startDate.split("-");
    	startDate= "";	
    	for(var i=0; i<sArr.length; i++){
    		startDate += sArr[i];
    	}
    	var sArr = startDate.split(":");
    	startDate= "";	
    	for(var i=0; i<sArr.length; i++){
    		startDate += sArr[i];
    	}
    	
    	startDate = startDate.replace(/\s/gi, "");
    	//console.log(startDate);
    	//var endDate = $("input#endDate").val();	
    	var eArr = endDate.split("-");   
     	var endDate= "";
     	for(var i=0; i<eArr.length; i++){
     		endDate += eArr[i];
     	}
     	var eArr = endDate.split(":");
     	endDate= "";	
    	for(var i=0; i<eArr.length; i++){
    		endDate += eArr[i];
    	}
    	endDate = endDate.replace(/\s/gi, "");
		//console.log(endDate);
		
     	//var startHour= $("select#startHour").val();
     	//var endHour = $("select#endHour").val();
     	//var startMinute= $("select#startMinute").val();
     	//var endMinute= $("select#endMinute").val();
        
     	// 조회기간 시작일자가 종료일자 보다 크면 경고
        if (Number(endDate) - Number(startDate) < 0) {
         	alert("종료일이 시작일 보다 작습니다."); 
         	return;
        }
       /*  
     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
        else if(Number(endDate) == Number(startDate)) {
        	
        	if(Number(startHour) > Number(endHour)){
        		alert("종료일이 시작일 보다 작습니다."); 
        		return;
        	}
        	else if(Number(startHour) == Number(endHour)){
        		if(Number(startMinute) > Number(endMinute)){
        			alert("종료일이 시작일 보다 작습니다."); 
        			return;
        		}
        		else if(Number(startMinute) == Number(endMinute)){
        			alert("시작일과 종료일이 동일합니다."); 
        			return;
        		}
        	}
        }// end of else if---------------------------------
    	 
    	  */
    	 
		// 제목 유효성 검사
		var subject = $("input#subject").val().trim();
        if(subject==""){
			alert("제목을 입력하세요."); 
			return;
		}
        
        // 캘린더 선택 유무 검사
		var calType = $("select.calType").val().trim();
		if(calType==""){
			alert("캘린더 종류를 선택하세요."); 
			return;
		}
		
		// 달력 형태로 만들어야 한다.(시작일과 종료일)
		// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
		var sdate = startDate+"00";
		var edate = endDate+"00";
		
		$("input[name=startdate]").val(sdate);
		$("input[name=enddate]").val(edate);
	
	//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
		/*
		      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
		*/
		
	//  console.log("색상 => " + $("input#color").val());
		
		// 공유자 넣어주기
		var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
		var joinUserArr = new Array();
		
		plusUser_elm.forEach(function(item,index,array){
		//	console.log(item.innerText.trim());
			/*
				이순신(leess) 
				아이유1(iyou1) 
				설현(seolh) 
			*/
			joinUserArr.push(item.innerText.trim());
		});
		
		var joinuser = joinUserArr.join(",");
		//	console.log("공유자 => " + joinuser);
		// 이순신(leess),아이유1(iyou1),설현(seolh) 
		
		$("input[name=joinuser]").val(joinuser);
		
		
		
		if($("input[name=attach]").val() == "") {
			  // 첨부파일이 없는 댓글쓰기인 경우
			  alert("파일없음");
			  goAddSchedule_noAttach();
			  
		  }
		  else {
			 // 첨부파일이 있는 댓글쓰기인 경우 
			  alert("파일있음");
			 goAddSchedule_withAttach();
		  }
		
	});// end of $("button#register").click(function(){})--------------------
			
			
			
	$("input[name=color]").change(function(){
		$("input.subject").css('color',$(this).val());
	});		
			
			
			
}); // end of $(document).ready(function(){})


function goAddSchedule_withAttach(){
	
	 var formData = $("form[name=scheduleFrm]").serialize();
	  $("form[name=scheduleFrm]").ajaxForm({
		 url: "<%= ctxPath%>/registerSchedule_end_withAttach.groovy",
		data: formData,
		 type:"POST",
	 	  enctype:"multipart/form-data",
		  dataType:"JSON",
		 success:function(json){
			if(json.n == 1){
				alert("일정 등록에 성공하였습니다.");
				 $('form.scheduleFrm').each(function() {
		   		      this.reset();
		   		  	});
		        $("select.small_category").empty();
		        $("select.small_category").hide();
				
				 $("div#modal_addSchedule").modal("hide");
				/* calendar.changeView("dayGridMonth");//해당월 보여주기 수정필요 */
				calendar.refetchEvents()
			}else{
				alert("일정 등록에 실패하였습니다.");
			}
		 },
		 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }	 
	 });
	
	  $("form[name=scheduleFrm]").submit();
	
}

function goAddSchedule_noAttach(){
	
	var formData = $("form[name=scheduleFrm]").serialize();
	  $.ajax({
		 url: "<%= ctxPath%>/registerSchedule_end_noAttach.groovy",
		data: formData,
		 type:"POST",
		  dataType:"JSON",
		 success:function(json){
			if(json.n == 1){
				alert("일정 등록에 성공하였습니다.");
				 $('form.scheduleFrm').each(function() {
		   		      this.reset();
		   		  	});
		        $("select.small_category").empty();
		        $("select.small_category").hide();
				
				 $("div#modal_addSchedule").modal("hide");
				/* calendar.changeView("dayGridMonth");//해당월 보여주기 수정필요 */
				calendar.refetchEvents()
			}else{
				alert("일정 등록에 실패하였습니다.");
			}
		 },
		 error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }	 
	 });
	
}


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
	$("input.add_com_smcatgoname").val("");
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
				
				html += "<div>";
				html += "<p>";		
				html +=	'<input type="checkbox" checked id="allComCal" name="allComCal" class="calendar_checkbox"/><label for="allComCal"></label><span>전체</span>';
				html += "</p>";
				html += "</div>";				
						
				$.each(json, function(index, item){
					html += "<li>";
				
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
					html += "</li>";
					});
				 	 
				}
				$("div.comCalList > ul").html(html);
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
	$("input.add_my_smcatgoname").val("");
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
				 html +="<div>";
				 html +="<p>";
                 html +='<input type="checkbox" checked id="allMyCal" name="allMyCal" class="calendar_checkbox"/><label for="allMyCal"></label><span>전체</span>';
                 html +="</p>";
                 html +="</div>";
                 html += "</li>";
				 $.each(json, function(index, item){
					 html += "<li>";
					 html += "<div>";
					 html += "<p>";
					 html += "<input type='checkbox' name='my_smcatgono' class='calendar_checkbox my_smcatgono' value='"+item.pk_smcatgono+"' checked id='my_smcatgono_"+index+"'/>";
					 html += "<label for='my_smcatgono_"+index+"'></label><span>"+item.smcatgoname+"</span>";
					
					 html += "<button class='btn_edit' data-target='editCal' onclick='editMyCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-edit'></i></button></td>";  
					 html += "<button class='btn_edit delCal' onclick='delCalendar("+item.pk_smcatgono+",\""+item.smcatgoname+"\")'><i class='fas fa-trash'></i></button></td>";
			
					 html += "</p>";
					 html += "</div>";
					 html += "</li>";	
				});
			 	 
		
			 }
			 $("div.myCalList > ul").html(html);

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
					$('#modal_editMyCal').modal('hide'); // 모달 숨기기
				
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


//일정등록 부분//

// div.displayUserList 에 공유자를 넣어주는 함수
function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
	
	var plusUser_es = $("div.displayUserList > span.plusUser").text();
	console.log(" => " + value);
  console.log("확인용 plusUser_es => " + plusUser_es);
    /*
    	확인용 plusUser_es => 
			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)
			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)
			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)아이유2(iyou2/younghak0959@naver.com)
    */

	if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
		alert("이미 추가한 회원입니다.");
	}
	
	else {
		$("div.displayUserList").append("<span class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></span>");
	}
	
	$("input#joinUserName").val("");
	
}// end of function add_joinUser(value){}----------------------------		


function showMap(address){
	$("div.card-content-map").show();
	
	var mapContainer = document.getElementById('card-content-map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

    
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
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+address+'</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.relayout();
        map.setCenter(coords);
        
    } 
});   
	
}

//자세히보기
function detailSchedule(pk_scheduleno){

	 $.ajax({
         url: '<%= ctxPath%>/schedule/detailSchedule.groovy',
         data:{"pk_scheduleno":pk_scheduleno},
         dataType: "json",
         success:function(json) {
        	 
        	 voteTotalCnt(pk_scheduleno); 
        	 voteTotalLoginCnt(pk_scheduleno);
        	  voteYesUser(pk_scheduleno);
			     voteNoUser(pk_scheduleno);
			     voteUndefinedUser(pk_scheduleno);
        	 
         
			//{"map":{"STARTDATE":"2022-05-02 00:00","FK_SMCATGONO":"13","FK_EMPNUM":"admin","FK_LGCATGONO":"1","SMCATGONAME":"테스트6","PLACE":"강남맛집","PK_SCHEDULENO":"26","ENDDATE":"2022-05-02 23:59","NAME":"한관리","COLOR":"#6449fc","SUBJECT":"파일없음-유","CONTENT":"파일없음-유","JOINUSER":"한관리(0-20150502)"}}
        ///////////////////////
        var miniCalendarYM = moment(json.map.STARTDATE).format('YYYY-MM');
        var miniCalendarDD = moment(json.map.STARTDATE).format('DD');
        var regdate = moment(json.map.REGDATE).format('YYYY-MM-DD HH:mm');
        // ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        //,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        //,dayNamesMin:
        
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
         html += '<i></i>';<!-- 아이콘 -->
         html += '<span class="js-project-title-button">'+json.map.LGCATGONAME+'-'+json.map.SMCATGONAME+'</span>'; <!-- 대분류캘린더-소분류캘린더 -->
         html += '</h3>';
         html += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
         html += '<span aria-hidden="true">&times;</span>';
         html += '</button>';
         html += '</div>';
   	
         html += '<div class="card-body">';
         html += '<div class="card-scroll">';
 		
         html += '<div class="card-body-top">';
   	 		
         html += '<div class="card-author">';
         html += '<span class="card-profileImg"></span>';<!-- 프로필이미지 -->
         html += '<dl class="card-author-info">';
         html += '<dt>';
         html += '<strong class="author-name"> ['+json.map.DEPTNAMEKOR+' : '+json.map.SPOTNAMEKOR+'] '+json.map.NAME+'</strong>';<!-- 작성자이름 -->	   		
         html += '<span class="author-date">'+regdate+'</span>';<!-- 작성시간 -->
         html += '</dt>';
         html += '</dl>';
         html += '</div>';
   	 			
         html += '<div>';
         html += '<div class="card-option">';
 				
         html += '<button class="card-option-btn"></button>';
 						
         html += '<ul class="card-option-ul">';
         html += '<li class="card-option-li" data-code="modify">';
         html += '<a href="#"> <i class="icon-edit"></i>수정</a>';
         html += '</li>';
         html += '<li class="card-option-li" data-code="delete">';
         html += '<a href="#"> <i class="icon-delete"></i>삭제</a>';
         html += '</li>';
         html += '</ul>';
         html += '</div>';
         html += '</div>';
         html += '</div>';
  
         html += '<div class="card-body-bottom">';
         html += '<div class="card-schedule-date">';
         html += '<strong class="card-month" style="color:'+json.map.COLOR+'">'+miniCalendarYM+'</strong><strong class="card-day" style="background-color:'+json.map.COLOR+'">'+miniCalendarDD+'</strong>';<!-- 미니달력 -->
         html += '</div>';
         html += '<div class="card-schedule-title-area">';
         html += '<h4 class="card-schedule-title">'+json.map.SUBJECT+'</h4>'; <!-- 제목 -->
         html += '<div class="card-schedule-day">';
         html += '<span class="card-schedule-startDate">'+startdate+' ('+startdate_day+'), '+startdate_time+'</span>'; <!-- 시작일 -->
         html += '<span class="card-schedule-endDate">'+enddate+' ('+enddate_day+'), '+enddate_time+'</span>'; <!-- 종료일 -->
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
         html += '<span class="memo-span"><div>'+json.map.CONTENT+'</div></span>';
         html += '</div>';
         html += '</li>';
         if(json.map.ADDRESSNAME != "-"){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-place"></i></div>';
	         html += '<div class="card-content-place">';
	         html += '<span class="place-span"><div>';
	        	 if(json.map.PLACENAME != "-"){
	        		html += json.map.PLACENAME+' : ';
	        	 }
		         if(json.map.ADDRESSNAME != "-"){
		        	 html +=json.map.ADDRESSNAME;
	        	 }
		         if(json.map.PLACEPHONE != "-"){
		        	 html +=' 번호 : '+json.map.PLACEPHONE;
	        	 }
		         html +='</div><a  href="'+json.map.PLACEURL+'" target="_blank">상세보기</a></span>';
	         html += '</div>';
	         html += '</li>';
	         
	         html += '<li>';
	         html += '<div class="card-content-title"></div>';
	         html += '<div class="card-content-map" id="card-content-map">';
	         html += '</div>';
	         html += '</li>';
         }		
         if(json.map.ORGFILENAME != "-"){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-file-download"></i></div>';
	         html += '<div class="card-content-download">';
	         html += '<span class="download-span"><a href="<%= ctxPath%>/downloadComment.groovy?pk_scheduleno='+json.map.PK_SCHEDULENO+'">'+json.map.ORGFILENAME+'</a></span>';
	         html += '</div>';
	         html += '</li>';
	         
         }
         if(json.map.JOINUSER != "-"){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-share"></i></div>';
	         html += '<div class="card-content-share">';
	         html += '<span class="share-span"><div>'+json.map.JOINUSER+'</div></span>';
	         html += '</div>';
	         html += '</li>';
	         
         }
         

         html += '</ul>';
         html += '</div>';
 					
		 if(json.map.VOTE == 1){/* 참석유무 */
			 

	         html += '<div class="card-vote">';
	         
	         html += '<div class="voteTotalCnt">';
		     html += '<span class="yesCnt">';
		     html += '<span>참석</span><em>0</em>';
		     html += '</span>';
		     
			 html += '<span class="noCnt">';
			 html += '<span>불참</span><em>0</em>';
			 
			 html += '</span>';
			 
			 html += '<span class="undefinedCnt">';
			 html += '<span>미정</span><em>0</em>';
			 html += '</span>';
			 html += '</div>';
	         
	         
	         
	         html += '<button class="vote-btn-yes" onclick="voteYesAdd('+json.map.PK_SCHEDULENO+')">참석</button>';
	         html += '<button class="vote-btn-no" onclick="voteNoAdd('+json.map.PK_SCHEDULENO+')">불참</button>';
	         html += '<button class="vote-btn-undefined" onclick="voteUndefinedAdd('+json.map.PK_SCHEDULENO+')">미정</button>';
	         html += '</div>';		
		 }			
         html += '</div>';
         html += '</div>';
 		
         html += '<div class="card-footer">';
         html += '<ul class="card-footer-group">';
 				
         html += '<li class="card-footer-li">';
 			               
         html += '<div class="comment-user-profile">';
         html += '<span class="comment-user-profile-span"></span>';
         html += '</div>';
 			            
         html += '<div class="comment-container">';
         html += '<div class="comment-user-area">';
         html += '<div class="comment-user">';
         html += '<span class="comment-user-name">김영준</span>';
         html += '<span class="comment-user-position"></span>';
         html += '<span class="record-date">2022-05-14 07:26</span>'; 
         html += '</div>';
 			                    
         html += '<div class="comment-writer-menu">';
         html += '<button type="button" class="comment-edit">수정</button>';
         html += '<button type="button" class="comment-delete">삭제</button>';
         html += '</div>'; 
         html += '</div>';
 			                
         html += '<div class="comment-content">';
         html += '<div class="comment-text-area">';
	     html += '<div class="comment-text"><div>댓글</div></div>';
	 	 html += '</div>';	
         html += '</div>'; 
         html += '</div>';

	     html += '</li>'; 
		 html += '</ul>';
		 html += '</div>';

		 html += '<div class="card-footer2">';
		 html += '<div class="comment-writer-profile">';
		 html += '<span class="comment-writer-profile-span"></span>';
		 html += '</div>';

         html += '<form class="comment-writer-container">';
         html += '<fieldset>';
	     html += '<div class="comment-writer-text" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>';
		 html += '<input type="hidden" class="comment-upload-input">';
		 html += '</fieldset>';                     
		 html += '</form>';
         html += '</div>';
			
        /*  <div class="card showSchedule"> */
         $("div.showSchedule").html(html);
        
         if(json.map.ADDRESSNAME != "-"){
         	$("div.card-content-map").hide();
         	showMap(json.map.ADDRESSNAME);
         }
        
         $("div.showSchedule").show();

         ////////////////////
         },
         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
   });
}


// 투표 
function voteYesAdd(fk_scheduleno) {
	$("button.vote-btn-yes").css({'background':'#00b19c','color':'#fff'});
	$("button.vote-btn-no").css({'background':'','color':''});
	$("button.vote-btn-undefined").css({'background':'','color':''});
	

	
		   $.ajax({
			   url:"<%= ctxPath%>/voteYesAdd.groovy",
			   type:"POST",
			   data:{"fk_scheduleno":fk_scheduleno,
				   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
			   dataType:"JSON", 
			   success:function(json) {
				   //alert(json.msg);
				     //swal(json.msg);
				     voteTotalCnt(fk_scheduleno);
				     
				     voteYesUser(fk_scheduleno);
				     voteNoUser(fk_scheduleno);
				     voteUndefinedUser(fk_scheduleno);
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   });
	   
	   
}// end of golikeAdd(pnum)---------------------------


// **** 특정제품에 대한 싫어요 등록하기 **** //
function voteNoAdd(fk_scheduleno) {
	$("button.vote-btn-no").css({'background':'#ff6b6b','color':'#fff'});
	$("button.vote-btn-yes").css({'background':'','color':''});
	$("button.vote-btn-undefined").css({'background':'','color':''});
	
	 
		   $.ajax({
			   url:"<%= ctxPath%>/voteNoAdd.groovy",
			   type:"POST",
			   data:{"fk_scheduleno":fk_scheduleno,
				   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
			   dataType:"JSON", 
			   success:function(json) {
				   //alert(json.msg);
				     //swal(json.msg);
				     voteTotalCnt(fk_scheduleno);
				     
				     voteYesUser(fk_scheduleno);
				     voteNoUser(fk_scheduleno);
				     voteUndefinedUser(fk_scheduleno);
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   });
	  
	   
}// end of golikeAdd(pnum)---------------


function voteUndefinedAdd(fk_scheduleno) {

	$("button.vote-btn-undefined").css({'background':'#777','color':'#fff'});
	$("button.vote-btn-yes").css({'background':'','color':''});
	$("button.vote-btn-no").css({'background':'','color':''});
	   		
		   $.ajax({
			   url:"<%= ctxPath%>/voteUndefinedAdd.groovy",
			   type:"POST",
			   data:{"fk_scheduleno":fk_scheduleno,
				   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
			   dataType:"JSON", 
			   success:function(json) {
				   //alert(json.msg);
				     //swal(json.msg);
				     voteTotalCnt(fk_scheduleno);
				     
				     voteYesUser(fk_scheduleno);
				     voteNoUser(fk_scheduleno);
				     voteUndefinedUser(fk_scheduleno);
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   });
	 
	   
}// end of golikeAdd(pnum)---------------

function voteTotalCnt(fk_scheduleno) {

	   $.ajax({
		   url:"<%= ctxPath%>/voteTotalCnt.groovy",
		   type:"POST",
		   data:{"fk_scheduleno":fk_scheduleno,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		   dataType:"JSON", 
		   success:function(json) {
			   $("div.voteTotalCnt span.yesCnt em").html(json.map.YESCNT);
			   $("div.voteTotalCnt span.noCnt em").html(json.map.NOCNT);
			   $("div.voteTotalCnt span.undefinedCnt em").html(json.map.UNDEFINEDCNT);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------


function voteTotalLoginCnt(fk_scheduleno) {

	   $.ajax({
		   url:"<%= ctxPath%>/voteTotalLoginCnt.groovy",
		   type:"POST",
		   data:{"fk_scheduleno":fk_scheduleno,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		   dataType:"JSON", 
		   success:function(json) {
				if(json.map.USERYESCNT == "1"){
					$("button.vote-btn-yes").css({'background':'#00b19c','color':'#fff'});
					$("button.vote-btn-no").css({'background':'','color':''});
					$("button.vote-btn-undefined").css({'background':'','color':''});
				
				}else if(json.map.USERNOCNT == "1"){
					$("button.vote-btn-no").css({'background':'#ff6b6b','color':'#fff'});
					$("button.vote-btn-yes").css({'background':'','color':''});
					$("button.vote-btn-undefined").css({'background':'','color':''});
					
				}else if(json.map.USERUNDEFINEDCNT == "1"){
					$("button.vote-btn-undefined").css({'background':'#777','color':'#fff'});
					$("button.vote-btn-yes").css({'background':'','color':''});
					$("button.vote-btn-no").css({'background':'','color':''});
				
				}
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------










function voteYesUser(fk_scheduleno) {

	   $.ajax({
		   url:"<%= ctxPath%>/voteYesUser.groovy",
		   type:"POST",
		   data:{"fk_scheduleno":fk_scheduleno,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		   dataType:"JSON", 
		   success:function(json) {
			   
			   let html = ""
			   $.each(json, function(index, item) {
				   html +='<li>';
				   html += '<div>'+item.name+'('+item.fk_empnum+')</div>';
				   html += '</div>'; 
				   html +='</li>';   
			   })
			   
			   $("ul.yesul").html(html);
	
			  
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------

function voteNoUser(fk_scheduleno) {

	   $.ajax({
		   url:"<%= ctxPath%>/voteNoUser.groovy",
		   type:"POST",
		   data:{"fk_scheduleno":fk_scheduleno,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		   dataType:"JSON", 
		   success:function(json) {
			   
		   
			   	let html = ""
				   $.each(json, function(index, item) {
					   html +='<li>';
					   html += '<div>'+item.name+'('+item.fk_empnum+')</div>';
					   html += '</div>'; 
					   html +='</li>';   
				   })
				   
				   $("ul.noul").html(html);

			
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------

function voteUndefinedUser(fk_scheduleno) {

	   $.ajax({
		   url:"<%= ctxPath%>/voteUndefinedUser.groovy",
		   type:"POST",
		   data:{"fk_scheduleno":fk_scheduleno,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}"},
		   dataType:"JSON", 
		   success:function(json) {
			   
			  		let html = ""
					   $.each(json, function(index, item) {
						   html +='<li>';
						   html += '<div>'+item.name+'('+item.fk_empnum+')</div>';
						   html += '</div>'; 
						   html +='</li>';   
					   })
					   
					   $("ul.undefinedul").html(html);
			   
		   
			 
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------




</script>




<a href="#" id="sideBtn" class="sideBtn"></a>

<!-- 사이드바 시작 -->

<div class="sideCalList">

	<div  align="center" class="mainlogo">
		<a href="<%= ctxPath%>/index.groovy"><img src="<%= ctxPath%>/resources/images/common/로고그루비.png"  alt="로고"  /></a>
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
					<i class='fas'>&#xf055;</i>
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





<!-- 카드 -->
<div class="card showSchedule">

<%-- 
	<div class="card-header">
		<h3 class="card-title">
			<i></i><!-- 아이콘 -->
			<span class="js-project-title-button">대분류캘린더-소분류캘린더</span> <!-- 대분류캘린더-소분류캘린더 -->
		</h3>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
       	</button>
  	</div>
  	
  	<div class="card-body">
		<div class="card-scroll">
		
  	 		<div class="card-body-top">
  	 		
  	 			<div class="card-author">
  	 				<span class="card-profileImg"></span><!-- 프로필이미지 -->
					<dl class="card-author-info">
						<dt>
					    	<strong class="author-name">김영준</strong><!-- 작성자이름 -->	   		
					        <span class="author-date">2022-05-07 23:03</span><!-- 작성시간 -->
					    </dt>
					</dl>
  	 			</div>
  	 			
				<div>
				     <div class="card-option">
				
						<button class="card-option-btn"></button>
						
						<ul class="card-option-ul">
				    		<li class="card-option-li" data-code="modify">
				    			<a href="#"> <i class="icon-edit"></i>수정</a>
							</li>
							<li class="card-option-li" data-code="delete">
							    <a href="#"> <i class="icon-delete"></i>삭제</a>
							</li>
						</ul>
					</div>
				</div>	
  	 		</div>
 
			<div class="card-body-bottom">
				<div class="card-schedule-date">
					<strong class="card-month">05-2022</strong><strong class="card-day">04</strong><!-- 미니달력 -->
				</div>
				<div class="card-schedule-title-area">
			     	<h4 class="card-schedule-title">제목</h4> <!-- 제목 -->
			     	<div class="card-schedule-day">
						<span class="card-schedule-startDate">2022-05-04 (수), 23:10</span> <!-- 시작일 -->
						<span class="card-schedule-endDate">2022-05-06 (금), 00:10</span> <!-- 종료일 -->
					</div>
				</div>
			</div>
		
			<div class="card-container">
				<div class="card-content">
				
					<div class="card-content2">
						<ul class="card-content-group">		
				
							<li>
								<div class="card-content-title"><i class="icon-text"></i></div>
								<div class="card-content-memo">
									<span class="memo-span"><div>테스트</div></span>
								</div>
							</li>
					
						</ul>
					</div>
					

					<div class="card-vote">
						<button class="vote-btn-yes">참석</button>
						<button class="vote-btn-no">불참</button>
						<button class="vote-btn-undefined">미정</button>
					</div>		
					
				</div>
			</div>
		
			<div class="card-footer">
				<ul class="card-footer-group">
				
					<li class="card-footer-li">
			               
						<div class="comment-user-profile">
						    <span class="comment-user-profile-span"></span>
						</div>
			            
						<div class="comment-container">
			                <div class="comment-user-area">
			                    <div class="comment-user">
			                        <span class="comment-user-name">김영준</span>
			                        <span class="comment-user-position"></span>
			                        <span class="record-date">2022-05-14 07:26</span> 
			                    </div>
			                    
			                    <div class="comment-writer-menu">
			                        <button type="button" class="comment-edit">수정</button>
			                        <button type="button" class="comment-delete">삭제</button>
			                    </div> 
			                </div>
			                
			                <div class="comment-content">
								<div class="comment-text-area">
								    <div class="comment-text"><div>''김영준','유혜림'' → ''김영준','유혜림','이재희','임성희','조덕노'', 참석자를 변경하였습니다.</div></div>
								</div>	
			                </div>  
			            </div>
			            
			        </li> 
			    </ul>
			 </div>

			<div class="card-footer2">
				<div class="comment-writer-profile">
			    	<span class="comment-writer-profile-span"></span>
			    </div>
			    
			    <form class="comment-writer-container">
			    	<fieldset>
						<div class="comment-writer-text" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
						<input type="hidden" class="comment-upload-input">
					</fieldset>                     
			    </form>
			</div>


	  	 			
		</div>
  	</div>
  	--%>
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
		<div id="calendar" style="margin:50px 0 50px 0;" ></div>
	</div>
		
</div> 






<%-- === 사내 캘린더 추가 Modal === --%>
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
		     				<td>소분류명</td>
		     				<td><input type="text" class="add_com_smcatgoname" placeholder="추가할 분류명을 입력하세요."/></td>
		     			</tr>
		     			<tr>
		     				<td>만든이</td>
		     				<td>${sessionScope.loginuser.name}</td>
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
		     				<td>소분류명</td>
		     				<td><input type="text" class="edit_com_smcatgoname" placeholder="수정할 분류명을 입력하세요."/><input type="hidden" value="" class="edit_com_smcatgono"></td>
		     			</tr>
		     			<tr>
		     				<td>만든이</td>
		     				<td>${sessionScope.loginuser.name}</td>
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
		     				<td>소분류명</td>
		     				<td><input type="text" class="add_my_smcatgoname" placeholder="추가할 분류명을 입력하세요."/></td>
		     			</tr>
		     			<tr>
		     				<td>만든이</td>
		     				<td>${sessionScope.loginuser.name}</td>
		     			</tr>
     				</table>
       			</form>	
            </div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="addCom" class="btn btn-success btn-sm" onclick="goAddMyCal()">추가</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>
        </div>
    </div>
</div>

<%-- === 내 캘린더 수정 Modal === --%>
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
		     				<td>소분류명</td>
		     				<td><input type="text" class=edit_my_smcatgoname placeholder="수정할 분류명을 입력하세요."/><input type="hidden" value="" class="edit_my_smcatgono"></td>
		     			</tr>
		     			<tr>
		     				<td>만든이</td>
		     				<td>${sessionScope.loginuser.name}</td>
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


<%-- === 캘린더 일정추가 Modal === --%>
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
 							<input type="color" id="color" name="color" value="#6449fc"/>
                  		</div>
                  		<div class="subject-div"> 
                  			<input type="text" id="subject" name="subject" class="subject" placeholder="제목을 입력하세요." autocomplete="off" data-required-yn="Y" maxlength="100" data-empty-msg="제목을 입력하세요"/>
                 		</div>
                 	</div>
					<ul>
						<li>
	 				 		<div class="title"><i class="icon-calendar"></i></div>
							<div>
		                        <input class="selectDay"/>
	                    	</div>
 				 		</li>
 				 		<li>
	 				 		 <div class="title"><i class="icon-select-calendar"></i></div>
	 				 		 <div>
	 				 		 	<select class="calType schedule" name="fk_lgcatgono">
									<%-- 
									<c:choose>
									사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.
										<c:when test="${loginuser.fk_pcode =='3' && loginuser.fk_dcode == '4' }">
											<option value="">선택하세요</option>
											<option value="1">내 캘린더</option>
											<option value="2">사내 캘린더</option>
										</c:when>
									--%> 
									<%-- 일정등록시 사내캘린더 등록은 oginuser.gradelevel =='10' 인 사용자만 등록이 가능하도록 한다. --%> 
										<%-- <c:when test="${loginuser.gradelevel =='10'}"> 
											<option value="">선택하세요</option>
											<option value="1">내 캘린더</option>
											<option value="2">사내 캘린더</option>
										<%-- </c:when> --%>
									<%-- 일정등록시 내캘린더 등록은 로그인 된 사용자이라면 누구나 등록이 가능하다.
										<c:otherwise>
											<option value="">선택하세요</option>
											<option value="1">내 캘린더</option>
										</c:otherwise >
									</c:choose>
									 --%> 	
									<option value="">선택하세요</option>
									<option value="1">내 캘린더</option>
									<option value="2">사내 캘린더</option>
								</select>
								<select class="small_category schedule" name="fk_smcatgono"></select>
	 				 		 </div>
	 				 		 
	 				 		 <div class="vote-group">
	 				 		 	<span>투표기능</span>
	 				 		 	<input type="checkbox" id="vote" name="vote" class="vote_checkbox">
	 				 		 	<label for="vote"></label>	
	 				 		 </div>
	 				 		 
	 				 		 
						</li>
						
						<li class="mapLi">
							<div class="title"></div>
							<div id="map" class="map"></div>
						</li>
						
						<li>
	 				 		 <div class="title"><i class="icon-place"></i></div>
	 				 		 <div>
	 				 		 
	 				 		 <input type="text" name="place" id="place" class="place" data-required-yn="Y" autocomplete="off" maxlength="500"  placeholder="장소를 입력하세요."/>
	 				 		 <i class="icon-search"></i>
	 				 		 </div>
	 				 		  
						</li>
						<li>
	 				 		 <div class="title"><i class="icon-share"></i></div>
	 				 		 <div>
	 				 		 <input type="text" id="joinUserName" class="joinUserName" data-required-yn="Y" autocomplete="off" maxlength="500" placeholder="일정을 공유할 회원명을 입력하세요."/>
							<div class="displayUserList"></div>
							<input type="hidden" name="joinuser"/>
	 				 		 </div>
						</li>
						<li>
	 				 		 <div class="title"><i class="icon-text"></i></div>
	 				 		 <div>
	 				 		 <textarea rows="10" cols="100" name="content" id="content"  class="content" data-required-yn="Y" placeholder=" 내용을 입력하세요."></textarea>

	 				 		 </div>
						</li>
						
						<li>
	 				 		 <div class="title"><i class="icon-file-upload"></i></div>
	 				 		 <div class="filebox">
	 				 		 	<label for="filename"><i class="icon-file"></i></label> 
						  		<input type="file" id="filename" class="upload-file" name="attach"> 
	 				 		 
								<input class="upload-name" value="파일선택" disabled="disabled">
								
														
							</div>
						</li>
						
						
					</ul>
					<input type="hidden" name="fk_empnum" value="${sessionScope.loginuser.pk_empnum}" />
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
					
					<input type="hidden" name="placeName" class="place_name"/>
					<input type="hidden" name="addressName" class="address_name"/>
					<input type="hidden" name="placePhone" class="place_phone"/>
					<input type="hidden" name="roadAddressName" class="road_address_name"/>
					<input type="hidden" name="placeUrl" class="place_url"/>

				</form>
						
            </div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="register" class="btn btn-success btn-sm btn_normal">등록</button>
			    <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">취소</button>
			</div>
        </div>
    </div>
</div>



<ul class= "yesul"></ul>
<ul class= "noul"></ul>
<ul class= "undefinedul"></ul>




<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" class="chooseDate" />	
</form>	

