package com.gaji.SingleBungle.findFriend.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class FindFriendChatting {
	private int chattingNo;			// 채팅 번호
	private String message;			// 메세지
	private Timestamp createDate;	// 작성시간
	private int friendNo;			// 게시글 번호
	private int memNo;				// 회원 번호
	private String nickname;		// 닉네임
	private String memGrade;		// 멤버등급
	
	public FindFriendChatting() { }

	public FindFriendChatting(int chattingNo, String message, Timestamp createDate, int friendNo, int memNo,
			String nickname, String memGrade) {
		super();
		this.chattingNo = chattingNo;
		this.message = message;
		this.createDate = createDate;
		this.friendNo = friendNo;
		this.memNo = memNo;
		this.nickname = nickname;
		this.memGrade = memGrade;
	}

	public int getChattingNo() {
		return chattingNo;
	}

	public void setChattingNo(int chattingNo) {
		this.chattingNo = chattingNo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public int getFriendNo() {
		return friendNo;
	}

	public void setFriendNo(int friendNo) {
		this.friendNo = friendNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMemGrade() {
		return memGrade;
	}

	public void setMemGrade(String memGrade) {
		this.memGrade = memGrade;
	}

	@Override
	public String toString() {
		return "FindFriendChatting [chattingNo=" + chattingNo + ", message=" + message + ", createDate=" + createDate
				+ ", friendNo=" + friendNo + ", memNo=" + memNo + ", nickname=" + nickname + ", memGrade=" + memGrade
				+ "]";
	}

}