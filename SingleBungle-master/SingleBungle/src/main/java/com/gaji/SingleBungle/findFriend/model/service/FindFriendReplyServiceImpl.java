package com.gaji.SingleBungle.findFriend.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaji.SingleBungle.findFriend.controller.FindFriendReplyController;
import com.gaji.SingleBungle.findFriend.model.dao.FindFriendReplyDAO;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendReply;

@Service
public class FindFriendReplyServiceImpl implements FindFriendReplyService {

	@Autowired
	private FindFriendReplyDAO dao;

	// 댓글 목록 조회 Service 구현
	@Override
	public List<FindFriendReply> selectReplyList(int parentFriendNo) {
		return dao.selectReplyList(parentFriendNo);
	}

	// 댓글 삽입 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReply(FindFriendReply reply) {
		
		reply.setReplyContent( replaceParameter( reply.getReplyContent() ) );
		reply.setReplyContent( reply.getReplyContent().replaceAll("\n", "<br>"));
		
		return dao.insertReply(reply);
	}
	
	// 댓글 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReply(FindFriendReply reply) {
		
		reply.setReplyContent( replaceParameter( reply.getReplyContent() ) );
		reply.setReplyContent( reply.getReplyContent().replaceAll("\n", "<br>"));
		
		return dao.updateReply(reply);
	}
	
	// 크로스 사이트 스크립트 방지 메소드
	private String replaceParameter(String param) {
		
		String result = param;
		
		if(param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}
		
		return result;
		
	}

	// 답글 삽입 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChildReply(FindFriendReply reply) {
		return dao.insertChildReply(reply);
	}

	// 댓글 삭제 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReply(int replyNo) {
		return dao.deleteReply(replyNo);
	}

	// 댓글 신고 등록 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoardReport(Map<String, Object> map) {
		int result = 0;
		
		int reportNo = dao.selectReportNo();
		
		System.out.println(reportNo);
		
		if(reportNo > 0) {
			map.put("reportNo", reportNo);
			
			String reportTitle = (String)map.get("reportTitle");
			String reportContent = (String)map.get("reportContent");
			
			reportTitle = replaceParameter(reportTitle);
			reportContent = replaceParameter(reportContent);
			
			map.put("reportTitle", reportTitle);
			map.put("reportContent", reportContent);
			
		}
				
		result = dao.insertBoardReport(map);
			
		if(result > 0) {
			
			result = reportNo;
		}
		
		return result;
		
	}

	
}
