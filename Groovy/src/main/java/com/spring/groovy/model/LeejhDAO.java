package com.spring.groovy.model;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.model.EmployeeVO;

@Repository
public class LeejhDAO implements InterLeejhDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////
	
	
	//  << 로그인 처리하기>> 
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = sqlsession.selectOne("leejh.getLoginEmployee", paraMap);
		
		return loginuser;
	}


}//end of public class LeejhDAO implements InterLeejhDAO
