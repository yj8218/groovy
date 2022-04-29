package com.spring.groovy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.*;
import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.SpotVO;
import com.spring.groovy.service.*;

@Controller //bean + controller
public class YuhrController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterYuhrService service;
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
    private FileManager fileManager;
	
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	// 관리자가 사원을 등록시키는 페이지
	@RequestMapping(value ="/register.groovy")
	public ModelAndView register(ModelAndView mav) {
		
		// 부서정보을 가져오기 위함
		List<DepartmentVO> departments = service.getDepts();
		
		// 직위정보을 가져오기 위함
		List<SpotVO> spots = service.getSpots();
				
		mav.addObject("departments", departments);
		mav.addObject("spots", spots);
		
		mav.setViewName("login/register.tiles1");
		
		return mav;//  /WEB-INF/views/tiles1/login/register.jsp 페이지 만들어야 한다.
		
	}//end of public ModelAndView register()
	
	
	// 사원번호 입력칸 유효성검사(중복검사, ajax 로 처리)
	@ResponseBody
	@RequestMapping(value="/empnumCheck.groovy", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String empnumCheck(HttpServletRequest request ) {
		
		String pk_empnum = request.getParameter("pk_empnum");
	//	System.out.println("fk_deptnum =>>"+fk_deptnum);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		
		String s_usingPk_empnum = service.empnumCheck(paraMap);
		
		boolean isEmpnumDuplicated = false; // true 면 중복된거고, false 면 중복안된것
		
		if(s_usingPk_empnum != null ) {
			isEmpnumDuplicated = true; // 중복이면 true 로 전환됨
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isEmpnumDuplicated", isEmpnumDuplicated);
		
		return jsonObj.toString();
	}
	
	@RequestMapping(value="/registerEnd.groovy", method= {RequestMethod.POST})
	public ModelAndView registerEnd(Map<String,String> paraMap, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		
		return mav;
	}

		
	
	
	
	
	
	
}//end of public class YuhrController