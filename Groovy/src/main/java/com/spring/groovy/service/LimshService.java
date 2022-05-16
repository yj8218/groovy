package com.spring.groovy.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.common.AES256;
import com.spring.groovy.model.DepartmentVO;
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
	    /*  
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
	   */   
	      return empvoList;
	}
	
	
	// 검색한 프로젝트 참여자 목록 보여주기(select)
	@Override
	public List<EmployeeVO> searchEmp(Map<String, String> paraMap) {

		List<EmployeeVO> empvoList = dao.searchEmp(paraMap);
	/*	
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
	*/	
		return empvoList;
	}


	// 사용자 프로필 보여주기(ajax) : 사진, 이름, 이메일, 전화번호
	@Override
	public EmployeeVO showEmpProfile(String pk_empnum) {

		EmployeeVO empvo = dao.showEmpProfile(pk_empnum);
		
	/*	
		if(empvo != null) {
			String phone = "";
			String email = "";
			
			try {
				phone = aes.decrypt(empvo.getPhone());
				email = aes.decrypt(empvo.getEmail());
			} catch(UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
            
			empvo.setPhone(phone);
			empvo.setEmail(email);
		}
	*/	
		return empvo;
	}


	// 부서 목록 가져오기(select)
	@Override
	public List<DepartmentVO> getDeptvoList() {
		
		List<DepartmentVO> deptvoList = dao.getDeptvoList();
		
		return deptvoList;
	}


	// 부서별 직원 목록 가져오기(select)
	@Override
	public List<EmployeeVO> getEmpListByDept(String pk_deptnum) {

		List<EmployeeVO> empvoListByDept = dao.getEmpListByDept(pk_deptnum);
		
		/*  
	      if(empvoListByDept != null) {
	         
	         String phone = "";
	         String email = "";
	
	         for(EmployeeVO empvo : empvoListByDept) {
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
	   */   
		
		return empvoListByDept;
	}


	// 1:1 채팅 직원 정보 가져오기(select)
	@Override
	public EmployeeVO getEmp(String name) {

		EmployeeVO empvo = dao.getEmp(name);

		if(empvo != null) {
			String phone = "";
			String email = "";
			
			try {
				phone = aes.decrypt(empvo.getPhone());
				email = aes.decrypt(empvo.getEmail());
			} catch(UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
            
			empvo.setPhone(phone);
			empvo.setEmail(email);
		}
		
		return empvo;
	}




}//end of public class LimshService implements InterLeejhService
