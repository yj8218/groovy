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

	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	@Override
	public String empDuplicatedCheck(Map<String, String> paraMap) {
		
		String checkValue = paraMap.get("checkValue");
			
		try {
			
			if("email".equalsIgnoreCase(paraMap.get("checkColumn")) ) { // 이메일일 때는 암호화해서 중복검사한다.
				paraMap.put("checkValue", aes.encrypt(checkValue) );
			//	System.out.println("확인용  checkValue  ===>" +  paraMap.get("checkValue") );
				// 확인용  checkValue  ===>T0TLz6N3cmZtw3zusfANvfRzs15oXWs1K2WrrFitQhM=
			}

		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String s_using_infoVal = sqlsession.selectOne("yuhr.empnumCheck", paraMap);

		return s_using_infoVal;
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
			
//			empVo.setPhone(aes.encrypt(phone)); // 연락처 (AES-256 암호화/복호화 대상)
			empVo.setEmail(aes.encrypt(email)); // 이메일 (AES-256 암호화/복호화 대상)
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} 
		
		int n = sqlsession.insert("yuhr.addEmp", empVo);
		return n;
	}




}//end of public class YuhrDAO implements InterYuhrDAO
