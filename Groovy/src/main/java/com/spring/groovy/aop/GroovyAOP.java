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
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..))")
	public void requiredLogin() {}
	
	// ===== Before Advice(공통관심사, 보조업무) 만들기 ====== // 
	@Before("requiredLogin()")//@After @Around
	public void loginCheck(JoinPoint joinpoint) {//로그인 유무검사하는 메소드
		//JoinPoint joinpoint는 포인트컷되어진 주업무의 메소드이다.
		
		//로그인 유무 확인하기 위해서는 request를 통해 session을 얻어와야한다.
		HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];//줌업무 메소드의 첫번쨰 파라미터 가져옴
		HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];//두번째 파라미터
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser") == null) {
			String message = "먼저 로그인부터 하세요.";
			String loc = request.getContextPath()+"/login.action";
			
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
				e.printStackTrace();
			}
	
		}
		
	}//end of public void loginCheck(JoinPoint joinpoint) 
	
}