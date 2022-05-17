<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>결재 대기 문서</title>

<style type="text/css">

div#container {
	width: 100%;
	margin: 0 auto;
}

table#myAppInfo {
	width: 100%;
	margin-bottom: 50px;
}

table#myAppInfo tr:first-child {
	/* border-bottom: solid 2px #6449FC;
	border-top: solid 2px #6449FC; */
	background-color: #faf9f9;
	
	
}

tr.selectOne:hover {
	background-color: #e0ccff;
	cursor: pointer;
	color: white;
	
}

table#myAppInfo td , th {
	padding: 10px;
	text-align: center;
	
}


</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("tr.selectOne").click( function () {
					
					const $target = $(event.target);
					
				//	alert("확인용 => " + $target.parent().html() );
						
					const pk_documentnum = $target.parent().children(".pk_documentnum").text();
					const apl_no = $target.parent().children("td.apl_name").children("input.apl_no").val();
					
					location.href="<%= ctxPath%>/selectOneReferenceDocument.groovy?apl_no="+apl_no+"&pk_documentnum="+pk_documentnum;																	
					
		}); 
		
	}); // end of $(document).ready(function()

	
</script>

</head>
<body>

	<div id="container">
		<div style="font-size: 20px; font-weight: bold; margin: 20px 0;">결재 참조 문서</div>
			<table id="myAppInfo" class="tcenter">
				<tr id="fileItemTapLi">	
					<th class="">번호</th>
					<th class="">문서번호</th>
					<th class="">결재문서</th>
					<th class="">기안일</th>
					<th class="">기안자</th>
				</tr>
				
				<!--  ++ 관리자로 로그인 했을때만 볼수있게 처리 
				<c:if test="${empty requestScope.emps }">
					<tr class="" >
						<td colspan="12">조회결과가 없습니다.</td>
					</tr>
				</c:if>-->
				
				<c:if test="${not empty requestScope.referenceApprovalList }">
					<c:forEach var="appList" items="${requestScope.referenceApprovalList }" >
						<tr class="selectOne">
							<td>${appList.rno }</td>
							<td class="pk_documentnum">${appList.pk_documentnum }</td>
							<td class="apl_name">${appList.apl_name }<input class="apl_no" type='hidden'  value='${appList.apl_no }'/></td>
							<td>${appList.writeday }</td>
							<td class="fk_empnum"><span style="font-weight: bold;">[${appList.deptnamekor }] </span>${appList.name}  ${appList.spotnamekor} </td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty requestScope.referenceApprovalList }">
					<tr class="selectOne">
						<td colspan="5">검색된 결과가 없습니다.</td>
					</tr>
				</c:if>
				
			</table>
			
		<%-- 페이지바 보여주는 곳! --%>
		<div align="center" id="pageBar" >
			${requestScope.pageBar }
		</div>
			
	</div>


</body>
</html>