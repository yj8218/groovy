package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.ApprovalVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.InterJodnDAO;

@Service
public class JodnService implements InterJodnService {
	
	@Autowired
	private InterJodnDAO dao;
	@Autowired
	private AES256 aes;
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
	public int goEpuipment(Map<String, String> paraMap) {
		
		int n = dao.goEpuipment(paraMap);
	//	System.out.println("service확인용 fk_empnum =>"+paraMap.get("fk_empnum"));
		return n;
	}

	// 비품신청 상세정보 등록
	@Override
	public void goEpuipmentEdit(Map<String, String> paraMap) {
		dao.goEpuipmentEdit(paraMap);
	}

	// 승인자 불러오기
	@Override
	public List<Map<String, String>> appEmpList(Map<String, Object> paraMap) {
		List<Map<String, String>> appEmpList = dao.appEmpList(paraMap);
		return appEmpList;
	}

	// 취소하면 데이터 삭제하기
	@Override
	public int delDocumentnum(String pk_documentnum) {
		int n = dao.delDocumentnum(pk_documentnum);
		return n;
	}
	@Override
	public int delDocumnet(String pk_documentnum) {
		int n = dao.delDocumnet(pk_documentnum);
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




}//end of public class JodnService implements InterLeejhService
