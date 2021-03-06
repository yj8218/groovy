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
	public int goEpuipment(EquipmentVO equipmentvo) {
	//	String pk_documentnum = sqlsession.selectOne("");
		int n =	sqlsession.insert("jodn.equipmentDocumentEdit", equipmentvo);
	//	String pk_documentnum = sqlsession.selectOne("jodn.equipmentDocumentNum");
	//	System.out.println("dao확인용 fk_empnum =>"+paraMap.get("fk_empnum"));
		return n;
	}

	// 비품신청 상세정보 등록
	@Override
	public void goEpuipmentEdit(EquipmentVO equipmentvo) {
		sqlsession.insert("jodn.goEpuipmentEdit", equipmentvo);
		
	}

	// 승인자 불러오기
	@Override
	public List<Map<String, String>> appEmpList(Map<String, Object> paraMap) {
		List<Map<String, String>> appEmpList = sqlsession.selectList("jodn.appEmpList", paraMap);
		return appEmpList;
	}

	// 취소하면 데이터 삭제하기
	@Override
	public int delDocumentnum(Map<String, String> paraMap) {
	//	System.out.println("pk_documentnum 확인용 DAO =>"+ pk_documentnum);
		int n = sqlsession.delete("jodn.delDocumentnum", paraMap);
		return n;
	}
	@Override
	public int delDocumnet(Map<String, String> paraMap) {
		int n = sqlsession.delete("jodn.delDocumnet", paraMap);
		return n;
	}

	// 신청하기 버튼 클릭 시 승인자 넣기
	@Override
	public int approverList(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jodn.approverList", paraMap);
		
		sqlsession.update("jodn.updateDocument", paraMap);
		sqlsession.update("jodn.updateApproval", paraMap);
		
		return n;
	}

	// 신청하기 버튼 클릭 시 참조자 넣기
	@Override
	public int referenceList(Map<String, Object> paraMap) {
		int n = sqlsession.insert("jodn.referenceList", paraMap);
		return n;
	}

	// 휴가신청 셀렉트값 가져오기
	@Override
	public List<String> vacationType() {
		List<String> vacationType = sqlsession.selectList("jodn.vacationType");
		return vacationType;
	}

	// 휴가신청하기 
	@Override
	public int goVacation(Map<String, String> paraMap) {
		int n =	sqlsession.insert("jodn.vacationDocumentEdit", paraMap);
		return n;
	}
	
	// 휴가신청 상세정보
	@Override
	public void goVacationEdit(Map<String, String> paraMap) {
		sqlsession.insert("jodn.goVacationEdit", paraMap);		
	}

	// 출장비 신청하기 
	@Override
	public int goBusinessCost(BusinessCostVO businessCostVO) {
		int n =	sqlsession.insert("jodn.BusinessCostDocumentEdit", businessCostVO);
		return n;
	}

	// 출장비 신청 상세정보
	@Override
	public void goBusinessCostEdit(BusinessCostVO businessCostVO) {
		sqlsession.insert("jodn.goBusinessCostEdit", businessCostVO);		
	}

	// 식비 신청 파일 생성
	@Override
	public int goFoodExpenses(FoodExpensesVO foodExpensesVO) {
		int n =	sqlsession.insert("jodn.FoodExpensesDocumentEdit", foodExpensesVO);
		return n;
	}

	// 식비 신청 상세정보
	@Override
	public void goFoodExpensesEdit(FoodExpensesVO foodExpensesVO) {
		sqlsession.insert("jodn.goFoodExpensesEdit", foodExpensesVO);		
	}

	// 휴직신청 파일 생성
	@Override
	public int goAbsence(Map<String, String> paraMap) {
		int n =	sqlsession.insert("jodn.AbsenceDocumentEdit", paraMap);
		return n;
	}

	// 휴직신청 상세정보
	@Override
	public void goAbsenceEdit(Map<String, String> paraMap) {
		sqlsession.insert("jodn.goAbsenceEdit", paraMap);		
	}

	// 새프로젝트 신청 파일 생성
	@Override
	public int goNewProject(NewProjectVO newProjectVO) {
		int n =	sqlsession.insert("jodn.NewProjectDocumentEdit", newProjectVO);
		return n;
	}

	// 새프로젝트 신청 상세정보 
	@Override
	public void goNewProjectEdit(NewProjectVO newProjectVO) {
		sqlsession.insert("jodn.goNewProjectEdit", newProjectVO);	
	}

	// 내 결제문서 조회하기
	@Override
	public List<ApprovalVO> myApproval(Map<String, String> paraMap) {
		List<ApprovalVO> myApprovalList = sqlsession.selectList("jodn.myApproval", paraMap);
		return myApprovalList;
	}
	
	// 내결제문서 조회 총페이지수 구하기
	@Override
	public int getMyApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("jodn.getMyApprovalTotalCount", paraMap);
		return totalCount;
	}


	// 내 결제문서 상세조회 (비품)
	@Override
	public ApprovalVO selectEquipmentDocument(Map<String, String> paraMap) {
		
		Map<String,String> selectEquipmentDocument = sqlsession.selectOne("jodn.selectEquipmentDocument", paraMap);
		
		String pk_documentnum = selectEquipmentDocument.get("pk_documentnum");
		
		//System.out.println(pk_documentnum);
		
		String fk_empnum = selectEquipmentDocument.get("fk_empnum");
		String status = selectEquipmentDocument.get("status");
		String productName = selectEquipmentDocument.get("productname");
		String productLink = selectEquipmentDocument.get("productlink");
		String productCnt = selectEquipmentDocument.get("productcnt");
		String productCost = selectEquipmentDocument.get("productcost");
		String productMoney = selectEquipmentDocument.get("productmoney");
		String productInfo = selectEquipmentDocument.get("productinfo");
		String rno = selectEquipmentDocument.get("rno");
		
		
		EquipmentVO equipmentvo = new EquipmentVO();
		equipmentvo.setProductName(productName);
		equipmentvo.setProductLink(productLink);
		equipmentvo.setProductCnt(productCnt);
		equipmentvo.setProductCost(productCost);
		equipmentvo.setProductMoney(productMoney);
		equipmentvo.setProductInfo(productInfo);
		equipmentvo.setProductInfo(productInfo);
		
		ApprovalVO approvalvo = new ApprovalVO();
		approvalvo.setPk_documentnum(pk_documentnum);
		approvalvo.setFk_empnum(fk_empnum);
		approvalvo.setStatus(status);
		approvalvo.setRno(rno);
		approvalvo.setEquipmentvo(equipmentvo);
		
		
		return approvalvo;
	}

	// 내결제문서 특정 문서 승인자 참조자 조회
	@Override
	public List<ApproverVO> app_List(String pk_documentnum) {
		List<ApproverVO> approverList = sqlsession.selectList("jodn.app_List", pk_documentnum);
		return approverList;
	}

	// 내 결제문서 상세조회 (출장비)
	@Override
	public Map<String, String> selectBusinessCostDocument(Map<String, String> paraMap) {
		Map<String,String> businessCostMap = sqlsession.selectOne("jodn.selectBusinessCostDocument", paraMap);
		return businessCostMap;
	}

	// 내 결제문서 상세조회 (식비)
	@Override
	public Map<String, String> selectFoodExpensesDocument(Map<String, String> paraMap) {
		Map<String,String> foodExpensesMap = sqlsession.selectOne("jodn.selectFoodExpensesDocument", paraMap);
		return foodExpensesMap;
	}

	// 내 결제문서 상세조회 (휴가)
	@Override
	public Map<String, String> selectVacationDocument(Map<String, String> paraMap) {
		Map<String,String> vacationMap = sqlsession.selectOne("jodn.selectVacationDocument", paraMap);
		return vacationMap;
	}

	// 내 결제문서 상세조회 (휴직)
	@Override
	public Map<String, String> selectAbsenceDocument(Map<String, String> paraMap) {
		Map<String,String> absenceMap = sqlsession.selectOne("jodn.selectAbsenceDocument", paraMap);
		return absenceMap;
	}

	// 내 결제문서 상세조회 (신규프로젝트)
	@Override
	public Map<String, String> selectnewProjectDocument(Map<String, String> paraMap) {
		Map<String,String> newProjectMap = sqlsession.selectOne("jodn.selectnewProjectDocument", paraMap);
		return newProjectMap;
	}

	// 나의 결재 대기 문서 조회
	@Override
	public List<Map<String, String>> waitApproval(Map<String, Object> paraMap) {
		List<Map<String, String>> waitApprovalList = sqlsession.selectList("jodn.waitApproval", paraMap);
		return waitApprovalList;
	}

	// 승인대기 문서 조회 총 페이지 수 구하기
	@Override
	public int getWaitApprovalTotalCount(Map<String, Object> paraMap) {
		int totalCount = sqlsession.selectOne("jodn.getWaitApprovalTotalCount", paraMap);
		return totalCount;
	}
	
	// 결재승인하기
	@Override
	public int app_success(Map<String, String> paraMap) {
		int n = sqlsession.update("jodn.app_success", paraMap);
		return n;
	}

	// 결재승인자 남은 인원수 알아오기
	@Override
	public int approverCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("jodn.approverCount", paraMap);
		return n;
	}

	// 남은 결재자가 없는 경우 문서상태변경
	@Override
	public int app_success_NApprover(Map<String, String> paraMap) {
		int n = sqlsession.insert("jodn.app_success_NApprover", paraMap);
		return n;
	}

	// 남은 결재자가 있는 경우 문서상태변경
	@Override
	public int app_success_YApprover(Map<String, String> paraMap) {
		int n = sqlsession.insert("jodn.app_success_YApprover", paraMap);
		return n;
	}

	// 나의 결재 완료 문서 보기
	@Override
	public List<Map<String, String>> endApproval(Map<String, String> paraMap) {
		List<Map<String, String>> endApprovalList = sqlsession.selectList("jodn.endApproval", paraMap);
		return endApprovalList;
	}

	// 나의 결재 참조 문서 보기
	@Override
	public List<Map<String, String>> referenceApproval(Map<String, String> paraMap) {
		List<Map<String, String>> referenceApprovalList = sqlsession.selectList("jodn.referenceApproval", paraMap);
		return referenceApprovalList;
	}

	// 내 결재 삭제하기
	@Override
	public int delApprover(Map<String, String> paraMap) {
		int n = sqlsession.delete("jodn.delApprover", paraMap);
		return n;
	}
	
	// 승인완료 문서 조회 총 페이지 수 구하기
	@Override
	public int getEndApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("jodn.getEndApprovalTotalCount", paraMap);
		return totalCount;
	}

	// 참조 문서 조회 총 페이지 수 구하기
	@Override
	public int getReferenceApprovalTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("jodn.getReferenceApprovalTotalCount", paraMap);
		return totalCount;
	}

	// 회원목록 불러오기
	@Override
	public List<EmployeeVO> getEmployeeList(Map<String, String> paraMap) {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getEmployeeList", paraMap);
		return employeeList;
	}

	
	// 결재반려하기
	@Override
	public int app_fail(Map<String, String> paraMap) {
		int n = sqlsession.update("jodn.app_fail", paraMap);
		return n;
	}

	// 결재반려시 문서상태변경
	@Override
	public int app_fail_Approver(Map<String, String> paraMap) {
		int n = sqlsession.update("jodn.app_fail_Approver", paraMap);
		return n;
	}

	// 불필요한 결재문서 삭제
	@Override
	public void removeList() {
		sqlsession.delete("jodn.remove_tbl_app_equip");
		sqlsession.delete("jodn.remove_tbl_app_business");
		sqlsession.delete("jodn.remove_tbl_app_food");
		sqlsession.delete("jodn.remove_tbl_vacationlist");
		sqlsession.delete("jodn.remove_tbl_app_absence");
		sqlsession.delete("jodn.remove_tbl_app_project");
		sqlsession.delete("jodn.removeDocument");
		
	}

	
	// 차트용 직원조회하기
	@Override
	public List<EmployeeVO> getAllEmployeeList() {
		List<EmployeeVO> employeeList = sqlsession.selectList("jodn.getAllEmployeeList");
		return employeeList;
	}

	// 관리자 페이지 결재목록 총게시물 구하기
	@Override
	public int getAdminApprovalTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("jodn.getAdminApprovalTotalCount", paraMap);
		return n;
	}

	// 관리자 페이지 결재목록 페이징처리 조회
	@Override
	public List<Map<String, String>> adminApprovalList(Map<String, String> paraMap) {
		List<Map<String, String>> adminApprovalList = sqlsession.selectList("jodn.adminApprovalList", paraMap);
		return adminApprovalList;
	}

	// 내 직급 넘버 받아오기
	@Override
	public int getSpotnum(String fk_empnum) {
		int n = sqlsession.selectOne("jodn.getSpotnum", fk_empnum);
		return n;
	}

	// 문서별 직급번호 받아오기
	@Override
	public List<Map<String, String>> getAppLineList(String fk_empnum) {
		List<Map<String,String>> appLineList = sqlsession.selectList("jodn.getAppLineList", fk_empnum);
		return appLineList;
	}

	// 남은 휴가일수 알아오기
	@Override
	public String getVacationdate(String fk_empnum) {
		String str_vacationdate = sqlsession.selectOne("jodn.getVacationdate", fk_empnum);
		return str_vacationdate;
	}

	// 주말을 제외한 휴가일 알아오기
	@Override
	public int getVacationDay(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("jodn.getVacationDay", paraMap);
		return n;
	}

	// 신청자의 남은 휴가일 구해오기
	@Override
	public Map<String, String> getMyVacation(Map<String, String> paraMap) {
		Map<String, String> myVacationMap = sqlsession.selectOne("jodn.getMyVacation", paraMap);
		return myVacationMap;
	}

	// 휴가일 차감하기
	@Override
	public void vacationdayUpdate(Map<String, String> paraMap) {
		sqlsession.update("jodn.vacationdayUpdate", paraMap);
	}
	



	

}//end of public class JodnDAO implements InterJodnDAO
