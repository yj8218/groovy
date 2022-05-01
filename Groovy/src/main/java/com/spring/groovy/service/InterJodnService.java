package com.spring.groovy.service;

import java.util.List;

import com.spring.groovy.model.ApprovalVO;

public interface InterJodnService {
	
	// 결재종류 가져오기
	List<ApprovalVO> approvalView();
	
}//end of public interface InterJodnService
