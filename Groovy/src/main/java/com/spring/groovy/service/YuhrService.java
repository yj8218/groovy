package com.spring.groovy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.InterYuhrDAO;

@Service
public class YuhrService implements InterYuhrService {
	
	@Autowired
	private InterYuhrDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////




}//end of public class YuhrService implements InterLeejhService
