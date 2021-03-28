package com.gaji.SingleBungle.message.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaji.SingleBungle.message.model.dao.MessageDAO;
import com.gaji.SingleBungle.message.model.vo.Message;
import com.gaji.SingleBungle.message.model.vo.MessagePageInfo;

@Service
public class MessageServiceImpl implements MessageService {
	
	@Autowired
	private MessageDAO dao;

	// 보낸 쪽지 수 조회 
	@Override
	public MessagePageInfo getSendPageInfo(int cp, int memberNo) {
		int listCount = dao.getSendListCount(memberNo);
		return new MessagePageInfo(cp, listCount);
	}

	// 보낸 쪽지 목록 조회
	@Override
	public List<Message> selectSendList(Map<String, Object> map) {
		return dao.selectSendList(map);
	}

	// 받은 쪽지 수 조회
	@Override
	public MessagePageInfo getReceivePageInfo(int cp, int memberNo) {
			
		int listCount = dao.getReceivePageInfo(memberNo);
		
		return new MessagePageInfo(cp, listCount);
	}

	// 받은 쪽지 목록 조회
	@Override
	public List<Message> selectReceiveList(Map<String, Object> map) {
		return dao.selectReceiveList(map);
	}
	
	
	// 쪽지 보내기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int sendMessage(Map<String, Object> map) {
		// 쪽지번호 얻어오기
		int msgNo = dao.selectNextNo();
		
		
		map.put("msgNo",msgNo);
		
		
		int result =  dao.sendMessage(map);
		
		
		return result;
	}

	
	// 메세지 읽음 상태 변경
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReadStatus(int messageNo) {
		return dao.updateReadStatus(messageNo);
	}

	
	// 보낸 메세지 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteSendMessage(List<Integer> list) {
		return dao.deleteSendMessage(list);
	}

	
	// 받은 메세지 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReceiveMessage(List<Integer> list) {
		return dao.deleteReceiveMessage(list);
	}

}
