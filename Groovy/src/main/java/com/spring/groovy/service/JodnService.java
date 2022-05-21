package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.ApproverVO;
import com.spring.groovy.model.BusinessCostVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.EquipmentVO;
import com.spring.groovy.model.FoodExpensesVO;
import com.spring.groovy.model.InterJodnDAO;
import com.spring.groovy.model.NewProjectVO;

@Service
public class JodnService implements InterJodnService {
	
	@Autowired
	private InterJodnDAO dao;
	@Autowired
	/////////////////////////////////////////////////////
	
	// 결재 종류 가져오기
	@Override
	public List<ApprovalVO> approvalView() {
		List<ApprovalVO> approvalList = dao.approvalView();
		return approvalList;
	}
	
	// 회계부서 직원불러오기
	@Override
	public List<EmployeeVO> getAccountEmployee() {
		List<EmployeeVO> employeeList = dao.getAccountEmployee();
		return employeeList;
	}

	// 영업부서 직원불러오기
	@Override
	public List<EmployeeVO> getSalesEmployee() {
		List<EmployeeVO> employeeList = dao.getSalesEmployee();
		return employeeList;
	}

	// 인사부서 직원 불러오기
	@Override
	public List<EmployeeVO> getPersonnelEmployee() {
		List<EmployeeVO> employeeList = dao.getPersonnelEmployee();
		return employeeList;
	}

	// 총무부서 직원 불러오기
	@Override
	public List<EmployeeVO> getManagerEmployee() {
		List<EmployeeVO> employeeList = dao.getManagerEmployee();
		return employeeList;
	}

	// 비품신청하기
	@Override
	public int goEpuipment(EquipmentVO equipmentvo) {
		
		int n = dao.goEpuipment(equipmentvo);
		return n;
	}

	// 비품신청 상세정보 등록
	@Override
	public void goEpuipmentEdit(EquipmentVO equipmentvo) {
		dao.goEpuipmentEdit(equipmentvo);
	}

	// 승인자 불러오기
	@Override
	public List<Map<String, String>> appEmpList(Map<String, Object> paraMap) {
		List<Map<String, String>> appEmpList = dao.appEmpList(paraMap);
		return appEmpList;
	}

	// 취소하면 데이터 삭제하기
	@Override
	public int delDocumentnum(Map<String, String> paraMap) {
		int n = dao.delDocumentnum(paraMap);
		return n;
	}
	@Override
	public int delDocumnet(Map<String, String> paraMap) {
		int n = dao.delDocumnet(paraMap);
		return n;
	}

	// 신청하기 버튼 클릭 시 승인자 넣기
	@Override
	public int approverList(Map<String, Object> paraMap) {
		int n = dao.approverList(paraMap);
		return n;
	}

	// 신청하기 버튼 클릭 시 참조자 넣기
	@Override
	public int referenceList(Map<String, Object> paraMap) {
		int n = dao.referenceList(paraMap);
		return n;
	}

	// 휴가신청 셀렉트값 가져오기
	@Override
	public List<String> vacationType() {
		List<String> vacationType = dao.vacationType();
		return vacationType;
	}

	// 휴가 신청 파일생성
	@Override
	public int goVacation(Map<String, String> paraMap) {
		int n = dao.goVacation(paraMap);
		return n;
	}

	// 휴가신청 상세정보 입력
	@Override
	public void goVacationEdit(Map<String, String> paraMap) {
		dao.goVacationEdit(paraMap);
	}

	// 출장비 신청 파일 생성
	@Override
	public int goBusinessCost(BusinessCostVO businessCostVO) {
		int n = dao.goBusinessCost(businessCostVO);
		return n;
	}

	// 출장비 신청 상세정보
	@Override
	public void goBusinessCostEdit(BusinessCostVO businessCostVO) {
		dao.goBusinessCostEdit(businessCostVO);
	}

	// 식비신청 파일 생성
	@Override
	public int goFoodExpenses(FoodExpensesVO foodExpensesVO) {
		int n = dao.goFoodExpenses(foodExpensesVO);
		return n;
	}

	// 식비 신청 상세정보
	@Override
	public void goFoodExpensesEdit(FoodExpensesVO foodExpensesVO) {
		dao.goFoodExpensesEdit(foodExpensesVO);
	}

	// 휴직신청 파일 생성
	@Override
	public int goAbsence(Map<String, String> paraMap) {
		int n = dao.goAbsence(paraMap);
		return n;
	}

	// 휴직신청 상세정보
	@Override
	public void goAbsenceEdit(Map<String, String> paraMap) {
		dao.goAbsenceEdit(paraMap);
		
	}

	// 새프로젝트 신청 파일 생성
	@Override
	public int goNewProject(NewProjectVO newProjectVO) {
		int n = dao.goNewProject(newProjectVO);
		return n;
	}

	// 새프로젝트 상세정보 
	@Override
	public void goNewProjectEdit(NewProjectVO newProjectVO) {
		dao.goNewProjectEdit(newProjectVO);
	}

	// 내결제문서 조회하기 
	@Override
	public List<ApprovalVO> myApproval(Map<String, String> paraMap) {
		List<ApprovalVO> myApprovalList = dao.myApproval(paraMap);
		return myApprovalList;
	}

	// 내 결제문서 상세조회 (비품)
	@Override
	public ApprovalVO selectEquipmentDocument(Map<String, String> paraMap) {
		ApprovalVO selectEquipmentDocument = dao.selectEquipmentDocument(paraMap);
		return selectEquipmentDocument;
	}

	// 내결제문서 특정 문서 승인자 참조자 조회
	@Override
	public List<ApproverVO> app_List(String pk_documentnum) {
		List<ApproverVO> approverList = dao.app_List(pk_documentnum);
		return approverList;
	}

	// 내 결제문서 상세조회 (출장비)
	@Override
	public Map<String, String> selectBusinessCostDocument(Map<String, String> paraMap) {
		Map<String,String> businessCostMap = dao.selectBusinessCostDocument(paraMap);
		return businessCostMap;
	}

	// 내 결제문서 상세조회 (식비)
	@Override
	public Map<String, String> selectFoodExpensesDocument(Map<String, String> paraMap) {
		Map<String,String> foodExpensesMap = dao.selectFoodExpensesDocument(paraMap);
		return foodExpensesMap;
	}

	// 내 결제문서 상세조회 (휴가)
	@Override
	public Map<String, String> selectVacationDocument(Map<String, String> paraMap) {
		Map<String,String> vacationMap = dao.selectVacationDocument(paraMap);
		return vacationMap;
	}

	// 내 결제문서 상세조회 (휴직)
	@Override
	public Map<String, String> selectAbsenceDocument(Map<String, String> paraMap) {
		Map<String,String> absenceMap = dao.selectAbsenceDocument(paraMap);
		return absenceMap;
	}

	// 내 결제문서 상세조회 (신규프로젝트)
	@Override
	public Map<String, String> selectnewProjectDocument(Map<String, String> paraMap) {
		Map<String,String> newProjectMap = dao.selectnewProjectDocument(paraMap);
		return newProjectMap;
	}

	// 나의 결재 대기 문서 조회
	@Override
	public List<Map<String, String>> waitApproval(Map<String, Object> paraMap) {
		List<Map<String,String>> waitApprovalList = dao.waitApproval(paraMap);
		return waitApprovalList;
	}

	// 내결제문서 조회 총페이지수 구하기
	@Override
	public int getMyApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getMyApprovalTotalCount(paraMap);
		return totalCount;
	}

	// 결재승인하기
	@Override
	public int app_success(Map<String, String> paraMap) {
		int n = dao.app_success(paraMap);
		return n;
	}

	// 결재승인자 남은 인원수 알아오기
	@Override
	public int approverCount(Map<String, String> paraMap) {
		int n = dao.approverCount(paraMap);
		return n;
	}

	// 남은 결재자가 없는 경우 문서상태변경
	@Override
	public int app_success_NApprover(Map<String, String> paraMap) {
		int n = dao.app_success_NApprover(paraMap);
		return n;
	}

	// 남은 결재자가 있는 경우 문서상태변경
	@Override
	public int app_success_YApprover(Map<String, String> paraMap) {
		int n = dao.app_success_YApprover(paraMap);
		return n;
	}

	// 나의 결재 완료 문서 보기
	@Override
	public List<Map<String, String>> endApproval(Map<String, String> paraMap) {
		List<Map<String,String>> endApprovalList = dao.endApproval(paraMap);
		return endApprovalList;
	}

	// 나의 결재 참조 문서 보기
	@Override
	public List<Map<String, String>> referenceApproval(Map<String, String> paraMap) {
		List<Map<String,String>> referenceApprovalList = dao.referenceApproval(paraMap);
		return referenceApprovalList;
	}

	// 참조자 승인자 삭제하기
	@Override
	public int delApprover(Map<String, String> paraMap) {
		int n = dao.delApprover(paraMap);
		return n;
	}

	// 승인대기 문서 조회 총 페이지 수 구하기
	@Override
	public int getWaitApprovalTotalCount(Map<String, Object> paraMap) {
		int totalCount = dao.getWaitApprovalTotalCount(paraMap);
		return totalCount;
	}

	// 승인완료 문서 조회 총 페이지 수 구하기
	@Override
	public int getEndApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getEndApprovalTotalCount(paraMap);
		return totalCount;
	}

	// 참조 문서 조회 총 페이지 수 구하기
	@Override
	public int getReferenceApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getReferenceApprovalTotalCount(paraMap);
		return totalCount;
	}

	// 회원목록 불러오기
	@Override
	public List<EmployeeVO> getEmployeeList(Map<String, String> paraMap) {
		List<EmployeeVO> employeeList = dao.getEmployeeList(paraMap);
		return employeeList;
	}

	// 결재반려하기
	@Override
	public int app_fail(Map<String, String> paraMap) {
		int n = dao.app_fail(paraMap);
		return n;
	}

	// 결재반려시 문서상태변경 
	@Override
	public int app_fail_Approver(Map<String, String> paraMap) {
		int n = dao.app_fail_Approver(paraMap);
		return n;
	}

	// 불필요한 결재문서 삭제
	@Override
	public void removeList() {
		dao.removeList();
	}

	// 차트용 직원조회
	@Override
	public List<EmployeeVO> getAllEmployeeList() {
		List<EmployeeVO> employeeList = dao.getAllEmployeeList();
		return employeeList;
	}

	// 관리자 페이지 결재목록 총게시물 구하기
	@Override
	public int getAdminApprovalTotalCount(Map<String, String> paraMap) {
		int n = dao.getAdminApprovalTotalCount(paraMap);
		return n;
	}

	// 관리자 페이지 결재목록 페이징처리 조회
	@Override
	public List<Map<String, String>> adminApprovalList(Map<String, String> paraMap) {
		List<Map<String, String>> adminApprovalList = dao.adminApprovalList(paraMap);
		return adminApprovalList;
	}

	// 내 직급넘버 받아오기
	@Override
	public int getSpotnum(String fk_empnum) {
		int n = dao.getSpotnum(fk_empnum);
		return n;
	}

	// 문서별 직급 번호 받아오기
	@Override
	public List<Map<String, String>> getAppLineList(String fk_empnum) {
		List<Map<String,String>> appLineList = dao.getAppLineList(fk_empnum);
		return appLineList;
	}

	// 남은 휴가 일수 알아오기
	@Override
	public String getVacationdate(String fk_empnum) {
		String str_vacationdate = dao.getVacationdate(fk_empnum);
		return str_vacationdate;
	}

	// 주말을 제외한 휴가일
	@Override
	public int getVacationDay(Map<String, String> paraMap) {
		int n = dao.getVacationDay(paraMap);
		return n;
	}

	// 신청자의 남은 휴가일 구해오기
	@Override
	public Map<String, String> getMyVacation(Map<String, String> paraMap) {
		Map<String, String> myVacationMap = dao.getMyVacation(paraMap);
		return myVacationMap;
	}

	// 휴가일 차감하기
	@Override
	public void vacationdayUpdate(Map<String, String> paraMap) {
		dao.vacationdayUpdate(paraMap);
	}

	





}//end of public class JodnService implements InterLeejhService
