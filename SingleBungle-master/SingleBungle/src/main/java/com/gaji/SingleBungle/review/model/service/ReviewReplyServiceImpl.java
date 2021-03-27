package com.gaji.SingleBungle.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaji.SingleBungle.review.model.dao.ReviewReplyDAO;
import com.gaji.SingleBungle.review.model.vo.ReviewReply;

@Service
public class ReviewReplyServiceImpl implements ReviewReplyService {
	
	@Autowired
	private ReviewReplyDAO dao;

	
	// 댓글 목록 조회
	@Override
	public List<ReviewReply> selectReplyList(int parentBoardNo) {
		return dao.selectReplyList(parentBoardNo);
	}

	
	// 댓글 삽입
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReply(ReviewReply reply) {
		reply.setReplyContent(replaceParameter (reply.getReplyContent()));
		reply.setReplyContent(reply.getReplyContent().replaceAll("\n", "<br>"));
		
		return dao.insertReply(reply);
	}
	
	// 크로스 사이트 스크립트 방지 메소드
	private String replaceParameter(String param) {
		
		String result = param;
		
		if(param !=null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;"); 
		}
		
		return result;
		
	}

	
	// 댓글 수정
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReply(ReviewReply reply) {
		reply.setReplyContent( replaceParameter( reply.getReplyContent() ) );
		reply.setReplyContent( reply.getReplyContent().replaceAll("\n", "<br>"));		
		
		return dao.updateReply(reply);
	}

	// 댓글 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReply(int replyNo) {
		return dao.deleteReply(replyNo);
	}

	
	
	// 답글 등록
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChildReply(ReviewReply reply) {
		return dao.insertChildReply(reply);
	}

	// 댓글 신고
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReviewReplyReport(Map<String, Object> map) {
		
		int result =0;
		
		int reportNo = dao.selectReportNo();
		
		if (reportNo>0) {
			map.put("reportNo",reportNo);
			
			String reportTitle = (String)map.get("reportTitle");
			String reportContent = (String)map.get("reportContent");
			
			reportTitle = replaceParameter(reportTitle);
			reportContent = replaceParameter(reportContent);
			
			map.put("reportTitle", reportTitle);
			map.put("reportContent", reportContent);
		}
		
		result = dao.insertReviewReplyReport(map);
		
		if(result>0) {
			result = reportNo;
		}
		
		return result;
	}

	


}
