package com.spring.groovy.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JodnDAO implements InterJodnDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 결재 종류 가져오기
	@Override
	public List<ApprovalVO> approvalView() {
		List<ApprovalVO> approvalList = sqlsession.selectList("jodn.approvalView");
		return approvalList;
	}
	
	// 회계부서 직원 불러오기
	@Override
	public List<EmployeeVO> getAccountEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getAccountEmployee");
		return employeeList;
	}

	// 영업부서 직원 불러오기
	@Override
	public List<EmployeeVO> getSalesEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getSalesEmployee");
		return employeeList;
	}

	// 인사부서 직원 불러오기
	@Override
	public List<EmployeeVO> getPersonnelEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getPersonnelEmployee");
		return employeeList;
	}

	// 총무부서 직원 불러오기
	@Override
	public List<EmployeeVO> getManagerEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getManagerEmployee");
		return employeeList;
	}


}//end of public class JodnDAO implements InterJodnDAO
