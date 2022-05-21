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
	width: 50%;
	margin: 0 30px;
}

table#approver {
	display: inline-block;
	border-radius: 7px;
}

table#approver td, table#approver th {
	padding: 15px;
	border-collapse: collapse;
}

table#reference {
	display: inline-block;
	margin-left: 30px;
	margin-top: 20px;
}

table#reference td, table#reference th {
	/* border: solid 1px grey; */
	padding: 15px;
}

table#tbl_app_info {
	margin: 30px 0;
	width: 100%;
}

table#tbl_app_info td, table#tbl_app_info th{
	padding: 15px;
}

table#reference th, table#approver th {
	text-align: center;
}

th.first  {
	background-color: #e0ccff;
	border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	color: #330080;
}

tr.table_index {
	background-color: #faf9f9;
}

table#tbl_app_info th {
	background-color: #e6e6e6;
	width: 20%;
}
table#tbl_app_info td {
	background-color: #faf9f9;
	width: 70%;
}

th.first_radius {
	border-top-left-radius: 10px;
}
th.last_radius {
	border-bottom-left-radius: 10px;
}

/* table#tbl_app_info td {
	padding-right: 100px;
	background-color: #faf9f9;
} */

button.btn_wait {
	border: none;
	background-color: #6449FC;
	width: 150px;
	height: 40px;
	color: white;
	font-weight: bold;
	border-radius: 7px;
	text-align: center;
	margin-left: 20px;
	margin-bottom: 200px;
	float: right;
} 


</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		let pk_documentnum = $("td.pk_documentnum").text();
		
		$("input[name='pk_documentnum']").val(pk_documentnum);
		
	}); // end of $(document).ready(function()

	function app_success () {
	//	alert($("textarea[name='opinion']").val());
		const frm = document.documentnumFrm;
		frm.action = "<%=ctxPath%>/app_success.groovy";
		frm.submit();
		
	};
			
	function app_fail() {
		const frm = document.documentnumFrm;
		frm.action = "<%=ctxPath%>/app_fail.groovy";
		frm.submit();
	}
	
	
</script>

</head>
<body>

	<div id="container">
		<div style="font-size: 20px; font-weight: bold; margin: 20px 0;">결재대기 문서 정보 보기</div>
			<table id="approver">
				<tr>
					<th colspan="5" class="first"> 결재자 </th>
				</tr>
				<tr class="table_index">
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
							<td class="wait" style="font-weight: bold;">승인대기</td>
						</c:if>
						<c:if test="${appList.appyn eq '1' }">
							<td class="wait" style="color: #3385ff; font-weight: bold;">승인완료</td>
						</c:if>
						<c:if test="${appList.appyn eq '2' }">
							<td class="wait" style="color: red; font-weight: bold;">반려</td>
						</c:if>
					</tr>
				</c:if>		
				</c:forEach>
			
			</table>
			<table id="reference">
				<tr>
					<th colspan="4" class="first"> 참조자 </th>
				</tr>
				<tr class="table_index">
					<th>사번</th>
					<th>이름</th>
					<th>직급</th>
				</tr>
				<c:forEach var="appList" items="${requestScope.approverList }">
				<c:if test="${appList.app_status eq '0' }">	
					<tr>
						<td>${appList.fk_empnum }</td>
						<td>${appList.name }</td>
						<td>${appList.spotnamekor }</td>
					</tr>
				</c:if>		
				</c:forEach>
			
			</table>
		
			
			<table id="tbl_app_info" class="tcenter">
				<!-- 문서가 비품일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '1' }">
					<tr>	
						<th class="first_radius">문서번호</th>
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
						<td><fmt:formatNumber value="${requestScope.equipmentvo.equipmentvo.productCost }" pattern="#,###" />원 </td>
					</tr>
					<tr>
						<th>금액</th>
						<td><fmt:formatNumber value="${requestScope.equipmentvo.equipmentvo.productMoney }" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th class="last_radius">사유</th>
						<td>${requestScope.equipmentvo.equipmentvo.productInfo } </td>
					</tr>
				</c:if>	
				<!-- 문서가 출장비일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '3' }">
					<tr>	
						<th class="first_radius">문서번호</th>
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
						<td><fmt:formatNumber value="${requestScope.businessCostMap.businessmoney}" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th class="last_radius">첨부파일</th>
			            <td><a style="cursor: pointer;" href="<%= request.getContextPath()%>/download.groovy?pk_documentnum=${requestScope.businessCostMap.pk_documentnum }&apl_no=${requestScope.apl_no}">${requestScope.businessCostMap.orgfilename}</a></td> 
					</tr>
				</c:if>	
				<!-- 문서가 식비일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '4' }">
					<tr>	
						<th class="first_radius">문서번호</th>
						<td class="pk_documentnum">${requestScope.foodExpensesMap.pk_documentnum }</td>
					</tr>
					<tr>
						<th>사용 날짜</th>
						<td>${requestScope.foodExpensesMap.foodexpensesdate} </td>
					</tr>
					<tr>
						<th>사용 금액</th>
						<td><fmt:formatNumber value="${requestScope.foodExpensesMap.foodexpensescost}" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th>식사 인원</th>
						<td>${requestScope.foodExpensesMap.foodexpensespersoncnt} 명</td>
					</tr>
					<tr>
						<th>비고</th>
						<td>${requestScope.foodExpensesMap.foodexpensesetc} </td>
					</tr>
					<tr>
						<th class="last_radius">첨부 파일</th>
			            <td><a style="cursor: pointer;" href="<%= request.getContextPath()%>/download.groovy?pk_documentnum=${requestScope.foodExpensesMap.pk_documentnum }&apl_no=${requestScope.apl_no}">${requestScope.foodExpensesMap.orgfilename}</a></td> 
					</tr>
				</c:if>	
				<!-- 문서가 휴가신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '5' }">
					<tr>	
						<th class="first_radius">문서번호</th>
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
						<th class="last_radius">비고</th>
						<td>${requestScope.vacationMap.vetc} </td>
					</tr>
				</c:if>	
				<!-- 문서가 휴직신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '6' }">
					<tr>	
						<th class="first_radius">문서번호</th>
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
						<th class="last_radius">비고</th>
						<td>${requestScope.absenceMap.absenceetc} </td>
					</tr>
				</c:if>	
				<!-- 문서가 신규프로젝트신청일때 상세정보 -->
				<c:if test="${requestScope.apl_no eq '7' }">
					<tr>	
						<th class="first_radius">문서번호</th>
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
						<td>${requestScope.newProjectMap.projectpersoncnt}명</td>
					</tr>
					<tr>
						<th>참여자명단</th>
						<td>${requestScope.newProjectMap.projectpersonlist} </td>
					</tr>
					<tr>
						<th class="last_radius">첨부파일</th>
			            <td><a style="cursor: pointer;" href="<%= request.getContextPath()%>/download.groovy?pk_documentnum=${requestScope.newProjectMap.pk_documentnum }&apl_no=${requestScope.apl_no}">${requestScope.newProjectMap.orgfilename}</a></td> 
					</tr>
				</c:if>	
			</table>
			
			<form name="documentnumFrm">
				<div style="font-weight: bold; margin:20px 0;">승인자 의견</div>
				<textarea style="width: 100%; height: 100px; margin-bottom: 40px; background-color: #faf9f9;; " name="opinion"></textarea>
				<br>
				<input type="hidden" name="pk_documentnum" />
				<input type="hidden" name="apl_no" />
			</form>
			<button class="btn_wait" onclick="javascript:location.href='<%= ctxPath%>${requestScope.gobackURL}'">확인</button>
			<button class="btn_wait" type="button" onclick="app_fail()">반려하기</button>
			<button class="btn_wait" type="button" onclick="app_success()">승인하기</button>
			
			
	</div>


</body>
</html>