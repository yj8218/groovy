<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.empProfile > img {
		width: 45px;
		height: 45px;
		overflow: hidden;
	}

</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		//프로젝트 참여자명 검색 시 검색 목록 보여주기
		$("div#searchEmpList").hide();
		
		$("input#searchEmp").keyup(function() {
			
			const wordLength = $(this).val().trim().length;
			
			if(wordLength == 0) {
				$("div#searchEmpList").hide();
				$("div#defaultEmpList").show();
			}
			else {
				$.ajax({
					url:"<%= ctxPath %>/searchEmp.groovy",
					type:"POST",
					data:{"searchType":"name",
						  "searchWord":$("input#searchEmp").val()},
					dataType:"JSON",
					success:function(json) {
						
						let html = "";
						if(json.length > 0) { // 검색된 데이터가 있는 경우
							$.each(json, function(index, item) {
								html += "<tr style='border-bottom: solid 1px #eeeeee;'>";
								html += "	<td class='empProfile' style='cursor: pointer;' onclick='javascript:checkEmp(\""+item.pk_empnum+"\")'>";
								html += "		<input type='checkbox'/>"
								html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/프로필사진/"+ item.emppicturename +"' style='border-radius: 15px;'>";
								html += "		<span class='name font-weight-bold'>[" + item.deptnamekor + "]" + item.name + "</span>";
								html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>"	
								html += "	</td>";
								html += "</tr>";
							});
						}
						else {
							html += "<tr>";
							html += "	<td colspan='2' align='center'>검색 결과가 없습니다.</td>";
							html += "</tr>";
						}
						
						$("table#tblSearchEmpList").html(html);
						$("div#defaultEmpList").hide();
						$("div#searchEmpList").show();
					},
					error: function(request, status, error) {
		              	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
				}); // end of $.ajax({})
			}
		}); // end of $("input#searchWord").keyup(function() {})
		
	}); // end of $(document).ready(function(){})
	
	
	function checkEmp(pk_empnum) {
		
		let html = "<tr id='" + pk_empnum + "' onclick='javascript:uncheckEmp('" + pk_empnum + "')'><td>" + pk_empnum + "</td></tr>";
		
		$("table.tblChkEmpList").append(html);
	}
	
	function uncheckEmp(pk_empnum) {
		alert("tr#" + pk_empnum);
	}
</script>

<div id="content" style="display: flex; margin-bottom: 80px;">
<div style="margin: auto; width: 90%;">
	<!-- 검색창 -->
	<div>
		<div style="border: none; height: 100px; position: relative;">
			<!-- 참여자 검색 -->
			<div style="position: absolute; top: 30px; width: 100%;">
				<div style="position: relative;">
					<i class="fas fa-search" style="position: absolute; left: 13px; top: 12px; opacity: 0.6;"></i>
					<input type="text" id="searchEmp" placeholder="참여자명, 소속으로 검색" style="width: 100%; height: 40px; border: solid 1px #eee; border-radius: 5px; padding-left: 40px;"/>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<!-- 직원 목록, 검색 결과, 체크부분 -->
		<div class="row">
			<div class="col-6" style="border-top: solid 1px lightgray;">
					<!-- 참여자 목록(기본_검색 X) -->
					<div id="defaultEmpList">
						<table class="tblEmpList" style="width: 100%;">
				    		<c:forEach var="empvo" items="${requestScope.empvoList}">
				    		<tr style="border-bottom: solid 1px #eeeeee;">
				    			<td class="empProfile" style="cursor: pointer;" onclick="javascript:checkEmp('${empvo.pk_empnum}')">
				    				<input type="checkbox"/>
				    				<img class="my-2 mr-2" src="<%= ctxPath %>/resources/images/프로필사진/${empvo.emppicturename}" style="width: 40px; border-radius: 15px;">
				    				<span class="name font-weight-bold">[${empvo.deptnamekor}]&nbsp;${empvo.name}</span>
				    				<input type="hidden" id="pk_empnum" value="${empvo.pk_empnum}"/>
				    			</td>
				    		</tr>
			    			</c:forEach>
			    		</table>
					</div>
					<!-- 참여자 목록(검색 O) -->
					<div id="searchEmpList">
						<table id="tblSearchEmpList" class="tblEmpList" style="width: 100%;"></table>
					</div>
			</div>
			<div class="col-6" style="border-top: solid 1px lightgray; border-left: solid 1px lightgray;">
				<div id="chkEmpList">
					<table class="tblChkEmpList" style="width: 100%;"></table>
				</div>		
			</div>
		</div>
	</div>
</div>
</div>

<!-- 취소, 초대 버튼 -->
<div align="center" style="display: table; position: fixed; bottom: 0; width: 100%; height: 80px; background-color: white;">
	<div style="display: table-cell; vertical-align: middle;">
		<button>취소</button>
	</div>
	<div style="display: table-cell; vertical-align: middle;">
		<button>초대하기</button>
	</div>
</div>