package com.spring.groovy.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		
		return boardvo;
		
	}

	// 글 list로 읽어오기 
	@Override
	public List<BoardVO> getBoardList(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.getBoardList(paraMap); 
		return boardList;
	}

	// 글 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = dao.del(paraMap);
		return n;
	}
	
	//댓글추가하기
	@Override
	public int addComment(CommentVO commentvo) {
		int n = dao.addComment(commentvo);
		return n;
	}
	/*
	//댓글목록 출력하기
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = dao.getCommentListPaging(paraMap); 
		return commentList;
	}*/
	// 파일첨부 없는 경우 글 수정
	@Override
	public int edit_board(Map<String, String> paraMap) {
		// === #144. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여 
		//           tbl_board 테이블에 insert 를 해주어야 한다.
		//           원글쓰기 이라면 tbl_board 테이블의 groupno 컬럼의 값은 
		//           groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
		//           답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다. 
		
		
		int n = dao.edit_board(paraMap);
		return n;
	}
	// 파일첨부 있는 경우 글 수정
	@Override
	public int edit_board_withFile(Map<String, String> paraMap) {
		// === #144. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여 
		//           tbl_board 테이블에 insert 를 해주어야 한다.
		//           원글쓰기 이라면 tbl_board 테이블의 groupno 컬럼의 값은 
		//           groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
		//           답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다. 
		
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 시작 === //
		/*
		 * if("".equals(boardvo.getFk_seq())) { // 원글쓰기인 경우 // groupno 컬럼의 값은 groupno
		 * 컬럼의 최대값(max)+1 로 해야 한다. int groupno = dao.getGroupnoMax() + 1;
		 * boardvo.setGroupno(String.valueOf(groupno)); }
		 */
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 끝 === //
		
		int n = dao.edit_board_withFile(paraMap);
		return n;
	}
	
	//맵으로 게시글 가져오기   
	@Override
	public Map<String, String> boardView(String pk_board_seq) {
		Map<String,String> map = dao.boardView(pk_board_seq);
		return map;
	}

	//댓글추가
	@Override
	public int commentAdd(Map<String, String> paraMap) {
		int n = dao.commentAdd(paraMap);
		return n;
	}
	
	//댓글보기
	@Override
	public List<Map<String, String>> commentShow(Map<String, String> paraMap) {
		List<Map<String,String>> listMap = dao.commentShow(paraMap);
		return listMap;
	}
	//원게시물에 딸린 댓글 totalPage 알아오기(ajax로 처리)
	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = dao.getCommentTotalPage(paraMap);
		return totalPage;
	}
	//댓글수정
	@Override
	public int commentEdit(Map<String, String> paraMap) {
		int n = dao.commentEdit(paraMap);
		return n;
	}
	//댓글삭제
	@Override
	public int commentDel(Map<String, String> paraMap) {
		int n = dao.commentDel(paraMap);
		return n;
	}

	@Override
	// === #115. 총 게시물 건수(totalCount) 구하기 - 
	public int getBoardTotalPage(Map<String, String> paraMap) {
		int totalPage = dao.getBoardTotalPage(paraMap);
		return totalPage;
	}




}//end of public class LeejhService implements InterLeejhService