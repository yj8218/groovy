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
		
	//	System.out.println(phone);
	//	System.out.println(email);
		
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
		
		try {
			for(EmployeeVO emp : emps) {
				
				String email = emp.getEmail();
				email = aes.decrypt(email);
				
				emp.setEmail(email);
			}
		
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
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
		
		try {
			String email = oneEmp.getEmail();
			email = aes.decrypt(email);
				
			oneEmp.setEmail(email);
		
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
		
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
	public void status_no_endcheck() {
		sqlsession.update("yuhr.status_no_endcheck");		
	}

	// tbl_commute_status 에 결근 1 update
	@Override
	public void status_no_workday(String pk_empnum) {
		sqlsession.insert("yuhr.status_no_workday",pk_empnum);		
	}

	// 모든 사원의 부서,재직여부,근태정보들,총근무일수,총근무시간
	@Override
	public List<Map<String, String>> getCommuteStatusInfo(Map<String, String> paraMap) {
		List<Map<String, String>> commuteStatusInfo = sqlsession.selectList("yuhr.getCommuteStatusInfo", paraMap);
		return commuteStatusInfo;
	}

	// 로그인한 사원의 오늘 근무한 시간을 초단위까지 db 에 update
	@Override
	public int todayworkedtime(String pk_empnum) {
		int m = sqlsession.update("yuhr.todayworkedtime", pk_empnum);
		return m;
	}

	// 한 사원의 출퇴근기록, 근태관리 기록을 다 가져온다
	@Override
	public List<Map<String, String>> showOneCommuteStatus(Map<String, String> paraMap) {
		List<Map<String, String>> OneCommuteStatus = sqlsession.selectList("yuhr.showOneCommuteStatus", paraMap);
		return OneCommuteStatus;
	}

	// 조회한 조건에 따른 총 근태의 수
	@Override
	public int getCommuteTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuhr.getCommuteTotalCount",paraMap);
		return totalCount;
	}

	// 오늘 휴무 아닌데 출근 안한 사원들의 empnum
	@Override
	public List<String> getEmpsNoWorkToday() {
		List<String> empsNoWorkToday = sqlsession.selectList("yuhr.getEmpsNoWorkToday");
		return empsNoWorkToday;
	}

	// 출석 한 시각 알아오기
	@Override
	public Map<String, String> getStartWorkTime(String login_empnum) {
		Map<String, String> startWorkTime = sqlsession.selectOne("yuhr.getStartWorkTime", login_empnum);
		return startWorkTime;
	}

	// 조회한 조건에 따른 한 사원의 총 근태기록의 수
	@Override
	public int getTotalCountByOne(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuhr.getTotalCountByOne", paraMap);
		return totalCount;
	}



}//end of public class YuhrDAO implements InterYuhrDAO
