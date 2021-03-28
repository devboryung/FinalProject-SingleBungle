package com.gaji.SingleBungle.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.admin.vo.AAttachment;
import com.gaji.SingleBungle.admin.vo.ABoard;
import com.gaji.SingleBungle.admin.vo.APageInfo;
import com.gaji.SingleBungle.admin.vo.IAttachment;
import com.gaji.SingleBungle.admin.vo.Reply;
import com.gaji.SingleBungle.admin.vo.inquiry;
import com.gaji.SingleBungle.admin.vo.reportBoard;
import com.gaji.SingleBungle.admin.vo.reportReply;
import com.gaji.SingleBungle.member.model.vo.MReply;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;


public interface adminService {

	APageInfo getPageInfo(int cp, int type);

	List<ABoard> selectList(APageInfo pInfo, int type);

	List<AAttachment> selectThumbnailList(List<ABoard> eventList);

	ABoard selectBoard(int boardNo, int type);

	List<AAttachment> selectAttachmentList(int boardNo);

	int insertNotice(Map<String, Object> map, List<MultipartFile> images, String savePath);

	AAttachment insertImage(MultipartFile uploadFile, String savePath);

	int insertEvent(Map<String, Object> map, List<MultipartFile> images, String savePath);

	int deleteBoard(int boardNo);

	List<ABoard> selectFaqList(int type);

	int insertFaqAction(Map<String, Object> map);

	List<inquiry> inquiryList(APageInfo pInfo, int memberNo);

	int insertinquiryAction(Map<String, Object> map, List<MultipartFile> images, String savePath);

	inquiry selectInquiryBoard(int inquiryNo);

	List<IAttachment> selectIAttachmentList(int inquiryNo);

	APageInfo getInquiryPageInfo(int cp);

	int deleteInquiry(int inquiryNo);

	int updateBoard(ABoard updateBoard, String savePath);

	APageInfo getAllPageInfo(int cp);

	List<ABoard> selectAllList(APageInfo pInfo);

	int recoverBoard(int boardNo, int boardCode);

	List<Reply> selectAllReply(APageInfo pInfo);

	APageInfo getReplyPageInfo(int cp);
	
	int recoverReply(int recoverReply, int boardCode);

	APageInfo getMemberPageInfo(int cp);

	List<Member> selectAllMember(APageInfo pInfo);

	int deleteMember(int memNo);

	int recoverMember(int memNo);

	APageInfo getGradePageInfo(int cp);

	List<Member> selectGradeMember(APageInfo pInfo);

	int gradeMember(int memNo, String grade);

	APageInfo getInquiryAllPageInfo(int cp);

	List<inquiry> inquiryAllList(APageInfo pInfo);

	APageInfo getReportBoardPageInfo(int cp);

	List<reportBoard> selectReportBoard(APageInfo pInfo);

	int recoverReportBoard(Map<String, Integer> map);

	int deleteReportBoard(Map<String, Integer> map);

	APageInfo getReportReplyPageInfo(int cp);

	List<reportReply> selectReportReply(APageInfo pInfo);

	int recoverReportReply(Map<String, Integer> map);

	int deleteReportReply(Map<String, Integer> map);

	List<ABoard> selectSearchList(String ct);

	APageInfo getSearchPageInfo(String ct, int cp);

	List<ABoard> selectBoardSearchList(String ct, APageInfo pInfo);

	APageInfo getSearchRBoardPageInfo(String ct, int cp);

	List<ABoard> selectSearchRBoardList(String ct, APageInfo pInfo);

	APageInfo getSearchReplyPageInfo(String ct, int cp);

	List<ABoard> selectSearchReplyList(String ct, APageInfo pInfo);

	APageInfo getSearchRReplyPageInfo(String ct, int cp);

	List<ABoard> selectSearchRReplyList(String ct, APageInfo pInfo);

	APageInfo getSearchmemberPageInfo(String ct, int cp);

	List<ABoard> selectSearchmemberList(String ct, APageInfo pInfo);

	APageInfo getSearchmemberGradePageInfo(String ct, int cp);

	List<ABoard> selectSearchmemberGradeList(String ct, APageInfo pInfo);

	List<ABoard> selectABoardList(APageInfo pInfo);

	List<MReply> selectAReplyList(APageInfo pInfo);

	APageInfo getABoarPageInfo(int cp);

	APageInfo getAReplyPageInfo(int cp2);



	

}
