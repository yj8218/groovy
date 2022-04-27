package com.spring.groovy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.InterJodnDAO;

@Service
public class JodnService implements InterJodnService {
	
	@Autowired
	private InterJodnDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////




}//end of public class JodnService implements InterLeejhService
