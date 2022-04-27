package com.spring.groovy.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LeejhDAO implements InterLeejhDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////


}//end of public class LeejhDAO implements InterLeejhDAO
