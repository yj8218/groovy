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
<title>관리자 결재내역 보기</title>

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

select.search {
	width: 100px;
	height: 30px;
	border-radius: 7px;
	border-color: #6449FC;
	color: #6449FC;
	margin-bottom: 20px;
}

li:hover{
   background-color: rgba(153, 102, 255, 0.1);  
   border: solid 1px #9966FF;
   cursor: pointer;
   text-decoration: none;
}
.li_w70{
   display:inline-block; 
   width:70px; 
   font-size:14pt;
}
.li_w60{
   display:inline-block; 
   width:60px; 
   font-size:14pt;
}
.li_w30{
   display:inline-block; 
   width:30px; 
   font-size:14pt;
}
a {
   color: #6449fc; 
   text-decoration: none;
}
a:hover{
   text-decoration: none;
}
.li_border{
   border: solid 1px #6449fc; 
   border-radius: 5px;
   margin: 0 2px;
}

</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("tr.selectOne").click( function () {
					
			const $target = $(event.target);
			
		//	alert("확인용 => " + $target.parent().html() );
			const gobackURL = "${requestScope.gobackURL}";	
			const pk_documentnum = $target.parent().children(".pk_documentnum").text();
			const apl_no = $target.parent().children("td.deptnamekor").children("input.apl_no").val();
			
			location.href="<%= ctxPath%>/selectOneAdminDocument.groovy?apl_no="+apl_no+"&pk_documentnum="+pk_documentnum+"&gobackURL="+gobackURL;
																						
		}); 
		
		
		$("select.search").bind("change", function() {
			
			const frm = document.statusFrm;
			frm.action = "<%=ctxPath%>/adminApproval.groovy";
			frm.submit();
		});
		
		if("${requestScope.searchValue}" != "" && "${requestScope.searchValue}" != null){
			$("select.search").val("${requestScope.searchValue}")
		}
		
	}); // end of $(document).ready(function()

	
</script>

</head>
<body>

	<div id="container">
		
		<div style="font-size: 20px; font-weight: bold; margin: 20px 0;">관리자 결재내역 보기</div>
		<form name="statusFrm">
			<select class="search" name="searchValue">
				<option value="">전체</option>
				<option value="0">승인대기</option>
				<option value="1">승인중</option>
				<option value="2">승인완료</option>
				<option value="3">반려</option>
			</select>
		</form>
			<table id="myAppInfo">
				<tr>	
					<th class="">번호</th>
					<th class="">문서번호</th>
					<th class="">결재문서</th>
					<th class="">결재요청</th>
					<th class="">결재일</th>
					<th class="">승인여부</th>
				</tr>
				
				<!--  ++ 관리자로 로그인 했을때만 볼수있게 처리 
				<c:if test="${empty requestScope.emps }">
					<tr class="" >
						<td colspan="12">조회결과가 없습니다.</td>
					</tr>
				</c:if>-->
				
				<c:if test="${not empty requestScope.adminApprovalList }">
					<c:forEach var="appList" items="${requestScope.adminApprovalList }" >
						<tr class="selectOne">
							<td>${appList.rno }</td>
							<td class="pk_documentnum">${appList.pk_documentnum }</td>
							<td class="apl_name">${appList.apl_name }</td>
							<td class="deptnamekor">${appList.name }<input class="apl_no" type='hidden'  value='${appList.apl_no }'/></td>
							<td>${appList.writeday }</td>
							<c:if test="${appList.status == 0 }">
								<td>승인대기</td>
							</c:if>
							<c:if test="${appList.status == 1 }">
								<td style="font-weight:bold;">승인중</td>
							</c:if>
							<c:if test="${appList.status == 2 }">
								<td style="color:blue;">승인완료</td>
							</c:if>
							<c:if test="${appList.status == 3 }">
								<td style="color:red;">반려</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.adminApprovalList }">
					<tr>
						<td colspan="6">검색된 결과가 없습니다.<td>
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