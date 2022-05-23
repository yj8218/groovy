package com.spring.groovy.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groovy.model.BoardVO;
import com.spring.groovy.common.AES256;
import com.spring.groovy.model.EmployeeVO;

@Repository
public class LeejhDAO implements InterLeejhDAO {
	@Autowired
	private AES256 aes;
	
	@Resource
	private SqlSessionTemplate sqlsession;
	////////////////////////////////////////////////////////////
	
	
	//  << 로그인 처리하기>> 
	@Override
	public EmployeeVO getLoginEmployee(Map<String, String> paraMap) {
		EmployeeVO loginuser = sqlsession.selectOne("leejh.getLoginEmployee", paraMap);
		
		
		
		return loginuser;
	}
	
	// << 로그인 기록 카운트 >>
	@Override
	public int getLoginHistory(String pk_empnum) {
		int n = sqlsession.selectOne("leejh.getLoginHistory", pk_empnum);
		return n;
	}
	
	// === 비밀번호 찾기 시 입력한 이메일과 사원번호에  존재하는 사원정보에게 인증번호 발송 메서드 === //
	@Override
	public boolean sendCodeEmail(Map<String, String> paraMap) {
		
		String email = paraMap.get("email");

		try {
			paraMap.put("email", aes.encrypt(email) );
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		String employeeid = sqlsession.selectOne("leejh.sendCodeEmail", paraMap);
		
		
		
		boolean isExists = false;
		
		if(employeeid != null) {
			isExists = true;
		}
		else {
			isExists = false;
		}
		
		return isExists;
	}

	// === 새비밀번호 업데이트 메서드(update) === //
	@Override
	public int newPwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.newPwdUpdate", paraMap);
		return n;
	}


	// === 직원정보을 가져오기  ===


	@Override
	public List<EmployeeVO> empList() {
		List<EmployeeVO> empList = sqlsession.selectList("leejh.empList");
		return empList;
	}

	@Override
	public List<String> deptList() {
		
		 List<String> deptList = sqlsession.selectList("leejh.deptList");
		return deptList;
	}
	
	
	// === 연락처 수정 메서드 === 
	@Override
	public int myPhoneUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myPhoneUpdate", paraMap);
		System.out.println("test");
		return n;
	}

	//유저 정보 얻어오기
	@Override
	public EmployeeVO getUserInfo(String pk_empnum) {
		EmployeeVO loginuser = sqlsession.selectOne("leejh.getUserInfo", pk_empnum);
		
		return loginuser;
	}
	// === 이메일 수정 메서드 ===
	@Override
	public int myEmailUpdate(Map<String, String> paraMap) {
		String myemail = paraMap.get("myemail");
		
		try {
			paraMap.put("myemail", aes.encrypt(myemail) );
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		int n = sqlsession.update("leejh.myEmailUpdate", paraMap);
		return n;
	}
	
	// === 주소 수정 메서드 ===
	@Override
	public int myAddressUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myAddressUpdate", paraMap);
		return n;
	}
	// === 비밀번호 수정 메서드 === 
	@Override
	public int myPwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.myPwdUpdate", paraMap);
		return n;
	}

	@Override
	public int editFile(EmployeeVO empVo) {
		int n = sqlsession.update("leejh.editFile",  empVo);
		return n;
	}

	// === 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("leejh.add", boardvo);
		return n;
	}

	// === #145. tbl_board 테이블에서 groupno 컬럼의 최대값 알아오기 === //
	@Override
	public int getGroupnoMax() {
		int maxgroupno = sqlsession.selectOne("leejh.getGroupnoMax");
		return maxgroupno;
	}

	// === #158. 글쓰기(첨부파일이 있는 경우) === //
	@Override
	public int add_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("leejh.add_withFile", boardvo);
		return n;
	}

	@Override
	public List<Map<String, String>> employeeChart() {
		List<Map<String, String>> employeeChartList = sqlsession.selectList("leejh.employeeChart");
			return employeeChartList;
	}

	// ==== #64. 글1개 조회하기 ==== //
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("leejh.getView", paraMap);
		return boardvo;
	}
	
	

	// ==== #65. 글조회수 1증가 하기 ==== //
	@Override
	public void  setAddReadCount(String pk_board_seq) {
		sqlsession.update("leejh.setAddReadCount", pk_board_seq);
	}
	
	// 글 list로 읽어오기 
	@Override
	public List<BoardVO> getBoardList(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("leejh.getBoardList", paraMap);
		return boardList;
	}

	// 글 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("leejh.del", paraMap);
		return n;
	}
	//댓글추가하기
	@Override
	public int addComment(CommentVO commentvo) {
		int n = sqlsession.insert("leejh.addComment", commentvo);
		return n;
	}
	/*
	//댓글목록 출력하기
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("leejh.getCommentListPaging");
		return commentList;
	}*/
	// 파일첨부 없는 경우 글 수정
	@Override
	public int edit_board(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.edit_board", paraMap);
		return n;
	}
	// 파일첨부 있는 경우 글 수정
	@Override
	public int edit_board_withFile(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.edit_board_withFile", paraMap);
		return n;
	}

	//맵으로 게시글 가져오기   
	@Override
	public Map<String, String> boardView(String pk_board_seq) {
		
		Map<String,String> map = sqlsession.selectOne("leejh.boardView", pk_board_seq);
		return map;
	}

	//댓글추가
	@Override
	public int commentAdd(Map<String, String> paraMap) {
		int n = sqlsession.insert("leejh.commentAdd", paraMap);
		return n; 
	}
	//댓글보기
	@Override
	public List<Map<String, String>> commentShow(Map<String, String> paraMap) {
		List<Map<String,String>> listMap = sqlsession.selectList("leejh.commentShow", paraMap);
		return listMap;
	}
	//원게시물에 딸린 댓글 totalPage 알아오기(ajax로 처리)
	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = sqlsession.selectOne("leejh.getCommentTotalPage", paraMap);
		return totalPage;
	}
	//댓글수정
	@Override
	public int commentEdit(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.commentEdit", paraMap);
		return n;
	}
	//댓글삭제
	@Override
	public int commentDel(Map<String, String> paraMap) {
		int n = sqlsession.update("leejh.commentDel", paraMap);
		return n;
	}
	// === #115. 총 게시물 건수(totalCount) 구하기 - 
	@Override
	public int getBoardTotalPage(Map<String, String> paraMap) {
		int totalPage = sqlsession.selectOne("leejh.getBoardTotalPage", paraMap);
		return totalPage;
	}





}//end of public class LeejhDAO implements InterLeejhDAO