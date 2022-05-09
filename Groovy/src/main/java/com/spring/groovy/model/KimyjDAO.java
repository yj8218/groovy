package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class KimyjDAO implements InterKimyjDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existComCalendar(String com_smcatgoname) {
		int m = sqlsession.selectOne("kimyj.existComCalendar", com_smcatgoname);
		return m;
	}
	
	// 사내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("kimyj.addComCalendar", paraMap);
		return n;
	}

	
	// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existMyCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("kimyj.existMyCalendar", paraMap);
		return m;
	}

	// 내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("kimyj.addMyCalendar", paraMap);
		return n;
	}

	
	// 사내 캘린더에서 사내캘린더 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showCompanyCalendar() {
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = sqlsession.selectList("kimyj.showCompanyCalendar");  
		return calendar_small_category_VO_CompanyList;
	}

	
	// 내 캘린더에서 내캘린더 소분류  보여주기
	@Override
	public List<Calendar_small_category_VO> showMyCalendar(String fk_empnum) {
		List<Calendar_small_category_VO> calendar_small_category_VO_MyList = sqlsession.selectList("kimyj.showMyCalendar", fk_empnum);  
		return calendar_small_category_VO_MyList;
	}

	
	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기
	@Override
	public List<Calendar_small_category_VO> selectSmallCategory(Map<String, String> paraMap) {
		List<Calendar_small_category_VO> small_category_VOList = sqlsession.selectList("kimyj.selectSmallCategory", paraMap);
		return small_category_VOList;
	}

	
	// 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기
	@Override
	public List<EmployeeVO> searchJoinUserList(String joinUserName) {
		List<EmployeeVO> joinUserList = sqlsession.selectList("kimyj.searchJoinUserList", joinUserName);
		return joinUserList;
	}

	
	// 일정 등록하기
	@Override
	public int registerSchedule_end(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("kimyj.registerSchedule_end", paraMap);
		return n;
	}

	
	// 등록된 일정 가져오기
	@Override
	public List<Calendar_schedule_VO> selectSchedule(String fk_empnum) {
		List<Calendar_schedule_VO> scheduleList = sqlsession.selectList("kimyj.selectSchedule", fk_empnum);
		return scheduleList;
	}

	
	// 일정 상세 보기 
	@Override
	public Map<String,String> detailSchedule(String pk_scheduleno) {
		Map<String,String> map = sqlsession.selectOne("kimyj.detailSchedule", pk_scheduleno);
		return map;
	}

	
	// 일정삭제하기
	@Override
	public int deleteSchedule(String pk_scheduleno) throws Throwable {
		int n = sqlsession.delete("kimyj.deleteSchedule", pk_scheduleno);
		return n;
	}

	
	// 일정수정하기
	@Override
	public int editSchedule_end(Calendar_schedule_VO svo) throws Throwable {
		int n = sqlsession.update("kimyj.editSchedule_end", svo);
		return n;
	}

	
	// (사내캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 
	@Override
	public int deleteSubCalendar(String pk_smcatgono) throws Throwable {
		int n = sqlsession.delete("kimyj.deleteSubCalendar", pk_smcatgono);
		return n;
	}

	
	// (사내캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = sqlsession.update("kimyj.editCalendar", paraMap);
		return n;
	}

	
	// 수정된 (사내캘린더 또는 내캘린더)속의 소분류 카테고리명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기  
	@Override
	public int existsCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("kimyj.existsCalendar", paraMap);
		return m;
	}

	
	// 총 일정 검색 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("kimyj.getTotalCount", paraMap);
		return n;
	}

	
	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap) { 
		List<Map<String,String>> scheduleList = sqlsession.selectList("kimyj.scheduleListSearchWithPaging", paraMap);
		return scheduleList;
	}


}//end of public class KimyjDAO implements InterKimyjDAO 
