package com.spring.groovy.service;

import java.util.List;
import java.util.Map;

import com.spring.groovy.model.BoardVO;
import com.spring.groovy.model.CommentVO;
import com.spring.groovy.model.DepartmentVO;
import com.spring.groovy.model.EmployeeVO;
import com.spring.groovy.model.SpotVO;

public interface InterLeejhService {
	
	
	//   === 로그인 처리하기  
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);

	//  === 로그인 기록 카운트  
	int getLoginHistory(String pk_empnum);

	// === 비밀번호 찾기 시 입력한 이메일과 사원번호에  존재하는 사원정보에게 인증번호 발송 메서드 
	boolean sendCodeEmail(Map<String, String> paraMap);

	// === 새비밀번호 업데이트 메서드(update) 
	int newPwdUpdate(Map<String, String> paraMap);



	// === 직원정보 
	List<EmployeeVO> empList();
	// === 부서정보
	List<String> deptList();

	// === 로그인유저 정보얻어오기
	EmployeeVO getUserInfo(String pk_empnum);
		
	// === 연락처 수정 메서드 
	int myPhoneUpdate(Map<String, String> paraMap);
	// === 이메일 수정 메서드 
	int myEmailUpdate(Map<String, String> paraMap);
	// === 주소 수정 메서드 
	int myAddressUpdate(Map<String, String> paraMap);
	// === 비밀번호 수정
	int myPwdUpdate(Map<String, String> paraMap);

	// === 파일 수정
	int editFile(EmployeeVO empVo);

	// === 글쓰기
	int add(BoardVO boardvo);
	// === 파일첨부 글쓰기
	int add_withFile(BoardVO boardvo);

	//하이차트 조직도
	List<Map<String, String>> employeeChart();
	
	
	//== 글조회수 증가와 함께 게시글 읽어오기
	BoardVO getView(Map<String, String> paraMap);

	
	// 글 list로 읽어오기 
	List<BoardVO> getBoardList(Map<String, String> paraMap);

	//글 삭제하기 
	int del(Map<String, String> paraMap);

	//댓글추가하기
	int addComment(CommentVO commentvo);

	//댓글목록 출력하기
///	List<CommentVO> getCommentListPaging(Map<String, String> paraMap);

	// 파일첨부 없는 경우 글 수정
	int edit_board(Map<String, String> paraMap);
	// 파일첨부 있는 경우 글 수정
	int edit_board_withFile(Map<String, String> paraMap);

	//맵으로 게시글 가져오기   --추후 getView랑 통합해야함.
	Map<String, String> boardView(Map<String, String> paraMap);
	//댓글추가
	int commentAdd(Map<String, String> paraMap);
	//댓글보기
	List<Map<String, String>> commentShow(Map<String, String> paraMap);
	//원게시물에 딸린 댓글 totalPage 알아오기(ajax로 처리)
	int getCommentTotalPage(Map<String, String> paraMap);
	//댓글수정
	int commentEdit(Map<String, String> paraMap);
	//댓글삭제
	int commentDel(Map<String, String> paraMap);

	int getBoardTotalPage(Map<String, String> paraMap);

	//검색어 입력시 보여주는거
	List<String> wordSearchShow(Map<String, String> paraMap);

	

	

	

	
}//end of public interface InterLeejhService
