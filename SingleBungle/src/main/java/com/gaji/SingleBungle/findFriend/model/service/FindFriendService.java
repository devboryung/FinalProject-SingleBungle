package com.gaji.SingleBungle.findFriend.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.findFriend.model.vo.FindFriendAttachment;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendChatting;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriend;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendPageInfo;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendSearch;

public interface FindFriendService {
	
	/** 게시글 목록 페이징처리 Service
	 * @param cp
	 * @return pInfo
	 */
	FindFriendPageInfo getPageInfo(int cp);
	
	/** 게시글 목록 조회 Service
	 * @param pInfo
	 * @return fList
	 */
	List<FindFriend> selectList(FindFriendPageInfo pInfo);
	
	/** 게시글 검색 목록 페이징처리 Service
	 * @param map
	 * @return pInfo
	 */
	FindFriendPageInfo getSearchPageInfo(FindFriendSearch fSearch, int cp);
	
	/** 게시글 검색 목록 조회 Service
	 * @param fSearch 
	 * @param pInfo
	 * @return fList
	 */
	List<FindFriend> selectSearchList(FindFriendSearch fSearch, FindFriendPageInfo pInfo);
	
	/** 친구찾기 게시글 상세 조회 Service
	 * @param friendNo
	 * @return findFriend
	 */
	FindFriend selectBoard(int friendNo);
	
	/** 게시글에 포함된 이미지 목록 조회 Service
	 * @param friendNo
	 * @return attachmentList
	 */
	List<FindFriendAttachment> selectAttachmentList(int friendNo);
	
	/** 상세 조회 시 참여신청 여부 확인 Service
	 * @param map
	 * @return checkApply
	 */
	int checkApply(Map<String, Object> map);
	
	/** 친구찾기 참여 신청 Service
	 * @param map
	 * @return int
	 */
	int insertApply(Map<String, Object> map);
	
	/** 친구찾기 참여 취소 Service
	 * @param map
	 * @return int
	 */
	int deleteApply(Map<String, Object> map);
	
	/** 친구찾기 참여인원 카운트 Service
	 * @param friendNo
	 * @return result
	 */
	int selectApplyCount(int friendNo);
	
	/** 친구찾기 게시글 신고 등록 Service
	 * @param map
	 * @return result
	 */
	int insertFindFriendReport(Map<String, Object> map);
	
	/** summernote 업로드 이미지 저장 Service
	 * @param uploadFile
	 * @param savePath
	 * @return at
	 */
	FindFriendAttachment inserImage(MultipartFile uploadFile, String savePath);

	/** 친구찾기 게시글 등록 Service
	 * @param findFriend
	 * @param savePath
	 * @return int
	 */
	int insertBoard(FindFriend findFriend, String savePath);

	/** 친구찾기 게시글 수정 Service
	 * @param updateBoard
	 * @return int
	 */
	int updateBoard(FindFriend updateBoard);

	/** 친구찾기 게시글 상태변경 Service
	 * @param friendNo
	 * @return result
	 */
	int updateStatus(int friendNo);

	/** DB에 최근 3일 이전에 저장된 파일 조회 Service 
	 * @return dbFileList
	 */
	List<String> selectDBFileList();

	/** 친구찾기 삭제 게시글 관리자 상세 조회 Service
	 * @param friendNo
	 * @return findFriend
	 */
	FindFriend selectDeleteBoard(int friendNo);

	/** 친구찾기 채팅 삽입 Service
	 * @param map
	 * @return result
	 */
	int insertChat(Map<String, Object> map);

	/** 친구찾기 채팅 조회 Service
	 * @param friendNo
	 * @return cList
	 */
	List<FindFriendChatting> selectChatList(int friendNo);

}
