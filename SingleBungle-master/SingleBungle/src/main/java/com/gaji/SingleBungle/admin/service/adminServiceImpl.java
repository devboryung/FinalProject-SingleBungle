package com.gaji.SingleBungle.admin.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.admin.dao.adminDAO;
import com.gaji.SingleBungle.admin.vo.AAttachment;
import com.gaji.SingleBungle.admin.vo.ABoard;
import com.gaji.SingleBungle.admin.vo.APageInfo;
import com.gaji.SingleBungle.admin.vo.IAttachment;
import com.gaji.SingleBungle.admin.vo.Reply;
import com.gaji.SingleBungle.admin.vo.inquiry;
import com.gaji.SingleBungle.admin.vo.reportBoard;
import com.gaji.SingleBungle.admin.vo.reportReply;
import com.gaji.SingleBungle.board.model.vo.Board;
import com.gaji.SingleBungle.board.model.vo.BoardAttachment;
import com.gaji.SingleBungle.findFriend.exception.InsertAttachmentFailException;
import com.gaji.SingleBungle.member.model.vo.MReply;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;

@Repository
public class adminServiceImpl implements adminService{
	
	@Autowired
	private adminDAO dao;

	@Override
	public APageInfo getPageInfo(int cp, int type) {
		int listCount = dao.getListCount(type);
		return new APageInfo(cp, listCount, type);
	}

	@Override
	public List<ABoard> selectList(APageInfo pInfo, int type) {
		return dao.selectList(pInfo);
	}

	@Override
	public List<AAttachment> selectThumbnailList(List<ABoard> eventList) {
		return dao.selectThumbnailList(eventList);
	}

	
	
	@Transactional(rollbackFor=Exception.class)
	@Override
	public ABoard selectBoard(int boardNo, int type) {
		// 1) 게시글 상세 조회
   		ABoard temp = new ABoard();
   		temp.setBoardNo(boardNo);
   		temp.setBoardCode(type);
   		
		ABoard board = dao.selectBoard(temp);
		
		// 2) 상세 조회 성공 시 조회수 증가
		if(board!=null) {
			int result = dao.increaseReadCount(boardNo);
			
			if(result>0) { // DB 조회 수 증가 성공 시, 조회 된 board의 조회수도 1 증가
				board.setReadCount(board.getReadCount()+1);
				
			}
		}
		return board;
	}

	@Override
	public List<AAttachment> selectAttachmentList(int boardNo) {
		return dao.selectAttachmentList(boardNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertNotice(Map<String, Object> map, List<MultipartFile> images, String savePath) {
		int result =0; // 최종 결과 저장 변수 선언
		
		// 1) 게시글 번호 얻어오기 -> SEQ_BNO.NEXTVAL
		int boardNo = dao.selectNextNo();
		
		// 2) 게시글 삽입
		if(boardNo>0) { // 다음 게시글 번호를 얻어온 경우
			map.put("boardNo", boardNo); // map에 boardNo 추가
			map.put("boardCode", 3);
			map.put("categoryCode", 31);
			
			// 게시글 삽입 DAO 메소드 호출
			result = dao.insertBoard(map);
			

			// 3) 게시글 삽입 성공 시 이미지 정보 삽입
			if(result>0) { // 게시글 삽입에 성공한다면 result에 글 번호 등록(상세 조회를 위해서)
				
				// 이미지 정보를 Attachment 객체에 저장하여 List에 추가
				List<AAttachment> uploadImages = new ArrayList<AAttachment>();
				
				// images.get(i).getOriginalFileName() 메소드를 수행하면 업로드된 파일의 원본 파일명이 출력된다.
				// --> 중복 상황을 대비하여 파일명 변경하는 코드 필요.(rename() 메소드)
				
				// DB에 저장할 웹 상 접근 주소(filePath)
				String filePath = null;
				
				filePath ="/resources/adminImages";
				
				
				
				// for문을 이용하여 파일정보가 담긴 images를 반복 접근
				// -> 업로드된 파일이 있을 경우에만 uploadImages 리스트에 추가
				for(int i=0; i<images.size(); i++) {
					// i == 인덱스 == FileLevel과 같은 값
					
					// 현재 접근한 images의 요소(MultipartFile)에 업로드된 파일이 있는지 확인.
					if( !images.get(i).getOriginalFilename().equals("") ) { 
						// 파일이 업로드 된 경우 == 업로드된 원본 파일명이 있는 경우
						
						// 원본 파일명 변경
						String fileName = rename(images.get(i).getOriginalFilename());
						
						// Attachment 객체 생성
						AAttachment at = new AAttachment(filePath, fileName, i, boardNo);
													// filePath, fileName, fileLever, parentBoardNo
						
						uploadImages.add(at); // 리스트에 추가
					}
				}
				
				// uploadImage 확인
				for(AAttachment at : uploadImages) {
					System.out.println(at);
				}
				
				
				
				//-----------------------------summernote----------------------------
				// 게시판 타입이 2번(summernote를 이용한 게시글 작성)일 경우
				// boardContent 내부에 업로드된 이미지 정보 (filePath, fileName)이 들어있음
				// -> boardContent에서 <img> 태그만을 골라내어 img 태그의 src 속성값을 추출 후 filePath, fileName을 얻어냄.

					Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); 
					//img 태그 src 추출 정규표현식
					
					// SummerNote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
					Matcher matcher = pattern.matcher((String)map.get("boardContent"));     
					 
					String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
					String src = null; // src 속성값을 저장할 임시 참조 변수
					int fileLevel=1;
					
					// matcher.find() : Matcher 객체에 저장된 값(검사를 통해 매칭된 src 속성 값)에 반복 접근하여 값이 있을 경우 true 
					while(matcher.find()){
						
						src=  matcher.group(1); // 매칭된 src 속성값을  Matcher 객체에서 꺼내서 src에 저장 
						
						filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/")); 
						// 파일명을 제외한 경로만 별도로 저장.--> 2번째 / 부터   마지막 / 까지
						
						fileName = src.substring(src.lastIndexOf("/")+ 1); // 업로드된 파일명만 잘라서 별도로 저장.
						
						// Attachment 객체를 이용하여 DB에 파일 정보를 저장
						AAttachment at = new AAttachment(filePath, fileName, fileLevel , boardNo);
						// 파일 레벨 숫자는 상관없음,
						
						uploadImages.add(at);
						fileLevel++;

					}
				
				
				//-----------------------------summernote----------------------------
				
				
				if(!uploadImages.isEmpty()) {
					// 파일 정보 삽입 DAO 호출
					result = dao.insertAttachmentList(uploadImages);
					System.out.println("result : " + result);
					// result == 삽입된 행의 개수
					
					if(result == uploadImages.size()) {
						
						result = boardNo;
						// 반환 될 result 에 boardNo 저장. (상세정보 페이지로 넘어가기 위해서)
						
						// MultipartFile.transferTo()
						// -> MultipartFile 객체에 저장된 파일을 지정된 경로에 실제 파일의 형태로 변h환하여 저장하는 메소드.
						
						int size = 0;
						
						if (!images.get(0).getOriginalFilename().equals("")){
							size = images.size(); //==1
						}
						
						for(int i=0; i<size; i++) {
						// uploadImages라는  List에는 Attachment가 담겨져 있다. (파일이 업로드된 개수만큼 담겨져있으면서,파일 레벨이 지정되어 있음)
						// uploadImages.get(i).getFileLevel() = i에 따라서 파일 레벨이 나온다.
						// images는  input type="file" 태그 정보를 담은 , 실제 파일이 업로드 된 MultipartFile 들이 모여있는 List
						// savePath : 실제 컴퓨터의 서버 경로
							
					    // uploadImages를 만들 때 각 요소의 파일 레벨은 images의 index를 이용하여 부여한다.--> images의 index를 통해 uploadImages의 레벨을 구할 수 있다.
		                // uploadImages.get(i).getFileName() : 업로드된 i번째 이미지의 변경된 이름을 가져온다.
					    // 실제 파일들을 변경된  파일의 이름으로  새로운 경로에 저장한다.
							try {
								images.get(uploadImages.get(i).getFileLevel()).transferTo(new File(savePath+"/"+uploadImages.get(i).getFileName()) );
								
							}catch(Exception e) {
								e.printStackTrace();
								
								// transferTo()는 IOException(CheckedException)을 발생시킨다. 어쩔 수 없이 try catch를 작성해서 예외처리 함.
								// 예외가 처리되면 @Transactional이 정상 동작하지 못 함.
								// 꼭 예외처리를 하지 않아도 되는 UncheckedException을 강제 발생시켜 @Transactional이 예외가 발생했음을 감지하게 함.
								// 상황에 맞는 사용자 정의 예외를 작성함.
								throw new InsertAttachmentFailException("파일 서버 저장 실패");
							}
						}
						
					}else { // 파일 정보를 DB에 삽입 실패
						throw new InsertAttachmentFailException("파일 정보 DB 삽입 실패");
					}
					
				}else { // 업로드된 이미지가 없을 경우
					result = boardNo;
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

		@Override
		public AAttachment insertImage(MultipartFile uploadFile, String savePath) {
			// 중복을 방지하기 위해, 파일명 변경해 줌
			String fileName = rename(uploadFile.getOriginalFilename());

			// 웹 상 접근 주소
			String filePath = "/resources/adminImages";
			
			// 돌려 보내줄 파일 정보를 Attachment 객체에 담아서 전달.
			AAttachment at = new AAttachment();
			at.setFilePath(filePath);
			at.setFileName(fileName);
			
			// 서버에 파일 저장(transferTo())
			
			try {
				uploadFile.transferTo(new File(savePath + "/" + fileName));
				// savePath : ~~~~/infoImages   fileName = 20210217~~.png
			}catch(Exception e) {
				e.printStackTrace();
				
				throw new InsertAttachmentFailException("summernote 파일 업로드 실패");
			}
			
			return at;
		}

		
		
		@Override
		public int insertEvent(Map<String, Object> map, List<MultipartFile> images, String savePath) {
			int result =0; // 최종 결과 저장 변수 선언
			
			// 1) 게시글 번호 얻어오기 -> SEQ_BNO.NEXTVAL
			int boardNo = dao.selectNextNo();
			
			// 2) 게시글 삽입
			if(boardNo>0) { // 다음 게시글 번호를 얻어온 경우
				map.put("boardNo", boardNo); // map에 boardNo 추가
				map.put("boardCode", 4);
				map.put("categoryCode", 41);
				

				// 게시글 삽입 DAO 메소드 호출
				result = dao.insertBoard(map);
				

				// 3) 게시글 삽입 성공 시 이미지 정보 삽입
				if(result>0) { // 게시글 삽입에 성공한다면 result에 글 번호 등록(상세 조회를 위해서)
					
					// 이미지 정보를 Attachment 객체에 저장하여 List에 추가
					List<AAttachment> uploadImages = new ArrayList<AAttachment>();
					
					// images.get(i).getOriginalFileName() 메소드를 수행하면 업로드된 파일의 원본 파일명이 출력된다.
					// --> 중복 상황을 대비하여 파일명 변경하는 코드 필요.(rename() 메소드)
					
					// DB에 저장할 웹 상 접근 주소(filePath)
					String filePath = null;
					
					filePath ="/resources/adminImages";
					
					

					//-----------------------------summernote----------------------------
					// 게시판 타입이 2번(summernote를 이용한 게시글 작성)일 경우
					// boardContent 내부에 업로드된 이미지 정보 (filePath, fileName)이 들어있음
					// -> boardContent에서 <img> 태그만을 골라내어 img 태그의 src 속성값을 추출 후 filePath, fileName을 얻어냄.

						Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); 
						//img 태그 src 추출 정규표현식
						
						// SummerNote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
						Matcher matcher = pattern.matcher((String)map.get("boardContent"));     
						 
						String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
						String src = null; // src 속성값을 저장할 임시 참조 변수
						int fileLevel=1;
						
						// matcher.find() : Matcher 객체에 저장된 값(검사를 통해 매칭된 src 속성 값)에 반복 접근하여 값이 있을 경우 true 
						while(matcher.find()){
							
							src=  matcher.group(1); // 매칭된 src 속성값을  Matcher 객체에서 꺼내서 src에 저장 
							
							filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/")); 
							// 파일명을 제외한 경로만 별도로 저장.--> 2번째 / 부터   마지막 / 까지
							
							fileName = src.substring(src.lastIndexOf("/")+ 1); // 업로드된 파일명만 잘라서 별도로 저장.
							
							// Attachment 객체를 이용하여 DB에 파일 정보를 저장
							AAttachment at = new AAttachment(filePath, fileName, fileLevel , boardNo);
							// 파일 레벨 숫자는 상관없음,
							
							uploadImages.add(at);
							fileLevel++;

						}
					
					
					//-----------------------------summernote----------------------------
					
					
					if(!uploadImages.isEmpty()) {
						// 파일 정보 삽입 DAO 호출
						result = dao.insertAttachmentList(uploadImages);
						//System.out.println("result : " + result);
						// result == 삽입된 행의 개수
						
						if(result == uploadImages.size()) {
							
							result = boardNo;
							// 반환 될 result 에 boardNo 저장. (상세정보 페이지로 넘어가기 위해서)
							
							// MultipartFile.transferTo()
							// -> MultipartFile 객체에 저장된 파일을 지정된 경로에 실제 파일의 형태로 변h환하여 저장하는 메소드.
							
							int size = 0;
							
							if (!images.get(0).getOriginalFilename().equals("")){
								size = images.size(); //==1
							}
							
							for(int i=0; i<size; i++) {
							// uploadImages라는  List에는 Attachment가 담겨져 있다. (파일이 업로드된 개수만큼 담겨져있으면서,파일 레벨이 지정되어 있음)
							// uploadImages.get(i).getFileLevel() = i에 따라서 파일 레벨이 나온다.
							// images는  input type="file" 태그 정보를 담은 , 실제 파일이 업로드 된 MultipartFile 들이 모여있는 List
							// savePath : 실제 컴퓨터의 서버 경로
								
						    // uploadImages를 만들 때 각 요소의 파일 레벨은 images의 index를 이용하여 부여한다.--> images의 index를 통해 uploadImages의 레벨을 구할 수 있다.
			                // uploadImages.get(i).getFileName() : 업로드된 i번째 이미지의 변경된 이름을 가져온다.
						    // 실제 파일들을 변경된  파일의 이름으로  새로운 경로에 저장한다.
								try {
									images.get(uploadImages.get(i).getFileLevel()).transferTo(new File(savePath+"/"+uploadImages.get(i).getFileName()) );
									
								}catch(Exception e) {
									e.printStackTrace();
									
									// transferTo()는 IOException(CheckedException)을 발생시킨다. 어쩔 수 없이 try catch를 작성해서 예외처리 함.
									// 예외가 처리되면 @Transactional이 정상 동작하지 못 함.
									// 꼭 예외처리를 하지 않아도 되는 UncheckedException을 강제 발생시켜 @Transactional이 예외가 발생했음을 감지하게 함.
									// 상황에 맞는 사용자 정의 예외를 작성함.
									throw new InsertAttachmentFailException("파일 서버 저장 실패");
								}
							}
							
						}else { // 파일 정보를 DB에 삽입 실패
							throw new InsertAttachmentFailException("파일 정보 DB 삽입 실패");
						}
						
					}else { // 업로드된 이미지가 없을 경우
						result = boardNo;
					}
					
				}
			}
			return result;
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int deleteBoard(int boardNo) {
			
			return dao.deleteBoard(boardNo);
		}

		@Override
		public List<ABoard> selectFaqList(int type) {
			return dao.selectFaqList(type);
		}

		
		
		@Override
		public int insertFaqAction(Map<String, Object> map) {
			int result =0; // 최종 결과 저장 변수 선언
			
			// 1) 게시글 번호 얻어오기 -> SEQ_BNO.NEXTVAL
			int boardNo = dao.selectNextNo();
			
			// 2) 게시글 삽입
			if(boardNo>0) { // 다음 게시글 번호를 얻어온 경우
				map.put("boardNo", boardNo); // map에 boardNo 추가
				map.put("boardCode", 5);

				// 게시글 삽입 DAO 메소드 호출
				result = dao.insertBoard(map);
			}
			return result;
		}

		//1:1게시판 회원별 리스트 조회
		@Override
		public List<inquiry> inquiryList(APageInfo pInfo, int memberNo) {
			return dao.inquiryList(pInfo, memberNo);
		}

		//1:1게시판 관리자 리스트 조회
		@Override
		public List<inquiry> inquiryAllList(APageInfo pInfo) {
			return dao.inquiryAllList(pInfo);
		}
		
		
		@Override
		public APageInfo getInquiryPageInfo(int cp) {
			int listCount = dao.getInquiryListCount();
			return new APageInfo(cp, listCount);
		}
		
		@Override
		public APageInfo getInquiryAllPageInfo(int cp) {
			int listCount = dao.getAllInquiryListCount();
			return new APageInfo(cp, listCount);
		}
		
		
		@Override
		public int insertinquiryAction(Map<String, Object> map, List<MultipartFile> images, String savePath) {
			int result =0; // 최종 결과 저장 변수 선언
			
			// 1) 게시글 번호 얻어오기 -> SEQ_BNO.NEXTVAL
			int inquiryNo = dao.selecinquirytNextNo();
			
			// 2) 게시글 삽입
			if(inquiryNo>0) { // 다음 게시글 번호를 얻어온 경우
				map.put("inquiryNo", inquiryNo); // map에 boardNo 추가

				// 게시글 삽입 DAO 메소드 호출
				result = dao.insertinquiry(map);
				

				// 3) 게시글 삽입 성공 시 이미지 정보 삽입
				if(result>0) { // 게시글 삽입에 성공한다면 result에 글 번호 등록(상세 조회를 위해서)
					
					// 이미지 정보를 Attachment 객체에 저장하여 List에 추가
					List<AAttachment> uploadImages = new ArrayList<AAttachment>();
					
					// images.get(i).getOriginalFileName() 메소드를 수행하면 업로드된 파일의 원본 파일명이 출력된다.
					// --> 중복 상황을 대비하여 파일명 변경하는 코드 필요.(rename() 메소드)
					
					// DB에 저장할 웹 상 접근 주소(filePath)
					String filePath = null;
					
					filePath ="/resources/adminImages";
					
					

					//-----------------------------summernote----------------------------
					// 게시판 타입이 2번(summernote를 이용한 게시글 작성)일 경우
					// boardContent 내부에 업로드된 이미지 정보 (filePath, fileName)이 들어있음
					// -> boardContent에서 <img> 태그만을 골라내어 img 태그의 src 속성값을 추출 후 filePath, fileName을 얻어냄.

						Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); 
						//img 태그 src 추출 정규표현식
						
						// SummerNote에 작성된 내용 중 img태그의 src속성의 값을 검사하여 매칭되는 값을 Matcher객체에 저장함.
						Matcher matcher = pattern.matcher((String)map.get("inquiryContent"));     
						 
						String fileName = null; // 파일명 변환 후 저장할 임시 참조 변수
						String src = null; // src 속성값을 저장할 임시 참조 변수
						int fileLevel=1;
						
						// matcher.find() : Matcher 객체에 저장된 값(검사를 통해 매칭된 src 속성 값)에 반복 접근하여 값이 있을 경우 true 
						while(matcher.find()){
							
							src=  matcher.group(1); // 매칭된 src 속성값을  Matcher 객체에서 꺼내서 src에 저장 
							
							filePath = src.substring(src.indexOf("/", 2), src.lastIndexOf("/")); 
							// 파일명을 제외한 경로만 별도로 저장.--> 2번째 / 부터   마지막 / 까지
							
							fileName = src.substring(src.lastIndexOf("/")+ 1); // 업로드된 파일명만 잘라서 별도로 저장.
							
							// Attachment 객체를 이용하여 DB에 파일 정보를 저장
							AAttachment at = new AAttachment(filePath, fileName, fileLevel , inquiryNo);
							// 파일 레벨 숫자는 상관없음,
							
							uploadImages.add(at);
							fileLevel++;

						}
					
					
					//-----------------------------summernote----------------------------
					
					
					if(!uploadImages.isEmpty()) {
						// 파일 정보 삽입 DAO 호출
						result = dao.insertAttachmentList(uploadImages);
						//System.out.println("result : " + result);
						// result == 삽입된 행의 개수
						
						if(result == uploadImages.size()) {
							
							result = inquiryNo;
							// 반환 될 result 에 boardNo 저장. (상세정보 페이지로 넘어가기 위해서)
							
							// MultipartFile.transferTo()
							// -> MultipartFile 객체에 저장된 파일을 지정된 경로에 실제 파일의 형태로 변h환하여 저장하는 메소드.
							
							int size = 0;
							
							if (!images.get(0).getOriginalFilename().equals("")){
								size = images.size(); //==1
							}
							
							for(int i=0; i<size; i++) {
					
								try {
									images.get(uploadImages.get(i).getFileLevel()).transferTo(new File(savePath+"/"+uploadImages.get(i).getFileName()) );
									
								}catch(Exception e) {
									e.printStackTrace();
									
									// transferTo()는 IOException(CheckedException)을 발생시킨다. 어쩔 수 없이 try catch를 작성해서 예외처리 함.
									// 예외가 처리되면 @Transactional이 정상 동작하지 못 함.
									// 꼭 예외처리를 하지 않아도 되는 UncheckedException을 강제 발생시켜 @Transactional이 예외가 발생했음을 감지하게 함.
									// 상황에 맞는 사용자 정의 예외를 작성함.
									throw new InsertAttachmentFailException("파일 서버 저장 실패");
								}
							}
							
						}else { // 파일 정보를 DB에 삽입 실패
							throw new InsertAttachmentFailException("파일 정보 DB 삽입 실패");
						}
						
					}else { // 업로드된 이미지가 없을 경우
						result = inquiryNo;
					}
					
				}
			}
			return result;
		}

		@Override
		public inquiry selectInquiryBoard(int inquiryNo) {
			// 1) 게시글 상세 조회
	   		inquiry temp = new inquiry();
	   		temp.setInquiryNo(inquiryNo);

			return dao.selectInquiry(temp);
		}

		@Override
		public List<IAttachment> selectIAttachmentList(int inquiryNo) {
			return dao.selectIAttachmentList(inquiryNo);
		}

		

		@Override
		public int deleteInquiry(int inquiryNo) {
			return dao.deleteInquiry(inquiryNo);
		}

		
		
		@Transactional(rollbackFor = Exception.class)
		@Override
		public int updateBoard(ABoard updateBoard, String savePath) {
			int result = dao.updateBoard(updateBoard);

			if (result > 0) {
				
				// 수정 전 파일을 모아두는 list
				List<AAttachment> oldFiles = dao.selectAttachmentList(updateBoard.getBoardNo());
				
				// 삭제 되어야할 파일 정보를 담을 리스트
				List<AAttachment> removeFileList = new ArrayList<AAttachment>();


				// DB에 저장할 웹 상 이미지 접근 경로
				String filePath = "/resources/adminImages";

				Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");

				Matcher matcher = pattern.matcher(updateBoard.getBoardContent());

				List<String> fileNameList = new ArrayList<String>();

				String src = null;
				String fileName = null;

				while (matcher.find()) {
					src = matcher.group(1);
					fileName = src.substring(src.lastIndexOf("/") + 1);
					fileNameList.add(fileName);
				}

				// DB에 새로 추가할 이미지파일 정보를 모아둘 List생성
				List<AAttachment> newAttachmentList = new ArrayList<AAttachment>();

				// DB에서 삭제할 이미지파일 번호를 모아둘 List 생성
				List<Integer> deleteFileNoList = new ArrayList<Integer>();
				
				
				// 기존에 올려둔 파일 전부 삭제
				for(AAttachment oldAt : oldFiles) {
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
					AAttachment at = new AAttachment(filePath, fName, fileLevel, updateBoard.getBoardNo());
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

		@Override
		public APageInfo getAllPageInfo(int cp) {
			int listCount = dao.getAllListCount();
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectAllList(APageInfo pInfo) {
			return dao.selectAllList(pInfo);
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int recoverBoard(int boardNo, int boardCode) {
			int result=0;
			if(boardCode == 1) {result = dao.recoverBoard1(boardNo);}
			if(boardCode == 2) {result = dao.recoverBoard2(boardNo);}
			if(boardCode == 3) {result = dao.recoverBoard3(boardNo);}
			if(boardCode == 4) {result = dao.recoverBoard4(boardNo);}
			if(boardCode == 6) {result = dao.recoverBoard6(boardNo);}
			if(boardCode == 7) {result = dao.recoverBoard7(boardNo);}
			if(boardCode == 8) {result = dao.recoverBoard8(boardNo);}
			
			return result;
		}

		@Override
		public APageInfo getReplyPageInfo(int cp) {
			int listCount = dao.getReplyListCount();
			return new APageInfo(cp, listCount);
		}
		
		@Override
		public List<Reply> selectAllReply(APageInfo pInfo) {
			return dao.selectAllReply(pInfo);
		}

		@Override
		public int recoverReply(int replyNo, int boardCode) {
			int result=0;
			if(boardCode == 1 || boardCode==2) {result = dao.recoverReply1(replyNo);}
			if(boardCode == 6) {result = dao.recoverReply6(replyNo);}
			if(boardCode == 7) {result = dao.recoverReply7(replyNo);}
			if(boardCode == 8) {result = dao.recoverReply8(replyNo);}
			
			
			return result;
		}

		@Override
		public APageInfo getMemberPageInfo(int cp) {
			int listCount = dao.getMemberPageInfo();
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<Member> selectAllMember(APageInfo pInfo) {
			return dao.selectAllMember(pInfo);
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int deleteMember(int memNo) {
			return dao.deleteMember(memNo);
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int recoverMember(int memNo) {
			return dao.recoverMember(memNo);
		}

		@Override
		public APageInfo getGradePageInfo(int cp) {
			int listCount = dao.getGradePageInfo();
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<Member> selectGradeMember(APageInfo pInfo) {
			return dao.selectGradeMember(pInfo);
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int gradeMember(int memNo, String grade) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("memNo", memNo);
			
			if(grade.equals("F")) {map.put("grade", "S");}
			if(grade.equals("S")) {map.put("grade", "T");}
			if(grade.equals("T")) {map.put("grade", "T");}

			return dao.gradeMember(map);
		}

		@Override
		public APageInfo getReportBoardPageInfo(int cp) {
			int listCount = dao.getReportBoardPageInfo();
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<reportBoard> selectReportBoard(APageInfo pInfo) {
			return dao.selectReportBoard(pInfo);
		}

		@Transactional(rollbackFor = Exception.class)
		@Override
		public int recoverReportBoard(Map<String, Integer> map) {
			return dao.recoverReportBoard(map);
		}

		@Override
		public int deleteReportBoard(Map<String, Integer> map) {
			return dao.deleteReportBoard(map);
		}

		@Override
		public APageInfo getReportReplyPageInfo(int cp) {
			int listCount = dao.getReportReplyPageInfo();
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<reportReply> selectReportReply(APageInfo pInfo) {
			return dao.selectReportReply(pInfo);
		}

		@Override
		public int recoverReportReply(Map<String, Integer> map) {
			return dao.recoverReportReply(map);
		}

		@Override
		public int deleteReportReply(Map<String, Integer> map) {
			return dao.deleteReportReply(map);
		}

		@Override
		public List<ABoard> selectSearchList(String ct) {
			return dao.selectSearchList(ct);
		}

		@Override
		public APageInfo getSearchPageInfo(String ct, int cp) {
			// 검색 조건에 맞는 게시글 수 조회
			int listCount = dao.getSearchListCount(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectBoardSearchList(String ct, APageInfo pInfo) {
			return dao.selectBoardSearchList(ct,pInfo);
		}

		@Override
		public APageInfo getSearchRBoardPageInfo(String ct, int cp) {
			int listCount = dao.getSearchRBoardListCount(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectSearchRBoardList(String ct, APageInfo pInfo) {
			return dao.selectSearchRBoardList(ct,pInfo);
		}

		@Override
		public APageInfo getSearchReplyPageInfo(String ct, int cp) {
			int listCount = dao.getSearchReplyListCount(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectSearchReplyList(String ct, APageInfo pInfo) {
			return dao.selectSearchReplyList(ct,pInfo);
		}

		@Override
		public APageInfo getSearchRReplyPageInfo(String ct, int cp) {
			int listCount = dao.getSearchRReplyListCount(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectSearchRReplyList(String ct, APageInfo pInfo) {
			return dao.selectSearchRReplyList(ct,pInfo);
		}

		@Override
		public APageInfo getSearchmemberPageInfo(String ct, int cp) {
			int listCount = dao.getSearchMemberListCount(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectSearchmemberList(String ct, APageInfo pInfo) {
			return dao.selectSearchmemberList(ct,pInfo);
		}

		@Override
		public APageInfo getSearchmemberGradePageInfo(String ct, int cp) {
			int listCount = dao.getSearchmemberGradePageInfo(ct);
			return new APageInfo(cp, listCount);
		}

		@Override
		public List<ABoard> selectSearchmemberGradeList(String ct, APageInfo pInfo) {
			return dao.selectSearchmemberGradeList(ct,pInfo);
		}

		@Override
		public List<ABoard> selectABoardList(APageInfo pInfo) {
			return dao.selectABoardList(pInfo);
		}

		@Override
		public List<MReply> selectAReplyList(APageInfo pInfo) {
			return dao.selectAReplyList(pInfo);
		}

		@Override
		public APageInfo getABoarPageInfo(int cp) {
			int listCount = dao.getABoarPageInfo(cp);
			return new APageInfo(cp, listCount);
		}

		@Override
		public APageInfo getAReplyPageInfo(int cp2) {
			int listCount = dao.getAReplyPageInfo(cp2);
			return new APageInfo(cp2, listCount);
		}

		


		

		


		
		

	



}
