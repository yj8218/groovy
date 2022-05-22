package com.spring.groovy.service;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.*;

@Service
public class YuhrService implements InterYuhrService {
	
	@Autowired
	private InterYuhrDAO dao;
	
	
	/////////////////////////////////////////////////////
	
	// 부서정보를 가져오기 위함
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departments = dao.getDepts();
		return departments;
	}

	// 직위정보를 가져오기 위함
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spots = dao.getSpots();
		return spots;
	}

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	@Override
	public String empDuplicatedCheck(Map<String, String> paraMap) {
		String s_using_infoVal = dao.empDuplicatedCheck(paraMap);
		return s_using_infoVal;
	}

	// 사원테이블에 사원정보 insert
	@Override
	public int addEmp(EmployeeVO empVo) {
		int n = dao.addEmp(empVo);
		
		return n;
	}

	// 직원정보를 가져오기 위함
	@Override
	public List<EmployeeVO> getEmps(Map<String, String> paraMap) {
		List<EmployeeVO> emps = dao.getEmps(paraMap);
		return emps;
	}

	// 조회한 조건에 따른 총 사원의 수
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}

	// 한명의 사원 상세정보 가져오기
	@Override
	public EmployeeVO getOneEmp(String pk_empnum) {
		EmployeeVO oneEmp = dao.getOneEmp(pk_empnum);
		return oneEmp;
	}

	// 근태정보 가져오기
	@Override
	public List<CommuteStatusVO> getCommStatus() {
		List<CommuteStatusVO> commStatusList = dao.getCommStatus();
		return commStatusList;
	}

	// TBL_COMMUTE 에 오늘의 출근 시각 insert
	@Override
	public int startWork(String pk_empnum) {
		int n = dao.startWork(pk_empnum);
		
		return n;
	}

	// tbl_commute_status 에 지각 1 입력
	@Override
	public void status_late(String pk_empnum) {
		dao.status_late(pk_empnum);
	}

	// 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지 확인하는 용도
	@Override
	public int isClickedStartBtn(String pk_empnum) {
		int n = dao.isClickedStartBtn(pk_empnum);
		return n;
	}

	// tbl_commute 오늘의 자기 행에 퇴근 update
	@Override
	public int endWork(String pk_empnum) {
		int n = dao.endWork(pk_empnum);
		return n;
	}
	
	// tbl_commute_status 에 조기퇴근 1 update
	@Override
	public void status_early_endcheck(String pk_empnum) {
		dao.status_early_endcheck(pk_empnum);
		
	}
	
	// === Spring Scheduler 를 사용하여 자정에 자동으로 근태 기록하기 ===
	@Override
	@Scheduled(cron = "0 0 0 * * *") // 자정에 작동된다
	public void checkEndCommuteStatus() {

		// == 현재 시각을 나타내기 ==
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = dateFormat.format(currentDate.getTime());

	//	System.out.println("checkEndCommuteStatus Spring Scheduler 작동시간 => " + currentTime);
		
		try { 
	         Desktop.getDesktop().browse(new URI("http://localhost:9090/groovy/checkEndCommuteStatus.groovy")); 
	         // WAS 컴퓨터에서만 특정 웹페이지를 실행시켜주는 것이지, WAS에 접속한 다른 클라이언트 컴퓨터에서는 특정 웹사이트를 실행시켜주지 않는다.
	      } catch (IOException e) { 
	         e.printStackTrace(); 
	      } catch (URISyntaxException e) {
	         e.printStackTrace(); 
	      }
	}
		
	// tbl_commute_status 에 퇴근미체크 1 update
	@Override
	public void status_no_endcheck() {
		dao.status_no_endcheck();
		
	}

	// tbl_commute_status 에 결근 1 update
	@Override
	public void status_no_workday(String pk_empnum) {
		dao.status_no_workday(pk_empnum);
		
	}
	
	// 모든 사원의 부서,재직여부,근태정보들,총근무일수,총근무시간
	@Override
	public List<Map<String, String>> getCommuteStatusInfo(Map<String, String> paraMap) {
		List<Map<String, String>> commuteStatusInfo = dao.getCommuteStatusInfo(paraMap);
		return commuteStatusInfo;
	}

	// 로그인한 사원의 오늘 근무한 시간을 초단위까지 db 에 update
	@Override
	public int todayworkedtime(String pk_empnum) {
		int m = dao.todayworkedtime(pk_empnum);
		return m;
	}

	// 한 사원의 출퇴근기록, 근태관리 기록을 다 가져온다
	@Override
	public List<Map<String, String>> showOneCommuteStatus(Map<String, String> paraMap) {
		List<Map<String, String>> OneCommuteStatus = dao.showOneCommuteStatus(paraMap);
		return OneCommuteStatus;
	}
	
	// 조회한 조건에 따른 총 근태의 수
	@Override
	public int getCommuteTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getCommuteTotalCount(paraMap);
		return totalCount;
	}

	// 오늘 휴무 아닌데 출근 안한 사원들의 empnum
	@Override
	public List<String> getEmpsNoWorkToday() {
		List<String> empsNoWorkToday = dao.getEmpsNoWorkToday();
		return empsNoWorkToday;
	}

	// 출석 한 시각 알아오기
	@Override
	public Map<String, String> getStartWorkTime(String login_empnum) {
		Map<String, String> startWorkTime = dao.getStartWorkTime(login_empnum);
		return startWorkTime;
	}

	// 조회한 조건에 따른 한 사원의 총 근태기록의 수
	@Override
	public int getTotalCountByOne(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCountByOne(paraMap);
		return totalCount;
	}



	
	



}//end of public class YuhrService implements InterLeejhService
