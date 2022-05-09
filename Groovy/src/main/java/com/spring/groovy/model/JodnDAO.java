package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JodnDAO implements InterJodnDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 결재 종류 가져오기
	@Override
	public List<ApprovalVO> approvalView() {
		List<ApprovalVO> approvalList = sqlsession.selectList("jodn.approvalView");
		return approvalList;
	}
	
	// 회계부서 직원 불러오기
	@Override
	public List<EmployeeVO> getAccountEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getAccountEmployee");
		return employeeList;
	}

	// 영업부서 직원 불러오기
	@Override
	public List<EmployeeVO> getSalesEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getSalesEmployee");
		return employeeList;
	}

	// 인사부서 직원 불러오기
	@Override
	public List<EmployeeVO> getPersonnelEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getPersonnelEmployee");
		return employeeList;
	}

	// 총무부서 직원 불러오기
	@Override
	public List<EmployeeVO> getManagerEmployee() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getManagerEmployee");
		return employeeList;
	}

	// 비품신청하기
	@Override
	public int goEpuipment(Map<String, String> paraMap) {
	//	String pk_documentnum = sqlsession.selectOne("");
		int n =	sqlsession.insert("jodn.equipmentDocumentEdit", paraMap);
	//	String pk_documentnum = sqlsession.selectOne("jodn.equipmentDocumentNum");
	//	System.out.println("dao확인용 fk_empnum =>"+paraMap.get("fk_empnum"));
		return n;
	}

	// 비품신청 상세정보 등록
	@Override
	public void goEpuipmentEdit(Map<String, String> paraMap) {
		sqlsession.insert("jodn.goEpuipmentEdit", paraMap);
		
	}

	// 승인자 불러오기
	@Override
	public List<Map<String, String>> appEmpList(Map<String, Object> paraMap) {
		List<Map<String, String>> appEmpList = sqlsession.selectList("jodn.appEmpList", paraMap);
		return appEmpList;
	}

	// 취소하면 데이터 삭제하기
	@Override
	public int delDocumentnum(String pk_documentnum) {
	//	System.out.println("pk_documentnum 확인용 DAO =>"+ pk_documentnum);
		int n = sqlsession.delete("jodn.delDocumentnum", pk_documentnum);
		return n;
	}
	@Override
	public int delDocumnet(String pk_documentnum) {
		int n = sqlsession.delete("jodn.delDocumnet", pk_documentnum);
		return n;
	}

	// 신청하기 버튼 클릭 시 승인자 넣기
	@Override
	public int approverList(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jodn.approverList", paraMap);
		return n;
	}

	// 신청하기 버튼 클릭 시 참조자 넣기
	@Override
	public int referenceList(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jodn.referenceList", paraMap);
		return n;
	}


}//end of public class JodnDAO implements InterJodnDAO
