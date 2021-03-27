package com.gaji.SingleBungle.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.board.model.vo.BoardReply;

@Repository
public class BoardReplyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 댓글 목록 조회 DAO
	 * @param parentBoardNo
	 * @return rList
	 */
	public List<BoardReply> selectReplyList(int parentBoardNo) {
		return sqlSession.selectList("boardReplyMapper.selectReplyList", parentBoardNo);
	}

	/** 댓글 등록 DAO
	 * @param reply
	 * @return result
	 */
	public int insertReply(BoardReply reply) {
		return sqlSession.insert("boardReplyMapper.insertReply", reply);
	}

	/** 댓글 수정 DAO
	 * @param reply
	 * @return result
	 */
	public int updateReply(BoardReply reply) {
		return sqlSession.update("boardReplyMapper.updateReply", reply);
	}

	/** 댓글 삭제 DAO
	 * @param replyNo
	 * @return result
	 */
	public int deleteReply(int replyNo) {
		return sqlSession.update("boardReplyMapper.deleteReply", replyNo);
	}

	/** 답글 삽입 DAO
	 * @param reply
	 * @return
	 */
	public int insertChildReply(BoardReply reply) {
		return sqlSession.insert("boardReplyMapper.insertChildReply", reply);
	}

	/** 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("boardReplyMapper.selectReportNo");
	}
	
	/** 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoardReport(Map<String, Object> map) {
		return sqlSession.insert("boardReplyMapper.insertBoardReport", map);
	}

}
