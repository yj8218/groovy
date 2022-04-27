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
.colsize2{width: 8%;}
.colsize3{width: 7%;}
.colsize4{width: 10%;}
.colsize5{width: 12%;}
.colsize6{width: 10%;}
.colsize7{width: 5%;}

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
		<button id="addFolder" type="button" class="btn btn-primary bnone">+ 업무 추가</button>
		<button id="download" type="button" class="btn btn-primary bnone">다운로드</button>
	</div>
	
	<div class="row ml-4 my-2 py-3 tcenter" id="fileItemTapLi">
	
		<div class="colsize1" >
			<span class="" style="">업무명<em></em></span>
		</div>
		<div class="colsize2" >
			<span class="">상태</span>
		</div>
		<div class="colsize3" >
			<span class="">우선순위<em></em></span>
		</div>
		<div class="colsize4" >
			<span class="">담당자<em></em></span>
		</div>
		<div class="colsize5" >
			<span class="">마감일<em></em></span>
		</div>
		<div class="colsize6" >
			<span class="">수정일<em></em></span>
		</div>
		<div class="colsize7" >
			<span class="">번호<em></em></span>
		</div>
		
	</div>
	    
        
        
<%--	
	<c:if test="${not empty boardvo}">
	++ 반복문
--%>
		
	
	<ul id="fileLayerUl" class="row ml-4 fileUL" >
        <li id="list-" class="my-2" style="padding-bottom: 30px;  width: 100%; ">
            <div class="fleft colsize1"  >
                <div class="fleft">
                   
                <span class="">첫번째 업무</span>
                </div>
            </div>
            <div class="fleft tcenter colsize2" ><strong>요청</strong></div>
            <div class="fleft tcenter colsize3" ><strong>보통</strong></div>
            <div class="fleft tcenter colsize4" ><strong>이재희 외 1명</strong></div>
            <div class="fleft tcenter colsize5" ><strong>2022-04-22</strong></div>
            <div class="fleft tcenter colsize6" ><strong>2022-04-25</strong></div>
            <div class="fleft tcenter colsize7" ><strong>5</strong></div>
        </li>
        
        <li id="list-" class="my-2" style="padding-bottom: 30px;  width: 100%; ">
            <div class=" fleft colsize1" >
                <div class="fleft ">
                    
                <span class="">두번째 업무</span>
                </div>
            </div>
            <div class="fleft tcenter colsize2"><strong>진행</strong></div>
            <div class="fleft tcenter colsize3" ><strong>-</strong></div>
            <div class="fleft tcenter colsize4" ><strong>유혜림</strong></div>
            <div class="fleft tcenter colsize5" ><strong>-</strong></div>
            <div class="fleft tcenter colsize6" ><strong>2022-04-25</strong></div>
            <div class="fleft tcenter colsize7" ><strong>3</strong></div>
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