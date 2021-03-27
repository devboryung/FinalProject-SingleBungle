package com.gaji.SingleBungle.member.model.vo;

import java.sql.Timestamp;

public class MReply {
	//REPLY_NO, REPLY_CONTENT, PARENT_BOARD_NO, BOARD_CD, BOARD_TITLE, '자유게시판' TYPE, CREATE_DT
	
	private int replyNo;
	private String replyContent;
	private int parentBoardNo;
	private int boardCd;
	private String boardTitle;
	private String type;
	private Timestamp createDt;
	
	public MReply() {
	}

	@Override
	public String toString() {
		return "MReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", parentBoardNo=" + parentBoardNo
				+ ", boardCd=" + boardCd + ", boardTitle=" + boardTitle + ", type=" + type + ", createDt=" + createDt
				+ "]";
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

	public int getParentBoardNo() {
		return parentBoardNo;
	}

	public void setParentBoardNo(int parentBoardNo) {
		this.parentBoardNo = parentBoardNo;
	}

	public int getBoardCd() {
		return boardCd;
	}

	public void setBoardCd(int boardCd) {
		this.boardCd = boardCd;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Timestamp getCreateDt() {
		return createDt;
	}

	public void setCreateDt(Timestamp createDt) {
		this.createDt = createDt;
	}

	public MReply(int replyNo, String replyContent, int parentBoardNo, int boardCd, String boardTitle, String type,
			Timestamp createDt) {
		super();
		this.replyNo = replyNo;
		this.replyContent = replyContent;
		this.parentBoardNo = parentBoardNo;
		this.boardCd = boardCd;
		this.boardTitle = boardTitle;
		this.type = type;
		this.createDt = createDt;
	}
	
	
	
}
