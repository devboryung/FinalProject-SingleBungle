package com.gaji.SingleBungle.findFriend.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.findFriend.model.vo.FindFriendAttachment;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendChatting;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriend;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendPageInfo;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendSearch;

@Repository
public class FindFriendDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 전체 게시글 수 조회 DAO
	 * @return listCount
	 */
	public int getListCount() {
		return sqlSession.selectOne("friendMapper.getListCount");
	}
	
	/** 전체 게시글 목록 조회
	 * @param pInfo
	 * @return
	 */
	public List<FindFriend> selectList(FindFriendPageInfo pInfo) {
		
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		
		return sqlSession.selectList("friendMapper.selectList", pInfo, rowBounds);
	}
	
	/** 검색 게시글 수 조회 DAO
	 * @param fSearch
	 * @return
	 */
	public int getSearchListCount(FindFriendSearch fSearch) {
		return sqlSession.selectOne("friendMapper.getSearchListCount", fSearch);
	}

	/** 게시글 검색 목록 조회 DAO
	 * @param map
	 * @param pInfo
	 * @return
	 */
	public List<FindFriend> selectSearchList(FindFriendSearch fSearch, FindFriendPageInfo pInfo) {
		
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		
		return sqlSession.selectList("friendMapper.selectSearchList", fSearch, rowBounds);
	}

	/** 게시글 상세 조회 DAO
	 * @param friendNo
	 * @return findFriend
	 */
	public FindFriend selectBoard(int friendNo) {
		return sqlSession.selectOne("friendMapper.selectBoard", friendNo);
	}
	
	
	/** 게시글 조회 수 증가 DAO
	 * @param friendNo
	 * @return result
	 */
	public int increaseReadCount(int friendNo) {
		return sqlSession.update("friendMapper.increaseReadCount", friendNo);
	}
	
	/** 게시글에 포함된 이미지 목록 조회 DAO
	 * @param friendNo
	 * @return attachmentList
	 */
	public List<FindFriendAttachment> selectAttachmentList(int friendNo) {
		return sqlSession.selectList("friendMapper.selectAttachmentList", friendNo);
	}
	
	/** 상세 조회 시 참여신청 여부 확인 DAO
	 * @param map
	 * @return checkApply
	 */
	public int checkApply(Map<String, Object> map) {
		return sqlSession.selectOne("friendMapper.checkApply", map);
	}
	
	/** 친구찾기 참여 신청 DAO
	 * @param map
	 * @return int
	 */
	public int insertApply(Map<String, Object> map) {
		return sqlSession.insert("friendMapper.insertApply", map);
	}

	/** 친구찾기 참여 취소 DAO
	 * @param map
	 * @return int
	 */
	public int deleteApply(Map<String, Object> map) {
		return sqlSession.delete("friendMapper.deleteApply", map);
	}
	
	/** 친구찾기 참여인원 카운트 DAO
	 * @param friendNo
	 * @return result
	 */
	public int selectApplyCount(int friendNo) {
		return sqlSession.selectOne("friendMapper.selectApplyCount", friendNo);
	}
	
	/** 친구찾기 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("friendMapper.selectReportNo");
	}
	
	/** 친구찾기 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertFindFriendReport(Map<String, Object> map) {
		return sqlSession.insert("friendMapper.insertFindFriendReport", map);
	}
	
	/** 다음 게시글 번호 조회 DAO
	 * @return nextBoardNo
	 */
	public int selectNextBoardNo() {
		return sqlSession.selectOne("friendMapper.selectNextBoardNo");
	}

	/** 게시글 삽입 DAO
	 * @param findFriend
	 * @return
	 */
	public int insertBoard(FindFriend findFriend) {
		return sqlSession.insert("friendMapper.insertBoard", findFriend);
	}

	/** 파일 정보 삽입 DAO
	 * @param uploadImages
	 * @return
	 */
	public int insertAttachmentList(List<FindFriendAttachment> uploadImages) {
		return sqlSession.insert("friendMapper.insertAttachmentList", uploadImages);
	}

	/** 게시글 수정 DAO
	 * @param updateBoard
	 * @return
	 */
	public int updateBoard(FindFriend updateBoard) {
		return sqlSession.update("friendMapper.updateBoard", updateBoard);
	}

	/** 파일 정보 일괄 삭제 DAO
	 * @param deleteFileNoList
	 * @return result
	 */
	public int deleteAttachmentList(List<Integer> deleteFileNoList) {
		return sqlSession.delete("friendMapper.deleteAttachmentList", deleteFileNoList);
	}

	/** 친구찾기 게시글 상태변경 DAO
	 * @param friendNo
	 * @return result
	 */
	public int updateStatus(int friendNo) {
		return sqlSession.update("friendMapper.updateStatus", friendNo);
	}

	/** DB에 최근 3일 이전에 저장된 파일 조회 DAO
	 * @return dbFileList
	 */
	public List<String> selectDBFileList() {
		return sqlSession.selectList("friendMapper.selectDBFileList");
	}
	
	/** 친구찾기 삭제 게시글 관리자 상세 조회 DAO
	 * @param friendNo
	 * @return findFriend
	 */
	public FindFriend selectDeleteBoard(int friendNo) {
		return sqlSession.selectOne("friendMapper.selectDeleteBoard", friendNo);
	}

	/** 친구찾기 채팅 삽입 DAO
	 * @param fChat
	 * @return result
	 */
	public int insertChat(Map<String, Object> map) {
		return sqlSession.insert("friendMapper.insertChat", map);
	}

	/** 친구찾기 채팅 조회 DAO
	 * @param friendNo
	 * @return cList
	 */
	public List<FindFriendChatting> selectChatList(int friendNo) {
		return sqlSession.selectList("friendMapper.selectChatList", friendNo);
	}

}
