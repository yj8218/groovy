package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.SpotVO;

public interface InterLeejhService {
	
	
	//   === 로그인 처리하기  
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);

	//  === 로그인 기록 카운트  
	int getLoginHistory(String pk_empnum);

	// === 비밀번호 찾기 시 입력한 이메일과 사원번호에  존재하는 사원정보에게 인증번호 발송 메서드 
	boolean sendCodeEmail(Map<String, String> paraMap);

	// === 새비밀번호 업데이트 메서드(update) 
	int newPwdUpdate(Map<String, String> paraMap);



	// === 직원정보 
	List<EmployeeVO> empList();
	// === 부서정보
	List<String> deptList();

	// === 로그인유저 정보얻어오기
	EmployeeVO getUserInfo(String pk_empnum);
		
	// === 연락처 수정 메서드 
	int myPhoneUpdate(Map<String, String> paraMap);
	// === 이메일 수정 메서드 
	int myEmailUpdate(Map<String, String> paraMap);

	
}//end of public interface InterLeejhService
