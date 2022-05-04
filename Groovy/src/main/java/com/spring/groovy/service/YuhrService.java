package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.*;

@Service
public class YuhrService implements InterYuhrService {
	
	@Autowired
	private InterYuhrDAO dao;
	
	
	/////////////////////////////////////////////////////
	
	// 부서정보를 가져오기 위함
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departments = dao.getDepts();
		return departments;
	}

	// 직위정보를 가져오기 위함
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spots = dao.getSpots();
		return spots;
	}

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	@Override
	public String empDuplicatedCheck(Map<String, String> paraMap) {
		String s_using_infoVal = dao.empDuplicatedCheck(paraMap);
		return s_using_infoVal;
	}

	// 사원테이블에 사원정보 insert
	@Override
	public int addEmp(EmployeeVO empVo) {
		int n = dao.addEmp(empVo);
		return n;
	}

	// 직원정보를 가져오기 위함
	@Override
	public List<EmployeeVO> getEmps(Map<String, String> paraMap) {
		List<EmployeeVO> emps = dao.getEmps(paraMap);
		return emps;
	}

	// 조회한 조건에 따른 총 사원의 수
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}

	// 한 사원만 조회해오기
	@Override
	public EmployeeVO getOneEmpInfo(String pk_empnum) {
		EmployeeVO oneEmp = dao.getOneEmpInfo(pk_empnum);
		return oneEmp;
	}





}//end of public class YuhrService implements InterLeejhService
