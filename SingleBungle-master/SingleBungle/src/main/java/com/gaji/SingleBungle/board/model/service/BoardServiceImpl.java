package com.gaji.SingleBungle.board.model.service;

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

import com.gaji.SingleBungle.board.model.dao.BoardDAO;
import com.gaji.SingleBungle.board.model.exception.BoardInsertAttachmentFailException;
import com.gaji.SingleBungle.board.model.vo.Board;
import com.gaji.SingleBungle.board.model.vo.BoardAttachment;
import com.gaji.SingleBungle.board.model.vo.BoardLike;
import com.gaji.SingleBungle.board.model.vo.BoardPageInfo;
import com.gaji.SingleBungle.board.model.vo.BoardSearch;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;

	// 페이징 처리  Service 구현
	@Override
	public BoardPageInfo getPageInfo(int cp) {
		
		int listCount = dao.getListCount();
		
		return new BoardPageInfo(cp, listCount, 1);
	}

	// 게시글 목록 조회 Service 구현
	@Override
	public List<Board> selectList(BoardPageInfo bpInfo) {
		return dao.selectList(bpInfo);
	}
	
	// 게시글 검색 목록 페이징 Service 구현
	@Override
	public BoardPageInfo getSearchPageInfo(BoardSearch bSearch, int cp) {
		
		int listCount = dao.getSearchListCount(bSearch);
				
		return new BoardPageInfo(cp, listCount, '1');
	}

	// 게시글 검색 목록 조회 Service 구현
	@Override
	public List<Board> selectSearchList(BoardSearch bSearch, BoardPageInfo bpInfo) {
		return dao.selectSearchList(bSearch, bpInfo);
	}

	// 게시글 상세 조회 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Board selectBoard(int boardNo) {

		Board temp = new Board();
		temp.setBoardNo(boardNo);
		
		Board board = dao.selectBoard(temp);
		
		if(board != null) {
			int result = dao.increaseReadCount(boardNo);
			
			if(result > 0) {
				board.setReadCount(board.getReadCount() + 1);
			}
		}
				
		return board;
	}

	// 게시글에 포함된 이미지 목록 조회 Service 구현
	@Override
	public List<BoardAttachment> selectAttachmentList(int boardNo) {
		return dao.selectAttachmentList(boardNo);
	}
	
	
	// summernote 업로드 이미지 저장 Service 구현
	@Override
	public BoardAttachment insertImage(MultipartFile uploadFile, String savePath) {
		
		String fileName = rename(uploadFile.getOriginalFilename());
		
		String filePath = "/resources/boardImages";
		
		BoardAttachment at = new BoardAttachment();
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
	
   // 파일명 변경 메소드
   public String rename(String originFileName) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
      String date = sdf.format(new java.util.Date(System.currentTimeMillis()));
         
      int ranNum = (int)(Math.random()*100000);
         
      String str = "_" + String.format("%05d", ranNum);
         
      String ext = originFileName.substring(originFileName.lastIndexOf("."));
         
      return date + str + ext;
      }

	// 게시글 삽입 Service 구현
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertBoard(Map<String, Object> map, List<MultipartFile> images, String savePath) {
		
		int result = 0;
		
		int boardNo = dao.selectNextNo();
		
		if(boardNo > 0) {
			map.put("boardNo", boardNo);
			
			result = dao.insertBoard(map);
			
            // 게시글 삽입 성공 시 이미지 정보 삽입
            if(result > 0) {
            	
            	List<BoardAttachment> uploadImages = new ArrayList<BoardAttachment>();
            	
            	String filePath = null;
            	
            	filePath = "/resources/boardImages";

            // ---------------------------------------------------- summernote
				Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); //img 태그 src 추출 정규표현식
				
				// SummerNote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
				Matcher matcher = pattern.matcher((String)map.get("boardContent"));     
				 
				String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
				String src = null; // src 속성값을 저장할 임시 참조 변수
				int fileLevel = 1;
				
				// matcher.find() : Matcher 객체에 저장된 값(검사를 통해 매칭된 src 속성 값)에 반복 접근하여 값이 있을 경우 true 
				while(matcher.find()){
					src =  matcher.group(1); // 매칭된 src 속성값을  Matcher 객체에서 꺼내서 src에 저장 
					
					filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/")); // 파일명을 제외한 경로만 별도로 저장.
					
					fileName = src.substring(src.lastIndexOf("/") + 1); // 업로드된 파일명만 잘라서 별도로 저장.
					
					// Attachment 객체를 이용하여 DB에 파일 정보를 저장
					BoardAttachment at = new BoardAttachment(filePath, fileName, fileLevel, boardNo);
					uploadImages.add(at);
					fileLevel++;
				}

            if(!uploadImages.isEmpty()) { // 업로드된 이미지가 있을 경우
               // 파일 정보 삽입 DAO 호출
               result = dao.insertAttachmentList(uploadImages);
               // result == 삽입된 행의 개수
               
               // 모든 데이터가 정상 삽입 되었을 경우 --> 서버에 파일 저장
               if(result == uploadImages.size()) {
                  result = boardNo; // result에 boardNo 저장

				} else {
					throw new BoardInsertAttachmentFailException("파일 정보 DB 삽입 실패");
				}

			} else { // 업로드된 이미지가 없을 경우
				result = boardNo;
			}
		}
	}

	return result;
}
	
	// 게시글 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateBoard(Board updateBoard) {
	
		int result = dao.updateBoard(updateBoard);
	
		if (result > 0) {
	
			List<BoardAttachment> oldFiles = dao.selectAttachmentList(updateBoard.getBoardNo());
	
			String filePath = "/resources/boardImages";
	
			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); // img 태그 src 추출 정규표현식
	
			// 게시글에 작성된 <img> 태그의 src 속성을 이용해서 파일명을 얻어오기
			Matcher matcher = pattern.matcher(updateBoard.getBoardContent());
	
			// 정규식을 통해 게시글에 작성된 이미지 파일명만 얻어와 모아둘 List 선언
			List<String> fileNameList = new ArrayList<String>();
	
			String src = null; // matcher에 저장된 src를 꺼내서 임시 저장할 변수
			String fileName = null; // src에서 파일명을 추출해서 임시 저장할 변수
	
			while (matcher.find()) {
				src = matcher.group(1); // /spring/board/resources/infoImages/abc.jpg
				fileName = src.substring(src.lastIndexOf("/") + 1); // abc.jpg
				fileNameList.add(fileName);
			}
	
			// DB에 새로 추가할 이미지파일 정보를 모아둘 List 생성
			List<BoardAttachment> newAttachmentList = new ArrayList<BoardAttachment>();
	
			// DB에 삭제할 이미지 파일 번호를 모아둘 List 생성
			List<Integer> deleteFileNoList = new ArrayList<Integer>();
	
			// 수정된 게시글 파일명 목록(fileNameList)과
			// 수정 전 파일 정보 목록(oldFiles)를 비교해서
			// 수정된 게시글 파일명 하나를 기준으로 하여 수정 전 파일명과 순차적으로 비교를 진행
			// --> 수정된 게시글 파일명과 일치하는 수정 전 파일명이 없다면
			// == 새로 삽입된 이미지임을 의미함.
			for (String fName : fileNameList) {
	
				boolean flag = true;
	
				for (BoardAttachment oldAt : oldFiles) {
					if (fName.equals(oldAt.getFileName())) { // 수정 후 / 수정 전 같은 파일이 있다 == 이미지가 수정되지 않았다.
						flag = false;
						break;
					}
				}
	
				// flag == true == 수정 후 게시글 파일명과 수정 전 게시글 파일명이 일치하는게 없을 경우
				// == 새로운 이미지 --> newAttachmentList 추가
				if (flag) {
					BoardAttachment at = new BoardAttachment(filePath, fName, 1, updateBoard.getBoardNo());
					newAttachmentList.add(at);
				}
			}
	
			// 수정된 게시글 파일명 목록(oldFiles)과
			// 수정 전 파일 정보 목록(fileNameList)를 비교해서
			// 수정 전 파일명 하나를 기준으로 하여 수정 후 파일명과 순차적으로 비교를 진행
			// --> 수정 전 게시글 파일명과 일치하는 수정 후 파일명이 없다면
			// == 기존 수정 전 이미지가 삭제됨을 의미.
	
			for (BoardAttachment oldAt : oldFiles) {
	
				boolean flag = true;
	
				for (String fName : fileNameList) {
	
					if (oldAt.getFileName().equals(fName)) {
						flag = false;
						break;
					}
				}
	
				// flag == true == 수정 전 파일명과 수정 후 파일명이 일치하는게 없을 경우
				// == 삭제된 이미지 --> deleteFileNoList 추가
				if (flag) {
					deleteFileNoList.add(oldAt.getFileNo());
				}
			}
	
			// newAttachmentList / deleteFileNoList 완성됨
	
			if (!newAttachmentList.isEmpty()) { // 새로 삽입된 이미지가 있다면
				result = dao.insertAttachmentList(newAttachmentList);
	
				if (result != newAttachmentList.size()) { // 삽입된 결과행의 수와 삽입을 수행한 리스트 수가 맞지 않을 경우 == 실패
					throw new BoardInsertAttachmentFailException("파일 수정 실패(파일 정보 삽입중 오류 발생)");
				}
			}
	
			if (!deleteFileNoList.isEmpty()) { // 삭제할 이미지가 있다면
				result = dao.deleteAttachmentList(deleteFileNoList);
	
				if (result != deleteFileNoList.size()) {
					throw new BoardInsertAttachmentFailException("파일 삭제 실패(파일 정보 삭제중 오류 발생)");
				}
			}
	
		}
	
		return result;
	}
   		
   		

   	// 게시글 삭제 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteBoard(Board board) {
		return dao.deleteBoard(board);
	}

	// 좋아요 목록 조회 Service 구현
	@Override
	public List<BoardLike> selectLike(int memberNo) {
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

	// 신고 게시글 등록 Service 구현
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertBoardReport(Map<String, Object> map) {
		
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
				
		result = dao.insertBoardReport(map);
			
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
	public Board selectDeleteBoard(int boardNo) {
		return dao.selectDeleteBoard(boardNo);
	}







   

}