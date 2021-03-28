package com.gaji.SingleBungle.board.model.vo;

import java.sql.Timestamp;

public class BoardReply {

	private int replyNo;
	private String replyContent;
	private Timestamp replyCreateDt;
	private String replyStatus;
	private int replyDepth;
	private int memNo;
	private String nickname;
	private int parentBoardNo;
	private int parentReplyNo;
	private String memberGrade;
	
	
	public BoardReply() {
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Timestamp getReplyCreateDt() {
		return replyCreateDt;
	}

	public void setReplyCreateDt(Timestamp replyCreateDt) {
		this.replyCreateDt = replyCreateDt;
	}

	public String getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(String replyStatus) {
		this.replyStatus = replyStatus;
	}

	public int getReplyDepth() {
		return replyDepth;
	}

	public void setReplyDepth(int replyDepth) {
		this.replyDepth = replyDepth;
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

	public int getParentBoardNo() {
		return parentBoardNo;
	}

	public void setParentBoardNo(int parentBoardNo) {
		this.parentBoardNo = parentBoardNo;
	}

	public int getParentReplyNo() {
		return parentReplyNo;
	}

	public void setParentReplyNo(int parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}
	
	

	public String getMemberGrade() {
		return memberGrade;
	}

	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}

	@Override
	public String toString() {
		return "BoardReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyCreateDt=" + replyCreateDt
				+ ", replyStatus=" + replyStatus + ", replyDepth=" + replyDepth + ", memNo=" + memNo + ", nickname="
				+ nickname + ", parentBoardNo=" + parentBoardNo + ", parentReplyNo=" + parentReplyNo + ", memberGrade="
				+ memberGrade + "]";
	}


	
	
	
}
