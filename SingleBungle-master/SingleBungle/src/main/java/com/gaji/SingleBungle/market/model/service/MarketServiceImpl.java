package com.gaji.SingleBungle.market.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gaji.SingleBungle.market.model.dao.MarketDAO;
import com.gaji.SingleBungle.market.model.exception.MarketInsertAttachmentFailException;
import com.gaji.SingleBungle.market.model.vo.Market;
import com.gaji.SingleBungle.market.model.vo.MarketAttachment;
import com.gaji.SingleBungle.market.model.vo.MarketLike;
import com.gaji.SingleBungle.market.model.vo.MarketPageInfo;
import com.gaji.SingleBungle.market.model.vo.MarketSearch;

@Service
public class MarketServiceImpl implements MarketService {

	@Autowired
	private MarketDAO dao;

	// 페이징 처리 객체 생성 Service 구현
	@Override
	public MarketPageInfo getPageInfo(int cp) {
		int listCount = dao.getListCount();
		return new MarketPageInfo(cp, listCount);
	}

	// 게시글 목록 조회 Service 구현
	@Override
	public List<Market> selectList(MarketPageInfo mpInfo) {
		return dao.selectList(mpInfo);
	}
	
	// 썸네일 목록 조회 Service 구현
	@Override
	public List<MarketAttachment> selectThumbnailList(List<Market> mList) {
		return dao.selectThumbnailList(mList);
	}

	// 상세 조회 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Market selectMarket(int marketNo) {

		Market temp = new Market();
		temp.setMarketNo(marketNo);

		Market market = dao.selectMarket(temp);

		if (market != null) {
			int result = dao.increaseReadCount(marketNo);

			if (result > 0) {
				market.setReadCount(market.getReadCount() + 1);
			}
		}
		return market;
	}
	
	// 좋아요 여부 확인 Service 구현
	@Override
	public int selectLikePushed(Map<String, Integer> map) {
		return dao.selectLikePushed(map);
	}
	
	// 게시글 상세 조회 이미지 목록 조회 Service 구현
	@Override
	public List<MarketAttachment> selectAttachmentList(int marketNo) {
		return dao.selectAttachmentList(marketNo);
	}

	
	// 좋아요 목록 조회 Service 구현
	@Override
	public List<MarketLike> selectLike(int memberNo) {
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

	// 게시글 등록 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertMarket(Market market, List<MultipartFile> images, String savePath) {
		int result = 0;

		int marketNo = dao.selectNextNo();

		if (marketNo > 0) {
			market.setMarketNo(marketNo);

			String marketTitle = market.getMarketTitle();
			String marketContent = market.getMarketContent();

			marketTitle = replaceParameter(marketTitle);
			marketContent = replaceParameter(marketContent);

			market.setMarketTitle(marketTitle);
			market.setMarketContent(marketContent);
		}

		result = dao.insertMarket(market);

		if (result > 0) {
			List<MarketAttachment> uploadImages = new ArrayList<MarketAttachment>();

			String filePath = "/resources/marketImages";

			for (int i = 0; i < images.size(); i++) {
				if (!images.get(i).getOriginalFilename().equals("")) {
					String fileName = rename(images.get(i).getOriginalFilename());

					MarketAttachment at = new MarketAttachment(filePath, fileName, i, marketNo);

					uploadImages.add(at);
					System.out.println(uploadImages);
				}
			}

			if (!uploadImages.isEmpty()) {
				result = dao.insertAttachmentList(uploadImages);

				if (result == uploadImages.size()) {
					result = marketNo;

					
					 int size = uploadImages.size();;
					  
					 
					 
//					 if(!images.get(0).getOriginalFilename().equals("")) { size = images.size(); }
					 
					for (int i = 0; i < size; i++) {
						try {
							images.get(uploadImages.get(i).getFileLevel())
									.transferTo(new File(savePath + "/" + uploadImages.get(i).getFileName()));
							System.out.println("파일 저장 성공!!!!");
						} catch (Exception e) {
							e.printStackTrace();

							throw new MarketInsertAttachmentFailException("파일 서버 저장 실패");
						}
					}
				}
			} else {
				throw new MarketInsertAttachmentFailException("파일 정보 DB 삽입 실패");
			}
		} else {
			result = marketNo;
		}
		return result;
	}

	// 크로스 사이트 스크립팅 방지 처리 메소드
	private String replaceParameter(String param) {
		String result = param;
		if (param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}
		return result;
	}

	public String rename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000);
		String str = "_" + String.format("%05d", ranNum);
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
		return date + str + ext;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int reservation(Map<String, Integer> map) {
		return dao.reservation(map);
	}
	
	// 검색 조건이 포함된 페이징 처리 객체 생성 Service 구현
	@Override
	public MarketPageInfo getSearchPageInfo(MarketSearch mSearch, int cp) {
		
		// 검색 조건에 맞는 게시글 수 조회
		int listCount = dao.getSearchListCount(mSearch);
		return new MarketPageInfo(cp, listCount);
	}
	
	// 검색 조건이 포함된 게시글 목록 조회 Service 구현
	@Override
	public List<Market> selectSearchList(MarketSearch mSearch, MarketPageInfo pInfo) {
		return dao.selectSearchList(mSearch, pInfo);
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
	
	// 게시글 삭제 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteMarket(Market market) {
		return dao.deleteMarket(market);
	}

	// 사고 팔고 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateMarket(Market market, List<MultipartFile> images, String savePath, int[] beforImages) {
		
		// 크로스사이트스크립트  방지 처리
		String marketTitle = market.getMarketTitle();
		String marketContent = market.getMarketContent();

		marketTitle = replaceParameter(marketTitle);
		marketContent = replaceParameter(marketContent);

		market.setMarketTitle(marketTitle);
		market.setMarketContent(marketContent);
		
		// 사고 팔고 글 수정 DAO 호출
		int result = dao.updateMarket(market);
		
		if(result > 0) {
			// 수정 전 업로드된 파일 정보를 얻어옴.
			// -> 새롭게 삽입 또는 수정되는 파일과 비교하기 위함.
			List<MarketAttachment> oldFiles = dao.selectAttachmentList(market.getMarketNo());
			
			// 새로 업로드된 파일 정보를 담을 리스트
			List<MarketAttachment> uploadImages = new ArrayList<MarketAttachment>();
			
			// 삭제 되어야할 파일 정보를 담을 리스트
			List<MarketAttachment> removeFileList = new ArrayList<MarketAttachment>();
			
			int lv = 0; // 파일 레벨을 지정하기 위한 변수
			for(MarketAttachment old : oldFiles) {
				
				for(int i=0; i<beforImages.length ; i++) {
					
					if(old.getFileNo() == beforImages[i] && old.getFileLevel() != i) {
						//if(i == 0) lv = 0;
						//else	   
							lv = i;
						System.out.println(beforImages[i] + " / " + old);
						System.out.println("lv : " + lv);
						MarketAttachment newAt = new MarketAttachment(old.getFilePath(), old.getFileName(), lv, market.getMarketNo());
						newAt.setFileNo(old.getFileNo());
						
						result = dao.updateOldFile(newAt);
						
						if(result == 0) {
							throw new RuntimeException("파일 정보 수정 중 오류 발생");
						}
					}
				}
				
				
				boolean flag = true;
				for(int i=0; i<beforImages.length ; i++) {
					if(old.getFileNo() == beforImages[i]) {
						flag = false;
						break;
					}
				}
				
				if(flag) {
					removeFileList.add(old);
				}
			}
			
			if(lv == 0) {
				lv = beforImages.length;
			}else {
				lv++;
			}
			
			
			
			// DB에 저장할 웹상 이미지 접근 경로
			String filePath = "/resources/marketImages";
			
			// 새롭게 업로드된 파일 정보를 가지고 있는 images에 반복 접근
			for (int i = 0; i < images.size(); i++) {
				if (!images.get(i).getOriginalFilename().equals("")) {
					
					// 파일명 변경
					String fileName = rename(images.get(i).getOriginalFilename());

					// MarketAttachment 객체 생성
					MarketAttachment at = new MarketAttachment(filePath, fileName, lv++, market.getMarketNo());

					uploadImages.add(at);
				}
			}
			
			
			// 새롭게 삽입된 이미지 모두 삽입.
			if(!uploadImages.isEmpty()) {
				result = dao.insertAttachmentList(uploadImages);
			}
			
		
			
			if(result > 0 && !removeFileList.isEmpty()) {
				result = dao.deleteAttachmentList(removeFileList);
				if(result <= 0) {
					throw new RuntimeException("파일 정보 삭제 중 오류 발생");
				}
			}
			
			
			if(result > 0) {
				
				for(int i=0 ; i<uploadImages.size(); i++) {
					
					try {
						images.get(uploadImages.get(i).getFileLevel())
							.transferTo(new File(savePath + "/" + uploadImages.get(i).getFileName()) );                                             
					}catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("파일 정보 수정 실패");
					}
				}
			}
			
			
			// 이전 파일 서버에서 삭제하는 코드 
			for(MarketAttachment removeFile : removeFileList) {
				File tmp = new File(savePath + "/" + removeFile.getFileName());
				tmp.delete();
			}
		}
		
		
		return result;
	}

	//	관리자 삭제된 게시글 상세조회
	@Override
	public Market selectDeleteMarket(int marketNo) {
		return dao.selectDeleteMarket(marketNo);
	}

	// 조회수 상위 3 게시글 조회
	@Override
	public List<Market> marketListTop3() {
		return dao.marketListTop3();
	}

	
	// 닉네임 조회
	@Override
	public String getNickname(int memberNo) {
		return dao.getNickname(memberNo);
	}
	
	// 판매내역 게시글 수 조회
	@Override
	public MarketPageInfo getMyPageInfo(int cp, int memberNo) {
		int listCount = dao.getMyPageInfo(memberNo);
		return new MarketPageInfo(cp, listCount);
	}
	
	// 판매 내역 조회
	@Override
	public List<Market> selectMypageList(Map<String, Object> map) {
		return dao.selectMypageList(map);
	}

	
	// 동네인증 update service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int locateUpdate(Map<String, Object> map) {
		return dao.locateUpdate(map);
	}

	
	// 동네인증 insert service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int locateInsert(Map<String, Object> map) {
		return dao.locateInsert(map);
	}

	
	// 노인증 주소 검색 insert service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int NoCertificationInsert(Map<String, Object> map) {
		return dao.NoCertificationInsert(map);
	}

	// 노인증 주소 검색 update service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int NoCertificationUpdate(Map<String, Object> map) {
		return  dao.NoCertificationUpdate(map);
	}
	
	
	




	
	

	
	



}
