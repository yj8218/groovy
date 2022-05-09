package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.*;

public interface InterYuhrService {

	// 부서명을 가져오기 위함
	List<DepartmentVO> getDepts();

	// 직위명을 가져오기 위함
	List<SpotVO> getSpots();

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	String empDuplicatedCheck(Map<String, String> paraMap);

	// 사원테이블에 사원정보 insert
	int addEmp(EmployeeVO empVo);

	// 직원정보를 가져오기 위함
	List<EmployeeVO> getEmps(Map<String, String> paraMap);

}//end of public interface InterYuhrService
