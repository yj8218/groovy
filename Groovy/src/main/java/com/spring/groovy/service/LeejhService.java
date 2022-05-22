package com.spring.groovy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.model.BoardVO;
import com.spring.groovy.common.AES256;
import com.spring.groovy.model.*;


@Service
public class LeejhService implements InterLeejhService {
	
	@Autowired
	private InterLeejhDAO dao;
	@Autowired
	private AES256 aes;
	/////////////////////////////////////////////////////
	
	
	//   === 로그인 처리하기  ===
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = dao.getLoginEmployee(paraMap);

		return loginuser;
	}
	
	//  === 로그인 기록 카운트  ===
	@Override
	public int getLoginHistory(String pk_empnum) {
		int n = dao.getLoginHistory(pk_empnum);
		return n;
	}
	
	// === 비밀번호 찾기 인증번호 발송 메서드 === //
	@Override
	public boolean sendCodeEmail(Map<String, String> paraMap) {
		boolean isExists = dao.sendCodeEmail(paraMap);
		return isExists;
	}

	// === 새비밀번호 업데이트 메서드(update) === //
	@Override
	public int newPwdUpdate(Map<String, String> paraMap) {
		int n = dao.newPwdUpdate(paraMap);
		return n;
	}
	

	//직원정보
	@Override
	public List<EmployeeVO> empList() {
		List<EmployeeVO> empList = dao.empList();
		return empList;
	}

	@Override
	public List<String> deptList() {
		List<String> deptList = dao.deptList();
		//System.out.println(deptList);
		return deptList;
	}
	
	// 로그인유저 정보얻어오기
	@Override
	public EmployeeVO getUserInfo(String pk_empnum) {
		EmployeeVO loginuser  = dao.getUserInfo(pk_empnum);
		return loginuser;
	}
		
	// === 연락처 수정 메서드 === 
	@Override
	public int myPhoneUpdate(Map<String, String> paraMap) {
		int n = dao.myPhoneUpdate(paraMap);
		return n;
	}
	
	// === 이메일 수정 메서드 === 
	@Override
	public int myEmailUpdate(Map<String, String> paraMap) {
		int n = dao.myEmailUpdate(paraMap);
		return n;
	}
	// === 주소 수정 메서드 
	@Override
	public int myAddressUpdate(Map<String, String> paraMap) {
		int n = dao.myAddressUpdate(paraMap);
		return n;
	}
	// === 비밀번호 수정
	@Override
	public int myPwdUpdate(Map<String, String> paraMap) {
		int n = dao.myPwdUpdate(paraMap);
		return n;
	}

	@Override
	public int editFile(EmployeeVO empVo) {
		int n = dao.editFile(empVo);
		return n;
	}

	//글쓰기
	@Override
	public int add(BoardVO boardvo) {

		// === #144. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여 
		//           tbl_board 테이블에 insert 를 해주어야 한다.
		//           원글쓰기 이라면 tbl_board 테이블의 groupno 컬럼의 값은 
		//           groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
		//           답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다. 
		
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 시작 === //
		if("".equals(boardvo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야 한다.
			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 끝 === //
		
		int n = dao.add(boardvo);
		return n;
	}

	// === #157. 글쓰기(파일첨부가 있는 글쓰기) === //
	@Override
	public int add_withFile(BoardVO boardvo) {
		
		// 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여 
		// tbl_board 테이블에 insert 를 해주어야 한다.
		// 원글쓰기 이라면 tbl_board 테이블의 groupno 컬럼의 값은 
		// groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
		// 답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다.
		
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 시작 === //
		if("".equals(boardvo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야 한다.
			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 끝 === //
		
		int n = dao.add_withFile(boardvo); // 첨부파일이 있는 경우
		return n;
	}

	@Override
	public List<Map<String, String>> employeeChart() {
		List<Map<String, String>> employeeChartList = dao.employeeChart();
		return employeeChartList;
	}


	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글1개 조회하기
		
		String login_userid = paraMap.get("login_userid");  
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		if(login_userid != null &&
		   boardvo != null &&
		  !login_userid.equals(boardvo.getFk_empnum())) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다. 
			
			dao.setAddReadCount(boardvo.getPk_board_seq());  // 글조회수 1증가 하기 
			boardvo = dao.getView(paraMap); 
		}
		
		return boardvo;
	}

	// 글 list로 읽어오기 
	@Override
	public List<BoardVO> getBoardList() {
		List<BoardVO> boardList = dao.getBoardList(); 
		return boardList;
	}


}//end of public class LeejhService implements InterLeejhService