package com.spring.groovy.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Sha256;
import com.spring.groovy.common.FileManager;
import com.spring.groovy.model.BoardVO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.groovy.annotation.NoLogging;
import com.spring.groovy.common.AES256;
import com.spring.groovy.common.GoogleMail;
import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.*;
import com.spring.groovy.service.*;

@Controller //bean + controller
public class LeejhController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterLeejhService service;
	@Autowired
	private AES256 aes;
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	//  << 로그인 폼요청 >>
	@NoLogging
	@RequestMapping(value="/login.groovy", method= {RequestMethod.GET})
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("login/loginform.tiles2");
		
		return mav;
	}
	
	//  << 로그인 처리하기 >>
	@NoLogging
	@RequestMapping(value="/loginEnd.groovy", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String pk_empnum = request.getParameter("pk_empnum");
		
		pk_empnum = pk_empnum.trim();
		
		String pwd = request.getParameter("pwd");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum",pk_empnum);
		paraMap.put("pwd",Sha256.encrypt(pwd));
	//	System.out.println("확인 pk_empnum:"+pk_empnum);
	//	System.out.println("확인 pwd:"+pwd);
		
		EmployeeVO loginuser = service.getLoginEmployee(paraMap);
		//EmployeeVO loginuser - com.spring.groovy.controller.LeejhController.loginEnd(ModelAndView, HttpServletRequest)
	//	System.out.println("확인 loginuser:"+loginuser);
		
		if(loginuser == null) { //로그인 실패시
			String message = "사원번호 또는 비밀번호가 잘못되었습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		else { // 아이디와 암호가 존재하는 경우
			
			if(loginuser.getResignationstatus() == 1 ) { //퇴사자 정보로 로그인  퇴사자는 1값
				String message = "이미 퇴사한 사원입니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			else {
				HttpSession session =  request.getSession();
				//메모리에 생성되어져 있는 session 을 불러오는 것이다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				
				/*
				int count = service.getLoginHistory(pk_empnum);
				
				if(count == 1) {
					//첫 로그인인 경우
					mav.setViewName("redirect:/pwdChange.groovy");
				}
				else {*/
				
					if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
						
						String message = "비밀번호를 변경하신지 3개월이 지났습니다.\n암호를 변경하시는 것을 추천합니다";
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
						/*
						//조직도 불러오기
						List<EmployeeVO> empList = service.empList();
						//부서 불러오기
						List<String> deptList = service.deptList();
						
						mav.addObject("empList", empList);
						mav.addObject("deptList", deptList);
						*/
						String goBackURL = (String) session.getAttribute("goBackURL");
						
						if(goBackURL != null) {
							mav.setViewName("redirect:"+goBackURL);
							session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다. 
						}
						else { 
							mav.setViewName("redirect:/index.groovy"); // 시작페이지로 이동
						}
						
					}
			
			}
			
		
		}//end of else
		
		return mav;
	}
	
	
	// ===  로그아웃 처리하기 === //
	@NoLogging
	@RequestMapping(value="/logout.groovy")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
	
		// 로그아웃 시 시작페이지로 돌아가는 것임//
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/login.groovy";
				
		mav.addObject("message",message);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		// /WEB-INF/views/msg.jsp
		
		
		return mav;
	
	}

	
	// === 비밀번호 찾기 화면 메서드 === //
	@RequestMapping(value = "findpwd.groovy")
	public ModelAndView findpwd(ModelAndView mav) {
		mav.setViewName("login/findpwd.tiles2");
		return mav;
	}
	
	// === 비밀번호 찾기 인증번호 발송 메서드 === //
	@ResponseBody
	@RequestMapping(value = "/sendCodeEmail.groovy", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public String sendCodeEmail(HttpServletRequest request) {
		String email = request.getParameter("email");
		String pk_empnum = request.getParameter("pk_empnum");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("email", email);
		paraMap.put("pk_empnum", pk_empnum);
		
		// === 해당하는 이메일과 사원번호에 존재하는 사원 정보 찾기(select) === //
		boolean isExists = service.sendCodeEmail(paraMap);
		
		boolean sendEmail = false;
		
		if(isExists) {
			// 회원으로 존재하는 경우
			
			// 인증키를 랜덤하게 생성하도록 한다.
			Random rnd = new Random();
			
			String certificationCode = "";
			// 인증키는 영문소문자 5글자 + 숫자 7글자 로 만들겠습니다.
			// 예: certificationCode = awkfk7274003
			
			char randchar = ' ';
			for(int i=0; i < 5; i++) {
			/*
			    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
			    int rndnum = rnd.nextInt(max - min + 1) + min;
			       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
			 */		
				
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
			
			}
			
			int randnum = 0;
			for(int i=0; i < 5; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				certificationCode += randnum;
			}
			
			// 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
			GoogleMail mail = new GoogleMail();
			
			try {
				mail.sendmail(email, certificationCode);
				sendEmail = true; // 메일 전송 성공했음을 기록함.
				
				// 세션불러오기
				HttpSession session = request.getSession();
				session.setAttribute("certificationCode", certificationCode);
				// 발급한 인증코드를 세션에 저장시킴.
				
			} catch(Exception e) { // 메일 전송이 실패한 경우
				e.printStackTrace();
				sendEmail = false; // 메일 전송 실패했음을 기록함.
			}
		}

		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("sendEmail", sendEmail);
		
		String json = jsonObj.toString();
		
		return json;
	}
	
	// === 인증번호 체크 메서드 === ///
	@ResponseBody
	@RequestMapping(value = "/checkCode.groovy", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public String checkCode(HttpServletRequest request) {
		// 입력한 인증번호 값 가져오기
		String codeNo = request.getParameter("codeNo");
		
		// 세션불러오기
		HttpSession session = request.getSession();
		String certificationCode = (String)session.getAttribute("certificationCode");
		
		String message = "";
		boolean isSuccess = false;
		
		if(certificationCode.equals(codeNo)) {
			message = "인증 성공되었습니다.";
			isSuccess = true;
		}
		else {
			message = "인증코드가 일치하지 않습니다. 다시 시도하세요.";
			isSuccess = false;
		}
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("message", message);
		jsonObj.put("isSuccess", isSuccess);
		
		String json = jsonObj.toString();
		
		return json;
	}
	
	
	// === 새비밀번호 업데이트 메서드(update) === //
	@ResponseBody
	@RequestMapping(value = "/newPwdUpdate.groovy", method = {RequestMethod.POST})
	public String newPasswordUpdate(HttpServletRequest request) {
		String email = request.getParameter("email");
		String pk_empnum = request.getParameter("pk_empnum");
		String newPassword = request.getParameter("newPassword");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("email", email);
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("newPassword", Sha256.encrypt(newPassword));
		
		int n = service.newPwdUpdate(paraMap);
		
		boolean isSuccess = false;
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(n == 1) {
			isSuccess = true;
			jsonObj.put("isSuccess", isSuccess);
		}
		else {
			isSuccess = false;
			jsonObj.put("isSuccess", isSuccess);
		}
		
		String json = jsonObj.toString();
		
		return json;
	}
	
	// ===  조직도  === //
	@ResponseBody
	@RequestMapping(value = "/getOrganization.groovy", produces = "text/plain;charset=UTF-8")
	public String getOrganizationTree(HttpServletRequest request, HttpServletResponse response) {
		
		List<EmployeeVO> empList = service.empList();
		List<String> deptList = service.deptList();
		
		/* String test = deptList[0]; */
		JSONArray jsonArr = new JSONArray();
		
		
		
		for(int i=0; i<deptList.size(); i++) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("id", deptList.get(i));
			jsonObj.put("parent", "#");
			jsonObj.put("text", deptList.get(i));
			
			jsonArr.put(jsonObj);// {}   [{},{},{}]
		}
		if(empList != null && empList.size() > 0) {
			
			for(EmployeeVO empvo : empList) {
				JSONObject jsonObj = new JSONObject();
				
				
				jsonObj.put("id", empvo.getPk_empnum());
				jsonObj.put("parent", empvo.getDeptnamekor());
				jsonObj.put("text",empvo.getSpotnamekor() +" " +empvo.getName());
				
				
				
				jsonArr.put(jsonObj);
			}// end of for(EmployeeVO empvo : empList) {}-----------------------
			
		}// end of if(empList != null && empList.size() > 0) {}-----------------------
		
		return jsonArr.toString();
	}// end of public String getOrganizationTree(HttpServletRequest request, HttpServletResponse response) {}
	
	
	// === 부서별 조직도 불러오기 === //
	@ResponseBody
	@RequestMapping(value = "/getDepartment.groovy", produces = "text/plain;charset=UTF-8")
	public String getDepartment(HttpServletRequest request, HttpServletResponse response) {
		
		List<String> deptList = service.deptList();
		
		JSONArray jsonArr = new JSONArray();
		
		if(deptList != null && deptList.size() > 0) {
			
			for(String deptnamekor : deptList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("deptnamekor", deptnamekor);
				
				jsonArr.put(jsonObj);
			}
			
		}// end of if-----------------------
		
		return jsonArr.toString();
	}// end of public String getDepartment(HttpServletRequest request, HttpServletResponse response) {}

	
	// === #71. 회원정보 수정페이지 요청 === //
	@RequestMapping(value="/MyInfoEdit.groovy")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 수정해야할 나 
		String pk_empnum = request.getParameter("pk_empnum");
		List<String> deptList = service.deptList();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		
			// 자신의 글을 수정할 경우
			// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
			mav.addObject("paraMap", paraMap);
			mav.setViewName("board/edit.tiles1"); 
		
		
		return mav;
	}
	
	//로그인한 유저 정보 얻어오기 
	@ResponseBody
	@RequestMapping(value ="/getUserInfo.groovy", produces="text/plain;charset=UTF-8")
	public String getUserInfo(HttpServletRequest request ) {
		
		String pk_empnum = request.getParameter("pk_empnum"); // 한명의 사원 사번 받아옴

		// 한명의 사원 상세정보 가져오기
		EmployeeVO user = service.getUserInfo(pk_empnum);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("pk_empnum", user.getPk_empnum());
		jsonObj.put("name", user.getName());
		jsonObj.put("birthday", user.getBirthday());
		jsonObj.put("gender", user.getGender());
		jsonObj.put("age", user.getAge());

		jsonObj.put("postcode", user.getPostcode());
		jsonObj.put("address", user.getAddress());
		jsonObj.put("detailaddress", user.getDetailaddress());
		
		jsonObj.put("phone", user.getPhone());
		
		try {
			jsonObj.put("email", aes.decrypt(user.getEmail()));
		} catch (JSONException | UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		jsonObj.put("deptnamekor", user.getDeptnamekor());
		jsonObj.put("spotnamekor", user.getSpotnamekor());
		
		jsonObj.put("startday", user.getStartday());
		jsonObj.put("resignationstatus", user.getResignationstatus());
		jsonObj.put("resignationday", user.getResignationday());
		jsonObj.put("fk_vstatus", user.getFk_vstatus());
		jsonObj.put("salary", user.getSalary());
		
		jsonObj.put("emppicturename", user.getEmppicturename());
		return jsonObj.toString();
	}
	
	
	// 연락처 수정
	@ResponseBody
	@RequestMapping(value="/myPhoneEditEnd.groovy")
	public String requiredLogin_myPhoneEditEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String pk_empnum = request.getParameter("pk_empnum");
		String myphone = request.getParameter("myphone");
		System.out.println("myphone:"+myphone);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("myphone", myphone);
		
		int n = service.myPhoneUpdate(paraMap);
		
		boolean isSuccess = false;
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(n == 1) {
			isSuccess = true;
			jsonObj.put("isSuccess", isSuccess);
		}
		else {
			isSuccess = false;
			jsonObj.put("isSuccess", isSuccess);
		}
		
		String json = jsonObj.toString();
		
		return json;
		
	}
	
	
	
	// 이메일 수정
	@ResponseBody
	@RequestMapping(value="/myEmailEditEnd.groovy")
	public String requiredLogin_myEmailEditEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String pk_empnum = request.getParameter("pk_empnum");
		String myemail = request.getParameter("myemail");
		System.out.println("myemail:"+myemail);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("myemail", myemail);
		
		int n = service.myEmailUpdate(paraMap);
		
		boolean isSuccess = false;
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(n == 1) {
			isSuccess = true;
			jsonObj.put("isSuccess", isSuccess);
		}
		else {
			isSuccess = false;
			jsonObj.put("isSuccess", isSuccess);
		}
		
		String json = jsonObj.toString();
		
		return json;
		
	}
	
	// 주소 수정
	@ResponseBody
	@RequestMapping(value="/myAddressEditEnd.groovy")
	public String requiredLogin_myAddressEditEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String pk_empnum = request.getParameter("pk_empnum");
		String mypostcode = request.getParameter("mypostcode");
		String myaddress = request.getParameter("myaddress");
		String mydetailAddress = request.getParameter("mydetailAddress");
		String myextraAddress = request.getParameter("myextraAddress");
		System.out.println("my:"+mypostcode);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("mypostcode", mypostcode);
		paraMap.put("myaddress", myaddress);
		paraMap.put("mydetailAddress", mydetailAddress);
		paraMap.put("myextraAddress", myextraAddress);
		
		int n = service.myAddressUpdate(paraMap);
		
		boolean isSuccess = false;
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(n == 1) {
			isSuccess = true;
			jsonObj.put("isSuccess", isSuccess);
		}
		else {
			isSuccess = false;
			jsonObj.put("isSuccess", isSuccess);
		}
		
		String json = jsonObj.toString();
		
		return json;
		
	}
	
	//비밀번호 수정 myPwdEditEnd.groovy
	@ResponseBody
	@RequestMapping(value="/myPwdEditEnd.groovy")
	public String requiredLogin_myPwdEditEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String pk_empnum = request.getParameter("pk_empnum");
		String originpwd = request.getParameter("originpwd");
		String mypwd = request.getParameter("mypwd");
		System.out.println("my:"+mypwd);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_empnum", pk_empnum);
		paraMap.put("originpwd", Sha256.encrypt(originpwd));
		paraMap.put("mypwd",Sha256.encrypt(mypwd));
		
		int n = service.myPwdUpdate(paraMap);
		
		boolean isSuccess = false;
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(n == 1) {
			isSuccess = true;
			jsonObj.put("isSuccess", isSuccess);
		}
		else {
			isSuccess = false;
			jsonObj.put("isSuccess", isSuccess);
		}
		
		String json = jsonObj.toString();
		
		return json;
		
	}
	
	
	// 사원등록 요청
	@ResponseBody
	@RequestMapping(value="/myphotoEdit.groovy", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView myphotoEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, EmployeeVO empVo,MultipartHttpServletRequest mrequest) {

		MultipartFile attach = empVo.getAttach();
		//if(!attach.isEmpty()) { // attach(첨부파일)이 있다면
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
		
			
			int n = 0;
			
		
				// 파일첨부가 있는 경우라면
				n = service.editFile(empVo);
			
			if(n==1) {
				mav.addObject("message", "사진이 성공적으로 변경되었습니다.");
				mav.addObject("loc", mrequest.getContextPath()+"/index.groovy");
				
				mav.setViewName("msg");
			}
			else {
				mav.addObject("message", "사진 변경에 실패했습니다.");
				mav.addObject("loc", "javascript:history.back()");
				
				mav.setViewName("msg");
			}
			
			return mav;
	}


		
	// === #51. 게시판 글쓰기 폼페이지 요청 === //
		@RequestMapping(value="/add.groovy")
		public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		//	getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// === #142. 답변글쓰기가 추가된 경우 시작 === //
			String fk_seq = request.getParameter("fk_seq");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			String b_subject = "[답변] "+request.getParameter("b_subject");
			/*
			    view.jsp 에서 "답변글쓰기" 를 할때 글제목에 [ 또는 ] 이 들어간 경우 아래와 같은 오류가 발생한다.
			          
			    HTTP 상태 400 – 잘못된 요청
			       메시지 요청 타겟에서 유효하지 않은 문자가 발견되었습니다. 유효한 문자들은 RFC 7230과 RFC 3986에 정의되어 있습니다.
			       
			       해결책은 
			       톰캣의 C:\apache-tomcat-9.0.55\conf\server.xml 에서 
			    <Connector port="9090" URIEncoding="UTF-8" protocol="HTTP/1.1"
	               connectionTimeout="20000"
	               redirectPort="8443" /> 
	                      에 가서
	            <Connector port="9090" URIEncoding="UTF-8" protocol="HTTP/1.1"
	               connectionTimeout="20000"
	               redirectPort="8443"
	               relaxedQueryChars="[]()^|&quot;" />  
	                     
	                      와 같이 relaxedQueryChars="[]()^|&quot;" 을 추가해주면 된다.    
			*/
			
			if(fk_seq == null) {
				fk_seq = "";
			}
			
			mav.addObject("fk_seq", fk_seq);
			mav.addObject("groupno", groupno);
			mav.addObject("depthno", depthno);
			mav.addObject("b_subject", b_subject);
			// === 답변글쓰기가 추가된 경우 끝               === //
			
			mav.setViewName("board/writeBoardModal.tiles2");
			//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		    return mav;
		}

	
	// === #54. 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value="/addEnd.groovy", method= {RequestMethod.POST})
//	public ModelAndView addEnd(ModelAndView mav, BoardVO boardvo) {    <== After Advice 를 사용하기 전  
//	public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo) { // <== After Advice 를 사용하기 
	public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
	/*
	    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
	    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	        자동적으로 BoardVO boardvo 에 set 되어진다.
	*/
		
	/*
		=== #151. 파일첨부가 된 글쓰기 이므로  
		        먼저 위의  public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo) { 을 
		        주석처리 한 이후에 아래와 같이 한다.
		    MultipartHttpServletRequest mrequest 를 사용하기 위해서는 
		        먼저 /Board/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml 에서     
		    #21 파일업로드 및 파일다운로드에 필요한 의존객체 설정하기 를 해두어야 한다.  
		*/
		/*
			   웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
			   컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
			  MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
			   즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.  	
		*/	
		
		// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지, 아니면 파일첨부가 안된것인지 구분을 지어주어야 한다. === 
		// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! ===
		MultipartFile attach = boardvo.getAttach();
		
		if( !attach.isEmpty() ) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
			
			/*
			   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
			   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
			              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
			*/
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
		//	System.out.println("~~~~ 확인용  webapp 의 절대경로 => " + root);
			// ~~~~ 확인용  webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\ 
			
			String path = root+"resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		            운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
		//	System.out.println("~~~~ 확인용  path => " + path);
			// ~~~~ 확인용  path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files  
		
			
		/*
		   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 
		*/
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것 
			
			long fileSize = 0;
			// 첨부파일의 크기 
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
			 // attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
			//	System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
				// ~~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				
			//	System.out.println(">>> 확인용 newFileName => " + newFileName);
				// >>> 확인용 newFileName => 20220429123036877439302653900.pdf
			
		/*
		   3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기 
		*/
				boardvo.setB_filename(newFileName);
				// WAS(톰캣)에 저장될 파일명(2022042912181535243254235235234.png)
				
				boardvo.setB_orgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				boardvo.setB_filesize(String.valueOf(fileSize)) ;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
		
	
	//	int n = service.add(boardvo);  // <== 파일첨부가 없는 글쓰기 
		
	//  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
	//  먼저 위의  int n = service.add(boardvo); 부분을 주석처리 하고서 아래와 같이 한다.	
		
		int n = 0;
		
		if( attach.isEmpty() ) {
			// 파일첨부가 없는 경우라면 
			n = service.add(boardvo);
		}
		else {
			// 파일첨부가 있는 경우라면 
			n = service.add_withFile(boardvo);
		}
		
		if(n==1) {
			mav.setViewName("redirect:/index.groovy");
			//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("board/error/add_error.tiles1");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
		
		
		
	
		return mav;
	}
	
	
	
	// ===  조직도  === //
	/* @ResponseBody */
	@RequestMapping(value = "/orgChart.groovy")
	public ModelAndView orgChart(ModelAndView mav, HttpServletRequest request) {
		
		
		
		mav.setViewName("employee/orgChart.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/orgChart2.groovy", produces = "text/plain;charset=UTF-8")
	public String orgChart(HttpServletRequest request, HttpServletResponse response) {
		
		
		List<Map<String,String>> employeeChartList= service.employeeChart();
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String,String> map : employeeChartList) {
				JsonObject jsonObj = new JsonObject();  //얘도 소문자 ~ 하면 구글슨~
				jsonObj.addProperty("name", 			map.get("name")); //put대신 addProperty
				jsonObj.addProperty("id", 	    map.get("deptnamekor"));
				jsonObj.addProperty("title",	    map.get("spotnamekor"));
				
				/*
				 [{"department_name":"Accounting","cnt":"2","percentage":"1.87"},{"department_name":"Administration","cnt":"1","percentage":".93"},{"department_name":"Executive","cnt":"3","percentage":"2.8"},{"department_name":"Finance","cnt":"6","percentage":"5.61"},{"department_name":"Human Resources","cnt":"1","percentage":".93"},{"department_name":"IT","cnt":"5","percentage":"4.67"},{"department_name":"Marketing","cnt":"2","percentage":"1.87"},{"department_name":"Public Relations","cnt":"1","percentage":".93"},{"department_name":"Purchasing","cnt":"6","percentage":"5.61"},{"department_name":"Sales","cnt":"34","percentage":"31.78"},{"department_name":"Shipping","cnt":"45","percentage":"42.06"},{"department_name":"부서없음","cnt":"1","percentage":".93"}]
				 [{"name":"이국민","deptnamekor":"임원","spotnamekor":"사장"},{"name":"장근석","deptnamekor":"임원","spotnamekor":"이사"},{"name":"권보아","deptnamekor":"임원","spotnamekor":"이사"},{"name":"이승기","deptnamekor":"회계","spotnamekor":"부장"},{"name":"이동욱","deptnamekor":"영업","spotnamekor":"부장"},{"name":"박가희","deptnamekor":"인사","spotnamekor":"부장"},{"name":"배윤정","deptnamekor":"총무","spotnamekor":"부장"},{"name":"이석훈","deptnamekor":"회계","spotnamekor":"차장"},{"name":"신유미","deptnamekor":"영업","spotnamekor":"차장"},{"name":"최영준","deptnamekor":"인사","spotnamekor":"차장"},{"name":"이홍기","deptnamekor":"총무","spotnamekor":"차장"},{"name":"권재승","deptnamekor":"회계","spotnamekor":"과장"},{"name":"김태연","deptnamekor":"회계","spotnamekor":"과장"},{"name":"이순규","deptnamekor":"영업","spotnamekor":"과장"},{"name":"김제아","deptnamekor":"영업","spotnamekor":"과장"},{"name":"티파니","deptnamekor":"인사","spotnamekor":"과장"},{"name":"김치타","deptnamekor":"인사","spotnamekor":"과장"},{"name":"강소유","deptnamekor":"총무","spotnamekor":"과장"},{"name":"김효연","deptnamekor":"총무","spotnamekor":"과장"},{"name":"김석진","deptnamekor":"회계","spotnamekor":"대리"},{"name":"권유리","deptnamekor":"회계","spotnamekor":"대리"},{"name":"박지민","deptnamekor":"회계","spotnamekor":"대리"},{"name":"민윤기","deptnamekor":"영업","spotnamekor":"대리"},{"name":"유혜림","deptnamekor":"영업","spotnamekor":"대리"},{"name":"최수영","deptnamekor":"영업","spotnamekor":"대리"},{"name":"김태형","deptnamekor":"영업","spotnamekor":"대리"},{"name":"임윤아","deptnamekor":"인사","spotnamekor":"대리"},{"name":"전정국","deptnamekor":"인사","spotnamekor":"대리"},{"name":"정호석","deptnamekor":"인사","spotnamekor":"대리"},{"name":"김남준","deptnamekor":"총무","spotnamekor":"대리"},{"name":"임나영","deptnamekor":"총무","spotnamekor":"대리"},{"name":"서주현","deptnamekor":"총무","spotnamekor":"대리"},{"name":"김도연","deptnamekor":"회계","spotnamekor":"사원"},{"name":"김청하","deptnamekor":"회계","spotnamekor":"사원"},{"name":"혜림유","deptnamekor":"회계","spotnamekor":"사원"},{"name":"이재희","deptnamekor":"회계","spotnamekor":"사원"},{"name":"김소혜","deptnamekor":"회계","spotnamekor":"사원"},{"name":"황민현","deptnamekor":"회계","spotnamekor":"사원"},{"name":"유연정","deptnamekor":"영업","spotnamekor":"사원"},{"name":"전소미","deptnamekor":"영업","spotnamekor":"사원"},{"name":"옹성우","deptnamekor":"영업","spotnamekor":"사원"},{"name":"김세정","deptnamekor":"영업","spotnamekor":"사원"},{"name":"김재환","deptnamekor":"인사","spotnamekor":"사원"},{"name":"윤지성","deptnamekor":"인사","spotnamekor":"사원"},{"name":"정채연","deptnamekor":"인사","spotnamekor":"사원"},{"name":"최유정","deptnamekor":"인사","spotnamekor":"사원"},{"name":"강다니엘","deptnamekor":"총무","spotnamekor":"사원"},{"name":"하성운","deptnamekor":"총무","spotnamekor":"사원"},{"name":"강미나","deptnamekor":"총무","spotnamekor":"사원"},{"name":"주결경","deptnamekor":"총무","spotnamekor":"사원"},{"name":"관리자","deptnamekor":"회계","spotnamekor":"인턴"},{"name":"박지훈","deptnamekor":"회계","spotnamekor":"인턴"},{"name":"박우진","deptnamekor":"영업","spotnamekor":"인턴"},{"name":"배진영","deptnamekor":"인사","spotnamekor":"인턴"},{"name":"이대휘","deptnamekor":"총무","spotnamekor":"인턴"},{"name":"라이관린","deptnamekor":"총무","spotnamekor":"인턴"},{"name":"한관리","deptnamekor":"인사","spotnamekor":"관리자"}] 
				 */
				
				
				jsonArr.add(jsonObj); //put 대신 add
		}//end of for-----------------------
			
		//return gson.toJson(jsonArr); // jsonArr.toString  대신 toJson   위에서 Gson gson = new Gson(); 써줘야 함.
		return new Gson().toJson(jsonArr); 
		
		
		

	}// end of public String getOrganizationTree(HttpServletRequest request, HttpServletResponse response) {}
	
	
	
	
		
		
		// === #90. 메인화면 글 조회해오기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/readBoard.groovy", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String readComment(HttpServletRequest request) {
		
		//	String pk_board_seq = request.getParameter("pk_board_seq");
			
			List<BoardVO> boardList = service.getBoardList();
			
			JSONArray jsonArr = new JSONArray();  // []
			
			if( boardList != null ) {
				for(BoardVO boardvo : boardList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("name", boardvo.getName());
					jsonObj.put("pk_board_seq", boardvo.getPk_board_seq());
					jsonObj.put("b_content", boardvo.getB_content());
					jsonObj.put("b_regDate", boardvo.getB_regdate());
					jsonObj.put("fk_empnum", boardvo.getFk_empnum());
					jsonObj.put("b_subject", boardvo.getB_subject());
					jsonObj.put("b_content", boardvo.getB_content());

					jsonObj.put("b_readcount", boardvo.getB_readcount());
					jsonObj.put("b_regdate", boardvo.getB_regdate());
					jsonObj.put("b_pw", boardvo.getB_pw());
						
				 	jsonObj.put("b_filename", boardvo.getB_filename());
				 	jsonObj.put("b_orgfilename", boardvo.getB_orgfilename());
				 	jsonObj.put("b_filesize", boardvo.getB_filesize());
				 	jsonObj.put("emppicturename", boardvo.getEmppicturename());
				 	jsonObj.put("deptnamekor", boardvo.getDeptnamekor());
				 	jsonObj.put("spotnamekor", boardvo.getSpotnamekor());
					jsonArr.put(jsonObj);
				}// end of for---------------------
			}
			
			return jsonArr.toString();
		}
		
		
		// === #51. 게시판 글 수정 모달요청 === //
		@RequestMapping(value="/editBoard.groovy")
		public ModelAndView editBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
			String pk_board_seq = request.getParameter("pk_board_seq");
			
			mav.setViewName("board/editBoardModal.tiles2");
			//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		    return mav;
		}
		
		
	

		//글삭제
		@ResponseBody
		@RequestMapping(value="/delBoard.groovy")
		public String delBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
			//String fk_empnum = request.getParameter("fk_empnum");
			//System.out.println("fk_empnum:"+fk_empnum);
			String pk_board_seq = request.getParameter("pk_board_seq");
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_board_seq", pk_board_seq);
			
			int n = service.del(paraMap);
			
			boolean isSuccess = false;
			JSONObject jsonObj = new JSONObject(); // {}
			
			if(n == 1) {
				isSuccess = true;
				jsonObj.put("isSuccess", isSuccess);
			}
			else {
				isSuccess = false;
				jsonObj.put("isSuccess", isSuccess);
			}
			
			String json = jsonObj.toString();
			
			return json;
			
		}
		
		
		
		
		
		// ===  댓글쓰기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/addComment.groovy", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String addComment(CommentVO commentvo) {
			// 댓글쓰기에 첨부파일이 없는 경우 
			
			int n = 0;
			
			try {
				n = service.addComment(commentvo);
			} catch (Throwable e) {
				e.printStackTrace();
			}
			// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
			// 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)  
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			//jsonObj.put("cmt_name", commentvo.getCmt_name());
			
			return jsonObj.toString();  // "{"n":1,"name":"엄정화"}" 또는 "{"n":0,"name":"서영학"}"
		}
		
		
		/*
		// === #128. 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/commentList.groovy", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String commentList(HttpServletRequest request) {
			
			String fk_board_seq = request.getParameter("fk_board_seq");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			int sizePerPage = 5;  // 한 페이지당 5개의 댓글을 보여줄 것임.
			/*
			    currentShowPageNo      startRno     endRno
			   --------------------------------------------
			       1page        ==>       1           5
			       2page        ==>       6           10
			       3page        ==>       11          15
			       4page        ==>       16          20
			       ....  
			 */
		/*
			int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
			int endRno = startRno + sizePerPage - 1;
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_board_seq", fk_board_seq);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			List<CommentVO> commentList = service.getCommentListPaging(paraMap);
			
			JSONArray jsonArr = new JSONArray(); // []
			
			if(commentList != null) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("cmt_content", cmtvo.getCmt_content());
					jsonObj.put("cmt_name", cmtvo.getCmt_name());
					jsonObj.put("cmt_regDate", cmtvo.getCmt_regDate());
					
					// == 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 시작 == //
					jsonObj.put("pk_cmt_seq", cmtvo.getPk_cmt_seq());
					jsonObj.put("cmt_fileName", cmtvo.getCmt_fileName());
					jsonObj.put("cmt_orgFilename", cmtvo.getCmt_orgFilename());
					jsonObj.put("cmt_fileSize", cmtvo.getCmt_fileSize());
					// == 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 끝 == //
					
					jsonArr.put(jsonObj);
				}// end of for------------------
			}
			
			return jsonArr.toString();
		}
		
		*/
		
		/*
		// 연락처 수정
		@ResponseBody
		@RequestMapping(value="/editBoardEnd.groovy")
		public String editBoardEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
			String pk_empnum = request.getParameter("pk_empnum");
			String myphone = request.getParameter("myphone");
			System.out.println("myphone:"+myphone);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_empnum", pk_empnum);
			paraMap.put("myphone", myphone);
			
			int n = service.myPhoneUpdate(paraMap);
			
			boolean isSuccess = false;
			JSONObject jsonObj = new JSONObject(); // {}
			
			if(n == 1) {
				isSuccess = true;
				jsonObj.put("isSuccess", isSuccess);
			}
			else {
				isSuccess = false;
				jsonObj.put("isSuccess", isSuccess);
			}
			
			String json = jsonObj.toString();
			
			return json;
			
		}*/
		
		
		// === #54. 게시판 수정 완료 요청 === //
		@RequestMapping(value="/editBoardEnd.groovy", method= {RequestMethod.POST})
		public ModelAndView editBoardEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
		
			
			String pk_board_seq = mrequest.getParameter("pk_board_seq");
			String b_subject = mrequest.getParameter("b_subject");
			String b_content = mrequest.getParameter("b_content");
			
			//Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("pk_board_seq", pk_board_seq);
			paraMap.put("b_subject", b_subject);
			paraMap.put("b_content", b_content);
			
			
			/*
		    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
		    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
		        자동적으로 BoardVO boardvo 에 set 되어진다.
		*/
			
		/*
			=== #151. 파일첨부가 된 글쓰기 이므로  
			        먼저 위의  public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo) { 을 
			        주석처리 한 이후에 아래와 같이 한다.
			    MultipartHttpServletRequest mrequest 를 사용하기 위해서는 
			        먼저 /Board/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml 에서     
			    #21 파일업로드 및 파일다운로드에 필요한 의존객체 설정하기 를 해두어야 한다.  
			*/
			/*
				   웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
				   컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
				  MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
				   즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.  	
			*/	
			
			// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지, 아니면 파일첨부가 안된것인지 구분을 지어주어야 한다. === 
			// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! ===
			MultipartFile attach = boardvo.getAttach();
			
			if( !attach.isEmpty() ) {
				// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
				
				/*
				   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
				   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
				              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
				              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
				*/
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				
			//	System.out.println("~~~~ 확인용  webapp 의 절대경로 => " + root);
				// ~~~~ 확인용  webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\ 
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//	System.out.println("~~~~ 확인용  path => " + path);
				// ~~~~ 확인용  path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files  
			
				
			/*
			   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 
			*/
				String newFileName = "";
				// WAS(톰캣)의 디스크에 저장될 파일명 
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것 
				
				long fileSize = 0;
				// 첨부파일의 크기 
				
				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					
					String originalFilename = attach.getOriginalFilename();
				 // attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				//	System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
					// ~~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
					
				//	System.out.println(">>> 확인용 newFileName => " + newFileName);
					// >>> 확인용 newFileName => 20220429123036877439302653900.pdf
				
			/*
			   3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기 
			*/
					paraMap.put("newFileName", newFileName);
					// WAS(톰캣)에 저장될 파일명(2022042912181535243254235235234.png)
					
					paraMap.put("originalFilename", originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
					// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					paraMap.put("fileSize", String.valueOf(fileSize));
					
					
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
			
		
		//	int n = service.add(boardvo);  // <== 파일첨부가 없는 글쓰기 
			
		//  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
		//  먼저 위의  int n = service.add(boardvo); 부분을 주석처리 하고서 아래와 같이 한다.	
			
			int n = 0;
			System.out.println(pk_board_seq);
			
			if( attach.isEmpty() ) {
				// 파일첨부가 없는 경우라면 
				n = service.edit_board(paraMap);
			}
			else {
				// 파일첨부가 있는 경우라면 
				n = service.edit_board_withFile(paraMap);
			}
			
			if(n==1) {
				mav.addObject("message", "글 수정 성공!!");
				mav.addObject("loc",mrequest.getContextPath()+"/index.groovy");
				//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
			}
			else {
				mav.addObject("message", "글 수정 실패!!");
				mav.addObject("loc", "javascript:history.back()");
				
				//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
			}
			
			mav.setViewName("msg");
			
			return mav;
			
			
		
		}
	
}//end of public class LeejhController