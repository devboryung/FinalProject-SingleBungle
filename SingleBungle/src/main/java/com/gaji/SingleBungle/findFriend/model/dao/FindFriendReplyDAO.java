package com.gaji.SingleBungle.findFriend.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.findFriend.controller.FindFriendReplyController;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendReply;

@Repository
public class FindFriendReplyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 댓글 목록 조회 DAO
	 * @param friendNo
	 * @return rList
	 */
	public List<FindFriendReply> selectReplyList(int parentFriendNo) {
		return sqlSession.selectList("replyMapper.selectReplyList", parentFriendNo);
	}

	/** 댓글 등록 DAO
	 * @param reply
	 * @return result
	 */
	public int insertReply(FindFriendReply reply) {
		return sqlSession.insert("replyMapper.insertReply", reply);
	}

	/** 댓글 수정 DAO
	 * @param reply
	 * @return result
	 */
	public int updateReply(FindFriendReply reply) {
		return sqlSession.update("replyMapper.updateReply", reply);
	}

	/** 댓글 삭제 DAO
	 * @param replyNo
	 * @return result
	 */
	public int deleteReply(int replyNo) {
		return sqlSession.update("replyMapper.deleteReply", replyNo);
	}

	/** 답글 삽입 DAO
	 * @param reply
	 * @return result
	 */
	public int insertChildReply(FindFriendReply reply) {
		return sqlSession.insert("replyMapper.insertChildReply", reply);
	}

	/** 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("replyMapper.selectReportNo");

	}
	
	/** 댓글 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoardReport(Map<String, Object> map) {
		return sqlSession.insert("replyMapper.insertBoardReport", map);
	}

}
