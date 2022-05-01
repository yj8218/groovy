package com.spring.groovy.service;

import java.util.List;

import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.EmployeeVO;

public interface InterJodnService {
	
	// 결재종류 가져오기
	List<ApprovalVO> approvalView();
	
	// 회계부서 직원 불러오기
	List<EmployeeVO> getAccountEmployee();

	// 영업부서 직원 불러오기
	List<EmployeeVO> getSalesEmployee();

	// 인사부서 직원 불러오기
	List<EmployeeVO> getPersonnelEmployee();

	// 총무부서 직원 불러오기
	List<EmployeeVO> getManagerEmployee();
	
}//end of public interface InterJodnService
