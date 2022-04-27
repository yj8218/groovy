package com.spring.groovy.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class KimyjDAO implements InterKimyjDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	@Override
	public int test_insert() {
		int n = sqlsession.insert("kimyj.test_insert");
		return n;
	}


}//end of public class KimyjDAO implements InterKimyjDAO 
