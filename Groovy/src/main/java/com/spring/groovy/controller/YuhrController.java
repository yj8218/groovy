package com.spring.groovy.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.*;
import com.spring.groovy.model.*;
import com.spring.groovy.service.*;

@Controller 
public class YuhrController {
	
	@Autowired
	private InterYuhrService service;
	
	@Autowired    
    private FileManager fileManager;
	
	// null 일때 "" 주는 메소드
	public String makeNotNull(String input) {
		if(input == null || "".equals(input)) {
			input = "";
		}
		return input;
	}
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	
	// 관리자가 사원을 등록시키는 페이지
	@RequestMapping(value ="/register.groovy")
	public ModelAndView register(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		int spotnum = loginuser.getFk_spotnum();
		
		if(spotnum != 0) {// 관리자가 아닌 사원은 못들어오게 한다(관리자의 spotnum 은 0)
			mav.addObject("message", "관리자만 들어올 수 있는 페이지입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		else {
			// 부서정보을 가져오기 위함
			List<DepartmentVO> departments = service.getDepts();
			
			// 직위정보을 가져오기 위함
			List<SpotVO> spots = service.getSpots();
					
			mav.addObject("departments", departments);
			mav.addObject("spots", spots);
			
			mav.setViewName("login/register.tiles1");
		}
		
		return mav;
	}
	
	
	// 사원 정보 중복검사(ajax 로 처리, 이메일, 휴대폰번호, 사원번호)
	@ResponseBody
	@RequestMapping(value="/empDuplicatedCheck.groovy", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String empnumCheck(HttpServletRequest request ) {
		
		String checkColumn = request.getParameter("checkColumn");
		String checkValue = request.getParameter("checkValue");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("checkColumn", checkColumn);
		paraMap.put("checkValue", checkValue);
		
		String s_using_infoVal = service.empDuplicatedCheck(paraMap);
		
		boolean isDuplicatedInfoVal = false; // true 면 중복, false 면 중복X
		
		if(s_using_infoVal != null ) {
			isDuplicatedInfoVal = true; // 중복이어서 true 로 전환
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isDuplicatedInfoVal", isDuplicatedInfoVal);
		
		return jsonObj.toString();
	}
	
	
	// 사원등록 요청
	@RequestMapping(value="/registerEnd.groovy", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView registerEnd(Map<String,String> paraMap, ModelAndView mav, EmployeeVO empVo, MultipartHttpServletRequest mrequest) {

		MultipartFile attach = empVo.getAttach();
		if(!attach.isEmpty()) { // attach(첨부파일)이 있다면
			
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
		//	System.out.println("~~ 확인용 webapp의 절대경로 =>" +root);
			// ~~ 확인용 webapp의 절대경로 =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\

			String path = root + "resources"+File.separator+"files";
			// path 가 청부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			
		//	System.out.println("~~ 확인용 path =>" +path);
			// ~~ 확인용 path =>C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Groovy\resources\files

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

	
	// 사원정보 조회 페이지
	@RequestMapping(value ="/viewEmp.groovy")
	public ModelAndView viewEmp(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		int spotnum = loginuser.getFk_spotnum();
		
		if(spotnum != 0) {// 관리자의 spotnum 은 0
			mav.addObject("message", "관리자만 들어올 수 있는 페이지입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		else {
			// 부서정보을 가져오기 위함
			List<DepartmentVO> departments = service.getDepts();
			
			// 직위정보을 가져오기 위함
			List<SpotVO> spots = service.getSpots();
			
			Map<String, String> paraMap = new HashMap<>();
			
			String dept = request.getParameter("dept");
			String spot = request.getParameter("spot");
			String date_start = request.getParameter("date_start");
			String date_end = request.getParameter("date_end");
			String resign_status = request.getParameter("resign_status");
			String search_item = request.getParameter("search_item");
			String search_value = request.getParameter("search_value");
			String select_order = request.getParameter("select_order");
			
			// null 일때 "" 주는 메소드
			dept = makeNotNull(dept);
			spot = makeNotNull(spot);
			date_start = makeNotNull(date_start);
			date_end = makeNotNull(date_end);
			resign_status = makeNotNull(resign_status);
			search_item = makeNotNull(search_item);
			search_value = makeNotNull(search_value);
			if(select_order == null) {
				select_order = "pk_empnum desc";
			}
			
			paraMap.put("dept", dept);
			paraMap.put("spot", spot);
			paraMap.put("date_start", date_start);
			paraMap.put("date_end", date_end);
			paraMap.put("resign_status", resign_status);
			paraMap.put("search_item", search_item);
			paraMap.put("search_value", search_value);
			paraMap.put("select_order", select_order);
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			int totalCount = 0; 		// 총 게시물 개수
			int sizePerPage = 10; 		// 한 페이지당 보여줄 게시물 개수
			int currentShowPageNo = 0; 	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 한다.
			int totalPage = 0; 			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; 	// 시작행 번호
			int endRno = 0; 	// 끝행 번호
			
			// 조회한 조건에 따른 총 사원의 수
			totalCount = service.getTotalCount(paraMap);
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
					
			if(str_currentShowPageNo == null) {
				// 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			}
			else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
					
				} catch (NumberFormatException e) {
					currentShowPageNo = 1;
				}
				
			}
			
			// 공식
			startRno = ((currentShowPageNo -1) * sizePerPage) + 1;
			endRno = startRno + sizePerPage -1;
			
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			
			///////// 검색 조건에 따른 페이지바 보여주기 시작 ////////////////////////
			int blockSize = 5; 
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		      
			String pageBar = "<ul style='list-style: none;'>";
			String url = "viewEmp.groovy";
			
			
			// === [맨처음][이전] 만들기 === // 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&spot="+spot+"&date_start="+date_start+"&date_end="+date_end+"&resign_status="+resign_status+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&spot="+spot+"&date_start="+date_start+"&date_end="+date_end+"&resign_status="+resign_status+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:14pt; font-weight: bold; padding: 2px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&spot="+spot+"&date_start="+date_start+"&date_end="+date_end+"&resign_status="+resign_status+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}// end of while ----------
			
			
			// === [다음][마지막] 만들기 === // 
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&spot="+spot+"&date_start="+date_start+"&date_end="+date_end+"&resign_status="+resign_status+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+(pageNo)+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&spot="+spot+"&date_start="+date_start+"&date_end="+date_end+"&resign_status="+resign_status+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			mav.addObject("pageBar", pageBar);
			
			///////// 검색 조건에 따른 페이지바 보여주기 끝 ////////////////////////
			
			
			// 직원정보를 가져오기 위함(부서, 직위 join)
			List<EmployeeVO> emps = service.getEmps(paraMap);
			
			mav.addObject("departments", departments);
			mav.addObject("spots", spots);
			mav.addObject("emps", emps);
			mav.addObject("currentShowPageNo", currentShowPageNo);
			
			// 뷰단에 값을 고정시키기 위함
			mav.addObject("dept", dept);
			mav.addObject("spot", spot);
			mav.addObject("date_start", date_start);
			mav.addObject("date_end", date_end);
			mav.addObject("resign_status", resign_status);
			mav.addObject("search_item", search_item);
			mav.addObject("search_value", search_value);
			mav.addObject("select_order", select_order);
			
			mav.setViewName("employee/viewEmp.tiles1");
		}
		
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value ="/getOneEmpInfo.groovy", produces="text/plain;charset=UTF-8")
	public String getOneEmpInfo(HttpServletRequest request ) {
		
		String pk_empnum = request.getParameter("pk_empnum"); // 한명의 사원번호를 받아옴

		// 한명의 사원 상세정보 가져오기
		EmployeeVO oneEmp = service.getOneEmp(pk_empnum);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("pk_empnum", oneEmp.getPk_empnum());
		jsonObj.put("name", oneEmp.getName());
		jsonObj.put("birthday", oneEmp.getBirthday());
		jsonObj.put("gender", oneEmp.getGender());
		jsonObj.put("age", oneEmp.getAge());

		jsonObj.put("postcode", oneEmp.getPostcode());
		jsonObj.put("address", oneEmp.getAddress());
		jsonObj.put("detailaddress", oneEmp.getDetailaddress());
		
		jsonObj.put("phone", oneEmp.getPhone());
		jsonObj.put("email", oneEmp.getEmail());
		
		jsonObj.put("deptnamekor", oneEmp.getDeptnamekor());
		jsonObj.put("spotnamekor", oneEmp.getSpotnamekor());
		
		jsonObj.put("startday", oneEmp.getStartday());
		jsonObj.put("resignationstatus", oneEmp.getResignationstatus());
		jsonObj.put("resignationday", oneEmp.getResignationday());
		jsonObj.put("fk_vstatus", oneEmp.getFk_vstatus());
		jsonObj.put("salary", oneEmp.getSalary());
		
		jsonObj.put("emppicturename", oneEmp.getEmppicturename());
		
		return jsonObj.toString();
	}
	
	
	// 근태관리 페이지(관리자용)
	@RequestMapping(value ="/worktime.groovy")
	public ModelAndView worktimeA(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		int spotnum = loginuser.getFk_spotnum();

		if(spotnum != 0) {// 관리자의 spotnum 은 0
			// 관리자만 들어올 수 있는 페이지입니다. => 이전페이지로 보내기
			mav.addObject("message", "관리자만 들어올 수 있는 페이지입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		else {
			// 부서정보을 가져오기 위함
			List<DepartmentVO> departments = service.getDepts();
			
			// 근태정보을 가져오기 위함
			List<CommuteStatusVO> commStatusList = service.getCommStatus();
			
			Map<String, String> paraMap = new HashMap<>();
			String dept = request.getParameter("dept");
			String date_start = request.getParameter("date_start");
			String date_end = request.getParameter("date_end");
			String search_item = request.getParameter("search_item");
			String search_value = request.getParameter("search_value");
			String select_order = request.getParameter("select_order");

			// null 일때 "" 주는 메소드
			dept = makeNotNull(dept);
			date_start = makeNotNull(date_start);
			date_end = makeNotNull(date_end);
			search_item = makeNotNull(search_item);
			search_value = makeNotNull(search_value);
			if(select_order == null) {
				select_order = "";
			}
			
			paraMap.put("dept", dept);
			paraMap.put("date_start", date_start);
			paraMap.put("date_end", date_end);
			paraMap.put("search_item", search_item);
			paraMap.put("search_value", search_value);
			paraMap.put("select_order", select_order);
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			int totalCount = 0; 		// 총 게시물 개수
			int sizePerPage = 5; 		// 한 페이지당 보여줄 게시물 개수
			int currentShowPageNo = 0; 	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 한다.
			int totalPage = 0; 			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; 	// 시작행 번호
			int endRno = 0; 	// 끝행 번호
			
			// 조회한 조건에 따른 총 근태의 수
			totalCount = service.getCommuteTotalCount(paraMap);
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);

			if(str_currentShowPageNo == null) {
				// 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			}
			else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
					
				} catch (NumberFormatException e) {
					currentShowPageNo = 1;
				}
				
			}
			
			// 공식
			startRno = ((currentShowPageNo -1) * sizePerPage) + 1;
			endRno = startRno + sizePerPage -1;
			
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			
			///////// 검색 조건에 따른 페이지바 보여주기 시작 ////////////////////////
			int blockSize = 2; 
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		      
			String pageBar = "<ul style='list-style: none;'>";
			String url = "worktime.groovy";
			
			
			// === [맨처음][이전] 만들기 === // 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&date_start="+date_start+"&date_end="+date_end+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&date_start="+date_start+"&date_end="+date_end+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:14pt; font-weight: bold; padding: 2px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&date_start="+date_start+"&date_end="+date_end+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}// end of while ----------
			
			
			// === [다음][마지막] 만들기 === // 
			
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&date_start="+date_start+"&date_end="+date_end+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+(pageNo)+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:14pt; '><a href='"+url+"?dept="+dept+"&date_start="+date_start+"&date_end="+date_end+"&search_item="+search_item+"&search_value="+search_value+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			mav.addObject("pageBar", pageBar);
			
			///////// 검색 조건에 따른 페이지바 보여주기 끝 ////////////////////////
			
			
			// 조건에 맞는 사원의 부서,재직여부,근태정보들,총근무일수,총근무시간
			List<Map<String, String>> commuteStatusInfo = service.getCommuteStatusInfo(paraMap);
			
			mav.addObject("departments", departments);
			mav.addObject("commStatusList", commStatusList);
			mav.addObject("commuteStatusInfo", commuteStatusInfo);
			
			// 뷰단에 값을 고정시키기 위함
			mav.addObject("dept", dept);
			mav.addObject("date_start", date_start);
			mav.addObject("date_end", date_end);
			mav.addObject("search_item", search_item);
			mav.addObject("search_value", search_value);
			mav.addObject("select_order", select_order);
						
			mav.setViewName("employee/worktime.tiles1");
		}
		
		return mav;
	}
	
	
	// 출근 버튼 기능
	@RequestMapping(value ="/commutebutton.groovy")
	public ModelAndView requiredLogin_commutebutton(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		getCurrentURL(request);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		String pk_empnum ="";
		if(loginuser != null) {
			pk_empnum = loginuser.getPk_empnum();
		}
		
		// 출근시각, 퇴근시각 유지시키기 위함
		Map<String, String> WorkTime = service.getStartWorkTime(pk_empnum);
		
		mav.addObject("pk_empnum", pk_empnum);
		mav.addObject("WorkTime", WorkTime);
		
		mav.setViewName("index.tiles1");
		
		return mav;
	}
	
	
	// 출근 버튼 클릭(insert)
	@ResponseBody
	@RequestMapping(value ="/startWork.groovy", method = {RequestMethod.POST})
	public String startWork(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		String pk_empnum = loginuser.getPk_empnum();
		
		// TBL_COMMUTE 에 오늘의 출근 insert
		int n = service.startWork(pk_empnum);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	
	// 출근 찍고 나서 근태 처리 해주는 메소드
	@ResponseBody
	@RequestMapping(value ="/checkStartCommuteStatus.groovy", method = {RequestMethod.POST})
	public String checkCommuteStatus(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		System.out.println("~~ checkCommuteStatus 확인용 loginuser => " + loginuser);
		
		String pk_empnum = loginuser.getPk_empnum();
		
		// 출근을 버튼을 클릭한 시각으로 지각인지 아닌지 판별하는 것이다
		LocalTime now = LocalTime.now();
		
		// 정상 출근시각은 9시로 한다
		LocalTime fixedStartWTime = LocalTime.of(9, 20, 00);
		
		// 지각한 경우 
		if(!now.isBefore(fixedStartWTime)) {
			System.out.println("지각");
			// tbl_commute_status 에 지각 1 입력
			service.status_late(pk_empnum);
		}
		else {
			System.out.println("정상출근");
			// tbl_commute_status 에 등록할 근태상황은 없다.
		}
		
		JSONObject jsonObj = new JSONObject();
		
		return jsonObj.toString();
	}
		
		
	// 오늘 출석 찍었는지 로그인한 아이디로 검사해서 출근버튼 막을지 확인하는 용도
	@ResponseBody
	@RequestMapping(value ="/isClickedStartBtn.groovy", method = {RequestMethod.POST})
	public String isClickedStartBtn(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		String pk_empnum = loginuser.getPk_empnum(); //
		
		JSONObject jsonObj = new JSONObject();
		
		int n = service.isClickedStartBtn(pk_empnum);
		
		if(n==1) { // 출근 찍음
			jsonObj.put("isClickedStartBtn", true); 
		}
		
		return jsonObj.toString();
	}
	
	
	// 퇴근 버튼 클릭(update)
	@ResponseBody
	@RequestMapping(value ="/endWork.groovy", method = {RequestMethod.POST})
	public String endWork(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		String pk_empnum = loginuser.getPk_empnum();
		
		JSONObject jsonObj = new JSONObject();
		
		// tbl_commute 테이블 오늘의 자기 행에 퇴근 update
		int n = service.endWork(pk_empnum);
		
		// 퇴근 버튼을 클릭한 시각으로 조기퇴근인지, 퇴근미체크인지, 결근인지 판별하는 것이다
		LocalTime now = LocalTime.now();
		
		// 정상 퇴근시각 18시
		LocalTime fixedStartWTime = LocalTime.of(18, 00, 00);
		
		// 조기퇴근인 경우
		if(n == 1 && now.isBefore(fixedStartWTime)) {
			System.out.println("조기퇴근");
			// tbl_commute_status 에 조기퇴근 1 update
			service.status_early_endcheck(pk_empnum);
		}
		else {// 정상퇴근인경우
			System.out.println("정상퇴근");
			// tbl_commute_status 에 등록할 근태상황은 없다.
		}
		
		// 로그인한 사원의 오늘 근무한 시간을 계산해서 초단위까지 db 에 update
		service.todayworkedtime(pk_empnum);

		return jsonObj.toString();
	}
	
	
	// Spring Scheduler 를 사용하여 자정에 퇴근 근태 체크하기(퇴근미체크인지, 결근) 
	@RequestMapping(value="/checkEndCommuteStatus.groovy")
	public ModelAndView checkEndCommuteStatus(ModelAndView mav, HttpServletRequest request) {
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		String currentTime = dateFormat.format(currentDate.getTime());
		
		// 오늘 출근한 모든 사원들중 퇴근을 찍지 않은 사원 정보 조회 -> 퇴근미체크
		service.status_no_endcheck();
		
		// 오늘 출근했어야 하는 사원들중(휴가중이 아닌 사원들) 출근 찍지 않은(tbl_commute 에 데이터가 없는) 사원 정보 조회 -> 결근
		// 오늘 휴무 아닌데 출근 안한 사원들의 empnum
		List<String> empsNoWorkToday = new ArrayList<>(); 
		empsNoWorkToday = service.getEmpsNoWorkToday();
		
		for(String emp_nowork : empsNoWorkToday) {
			service.status_no_workday(emp_nowork);
		}
				
		String message = currentTime+", 오늘의 근태가 등록되었습니다.";
		String loc = request.getContextPath()+"/index.groovy";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		return mav;
	}
	
	
	// 한 사원의 근태기록을 보여주는 페이지 - 사원만
	@RequestMapping(value="/showOneCommuteStatus.groovy")
	public ModelAndView showOneCommuteStatus(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		int spotnum = loginuser.getFk_spotnum();
		String login_empnum = loginuser.getPk_empnum();
		
		String date_start = request.getParameter("date_start");
		String date_end = request.getParameter("date_end");
		
		date_start = makeNotNull(date_start);
		date_end = makeNotNull(date_end);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("date_start", date_start);
		paraMap.put("date_end", date_end);
		
		String pk_empnum = "";
		
		if(request.getParameter("pk_empnum") == null) { // 사원이 로그인 했을 경우 넘겨받는 pk_empnum 파라미터는 null 이고, 자신의 것만 조회하면 되므로
			pk_empnum = login_empnum;
		}else { // 관리자가 로그인 했을 경우 전체사원 근태관리 조회 페이지에 접근 가능, 넘겨받는 pk_empnum 파라미터가 존재한다.
			pk_empnum = request.getParameter("pk_empnum");
		}
		paraMap.put("pk_empnum", pk_empnum);

		// 한 사원의 출퇴근기록, 근태관리 기록을 다 가져온다
		List<Map<String, String>> OneCommuteStatus = service.showOneCommuteStatus(paraMap);
		
		mav.addObject("OneCommuteStatus", OneCommuteStatus);
		mav.addObject("loginuser", loginuser);
		
		if(spotnum != 0  ) {// 사원으로 로그인 하고 
			if(login_empnum.equals(pk_empnum)) {// 자신의 근태기록을 클릭한경우
				mav.setViewName("employee/oneCommuteStatus.tiles1");
			}
			else {// 다른 사람의 근태기록을 보려고 하는 경우
				mav.addObject("message", "다른 사원의 근태기록은 조회할 수 없습니다.");
				mav.addObject("loc", "javascript:history.back()");
				
				mav.setViewName("msg");
			}
		}
		else {// 관리자로 로그인 한 경우
			mav.setViewName("employee/oneCommuteStatus.tiles1");
		}
		
		return mav;
	}
	
	
	// 한 사원의 근태기록을 보여주는 페이지 - 관리자, ajax
	@ResponseBody
	@RequestMapping(value ="/showOneCommuteStatusByAjax.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String showOneCommuteStatusByAjax(HttpServletRequest request ) {
		
		String pk_empnum = request.getParameter("pk_empnum");
		System.out.println("확인용  => "+pk_empnum);
		JSONObject jsonObj = new JSONObject();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("date_start", "");
		paraMap.put("date_end", "");
		
		// 한 사원의 출퇴근기록, 근태관리 기록을 다 가져온다
		List<Map<String, String>> OneCommuteStatus = service.showOneCommuteStatus(paraMap);
		
		jsonObj.put("OneCommuteStatus", OneCommuteStatus);
		jsonObj.put("pk_empnum", pk_empnum);

		return jsonObj.toString();
	}
	
	
	// 스톱워치 기록을 유지시켜주는 용도
	@ResponseBody
	@RequestMapping(value ="/getStartWorkTime.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String getStartWorkTime(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		String login_empnum = loginuser.getPk_empnum();
		JSONObject jsonObj = new JSONObject();
		
		// 출근한 시각 알아오기
		Map<String, String> startWorkTime = service.getStartWorkTime(login_empnum);
		
		jsonObj.put("startWorkTime", startWorkTime);
		
		return jsonObj.toString();
	}
	
	
}//end of public class YuhrController