package com.gaji.SingleBungle.cafe.model.service;

import java.util.List;
import java.util.Map;

import com.gaji.SingleBungle.cafe.model.vo.CafeReply;

public interface CafeReplyService {

	/** 댓글 목록 조회 Service
	 * @param cafeNo
	 * @return rList
	 */
	List<CafeReply> selectReplyList(int cafeNo);

	/** 댓글 삽입 Service
	 * @param reply
	 * @return result
	 */
	int insertReply(CafeReply reply);

	/** 댓글 수정 Service
	 * @param reply
	 * @return result
	 */
	int updateReply(CafeReply reply);

	/** 댓글 삭제 Service
	 * @param replyNo
	 * @return result
	 */
	int deleteReply(int replyNo);

	/** 답글 삽입 Service
	 * @param reply
	 * @return
	 */
	int insertChildReply(CafeReply reply);

	/** 댓글 신고 Service
	 * @param map
	 * @return
	 */
	int insertBoardReport(Map<String, Object> map);

}
