package com.spring.groovy.model;

import java.util.Map;

public interface InterLeejhDAO {
	
	
	// === 로그인 처리하기 ===
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);

	// === 로그인 기록 카운트 ===
	int getLoginHistory(String pk_empnum);

	// === 비밀번호 찾기 시 입력한 이메일과 사원번호에  존재하는 사원정보에게 인증번호 발송 메서드 === //
	boolean sendCodeEmail(Map<String, String> paraMap);

	// === 새비밀번호 업데이트 메서드(update) === //
	int newPwdUpdate(Map<String, String> paraMap);
	

}//end of public interface InterLeejhDAO
