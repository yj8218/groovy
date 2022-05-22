package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LimshDAO implements InterLimshDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 직원 목록 가져오기(select)
	@Override
	public List<EmployeeVO> showEmployeeList() {

		List<EmployeeVO> empvoList = sqlsession.selectList("limsh.showEmployeeList");
		
		return empvoList;
	}
	
	
	// 검색한 프로젝트 참여자 목록 보여주기(select)
	@Override
	public List<EmployeeVO> searchEmp(Map<String, String> paraMap) {

		List<EmployeeVO> empvoList = sqlsession.selectList("limsh.searchEmp", paraMap);
		
		return empvoList;
	}


	// 사용자 프로필 보여주기(ajax) : 사진, 이름, 이메일, 전화번호
	@Override
	public EmployeeVO showEmpProfile(String pk_empnum) {
		
		EmployeeVO empvo = sqlsession.selectOne("limsh.showEmpProfile", pk_empnum);
		
		return empvo;
	}


	// 부서 목록 가져오기(select)
	@Override
	public List<DepartmentVO> getDeptvoList() {

		List<DepartmentVO> deptvoList = sqlsession.selectList("limsh.getDeptvoList");
		
		return deptvoList;
	}


	// 부서별 직원 목록 가져오기(select)
	@Override
	public List<EmployeeVO> getEmpListByDept(String pk_deptnum) {
		
		List<EmployeeVO> empvoListByDept = sqlsession.selectList("limsh.getEmpListByDept", pk_deptnum);
		
		return empvoListByDept;
	}


	// 1:1 채팅 직원 정보 가져오기(select)
	@Override
	public EmployeeVO getEmp(String pk_empnum) {

		EmployeeVO empvo = sqlsession.selectOne("limsh.getEmp", pk_empnum);
		
		return empvo;
	}


	// 채팅방 생성하기(insert)
	@Override
	public int createChat(Map<String, String> paraMap) {

		int n = sqlsession.insert("limsh.createChat", paraMap);
		
		return n;
	}


}//end of public class LimshDAO implements InterLimshDAO
