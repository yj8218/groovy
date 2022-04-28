package com.spring.groovy.model;

import java.util.Map;

public interface InterLeejhDAO {
	
	//  ** 로그인 처리하기 
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);
	

}//end of public interface InterLeejhDAO
