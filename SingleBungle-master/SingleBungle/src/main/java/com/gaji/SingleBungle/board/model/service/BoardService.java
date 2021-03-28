package com.gaji.SingleBungle.board.model.service;

import java.util.List;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.board.model.vo.Board;
import com.gaji.SingleBungle.board.model.vo.BoardAttachment;
import com.gaji.SingleBungle.board.model.vo.BoardLike;
import com.gaji.SingleBungle.board.model.vo.BoardPageInfo;
import com.gaji.SingleBungle.board.model.vo.BoardSearch;

public interface BoardService {

	
	/** 페이징 처리 객체 생성 Service
	 * @param cp
	 * @return bpInfo
	 */
	public abstract BoardPageInfo getPageInfo(int cp);

	
	/** 게시글 목록 조회 Service
	 * @param bpInfo
	 * @return bList
	 */
	public abstract List<Board> selectList(BoardPageInfo bpInfo);
	
	/** 게시글 검색 목록 페이징 Service
	 * @param map
	 * @return bpInfo
	 */
	public abstract BoardPageInfo getSearchPageInfo(BoardSearch bSearch, int cp);


	/** 게시글 검색 목록 조회 Service
	 * @param map
	 * @param bpInfo
	 * @return bList
	 */
	public abstract List<Board> selectSearchList(BoardSearch bSearch, BoardPageInfo bpInfo);


	/** 게시글 상세 조회 Service
	 * @param boardNo
	 * @return board
	 */
	public abstract Board selectBoard(int boardNo);


	/** 게시글에 포함된 이미지 목록 조회 Service
	 * @param boardNo
	 * @return attachmentList
	 */
	public abstract List<BoardAttachment> selectAttachmentList(int boardNo);
	
	/** summernote 업로드 이미지 저장 Service
	 * @param uploadFile
	 * @param savePath
	 * @return at
	 */
	public abstract BoardAttachment insertImage(MultipartFile uploadFile, String savePath);

	/** 게시글 삽입 (+ 파일 업로드) Service
	 * @param map
	 * @param images
	 * @param savePath
	 * @return result
	 */
	public abstract int insertBoard(Map<String, Object> map, List<MultipartFile> images, String savePath);

	/** 게시글 수정 Service
	 * @param updateBoard
	 * @return result
	 */
	public abstract int updateBoard(Board updateBoard);
	
	/** 게시글 삭제 Service
	 * @param board
	 * @return result
	 */
	public abstract int deleteBoard(Board board);
	
	/** 좋아요 목록 조회 Service
	 * @param memberNo
	 * @return
	 */
	List<BoardLike> selectLike(int memberNo);


	/** 좋아요 증가 Service
	 * @param map
	 * @return result
	 */
	public abstract int increaseLike(Map<String, Object> map);


	/** 좋아요 감소 Service
	 * @param map
	 * @return result
	 */
	public abstract int decreaseLike(Map<String, Object> map);


	/** 좋아요 여부 확인 Service
	 * @param map
	 * @return like
	 */
	public abstract int selectLikePushed(Map<String, Integer> map);


	/** 신고 등록 Service
	 * @param map
	 * @return result
	 */
	public abstract int insertBoardReport(Map<String, Object> map);

	
	
	
	
	
	
	
	
	
	
	
	
	

	/** 관리자(admin) 삭제된 게시글 상세조회 Service
	 * @param boardNo
	 * @return 
	 */
	public abstract Board selectDeleteBoard(int boardNo);



	
	

}
