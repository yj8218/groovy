package com.spring.groovy.model;

import java.util.List;

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


}//end of public class JodnDAO implements InterJodnDAO
