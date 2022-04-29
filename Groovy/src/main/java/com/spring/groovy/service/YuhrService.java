package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.*;

@Service
public class YuhrService implements InterYuhrService {
	
	@Autowired
	private InterYuhrDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	// 부서정보를 가져오기 위함
	@Override
	public List<DepartmentVO> getDepts() {
		List<DepartmentVO> departments = dao.getDepts();
		return departments;
	}

	// 직위정보를 가져오기 위함
	@Override
	public List<SpotVO> getSpots() {
		List<SpotVO> spots = dao.getSpots();
		return spots;
	}

	// 사원번호 입력칸 유효성검사(중복검사, ajax 로 처리)
	@Override
	public String empnumCheck(Map<String, String> paraMap) {
		String s_usingPk_empnum = dao.empnumCheck(paraMap);
		return s_usingPk_empnum;
	}





}//end of public class YuhrService implements InterLeejhService
