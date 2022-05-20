package com.spring.groovy.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.MyUtil;
import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.service.InterLimshService;

@Controller //bean + controller
public class LimshController {
	
	@Autowired //Type에 따라 알아서 Bean을 주입해준다.
	private InterLimshService service;
	
	//=== 로그인 또는 로그아웃을 했을때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session= request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));	
	}//end of public void getCurrentURL(HttpServletRequest request)
	
	////////////////////////////////////////////////////////////////////////
	
	// 인덱스 페이지 요청하기
	@RequestMapping(value="/index.groovy")
	public ModelAndView showIndex(ModelAndView mav, HttpServletRequest request) {
		
		List<EmployeeVO> empvoList = service.showEmployeeList();
		mav.addObject("empvoList", empvoList);
		
		List<DepartmentVO> deptvoList = service.getDeptvoList();
		mav.addObject("deptvoList", deptvoList);
		
		mav.setViewName("index.tiles1");
		
		return mav;
	}
	
	// 프로젝트 참여자 목록 보여주기
	@RequestMapping(value="/showEmployeeList.groovy")
	public ModelAndView showEmployeeList(ModelAndView mav, HttpServletRequest request) {
		
		List<EmployeeVO> empvoList = service.showEmployeeList();
		
		request.setAttribute("empvoList", empvoList);
		
		mav.setViewName("employee/showEmployeeList.tiles2");
		
		return mav;
	}
	
	// 검색한 프로젝트 참여자 목록 보여주기
	@ResponseBody
	@RequestMapping(value="/searchEmp.groovy", method={RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String searchEmp(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
	//	System.out.println("확인용 searchType, searchWord => " + searchType + ", " + searchWord);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<EmployeeVO> empvoList = service.searchEmp(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(empvoList != null) {
			for(EmployeeVO empvo : empvoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_empnum", empvo.getPk_empnum());
				jsonObj.put("name", empvo.getName());
				jsonObj.put("phone", empvo.getPhone());
				jsonObj.put("email", empvo.getEmail());
				jsonObj.put("emppicturename", empvo.getEmppicturename());
				jsonObj.put("emppicturefilename", empvo.getEmppicturefilename());
				jsonObj.put("spotnamekor", empvo.getSpotnamekor());
				jsonObj.put("deptnamekor", empvo.getDeptnamekor());
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// 사용자 프로필 보여주기(ajax) : 사진, 이름, 이메일, 전화번호
	@ResponseBody
	@RequestMapping(value="/showEmpProfile.groovy", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String showEmpProfile(HttpServletRequest request) {
		
		String pk_empnum = request.getParameter("pk_empnum");
		
		EmployeeVO empvo = service.showEmpProfile(pk_empnum);
		
		JSONObject jsonObj = new JSONObject();
		if(empvo != null) {
			jsonObj.put("name", empvo.getName());
			jsonObj.put("email", empvo.getEmail());
			jsonObj.put("phone", empvo.getPhone());
			jsonObj.put("emppicturename", empvo.getEmppicturename());
			jsonObj.put("emppicturefilename", empvo.getEmppicturefilename());
			
		//	System.out.println("email, phone => " + empvo.getEmail() + ", " + empvo.getPhone());
		}
		
		return jsonObj.toString();
	}
	
	
	// 직원 번호로 직원명 알아오기(Ajax)
	@ResponseBody
	@RequestMapping(value="/openPersonalChat.groovy", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String openPersonalChat(HttpServletRequest request) {
		
		String pk_empnum = request.getParameter("pk_empnum");
		
		EmployeeVO empvo = service.showEmpProfile(pk_empnum);
		
		JSONObject jsonObj = new JSONObject();
		if(empvo != null) {
			jsonObj.put("name", empvo.getName());
		}
		
		return jsonObj.toString();
	}
	
	
	// 개인 채팅 열기(popup)
	@RequestMapping(value="/openPersonalChatEnd.groovy", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public ModelAndView openPersonalChatEnd(HttpServletRequest request, ModelAndView mav) {
		
		List<EmployeeVO> empvoList = new ArrayList<>();
		
		// 상대 직원 정보 알아오기
		String name = request.getParameter("name");
		EmployeeVO empvo = service.getEmp(name);
		
		// 로그인 중인 직원 정보 알아오기
		
		
		mav.addObject("empvo", empvo);
		
		mav.setViewName("board/openChat.tiles2");
		
		return mav;
	}
	
	
	// 부서별 직원 목록 보여주기(ajax)
	@ResponseBody
	@RequestMapping(value="/showEmpByDept.groovy", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String showEmpByDept(HttpServletRequest request) {
		
		String pk_deptnum = request.getParameter("pk_deptnum");
		
		List<EmployeeVO> empvoListByDept = service.getEmpListByDept(pk_deptnum);
		
		JSONArray jsonArr = new JSONArray();
		
		if(empvoListByDept != null) {
			for(EmployeeVO empvo : empvoListByDept) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_empnum", empvo.getPk_empnum());
				jsonObj.put("name", empvo.getName());
				jsonObj.put("phone", empvo.getPhone());
				jsonObj.put("email", empvo.getEmail());
				jsonObj.put("emppicturename", empvo.getEmppicturename());
				jsonObj.put("emppicturefilename", empvo.getEmppicturefilename());
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// 새 채팅 팝업창 띄우기(초대할 직원 목록 보여주기)
	@RequestMapping(value="/openNewChat.groovy")
	public ModelAndView openNewChat(ModelAndView mav, HttpServletRequest request) {
		
		List<EmployeeVO> empvoList = service.showEmployeeList();

		mav.addObject("empvoList", empvoList);
		
		mav.setViewName("board/openNewChat.tiles2");
		
		return mav;
	}
	
	
	// 그룹채팅 띄우기
	@RequestMapping(value="/chatting/multichat.groovy", method={RequestMethod.GET})
   	public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {
   		
		System.out.println("1번");
		
   		return "chatting/multichat.tiles2";
   	}
/*	
	@RequestMapping(value="/writeBoardModal.groovy")
	public ModelAndView writeBoardModal(ModelAndView mav) {
		
		mav.setViewName("board/writeBoardModal.tiles2");
		
		return mav;
	}
*/
	
}//end of public class LimshController