package com.spring.groovy.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Sha256;
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
	
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	//  << 로그인 폼요청 >>
	@RequestMapping(value="/login.groovy", method= {RequestMethod.GET})
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
						mav.setViewName("redirect:/index.groovy"); //시작페이지로 이동
						
					}
			
			}
			
		
		}//end of else
		
		return mav;
	}
	
	
	// ===  로그아웃 처리하기 === //
	
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
	
	
}//end of public class LeejhController