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
<title>결재대기문서 내역보기</title>

<style type="text/css">

div#container {
	width: 90%;
	margin: 0 auto;
}

table#approver {
	display: inline-block;
}

table#approver td, table#approver th {
	border: solid 1px grey;
	padding: 10px;
}

table#reference {
	display: inline-block;
	margin-left: 30px;
	margin-top: 20px;
}

table#reference td, table#reference th {
	border: solid 1px grey;
	padding: 10px;
}

table#tbl_app_info {
	margin-top: 30px;
}

table#tbl_app_info td, table#tbl_app_info th{
	padding: 10px;
}

table#reference th, table#approver th {
	text-align: center;
}


</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		let pk_documentnum = $("td.pk_documentnum").text();
		
		$("input[name='pk_documentnum']").val(pk_documentnum);
		
		if($("td.app_opinion_chk").val() != "" ){
			$("div#app_opinion_chk").hide();
		} else {
			$("div#app_opinion_chk").show();
		}
			
	}); // end of $(document).ready(function()


	
	
</script>

</head>
<body>

	<div id="container">
		
		<h2>결재참조 문서 정보 보기</h2>
			<table id="approver">
				<tr>
					<th colspan="5"> 결재자 </th>
				</tr>
				<tr>
					<th>사번</th>
					<th>부서</th>
					<th>직급</th>
					<th>이름</th>
					<th>승인여부</th>
				</tr>
				<c:forEach var="appList" items="${requestScope.approverList }">
				<c:if test="${appList.app_status eq '1' }">	
					<tr>
						<td>${appList.fk_empnum }</td>
						<td>${appList.deptnamekor }</td>
						<td>${appList.spotnamekor }</td>
						<td>${appList.name }</td>
						<c:if test="${appList.appyn eq '0' }">
							<td>승인대기</td>
						</c:if>
						<c:if test="${appList.appyn eq '1' }">
							<td class="app_opinion_chk">승인완료</td>
						</c:if>
						<c:if test="${appList.appyn eq '2' }">
							<td class="app_opinion_chk">반려</td>
						</c:if>
					</tr>
				</c:if>		
				</c:forEach>
			
			</table>
			<table id="reference">
				<tr>
					<th colspan="4"> 참조자 </th>
				</tr>
				<tr>
					<th>사번</th>
					<th>부서</th>
					<th>직급</th>
					<th>이름</th>
				</tr>
				<c:forEach var="appList" items="${requestScope.approverList }">
				<c:if test="${appList.app_status eq '0' }">	
					<tr>
						<td>${appList.fk_empnum }</td>
						<td>${appList.deptnamekor }</td>
						<td>${appList.spotnamekor }</td>
						<td>${appList.name }</td>
					</tr>
				</c:if>		
				</c:forEach>
			
			</table>
		
			
			<table id="tbl_app_info" class="tcenter">
				<!-- 문서가 비품일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '1' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.equipmentvo.pk_documentnum }</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td>${requestScope.equipmentvo.equipmentvo.productName } </td>
					</tr>
					<tr>
						<th>상품정보(링크)</th>
						<td>${requestScope.equipmentvo.equipmentvo.productLink } </td>
					</tr>
					<tr>
						<th>수량</th>
						<td>${requestScope.equipmentvo.equipmentvo.productCnt } </td>
					</tr>
					<tr>
						<th>단가</th>
						<td>${requestScope.equipmentvo.equipmentvo.productCost } </td>
					</tr>
					<tr>
						<th>금액</th>
						<td>${requestScope.equipmentvo.equipmentvo.productMoney } </td>
					</tr>
					<tr>
						<th>사유</th>
						<td>${requestScope.equipmentvo.equipmentvo.productInfo } </td>
					</tr>
				</c:if>	
				<!-- 문서가 출장비일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '3' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.businessCostMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>출장목적</th>
						<td>${requestScope.businessCostMap.businessregion} </td>
					</tr>
					<tr>
						<th>출장 시작일</th>
						<td>${requestScope.businessCostMap.businessstartdate} </td>
					</tr>
					<tr>
						<th>출장 종료일</th>
						<td>${requestScope.businessCostMap.businessenddate} </td>
					</tr>
					<tr>
						<th>출장 목적</th>
						<td>${requestScope.businessCostMap.businesspurpose} </td>
					</tr>
					<tr>
						<th>청구 금액</th>
						<td>${requestScope.businessCostMap.businessmoney} </td>
					</tr>
					<tr>
						<th>첨부 파일</th>
						<td>${requestScope.businessCostMap.orgfilename} </td>
					</tr>
				</c:if>	
				<!-- 문서가 식비일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '4' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.foodExpensesMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>사용 날짜</th>
						<td>${requestScope.foodExpensesMap.foodexpensesdate} </td>
					</tr>
					<tr>
						<th>사용 금액</th>
						<td>${requestScope.foodExpensesMap.foodexpensescost} </td>
					</tr>
					<tr>
						<th>식사 인원</th>
						<td>${requestScope.foodExpensesMap.foodexpensespersoncnt} </td>
					</tr>
					<tr>
						<th>비고</th>
						<td>${requestScope.foodExpensesMap.foodexpensesetc} </td>
					</tr>
					<tr>
						<th>첨부 파일</th>
						<td>${requestScope.foodExpensesMap.orgfilename} </td>
					</tr>
				</c:if>	
				<!-- 문서가 휴가신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '5' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.vacationMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>휴가 종류</th>
						<td>${requestScope.vacationMap.vtype} </td>
					</tr>
					<tr>
						<th>휴가시작일</th>
						<td>${requestScope.vacationMap.vstartdate} </td>
					</tr>
					<tr>
						<th>휴가종료일</th>
						<td>${requestScope.vacationMap.venddate} </td>
					</tr>
					<tr>
						<th>휴가사유</th>
						<td>${requestScope.vacationMap.vinfo} </td>
					</tr>
					<tr>
						<th>비고</th>
						<td>${requestScope.vacationMap.vetc} </td>
					</tr>
				</c:if>	
				<!-- 문서가 휴직신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '6' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.absenceMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>휴직 시작일</th>
						<td>${requestScope.absenceMap.absencestartdate} </td>
					</tr>
					<tr>
						<th>휴직 종료일</th>
						<td>${requestScope.absenceMap.absenceenddate} </td>
					</tr>
					<tr>
						<th>휴직사유</th>
						<td>${requestScope.absenceMap.absenceinfo} </td>
					</tr>
					<tr>
						<th>비고</th>
						<td>${requestScope.absenceMap.absenceetc} </td>
					</tr>
				</c:if>	
				<!-- 문서가 신규프로젝트신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '7' }">
					<tr>	
						<th class="">문서번호</th>
						<td class="pk_documentnum">${requestScope.newProjectMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>프로젝트명</th>
						<td>${requestScope.newProjectMap.projectname} </td>
					</tr>
					<tr>
						<th>프로젝트 시작일</th>
						<td>${requestScope.newProjectMap.projectstartdate} </td>
					</tr>
					<tr>
						<th>프로젝트 종료예정일</th>
						<td>${requestScope.newProjectMap.projectenddate} </td>
					</tr>
					<tr>
						<th>참여자 인원</th>
						<td>${requestScope.newProjectMap.projectpersoncnt} </td>
					</tr>
					<tr>
						<th>참여자명단</th>
						<td>${requestScope.newProjectMap.projectpersonlist} </td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>${requestScope.newProjectMap.orgfilename} </td>
					</tr>
				</c:if>	
			</table>
			
			<div id="app_opinion_chk">
				<div>승인자 의견</div>
				<table id="app_opinion">
					<tr>
						<th width="30%;">승인자</th>
						<th width="70%;">의견</th>
					</tr>
				<c:forEach var="appList" items="${requestScope.approverList }">
					<c:if test="${appList.app_status eq '1' }">	
						<tr>
							<td>[ ${appList.deptnamekor} ] ${appList.name} ${appList.spotnamekor}</td>
							<td>${appList.opinion}</td>
						</tr>
					</c:if>		
					</c:forEach>
				</table>
			</div>
			
	</div>


</body>
</html>