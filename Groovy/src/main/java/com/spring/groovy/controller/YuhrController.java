package com.spring.groovy.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.*;
import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.EmployeeVO;
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
	
	
	// 사원등록 요청
	@RequestMapping(value="/registerEnd.groovy", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView registerEnd(Map<String,String> paraMap, ModelAndView mav, EmployeeVO empVo, MultipartHttpServletRequest mrequest) {

		MultipartFile attach = empVo.getAttach();
		if(!attach.isEmpty()) { // attach(첨부파일)이 있다면
			/*
	            1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	            >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                       조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	        */
			
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
		//	System.out.println("~~ 확인용 webapp의 절대경로 =>" +root);
			// ~~ 확인용 webapp의 절대경로 =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\

			String path = root + "resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		             운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		             운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			*/
			
			// path 가 청부파일이 저장될 WAS(톰캣)의 폴더가 된다.
		//	System.out.println("~~ 확인용 path =>" +path);
			// ~~ 확인용 path =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\resources\files

			/*
		    	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기   
			 */
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것  
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것 
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); 
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				// attach.getOriginalFilename() 은 첨부파일의 파일명(예: 강아지.png)이다.
				
			//	System.out.println(">>> 확인용  newFileName => " + newFileName);
				// >>> 확인용  newFileName => 20220429202622949927811335000.jpg

				
			/*
			    3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기   
			*/
				empVo.setEmppicturefilename(newFileName);
				// WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png) 
				
				empVo.setEmppicturename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		int n = 0;
		
		if(attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			empVo.setEmppicturename("");
			n = service.addEmp(empVo);
		}
		else {
			// 파일첨부가 있는 경우라면
			n = service.addEmp(empVo);
		}
		
		if(n==1) {
			mav.addObject("message", "사원이 성공적으로 등록되었습니다.");
			mav.addObject("loc", mrequest.getContextPath()+"/index.groovy");
			
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "사원 등록에 실패했습니다.");
			mav.addObject("loc", "javascript:history.back()");
			
			mav.setViewName("msg");
		}
		
		return mav;
	}

	
	// 조직도 및 사원정보 조회 페이지
	@RequestMapping(value ="/viewEmp.groovy")
	public ModelAndView viewEmp(ModelAndView mav) {
		
		// 부서정보을 가져오기 위함
		List<DepartmentVO> departments = service.getDepts();
		
		// 직위정보을 가져오기 위함
		List<SpotVO> spots = service.getSpots();
				
		mav.addObject("departments", departments);
		mav.addObject("spots", spots);
		
		mav.setViewName("employee/viewEmp.tiles1");
		
		return mav;//  /WEB-INF/views/tiles1/employee/viewEmp.jsp 페이지 만들어야 한다.
		
	}//end of public ModelAndView viewEmp(ModelAndView mav)	
	
	
	// 근태관리 페이지(사원용 및 관리자용)
	@RequestMapping(value ="/worktime.groovy")
	public ModelAndView worktimeA(ModelAndView mav) {
		
		// 부서정보을 가져오기 위함
		List<DepartmentVO> departments = service.getDepts();
		
		// 직위정보을 가져오기 위함
		List<SpotVO> spots = service.getSpots();
		
		mav.addObject("departments", departments);
		mav.addObject("spots", spots);
		
		mav.setViewName("employee/worktime.tiles1");
		
		return mav;//  /WEB-INF/views/tiles1/employee/worktime.jsp 페이지 만들어야 한다.
		
	}//end of public ModelAndView viewEmp(ModelAndView mav)	
	
	
	
	
	
}//end of public class YuhrController