package com.gaji.SingleBungle.admin.service;

import java.util.List;

import com.gaji.SingleBungle.admin.vo.inquiryReply;

public interface inquiryReplyService {

	List<inquiryReply> selectReplyList(int parentBoardNo);

	int insertReply(inquiryReply reply);

	int updateInquiryFl(int parentBoardNo);



}
