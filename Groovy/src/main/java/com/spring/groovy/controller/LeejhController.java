package com.spring.groovy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.MyUtil;
import com.spring.groovy.service.InterLeejhService;

@Controller //bean + controller
public class LeejhController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterLeejhService service;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value="/login.groovy")
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("login");
		
		return mav;
	}
	
	
	
}//end of public class LeejhController