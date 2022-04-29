package com.spring.groovy.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class YuhrDAO implements InterYuhrDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////

	// 부서명을 가져오기 위함
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departments = sqlsession.selectList("yuhr.getDepts");
		return departments;
	}

	// 직위명을 가져오기 위함
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spots = sqlsession.selectList("yuhr.getSpots");
		return spots;
	}

	// 사원번호 입력칸 유효성검사(중복검사, ajax 로 처리)
	@Override
	public String empnumCheck(Map<String, String> paraMap) {
		String s_usingPk_empnum = sqlsession.selectOne("yuhr.empnumCheck", paraMap);
		return s_usingPk_empnum;
	}



}//end of public class YuhrDAO implements InterYuhrDAO
