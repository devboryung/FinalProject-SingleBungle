package com.gaji.SingleBungle.board.model.service;

import java.util.List;
import java.util.Map;

import com.gaji.SingleBungle.board.model.vo.BoardReply;

public interface BoardReplyService {

	
	/** 댓글 목록 조회 Service
	 * @param parentBoardNo
	 * @return rList
	 */
	public abstract List<BoardReply> selectReplyList(int parentBoardNo);

	/** 댓글 삽입 Service
	 * @param reply
	 * @return result
	 */
	public abstract int insertReply(BoardReply reply);

	/** 댓글 수정 Service
	 * @param reply
	 * @return result
	 */
	public abstract int updateReply(BoardReply reply);

	/** 댓글 삭제 Service
	 * @param replyNo
	 * @return result
	 */
	public abstract int deleteReply(int replyNo);

	/** 답글 삽입 Service
	 * @param reply
	 * @return
	 */
	public abstract int insertChildReply(BoardReply reply);

	/** 댓글 신고 Service
	 * @param map
	 * @return
	 */
	public abstract int insertBoardReport(Map<String, Object> map);
	
	

}
