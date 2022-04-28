package com.spring.groovy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Sha256;
import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.*;
import com.spring.groovy.service.*;

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
	
	//  << 로그인 폼요청 >>
	@RequestMapping(value="/login.groovy")
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("login/loginform.tiles2");
		
		return mav;
	}
	
	//  << 로그인 처리하기 >>
	@RequestMapping(value="/loginEnd.groovy", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String pk_empnum = request.getParameter("pk_empnum");
		String pwd = request.getParameter("pwd");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum",pk_empnum);
		paraMap.put("pwd",pwd);
	//	System.out.println("확인 pk_empnum:"+pk_empnum);
	//	System.out.println("확인 pwd:"+pwd);
		
		EmployeeVO loginuser = service.getLoginEmployee(paraMap);
		//EmployeeVO loginuser - com.spring.groovy.controller.LeejhController.loginEnd(ModelAndView, HttpServletRequest)
	//	System.out.println("확인 loginuser:"+loginuser);
		
		if(loginuser == null) { //로그인 실패시
			String message = "사원번호 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			//  /WEB-INF/views/msg.jsp 파일을 생성한다.
			
		}
		else { // 아이디와 암호가 존재하는 경우
			
			HttpSession session =  request.getSession();
			//메모리에 생성되어져 있는 session 을 불러오는 것이다.
			
			session.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
			
			
			mav.setViewName("redirect:/approval.groovy"); //시작페이지로 이동
			
			
			
			/*
			if(loginuser.getIdle() == 1) { // 로그인 한지 1년이 경과한 경우
				
				//System.out.println("~~~~ 로그인을 한지 1년이 지나서 휴면상태로 되었습니다. ");
				
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n관리자가에게 문의 바랍니다.";
				String loc = request.getContextPath()+"/index.action";
				// 원래는 위와 같이 index.action 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				//  /WEB-INF/views/msg.jsp 파일을 생성한다.
			}
			else { //로그인 한지 1년 이내인 경우
				//session에 넣어준다.
				HttpSession session =  request.getSession();
				//메모리에 생성되어져 있는 session 을 불러오는 것이다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				
				if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다";
					String loc = request.getContextPath()+"/index.action";
					// 원래는 위와 같이 index.action 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다.
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					mav.setViewName("msg");
					
				}
				else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우
					
					// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
		            // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
		            // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
		            // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
					String goBackURL = (String) session.getAttribute("goBackURL");
					
					if(goBackURL != null) {
						mav.setViewName("redirect:" + goBackURL);
						session.removeAttribute("goBackURL"); //세션에서 반드시 제거해주어야 한다.
					}
					else {
						mav.setViewName("redirect:/index.action"); //시작페이지로 이동
					}
					
				}
				
				
			}
		}
		
		
		*/
		
		}
		return mav;
	}

	
	
}//end of public class LeejhController