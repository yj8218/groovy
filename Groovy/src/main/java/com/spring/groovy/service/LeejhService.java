package com.spring.groovy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.*;


@Service
public class LeejhService implements InterLeejhService {
	
	@Autowired
	private InterLeejhDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	
	//  << 로그인 처리하기 >>
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = dao.getLoginEmployee(paraMap);

		return loginuser;
	}




}//end of public class LeejhService implements InterLeejhService
