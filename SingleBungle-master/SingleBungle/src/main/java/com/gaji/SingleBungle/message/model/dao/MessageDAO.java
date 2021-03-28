package com.gaji.SingleBungle.message.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.message.model.vo.Message;
import com.gaji.SingleBungle.message.model.vo.MessagePageInfo;


@Repository
public class MessageDAO {
	
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/** 보낸 쪽지 수 조회 
	 * @param memberNo 
	 * @return
	 */
	public int getSendListCount(int memberNo) {
		
		return sqlSession.selectOne("messageMapper.getSendListCount",memberNo );
	}


	/** 보낸 쪽지 목록 조회
	 * @param map
	 * @return
	 */
	public List<Message> selectSendList(Map<String, Object> map) {
		 // RowBounds 객체 : offset과 limit를 이용하여 조회 결과 중 일부 행만 조회하는
	     //                마이바티스 객체
		
		MessagePageInfo pInfo = (MessagePageInfo)map.get("pInfo");
		
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset , pInfo.getLimit());
		
		map.put("pInfo",pInfo);
		
		return sqlSession.selectList("messageMapper.selectSendList", map, rowBounds);
	}


	/** 받은 쪽지 수 조회
	 * @param memberNo
	 * @return
	 */
	public int getReceivePageInfo(int memberNo) {
		return sqlSession.selectOne("messageMapper.getReceivePageInfo", memberNo);
	}


	/** 받은 쪽지 목록 조회
	 * @param map
	 * @return
	 */
	public List<Message> selectReceiveList(Map<String, Object> map) {
		MessagePageInfo pInfo = (MessagePageInfo)map.get("pInfo");
		
		int offset = (pInfo.getCurrentPage()-1) * pInfo.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset , pInfo.getLimit());
		
		map.put("pInfo",pInfo);		
		
		return  sqlSession.selectList("messageMapper.selectReceiveList", map);
	}
	
	
	/** 쪽지번호 얻어오기
	 * @return
	 */
	public int selectNextNo() {
		return sqlSession.selectOne("messageMapper.selectNextNo");
	}



	/** 쪽지 보내기
	 * @param map
	 * @return
	 */
	public int sendMessage(Map<String, Object> map) {
		return sqlSession.insert("messageMapper.sendMessage", map);
	}


	/** 메세지 읽음 상태 변경
	 * @param messageNo
	 * @return
	 */
	public int updateReadStatus(int messageNo) {
		return sqlSession.update("messageMapper.updateReadStatus",messageNo);
	}


	/** 보낸 메세지 삭제
	 * @param list
	 * @return
	 */
	public int deleteSendMessage(List<Integer> list) {
		return sqlSession.update("messageMapper.deleteSendMessage",list);
	}


	public int deleteReceiveMessage(List<Integer> list) {
		return sqlSession.update("messageMapper.deleteReceiveMessage",list);
	}


}
