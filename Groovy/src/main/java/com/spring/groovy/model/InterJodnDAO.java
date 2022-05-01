package com.spring.groovy.model;

import java.util.List;

public interface InterJodnDAO {

	// 결재 종류 가져오기
	List<ApprovalVO> approvalView();

	// 회계부서 직원 불러오기
	List<EmployeeVO> getAccountEmployee();

	// 영업부서 직원 불러오기
	List<EmployeeVO> getSalesEmployee();

	// 인사부서 직원 불러오기
	List<EmployeeVO> getPersonnelEmployee();

	// 총무부서 직원 불러오기
	List<EmployeeVO> getManagerEmployee();


}//end of public interface InterJodnDAO
