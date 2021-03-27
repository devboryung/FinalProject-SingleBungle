package com.gaji.SingleBungle.market.model.service;

import java.util.List;
import java.util.Map;

import com.gaji.SingleBungle.market.model.vo.MarketReply;

public interface MarketReplyService {

	/** 댓글 목록 조회
	 * @param parentMarketNo
	 * @return rList
	 */
	List<MarketReply> selectReplyList(int parentMarketNo);

	/** 댓글 삽입
	 * @param reply
	 * @return results
	 */
	int insertReply(MarketReply reply);

	/** 댓글 수정 Service
	 * @param reply
	 * @return
	 */
	int updateReply(MarketReply reply);

	/** 댓글 삭제 Serivce
	 * @param replyNo
	 * @return result
	 */
	int deleteReply(int replyNo);

	/** 대댓글 등록 Service
	 * @param reply
	 * @return result
	 */
	int insertChildReply(MarketReply reply);

	/** 댓글 신고 Service
	 * @param map
	 * @return
	 */
	int insertBoardReport(Map<String, Object> map);
	
}
