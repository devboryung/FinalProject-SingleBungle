package com.gaji.SingleBungle.findFriend.websocket;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gaji.SingleBungle.findFriend.model.service.FindFriendService;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendChatting;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class ChattingWebsocketHandler extends TextWebSocketHandler {
	
	@Autowired
	private FindFriendService service;
	
	private Logger logger = LoggerFactory.getLogger(ChattingWebsocketHandler.class);
	
	private Set<WebSocketSession> sessions
		= Collections.synchronizedSet(new HashSet<WebSocketSession>());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		logger.info("{}연결됨", session.getId());
		
		sessions.add(session);
		
		//logger.info(session.getPrincipal().getName() + "님 등장!");
		
	}
	
	// 클라이언트로부터 텍스트 메세지를 받았을 때 수행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		logger.info("전달받은 내용 : " + message.getPayload());
		
		JsonObject obj = new Gson().fromJson(message.getPayload(), JsonObject.class);
		
		logger.info("게시글 번호 : " + obj.get("friendNo").toString());
		logger.info("회원 번호 : " + obj.get("memberNo").toString());
		logger.info("채팅 내용 : " + obj.get("chat").toString());
		logger.info("회원 등급 : " + obj.get("memberGrade").toString());
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", obj.get("friendNo").toString());
		map.put("memberNo", obj.get("memberNo").toString());
		map.put("chat", obj.get("chat").toString());
		
		
		// 채팅 DB 저장
		int result = service.insertChat(map);
		
		for(WebSocketSession s : sessions) {
			
			// 현재 접속 중인 회원 아이디 얻어오기
			String loginMemberId = ((Member)s.getAttributes().get("loginMember")).getMemberId();
			logger.info(loginMemberId + "회원에게 채팅 전달");
			
			s.sendMessage(new TextMessage(message.getPayload()));
			
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	
		//logger.info(session.getPrincipal().getName() + "님 퇴장.");
	}
	
}
