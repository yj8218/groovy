package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.ApproverVO;
import com.spring.groovy.model.BusinessCostVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.EquipmentVO;
import com.spring.groovy.model.FoodExpensesVO;
import com.spring.groovy.model.NewProjectVO;

public interface InterJodnService {
	
	// 결재종류 가져오기
	List<ApprovalVO> approvalView();
	
	// 회계부서 직원 불러오기
	List<EmployeeVO> getAccountEmployee();

	// 영업부서 직원 불러오기
	List<EmployeeVO> getSalesEmployee();

	// 인사부서 직원 불러오기
	List<EmployeeVO> getPersonnelEmployee();

	// 총무부서 직원 불러오기
	List<EmployeeVO> getManagerEmployee();

	// 비품신청 파일 생성
	int goEpuipment(EquipmentVO equipmentvo);

	// 비품신청 상세정보 입력
	void goEpuipmentEdit(EquipmentVO equipmentvo);

	// 선택된 승인자 불러오기
	List<Map<String, String>> appEmpList(Map<String, Object> paraMap);

	// 취소버튼클릭시 데이터 삭제하기
	int delDocumentnum(Map<String, String> paraMap);
	int delDocumnet(Map<String, String> paraMap);

	// 신청하기 버튼 클릭 시 승인자 넣기
	int approverList(Map<String, Object> paraMap);

	// 신청하기 버튼 클릭 시 참조자 넣기
	int referenceList(Map<String, Object> paraMap);

	// 휴가신청 셀렉트값 가져오기
	List<String> vacationType();

	// 휴가 신청 파일생성
	int goVacation(Map<String, String> paraMap);

	// 휴가신청 상세정보 입력
	void goVacationEdit(Map<String, String> paraMap);

	// 출장비 신청 파일 생성
	int goBusinessCost(BusinessCostVO businessCostVO);

	// 출장비 신청 상세정보 입력
	void goBusinessCostEdit(BusinessCostVO businessCostVO);

	// 식비사용내역 파일 생성
	int goFoodExpenses(FoodExpensesVO foodExpensesVO);

	// 식비사용내역 상세정보
	void goFoodExpensesEdit(FoodExpensesVO foodExpensesVO);

	// 휴직신청 파일 생성
	int goAbsence(Map<String, String> paraMap);

	// 휴직신청 상세정보
	void goAbsenceEdit(Map<String, String> paraMap);

	// 새 프로젝트 신청 파일생성
	int goNewProject(NewProjectVO newProjectVO);

	// 새프로젝트 신청 상세정보
	void goNewProjectEdit(NewProjectVO newProjectVO);

	// 내 결제문서 조회하기
	List<ApprovalVO> myApproval(Map<String, String> paraMap);

	// 내 결제문서 상세조회 (비품)
	ApprovalVO selectEquipmentDocument(Map<String, String> paraMap);

	// 내결제문서 특정 문서 승인자 참조자 조회
	List<ApproverVO> app_List(String pk_documentnum);

	// 내 결제문서 상세조회 (출장비)
	Map<String, String> selectBusinessCostDocument(Map<String, String> paraMap);
	
	// 내 결제문서 상세조회 (식비)
	Map<String, String> selectFoodExpensesDocument(Map<String, String> paraMap);

	// 내 결제문서 상세조회 (휴가)
	Map<String, String> selectVacationDocument(Map<String, String> paraMap);

	// 내 결제문서 상세조회 (휴직)
	Map<String, String> selectAbsenceDocument(Map<String, String> paraMap);

	// 내 결제문서 상세조회 (신규프로젝트)
	Map<String, String> selectnewProjectDocument(Map<String, String> paraMap);

	// 나의 결재 대기 문서 보기
	List<Map<String, String>> waitApproval(Map<String, String> paraMap);

	// 내결제문서 조회 총페이지수 구하기
	int getMyApprovalTotalCount(Map<String, String> paraMap);

	// 결재승인하기
	int app_success(Map<String, String> paraMap);

	// 결재승인자 남은 인원수 알아오기
	int approverCount(Map<String, String> paraMap);
	
	// 남은 결재자가 없는 경우 문서상태변경
	int app_success_NApprover(Map<String, String> paraMap);

	// 남은 결재자가 있는 경우 문서상태변경
	int app_success_YApprover(Map<String, String> paraMap);

	// 나의 결재 완료 문서 보기
	List<Map<String, String>> endApproval(String fk_empnum);

	// 나의 결재 참조 문서 보기
	List<Map<String, String>> referenceApproval(String fk_empnum);

	// 참조자 승인자 삭제하기
	int delApprover(Map<String, String> paraMap);

	// 승인대기 문서 조회 총 페이지 수 구하기
	int geWaitApprovalTotalCount(Map<String, String> paraMap);


	
	
	
}//end of public interface InterJodnService
