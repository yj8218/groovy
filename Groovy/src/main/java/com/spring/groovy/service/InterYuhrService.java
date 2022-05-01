package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.*;

public interface InterYuhrService {

	// 부서명을 가져오기 위함
	List<DepartmentVO> getDepts();

	// 직위명을 가져오기 위함
	List<SpotVO> getSpots();

	// 사원번호 입력칸 유효성검사(중복검사, ajax 로 처리)
	String empnumCheck(Map<String, String> paraMap);

	// 사원테이블에 사원정보 insert
	int addEmp(EmployeeVO empVo);

}//end of public interface InterYuhrService
