package com.gaji.SingleBungle.market.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.market.model.vo.Market;
import com.gaji.SingleBungle.market.model.vo.MarketAttachment;
import com.gaji.SingleBungle.market.model.vo.MarketLike;
import com.gaji.SingleBungle.market.model.vo.MarketPageInfo;
import com.gaji.SingleBungle.market.model.vo.MarketSearch;

@Repository
public class MarketDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 사고팔고 전체 게시글 수 조회  DAO
	 * @return listCount
	 */
	public int getListCount() {
		return sqlSession.selectOne("marketMapper.getListCount");
	}

	
	/** 게시글 목록 조회 DAO
	 * @param mpInfo
	 * @return mList
	 */
	public List<Market> selectList(MarketPageInfo mpInfo) {
		int offset = (mpInfo.getCurrentPage() - 1) * mpInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, mpInfo.getLimit());
		return sqlSession.selectList("marketMapper.selectList", mpInfo, rowBounds);
	}
	 
	/** 썸네일 목록 조회 DAO
	 * @param mList
	 * @return thList
	 */
	public List<MarketAttachment> selectThumbnailList(List<Market> mList) {
		return sqlSession.selectList("marketMapper.selectThumbnailList", mList);
	}


	/** 상세조회 DAO
	 * @param temp
	 * @return market
	 */
	public Market selectMarket(Market temp) {
		return sqlSession.selectOne("marketMapper.selectMarket", temp);
	}
	
	
	/** 좋아요 여부 확인 DAO
	 * @param map
	 * @return likeP
	 */
	public int selectLikePushed(Map<String, Integer> map) {
		return sqlSession.selectOne("marketMapper.selectLikePushed", map);
	}


	/** 조회수 증가 DAO
	 * @param marketNo
	 * @return
	 */
	public int increaseReadCount(int marketNo) {
		return sqlSession.update("marketMapper.increaseReadCount", marketNo);
	}


	/** 좋아요 목록 조회 DAO
	 * @param memberNo
	 * @return
	 */
	public List<MarketLike> selectLike(int memberNo) {
		return sqlSession.selectList("marketMapper.selectLike", memberNo);
	}


	/** 좋아요 증가 DAO
	 * @param map
	 * @return result
	 */
	public int increaseLike(Map<String, Object> map) {
		return sqlSession.insert("marketMapper.increaseLike", map);
	}


	/** 좋아요 감소 DAO
	 * @param map
	 * @return result
	 */
	public int decreaseLike(Map<String, Object> map) {
		return sqlSession.delete("marketMapper.decreaseLike", map);
	}

	
	/** 다음 게시글 번호 조회 DAO
	 * @return result
	 */
	public int selectNextNo() {
		return sqlSession.selectOne("marketMapper.selectNextNo");
	}


	/** 게시글 등록 DAO
	 * @param market
	 * @return result
	 */
	public int insertMarket(Market market) {
		return sqlSession.insert("marketMapper.insertMarket", market);
	}


	/** 파일 정보 삽입 DAO
	 * @param uploadImages
	 * @return result
	 */
	public int insertAttachmentList(List<MarketAttachment> uploadImages) {
		return sqlSession.insert("marketMapper.insertAttachmentList", uploadImages);
	}


	/** 게시글에 포함된 이미지 목록 조회 DAO
	 * @param marketNo
	 * @return attachmentList
	 */
	public List<MarketAttachment> selectAttachmentList(int marketNo) {
		return sqlSession.selectList("marketMapper.selectAttachmentList", marketNo);
	}


	public int reservation(Map<String, Integer> map) {
		return sqlSession.update("marketMapper.reservation", map);
	}


	/**	검색 조건이 포함된 페이징 처리 객체 생성 DAO
	 * @param mSearch
	 * @return
	 */
	public int getSearchListCount(MarketSearch mSearch) {
		return sqlSession.selectOne("marketMapper.getSearchListCount", mSearch);
	}


	/** 검색 조건이 포함된 게시글 목록 조회 DAO
	 * @param mSearch 
	 * @param pInfo
	 * @return mList
	 */
	public List<Market> selectSearchList(MarketSearch mSearch, MarketPageInfo pInfo) {
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit(); 
		
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		
		return sqlSession.selectList("marketMapper.selectSearchList", mSearch, rowBounds);
	}

	
	/** 게시글 신고 다음 번호 가져오기
	 * @return
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("marketMapper.selectReportNo");
	}
	
	/** 게시글 신고
	 * @param map
	 * @return
	 */
	public int insertReviewReport(Map<String, Object> map) {
		return sqlSession.insert("marketMapper.insertReviewReport",map);
	}


	/** 게시글 신고 DAO
	 * @param market
	 * @return result
	 */
	public int deleteMarket(Market market) {
		return sqlSession.update("marketMapper.deleteMarket", market);
	}

	

	/** 사고 팔고 글 부분 수정 DAO
	 * @param market
	 * @return result
	 */
	public int updateMarket(Market market) {
		return sqlSession.update("marketMapper.updateMarket", market);
	}


	/** 이전 파일의 레벨을 변경시키는 DAO
	 * @param newAt
	 * @return result
	 */ 
	public int updateOldFile(MarketAttachment newAt) {
		return sqlSession.update("marketMapper.updateOldFile", newAt);
	}


	/** 삭제된 이전 파일 정보 삭제 DAO
	 * @param removeFileList
	 * @return result
	 */
	public int deleteAttachmentList(List<MarketAttachment> removeFileList) {
		return sqlSession.delete("marketMapper.deleteAttachmentList", removeFileList);
	}


	/** 관리자 삭제된 페이지 상세 조회
	 * @param marketNo
	 * @return
	 */
	public Market selectDeleteMarket(int marketNo) {
		return sqlSession.selectOne("marketMapper.selectDeleteReview",marketNo);
	}



	/** 조회수 상위 3 게시글
	 * @return list
	 */
	public List<Market> marketListTop3() {
		return sqlSession.selectList("marketMapper.reviewListTop3");
	}


	/** 닉네임 조회
	 * @param memberNo
	 * @return nickname
	 */
	public String getNickname(int memberNo) {
		return sqlSession.selectOne("marketMapper.getNickname", memberNo);
	}

	/** 판매내역 게시글 수 조회
	 * @param memberNo 
	 * @return listCount
	 */
	public int getMyPageInfo(int memberNo) {
		return sqlSession.selectOne("marketMapper.getMyPageInfo", memberNo);
	}	
	
	
	/** 판매내역 조회
	 * @param map
	 * @return mList
	 */
	public List<Market> selectMypageList(Map<String, Object> map) {
		
		MarketPageInfo temp = (MarketPageInfo) map.get("mpInfo");
		int offset = (temp.getCurrentPage() - 1) *temp.getLimit();
		RowBounds rowBounds = new RowBounds(offset, temp.getLimit());
		return sqlSession.selectList("marketMapper.selectMypageList", map, rowBounds);
	}


	/** 동네인증 update DAO
	 * @param map
	 * @return result
	 */
	public int locateUpdate(Map<String, Object> map) {
		return sqlSession.update("marketMapper.locateUpdate", map);
	}


	/** 동네인증 insert DAO
	 * @param map
	 * @return result
	 */
	public int locateInsert(Map<String, Object> map) {
		return sqlSession.insert("marketMapper.locateInsert", map);
	}


	/** 노인증 주소 검색 insert DAO
	 * @param map
	 * @return result
	 */
	public int NoCertificationInsert(Map<String, Object> map) {
		return sqlSession.insert("marketMapper.NoCertificationInsert", map);
	}


	/** 노인증 주소 검색 update DAO
	 * @param map
	 * @return result
	 */
	public int NoCertificationUpdate(Map<String, Object> map) {
		return sqlSession.update("marketMapper.NoCertificationUpdate", map);
	}

	

	

	





}
