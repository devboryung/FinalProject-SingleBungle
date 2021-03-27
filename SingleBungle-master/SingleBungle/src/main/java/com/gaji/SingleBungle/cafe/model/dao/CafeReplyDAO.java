package com.gaji.SingleBungle.cafe.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.cafe.model.vo.CafeReply;

@Repository
public class CafeReplyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	
	/** 댓글 목록 조회 DAO
	 * @param cafeNo
	 * @return rList
	 */
	public List<CafeReply> selectReplyList(int cafeNo) {
		return sqlSession.selectList("cafeReplyMapper.selectReplyList", cafeNo);
	}


	/** 댓글 등록 DAO
	 * @param reply
	 * @return result
	 */
	public int insertReply(CafeReply reply) {
		return sqlSession.insert("cafeReplyMapper.insertReply", reply);
	}

	/** 댓글 수정 DAO
	 * @param reply
	 * @return result
	 */
	public int updateReply(CafeReply reply) {
		return sqlSession.update("cafeReplyMapper.updateReply", reply);
	}

	/** 댓글 삭제 DAO
	 * @param replyNo
	 * @return result
	 */
	public int deleteReply(int replyNo) {
		return sqlSession.update("cafeReplyMapper.deleteReply", replyNo);
	}

	/** 답글 삽입 DAO
	 * @param reply
	 * @return
	 */
	public int insertChildReply(CafeReply reply) {
		return sqlSession.insert("cafeReplyMapper.insertChildReply", reply);
	}


	/** 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("cafeReplyMapper.selectReportNo");
	}

	/** 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoardReport(Map<String, Object> map) {
		return sqlSession.insert("cafeReplyMapper.insertBoardReport", map);
	}


}
