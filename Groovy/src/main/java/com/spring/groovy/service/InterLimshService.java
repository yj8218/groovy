package com.spring.groovy.service;

import java.util.List;

import com.spring.groovy.model.EmployeeVO;

public interface InterLimshService {

	// 직원 목록 가져오기(select)
	List<EmployeeVO> showEmployeeList();
	
}//end of public interface InterLimshService
