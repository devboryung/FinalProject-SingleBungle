package com.gaji.SingleBungle.cafe.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.cafe.model.vo.Cafe;
import com.gaji.SingleBungle.cafe.model.vo.CafeAttachment;
import com.gaji.SingleBungle.cafe.model.vo.CafeLike;
import com.gaji.SingleBungle.cafe.model.vo.CafePageInfo;
import com.gaji.SingleBungle.cafe.model.vo.CafeSearch;

public interface CafeService {

	/** 페이징 처리 객체 생성 Service
	 * @param cp
	 * @return cpInfo
	 */
	public abstract CafePageInfo getPageInfo(int cp);

	/** 게시글 목록 조회 Service
	 * @param cpInfo
	 * @return cList
	 */
	public abstract List<Cafe> selectList(CafePageInfo cpInfo);

	/** 썸네일 목록 조회 Service
	 * @param cList
	 * @return thList
	 */
	public abstract List<CafeAttachment> selectThumbnailList(List<Cafe> cList);
	
	/** 게시글 검색 목록 페이징 Service
	 * @param map
	 * @return cpInfo
	 */
	public abstract CafePageInfo getSearchPageInfo(CafeSearch cSearch, int cp);
 
	/** 게시글 검색 목록 조회 Service
	 * @param map
	 * @param cpInfo
	 * @return cList
	 */
	public abstract List<Cafe> selectSearchList(CafeSearch cSearch, CafePageInfo cpInfo);
	
	/** 조회수 상위 3 게시글 조회 Service
	 * @return list
	 */
	public abstract List<Cafe> cafeListTop3();
	
	/** 게시글 상세 조회 Service
	 * @param cafeNo
	 * @return cafe
	 */
	public abstract Cafe selectCafe(int cafeNo);

	/** 게시글에 포함된 이미지 목록 조회 Service
	 * @param cafeNo
	 * @return attachmentList
	 */
	public abstract List<CafeAttachment> selectAttachmentList(int cafeNo);

	/** 게시글 삽입 (+ 파일 업로드) Service
	 * @param map
	 * @param images
	 * @param savePath
	 * @return result
	 */
	public abstract int insertCafe(Map<String, Object> map, List<MultipartFile> images, String savePath);
	
	/** summernote 업로드 이미지 저장 Service
	 * @param uploadFile
	 * @param savePath
	 * @return at
	 */
	public abstract CafeAttachment insertImage(MultipartFile uploadFile, String savePath);

	/** 게시글 삭제 Service
	 * @param cafe
	 * @return result
	 */
	public abstract int deleteCafe(Cafe cafe);

	/** 게시글 수정 Service
	 * @param updateCafe
	 * @return result
	 */
	public abstract int updateCafe(Cafe updateCafe);

	/** 좋아요 목록 조회 Service
	 * @param memberNo
	 * @return
	 */
	public abstract List<CafeLike> selectLike(int memberNo);

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
	public abstract int insertCafeReport(Map<String, Object> map);

	
	
	
	
	
	
	
	
	
	
	
	/** 관리자(admin) 삭제된 게시글 상세조회 Service
	 * @param cafeNo
	 * @return
	 */
	public abstract Cafe selectDeleteCafe(int cafeNo);

	
}
