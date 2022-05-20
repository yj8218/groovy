package com.spring.groovy.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.annotation.NoLogging;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.*;
import com.spring.groovy.service.InterJodnService;

@Component
@Controller //bean + controller
public class JodnController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterJodnService service;
	
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
		 
	
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
	
	
	@RequestMapping(value="/goEpuipment.groovy" , method= {RequestMethod.POST})
	public ModelAndView requiredLogin_goEpuipment(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HttpSession session, EquipmentVO equipmentvo ) {
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);
		
		String fk_empnum = loginuser.getPk_empnum();
		
		equipmentvo.setPk_documentnum(pk_documentnum);
		equipmentvo.setFk_empnum(fk_empnum);
		
		int n = service.goEpuipment(equipmentvo);

		if(n==1) {
			service.goEpuipmentEdit(equipmentvo);
			
		} else {
			
			String message = "비품신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=1");

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

	@RequestMapping(value="/goBusinessCost.groovy", method= {RequestMethod.POST})
	public ModelAndView goBusinessCost(ModelAndView mav, BusinessCostVO businessCostVO, MultipartHttpServletRequest mrequest) {
		
		HttpSession session = mrequest.getSession();
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);

		String fk_empnum = loginuser.getPk_empnum();
	//	System.out.println("fk_empnum 확인용 =>" + fk_empnum);
		
		businessCostVO.setPk_documentnum(pk_documentnum);
		businessCostVO.setFk_empnum(fk_empnum);
		
		MultipartFile attach = businessCostVO.getAttach();
		
		if(!attach.isEmpty()) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
			
			/*
	          1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	          >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                       조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	        */
			// WAS 의 wepapp 의 절대경로를 알아와야 한다.
		//	HttpSession session = mrequest.getSession();	
			String root = session.getServletContext().getRealPath("/");
			
	//		System.out.println("확인용  webapp의 절대경로  =>" + root);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root + "resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
		//	System.out.println("확인용 path  =>" + path);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\resources\files
			
			/*
			 	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
				String newFileName = "";
				//  WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 곳
				
				long fileSize = 0;
				// 첨부파일의 크기

				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것 
					String originalFilename = attach.getOriginalFilename();
					// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				//	System.out.println("확인용 originalFilename => "+ originalFilename);
					// 확인용 originalFilename => Electrolux냉장고_사용설명서.pdf
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
		            
				//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
					// >>> 확인용 newFileName => 202204291230251171571296730300.pdf
				
				/*
				 	3. BoardVO boardvo에  fileName 값과  originalFilename 값과 fileSize값을 넣어주기
				 */
					businessCostVO.setFileName(newFileName);
					// WAS(톰캣)에 저장된 파일명(202204291230251171571296730300.pdf)
					
					businessCostVO.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					
					businessCostVO.setFileSize(String.valueOf(fileSize));
					
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}	
				
		}
		
		int n = service.goBusinessCost(businessCostVO);

		if(n==1) {
			service.goBusinessCostEdit(businessCostVO);
			
		} else {
			
			String message = "휴가신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=3");
		
		
		return mav;
	}
	
	
	/////////////////////////////// 출장비 신청 끝
	
	// 식비사용내역 신청
	@RequestMapping(value="/foodExpensesEdit.groovy")
	public ModelAndView foodExpensesEdit(ModelAndView mav) {
		mav.setViewName("board/foodExpensesEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	@RequestMapping(value="/goFoodExpenses.groovy", method= {RequestMethod.POST})
	public ModelAndView goFoodExpenses(ModelAndView mav, FoodExpensesVO foodExpensesVO, MultipartHttpServletRequest mrequest) {
		
		HttpSession session = mrequest.getSession();
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);

		String fk_empnum = loginuser.getPk_empnum();
		
		foodExpensesVO.setPk_documentnum(pk_documentnum);
		foodExpensesVO.setFk_empnum(fk_empnum);
		
		MultipartFile attach = foodExpensesVO.getAttach();
		
		if(!attach.isEmpty()) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
			
			/*
	          1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	          >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                       조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	        */
			// WAS 의 wepapp 의 절대경로를 알아와야 한다.
		//	HttpSession session = mrequest.getSession();	
			String root = session.getServletContext().getRealPath("/");
			
	//		System.out.println("확인용  webapp의 절대경로  =>" + root);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root + "resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
		//	System.out.println("확인용 path  =>" + path);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\resources\files
			
			/*
			 	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
				String newFileName = "";
				//  WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 곳
				
				long fileSize = 0;
				// 첨부파일의 크기

				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것 
					String originalFilename = attach.getOriginalFilename();
					// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				//	System.out.println("확인용 originalFilename => "+ originalFilename);
					// 확인용 originalFilename => Electrolux냉장고_사용설명서.pdf
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
		            
				//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
					// >>> 확인용 newFileName => 202204291230251171571296730300.pdf
				
				/*
				 	3. BoardVO boardvo에  fileName 값과  originalFilename 값과 fileSize값을 넣어주기
				 */
					foodExpensesVO.setFileName(newFileName);
					// WAS(톰캣)에 저장된 파일명(202204291230251171571296730300.pdf)
					
					foodExpensesVO.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					
					foodExpensesVO.setFileSize(String.valueOf(fileSize));
					
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}	
				
		}
		
		int n = service.goFoodExpenses(foodExpensesVO);

		if(n==1) {
			service.goFoodExpensesEdit(foodExpensesVO);
			
		} else {
			
			String message = "식비사용내역신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}

		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=4");
		
		return mav;
	}
	///////////////////////////////// 식비사용내역 신청 끝
	
	
	// 휴가 신청
	@RequestMapping(value="/vacationEdit.groovy")
	public ModelAndView vacationEdit(ModelAndView mav) {
		
		List<String> vacationTypeList = service.vacationType();
		
	//	System.out.println(vacationType.toString());
		
		mav.addObject("vacationTypeList", vacationTypeList);
		
		mav.setViewName("board/vacationEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}

	@RequestMapping(value="goVacation.groovy")
	public ModelAndView requiredLogin_goVacation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HttpSession session ) {
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);

		String fk_empnum = loginuser.getPk_empnum();
		
		String fk_vstatus = request.getParameter("fk_vstatus");
		String holidayStartDate = request.getParameter("holidayStartDate");
		String holidayStartHour = request.getParameter("holidayStartHour");
		String holidayEndDate = request.getParameter("holidayEndDate");
		String holidayEndHour = request.getParameter("holidayEndHour");
		String vinfo = request.getParameter("vinfo");
		String vetc = request.getParameter("vetc");
		
		String vstartdate = holidayStartDate +" "+holidayStartHour;
		String venddate = holidayEndDate +" "+ holidayEndHour;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("pk_documentnum", pk_documentnum);
		
		paraMap.put("fk_vstatus", fk_vstatus);
		paraMap.put("vstartdate", vstartdate);
		paraMap.put("venddate", venddate);
		paraMap.put("vinfo", vinfo);
		paraMap.put("vetc", vetc);

		int n = service.goVacation(paraMap);

		if(n==1) {
			service.goVacationEdit(paraMap);
			
		} else {
			
			String message = "휴가신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=5");
		
		return mav;
	}
	
	
	
	/////////////////////////// 휴가신청 끝
	
	
	// 휴직 신청
	@RequestMapping(value="/absenceEdit.groovy")
	public ModelAndView absenceEdit(ModelAndView mav) {
		mav.setViewName("board/absenceEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	@RequestMapping(value="/goAbsence.groovy" , method= {RequestMethod.POST})
	public ModelAndView goAbsence(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HttpSession session ) {
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);
		String fk_empnum = loginuser.getPk_empnum();

		
		String absenceStartDate = request.getParameter("absenceStartDate");
		String absenceEndDate = request.getParameter("absenceEndDate");
		String absenceInfo = request.getParameter("absenceInfo");
		String absenceETC = request.getParameter("absenceETC");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("pk_documentnum", pk_documentnum);
		
		paraMap.put("absenceStartDate", absenceStartDate);
		paraMap.put("absenceEndDate", absenceEndDate);
		paraMap.put("absenceInfo", absenceInfo);
		paraMap.put("absenceETC", absenceETC);

		int n = service.goAbsence(paraMap);

		if(n==1) {
			service.goAbsenceEdit(paraMap);
			
		} else {
			
			String message = "휴직신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=6");
		
		return mav;
	}
	
	
	/////////////////////////// 휴직신청 끝
	
	
	// 신규프로젝트 신청
	@RequestMapping(value="/newProjectEdit.groovy")
	public ModelAndView newProjectEdit(ModelAndView mav) {
		mav.setViewName("board/newProjectEdit.tiles1");
		// /WEB-INF/views/tiles1/board/expensesEdit.jsp
		
		return mav;
	}
	
	
	@RequestMapping(value="/goNewProject.groovy", method= {RequestMethod.POST})
	public ModelAndView goNewProject(ModelAndView mav, NewProjectVO newProjectVO, MultipartHttpServletRequest mrequest) {
		
		HttpSession session = mrequest.getSession();
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Date today = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ( "yyyyMMddHHmmssSSS");
		
		String pk_documentnum = fmt.format(today);
	//	System.out.println("확인용 pk_documentnum =>"+pk_documentnum);

		String fk_empnum = loginuser.getPk_empnum();
		
		newProjectVO.setPk_documentnum(pk_documentnum);
		newProjectVO.setFk_empnum(fk_empnum);
		
		MultipartFile attach = newProjectVO.getAttach();
		
		if(!attach.isEmpty()) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
			
			/*
	          1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	          >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                       조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	        */
			// WAS 의 wepapp 의 절대경로를 알아와야 한다.
		//	HttpSession session = mrequest.getSession();	
			String root = session.getServletContext().getRealPath("/");
			
	//		System.out.println("확인용  webapp의 절대경로  =>" + root);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root + "resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
		//	System.out.println("확인용 path  =>" + path);
			// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\resources\files
			
			/*
			 	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
				String newFileName = "";
				//  WAS(톰캣)의 디스크에 저장될 파일명
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 곳
				
				long fileSize = 0;
				// 첨부파일의 크기

				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것 
					String originalFilename = attach.getOriginalFilename();
					// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				//	System.out.println("확인용 originalFilename => "+ originalFilename);
					// 확인용 originalFilename => Electrolux냉장고_사용설명서.pdf
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
		            
				//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
					// >>> 확인용 newFileName => 202204291230251171571296730300.pdf
				
				/*
				 	3. BoardVO boardvo에  fileName 값과  originalFilename 값과 fileSize값을 넣어주기
				 */
					newProjectVO.setFileName(newFileName);
					// WAS(톰캣)에 저장된 파일명(202204291230251171571296730300.pdf)
					
					newProjectVO.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					
					newProjectVO.setFileSize(String.valueOf(fileSize));
					
				} catch (Exception e) {
					e.printStackTrace();
				}	
				
		}
		
		int n = service.goNewProject(newProjectVO);

		if(n==1) {
			service.goNewProjectEdit(newProjectVO);
			
		} else {
			
			String message = "새프로젝트신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
		}
		
		mav.setViewName("redirect:/approver.groovy?pk_documentnum="+pk_documentnum+"&apl_no=7");
		
		return mav;
	}

	
	///////////////////////////////////// 신규프로젝트신청 끝
	
	// 승인자 참조자 넣기 페이지
		@RequestMapping(value="/approver.groovy")
		public ModelAndView approver(ModelAndView mav, HttpServletRequest request, HttpSession session) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			String search = request.getParameter("search");
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			mav.addObject("pk_documentnum", pk_documentnum);
			mav.addObject("apl_no", apl_no);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("search", search);
			
			// 통합 직원 불러오기 
			List<EmployeeVO> employeeList = service.getEmployeeList(paraMap);
			
			mav.addObject("search", search);
			mav.addObject("employeeList", employeeList);
			
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
		String apl_no = request.getParameter("apl_no");
//		System.out.println("확인용 str_approver_chk  =>"+ str_approver_chk);
		
		Map<String, Object> paraMap = new HashMap<>();
		
		String[] arr_approver_chk = str_approver_chk.split("\\,");
		
//		System.out.println("확인용 arr_approver_chk.length => "+arr_approver_chk.length );
//		System.out.println("확인용 pk_documentnum => "+ pk_documentnum);
		
		paraMap.put("arr_approver_chk", arr_approver_chk);
		paraMap.put("pk_documentnum", pk_documentnum);
		paraMap.put("apl_no", apl_no);
		
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
	
	
	// 승인자 참조자 등록 취소
	@RequestMapping(value="/cancelApprover.groovy")
	public ModelAndView cancelApprover(ModelAndView mav, HttpServletRequest request) {
	
		String pk_documentnum = request.getParameter("pk_documentnum");
		String apl_no = request.getParameter("apl_no");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_documentnum", pk_documentnum);
		paraMap.put("apl_no", apl_no);
		
		//System.out.println("pk_documentnum 확인용 컨트롤 =>"+pk_documentnum);
		
		int n = service.delDocumentnum(paraMap);
		int x = service.delDocumnet(paraMap);
		
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
			String message = "결재신청에 실패했습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}	
		
		////////////////////////////////////////////////////////////////////
		
		// 나의 결재 내역 정보 조회
		@RequestMapping(value="/myApproval.groovy")
		public ModelAndView myApproval(ModelAndView mav, ApprovalVO approvalVO, HttpSession session, HttpServletRequest request) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String fk_empnum = loginuser.getPk_empnum();
			String searchValue = request.getParameter("searchValue");
			
			mav.addObject("loginuser", loginuser);
			
			service.removeList();
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			// 검색이 있는 나의 결재 내역 정보 조회
			paraMap.put("searchValue", searchValue);
			
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을 때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수 
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.	
			int totalPage = 0; // 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작행 번호
			int endRno = 0; // 끝 행 번호
			
			// 총 게시물 건수(totalCount)
		    totalCount = service.getMyApprovalTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null ) {
				// 게시판에 보여지는 초기화면 
				currentShowPageNo = 1;
			} else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			startRno =  (currentShowPageNo - 1) * sizePerPage + 1;
			endRno = startRno + sizePerPage - 1;
			
			paraMap.put("startRno", String.valueOf(startRno)); // 스트링타입으로 변환
			paraMap.put("endRno", String.valueOf(endRno));
			
			// ~~~~~~~~~~~~~~~~~~~~~~~
			
			List<ApprovalVO> myApprovalList = service.myApproval(paraMap);
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			mav.addObject("searchValue",searchValue);
			
			int blockSize = 10;
			// blockSize는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
						
			int loop = 1;
			/*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	        */
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = request.getContextPath()+"/myApproval.groovy";
			
			if(searchValue == null ) {
				searchValue = "";
			}
			
			// === [처음][이전] 만들기 == 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo=1'>[처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px #6449FC; color:#6449FC; padding: 2px 4px;'>"+pageNo+"</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}

				loop++;
				pageNo++;			
				} // end of while 
			
			// === [다음][마지막] 만들기 ==
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL.replace("&", " "));
			
			// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝
			///////////////////////////////////////////////////////////////////////
			
			mav.addObject("myApprovalList", myApprovalList);
			
			mav.setViewName("board/myApproval.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}
		
		
		
		

		// 나의 결재 상세정보 조회하기
		@RequestMapping(value="/selectOneMyDocument.groovy")
		public ModelAndView selectOneMyDocument(ModelAndView mav, ApprovalVO approvalVO, ApproverVO approverVO, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("apl_no", apl_no);

			mav.addObject("apl_no",apl_no);

			if("1".equals(apl_no)) { // 비품신청
				
				ApprovalVO equipmentvo = service.selectEquipmentDocument(paraMap);
				
			//	System.out.println(equipmentvo.getEquipmentvo().getProductName());
			//	System.out.println("equipmentvo.getEquipmentvo() => " + equipmentvo.getEquipmentvo());
				mav.addObject("equipmentvo", equipmentvo);
				
			} else if("3".equals(apl_no)) { // 출장비 신청
				
				Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
				
				mav.addObject("businessCostMap", businessCostMap);
			
			} else if("4".equals(apl_no)) { // 식비신청
				
				Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
				
				mav.addObject("foodExpensesMap", foodExpensesMap);
			
			} else if("5".equals(apl_no)) { // 휴가신청
				
				Map<String,String> vacationMap = service.selectVacationDocument(paraMap);
				
				mav.addObject("vacationMap", vacationMap);
			
			} else if("6".equals(apl_no)) { // 휴직신청
				
				Map<String,String> absenceMap = service.selectAbsenceDocument(paraMap);
				
				mav.addObject("absenceMap", absenceMap);
			
			} else if("7".equals(apl_no)) { // 신규프로젝트신청
				
				Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
				
				mav.addObject("newProjectMap", newProjectMap);
			
			}
		    
			// 승인자 참조자 조회하기
			List<ApproverVO> approverList = service.app_List(pk_documentnum);
			
			// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = request.getParameter("gobackURL");
		//	System.out.println("gobackURL 확인용 =>" +gobackURL);
			// gobackURL 확인용 =>/list.action
			// gobackURL 확인용 =>/list.action?searchType=
			// replace 로 공백으로 바꿔준 후 
			// gobackURL 확인용 =>/list.action?searchType= searchWord= currentShowPageNo=2
			
			if(gobackURL != null && gobackURL.contains(" ")) {
				gobackURL = gobackURL.replace(" ", "&");
			}
			
//			System.out.println("~~~~ view 의 searchType : " + searchType);
//		    System.out.println("~~~~ view 의 searchWord : " + searchWord);
//		    System.out.println("~~~~ view 의 gobackURL : " + gobackURL);

			mav.addObject("gobackURL", gobackURL);
			
			mav.addObject("approverList", approverList);
			
			
			mav.setViewName("board/myApprovalDetail.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}

		//////////////////////////////////////////////////////////////////
		// 나의 결재 대기 문서 보기
		@RequestMapping(value="/waitApproval.groovy")
		public ModelAndView waitApproval(ModelAndView mav, HttpSession session, HttpServletRequest request) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			// pk_documentnum 값 가져오기 결재승인 순서 관련 작업 남아있음
			
			// 내 직급 넘버 받아오기
			int spotnum = service.getSpotnum(fk_empnum);
			
			// 문서별 직급번호 받아오기
			List<Map<String,String>> appLineList = service.getAppLineList(fk_empnum);
			
			
//		 	String[] fk_documentnumArr = {};
			/*
			 * ArrayList<String> fk_documentnumArr = new ArrayList<>(); for(int i=0;
			 * i<appLineList.size(); i++ ) { if(spotnum ==
			 * Integer.parseInt(appLineList.get(i).get("minSpotnum"))) {
			 * fk_documentnumArr.add(appLineList.get(i).get("fk_documentnum")); }
			 * 
			 * }
			 */
		 	
		 	String[] fk_documentnumArr = new String[appLineList.size()];
		 	
		 	for(int i=0; i<fk_documentnumArr.length; i++ ) {
				if(spotnum == Integer.parseInt(appLineList.get(i).get("minSpotnum"))) {
					fk_documentnumArr[i] = appLineList.get(i).get("fk_documentnum");
				}
			}
			
//		 	System.out.println("fk_documentnumArr 확인용 => "+ fk_documentnumArr);
		 	
//		 	String str_fk_documentnumArr = fk_documentnumArr.toString();
//		 	
//		 	str_fk_documentnumArr = str_fk_documentnumArr.substring(1, str_fk_documentnumArr.length()-1);
//		 	
//		 	System.out.println("확인용 str_fk_documentnumArr =>" + str_fk_documentnumArr);
//		
//		 	
			
			
			Map<String, Object> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("fk_documentnumArr", fk_documentnumArr);
			
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을 때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수 
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.	
			int totalPage = 0; // 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작행 번호
			int endRno = 0; // 끝 행 번호
			
			// 총 게시물 건수(totalCount)
		    totalCount = service.getWaitApprovalTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null ) {
				// 게시판에 보여지는 초기화면 
				currentShowPageNo = 1;
			} else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			startRno =  (currentShowPageNo - 1) * sizePerPage + 1;
			endRno = startRno + sizePerPage - 1;
			
			paraMap.put("startRno", String.valueOf(startRno)); // 스트링타입으로 변환
			paraMap.put("endRno", String.valueOf(endRno));
			
			// ~~~~~~~~~~~~~~~~~~~~~~~
			
			List<Map<String,String>> waitApprovalList = service.waitApproval(paraMap);
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			int blockSize = 10;
			// blockSize는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
						
			int loop = 1;
			/*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	        */
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = request.getContextPath()+"/myApproval.groovy";
			
			// === [처음][이전] 만들기 == 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo=1'>[처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px #6449FC; color:#6449FC; padding: 2px 4px;'>"+pageNo+"</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}

				loop++;
				pageNo++;			
				} // end of while 
			
			// === [다음][마지막] 만들기 ==
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL.replace("&", " "));
			
			// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝
			///////////////////////////////////////////////////////////////////////
			
			
			
			mav.addObject("waitApprovalList", waitApprovalList);
			
			mav.setViewName("board/waitApproval.tiles1");
			
			return mav;
		}

		// 나의 결재대기 상세보기 
		@RequestMapping(value="selectOneWaitDocument.groovy")
		public ModelAndView selectOneWaitDocument(ModelAndView mav, ApprovalVO approvalVO, ApproverVO approverVO, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("apl_no", apl_no);

			mav.addObject("apl_no",apl_no);

			if("1".equals(apl_no)) { // 비품신청
				
				ApprovalVO equipmentvo = service.selectEquipmentDocument(paraMap);
				
			//	System.out.println(equipmentvo.getEquipmentvo().getProductName());
			//	System.out.println("equipmentvo.getEquipmentvo() => " + equipmentvo.getEquipmentvo());
				mav.addObject("equipmentvo", equipmentvo);
				
			} else if("3".equals(apl_no)) { // 출장비 신청
				
				Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
				
				mav.addObject("businessCostMap", businessCostMap);
			
			} else if("4".equals(apl_no)) { // 식비신청
				
				Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
				
				mav.addObject("foodExpensesMap", foodExpensesMap);
			
			} else if("5".equals(apl_no)) { // 휴가신청
				
				Map<String,String> vacationMap = service.selectVacationDocument(paraMap);
				
				mav.addObject("vacationMap", vacationMap);
			
			} else if("6".equals(apl_no)) { // 휴직신청
				
				Map<String,String> absenceMap = service.selectAbsenceDocument(paraMap);
				
				mav.addObject("absenceMap", absenceMap);
			
			} else if("7".equals(apl_no)) { // 신규프로젝트신청
				
				Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
				
				mav.addObject("newProjectMap", newProjectMap);
			
			}
		
			// 승인자 참조자 조회하기
			List<ApproverVO> approverList = service.app_List(pk_documentnum);
			
			String gobackURL = request.getParameter("gobackURL");
			
			if(gobackURL != null && gobackURL.contains(" ")) {
				gobackURL = gobackURL.replace(" ", "&");
			}

			mav.addObject("gobackURL", gobackURL);
			
			mav.addObject("approverList", approverList);
			
			
			mav.setViewName("board/waitApprovalDetail.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}
		
		
		// 문서승인하기
		@RequestMapping(value="/app_success.groovy")
		public ModelAndView app_success(ModelAndView mav, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String opinion = request.getParameter("opinion");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("opinion", opinion);

			// 결재승인하기
			int n = service.app_success(paraMap);
			
			// 결재승인자 남은 인원수 알아오기
			int count = service.approverCount(paraMap);
			
			int x = 0;
			if(n==1 && count==0) {
				// 남은 결재자가 없는 경우 문서상태변경
				x = service.app_success_NApprover(paraMap);
			}
			
			if(n==1 && count!=0) {
				// 남은 결재자가 있는 경우 문서상태변경
				x = service.app_success_YApprover(paraMap);
			}
			
			if(n==1 && x==1) {
				mav.setViewName("redirect:/waitApproval.groovy");
			}
			
			return mav;
		}
		
		
		
		// 문서반려하기
		@RequestMapping(value="/app_fail.groovy")
		public ModelAndView app_fail(ModelAndView mav, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String opinion = request.getParameter("opinion");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("opinion", opinion);

			// 결재반려하기
			int n = service.app_fail(paraMap);
			
			int	x = service.app_fail_Approver(paraMap);
			
			if(n==1 && x==1) {
				
				String message = "결재문서를 반려하셨습니다.";
				String loc = "redirect:/waitApproval.groovy";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
				
				mav.setViewName("redirect:/waitApproval.groovy");
			}
			
			if(n==0 || x==0) {
				String message = "결재문서에 승인실패하셨습니다.";
				String loc = "redirect:/waitApproval.groovy";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
				
				mav.setViewName("redirect:/waitApproval.groovy");
			}
			
			return mav;
		}

		
		// 나의 결재 완료 문서 보기
		@RequestMapping(value="/endApproval.groovy")
		public ModelAndView endApproval(ModelAndView mav, HttpSession session, HttpServletRequest request) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을 때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수 
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.	
			int totalPage = 0; // 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작행 번호
			int endRno = 0; // 끝 행 번호
			
			// 총 게시물 건수(totalCount)
		    totalCount = service.getEndApprovalTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null ) {
				// 게시판에 보여지는 초기화면 
				currentShowPageNo = 1;
			} else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			startRno =  (currentShowPageNo - 1) * sizePerPage + 1;
			endRno = startRno + sizePerPage - 1;
			
			paraMap.put("startRno", String.valueOf(startRno)); // 스트링타입으로 변환
			paraMap.put("endRno", String.valueOf(endRno));
			
			// ~~~~~~~~~~~~~~~~~~~~~~~
			
			List<Map<String,String>> endApprovalList = service.endApproval(paraMap);
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			int blockSize = 10;
			// blockSize는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
						
			int loop = 1;
			/*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	        */
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = request.getContextPath()+"/myApproval.groovy";
			
			// === [처음][이전] 만들기 == 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo=1'>[처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px #6449FC; color:#6449FC; padding: 2px 4px;'>"+pageNo+"</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}

				loop++;
				pageNo++;			
				} // end of while 
			
			// === [다음][마지막] 만들기 ==
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL.replace("&", " "));
			
			// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝
			///////////////////////////////////////////////////////////////////////
			
			
			mav.addObject("endApprovalList", endApprovalList);
			
			mav.setViewName("board/endApproval.tiles1");
			
			return mav;
		}

		
		// 나의 결재대기 상세보기 
		@RequestMapping(value="/selectOneEndDocument.groovy")
		public ModelAndView selectOneEndDocument(ModelAndView mav, ApprovalVO approvalVO, ApproverVO approverVO, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("apl_no", apl_no);

			mav.addObject("apl_no",apl_no);

			if("1".equals(apl_no)) { // 비품신청
				
				ApprovalVO equipmentvo = service.selectEquipmentDocument(paraMap);
				
			//	System.out.println(equipmentvo.getEquipmentvo().getProductName());
			//	System.out.println("equipmentvo.getEquipmentvo() => " + equipmentvo.getEquipmentvo());
				mav.addObject("equipmentvo", equipmentvo);
				
			} else if("3".equals(apl_no)) { // 출장비 신청
				
				Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
				
				mav.addObject("businessCostMap", businessCostMap);
			
			} else if("4".equals(apl_no)) { // 식비신청
				
				Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
				
				mav.addObject("foodExpensesMap", foodExpensesMap);
			
			} else if("5".equals(apl_no)) { // 휴가신청
				
				Map<String,String> vacationMap = service.selectVacationDocument(paraMap);
				
				mav.addObject("vacationMap", vacationMap);
			
			} else if("6".equals(apl_no)) { // 휴직신청
				
				Map<String,String> absenceMap = service.selectAbsenceDocument(paraMap);
				
				mav.addObject("absenceMap", absenceMap);
			
			} else if("7".equals(apl_no)) { // 신규프로젝트신청
				
				Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
				
				mav.addObject("newProjectMap", newProjectMap);
			
			}
		
			// 승인자 참조자 조회하기
			List<ApproverVO> approverList = service.app_List(pk_documentnum);
			
			String gobackURL = request.getParameter("gobackURL");
			
			if(gobackURL != null && gobackURL.contains(" ")) {
				gobackURL = gobackURL.replace(" ", "&");
			}

			mav.addObject("gobackURL", gobackURL);
			
			mav.addObject("approverList", approverList);
			
			mav.setViewName("board/endApprovalDetail.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}

		// 나의 결재 참조 문서 보기
		@RequestMapping(value="/referenceApproval.groovy")
		public ModelAndView referenceApproval(ModelAndView mav, HttpSession session, HttpServletRequest request) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을 때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수 
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.	
			int totalPage = 0; // 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작행 번호
			int endRno = 0; // 끝 행 번호
			
			// 총 게시물 건수(totalCount)
		    totalCount = service.getReferenceApprovalTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null ) {
				// 게시판에 보여지는 초기화면 
				currentShowPageNo = 1;
			} else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			startRno =  (currentShowPageNo - 1) * sizePerPage + 1;
			endRno = startRno + sizePerPage - 1;
			
			paraMap.put("startRno", String.valueOf(startRno)); // 스트링타입으로 변환
			paraMap.put("endRno", String.valueOf(endRno));
			
			// ~~~~~~~~~~~~~~~~~~~~~~~
			
			List<Map<String,String>> referenceApprovalList = service.referenceApproval(paraMap);
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			int blockSize = 10;
			// blockSize는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
						
			int loop = 1;
			/*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	        */
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = request.getContextPath()+"/myApproval.groovy";
			
			// === [처음][이전] 만들기 == 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo=1'>[처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px #6449FC; color:#6449FC; padding: 2px 4px;'>"+pageNo+"</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:#6449FC;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}

				loop++;
				pageNo++;			
				} // end of while 
			
			// === [다음][마지막] 만들기 ==
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL.replace("&", " "));
			
			// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝
			///////////////////////////////////////////////////////////////////////
			
			// pk_documentnum 값 가져오기
			
			mav.addObject("referenceApprovalList", referenceApprovalList);
			
			mav.setViewName("board/referenceApproval.tiles1");
			
			return mav;
		}

		
		// 나의 결재참조 상세보기 
		@RequestMapping(value="/selectOneReferenceDocument.groovy")
		public ModelAndView selectOneReferenceDocument(ModelAndView mav, ApprovalVO approvalVO, ApproverVO approverVO, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("apl_no", apl_no);

			mav.addObject("apl_no",apl_no);

			if("1".equals(apl_no)) { // 비품신청
				
				ApprovalVO equipmentvo = service.selectEquipmentDocument(paraMap);
				
			//	System.out.println(equipmentvo.getEquipmentvo().getProductName());
			//	System.out.println("equipmentvo.getEquipmentvo() => " + equipmentvo.getEquipmentvo());
				mav.addObject("equipmentvo", equipmentvo);
				
			} else if("3".equals(apl_no)) { // 출장비 신청
				
				Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
				
				mav.addObject("businessCostMap", businessCostMap);
			
			} else if("4".equals(apl_no)) { // 식비신청
				
				Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
				
				mav.addObject("foodExpensesMap", foodExpensesMap);
			
			} else if("5".equals(apl_no)) { // 휴가신청
				
				Map<String,String> vacationMap = service.selectVacationDocument(paraMap);
				
				mav.addObject("vacationMap", vacationMap);
			
			} else if("6".equals(apl_no)) { // 휴직신청
				
				Map<String,String> absenceMap = service.selectAbsenceDocument(paraMap);
				
				mav.addObject("absenceMap", absenceMap);
			
			} else if("7".equals(apl_no)) { // 신규프로젝트신청
				
				Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
				
				mav.addObject("newProjectMap", newProjectMap);
			
			}
		
			// 승인자 참조자 조회하기
			List<ApproverVO> approverList = service.app_List(pk_documentnum);
			
			String gobackURL = request.getParameter("gobackURL");
			
			if(gobackURL != null && gobackURL.contains(" ")) {
				gobackURL = gobackURL.replace(" ", "&");
			}

			mav.addObject("gobackURL", gobackURL);
			
			mav.addObject("approverList", approverList);
			
			mav.setViewName("board/referenceApprovalDetail.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}
		
		
		
		
		
		// 내가등록한 문서 등록 취소
		@RequestMapping(value="/cancelApproval.groovy")
		public ModelAndView cancelApproval(ModelAndView mav, HttpServletRequest request) {
		
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("apl_no", apl_no);
			
			//System.out.println("pk_documentnum 확인용 컨트롤 =>"+pk_documentnum);
			
			int y = service.delApprover(paraMap);
			int n = service.delDocumentnum(paraMap);
			int x = service.delDocumnet(paraMap);
			
			if(n==1 && x==1 && y>0) {
				mav.setViewName("redirect:/myApproval.groovy");
				String message = "결재문서를 취소하였습니다.";
				String loc = request.getContextPath()+"/myApproval.groovy";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
				
			} else {
				String message = "결재취소에 실패했습니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
			}
			
			return mav;
		}	
		
		
		// == 첨부파일 다운로드 받기 ==
		@RequestMapping(value="/download.groovy")
		public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			// 첨부파일이 있는 글 번호
			
			/*
			 	첨부파일이 있는 글 번호에서 
			 	fileName 값을 DB에서 가져와야 한다.
			 	orgFileName 또한 가져와야 한다.
			 */
			
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("apl_no", apl_no);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = null;
	    	// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
			
			
				if("3".equals(apl_no)) { // 출장비 신청
					try {
					
						Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
						
							if(businessCostMap == null || (businessCostMap != null && businessCostMap.get("filename") == null) ) {
								out = response.getWriter();
								
								out.println("<script type='text/javascript'>alert('존재하지 않거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
								return; // 종료
							} else {
								// 정상적으로 다운로드를 할 경우
								
								String fileName = businessCostMap.get("filename");
								// 톰캣디스크에 저장된 파일이름
								String orgFilename = businessCostMap.get("orgfilename");
								// 다운로드 시 보여줄 파일명 
								
								// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
					            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
								
								// WAS 의 wepapp 의 절대경로를 알아와야 한다.
								HttpSession session = request.getSession();	
								String root = session.getServletContext().getRealPath("/");
								
						//		System.out.println("확인용  webapp의 절대경로  =>" + root);
								// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
								
								String path = root + "resources"+File.separator+"files";
								/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
								       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
								       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
							    */
								
								// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
							//	System.out.println("확인용 path  =>" + path);
								// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
								
								// ***** 파일 다운로드하기 *****
								boolean flag =false; // file 다운로드 성공, 실패를 알려주는 용도
								flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
								// 파일 다운로드 성공 시 flag는 true,
								// 파일 다운로드 실패 시 flag는 false 를 가진다.
								
								if(!flag) {
									// 다운로드가 실패할 경우 메세지를 띄워준다. 
									out = response.getWriter();
									out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back();</script>");
								}
							}
							
						} catch(NumberFormatException | IOException e) {
							out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back();</script>");
							return; // 종료
				}
					
				} else if("4".equals(apl_no)) { // 식비신청
					try {
						Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
						
						if(foodExpensesMap == null || (foodExpensesMap != null && foodExpensesMap.get("filename") == null) ) {
							out = response.getWriter();
							
							out.println("<script type='text/javascript'>alert('존재하지 않거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
							return; // 종료
						} else {
							// 정상적으로 다운로드를 할 경우
							
							String fileName = foodExpensesMap.get("filename");
							// 톰캣디스크에 저장된 파일이름
							String orgFilename = foodExpensesMap.get("orgfilename");
							// 다운로드 시 보여줄 파일명 
							
							// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
				            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
							
							// WAS 의 wepapp 의 절대경로를 알아와야 한다.
							HttpSession session = request.getSession();	
							String root = session.getServletContext().getRealPath("/");
							
					//		System.out.println("확인용  webapp의 절대경로  =>" + root);
							// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
							
							String path = root + "resources"+File.separator+"files";
							/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
							       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
							       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
						    */
							
							// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
						//	System.out.println("확인용 path  =>" + path);
							// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
							
							// ***** 파일 다운로드하기 *****
							boolean flag =false; // file 다운로드 성공, 실패를 알려주는 용도
							flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
							// 파일 다운로드 성공 시 flag는 true,
							// 파일 다운로드 실패 시 flag는 false 를 가진다.
							
							if(!flag) {
								// 다운로드가 실패할 경우 메세지를 띄워준다. 
								out = response.getWriter();
								out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back();</script>");
							}
						}
					
					} catch(NumberFormatException | IOException e) {
						out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back();</script>");
						return; // 종료
					}
					
				}  else if("7".equals(apl_no)) { // 신규프로젝트신청
					
					try {
						
						Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
						
						if(newProjectMap == null || (newProjectMap != null && newProjectMap.get("filename") == null) ) {
							out = response.getWriter();
							
							out.println("<script type='text/javascript'>alert('존재하지 않거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
							return; // 종료
						} else {
							// 정상적으로 다운로드를 할 경우
							
							String fileName = newProjectMap.get("fileName");
							// 톰캣디스크에 저장된 파일이름
							String orgFilename = newProjectMap.get("orgFilename");
							// 다운로드 시 보여줄 파일명 
							
							// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
				            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
							
							// WAS 의 wepapp 의 절대경로를 알아와야 한다.
							HttpSession session = request.getSession();	
							String root = session.getServletContext().getRealPath("/");
							
					//		System.out.println("확인용  webapp의 절대경로  =>" + root);
							// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
							
							String path = root + "resources"+File.separator+"files";
							/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
							       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
							       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
						    */
							
							// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
						//	System.out.println("확인용 path  =>" + path);
							// 확인용  webapp의 절대경로  =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
							
							// ***** 파일 다운로드하기 *****
							boolean flag =false; // file 다운로드 성공, 실패를 알려주는 용도
							flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
							// 파일 다운로드 성공 시 flag는 true,
							// 파일 다운로드 실패 시 flag는 false 를 가진다.
							
							if(!flag) {
								// 다운로드가 실패할 경우 메세지를 띄워준다. 
								out = response.getWriter();
								out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back();</script>");
							}
						}
					
					} catch(NumberFormatException | IOException e) {
						out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back();</script>");
						return; // 종료
					}
				
				}
		}
		
		@RequestMapping(value="/employeeChart.groovy")
		public ModelAndView employeeChart(ModelAndView mav, HttpServletRequest request) {
			
			List<EmployeeVO> employeeList = service.getAllEmployeeList();
			
			mav.addObject("employeeList", employeeList);
			
			mav.setViewName("employee/employeeChart.tiles1");
			
			
			
			return mav;
		}
		
		
		
		// 관리자 결재내역 보기
		@RequestMapping(value="/adminApproval.groovy")
		public ModelAndView adminApproval(ModelAndView mav, ApprovalVO approvalVO, HttpSession session, HttpServletRequest request) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String fk_empnum = loginuser.getPk_empnum();
			String searchValue = request.getParameter("searchValue");
			
			mav.addObject("loginuser", loginuser);
			
			service.removeList();
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_empnum", fk_empnum);
			// 검색이 있는 나의 결재 내역 정보 조회
			paraMap.put("searchValue", searchValue);
			
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을 때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수 
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.	
			int totalPage = 0; // 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작행 번호
			int endRno = 0; // 끝 행 번호
			
			// 총 게시물 건수(totalCount)
		    totalCount = service.getAdminApprovalTotalCount(paraMap);
			
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null ) {
				// 게시판에 보여지는 초기화면 
				currentShowPageNo = 1;
			} else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			startRno =  (currentShowPageNo - 1) * sizePerPage + 1;
			endRno = startRno + sizePerPage - 1;
			
			paraMap.put("startRno", String.valueOf(startRno)); // 스트링타입으로 변환
			paraMap.put("endRno", String.valueOf(endRno));
			
			// ~~~~~~~~~~~~~~~~~~~~~~~
			
			List<Map<String,String>> adminApprovalList = service.adminApprovalList(paraMap);
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			mav.addObject("searchValue",searchValue);
			
			int blockSize = 10;
			// blockSize는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
						
			int loop = 1;
			/*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	        */
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = request.getContextPath()+"/adminApproval.groovy";
			
			if(searchValue == null ) {
				searchValue = "";
			}
			
			// === [처음][이전] 만들기 == 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo=1'>[처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px #6449FC; color:#6449FC; padding: 2px 4px;'>"+pageNo+"</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}

				loop++;
				pageNo++;			
				} // end of while 
			
			// === [다음][마지막] 만들기 ==
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; color:#6449FC;'><a href='"+url+"?searchValue="+searchValue+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
			mav.addObject("gobackURL", gobackURL.replace("&", " "));
			
			// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝
			///////////////////////////////////////////////////////////////////////
			
			mav.addObject("adminApprovalList", adminApprovalList);
			
			mav.setViewName("board/adminApproval.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}
		
		// 관리자 결재정보 상세정보 조회하기
		@RequestMapping(value="/selectOneAdminDocument.groovy")
		public ModelAndView selectOneAdminDocument(ModelAndView mav, ApprovalVO approvalVO, ApproverVO approverVO, HttpSession session, HttpServletRequest request ) {
			
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			String fk_empnum = loginuser.getPk_empnum();
			
			String pk_documentnum = request.getParameter("pk_documentnum");
			String apl_no = request.getParameter("apl_no");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pk_documentnum", pk_documentnum);
			paraMap.put("fk_empnum", fk_empnum);
			paraMap.put("apl_no", apl_no);

			mav.addObject("apl_no",apl_no);

			if("1".equals(apl_no)) { // 비품신청
				
				ApprovalVO equipmentvo = service.selectEquipmentDocument(paraMap);
				
			//	System.out.println(equipmentvo.getEquipmentvo().getProductName());
			//	System.out.println("equipmentvo.getEquipmentvo() => " + equipmentvo.getEquipmentvo());
				mav.addObject("equipmentvo", equipmentvo);
				
			} else if("3".equals(apl_no)) { // 출장비 신청
				
				Map<String,String> businessCostMap = service.selectBusinessCostDocument(paraMap);
				
				mav.addObject("businessCostMap", businessCostMap);
			
			} else if("4".equals(apl_no)) { // 식비신청
				
				Map<String,String> foodExpensesMap = service.selectFoodExpensesDocument(paraMap);
				
				mav.addObject("foodExpensesMap", foodExpensesMap);
			
			} else if("5".equals(apl_no)) { // 휴가신청
				
				Map<String,String> vacationMap = service.selectVacationDocument(paraMap);
				
				mav.addObject("vacationMap", vacationMap);
			
			} else if("6".equals(apl_no)) { // 휴직신청
				
				Map<String,String> absenceMap = service.selectAbsenceDocument(paraMap);
				
				mav.addObject("absenceMap", absenceMap);
			
			} else if("7".equals(apl_no)) { // 신규프로젝트신청
				
				Map<String,String> newProjectMap = service.selectnewProjectDocument(paraMap);
				
				mav.addObject("newProjectMap", newProjectMap);
			
			}
		    
			// 승인자 참조자 조회하기
			List<ApproverVO> approverList = service.app_List(pk_documentnum);
			
			// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		    //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		    //           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = request.getParameter("gobackURL");
		//	System.out.println("gobackURL 확인용 =>" +gobackURL);
			// gobackURL 확인용 =>/list.action
			// gobackURL 확인용 =>/list.action?searchType=
			// replace 로 공백으로 바꿔준 후 
			// gobackURL 확인용 =>/list.action?searchType= searchWord= currentShowPageNo=2
			
			if(gobackURL != null && gobackURL.contains(" ")) {
				gobackURL = gobackURL.replace(" ", "&");
			}
			
//			System.out.println("~~~~ view 의 searchType : " + searchType);
//		    System.out.println("~~~~ view 의 searchWord : " + searchWord);
//		    System.out.println("~~~~ view 의 gobackURL : " + gobackURL);

			mav.addObject("gobackURL", gobackURL);
			
			mav.addObject("approverList", approverList);
			
			
			mav.setViewName("board/adminApprovalDetail.tiles1");
			// /WEB-INF/views/tiles1/board/expensesEdit.jsp
			
			return mav;
		}
	
}//end of public class JodnController