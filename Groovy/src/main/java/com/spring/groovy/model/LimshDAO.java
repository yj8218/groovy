package com.spring.groovy.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LimshDAO implements InterLimshDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 직원 목록 가져오기(select)
	@Override
	public List<EmployeeVO> showEmployeeList() {

		List<EmployeeVO> empvoList = sqlsession.selectList("limsh.showEmployeeList");
		
		return empvoList;
	}


}//end of public class LimshDAO implements InterLimshDAO
