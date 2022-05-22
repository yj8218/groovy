package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

public interface InterYuhrDAO {

	// 부서명을 가져오기 위함
	List<DepartmentVO> getDepts();

	// 직위명을 가져오기 위함
	List<SpotVO> getSpots();

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	String empDuplicatedCheck(Map<String, String> paraMap);

	// 사원테이블에 사원정보 insert
	int addEmp(EmployeeVO empVo);

	// 직원정보를 가져오기 위함 
	List<EmployeeVO> getEmps(Map<String, String> paraMap);

	// 조회한 조건에 따른 총 사원의 수
	int getTotalCount(Map<String, String> paraMap);

	// 한명의 사원 상세정보 가져오기
	EmployeeVO getOneEmp(String pk_empnum);

	// 근태정보 가져오기
	List<CommuteStatusVO> getCommStatus();

	// tbl_commute 에 오늘의 출근 insert
	int startWork(String pk_empnum);

	// tbl_commute_status 에 지각 1 입력
	void status_late(String pk_empnum);

	// 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지 확인하는 용도
	Map<String, Integer> isClickedBtn(String pk_empnum);

	// tbl_commute 오늘의 자기 행에 퇴근 update
	int endWork(String pk_empnum);

	// tbl_commute_status 에 조기퇴근 1 update
	void status_early_endcheck(String pk_empnum);

	// tbl_commute_status 에 퇴근미체크 1 update
	void status_no_endcheck();

	// tbl_commute_status 에 결근 1 update
	void status_no_workday(String pk_empnum);

	// 모든 사원의 부서,재직여부,근태정보들,총근무일수,총근무시간
	List<Map<String, String>> getCommuteStatusInfo(Map<String, String> paraMap);

	// 로그인한 사원의 오늘 근무한 시간을 초단위까지 db 에 update
	int todayworkedtime(String pk_empnum);

	// 한 사원의 출퇴근기록, 근태관리 기록을 다 가져온다
	List<Map<String, String>> showOneCommuteStatus(Map<String, String> paraMap);

	// 조회한 조건에 따른 총 근태의 수
	int getCommuteTotalCount(Map<String, String> paraMap);

	// 오늘 휴무 아닌데 출근 안한 사원들의 empnum
	List<String> getEmpsNoWorkToday();

	// 출석 한 시각 알아오기
	Map<String, String> getStartWorkTime(String login_empnum);

	// 조회한 조건에 따른 한 사원의 총 근태기록의 수
	int getTotalCountByOne(Map<String, String> paraMap);


}//end of public interface InterYuhrDAO
