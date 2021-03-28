package com.gaji.SingleBungle.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

@Repository
public class adminDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount(int type) {
		return sqlSession.selectOne("adminMapper.getListCount", type);
	}

	public List<ABoard> selectList(APageInfo pInfo) {
		// RowBounds 객체 : offset과 limit를 이용하여 조회 내용 중 일부 행만 조회하는 마이바티스 객체
				int offset = (pInfo.getCurrentPage() - 1) * pInfo.getLimit();
				
				RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectList", pInfo.getBoardType(), rowBounds);
	}

	public List<AAttachment> selectThumbnailList(List<ABoard> eventList) {
		return sqlSession.selectList("adminMapper.selectThumbnailList", eventList);
	}

	public ABoard selectBoard(ABoard temp) {
		return sqlSession.selectOne("adminMapper.selectBoard", temp);
	}

	public int increaseReadCount(int boardNo) {
		return sqlSession.update("adminMapper.increaseReadCount",boardNo);
	}

	public List<AAttachment> selectAttachmentList(int boardNo) {
		return sqlSession.selectList("adminMapper.selectAttachmentList", boardNo);
	}

	public int selectNextNo() {
		return sqlSession.selectOne("adminMapper.selectNextNo");
	}

	public int insertBoard(Map<String, Object> map) {
		return sqlSession.insert("adminMapper.insertBoard",map);
	}

	public int insertAttachmentList(List<AAttachment> uploadImages) {
		return sqlSession.insert("adminMapper.insertAttachmentList", uploadImages);
	}

	public int deleteBoard(int boardNo) {
		return sqlSession.update("adminMapper.deleteBoard", boardNo);
	}

	public List<ABoard> selectFaqList(int type) {
		return sqlSession.selectList("adminMapper.selectFaqList", type);
	}

	//1:1게시판 이용자 리스트 조회
	public List<inquiry> inquiryList(APageInfo pInfo, int memberNo) {
		// RowBounds 객체 : offset과 limit를 이용하여 조회 내용 중 일부 행만 조회하는 마이바티스 객체
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardType", pInfo.getBoardType());
		map.put("memberNo", memberNo);
		
		return sqlSession.selectList("adminMapper.inquiryList", map, rowBounds);
	}
	
	//1:1게시판 관리자 리스트 조회
	public List<inquiry> inquiryAllList(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardType", pInfo.getBoardType());
		return sqlSession.selectList("adminMapper.inquiryAllList", map, rowBounds);
	}

	public int selecinquirytNextNo() {
		return sqlSession.selectOne("adminMapper.selecinquirytNextNo");
	}

	public int insertinquiry(Map<String, Object> map) {
		return sqlSession.insert("adminMapper.insertinquiry",map);
	}

	public inquiry selectInquiry(inquiry temp) {
		return sqlSession.selectOne("adminMapper.selectInquiry", temp);
	}
	

	public List<IAttachment> selectIAttachmentList(int inquiryNo) {
		return sqlSession.selectList("adminMapper.selectIAttachmentList", inquiryNo);
	}

	public int getInquiryListCount() {
		return sqlSession.selectOne("adminMapper.getInquiryListCount");
	}
	
	public int getAllInquiryListCount() {
		return sqlSession.selectOne("adminMapper.getAllInquiryListCount");
	}

	public int deleteInquiry(int inquiryNo) {
		return sqlSession.update("adminMapper.deleteInquiry", inquiryNo);
	}

	public int updateBoard(ABoard updateBoard) {
		return sqlSession.update("adminMapper.updateBoard", updateBoard);
	}

	public int deleteAttachmentList(List<Integer> deleteFileNoList) {
		return sqlSession.delete("adminMapper.deleteAttachmentList", deleteFileNoList);
	}                   

	public int getAllListCount() {
		return sqlSession.selectOne("adminMapper.getAllListCount");
	}

	public List<ABoard> selectAllList(APageInfo pInfo) {
		// RowBounds 객체 : offset과 limit를 이용하여 조회 내용 중 일부 행만 조회하는 마이바티스 객체
		 int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	     RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
	      
		return sqlSession.selectList("adminMapper.selectAllList", pInfo, rowBounds);
	}

	public int recoverBoard1(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard1", boardNo);
	}

	public int recoverBoard2(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard2", boardNo);
	}

	public int recoverBoard3(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard3", boardNo);
	}

	public int recoverBoard4(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard4", boardNo);
	}

	public int recoverBoard6(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard6", boardNo);
	}

	public int recoverBoard7(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard7", boardNo);
	}

	public int recoverBoard8(int boardNo) {
		return sqlSession.update("adminMapper.recoverBoard8", boardNo);
	}

	public int getReplyListCount() {
		return sqlSession.selectOne("adminMapper.getReplyListCount");
	}
	
	public List<Reply> selectAllReply(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	     RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectAllReply", pInfo, rowBounds);
	}

	public int recoverReply1(int replyNo) {
		return sqlSession.update("adminMapper.recoverReply1", replyNo);
	}

	public int recoverReply6(int replyNo) {
		return sqlSession.update("adminMapper.recoverReply6", replyNo);
	}

	public int recoverReply7(int replyNo) {
		return sqlSession.update("adminMapper.recoverReply7", replyNo);
	}

	public int recoverReply8(int replyNo) {
		return sqlSession.update("adminMapper.recoverReply8", replyNo);
	}

	public int getMemberPageInfo() {
		return sqlSession.selectOne("adminMapper.getMemberPageInfo");
	}

	public List<Member> selectAllMember(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	     RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectAllMember", pInfo, rowBounds);
	}

	public int deleteMember(int memNo) {
		return sqlSession.update("adminMapper.deleteMember", memNo);
	}

	public int recoverMember(int memNo) {
		return sqlSession.update("adminMapper.recoverMember", memNo);
	}

	public int getGradePageInfo() {
		return sqlSession.selectOne("adminMapper.getGradePageInfo");
	}

	public List<Member> selectGradeMember(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectGradeMember", pInfo, rowBounds);
	}

	public int gradeMember(Map<String, Object> map) {
		return sqlSession.update("adminMapper.gradeMember", map);
	}

	public int getReportBoardPageInfo() {
		return sqlSession.selectOne("adminMapper.getReportBoardPageInfo");
	}

	public List<reportBoard> selectReportBoard(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectReportBoard", pInfo, rowBounds);
	}

	public int recoverReportBoard(Map<String, Integer> map) {
		return sqlSession.update("adminMapper.recoverReportBoard", map);
	}

	public int deleteReportBoard(Map<String, Integer> map) {
		return sqlSession.update("adminMapper.deleteReportBoard", map);
	}

	public int getReportReplyPageInfo() {
		return sqlSession.selectOne("adminMapper.getReportReplyPageInfo");
	}

	public List<reportReply> selectReportReply(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectReportReply", pInfo, rowBounds);
	}

	public int recoverReportReply(Map<String, Integer> map) {
		return sqlSession.update("adminMapper.recoverReportReply", map);
	}

	public int deleteReportReply(Map<String, Integer> map) {
		return sqlSession.update("adminMapper.deleteReportReply", map);
	}

	public List<ABoard> selectSearchList(String ct) {
		return sqlSession.selectList("adminMapper.selectSearchList", ct);
	}

	public int getSearchListCount(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchListCount", ct);
	}

	public List<ABoard> selectBoardSearchList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectBoardSearchList", ct, rowBounds);
	}

	public int getSearchRBoardListCount(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchRBoardListCount", ct);
	}

	public List<ABoard> selectSearchRBoardList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectSearchRBoardList", ct, rowBounds);
	}

	public int getSearchReplyListCount(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchReplyListCount", ct);
	}

	public List<ABoard> selectSearchReplyList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectSearchReplyList", ct, rowBounds);
	}

	public int getSearchRReplyListCount(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchRReplyListCount", ct);
	}

	public List<ABoard> selectSearchRReplyList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectSearchRReplyList", ct, rowBounds);
	}

	public int getSearchMemberListCount(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchMemberListCount", ct);
	}

	public List<ABoard> selectSearchmemberList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectSearchmemberList", ct, rowBounds);
	}

	public int getSearchmemberGradePageInfo(String ct) {
		return sqlSession.selectOne("adminMapper.getSearchmemberGradePageInfo", ct);
	}

	public List<ABoard> selectSearchmemberGradeList(String ct, APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectSearchmemberGradeList", ct, rowBounds);
	}

	public int getABoarPageInfo(int cp) {
		return sqlSession.selectOne("adminMapper.getABoarPageInfo", cp);
	}

	public int getAReplyPageInfo(int cp2) {
		return sqlSession.selectOne("adminMapper.getAReplyPageInfo", cp2);
	}

	public List<ABoard> selectABoardList(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectABoardList",pInfo, rowBounds);
	}

	public List<MReply> selectAReplyList(APageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("adminMapper.selectAReplyList", pInfo, rowBounds);
	}

}
