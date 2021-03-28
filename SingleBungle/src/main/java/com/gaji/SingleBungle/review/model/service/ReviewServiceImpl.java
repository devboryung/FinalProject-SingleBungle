package com.gaji.SingleBungle.review.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.findFriend.exception.InsertAttachmentFailException;
import com.gaji.SingleBungle.review.model.dao.ReviewDAO;
import com.gaji.SingleBungle.review.model.vo.Review;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewLike;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;
import com.gaji.SingleBungle.review.model.vo.ReviewReply;
import com.gaji.SingleBungle.review.model.vo.ReviewSearch;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAO dao;

	// 전제 게시글 수 조회 Service 구현
	@Override
	public ReviewPageInfo getPageInfo(int cp) {

		int listCount = dao.getListCount();

		return new ReviewPageInfo(cp, listCount, 2);
	}

	// 게시글 목록 조회 Service 구현
	@Override
	public List<Review> selectList(ReviewPageInfo pInfo) {
		return dao.selcetList(pInfo);
	}

	// 썸네일 목록 조회
	@Override
	public List<ReviewAttachment> selectThumbnailList(List<Review> rList) {
		return dao.selectThumbnailList(rList);
	}
	
	


	
	
	
	// 상세조회
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Review selectReview(int boardNo) {

		Review review = dao.selectReview(boardNo);

		if (review != null) {
			int result = dao.increaseReadCount(boardNo);

			if (result > 0) {
				review.setReadCount(review.getReadCount() + 1);
			}
		}
		return review;
	}
	
	

	

	// 조회수 상위 3 게시글 조회
	@Override
	public List<Review> reviewListTop3() {
		return dao.reviewListTop3();
	}

	
	
	
	//  좋아요 목록 조회
	@Override
	public List<ReviewLike> selectLike(int memberNo) {
		return dao.selectLike(memberNo);
	}
	
	
	
	// 좋아요 수 증가
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int increaseLike(Map<String, Object> map) {
		return dao.increaseLike(map);
	}
	
	
	// 좋아요 수 감소
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int decreaseLike(Map<String, Object>map) {
		return dao.decreaseLike(map);
	}
	
	
	// 좋아요 여부
	@Override
	public int selectLikePushed(Map<String, Integer> map) {
		return dao.selectLikePushed(map);
	}
	

	
	
	
	
	// 게시글 등록
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReview(Map<String, Object> map, String savePath) {
		int result = 0; // 결과 저장

		// 게시글 번호 얻어오기
		int boardNo = dao.selectNextNo();

		System.out.println(boardNo);

		System.out.println(map.get(boardNo));
		// 게시글 삽입
		if (boardNo > 0) {
			map.put("boardNo", boardNo);

			result = dao.insertBoard(map);

			if (result > 0) {

				List<ReviewAttachment> uploadImages = new ArrayList<ReviewAttachment>();

				String filePath = "/resources/reviewBoardImages";

				Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");

				// SummerNote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
				Matcher matcher = pattern.matcher((String) map.get("boardContent"));

				String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
				String src = null; // src 속성값을 저장할 임시 참조 변수
				int fileLevel = 1;

				while (matcher.find()) {
					src = matcher.group(1);

					filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/"));

					fileName = src.substring(src.lastIndexOf("/") + 1); // 업로드된 파일명만 잘라서 별도로 저장

					ReviewAttachment at = new ReviewAttachment(filePath, fileName, fileLevel, boardNo);

					uploadImages.add(at);
					fileLevel++;
				}

				if (!uploadImages.isEmpty()) {

					// 파일 정보 삽입 DAO 호출
					result = dao.insertAttachmentList(uploadImages);

					if (result == uploadImages.size()) {

						result = boardNo;

					} else { // 파일 정보를 DB에 삽입 실패
						throw new InsertAttachmentFailException("파일 정보 DB삽입 실패");
					}
				} else {// 업로드된 이미지가 없을 경우
					result = boardNo;
				}
			}
		}
		return result;
	}

	// summernote에 업로드된 이미지 저장
	@Override
	public ReviewAttachment insertImage(MultipartFile uploadFile, String savePath) {

		// 중복을 방지하기 위해, 파일명 변경해 줌
		String fileName = rename(uploadFile.getOriginalFilename());

		// 웹 상 접근 주소
		String filePath = "/resources/reviewBoardImages";

		// 돌려 보내줄 파일 정보를 Attachment 객체에 담아서 전달.
		ReviewAttachment at = new ReviewAttachment();
		at.setFilePath(filePath);
		at.setFileName(fileName);

		// 서버에 파일 저장(transferTo())

		try {
			uploadFile.transferTo(new File(savePath + "/" + fileName));
		} catch (Exception e) {
			e.printStackTrace();

			throw new InsertAttachmentFailException("summerote 파일 업로드 실패");
		}

		return at;
	}

	// 파일명 변경 메소드
	public String rename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성

		String str = "_" + String.format("%05d", ranNum);
		// String.format : 문자열을 지정된 패턴의 형식으로 변경하는 메소드
		// %05d : 오른쪽 정렬된 십진 정수(d) 5자리(5)형태로 변경. 빈자리는 0으로 채움(0)

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;
	}
	
	
	

	// 게시글 수정
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReview(Review updateReview, String savePath) {

		int result = dao.updateReview(updateReview);

		if (result > 0) {
			
			// 수정 전 파일을 모아두는 list
			List<ReviewAttachment> oldFiles = dao.selectAttachmentList(updateReview.getBoardNo());
			
			// 삭제 되어야할 파일 정보를 담을 리스트
			List<ReviewAttachment> removeFileList = new ArrayList<ReviewAttachment>();


			// DB에 저장할 웹 상 이미지 접근 경로
			String filePath = "/resources/reviewBoardImages";

			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");

			Matcher matcher = pattern.matcher(updateReview.getBoardContent());

			List<String> fileNameList = new ArrayList<String>();

			String src = null;
			String fileName = null;

			while (matcher.find()) {
				src = matcher.group(1);
				fileName = src.substring(src.lastIndexOf("/") + 1);
				fileNameList.add(fileName);
			}

			// DB에 새로 추가할 이미지파일 정보를 모아둘 List생성
			List<ReviewAttachment> newAttachmentList = new ArrayList<ReviewAttachment>();

			// DB에서 삭제할 이미지파일 번호를 모아둘 List 생성
			List<Integer> deleteFileNoList = new ArrayList<Integer>();
			
			
			// 기존에 올려둔 파일 전부 삭제
			for(ReviewAttachment oldAt : oldFiles) {
				deleteFileNoList.add(oldAt.getFileNo());
			}
			if(!deleteFileNoList.isEmpty()) { // 삭제할 이미지가 있다면
				result = dao.deleteAttachmentList(deleteFileNoList);
				
				if(result != deleteFileNoList.size()) {
					throw new InsertAttachmentFailException("파일 수정 실패(파일 정보 삭제 중 오류 발생)");
				}
			}
			
			
			// 새로운 파일 전부 등록
			// 파일 레벨 
			int fileLevel = 1;
			
			for (String fName : fileNameList) {
				ReviewAttachment at = new ReviewAttachment(filePath, fName, fileLevel, updateReview.getBoardNo());
				newAttachmentList.add(at);
				fileLevel++;
			}
			
			if(!newAttachmentList.isEmpty()) {
				result = dao.insertAttachmentList(newAttachmentList);
				
				if(result != newAttachmentList.size()) {
					
					throw new InsertAttachmentFailException("파일 수정 실패(파일 정보 삽입 중 오류 발생)");
					
				}
			}
		}
		return result;
	}

	
	
	// 게시글 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReview(Review review) {

		return dao.deleteReview(review);
	}
	
	
	
	//검색 조건이 포함된 페이징 처리 객체 생성 Service 구현
	@Override
	public ReviewPageInfo getSearchPageInfo(ReviewSearch rSearch, int cp) {
		
		// 검색 조건에 맞는 게시글 수 조회
		int listCount = dao.getSearchListCount(rSearch);
		
		return new ReviewPageInfo(cp, listCount, '2');
	}

	
	// 검색 조건이 포함된 게시글 목록 조회 Service 구현
	@Override
	public List<Review> selectSearchList(ReviewSearch rSearch, ReviewPageInfo pInfo) {
		return dao.selectSearchList(rSearch,pInfo);
	}

	
	// 게시글 신고 등록
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReviewReport(Map<String, Object> map) {
		
		int result = 0;
		
		int reportNo = dao.selectReportNo();
		
		if(reportNo>0) {
			
			map.put("reportNo", reportNo);
			
			String reportTitle = (String)map.get("reportTitle");
			String reportContent = (String)map.get("reportContent");
			
			reportTitle = replaceParameter(reportTitle);
			reportContent = replaceParameter(reportContent);
			
			map.put("reportTitle", reportTitle);
			map.put("reportContent", reportContent);			
		}
		
		result = dao.insertReviewReport(map);
		if(result > 0) {
			
			result = reportNo;
		}
		
		return result;
	}
	
	
	   // 크로스 사이트 스크립트 방지 처리 메소드
	   private String replaceParameter(String param) {
	      String result = param;
	      if(param != null) {
	         result = result.replaceAll("&", "&amp;");
	         result = result.replaceAll("<", "&lt;");
	         result = result.replaceAll(">", "&gt;");
	         result = result.replaceAll("\"", "&quot;");
	      }
	         
	      return result;
	   }	
	
//------------------------------------------------------------------------------

	//관리자 삭제된 게시글 상세조회
	@Override
	public Review selectDeleteReview(int boardNo) {
		
		return dao.selectDeleteReview(boardNo);
	}









}
