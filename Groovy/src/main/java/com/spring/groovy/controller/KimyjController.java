package com.spring.groovy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.groovy.common.MyUtil;
import com.spring.groovy.service.InterKimyjService;

@Controller //bean + controller
public class KimyjController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterKimyjService service;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	//-----spring 기초 시작-----//
		@RequestMapping(value ="/test/test_insert.groovy")
		public String test_insert(HttpServletRequest request) {
			System.out.println("체크");
			int n = service.test_insert();
			
			String message = "";
			if(n==1) {
				message = "데이터 입력 성공!";
			}else {
				message = "데이터 입력 실패!";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("n", n);
			
			return "test/test_insert";//  /WEB-INF/views/test/test_insert.jsp 페이지 만들어야 한다.
		}//end of public String test_insert(HttpServletRequest request)
	
	
}//end of public class KimyjController