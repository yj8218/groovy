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

	// === 부서정보을 가져오기 위함 ===
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departList = dao.getDepts();
		return departList;
	}

	// === 직위정보을 가져오기 위함 ===
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spotList = dao.getSpots();
		return spotList;
	}

	// === 직원정보를 가져오기 위함 === 
	@Override
	public List<EmployeeVO> getEmpList(Map<String, String> paraMap) {
		List<EmployeeVO> empList = dao.getEmpList(paraMap);
		return empList;
	}




}//end of public class LeejhService implements InterLeejhService
