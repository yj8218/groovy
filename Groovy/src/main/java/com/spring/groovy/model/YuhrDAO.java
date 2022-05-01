package com.spring.groovy.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.common.AES256;
import com.spring.groovy.common.Sha256;

@Repository
public class YuhrDAO implements InterYuhrDAO {
	
	@Autowired
	private AES256 aes;

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

	// 사원테이블에 사원정보 insert
	@Override
	public int addEmp(EmployeeVO empVo) {
		
		String pwd = empVo.getPwd();
		empVo.setPwd(Sha256.encrypt(pwd)); //비밀번호 (SHA-256 암호화 대상)
		
		String phone = empVo.getPhone();
		String email = empVo.getEmail();
		
		System.out.println(phone);
		System.out.println(email);
		
		try {
			
			
			empVo.setPhone(aes.encrypt(phone)); // 연락처 (AES-256 암호화/복호화 대상)
			empVo.setEmail(aes.encrypt(email)); // 이메일 (AES-256 암호화/복호화 대상)
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
		
		int n = sqlsession.insert("yuhr.addEmp", empVo);
		return n;
	}




}//end of public class YuhrDAO implements InterYuhrDAO
