package com.spring.groovy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.InterJodnDAO;

@Service
public class JodnService implements InterJodnService {
	
	@Autowired
	private InterJodnDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	// 결재 종류 가져오기
	@Override
	public List<ApprovalVO> approvalView() {
		List<ApprovalVO> approvalList = dao.approvalView();
		return approvalList;
	}




}//end of public class JodnService implements InterLeejhService
