package com.spring.groovy.model;


import java.awt.Desktop;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.AES256;
import com.spring.groovy.common.Sha256;

@Repository
public class YuhrDAO implements InterYuhrDAO {
	
	@Autowired
	private AES256 aes;

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 부서명을 가져오기 위함
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departments = sqlsession.selectList("yuhr.getDepts");
		return departments;
	}

	// 직위명을 가져오기 위함
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spots = sqlsession.selectList("yuhr.getSpots");
		return spots;
	}

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	@Override
	public String empDuplicatedCheck(Map<String, String> paraMap) {
		
		String checkValue = paraMap.get("checkValue");
			
		try {
			
			if("email".equalsIgnoreCase(paraMap.get("checkColumn")) ) { // 이메일일 때는 암호화해서 중복검사한다.
				paraMap.put("checkValue", aes.encrypt(checkValue) );
			//	System.out.println("확인용  checkValue  ===>" +  paraMap.get("checkValue") );
				// 확인용  checkValue  ===>T0TLz6N3cmZtw3zusfANvfRzs15oXWs1K2WrrFitQhM=
			}

		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String s_using_infoVal = sqlsession.selectOne("yuhr.empnumCheck", paraMap);

		return s_using_infoVal;
	}

	// 사원테이블에 사원정보 insert
	@Override
	public int addEmp(EmployeeVO empVo) {
		
		String pwd = empVo.getPwd();
		empVo.setPwd(Sha256.encrypt(pwd)); //비밀번호 (SHA-256 암호화 대상)
		
		String phone = empVo.getPhone();
		String email = empVo.getEmail();
		
		System.out.println(phone);
		System.out.println(email);
		
		try {
			
//			empVo.setPhone(aes.encrypt(phone)); // 연락처 (AES-256 암호화/복호화 대상)
			empVo.setEmail(aes.encrypt(email)); // 이메일 (AES-256 암호화/복호화 대상)
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
		
		int n = sqlsession.insert("yuhr.addEmp", empVo);
		return n;
	}

	// 직원정보를 가져오기 위함
	@Override
	public List<EmployeeVO> getEmps(Map<String, String> paraMap) {
		
		List<EmployeeVO> emps = sqlsession.selectList("yuhr.getEmps", paraMap);
	/*	
		try {
			for(EmployeeVO emp : emps) {
				
				String email = emp.getEmail();
				
				// 전부 다 암호화 되어있어야하는데, 되어있는것도 있고 안되어있는 것도 있다.
				System.out.println("확인용 email 1 " + email);
				email = aes.decrypt(email);
				
				System.out.println("확인용 email 2 " + email);
				emp.setEmail(email);
			}
		
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
	*/	
		return emps;
	}

	// 조회한 조건에 따른 총 사원의 수
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuhr.getTotalCount", paraMap);
		return totalCount;
	}

	// 한명의 사원 상세정보 가져오기
	@Override
	public EmployeeVO getOneEmp(String pk_empnum) {
		EmployeeVO oneEmp = sqlsession.selectOne("yuhr.getOneEmp", pk_empnum);
		return oneEmp;
	}

	// 근태정보 가져오기
	@Override
	public List<CommuteStatusVO> getCommStatus() {
		List<CommuteStatusVO> commStatusList = sqlsession.selectList("yuhr.getCommStatus");
		return commStatusList;
	}

	// TBL_COMMUTE 에 오늘의 출근 insert
	@Override
	public int startWork(String pk_empnum) {
		int n = sqlsession.insert("yuhr.startWork",pk_empnum);
		return n;
	}

	// tbl_commute_status 에 지각 1 입력
	@Override
	public void status_late(String pk_empnum) {
		sqlsession.insert("yuhr.status_late",pk_empnum);
	}

	// 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지 확인하는 용도
	@Override
	public int isClickedStartBtn(String pk_empnum) {
		int n = sqlsession.selectOne("yuhr.isClickedStartBtn",pk_empnum);
		return n;
	}

	// tbl_commute 오늘의 자기 행에 퇴근 update
	@Override
	public int endWork(String pk_empnum) {
		int n = sqlsession.update("yuhr.endWork",pk_empnum);
		return n;
	}

	// tbl_commute_status 에 조기퇴근 1 update
	@Override
	public void status_early_endcheck(String pk_empnum) {
		sqlsession.update("yuhr.status_early_endcheck",pk_empnum);
		
	}

	// tbl_commute_status 에 퇴근미체크 1 update
	@Override
	public void status_no_endcheck(String pk_empnum) {
		sqlsession.update("yuhr.status_no_endcheck",pk_empnum);		
	}

	// tbl_commute_status 에 결근 1 update
	@Override
	public void status_no_workday(String pk_empnum) {
		sqlsession.insert("yuhr.status_no_workday",pk_empnum);		
	}


}//end of public class YuhrDAO implements InterYuhrDAO
