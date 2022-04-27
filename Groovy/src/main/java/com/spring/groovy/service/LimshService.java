package com.spring.groovy.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.InterLimshDAO;

@Service
public class LimshService implements InterLimshService {
	
	@Autowired
	private InterLimshDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////




}//end of public class LimshService implements InterLeejhService
