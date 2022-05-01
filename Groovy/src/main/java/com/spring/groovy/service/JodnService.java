package com.spring.groovy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.InterJodnDAO;

@Service
public class JodnService implements InterJodnService {
	
	@Autowired
	private InterJodnDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	// 결재 종류 가져오기
	@Override
	public List<ApprovalVO> approvalView() {
		List<ApprovalVO> approvalList = dao.approvalView();
		return approvalList;
	}
	
	// 회계부서 직원불러오기
	@Override
	public List<EmployeeVO> getAccountEmployee() {
		List<EmployeeVO> employeeList = dao.getAccountEmployee();
		return employeeList;
	}

	// 영업부서 직원불러오기
	@Override
	public List<EmployeeVO> getSalesEmployee() {
		List<EmployeeVO> employeeList = dao.getSalesEmployee();
		return employeeList;
	}

	// 인사부서 직원 불러오기
	@Override
	public List<EmployeeVO> getPersonnelEmployee() {
		List<EmployeeVO> employeeList = dao.getPersonnelEmployee();
		return employeeList;
	}

	// 총무부서 직원 불러오기
	@Override
	public List<EmployeeVO> getManagerEmployee() {
		List<EmployeeVO> employeeList = dao.getManagerEmployee();
		return employeeList;
	}




}//end of public class JodnService implements InterLeejhService
