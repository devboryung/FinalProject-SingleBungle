package com.gaji.SingleBungle.findFriend.model.service;

import java.util.List;
import java.util.Map;

import com.gaji.SingleBungle.findFriend.controller.FindFriendReplyController;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendReply;

public interface FindFriendReplyService {

	/** 댓글 목록 조회 Service
	 * @param friendNo
	 * @return rList
	 */
	List<FindFriendReply> selectReplyList(int parentFriendNo);

	/** 댓글 삽입 Service
	 * @param reply
	 * @return result
	 */
	int insertReply(FindFriendReply reply);

	/** 댓글 수정 Service
	 * @param reply
	 * @return result
	 */
	int updateReply(FindFriendReply reply);

	/** 댓글 삭제 Service
	 * @param replyNo
	 * @return result
	 */
	int deleteReply(int replyNo);

	/** 답글 삽입 Service
	 * @param reply
	 * @return
	 */
	int insertChildReply(FindFriendReply reply);

	/** 댓글 신고 Service
	 * @param map
	 * @return
	 */
	int insertBoardReport(Map<String, Object> map);

}
