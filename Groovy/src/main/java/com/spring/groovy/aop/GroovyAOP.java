package com.spring.groovy.aop;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;

import com.spring.groovy.common.MyUtil;



// === #53. 공통관심사 클래스(Aspect 클래스) 생성하기
//AOP(aspect oriented programming)
@Aspect //공통관심사 클래스(Aspect 클래스)로 등록
@Component
public class GroovyAOP {
	// ===== Before Advice(보조업무) 만들기 ====== // 
	/*
	주업무(<예: 글쓰기, 글수정, 댓글쓰기 직원목록조회 등등>)를 실행하기 앞서서  
	이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
	주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
	관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	동작하도록 만들겠다.
	*/  
	
	// === Pointcut(주업무)를 설정해야 한다.
	// Pointcut 이란 공통 관심사를 필요로 하는 메소드를 말한다.
	
	//&& !@annotation(com.spring.groovy.annotation.NoLogging)
	@Pointcut("execution(public * com.spring..*Controller.*(..)) && !@annotation(com.spring.groovy.annotation.NoLogging)")
	public void requiredLogin() {}
	
	// ===== Before Advice(공통관심사, 보조업무) 만들기 ====== // 
	@Before("requiredLogin()")//@After @Around
	public void loginCheck(JoinPoint joinpoint) {//로그인 유무검사하는 메소드
		//JoinPoint joinpoint는 포인트컷되어진 주업무의 메소드이다.
		
		//로그인 유무 확인하기 위해서는 request를 통해 session을 얻어와야한다.
		//HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];//줌업무 메소드의 첫번쨰 파라미터 가져옴
		//HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];//두번째 파라미터
		
		//ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		//HttpServletRequest request = attr.getRequest();
		
		//ServletWebRequest servletContainer = (ServletWebRequest)RequestContextHolder.getRequestAttributes();

		//HttpServletRequest request = servletContainer.getRequest();

		//HttpServletResponse response = servletContainer.getResponse();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getResponse();

		

		
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser") == null) {
			String message = "먼저 로그인부터 하세요.";
			String loc = request.getContextPath()+"/login.groovy";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//로그인 성공후 로그인 하기전 페이지로 돌아가는 작업 만들기
			//=== 현재 페이지의 주소 (URL)알아오기
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url);//세선에 url 정보를 저장시켜둔다.	
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
		}
		
	}//end of public void loginCheck(JoinPoint joinpoint) 
	
	


	
	/*
	//내가만든 gobackurl
	// === Pointcut(주업무)를 설정해야 한다.
	// Pointcut 이란 공통 관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.*(..))")
	public void getCurrentURL() {}
	
	// ===== Before Advice(공통관심사, 보조업무) 만들기 ====== // 
	@Before("getCurrentURL()")//@After @Around
	public static String getCurrentURL(JoinPoint joinpoint) {
		if("RequestFacade".equalsIgnoreCase(joinpoint.getArgs()[0].getClass().getSimpleName()) ) {
			HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];//줌업무 메소드의 첫번쨰 파라미터 가져옴
		
			String currentURL = request.getRequestURI().toString();//데이터 제외하고 나온다
			//http://localhost:9090/MyMVC/member/memberOneDetail.up
			String queryString = request.getQueryString(); //? 다음 데이터값나옴 post방식이면 null값이다
			//userid=seokj
			
			if(queryString != null) {//get방식
				currentURL+= "?" + queryString;
				//http://localhost:9090/MyMVC/member/memberOneDetail.up?userid=seokj
			}
			String ctxPath = request.getContextPath();
			int beginIndex = currentURL.indexOf(ctxPath)+ctxPath.length(); ////http://localhost:9090/MyMVC/ 제거위해 위치값
			currentURL = currentURL.substring(beginIndex); 
			///member/memberOneDetail.up?userid=seokj
			
			HttpSession session= request.getSession();
			session.setAttribute("goBackURL", currentURL);	
			
			return currentURL;
		
		
		}else {
			return "";
		}
	

	}//end of public static String getCurrentURL(HttpServletRequest request)
	*/
	

}
