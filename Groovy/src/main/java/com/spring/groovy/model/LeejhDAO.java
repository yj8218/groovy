package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groovy.model.EmployeeVO;

@Repository
public class LeejhDAO implements InterLeejhDAO {

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

	// === 부서정보을 가져오기 위함 ===
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departList = sqlsession.selectList("leejh.getDepts");
		return departList;
	}
	
	// === 직위정보을 가져오기 위함 ===
	@Override
	public List<SpotVO> getSpots() {
		 List<SpotVO> spotList = sqlsession.selectList("leejh.getSpots");
		return spotList;
	}

	// === 직원정보을 가져오기 위함 ===
	@Override
	public List<EmployeeVO> getEmpList(Map<String, String> paraMap) {
		List<EmployeeVO> empList = sqlsession.selectList("leejh.getEmpList");
		return empList;
	}


}//end of public class LeejhDAO implements InterLeejhDAO
