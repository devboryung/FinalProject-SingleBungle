package com.gaji.SingleBungle.admin.vo;

import java.sql.Timestamp;

public class Reply {

	private int replyNo;
	private String replyContent;
	private Timestamp replyCreateDt;
	private String replyStatus;
	private int replyDepth;
	private int memNo;
	private String nickname;
	private int parentBoardNo;
	private int parentReplyNo;
	private int boardCode;
	
	public Reply() {}

	public Reply(int replyNo, String replyContent, Timestamp replyCreateDt, String replyStatus, int replyDepth,
			int memNo, String nickname, int parentBoardNo, int parentReplyNo, int boardCode) {
		super();
		this.replyNo = replyNo;
		this.replyContent = replyContent;
		this.replyCreateDt = replyCreateDt;
		this.replyStatus = replyStatus;
		this.replyDepth = replyDepth;
		this.memNo = memNo;
		this.nickname = nickname;
		this.parentBoardNo = parentBoardNo;
		this.parentReplyNo = parentReplyNo;
		this.boardCode = boardCode;
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

	public int getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(int boardCode) {
		this.boardCode = boardCode;
	}

	@Override
	public String toString() {
		return "Reply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyCreateDt=" + replyCreateDt
				+ ", replyStatus=" + replyStatus + ", replyDepth=" + replyDepth + ", memNo=" + memNo + ", nickname="
				+ nickname + ", parentBoardNo=" + parentBoardNo + ", parentReplyNo=" + parentReplyNo + ", boardCode="
				+ boardCode + "]";
	}

	
	
	
}
