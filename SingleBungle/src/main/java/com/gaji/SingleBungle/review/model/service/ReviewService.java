package com.gaji.SingleBungle.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.review.model.vo.Review;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewLike;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;
import com.gaji.SingleBungle.review.model.vo.ReviewReply;
import com.gaji.SingleBungle.review.model.vo.ReviewSearch;

public interface ReviewService {

	/** 전체 게시글 수 조회 Service
	 * @param cp
	 * @return pInfo
	 */
	ReviewPageInfo getPageInfo(int cp);
	
	

	/** 게시글 목록 조회 Service
	 * @param pInfo
	 * @return rList
	 */
	List<Review> selectList(ReviewPageInfo pInfo);

	
	
	/** 게시글 썸네일 조회
	 * @param rList
	 * @return thList
	 */
	List<ReviewAttachment> selectThumbnailList(List<Review> rList);
	
	
	
	
	
	/** 게시글 상세 조회
	 * @param boardNo
	 * @return review
	 */
	Review selectReview(int boardNo);
	

	
	/** 조회수 상위 3 게시글 조회
	 * @return list
	 */
	List<Review> reviewListTop3();
	
	

	/** 좋아요 목록 조회
	 * @param memberNo
	 * @return
	 */
	List<ReviewLike> selectLike(int memberNo);
	
	
	
	
	/** 좋아요 증가
	 * @param map
	 * @return result
	 */
	int increaseLike(Map<String, Object> map);
	
	
	
	
	/** 좋아요 감소
	 * @param map
	 * @return result
	 */
	int decreaseLike(Map<String, Object> map);









	/** 게시글 등록 _+ 파일 업로드 Service
	 * @param map
	 * @param images
	 * @param savePath
	 * @return result
	 */
	int insertReview(Map<String, Object> map, String savePath);



	/** summernote에 업로드된 이미지 저장
	 * @param uploadFile
	 * @param savePath
	 * @return at
	 */
	ReviewAttachment insertImage(MultipartFile uploadFile, String savePath);

	/** 게시글 수정
	 * @param updateReview
	 * @param savePath
	 * @return result
	 */
	int updateReview(Review updateReview, String savePath);


	/** 게시글 삭제
	 * @param review
	 * @return result
	 */
	int deleteReview(Review review);



	/** 검색 조건이 포함된 페이징 처리 객체 생성 Service
	 * @param rSearch
	 * @param cp
	 * @return listCount
	 */
	ReviewPageInfo getSearchPageInfo(ReviewSearch rSearch, int cp);


 
	/** 검색 조건이 포함된 게시글 목록 조회 Service
	 * @param rSearch
	 * @param pInfo
	 * @return rList
	 */
	List<Review> selectSearchList(ReviewSearch rSearch, ReviewPageInfo pInfo);



	/** 좋아요 여부 확인
	 * @param map
	 * @return
	 */
	int selectLikePushed(Map<String, Integer> map);

	
	
	/** 게시글 신고
	 * @param map
	 * @return result
	 */
	int insertReviewReport(Map<String, Object> map);
	
	
	
//------------------------------------------------------------------------------

	/**	관리자 삭제된 게시글 상세조회
	 * @param boardNo
	 * @return
	 */
	Review selectDeleteReview(int boardNo);
















	








}
