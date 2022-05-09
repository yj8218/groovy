package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

public interface InterJodnDAO {

	// 결재 종류 가져오기
	List<ApprovalVO> approvalView();

	// 회계부서 직원 불러오기
	List<EmployeeVO> getAccountEmployee();

	// 영업부서 직원 불러오기
	List<EmployeeVO> getSalesEmployee();

	// 인사부서 직원 불러오기
	List<EmployeeVO> getPersonnelEmployee();

	// 총무부서 직원 불러오기
	List<EmployeeVO> getManagerEmployee();

	// 비품신청하기
	int goEpuipment(Map<String, String> paraMap);

	// 비품신청 상세정보 등록
	void goEpuipmentEdit(Map<String, String> paraMap);

	// 승인자 불러오기
	List<Map<String, String>> appEmpList(Map<String, Object> paraMap);

	// 취소하면 데이터 삭제하기
	int delDocumentnum(String pk_documentnum);
	int delDocumnet(String pk_documentnum);

	// 신청하기 버튼 클릭 시 승인자 넣기
	int approverList(Map<String, Object> paraMap);

	// 신청하기 버튼 클릭 시 참조자 넣기
	int referenceList(Map<String, Object> paraMap);

	// 휴가신청 셀렉트값 가져오기
	List<String> vacationType();

	

}//end of public interface InterJodnDAO
