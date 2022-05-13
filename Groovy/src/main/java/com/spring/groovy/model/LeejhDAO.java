package com.spring.groovy.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.EmployeeVO;

@Repository
public class LeejhDAO implements InterLeejhDAO {
	@Autowired
	private AES256 aes;
	
	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////
	
	
	//  << 로그인 처리하기>> 
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = sqlsession.selectOne("leejh.getLoginEmployee", paraMap);
		
		
		
		return loginuser;
	}
	
	// << 로그인 기록 카운트 >>
	@Override
	public int getLoginHistory(String pk_empnum) {
		int n = sqlsession.selectOne("leejh.getLoginHistory", pk_empnum);
		return n;
	}
	
	// === 비밀번호 찾기 시 입력한 이메일과 사원번호에  존재하는 사원정보에게 인증번호 발송 메서드 === //
	@Override
	public boolean sendCodeEmail(Map<String, String> paraMap) {
		String employeeid = sqlsession.selectOne("leejh.sendCodeEmail", paraMap);
		boolean isExists = false;
		
		if(employeeid != null) {
			isExists = true;
		}
		else {
			isExists = false;
		}
		
		return isExists;
	}

	// === 새비밀번호 업데이트 메서드(update) === //
	@Override
	public int newPwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.newPwdUpdate", paraMap);
		return n;
	}


	// === 직원정보을 가져오기  ===


	@Override
	public List<EmployeeVO> empList() {
		List<EmployeeVO> empList = sqlsession.selectList("leejh.empList");
		return empList;
	}

	@Override
	public List<String> deptList() {
		
		 List<String> deptList = sqlsession.selectList("leejh.deptList");
		return deptList;
	}
	
	
	// === 연락처 수정 메서드 === 
	@Override
	public int myPhoneUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myPhoneUpdate", paraMap);
		System.out.println("test");
		return n;
	}

	//유저 정보 얻어오기
	@Override
	public EmployeeVO getUserInfo(String pk_empnum) {
		EmployeeVO loginuser = sqlsession.selectOne("leejh.getUserInfo", pk_empnum);
		
		return loginuser;
	}
	// === 이메일 수정 메서드 ===
	@Override
	public int myEmailUpdate(Map<String, String> paraMap) {
		String myemail = paraMap.get("myemail");
		
		try {
			paraMap.put("myemail", aes.encrypt(myemail) );
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		int n = sqlsession.update("leejh.myEmailUpdate", paraMap);
		return n;
	}
	
	// === 주소 수정 메서드 ===
	@Override
	public int myAddressUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myAddressUpdate", paraMap);
		return n;
	}
	// === 비밀번호 수정 메서드 === 
	@Override
	public int myPwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myPwdUpdate", paraMap);
		return n;
	}



}//end of public class LeejhDAO implements InterLeejhDAO
