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
	
	// === Spring Scheduler 를 사용하여 특정 URL 사이트로 연결하기 ===
	@Override
	@Scheduled(cron = "0 2 17 * * *") // 자정에 작동된다
	public void checkEndCommuteStatus() {
        // 스케줄러로 사용되어지는 메소드는 반드시 파라미터는 없어야 한다.!!!!!

		// == 현재 시각을 나타내기 ==
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = dateFormat.format(currentDate.getTime());

		System.out.println("Spring Scheduler 작동시간 => " + currentTime);
		
		// !!!! === 특정 사이트의 웹페이지를 보여주기 위해 기본브라우저를 띄운다 == !!
		// 조심할 것은, http:// 를 주소에 꼭 붙여아 한다.
		// 즉, 특정 사이트 웹페이지를 실행시키는 것이다.
		
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
	public void status_no_endcheck(String pk_empnum) {
		dao.status_no_endcheck(pk_empnum);
		
	}

	// tbl_commute_status 에 결근 1 update
	@Override
	public void status_no_workday(String pk_empnum) {
		dao.status_no_workday(pk_empnum);
		
	}


	
	



}//end of public class YuhrService implements InterLeejhService
