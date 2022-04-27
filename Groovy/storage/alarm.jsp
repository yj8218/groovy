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
#fileSearch{
	border: solid 1px gray; 
	margin: 15px 0; 
	padding: 5px 12px 5px 8px;
	display: inline-block; 
	width: auto;
	background-color: #ffffff;
	border-radius: 30px;
	
}

.bnone{
	border: none;
}
.alarmUL{
	list-style-type: none;
	display: inline-block;
	font-size: 11pt;
	
}
.alarmTapItem{
	float: left;
}
.alarmLI{
	
}
.alarmItem{
	display: inline-block;
	width: 900px;
	
}
.alarm-1{
	color: #777777;
	font-weight: bold;
}

.alarm-2{
	color: #7163c3;
}

.alarm-3{
	color: #777777;
}
.alarmItem:hover{
	cursor: pointer;
}
</style>


<div class="container-md" style="margin: 45px 0 0 230px;">
<div class="project-detail-top clearfix">


<div style="border: solid 1px gray; height: 120px; width: 100%;">
홈바
</div>


	<div>
		<div class="input-group mb-3 ml-4" id="fileSearch" >
		<!-- 돋보기 이미지, 나중에 이미지 다운받고 i 태그로 바꾸기 -->
		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	 		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
		</svg>
			<input type="text" placeholder="파일명을 입력해주세요." autocomplete="off" maxlength="20" class="bnone" >			
			<a type="button" class="" id="option" >옵션</a>
		</div>
	</div>


	<ul  class="alarmUL ml-4 mt-4" >
		
        <li class="alarmLI" >
        <div class="alarmItem" >
	        <div class="alarmTapItem mr-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="60" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
	        </div>
            <div class="alarmTapItem">
               <div class="alarm-1">이재희님의 업무 상단 고정</div>
               <div class="alarm-2">첫번째 업무</div>
               <div class="alarm-3">
                   <span>2022-04-22 18:09</span>
                   <span style="display: none">
                       <em class=""></em>이미지
                   </span>
                   <span style="display: none">
                       <em class=""></em>파일
                   </span>
               </div>
            </div>
            </div>
            <hr>
        </li>
        
        <li class="alarmLI">
        <div class="alarmItem">
	        <div class="alarmTapItem mr-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="60" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
	        </div>
            <div class="alarmTapItem">
                <div class="alarm-1">이재희님의 업무 상단 고정</div>
                <div class="alarm-2">첫번째 업무</div>
                <div class="alarm-3">
                    <span>2022-04-22 18:09</span>
                    <span style="display: none">
                        <em class=""></em>이미지
                    </span>
                    <span style="display: none">
                        <em class=""></em>파일
                    </span>
                </div>
            </div>
            </div>
            <hr>
        </li>
        
        <li class="alarmLI">
        <div class="alarmItem">
	        <div class="alarmTapItem mr-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="60" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
	        </div>
            <div class="alarmTapItem">
                <div class="alarm-1">이재희님의 업무 상단 고정</div>
                <div class="alarm-2">첫번째 업무</div>
                <div class="alarm-3">
                    <span>2022-04-22 18:09</span>
                    <span style="display: none">
                        <em class=""></em>이미지
                    </span>
                    <span style="display: none">
                        <em class=""></em>파일
                    </span>
                </div>
            </div>
            </div>
            <hr>
        </li>
        
        <li class="alarmLI">
        <div class="alarmItem">
	        <div class="alarmTapItem mr-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="60" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
	        </div>
            <div class="alarmTapItem">
                <div class="alarm-1">이재희님의 업무 상단 고정</div>
                <div class="alarm-2">첫번째 업무</div>
                <div class="alarm-3">
                    <span>2022-04-22 18:09</span>
                    <span style="display: none">
                        <em class=""></em>이미지
                    </span>
                    <span style="display: none">
                        <em class=""></em>파일
                    </span>
                </div>
            </div>
            </div>
            <hr>
        </li>
   
        
    </ul>

</div>
</div>