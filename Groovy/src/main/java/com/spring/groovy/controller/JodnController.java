package com.spring.groovy.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ModelAndView approvalView(ModelAndView mav, HttpServletRequest request) {
		
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
	
	
	@RequestMapping(value="goEpuipment.groovy")
	public ModelAndView requiredLogin_goEpuipment(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HttpSession session ) {
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmss");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);
		
		String productName = request.getParameter("productName");
		String productLink = request.getParameter("productLink");
		String productCnt = request.getParameter("productCnt");
		String productCost = request.getParameter("productCost");
		String productMoney = request.getParameter("productMoney");
		String productInfo = request.getParameter("productInfo");
		String fk_empnum = loginuser.getPk_empnum();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("pk_documentnum", pk_documentnum);
		
		paraMap.put("productName", productName);
		paraMap.put("productLink", productLink);
		paraMap.put("productCnt", productCnt);
		paraMap.put("productCost", productCost);
		paraMap.put("productMoney", productMoney);
		paraMap.put("productInfo", productInfo);

		int n = service.goEpuipment(paraMap);

		if(n==1) {
			service.goEpuipmentEdit(paraMap);
			
			// 회계부서
			List<EmployeeVO> accountEmployeeList = service.getAccountEmployee();
			// 영업부서
			List<EmployeeVO> salesEmployeeList = service.getSalesEmployee();
			// 인사부서
			List<EmployeeVO> personnelEmployeeList = service.getPersonnelEmployee();
			// 총무부서
			List<EmployeeVO> managerEmployeeList = service.getManagerEmployee();
			
			mav.addObject("pk_documentnum", pk_documentnum);
			
			mav.addObject("accountEmployeeList", accountEmployeeList);
			mav.addObject("salesEmployeeList", salesEmployeeList);
			mav.addObject("personnelEmployeeList", personnelEmployeeList);
			mav.addObject("managerEmployeeList", managerEmployeeList);
			
			mav.setViewName("board/approver.tiles1");
			// /WEB-INF/views/approval/approvalEdit.jsp
			
		} else {
			
			String message = "비품신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		return mav;
	}


	////////////////////////// 비품 신청 테스트 끝
	
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
	
	
	
	
	

	
	
	
	
	
	
	
	// 승인자 참조자 넣기 페이지
	@RequestMapping(value="/approver.groovy")
	public ModelAndView approver(ModelAndView mav) {
		
		
		// 회계부서
		List<EmployeeVO> accountEmployeeList = service.getAccountEmployee();
		// 영업부서
		List<EmployeeVO> salesEmployeeList = service.getSalesEmployee();
		// 인사부서
		List<EmployeeVO> personnelEmployeeList = service.getPersonnelEmployee();
		// 총무부서
		List<EmployeeVO> managerEmployeeList = service.getManagerEmployee();
		
		mav.addObject("accountEmployeeList", accountEmployeeList);
		mav.addObject("salesEmployeeList", salesEmployeeList);
		mav.addObject("personnelEmployeeList", personnelEmployeeList);
		mav.addObject("managerEmployeeList", managerEmployeeList);
		
		mav.setViewName("board/approver.tiles1");
		// /WEB-INF/views/approval/approvalEdit.jsp
		
		return mav;
	}
	
	
	// 승인자 데이터에 넣기 
	@ResponseBody
	@RequestMapping(value="/addApproverEnd.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String addApproverEnd(HttpServletRequest request) {
		
		String str_approver_chk = request.getParameter("str_approver_chk");
		String pk_documentnum = request.getParameter("pk_documentnum");
		
//		System.out.println("확인용 str_approver_chk  =>"+ str_approver_chk);
		
		Map<String, Object> paraMap = new HashMap<>();
		
		String[] arr_approver_chk = str_approver_chk.split("\\,");
		
//		System.out.println("확인용 arr_approver_chk.length => "+arr_approver_chk.length );
//		System.out.println("확인용 pk_documentnum => "+ pk_documentnum);
		
		paraMap.put("arr_approver_chk", arr_approver_chk);
		paraMap.put("pk_documentnum", pk_documentnum);
		
		int n = service.approverList(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 참조자 데이터 넣기
	@ResponseBody
	@RequestMapping(value="/addReferenceEnd.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String addReferenceEnd(HttpServletRequest request) {
		
		String str_reference_chk = request.getParameter("str_reference_chk");
		String pk_documentnum = request.getParameter("pk_documentnum");
		
//		System.out.println("확인용 str_reference_chk  =>"+ str_reference_chk);
		
		Map<String, Object> paraMap = new HashMap<>();
		
		String[] arr_reference_chk = str_reference_chk.split("\\,");
		
//		System.out.println("확인용 arr_reference_chk.length => "+arr_reference_chk.length );
//		System.out.println("확인용 pk_documentnum => "+ pk_documentnum);
		
		paraMap.put("arr_reference_chk", arr_reference_chk);
		paraMap.put("pk_documentnum", pk_documentnum);
		
		int n = service.referenceList(paraMap);
		
//		System.out.println("확인용 n =>"+n);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/addApprover.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String addApprover(HttpServletRequest request) {
		
		String str_approver = request.getParameter("str_approver");
		
		//	System.out.println("확인용 approver = > "+approver);
		//List<String> approverList = service.approverAdd();
		
		
		
		Map<String, Object> paraMap = new HashMap<>();
		
		if(str_approver != null && !"".equals(str_approver)) {
			String[] arr_approver = str_approver.split("\\,");
			paraMap.put("arr_approver", arr_approver);
		}
		
		List<Map<String, String>> appEmpList = service.appEmpList(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("appEmpList", appEmpList);
		
		return jsonObj.toString();
	}
	
	
	// 승인자 등록하기
		@RequestMapping(value="/cancelApprover.groovy")
		public ModelAndView cancelApprover(ModelAndView mav, HttpServletRequest request) {
		
			String pk_documentnum = request.getParameter("pk_documentnum");
			
			//System.out.println("pk_documentnum 확인용 컨트롤 =>"+pk_documentnum);
			
			int n = service.delDocumentnum(pk_documentnum);
			int x = service.delDocumnet(pk_documentnum);
			
			if(n==1 && x==1) {
				// 회계부서
				List<EmployeeVO> accountEmployeeList = service.getAccountEmployee();
				// 영업부서
				List<EmployeeVO> salesEmployeeList = service.getSalesEmployee();
				// 인사부서
				List<EmployeeVO> personnelEmployeeList = service.getPersonnelEmployee();
				// 총무부서
				List<EmployeeVO> managerEmployeeList = service.getManagerEmployee();
				
				mav.addObject("accountEmployeeList", accountEmployeeList);
				mav.addObject("salesEmployeeList", salesEmployeeList);
				mav.addObject("personnelEmployeeList", personnelEmployeeList);
				mav.addObject("managerEmployeeList", managerEmployeeList);
				
				mav.setViewName("redirect:/approvalView.groovy");
			} else {
				String message = "비품신청에 실패했습니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
			}
			
			return mav;
		}	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
}//end of public class JodnController