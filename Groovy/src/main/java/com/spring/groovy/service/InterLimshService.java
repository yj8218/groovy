package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.EmployeeVO;

public interface InterLimshService {

	// 직원 목록 가져오기(select)
	List<EmployeeVO> showEmployeeList();

	// 검색한 프로젝트 참여자 목록 보여주기(select)
	List<EmployeeVO> searchEmp(Map<String, String> paraMap);

	// 사용자 프로필 보여주기(ajax) : 사진, 이름, 이메일, 전화번호
	EmployeeVO showEmpProfile(String pk_empnum);

	// 부서 목록 가져오기(select)
	List<DepartmentVO> getDeptvoList();

	// 부서별 직원 목록 가져오기(select)
	List<EmployeeVO> getEmpListByDept(String pk_deptnum);

	// 1:1 채팅 직원 정보 가져오기(select)
	EmployeeVO getEmp(String name);
	
}//end of public interface InterLimshService
