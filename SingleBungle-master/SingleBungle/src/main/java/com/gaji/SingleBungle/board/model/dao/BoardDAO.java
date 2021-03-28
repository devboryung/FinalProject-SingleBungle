package com.gaji.SingleBungle.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.board.model.vo.Board;
import com.gaji.SingleBungle.board.model.vo.BoardAttachment;
import com.gaji.SingleBungle.board.model.vo.BoardLike;
import com.gaji.SingleBungle.board.model.vo.BoardPageInfo;
import com.gaji.SingleBungle.board.model.vo.BoardSearch;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/** 자유게시판 전체 게시글 수 조회 DAO
	 * @return listCount
	 */
	public int getListCount() {
		return sqlSession.selectOne("boardMapper.getListCount");
	}

	/** 게시글 목록 조회 DAO
	 * @param bpInfo
	 * @return bList
	 */
	public List<Board> selectList(BoardPageInfo bpInfo) {
		
		int offset = (bpInfo.getCurrentPage() - 1) * bpInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, bpInfo.getLimit());
		
		return sqlSession.selectList("boardMapper.selectList", bpInfo, rowBounds);
	}
	
	/** 검색 게시글 수 조회 DAO
	 * @param map
	 * @return 
	 */
	public int getSearchListCount(BoardSearch bSearch) {
		return sqlSession.selectOne("boardMapper.getSearchListCount", bSearch);
	}

	/** 게시글 검색 목록 조회 DAO
	 * @param map
	 * @param bpInfo
	 * @return bList
	 */
	public List<Board> selectSearchList(BoardSearch bSearch, BoardPageInfo bpInfo) {
		int offset = (bpInfo.getCurrentPage() -1) * bpInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, bpInfo.getLimit());
		
		return sqlSession.selectList("boardMapper.selectSearchList", bSearch, rowBounds);
	}


	/** 게시글 상세조회 DAO
	 * @param temp
	 * @return board
	 */
	public Board selectBoard(Board temp) {
		return sqlSession.selectOne("boardMapper.selectBoard", temp);
	}

	/** 게시글 조회수 증가 DAO
	 * @param boardNo
	 * @return result
	 */
	public int increaseReadCount(int boardNo) {
		return sqlSession.update("boardMapper.increaseReadCount", boardNo);
	}
	
	/** 게시글에 포함된 이미지 목록 조회 DAO
	 * @param boardNo
	 * @return attachmentList
	 */
	public List<BoardAttachment> selectAttachmentList(int boardNo) {
		return sqlSession.selectList("boardMapper.selectAttachmentList", boardNo);
	}
	
	/** 다음 게시글 번호 얻어오기 DAO
	 * @return boardNo
	 */
	public int selectNextNo() {
		return sqlSession.selectOne("boardMapper.selectNextNo");
	}

	/** 게시글 삽입 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoard(Map<String, Object> map) {
		return sqlSession.insert("boardMapper.insertBoard", map);
	}
	
	/** 파일 정보 삽입 DAO
	 * @param uploadImages
	 * @return
	 */
	public int insertAttachmentList(List<BoardAttachment> uploadImages) {
		return sqlSession.insert("boardMapper.insertAttachmentList", uploadImages);
	}

	
	
	/** 게시글 삭제 DAO
	 * @param board
	 * @return result
	 */
	public int deleteBoard(Board board) {
		return sqlSession.update("boardMapper.deleteBoard", board);
	}
	
	/** 좋아요 목록 조회 DAO
	 * @param memberNo
	 * @return
	 */
	public List<BoardLike> selectLike(int memberNo) {
		return sqlSession.selectList("boardMapper.selectLike", memberNo);
	}


	/** 좋아요 증가 DAO
	 * @param map
	 * @return result
	 */
	public int increaseLike(Map<String, Object> map) {
		return sqlSession.insert("boardMapper.increaseLike", map);
	}

	/** 좋아요 감소 DAO
	 * @param map
	 * @return result
	 */
	public int decreaseLike(Map<String, Object> map) {
		return sqlSession.delete("boardMapper.decreaseLike", map);
	}

	/** 게시글 수정 DAO
	 * @param updateBoard
	 * @return
	 */
	public int updateBoard(Board updateBoard) {
		return sqlSession.update("boardMapper.updateBoard", updateBoard);
	}

	/** 파일 정보 일괄 삭제 DAO
	 * @param deleteFileNoList
	 * @return result
	 */
	public int deleteAttachmentList(List<Integer> deleteFileNoList) {
		return sqlSession.delete("boardMapper.deleteAttachmentList", deleteFileNoList);
	}

	/** 좋아요 여부 확인 DAO
	 * @param map
	 * @return like
	 */
	public int selectLikePushed(Map<String, Integer> map) {
		return sqlSession.selectOne("boardMapper.selectLikePushed", map);
	}

	/** 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("boardMapper.selectReportNo");
	}

	/** 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoardReport(Map<String, Object> map) {
		return sqlSession.insert("boardMapper.insertBoardReport", map);
	}

	
	
	
	
	
	
	
	
	
	
	/** 관리자(admin) 삭제된 게시글 상세조회 DAO
	 * @param boardNo
	 * @return
	 */
	public Board selectDeleteBoard(int boardNo) {
		return sqlSession.selectOne("boardMapper.selectDeleteBoard",boardNo);
	}


	
	





	
}
