package com.gaji.SingleBungle.findFriend.model.service;

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
import com.gaji.SingleBungle.findFriend.model.dao.FindFriendDAO;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendAttachment;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendChatting;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriend;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendPageInfo;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendSearch;

@Service
public class FindFriendServiceImpl implements FindFriendService {

	@Autowired
	private FindFriendDAO dao;
	
	// 게시글 목록 페이징처리 Service 구현
	@Override
	public FindFriendPageInfo getPageInfo(int cp) {
		
		// 전체 게시글 수 조회
		int listCount = dao.getListCount();
		
		return new FindFriendPageInfo(cp, listCount);
	}
	
	// 게시글 목록 조회 Service 구현
	@Override
	public List<FindFriend> selectList(FindFriendPageInfo pInfo) {
		return dao.selectList(pInfo);
	}
	
	// 게시글 검색 목록 페이징처리 Service 구현
	@Override
	public FindFriendPageInfo getSearchPageInfo(FindFriendSearch fSearch, int cp) {
		
		// 검색 게시글 수 조회
		int listCount = dao.getSearchListCount(fSearch);
		
		return new FindFriendPageInfo(cp, listCount);
	}

	// 게시글 검색 목록 조회 Service 구현
	@Override
	public List<FindFriend> selectSearchList(FindFriendSearch fSearch, FindFriendPageInfo pInfo) {
		return dao.selectSearchList(fSearch, pInfo);
	}
	
	// 친구찾기 게시글 상세 조회 Service 구현
	@Override
	public FindFriend selectBoard(int friendNo) {
		
		// 1) 게시글 상세 조회
		FindFriend findFriend = dao.selectBoard(friendNo);
		
		// 2) 상세 조회 성공 시 조회수 증가
		if( findFriend != null ) {
			int result = dao.increaseReadCount(friendNo);
			
			if(result > 0) {
				findFriend.setReadCount(findFriend.getReadCount() + 1);
			}
		}
		
		return findFriend;
	}
	
	// 게시글에 포함된 이미지 목록 조회 Service 구현
	@Override
	public List<FindFriendAttachment> selectAttachmentList(int friendNo) {
		return dao.selectAttachmentList(friendNo);
	}


	// summernote 업로드 이미지 저장 Service 구현
	@Override
	public FindFriendAttachment inserImage(MultipartFile uploadFile, String savePath) {

		// 파일명 변경
		String fileName = rename(uploadFile.getOriginalFilename());

		// 웹상 접근 주소
		String filePath = "/resources/findFriendImages/";

		// 돌려 보내줄 파일 정보를 Attachment 객체에 담아서 전달.
		FindFriendAttachment at = new FindFriendAttachment();
		at.setFileName(fileName);
		at.setFilePath(filePath);

		// 서버에 파일 저장(transferTo())
		try {
			uploadFile.transferTo(new File(savePath + "/" + fileName));
		} catch (Exception e) {
			e.printStackTrace();

			throw new InsertAttachmentFailException("summernote 파일 업로드 실패");
		}

		return at;
	}

	// 파일명 변경 메소드
	public String rename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000);

		String str = "_" + String.format("%05d", ranNum);

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;

	}
	
	// 상세 조회 시 참여신청 여부 확인 Service 구현
	@Override
	public int checkApply(Map<String, Object> map) {
		return dao.checkApply(map);
	}
	
	// 친구찾기 참여 신청 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertApply(Map<String, Object> map) {
		return dao.insertApply(map);
	}
	
	// 친구찾기 참여 취소 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteApply(Map<String, Object> map) {
		return dao.deleteApply(map);
	}
	
	// 친구찾기 참여인원 카운트 Service 구현
	@Override
	public int selectApplyCount(int friendNo) {
		return dao.selectApplyCount(friendNo);
	}
	
	// 친구찾기  게시글 신고 등록 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertFindFriendReport(Map<String, Object> map) {
		
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
		
		result = dao.insertFindFriendReport(map);
		
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

	// 친구찾기 게시글 등록(+ 파일 업로드) Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(FindFriend findFriend, String savePath) {
		// 최종 결과 저장 변수 선언
		int result = 0;

		// 1) 다음 게시글 번호 얻어오기
		int nextBoardNo = dao.selectNextBoardNo();

		// 2) 게시글 삽입
		if (nextBoardNo > 0) { // 다음 게시글 번호를 얻어온 경우
			findFriend.setFriendNo(nextBoardNo); // 다음 게시글 번호 세팅

			// 게시글 삽입
			result = dao.insertBoard(findFriend);

			// 3) 게시글 삽입 성공 시 이미지 정보 삽입
			if (result > 0) {

				// 이미지 정보를 Attachment객체에 저장 후 List에 추가
				List<FindFriendAttachment> uploadImages = new ArrayList<FindFriendAttachment>();

				// DB에 저장할 웹상 접근 주소(filePath)
				String filePath = "/resources/findFriendImages";

				Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); // img태그 src추출 정규표현식

				// summernote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
				Matcher matcher = pattern.matcher(findFriend.getFriendContent());

				String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
				String src = null; // src 속성값을 저장할 임시 참조 변수

				// matcher.find() : Matcher 객체에 저장된 값(검사를 통해 매핑된 src 속성 값)에 반복 접근하여 값이 잇을 경우
				// true
				while (matcher.find()) {
					src = matcher.group(1); // 매칭된 src 속성값을 Matcher 객체에서 꺼내서 src에 저장

					filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/")); // 파일명을 제외한 경로 별도 저장.

					fileName = src.substring(src.lastIndexOf("/") + 1); // 업로드된 파일명만 잘라서 별도로 저장.

					// Attachment 객체를 이용하여 DB에 파일 정보를 저장
					FindFriendAttachment at = new FindFriendAttachment(filePath, fileName, nextBoardNo);
					uploadImages.add(at);

				}

				if (!uploadImages.isEmpty()) { // 업로드 된 이미지가 있을 경우
					
					// 파일 정보 삽입
					result = dao.insertAttachmentList(uploadImages); // result == 삽입된 행의 개수
					
					if(result == uploadImages.size()) {
						result = nextBoardNo; // result에 nextBoardNo 저장
						
					}else { // 파일 정보를 DB에 삽입하는데 실패했을 때
						throw new InsertAttachmentFailException("파일 정보 DB 삽입 실패");
						
					}
					
				}else { // 업로드된 이미지가 없을 경우
					result = nextBoardNo;
				}
			}
		}

		return result;
	}

	// 친구찾기 게시글 수정 Service 수정
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateBoard(FindFriend updateBoard) {
		
		// 게시글 수정
		int result = dao.updateBoard(updateBoard);
		
		// 이미지 수정
		if(result > 0) {
			
			List<FindFriendAttachment> oldFiles = dao.selectAttachmentList(updateBoard.getFriendNo());
			
			List<FindFriendAttachment> uploadImages = new ArrayList<FindFriendAttachment>();
			
			List<FindFriendAttachment> removeFileList = new ArrayList<FindFriendAttachment>();
		
			// DB에 저장할 웹상 이미지 접근 경로
			String filePath = "/resources/findFriendImages";
		
			// summernote로 작성된 게시글에 있는 이미지 정보 수정
			//	-> 게시글 내부 <img> 태그의 src 속성을 얻어와 파일명을 얻어옴.
			//	-> 수정 전 게시글 이미지와 수정 후 게시글 이미지 파일명을 비교
			//	--> 새롭게 추가된 이미지, 기존 이미지에서 삭제된 것도 존재
			//	--> Attachment 테이블에 반영
			
			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); // img태그 src추출 정규표현식
			
			Matcher matcher = pattern.matcher(updateBoard.getFriendContent());
			
			List<String> fileNameList = new ArrayList<String>();
			
			String src = null; // matcher에 저장된 src를 꺼내서 임시 저장할 변수
			String fileName = null; // src에서 파일명을 추출해서 임시 저장할 변수
			
			while(matcher.find()) {
				src = matcher.group(1); // spring/findFriend/resources/findFriendImages/*.jpg
				fileName = src.substring(src.lastIndexOf("/") + 1); // *.jpg
				fileNameList.add(fileName);
			}
		
			// DB에 새로 추가할 이미지파일 정보를 모아둘 List 생성
			List<FindFriendAttachment> newAttachmentList = new ArrayList<FindFriendAttachment>();
		
			// DB에 삭제할 이미지 파일 번호를 모아둘 List 생성
			List<Integer> deleteFileNoList = new ArrayList<Integer>();
			
			// 수정 된 게시글 파일명 목록(fileNameList)과
			// 수정 전 파일 정보 목록(oldFiles)를 비교해서
			// 수정 된 게시글 파일명 하나를 기준으로 하여 수정 전 파일명과 순차적으로 비교를 진행
			// --> 수정 된 게시글 파일명과 일치하는 수정 전 파일명이 없다면
			//	== 새로 삽입된 이미지임을 의미
			for(String fName : fileNameList) {
				
				boolean flag = true;
				
				for(FindFriendAttachment oldAt : oldFiles) {
					
					if(fName.equals(oldAt.getFileName())) { // 이미지가 수정되지 않은 경우
						flag = false;
						break;
					}
				}
				
				// 새로 삽입된  이미지가 존재할 경우 -> newAttachmentList에 추가
				if(flag) {
					FindFriendAttachment at = new FindFriendAttachment(filePath, fName, updateBoard.getFriendNo());
					newAttachmentList.add(at);
				}
				
			}
			
			// 수정 전 게시글 파일명 목록(oldFiles)과
			// 수정 된  파일명 목록(fileNameList)를 비교해서
			// 수정 전 게시글 파일명 하나를 기준으로 하여 수정 전 파일명과 순차적으로 비교를 진행
			// --> 수정 전 게시글 파일명과 일치하는 수정 후 파일명이 없다면
			//	== 기존 수정 전 이미지가 삭제됨을 의미
			for(FindFriendAttachment oldAt : oldFiles) {
				
				boolean flag = true;
				
				for(String fName : fileNameList) {
					
					if(oldAt.getFileName().equals(fName)) {
						flag = false;
						break;
					}
					
				}
				
				// 삭제된  이미지가 존재할 경우 -> deleteFileNoList에 추가
				if(flag) {
					deleteFileNoList.add(oldAt.getFileNo());
				}
			}
			
			// newAttachmentList / deleteFileNoList 완성됨
			if(!newAttachmentList.isEmpty()) { // 새로 삽입된 이미지가 있다면
				result = dao.insertAttachmentList(newAttachmentList);
				
				if(result != newAttachmentList.size()) { // 삽입된 결과 행의 수와 삽입을 수행한 리스트 수가 맞지 않을 경우 == 실패
					throw new InsertAttachmentFailException("파일 수정 실패(파일 정보 삽입 중 오류 발생)");
				}
			}
			
			if(!deleteFileNoList.isEmpty()) { // 삭제할 이미지가 있다면
				result = dao.deleteAttachmentList(deleteFileNoList);
				
				if(result != deleteFileNoList.size()) {
					throw new InsertAttachmentFailException("파일 수정 실패(파일 정보 삭제 중 오류 발생)");
				}
				
			}
			
		}
		
		return result;
	}

	// 친구찾기 게시글 상태변경 Service
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateStatus(int friendNo) {
		return dao.updateStatus(friendNo);
	}

	// DB에 최근 3일 이전에 저장된 파일 조회 Service 구현
	@Override
	public List<String> selectDBFileList() {
		return dao.selectDBFileList();
	}

	// 친구찾기 삭제 게시글 관리자 상세 조회 Service 구현
	@Override
	public FindFriend selectDeleteBoard(int friendNo) {
		return dao.selectDeleteBoard(friendNo);
	}

	// 친구찾기 채팅 삽입 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChat(Map<String, Object> map) {
		
		map.put( "friendNo", ((String)map.get("friendNo")).replaceAll("\"", " ").trim());
		map.put( "memberNo", ((String)map.get("memberNo")).replaceAll("\"", " ").trim());
		map.put( "chat", ((String)map.get("chat")).replaceAll("\"", " ").trim());
		
		map.put( "chat", ((String)map.get("chat")).replaceAll("\n", "<br>"));
		
		return dao.insertChat(map);
	}

	// 친구찾기 채팅 조회 Service
	@Override
	public List<FindFriendChatting> selectChatList(int friendNo) {
		return dao.selectChatList(friendNo);
	}

}
