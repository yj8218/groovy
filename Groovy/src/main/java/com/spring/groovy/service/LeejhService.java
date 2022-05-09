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
	
	
	//   === 로그인 처리하기  ===
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = dao.getLoginEmployee(paraMap);

		return loginuser;
	}
	
	//  === 로그인 기록 카운트  ===
	@Override
	public int getLoginHistory(String pk_empnum) {
		int n = dao.getLoginHistory(pk_empnum);
		return n;
	}
	
	// === 비밀번호 찾기 인증번호 발송 메서드 === //
	@Override
	public boolean sendCodeEmail(Map<String, String> paraMap) {
		boolean isExists = dao.sendCodeEmail(paraMap);
		return isExists;
	}

	// === 새비밀번호 업데이트 메서드(update) === //
	@Override
	public int newPwdUpdate(Map<String, String> paraMap) {
		int n = dao.newPwdUpdate(paraMap);
		return n;
	}
	

	//직원정보
	@Override
	public List<EmployeeVO> empList() {
		List<EmployeeVO> empList = dao.empList();
		return empList;
	}

	@Override
	public List<String> deptList() {
		List<String> deptList = dao.deptList();
		//System.out.println(deptList);
		return deptList;
	}



}//end of public class LeejhService implements InterLeejhService
