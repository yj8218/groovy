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
	
	// 로그인유저 정보얻어오기
	@Override
	public EmployeeVO getUserInfo(String pk_empnum) {
		EmployeeVO loginuser  = dao.getUserInfo(pk_empnum);
		return loginuser;
	}
		
	// === 연락처 수정 메서드 === 
	@Override
	public int myPhoneUpdate(Map<String, String> paraMap) {
		int n = dao.myPhoneUpdate(paraMap);
		return n;
	}
	
	// === 이메일 수정 메서드 === 
	@Override
	public int myEmailUpdate(Map<String, String> paraMap) {
		int n = dao.myEmailUpdate(paraMap);
		return n;
	}
	// === 주소 수정 메서드 
	@Override
	public int myAddressUpdate(Map<String, String> paraMap) {
		int n = dao.myAddressUpdate(paraMap);
		return n;
	}
	// === 비밀번호 수정
	@Override
	public int myPwdUpdate(Map<String, String> paraMap) {
		int n = dao.myPwdUpdate(paraMap);
		return n;
	}


}//end of public class LeejhService implements InterLeejhService
