package com.gaji.SingleBungle.cafe.model.service;

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

import com.gaji.SingleBungle.board.model.exception.BoardInsertAttachmentFailException;
import com.gaji.SingleBungle.cafe.model.dao.CafeDAO;
import com.gaji.SingleBungle.cafe.model.vo.Cafe;
import com.gaji.SingleBungle.cafe.model.vo.CafeAttachment;
import com.gaji.SingleBungle.cafe.model.vo.CafeLike;
import com.gaji.SingleBungle.cafe.model.vo.CafePageInfo;
import com.gaji.SingleBungle.cafe.model.vo.CafeSearch;

@Service
public class CafeServiceImpl implements CafeService {
	
	@Autowired
	private CafeDAO dao;

	// 페이징 처리 객체 생성 Service 구현
	@Override
	public CafePageInfo getPageInfo(int cp) {
		int listCount = dao.getListCount();
		return new CafePageInfo(cp, listCount);
	}

	// 게시글 목록 조회 Service 구현
	@Override
	public List<Cafe> selectList(CafePageInfo cpInfo) {
		return dao.selectList(cpInfo);
	}

	// 썸네일 목록 조회 Service 구현
	@Override
	public List<CafeAttachment> selectThumbnailList(List<Cafe> cList) {
		return dao.selectThumbnailList(cList);
	}
	
	// 게시글 검색 목록 페이징 Service 구현
	@Override
	public CafePageInfo getSearchPageInfo(CafeSearch cSearch, int cp) {
		
		int listCount = dao.getSearchListCount(cSearch);
		
		return new CafePageInfo(cp, listCount);
	}

	// 게시글 검색 목록 조회 Service 구현
	@Override
	public List<Cafe> selectSearchList(CafeSearch cSearch, CafePageInfo cpInfo) {
		return dao.selectSearchList(cSearch, cpInfo);
	}

	// 조회수 상위 3 게시글 조회 Service 구현
	@Override
	public List<Cafe> cafeListTop3() {
		return dao.cafeListTop3();
	}
	
	// 게시글 상세 조회 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Cafe selectCafe(int cafeNo) {
		
		Cafe temp = new Cafe();
		temp.setCafeNo(cafeNo);
		
		Cafe cafe = dao.selectCafe(temp);
		
		if(cafe != null) {
			int result = dao.increaseReadCount(cafeNo);
			
			if(result > 0) {
				cafe.setReadCount(cafe.getReadCount() + 1);
			}
		}
		
		return cafe;
	}

	// 게시글에 포함된 이미지 목록 조회 Service 구현
	@Override
	public List<CafeAttachment> selectAttachmentList(int cafeNo) {
		return dao.selectAttachmentList(cafeNo);
	}

	// 게시글 삽입 Service 구현
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertCafe(Map<String, Object> map, List<MultipartFile> images, String savePath) {
		
		int result = 0;
		
		int cafeNo = dao.selectNextNo();
		
		if (cafeNo > 0) {
			map.put("cafeNo", cafeNo);

			result = dao.insertBoard(map);

			if (result > 0) {

				List<CafeAttachment> uploadImages = new ArrayList<CafeAttachment>();

				String filePath = null;

				filePath = "/resources/cafeImages";

				Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); // img 태그 src 추출 정규표현식

				Matcher matcher = pattern.matcher((String)map.get("cafeContent"));

				String fileName = null;
				String src = null;
				int fileLevel = 1;

				while (matcher.find()) {
					src = matcher.group(1);

					filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/"));

					fileName = src.substring(src.lastIndexOf("/") + 1);

					CafeAttachment at = new CafeAttachment(filePath, fileName, fileLevel, cafeNo);
					uploadImages.add(at);
					fileLevel++;
				}

				if (!uploadImages.isEmpty()) { // 업로드된 이미지가 있을 경우

					result = dao.insertAttachmentList(uploadImages);

					if (result == uploadImages.size()) {
						result = cafeNo;

					} else {
						throw new BoardInsertAttachmentFailException("파일 정보 DB 삽입 실패");
					}

				} else { // 업로드된 이미지가 없을 경우
					result = cafeNo;
				}
			}
		}

		return result;
	}
	
	   // 파일명 변경 메소드
	   public String rename(String originFileName) {
	      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	      String date = sdf.format(new java.util.Date(System.currentTimeMillis()));
	         
	      int ranNum = (int)(Math.random()*100000); // 5자리 랜덤 숫자 생성
	         
	      String str = "_" + String.format("%05d", ranNum);
	      //String.format : 문자열을 지정된 패턴의 형식으로 변경하는 메소드
	      // %05d : 오른쪽 정렬된 십진 정수(d) 5자리(5)형태로 변경. 빈자리는 0으로 채움(0)
	         
	      String ext = originFileName.substring(originFileName.lastIndexOf("."));
	         
	      return date + str + ext;
	      }
	   
	// summernote 업로드 이미지 저장 Service 구현
	@Override
	public CafeAttachment insertImage(MultipartFile uploadFile, String savePath) {
		
		String fileName = rename(uploadFile.getOriginalFilename());
		
		String filePath = "/resources/cafeImages";
		
		CafeAttachment at = new CafeAttachment();
		at.setFilePath(filePath);
		at.setFileName(fileName);
		
		try {
			uploadFile.transferTo( new File( savePath + "/" + fileName ) );
		} catch (Exception e) {
			e.printStackTrace();
			
			throw new BoardInsertAttachmentFailException("summernote 파일 업로드 실패");
		}
		
		return at;
	}
	
	
	// 게시글 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateCafe(Cafe updateCafe) {
		
		int result = dao.updateCafe(updateCafe);
		
		if (result > 0) {
			
			List<CafeAttachment> oldFiles = dao.selectAttachmentList(updateCafe.getCafeNo());

			String filePath = "/resources/cafeImages";
	
			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
	
			Matcher matcher = pattern.matcher(updateCafe.getCafeContent());
	
			List<String> fileNameList = new ArrayList<String>();
	
			String src = null;
			String fileName = null;
	
			while (matcher.find()) {
				src = matcher.group(1);
				fileName = src.substring(src.lastIndexOf("/") + 1);
				fileNameList.add(fileName);
			}
	
			// DB에 새로 추가할 이미지파일 정보를 모아둘 List 생성
			List<CafeAttachment> newAttachmentList = new ArrayList<CafeAttachment>();
	
			// DB에 삭제할 이미지 파일 번호를 모아둘 List 생성
			List<Integer> deleteFileNoList = new ArrayList<Integer>();
	
			// 기존에 올려둔 파일 전부 삭제
			for(CafeAttachment oldAt : oldFiles) {
				deleteFileNoList.add(oldAt.getFileNo());
			}
			if(!deleteFileNoList.isEmpty()) { // 삭제할 이미지가 있다면
				result = dao.deleteAttachmentList(deleteFileNoList);
				
				if(result != deleteFileNoList.size()) {
					throw new BoardInsertAttachmentFailException("파일 수정 실패(파일 정보 삭제 중 오류 발생)");
				}
			}
			
			
			// 새로운 파일 전부 등록
			// 파일 레벨 
			int fileLevel = 1;
			
			for (String fName : fileNameList) {
				CafeAttachment at = new CafeAttachment(filePath, fName, fileLevel, updateCafe.getCafeNo());
				newAttachmentList.add(at);
				fileLevel++;
			}
			
			if(!newAttachmentList.isEmpty()) {
				result = dao.insertAttachmentList(newAttachmentList);
				
				if(result != newAttachmentList.size()) {
					
					throw new BoardInsertAttachmentFailException("파일 수정 실패(파일 정보 삽입 중 오류 발생)");
					
				}
			}
	
		}
	
		return result;
	}
	

	// 게시글 삭제 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteCafe(Cafe cafe) {
		return dao.deleteCafe(cafe);
	}

	// 좋아요 목록 조회 Service 구현
	@Override
	public List<CafeLike> selectLike(int memberNo) {
		return dao.selectLike(memberNo);
	}

	// 좋아요 증가 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int increaseLike(Map<String, Object> map) {
		return dao.increaseLike(map);
	}

	// 좋아요 감소 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int decreaseLike(Map<String, Object> map) {
		return dao.decreaseLike(map);
	}

	// 좋아요 여부 확인 Service 구현
	@Override
	public int selectLikePushed(Map<String, Integer> map) {
		return dao.selectLikePushed(map);
	}

	
	// 신고 등록 Service 구현
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertCafeReport(Map<String, Object> map) {
		
		int result = 0;
		
		int reportNo = dao.selectReportNo();
		
		if(reportNo > 0) {
			map.put("reportNo", reportNo);
			
			String reportTitle = (String)map.get("reportTitle");
			String reportContent = (String)map.get("reportContent");
			
			reportTitle = replaceParameter(reportTitle);
			reportContent = replaceParameter(reportContent);
			
			map.put("reportTitle", reportTitle);
			map.put("reportContent", reportContent);
			
		}
				
		result = dao.insertCafeReport(map);
			
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
   
   
   
   
   
   
   
   
    // 관리자(admin) 삭제된 게시글 상세조회 Service 구현
	@Override
	public Cafe selectDeleteCafe(int cafeNo) {
		return dao.selectDeleteCafe(cafeNo);
	}



}
