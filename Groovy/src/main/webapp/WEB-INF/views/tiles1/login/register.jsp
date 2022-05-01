<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	String ctxPath = request.getContextPath();
%>   


<style type="text/css" >
	div.container {
		width: 100%;
		margin: 0 auto;
		
	}
	
	form[name="registerFrm"] {
		width: 586px;
		margin: 0 auto;
	}
	
	span.title {
		display: inline-block;
	    margin-bottom: 10px;
	    padding: 3px 0;
	    font-size: 16px;
	    color: #333;
	    font-weight: 700;
	    text-align: left;
	}

	
	input.requiredInfo {
	    width: 586px;
	    height: 52px;
	    border: 1px solid #ddd;
	    -webkit-border-radius: 8px;
	    border-radius: 8px;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	    padding-left: 20px;
	}
	
	div#agreeCheck {
		margin-top: 20px;
	}
	
	a.agree {
		font-weight: bold;
		color: #623ad6;
	}
	
	a.agree:hover {
		cursor: pointer;
	}
	
	button.btn {
		display: inline;
	    color: #fff;
	    text-align: center;
	    background: #623ad6;
	    line-height: 52px;
	    height: 52px;
	    width: 48%;
	    -webkit-border-radius: 8px;
	    border-radius: 8px;
	    margin-top: 20px;
	    font-weight: 486px;
	    font-size: 16px;
	}	
	
	button#goRegister:hover {
		font-weight: bold;
		filter: brightness(90%);
		cursor: pointer;
	}
	
	div#registerBtn{padding: 70px 0 130px 0;}
</style>

<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 카카오 주소 api -->

<script type="text/javascript">	
	$(document).ready(function(){
		$("span.error").hide();
		$("input#name").focus();
		
		let b_flagEmpnumuplicateClick = false;
		// 등록하기 버튼 클릭시 "사원번호 중복확인" 을 클릭했는지를 알아보기 위한 용도
		
		
		// 1. 이름 입력칸 유효성검사
		$("input#name").blur(function(){
			
			const $target = $(this);
			const name = $target.val().trim();
			
			if(name == ""){ // 입력하지 않거나 공백만 입력했을 경우
				$("form.registerFrm :input").prop("disabled", true);
				$target.prop("disabled",false);
				
			    $target.next().show();
				$target.focus();
			}
			else{// 제대로 입력했을 경우
				$("form.registerFrm :input").prop("disabled", false);
				$target.next().hide();
			}
		});// -------------------------------------------------
		
		
		// 2. 이메일 입력칸 유효성검사
		$("input#email").blur(function(){
			
			const $target = $(this); 
			
	     	// 이메일 정규표현식 객체 생성
	        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
			
		 	const bool = regExp.test($target.val());
		 
			if(!bool){ // 이메일 정규표현식에 위배시
				$("form.registerFrm :input").prop("disabled", true);
				$target.prop("disabled",false);
				
			    $target.next().show();
				$target.focus();
			}
			else{ // 이메일정규표현식에 통과시
				$("form.registerFrm :input").prop("disabled", false);
				$target.next().hide();
			}
		});// -------------------------------------------------
		
		
		// 3. 휴대폰번호 입력칸 유효성검사
		$("input#phone").blur(function(){
			
			const $target = $(this);
			
		    // 휴대폰번호 정규표현식 객체 생성(010-1234-1234 또는 010-123-1234 만 가능)
	        const regExp = new RegExp(/^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/g); 
			
		 	const bool = regExp.test($target.val());
		 
			if(!bool){ // 휴대폰번호 정규표현식에 위배시
				$("form.registerFrm :input").prop("disabled", true);
				$target.prop("disabled",false);
				
			    $target.next().show();
				$target.focus();
			}
			else{ // 국번이 정규표현식에 통과시 
				$("form.registerFrm :input").prop("disabled", false);
				$target.next().hide();
			}
			
		});// -------------------------------------------------
		
		
		// 4. 부서 선택시 사원번호(아이디)와 초기비밀번호 자동입력
		// 부서는 사원번호(아이디)가 유효성검사를 통과하기 위해서 반드시 선택해야하므로, 부서 선택에 유효성검사를 또 하지 않는다.
		// 6. 초기비밀번호는 자동으로 입력되므로 유효성검사를 하지 않는다.
		$("select#fk_deptnum").change(function(){
			
			const $target = $(this);
		//	alert($target.val());
			
		    $("input#deptnumOfEmpnum").val($target.val()+"-");
		    $("input#pwd").val($target.val()+"-");
			
		});// -------------------------------------------------
		
		
		// 5. 사원번호 입력칸 유효성검사(+중복검사)
		$("img#empnumCheck").click(function(){
		  
			b_flagEmpnumuplicateClick = true;
			
			const pk_empnum = $("input#deptnumOfEmpnum").val() + $("input#pk_empnum").val() ; // 입력된 전체 사원번호
			
			if($("input#deptnumOfEmpnum").val() == ""){ // 부서선택을 안해서 부서번호칸에 아무것도 안들어있을때
				$("span#empnumcheckResult").html("부서를 먼저 선택하세요.").css("color","orange");
			}
			else{ // 부서 선택해서 부서번호칸에 값이 들어오고나서 사원번호 중복검사
				if(!Number($("input#pk_empnum").val())){ // 사원번호칸에 문자열이 들어왔을 때
					$("span#empnumcheckResult").html("사원번호는 숫자만 입력해주세요.").css("color","orange");
					$("input#pk_empnum").val("");
				}
				else{// 사원번호칸에 숫자를 제대로 입력했을 때
					// (+중복검사) ajax
					$.ajax({
		        	      url:"<%= ctxPath%>/empnumCheck.groovy",
		        	      data:{"pk_empnum":pk_empnum},
		        	      success:function(text){
		        	    	  
		        	    	  const json = JSON.parse(text); // JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환
		        	    	  
		        	    	  let s_deptnum = $("input#pk_empnum").val();
		        	    	  const dash = s_deptnum.indexOf('-'); // 없으면 -1
		        	    	  s_deptnum = s_deptnum.substring(0,dash);
		        	    	  
		       	    	      // 입력된 전체 사원번호 -> true 면 중복된거고, false 면 중복안된것
		           	    	  if(json.isEmpnumDuplicated) { // 중복인경우
		           	    		  $("span#empnumcheckResult").html($("input#pk_empnum").val() +" 은 이미 사용중인 사원번호입니다").css("color","orange");
		           	    		  $("input#pk_empnum").val("");
		           	    	  }
		           	    	  else { // 중복아닌경우
		           	    		  $("span#empnumcheckResult").html($("input#pk_empnum").val() +" 은 사용가능한 사원번호입니다").css("color","green");
		           	    	  	  $("input#pwd").val(pk_empnum);	
		           	    	  	  $("input#total_pk_empnum").val(pk_empnum);
		           	    	  }	  
		        	      },
		        	      error:function(request, status, error){
		        	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        	      }
		          	});// end of ajax
				}
			}
	     });// end of $("img#empnumCheck").click(function(){
		
		
	  	// 8. 월급 입력칸 유효성검사
		$("input#s_salary").bind("keyup", function(){
			
			const s_inputVal = $(this).val();
			const n_inputVal = Number(s_inputVal.replaceAll(',', ''));
			
			if(isNaN(n_inputVal)) {//NaN인지 판별
				$("input#s_salary").val("");
			}
			else{
				const formatValue = n_inputVal.toLocaleString();
				$("input#s_salary").val(formatValue);
				
				// Number 타입의 n_salary 를 submit() 하기 위함 
				$("input#n_salary").val(Number(formatValue.replaceAll(',', '')) );
				
			}
			
			
		});// -------------------------------------------------
			
		
		// 우편번호 찾기
		$("img#zipcodeSearch").click(function(){
			
	  		new daum.Postcode({
          	oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            let addr = ''; // 주소 변수
            let extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            
            } else {
                document.getElementById("detailaddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailaddress").focus();
          	}
	      }).open();
	  		
	});// end of $("img#zipcodeSearch").click(function()
		
			
		//=== 생일 입력칸에 jQuery UI 의 datepicker 사용 === //
		// === 전체 datepicker 옵션 일괄 설정하기 ===  
		//     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
  		$(function() {
	      //모든 datepicker에 대한 공통 옵션 설정
	      $.datepicker.setDefaults({
	    	  dateFormat: 'yy-mm-dd'  //Input Display Format 변경
              ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
              ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
              ,changeYear: true        //콤보박스에서 년 선택 가능
              ,changeMonth: true       //콤보박스에서 월 선택 가능                
              ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
              ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
              ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
              ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
              ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
              ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
              ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
              ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
              ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
      });

	    //input을 datepicker로 선언
        $("input#birthday").datepicker();                    
        $("input#startday").datepicker();
          
        // startday의 초기값을 오늘 날짜로 설정
        $('input#startday').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
          

  });// end of $(function() 
      ///////////////////////////////////////////////////////////////////
		
      	// 사원번호 값이 변경되면, 등록하기 버튼 클릭시 "사원번호중복확인" 을 클릭했는지를 알아보기 위한 용도를 초기화한다
		$("input#pk_empnum").bind("change", function(){
			b_flagEmpnumuplicateClick = false;
			$("input#total_pk_empnum").val(""); // 제출할 사원번호값도 초기화한다.
		});
      
      
      	// 사원 등록하기
		$("button#goRegister").click(function(){
			
			// ** 필수입력 사항에 모두 입력이 되었는지 검사한다. ** //
			// 9. 주소, 10. 생일, 12. 입사일자 유효성검사 포함
			let b_FlagRequiredInfo = true;
			
			$("input.requiredInfo").each(function(index, item){
				const data = $(item).val().trim();
				if(data == ""){
					alert("아직 입력되지 않은 정보가 있습니다. 입력사항은 모두 입력해주세요");
					b_FlagRequiredInfo = false;
					return false; // break;
				}
			});
			
			if(!b_FlagRequiredInfo){// 필수입력사항 중 입력안된게 있으면 그 다음으로 넘어가지 말고 종료
				return; // 종료
			}
			
			// 부서는 사원번호와 초기비밀번호를 입력하려면 반드시 선택해야하므로 검사를 따로 하지 않는다.
			
			// 7. 직위 유효성검사
			if($("select#fk_spotnum").val() == ""){
				alert("직위를 선택해주세요");
				return; // 종료
			}
			
			// 11. 성별 유효성검사 //
			const genderCheckedLength = $("input:radio[name=gender]:checked").length;
			if(genderCheckedLength == 0){
				alert("성별을 선택해주세요");
				return; // 종료
			}
			
			// ** 사원번호 중복확인을 통과 했는지 검사한다. ** //
			// b_flagEmpnumuplicateClick
			if(!b_flagEmpnumuplicateClick){// 사원번호 중복확인 버튼을 클릭하지 않았을 때
				alert("사원번호 중복확인 버튼을 클릭하여 사원번호 중복검사를 하세요");
				return; // 종료
			}
			
			// 제출요청
			const frm = document.registerFrm;
			frm.action = "<%= ctxPath%>/registerEnd.groovy"; 
			frm.method = "POST";
			frm.submit();
		
		});	// end of $("input#btnRegister").click(function(){
			
			
			
	});// end of $(document).ready(function()
</script>



<div class="container">
<%--
EMPNUM          v     NUMBER(10)    
PWD             v     VARCHAR2(200) 
NAME            v     VARCHAR2(20)  
ADDRESS              VARCHAR2(100) 
detailaddress        VARCHAR2(100) 
detailaddress         VARCHAR2(100) 
POSTCODE             VARCHAR2(20)  
PHONE           v     VARCHAR2(200) 
EMAIL           v     VARCHAR2(200) 
BIRTHDAY        v     DATE          
GENDER          v     VARCHAR2(10)  
REGISTERDAY     d     DATE          가입일자
STARTDAY        v     DATE          입사일자
RESIGNATIONSTATUS  d  NUMBER(1)     퇴사상태(0,1)
RESIGNATIONDAY       DATE          퇴사일자
FK_VSTATUS      d     NUMBER(1)     휴가상태(0,1)
FK_DEPTNUM      v     NUMBER        부서번호
FK_SPOTNUM      v     NUMBER        직위번호
EMPPICTURENAME  v     VARCHAR2(20)  직원사진
SALARY          v     NUMBER(20) 	월급
 --%> 
 
 
   
   <h1 align="center">사원 등록</h1>
       <form name="registerFrm"
	  		enctype="multipart/form-data" >
	  	 <%-- 1. 이름 --%>
       	 <span class="title">이름</span><br>
         <input type="text" class="requiredInfo" id="name" name="name" maxlength="20" required  placeholder="이름">
       	 <span class="error">이름은 필수입력 사항입니다.</span>
       	 	    
         <br><br>
         <%-- 2. 이메일 --%>
         <span class="title">이메일</span><br>
         <input type="email" class="requiredInfo" id="email" name="email" size="20" required placeholder="example@gmail.com" />
         <span class="error">이메일 형식에 맞게 입력해주세요.</span>
            
         <br><br>
         <%-- 3. 휴대폰번호 --%>
         <span class="title">휴대폰번호</span><br>
         <input type="text" class="requiredInfo" id="phone" name="phone" maxlength="20" required  placeholder="010-1234-1234">
         <span class="error">휴대폰번호 형식에 맞게 입력해주세요.</span>

         <br><br>
		 <!-- 부서선택시 자동으로 사원번호와 비밀번호 처음부분 입력됨 -->         
         <%-- 4. 부서 --%>
         <span class="title">부서</span><br>
         <select class="requiredInfo" id="fk_deptnum" name="fk_deptnum" required style="width: 130px; padding: 8px;">
         	<option value ="">부서선택</option>
         	<c:forEach var="departments" items="${requestScope.departments }">
         		<option value ="${departments.pk_deptnum}">${departments.deptnamekor}</option>
         	</c:forEach>
	     </select>
	     <span class="error">부서를 선택해주세요.</span>
                  
         <br><br>
         <%-- 5. 사원번호(아이디) --%>
         <span class="title">사원번호(아이디)</span><br>
         <input type="text" class="requiredInfo" id="deptnumOfEmpnum" placeholder="부서를 먼저 선택하세요."  required readonly>
         <input type="text" class="requiredInfo" id="pk_empnum"  maxlength="20" required placeholder="사원번호(아이디)">
         <input type="hidden" class="requiredInfo" id="total_pk_empnum" name="pk_empnum" maxlength="20" required placeholder="사원번호(아이디)">
         <!-- 사원번호(아이디)중복체크 -->
	     <img id="empnumCheck" src="<%=ctxPath%>/resources/images/common/b_id_check.gif" style="vertical-align: middle;" />
	     <span id="empnumcheckResult"></span>
	             
         <br><br>
         <%-- 6. 초기 비밀번호 --%>
         <span class="title">초기 비밀번호</span><br>
         <input type="text" class="requiredInfo" id="pwd" name="pwd" size="20" required placeholder="초기 비밀번호는 자동으로 설정됩니다." readonly/>
         
         
         <br><br>
         <%-- 7. 직위--%>
         <span class="title">직위</span><br>
         <select class="requiredInfo" id="fk_spotnum" name="fk_spotnum" required style="width: 130px; padding: 8px;">
         	<option value ="">직위선택</option>
         	<c:forEach var="spots" items="${requestScope.spots }">
         		<option value ="${spots.pk_spotnum}">${spots.spotnamekor}</option>
         	</c:forEach>
	     </select>
	     <span class="error">직위를 선택해주세요.</span>
	     
         <br><br>
         <%-- 8. 월급--%>
         <span class="title">월급</span><br>
         <input type="text" class="requiredInfo" id="s_salary" required  placeholder="월급">
         <input type="hidden" class="requiredInfo" id="n_salary" name="salary"  required  placeholder="월급">
         <span class="error">월급를 입력해주세요.</span>
         
         <br><br>
         <%-- 9. 주소--%>
         <span class="title">주소</span><br>
         <input type="text" class="requiredInfo" id="postcode" name="postcode" size="6" maxlength="5" required placeholder="우편번호" />&nbsp;&nbsp;
         
         <%-- 우편번호 찾기 --%>
         <img id="zipcodeSearch" src="<%=ctxPath %>/resources/images/common/b_zipcode.gif" style="vertical-align: middle;" />
         <span class="error">우편번호 형식이 아닙니다.</span>
         
         <input type="text" class="requiredInfo" id="address" name="address" maxlength="20" size="40" required placeholder="주소" /><br/>
         <input type="text" class="requiredInfo" id="detailaddress" name="detailaddress" size="40" placeholder="상세주소" />
         <span class="error">주소를 입력하세요</span>
	            
         <br><br>
         <%-- 10. 생일--%>
         <span class="title">생일</span><br>
         <input type="text" class="requiredInfo" id="birthday" name="birthday" maxlength="20" required  placeholder="생일">
         
         <br><br>
         <%-- 11. 성별--%>
         <span class="title">성별</span><br>
         <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
	     <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	            
         <br><br>
         <%-- 12. 입사일자--%>
         <span class="title">입사일자</span><br>
         <input type="text" class="requiredInfo" id="startday" name="startday" maxlength="20" required  placeholder="이름">
         
         
         <br><br>
         <%-- 13. 사진 --%>
         <span class="title">사진</span><br>
         <input type="file" class="requiredInfo" id="emppicturename" name="attach"  required style="border:none; padding-left: 4px;">
         
                  
         
         
         <div id ="registerBtn">
            <button type="button" id="goRegister" class="btn">사원 등록</button>
            <button type="reset" class="btn">사원 등록 취소</button>
         </div>
      </form>
</div>

