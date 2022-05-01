package com.spring.groovy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.InterKimyjDAO;

@Service
public class KimyjService implements InterKimyjService {
	
	@Autowired
	private InterKimyjDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	@Override
	public int test_insert() {
		int n = dao.test_insert();
		
		return n;
		
	}




}//end of public class KimyjService implements InterLeejhService
