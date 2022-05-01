package com.spring.groovy.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.*;
import com.spring.groovy.service.InterJodnService;

@Controller //bean + controller
public class JodnController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterJodnService service;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////

	// 전자결재 창 띄우기
	@RequestMapping(value="/approvalView.groovy")
	public ModelAndView approvalView(ModelAndView mav) {
		
		List<ApprovalVO> approvalList = service.approvalView();
		
		mav.addObject("approvalList", approvalList);
		mav.setViewName("board/approvalView.tiles1");
		
		return mav;
	}
	
	// 비품신청 
	@RequestMapping(value="/equipmentEdit.groovy")
	public ModelAndView equipmentEdit(ModelAndView mav) {
		
		mav.setViewName("board/equipmentEdit.tiles1");
		// /WEB-INF/views/tiles1/board/approvalEdit.jsp
		
		return mav;
	}

	// 경조비 신청
	@RequestMapping(value="/expensesEdit.groovy")
	public ModelAndView expensesEdit(ModelAndView mav) {
		
		mav.setViewName("board/expensesEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}

	// 출장비 신청
	@RequestMapping(value="/businessCostEdit.groovy")
	public ModelAndView businessCostEdit(ModelAndView mav) {
		
		mav.setViewName("board/businessCostEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}

	
	// 식비사용내역 신청
	@RequestMapping(value="/foodExpensesEdit.groovy")
	public ModelAndView foodExpensesEdit(ModelAndView mav) {
		
		mav.setViewName("board/foodExpensesEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	// 휴가 신청
	@RequestMapping(value="/holidayEdit.groovy")
	public ModelAndView holidayEdit(ModelAndView mav) {
		
		mav.setViewName("board/holidayEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	// 휴직 신청
	@RequestMapping(value="/absenceEdit.groovy")
	public ModelAndView absenceEdit(ModelAndView mav) {
		
		mav.setViewName("board/absenceEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	// 신규프로젝트 신청
	@RequestMapping(value="/newProjectEdit.groovy")
	public ModelAndView newProjectEdit(ModelAndView mav) {
		
		mav.setViewName("board/newProjectEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	
	
	

	
	
	
	
	
	
	
	// 결제선 등록 팝업 띄우기
	@RequestMapping(value="/approvePersonAdd.groovy")
	public ModelAndView approvePersonAdd(ModelAndView mav) {
		
		
		
		
	//	mav.addObject("", );
		
		mav.setViewName("approval/approvePersonAdd");
		// /WEB-INF/views/approval/approvalEdit.jsp
		
		return mav;
	}
	
	
	
	
	
	
	
}//end of public class JodnController