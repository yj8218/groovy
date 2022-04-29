package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

public interface InterYuhrDAO {

	// 부서명을 가져오기 위함
	List<DepartmentVO> getDepts();

	// 직위명을 가져오기 위함
	List<SpotVO> getSpots();

	// 사원번호 입력칸 유효성검사(중복검사, ajax 로 처리)
	String empnumCheck(Map<String, String> paraMap);


}//end of public interface InterYuhrDAO
