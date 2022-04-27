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
#fileSearch{
	border: solid 1px gray; 
	margin: 15px 0; 
	padding: 5px 12px 5px 8px;
	display: inline-block; 
	width: auto;
	background-color: #ffffff;
	border-radius: 30px;
	
}
#addFolder{
	display: inline-block; 
	float: right; 
	margin: 15px 0 15px 40px; 
	background-color: #6449fc;
}
#option{
	color: #6449fc;
}

li:hover{
	background-color: rgba(153, 102, 255, 0.1);  
	border: solid 1px #9966FF;
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
		<button id="addFolder" type="button" class="btn btn-primary bnone">+ 폴더 추가</button>
	</div>
	
	<div class="row ml-4 my-2 py-3 tcenter" id="fileItemTapLi">
	
		<div class="col-sm-6 " >
			<span class="" style="">파일명<em></em></span>
		</div>
		<div class="col-sm-2 " >
			<span class="">용량</span>
		</div>
		<div class="col-sm-2 " >
			<span class="">등록자<em></em></span>
		</div>
		<div class="col-sm-2 " >
			<span class="">등록일<em></em></span>
		</div>
		
	</div>
	    
        
        
<%--	
	<c:if test="${not empty boardvo}">
	++ 반복문
--%>
		
	
	<ul id="fileLayerUl" class="row ml-4 fileUL" >
        <li id="list-" class="my-2" style="padding-bottom: 30px;  width: 100%; ">
            <div class="col-sm-6 fleft" >
                <div class="fleft">
                    <svg style="padding-right: 10px" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-files" viewBox="0 0 16 16">
  					<path d="M13 0H6a2 2 0 0 0-2 2 2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2 2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm0 13V4a2 2 0 0 0-2-2H5a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1zM3 4a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4z"/>
					</svg>
                <span class="">폴더</span>
                </div>
            </div>
            <div class="col-sm-2 fleft tcenter"><strong>-</strong></div>
            <div class="col-sm-2 fleft tcenter" ><strong>이재희</strong></div>
            <div class="col-sm-2 fleft tcenter" ><strong>2022-04-22 18:06</strong></div>
        </li>
        
        <li id="list-" class="my-2" style="padding-bottom: 30px;  width: 100%; ">
            <div class="col-sm-6 fleft" >
                <div class="fleft">
                    <svg style="padding-right: 10px" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-files" viewBox="0 0 16 16">
  					<path d="M13 0H6a2 2 0 0 0-2 2 2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2 2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm0 13V4a2 2 0 0 0-2-2H5a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1zM3 4a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4z"/>
					</svg>
                <span class="">폴더</span>
                </div>
            </div>
            <div class="col-sm-2 fleft tcenter"><strong>-</strong></div>
            <div class="col-sm-2 fleft tcenter" ><strong>이재희</strong></div>
            <div class="col-sm-2 fleft tcenter" ><strong>2022-04-22 18:06</strong></div>
        </li>
        
        
        
    </ul>
    
    
		
		
		
	
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