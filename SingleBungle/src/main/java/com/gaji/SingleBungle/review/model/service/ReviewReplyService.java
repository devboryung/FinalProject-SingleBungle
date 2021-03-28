package com.gaji.SingleBungle.review.model.service;

import java.util.List;
import java.util.Map;

import com.gaji.SingleBungle.review.model.vo.ReviewReply;

public interface ReviewReplyService {

	
	
	/**  댓글 목록 조회
	 * @param parentBoardNo
	 * @return rList
	 */
	List<ReviewReply> selectReplyList(int parentBoardNo);

	/** 댓글 삽입
	 * @param reply
	 * @return result
	 */
	int insertReply(ReviewReply reply);

	/** 댓글 수정
	 * @param reply
	 * @return result
	 */
	int updateReply(ReviewReply reply);

	/** 댓글 삭제
	 * @param replyNo
	 * @return result
	 */
	int deleteReply(int replyNo);

	/** 답글 등록
	 * @param reply
	 * @return int
	 */
	int insertChildReply(ReviewReply reply);

	/** 댓글 신고
	 * @param map
	 * @return result
	 */
	int insertReviewReplyReport(Map<String, Object> map);
	


}
