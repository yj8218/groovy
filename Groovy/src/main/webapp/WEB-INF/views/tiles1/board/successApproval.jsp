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
<title>결재 완료 문서</title>

<style type="text/css">

tr.selectOne {
	cursor: pointer;
	
}

</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("tr.selectOne").click( function () {
					
					const $target = $(event.target);
					
				//	alert("확인용 => " + $target.parent().html() );
						
					const pk_documentnum = $target.parent().children(".pk_documentnum").text();
					const apl_no = $target.parent().children("td.fk_empnum").children("input.apl_no").val();
					
					location.href="<%= ctxPath%>/selectOneMyDocument.groovy?apl_no="+apl_no+"&pk_documentnum="+pk_documentnum;
																						
					
		}); 
		
	}); // end of $(document).ready(function()

	
</script>

</head>
<body>

	<div id="container">
		
		<h2>결재 대기 문서</h2>
			<table id="tbl_result" class="tcenter">
				<tr id="fileItemTapLi">	
					<th class="">번호</th>
					<th class="">결재번호</th>
					<th class="">결재문서</th>
					<th class="">기안자</th>
					<th class="">결재일</th>
					<th class="">승인여부</th>
				</tr>
				
				<!--  ++ 관리자로 로그인 했을때만 볼수있게 처리 
				<c:if test="${empty requestScope.emps }">
					<tr class="" >
						<td colspan="12">조회결과가 없습니다.</td>
					</tr>
				</c:if>-->
				
				<c:if test="${not empty requestScope.myApprovalList }">
					<c:forEach var="appList" items="${requestScope.myApprovalList }" >
						<tr class="selectOne">
							<td>${appList.rno }</td>
							<td class="pk_documentnum">${appList.pk_documentnum }</td>
							<td class="apl_name">${appList.apl_name }</td>
							<td class="fk_empnum">${appList.fk_empnum }<input class="apl_no" type='hidden'  value='${appList.apl_no }'/></td>
							<td>${appList.writeday }</td>
							<c:if test="${appList.status == 0 }">
								<td>승인대기</td>
							</c:if>
							<c:if test="${appList.status == 1 }">
								<td>승인중</td>
							</c:if>
							<c:if test="${appList.status == 2 }">
								<td>승인완료</td>
							</c:if>
							<c:if test="${appList.status == 3 }">
								<td>반려</td>
							</c:if>
						</tr>
					</c:forEach>
					
					
				</c:if>
				
			</table>
			
		<%-- 페이지바 보여주는 곳! --%>
		<div align="center" id="pageBar" >
			${requestScope.pageBar }
		</div>
			
	</div>


</body>
</html>