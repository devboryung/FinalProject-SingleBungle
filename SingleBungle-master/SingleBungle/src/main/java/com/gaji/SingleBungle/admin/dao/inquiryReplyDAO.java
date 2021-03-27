package com.gaji.SingleBungle.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.admin.vo.inquiryReply;

@Repository
public class inquiryReplyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<inquiryReply> selectReplyList(int parentBoardNo) {
		return sqlSession.selectList("inquiryReplyMapper.selectReplyList", parentBoardNo);
	}
	
	public int insertReply(inquiryReply reply) {
		return sqlSession.insert("inquiryReplyMapper.insertReply", reply);
	}

	public int updateInquiryFl(int parentBoardNo) {
		return sqlSession.update("inquiryReplyMapper.updateInquiryFl", parentBoardNo);
	}



}
