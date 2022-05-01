package com.spring.groovy.service;

import java.util.Map;

import com.spring.groovy.model.EmployeeVO;

public interface InterLeejhService {
	
	//  << 로그인 처리하기 >>
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);
	
}//end of public interface InterLeejhService
