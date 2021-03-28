package com.gaji.SingleBungle.cafe.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.cafe.model.vo.Cafe;
import com.gaji.SingleBungle.cafe.model.vo.CafeAttachment;
import com.gaji.SingleBungle.cafe.model.vo.CafeLike;
import com.gaji.SingleBungle.cafe.model.vo.CafePageInfo;
import com.gaji.SingleBungle.cafe.model.vo.CafeSearch;

@Repository
public class CafeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 맛집게시판 전체 게시글 수 조회 DAO
	 * @return listCount
	 */
	public int getListCount() {
		return sqlSession.selectOne("cafeMapper.getListCount");
	}

	
	/** 게시글 목록 조회 DAO
	 * @param cpInfo
	 * @return cList
	 */
	public List<Cafe> selectList(CafePageInfo cpInfo) {
		
		int offset = (cpInfo.getCurrentPage() - 1) * cpInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, cpInfo.getLimit());
		
		return sqlSession.selectList("cafeMapper.selectList", cpInfo, rowBounds);
	}

	/** 썸네일 목록 조회 DAO
	 * @param cList
	 * @return thList
	 */
	public List<CafeAttachment> selectThumbnailList(List<Cafe> cList) {
		return sqlSession.selectList("cafeMapper.selectThumbnailList", cList);
	}

	/** 게시글 상세조회 DAO
	 * @param temp
	 * @return cafe
	 */
	public Cafe selectCafe(Cafe temp) {
		return sqlSession.selectOne("cafeMapper.selectCafe", temp);
	}


	/** 게시글 조회수 증가 DAO
	 * @param cafeNo
	 * @return result
	 */
	public int increaseReadCount(int cafeNo) {
		return sqlSession.update("cafeMapper.increaseReadCount", cafeNo);
	}


	/** 게시글에 포함된 이미지 목록 조회 DAO
	 * @param cafeNo
	 * @return attachmentList
	 */
	public List<CafeAttachment> selectAttachmentList(int cafeNo) {
		return sqlSession.selectList("cafeMapper.selectAttachmentList", cafeNo);
	}


	/** 다음 게시글 번호 얻어오기 DAO
	 * @return cafeNo
	 */
	public int selectNextNo() {
		return sqlSession.selectOne("cafeMapper.selectNextNo");
	}


	/** 게시글 삽입 DAO
	 * @param map
	 * @return result
	 */
	public int insertBoard(Map<String, Object> map) {
		return sqlSession.insert("cafeMapper.insertBoard", map);
	}


	/** 게시글 삭제 DAO
	 * @param cafe
	 * @return result
	 */
	public int deleteCafe(Cafe cafe) {
		return sqlSession.update("cafeMapper.deleteCafe", cafe);
	}

	/** 검색 게시글 수 조회 DAO
	 * @param map
	 * @return 
	 */
	public int getSearchListCount(CafeSearch cSearch) {
		return sqlSession.selectOne("cafeMapper.getSearchListCount", cSearch);
	}

	/** 게시글 검색 목록 조회 DAO
	 * @param map
	 * @param bpInfo
	 * @return cList
	 */
	public List<Cafe> selectSearchList(CafeSearch cSearch, CafePageInfo cpInfo) {
		int offset = (cpInfo.getCurrentPage() -1) * cpInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, cpInfo.getLimit());
		
		return sqlSession.selectList("cafeMapper.selectSearchList", cSearch, rowBounds);
	}

 
	/** 조회수 상위 3 게시글 조회 DAO
	 * @return list
	 */
	public List<Cafe> cafeListTop3() {
		return sqlSession.selectList("cafeMapper.cafeListTop3");
	}


	/** 파일 정보 삽입 DAO
	 * @param uploadImages
	 * @return
	 */
	public int insertAttachmentList(List<CafeAttachment> uploadImages) {
		return sqlSession.insert("cafeMapper.insertAttachmentList", uploadImages);
	}


	/** 게시글 수정 DAO
	 * @param updateCafe
	 * @return
	 */
	public int updateCafe(Cafe updateCafe) {
		return sqlSession.update("cafeMapper.updateCafe", updateCafe);
	}


	/** 파일 정보 일괄 삭제 DAO
	 * @param deleteFileNoList
	 * @return result
	 */
	public int deleteAttachmentList(List<Integer> deleteFileNoList) {
		return sqlSession.delete("cafeMapper.deleteAttachmentList", deleteFileNoList);
	}


	/** 좋아요 목록 조회 DAO
	 * @param memberNo
	 * @return
	 */
	public List<CafeLike> selectLike(int memberNo) {
		return sqlSession.selectList("cafeMapper.selectLike", memberNo);
	}


	/** 좋아요 증가 DAO
	 * @param map
	 * @return result
	 */
	public int increaseLike(Map<String, Object> map) {
		return sqlSession.insert("cafeMapper.increaseLike", map);
	}

	/** 좋아요 감소 DAO
	 * @param map
	 * @return result
	 */
	public int decreaseLike(Map<String, Object> map) {
		return sqlSession.delete("cafeMapper.decreaseLike", map);
	}


	/** 좋아요 여부 확인 DAO
	 * @param map
	 * @return like
	 */
	public int selectLikePushed(Map<String, Integer> map) {
		return sqlSession.selectOne("cafeMapper.selectLikePushed", map);
	}


	/** 신고 등록 다음 게시글 번호 얻어오기 DAO
	 * @return reportNo
	 */
	public int selectReportNo() {
		return sqlSession.selectOne("cafeMapper.selectReportNo");
	}


	/** 신고 등록 DAO
	 * @param map
	 * @return result
	 */
	public int insertCafeReport(Map<String, Object> map) {
		return sqlSession.insert("cafeMapper.insertCafeReport", map);
	}


	
	
	
	
	
	
	
	/** 관리자(admin) 삭제된 게시글 상세조회 DAO
	 * @param cafeNo
	 * @return
	 */
	public Cafe selectDeleteCafe(int cafeNo) {
		return sqlSession.selectOne("cafeMapper.selectDeleteCafe",cafeNo);
	}
	
	

	
	



}
