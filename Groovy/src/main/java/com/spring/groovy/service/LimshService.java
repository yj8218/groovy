package com.spring.groovy.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.InterLimshDAO;

@Service
public class LimshService implements InterLimshService {
	
	@Autowired
	private InterLimshDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	// 직원 목록 가져오기(select)
	@Override
	public List<EmployeeVO> showEmployeeList() {

		List<EmployeeVO> empvoList = dao.showEmployeeList();
	      
	      if(empvoList != null) {
	         
	         String phone = "";
	         String email = "";

	         for(EmployeeVO empvo : empvoList) {
	            try {
	               phone = aes.decrypt(empvo.getPhone());
	               email = aes.decrypt(empvo.getEmail());
	            } catch(UnsupportedEncodingException | GeneralSecurityException e) {
	               e.printStackTrace();
	            }
	            
	            empvo.setPhone(phone);
	            empvo.setEmail(email);
	         }
	      }
	      
	      return empvoList;
	}




}//end of public class LimshService implements InterLeejhService
