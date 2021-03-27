package com.gaji.SingleBungle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaji.SingleBungle.admin.dao.inquiryReplyDAO;
import com.gaji.SingleBungle.admin.vo.inquiryReply;
import com.gaji.SingleBungle.review.model.vo.ReviewReply;

@Service
public class inquiryReplyServiceImpl implements inquiryReplyService{

	@Autowired
	private inquiryReplyDAO dao;
	
	
	@Override
	public List<inquiryReply> selectReplyList(int parentBoardNo) {
		return dao.selectReplyList(parentBoardNo);
	}
	
	
	// 댓글 삽입
		@Transactional(rollbackFor = Exception.class)
		@Override
		public int insertReply(inquiryReply reply) {
			reply.setInquiryContent(replaceParameter (reply.getInquiryContent()));
			reply.setInquiryContent(reply.getInquiryContent().replaceAll("\n", "<br>"));
			
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


		@Override
		public int updateInquiryFl(int parentBoardNo) {
			return dao.updateInquiryFl(parentBoardNo);
			
		}



	
}
