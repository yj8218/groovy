package com.spring.groovy.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.FileManager;
import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.Calendar_schedule_VO;
import com.spring.groovy.model.Calendar_small_category_VO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.service.InterKimyjService;


	@Controller //bean + controller
	public class KimyjController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterKimyjService service;
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
		
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="/scheduleManagement.groovy")
	public ModelAndView showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
				
		mav.setViewName("board/scheduleManagement.tiles1");

		return mav;
	}//end of public ModelAndView showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)
	
	// === 사내 캘린더에 사내캘린더 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/addComCalendar.groovy",method = {RequestMethod.POST})
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		
		String com_smcatgoname = request.getParameter("com_smcatgoname");
		String fk_empnum = request.getParameter("fk_empnum");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("com_smcatgoname",com_smcatgoname);
		paraMap.put("fk_empnum",fk_empnum);
		
		int n = service.addComCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}//end of public String addComCalendar(HttpServletRequest request) throws Throwable 
	
	
	// === 내 캘린더에 내캘린더 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/addMyCalendar.groovy",method = {RequestMethod.POST})
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String my_smcatgoname = request.getParameter("my_smcatgoname");
		String fk_empnum = request.getParameter("fk_empnum");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("my_smcatgoname",my_smcatgoname);
		paraMap.put("fk_empnum",fk_empnum);
		
		int n = service.addMyCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}//end of public String addMyCalendar(HttpServletRequest request) throws Throwable 
	
	
	// === 사내 캘린더에서 사내캘린더 소분류  보여주기 ===
	@ResponseBody
	@RequestMapping(value="/showCompanyCalendar.groovy",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")  
	public String showCompanyCalendar() {
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showCompanyCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("pk_smcatgono", smcatevo.getPk_smcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}//end of public String showCompanyCalendar() 
	
	
	// === 내 캘린더에서 내캘린더 소분류  보여주기 ===
	@ResponseBody
	@RequestMapping(value="/showMyCalendar.groovy",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showMyCalendar(HttpServletRequest request) {
		
		String fk_empnum = request.getParameter("fk_empnum");
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showMyCalendar(fk_empnum);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("pk_smcatgono", smcatevo.getPk_smcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}//end of public String showMyCalendar(HttpServletRequest request)
	
	// === 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 ===
	@ResponseBody
	@RequestMapping(value="/selectSmallCategory.groovy",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String selectSmallCategory(HttpServletRequest request) {
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 캘린더 대분류 번호
		String fk_empnum = request.getParameter("fk_empnum");       // 사용자아이디
		//System.out.println(fk_empnum);
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("fk_empnum", fk_empnum);//fk pk 혼돈 주의
		
		List<Calendar_small_category_VO> small_category_VOList = service.selectSmallCategory(paraMap);
			
		JSONArray jsArr = new JSONArray();
		if(small_category_VOList != null) {
			for(Calendar_small_category_VO scvo : small_category_VOList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("pk_smcatgono", scvo.getPk_smcatgono());
				jsObj.put("smcatgoname", scvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	}//end of ublic String selectSmallCategory(HttpServletRequest request)
	
	
	// === 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@ResponseBody
	@RequestMapping(value="/searchJoinUserList.groovy", produces="text/plain;charset=UTF-8")
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinUserName = request.getParameter("joinUserName");
		// 사원 명단 불러오기
		List<EmployeeVO> joinUserList = service.searchJoinUserList(joinUserName);
	
		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			
			for(EmployeeVO empvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				//jsObj.put("userid", empvo.getUserid());
				jsObj.put("pk_empnum", empvo.getPk_empnum());
				jsObj.put("name", empvo.getName());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
		
	}//end of public String searchJoinUserList(HttpServletRequest request)
	
	
	// === 일정 등록하기 ===
	@ResponseBody
	@RequestMapping(value ="/registerSchedule_end_withAttach.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String registerSchedule_end_withAttach(Calendar_schedule_VO scheduleVO, MultipartHttpServletRequest mrequest ) {
	//public String registerSchedule_end(Calendar_schedule_VO scheduleVO, HttpServletRequest mrequest ) {
		
		MultipartFile attach= scheduleVO.getAttach();
		//System.out.println("확인: "+attach);
		String vote = scheduleVO.getVote();
		//System.out.println("확인: "+vote);
		
		
		if(scheduleVO.getVote() == null) {
			scheduleVO.setVote("0");
		}
		//System.out.println("확인: "+vote);
		
		String Joinuser = scheduleVO.getJoinuser();
		//System.out.println("확인: "+Joinuser);
		if(!attach.isEmpty()) {//존재하는지 여부 파일첨부파일게시물 확인
			/*
            1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
            >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                       조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다. 
            //was webapp의 절대경로를 알아야한다.                           
            */
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			//System.out.println("root "+root);
			
			String path = root + "resources"+File.separator+"download";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			*/
			
			//path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//System.out.println("path "+path);
			
			//2. 파일첨부를 위한 변수의 설정및 값을 초기화 한후 파일 올리기
			
			String newFileName = "";//WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;//첨부파일의 내용물 담는것
			
			long fileSize = 0;//첨부파일의 크기
			
			try {
				bytes = attach.getBytes();//첨부파일의 내용물 읽어온다.
				
				String originalFilename = attach.getOriginalFilename();
				//getOriginalFilename 첨부파일의 파일명(예: 강아지.png);
				//System.out.println("originalFilename "+originalFilename);
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				//첨부된 파일을 업로드 하도록 하는 것이다.
				//System.out.println("newFileName "+newFileName);
				
				
				//2. boardvo에 fileName 값과 originalFilename, fileSize값 넣어주기
				
				scheduleVO.setFileName(newFileName);//WAS(톰캣)의 디스크에 저장될 파일명
				scheduleVO.setOrgFilename(originalFilename);
				//게시판 페이지에서 첨부된파일(강아지,png)을 보여줄때 사용
				//또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용
				fileSize = attach.getSize();//첨부파일의 크기(단위 바이트)
				scheduleVO.setFileSize(String.valueOf(fileSize));
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		int n = 0;
		try {
			n = service.registerSchedule_end(scheduleVO);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
		// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	    // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.) 
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
		
	}//end of public String registerSchedule_end_withAttach(Calendar_schedule_VO scheduleVO, MultipartHttpServletRequest mrequest )
	
	
	
	// === 일정 등록하기 ===
	@ResponseBody
	@RequestMapping(value ="/registerSchedule_end_noAttach.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String registerSchedule_end_noAttach(Calendar_schedule_VO scheduleVO, HttpServletRequest request ) {

		if(scheduleVO.getVote() == null) {
			scheduleVO.setVote("0");
		}
		int n = 0;
		
		try {
			n = service.registerSchedule_end(scheduleVO);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
		// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	    // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.) 
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
		
	}//end of public String registerSchedule_end_noAttach(Calendar_schedule_VO scheduleVO, HttpServletRequest request )

	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@RequestMapping(value="/selectSchedule.groovy", produces="text/plain;charset=UTF-8")
	public String selectSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String fk_empnum = request.getParameter("fk_empnum");
				
		List<Calendar_schedule_VO> scheduleList = service.selectSchedule(fk_empnum);
		
		JSONArray jsArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			
			for(Calendar_schedule_VO svo : scheduleList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("subject", svo.getSubject());
				jsObj.put("startdate", svo.getStartdate());
				jsObj.put("enddate", svo.getEnddate());
				jsObj.put("color", svo.getColor());
				jsObj.put("pk_scheduleno", svo.getPk_scheduleno());
				jsObj.put("fk_lgcatgono", svo.getFk_lgcatgono());
				jsObj.put("fk_smcatgono", svo.getFk_smcatgono());
				jsObj.put("fk_empnum", svo.getFk_empnum());
				jsObj.put("joinuser", svo.getJoinuser());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	}//end of public String selectSchedule(HttpServletRequest request)
	
	
	
	// === 일정상세보기 ===
	@ResponseBody
	@RequestMapping(value="/detailSchedule.groovy", produces="text/plain;charset=UTF-8")
	public String detailSchedule(HttpServletRequest request) {
		
		String pk_scheduleno = request.getParameter("pk_scheduleno");
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		//mav.addObject("listgobackURL_schedule",listgobackURL_schedule);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = MyUtil.getCurrentURL(request);
		//mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(pk_scheduleno);
			Map<String,String> map = service.detailSchedule(pk_scheduleno);
			
			JSONObject jsonObj = new JSONObject();//
			
			jsonObj.put("map", map);//{"n":1}
			return jsonObj.toString();//"{"n":1}"
			
		} catch (NumberFormatException e) {
			//mav.setViewName("redirect:/scheduleManagement.groovy");
			return gobackURL_detailSchedule;
		}

		
	}//end of public String detailSchedule(HttpServletRequest request) 
	
	// === 일정삭제하기 ===
	@ResponseBody
	@RequestMapping(value="/deleteSchedule.groovy", method = {RequestMethod.POST})
	public String deleteSchedule(HttpServletRequest request) throws Throwable {
		
		String pk_scheduleno = request.getParameter("pk_scheduleno");
				
		int n = service.deleteSchedule(pk_scheduleno);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String deleteSchedule(HttpServletRequest request) throws Throwable
	
	
	
	// === 일정 수정하기 ===
	@RequestMapping(value="/editSchedule.groovy", method = {RequestMethod.POST})
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String pk_scheduleno= request.getParameter("pk_scheduleno");
   		
		try {
			Integer.parseInt(pk_scheduleno);
			
			String gobackURL_detailSchedule = request.getParameter("gobackURL_detailSchedule");
			
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(pk_scheduleno);
			
			//if( !loginuser.getUserid().equals( map.get("FK_USERID") ) ) {
			if( !loginuser.getPk_empnum().equals( map.get("fk_empnum") ) ) {	
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
				
				mav.setViewName("board/editSchedule.tiles1");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/scheduleManagement.groovy");
		}
		
		return mav;
		
	}//end of public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request)
	
	
	
	// === 일정 수정 완료하기 ===
	@RequestMapping(value="/editSchedule_end.groovy", method = {RequestMethod.POST})
	public ModelAndView editSchedule_end(Calendar_schedule_VO svo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			 int n = service.editSchedule_end(svo);
			 
			 if(n==1) {
				 mav.addObject("message", "일정을 수정하였습니다.");
				 mav.addObject("loc", request.getContextPath()+"/scheduleManagement.groovy");
			 }
			 else {
				 mav.addObject("message", "일정 수정에 실패하였습니다.");
				 mav.addObject("loc", "javascript:history.back()");
			 }
			 
			 mav.setViewName("msg");
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("redirect:/scheduleManagement.groovy");
		}
			
		return mav;
	}//end of public ModelAndView editSchedule_end(Calendar_schedule_VO svo, HttpServletRequest request, ModelAndView mav)
	
	// === (사내캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기  === 	
	@ResponseBody
	@RequestMapping(value="/deleteSubCalendar.groovy", method = {RequestMethod.POST})
	public String deleteSubCalendar(HttpServletRequest request) throws Throwable {
		
		String pk_smcatgono = request.getParameter("pk_smcatgono");//수정필요
				
		int n = service.deleteSubCalendar(pk_smcatgono);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String deleteSubCalendar(HttpServletRequest request) throws Throwable 
	
	// === (사내캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 === 
	@ResponseBody
	@RequestMapping(value="/editCalendar.groovy", method = {RequestMethod.POST})
	public String editComCalendar(HttpServletRequest request) throws Throwable {
		
		String pk_smcatgono = request.getParameter("pk_smcatgono");//수정필요
		String smcatgoname = request.getParameter("smcatgoname");
		String fk_empnum = request.getParameter("fk_empnum");//수정필요
		String caltype = request.getParameter("caltype");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_smcatgono", pk_smcatgono);
		paraMap.put("smcatgoname", smcatgoname);
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalendar(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String editComCalendar(HttpServletRequest request) throws Throwable
	
	
	// === 검색 기능 === //
	@RequestMapping(value="/searchSchedule.groovy", method = {RequestMethod.GET})
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> scheduleList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_empnum = request.getParameter("fk_empnum");  // 로그인한 사용자id
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
	
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		
		if(searchType==null || (!"subject".equals(searchType) && !"content".equals(searchType)  && !"joinuser".equals(searchType))) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		if(fk_lgcatgono == null ) {
			fk_lgcatgono="";
		}
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		
		int totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = Integer.parseInt(str_sizePerPage);  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    totalCount = service.getTotalCount(paraMap);
	    //System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    	   
	    scheduleList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
		int blockSize= 5;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
		String pageBar = "<ul style='list-style:none;'>";
		
		String url = "searchSchedule.groovy";
		
		// === [맨처음][이전] 만들기 ===
		if(pageNo!=1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_empnum="+fk_empnum+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_empnum="+fk_empnum+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop>blockSize || pageNo>totalPage)) {
			
			if(pageNo==currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_empnum="+fk_empnum+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}// end of while--------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_empnum="+fk_empnum+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_empnum="+fk_empnum+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
		//System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("scheduleList", scheduleList);
		mav.setViewName("board/searchSchedule.tiles1");

		return mav;
	}//end of public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) 
	
	
	//=== #171. 파일첨부가 있는 댓글쓰기(ajax로 처리) 댓글 보여주기
	@ResponseBody
	@RequestMapping(value ="/downloadComment.groovy")
	public void downloadComment(HttpServletRequest request, HttpServletResponse response ) {
			
		String pk_scheduleno = request.getParameter("pk_scheduleno");//첨부파일이 잇는 글번호
		//filename, orgfilename 가져와야한다.
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null;
		try {
			//out = response.getWriter();
			Integer.parseInt(pk_scheduleno);
			Map<String,String> map = service.detailSchedule(pk_scheduleno);
			//CommentVO commentvo = service.getCommentOne(seq);
			if(map == null || (map != null&& map.get("FILENAME") == null) ) {
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}else {//정상적으로 다운로드를 할경우
				
				String fileName = map.get("FILENAME");
				//System.out.println("fileName"+fileName);
				String orgFilename = map.get("ORGFILENAME");
				//System.out.println("orgFilename"+orgFilename);
				// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
	            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
	            // WAS 의 webapp 의 절대경로를 알아와야 한다.
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				
				//System.out.println("root "+root);
				
				String path = root + "resources"+File.separator+"download";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				운영체제가 Windows 이라면 File.separator 는  "\" 이고,
				운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
				*/
				
				//path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				//System.out.println("path "+path);
				
				//file 다운로드 하기
				boolean flag = false;//file 다운로드 성공, 실패를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				
				if(!flag) {
					out = response.getWriter();
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패했습니다.'); history.back();</script>");
					return;
				}
				
			}
		}catch (NumberFormatException | IOException e) {
			e.printStackTrace();
				try {
					out = response.getWriter();
					out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			return;
		}
		
	}//end of public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) 	

	@ResponseBody
	@RequestMapping(value ="/voteYesAdd.groovy", method = {RequestMethod.POST})
	public String voteYesAdd(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);

		int n = 0;
		try {
			n = service.voteYesAdd(paraMap);
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String voteYesAdd(HttpServletRequest request)
		
	@ResponseBody
	@RequestMapping(value ="/voteNoAdd.groovy", method = {RequestMethod.POST})
	public String voteNoAdd(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		int n =0;
		try {
			n = service.voteNoAdd(paraMap);
		} catch (Throwable e) {
	
			//e.printStackTrace();
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String voteNoAdd(HttpServletRequest request)

	@ResponseBody
	@RequestMapping(value ="/voteUndefinedAdd.groovy", method = {RequestMethod.POST})
	public String voteUndefinedAdd(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		
		int n =0;
		try {
			n = service.voteUndefinedAdd(paraMap);
		} catch (Throwable e) {
	
			//e.printStackTrace();
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}//end of public String voteUndefinedAdd(HttpServletRequest request) 

	@ResponseBody
	@RequestMapping(value ="/voteTotalLoginCnt.groovy", method = {RequestMethod.GET})
	public String voteTotalLoginCnt(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		Map<String,String> map = service.voteTotalLoginCnt(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("map", map);
			
		return jsObj.toString();
	}//end of public String voteTotalLoginCnt(HttpServletRequest request)

	@ResponseBody
	@RequestMapping(value ="/voteTotalCnt.groovy", method = {RequestMethod.GET})
	public String voteTotalCnt(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		Map<String,String> map = service.voteTotalCnt(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("map", map);
			
		return jsObj.toString();
	}//end of public String voteTotalCnt(HttpServletRequest request)

	@ResponseBody
	@RequestMapping(value ="/voteYesUser.groovy", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String voteYesUser(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		List<Map<String,String>> listMap = service.voteYesUser(paraMap);
		
		JSONArray jsonArr = new JSONArray();
	 	for(Map<String, String> map :listMap) {
	 		JSONObject jsObj = new JSONObject();
			jsObj.put("fk_empnum", map.get("FK_EMPNUM"));
			jsObj.put("name", map.get("NAME"));
			jsonArr.put(jsObj);
	 	}
	
		return jsonArr.toString();
	}//end of public String voteYesUser(HttpServletRequest request)

	@ResponseBody
	@RequestMapping(value ="/voteNoUser.groovy", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String voteNoUser(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		List<Map<String,String>> listMap = service.voteNoUser(paraMap);
		
		JSONArray jsonArr = new JSONArray();
	 	for(Map<String, String> map :listMap) {
	 		JSONObject jsObj = new JSONObject();
			jsObj.put("fk_empnum", map.get("FK_EMPNUM"));
			jsObj.put("name", map.get("NAME"));
			jsonArr.put(jsObj);
	 	}
	
		return jsonArr.toString();
	}//end of public String voteNoUser(HttpServletRequest request) 

	@ResponseBody
	@RequestMapping(value ="/voteUndefinedUser.groovy", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String voteUndefinedUser(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		
		List<Map<String,String>> listMap = service.voteUndefinedUser(paraMap);
		
	 	JSONArray jsonArr = new JSONArray();
	 	for(Map<String, String> map :listMap) {
	 		JSONObject jsObj = new JSONObject();
			jsObj.put("fk_empnum", map.get("FK_EMPNUM"));
			jsObj.put("name", map.get("NAME"));
			jsonArr.put(jsObj);
	 	}
	
		return jsonArr.toString();
		
	}//end of public String voteUndefinedUser(HttpServletRequest request)


	@ResponseBody
	@RequestMapping(value ="/commentAdd.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String commentAdd(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		String name = request.getParameter("name");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		paraMap.put("name", name);
		paraMap.put("content", content);
		
		//댓글쓰기에 첨부파일이 없는 경우
		int n = 0;
		try {
			n = service.commentAdd(paraMap);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
	
	}//end of public String commentAdd(HttpServletRequest request) 

	@ResponseBody
	@RequestMapping(value ="/commentShow.groovy", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String commentShow(HttpServletRequest request) {
		
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		int sizePerPage = 3;
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
		int endRno = startRno + sizePerPage - 1;
		
		Map<String, String> paraMap = new HashMap<String, String>();
		
		paraMap.put("fk_scheduleno", fk_scheduleno);
		paraMap.put("startRno",String.valueOf(startRno));
		paraMap.put("endRno",String.valueOf(endRno));
	

		List<Map<String,String>> listMap = service.commentShow(paraMap);
	
		JSONArray jsonArr = new JSONArray();
	 	for(Map<String, String> map :listMap) {
	 		JSONObject jsObj = new JSONObject();
			jsObj.put("fk_scheduleno", map.get("FK_SCHEDULENO"));
			jsObj.put("fk_empnum", map.get("FK_EMPNUM"));
			jsObj.put("regdate", map.get("REGDATE"));
			jsObj.put("name", map.get("NAME"));
			jsObj.put("content", map.get("CONTENT"));
			jsObj.put("emppicturename", map.get("EMPPICTURENAME"));
			jsObj.put("spotnamekor", map.get("SPOTNAMEKOR"));
			jsObj.put("deptnamekor", map.get("DEPTNAMEKOR"));
			jsObj.put("commentseq", map.get("COMMENTSEQ"));
			
			
			jsonArr.put(jsObj);
	 	}
	
		return jsonArr.toString();
	
	}//end of public String commentShow(HttpServletRequest request)

	// === #132.  원게시물에 딸린 댓글 totalPage 알아오기(ajax로 처리)
	@ResponseBody
	@RequestMapping(value ="/getCommentTotalPage.groovy", method = {RequestMethod.GET})
	public String getCommentTotalPage(HttpServletRequest request) {
			
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		String sizePerPage = request.getParameter("sizePerPage");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_scheduleno", fk_scheduleno);
		paraMap.put("sizePerPage",sizePerPage);
	
		int totalPage = service.getCommentTotalPage(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage",totalPage);
		
	
		return jsonObj.toString();
		
	}//end of public String getCommentTotalPage(HttpServletRequest request)


	@ResponseBody
	@RequestMapping(value ="/commentEdit.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String commentEdit(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		String commentseq = request.getParameter("commentseq");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		paraMap.put("commentseq", commentseq);
		paraMap.put("content", content);
		
		
		int n = 0;
		try {
			n = service.commentEdit(paraMap);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
	
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
	
	}//end of public String commentEdit(HttpServletRequest request)

	@ResponseBody
	@RequestMapping(value ="/commentDel.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String commentDel(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String fk_scheduleno = request.getParameter("fk_scheduleno");
		String commentseq = request.getParameter("commentseq");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("fk_scheduleno", fk_scheduleno);
		paraMap.put("commentseq", commentseq);
		
		
		int n = 0;
		try {
			n = service.commentDel(paraMap);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
	
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
	
	}//end of public String commentDel(HttpServletRequest request)


	@ResponseBody
	@RequestMapping(value ="/scheduleDel.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String scheduleDel(HttpServletRequest request) {
		String fk_empnum = request.getParameter("fk_empnum");
		String pk_scheduleno = request.getParameter("pk_scheduleno");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("fk_empnum", fk_empnum);
		paraMap.put("pk_scheduleno", pk_scheduleno);
		
	
		int n = 0;
		try {
			n = service.scheduleDel(paraMap);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
	
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"

	}//end of public String scheduleDel(HttpServletRequest request)
	
	@ResponseBody
	@RequestMapping(value="/scheduleEdit.groovy", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String scheduleEdit(HttpServletRequest request) {
		
		String pk_scheduleno = request.getParameter("pk_scheduleno");
		JSONObject jsonObj = new JSONObject();//
		try {
			Integer.parseInt(pk_scheduleno);
			Map<String,String> map = service.detailSchedule(pk_scheduleno);
			
			
			
			jsonObj.put("map", map);//{"n":1}
			return jsonObj.toString();//"{"n":1}"
			
		} catch (NumberFormatException e) {
			jsonObj.put("message", "실패");
				return jsonObj.toString();
		}
			
	}//end of 	public String scheduleEdit(HttpServletRequest request)
	


	// === 일정 수정하기 ===
	@ResponseBody
	@RequestMapping(value ="/goEditSchedule_withAttach", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String goEditSchedule_withAttach(Calendar_schedule_VO scheduleVO, MultipartHttpServletRequest mrequest ) {
	//public String registerSchedule_end(Calendar_schedule_VO scheduleVO, HttpServletRequest mrequest ) {
		
		MultipartFile attach= scheduleVO.getAttach();
		String vote = scheduleVO.getVote();
		
		if(scheduleVO.getVote() == null) {
			scheduleVO.setVote("0");
		}
		
		String Joinuser = scheduleVO.getJoinuser();
		if(!attach.isEmpty()) {//존재하는지 여부 파일첨부파일게시물 확인
			/*
	        1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	        >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                   우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                   조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다. 
	        //was webapp의 절대경로를 알아야한다.                           
	        */
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			//System.out.println("root "+root);
			
			String path = root + "resources"+File.separator+"download";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			*/
			
			//path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//System.out.println("path "+path);
			
			//2. 파일첨부를 위한 변수의 설정및 값을 초기화 한후 파일 올리기
			
			String newFileName = "";//WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;//첨부파일의 내용물 담는것
			
			long fileSize = 0;//첨부파일의 크기
			
			try {
				bytes = attach.getBytes();//첨부파일의 내용물 읽어온다.
				
				String originalFilename = attach.getOriginalFilename();
				//getOriginalFilename 첨부파일의 파일명(예: 강아지.png);
				//System.out.println("originalFilename "+originalFilename);
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				//첨부된 파일을 업로드 하도록 하는 것이다.
				//System.out.println("newFileName "+newFileName);
				
				//2. boardvo에 fileName 값과 originalFilename, fileSize값 넣어주기
				
				scheduleVO.setFileName(newFileName);//WAS(톰캣)의 디스크에 저장될 파일명
				scheduleVO.setOrgFilename(originalFilename);
				//게시판 페이지에서 첨부된파일(강아지,png)을 보여줄때 사용
				//또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용
				fileSize = attach.getSize();//첨부파일의 크기(단위 바이트)
				scheduleVO.setFileSize(String.valueOf(fileSize));
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		int n = 0;
		try {
			n = service.editSchedule_end(scheduleVO);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
		// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	    // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.) 
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
		
	}//end of public String goEditSchedule_withAttach(Calendar_schedule_VO scheduleVO, MultipartHttpServletRequest mrequest )



	// === 일정 수정하기 ===
	@ResponseBody
	@RequestMapping(value ="/goEditSchedule_noAttach.groovy", method = {RequestMethod.POST},  produces="text/plain;charset=UTF-8")
	public String goEditSchedule_noAttach(Calendar_schedule_VO scheduleVO, HttpServletRequest request ) {
		
		if(scheduleVO.getVote() == null) {
			scheduleVO.setVote("0");
		}
		int n = 0;
		
		try {
			n = service.editSchedule_end(scheduleVO);
		} catch (Throwable e) {
			//e.printStackTrace();
		}
	
		// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	    // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.) 
		JSONObject jsonObj = new JSONObject();//
		
		jsonObj.put("n", n);//{"n":1}
		return jsonObj.toString();//"{"n":1}"
		
	}//end of public String goEditSchedule_noAttach(Calendar_schedule_VO scheduleVO, HttpServletRequest request ) 

	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@RequestMapping(value="/selectVacationlist.groovy", produces="text/plain;charset=UTF-8")
	public String selectVacationlist(HttpServletRequest request) {
			
		List<Map<String,String>> listMap = service.selectVacationlist();
		
		JSONArray jsArr = new JSONArray();
		
		if(listMap != null && listMap.size() > 0) {
			
			for(Map<String, String> map :listMap) {
		 		JSONObject jsObj = new JSONObject();
				jsObj.put("pk_documentnum", map.get("PK_DOCUMENTNUM"));
				jsObj.put("vstartdate", map.get("VSTARTDATE"));
				jsObj.put("venddate", map.get("VENDDATE"));
				jsObj.put("vinfo", map.get("VINFO"));
				jsObj.put("pk_empnum", map.get("PK_EMPNUM"));
				jsObj.put("name", map.get("NAME"));
				jsObj.put("vtype", map.get("VTYPE"));
				jsObj.put("spotnamekor", map.get("SPOTNAMEKOR"));
				jsObj.put("deptnamekor", map.get("DEPTNAMEKOR"));
				
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
		
	}//end of public String selectVacationlist(HttpServletRequest request)
		
}//end of public class KimyjController