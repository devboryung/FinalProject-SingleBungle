package com.gaji.SingleBungle.admin.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class ABoard {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Date boardCreateDate;
	private String boardStatus;
	private int readCount;
	private int boardCode;
	private int categoryCode;
	private int memberNo;
	
	public ABoard() {}

	public ABoard(int boardNo, String boardTitle, String boardContent, Date boardCreateDate, String boardStatus,
			int readCount, int boardCode, int categoryCode, int memberNo) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardCreateDate = boardCreateDate;
		this.boardStatus = boardStatus;
		this.readCount = readCount;
		this.boardCode = boardCode;
		this.categoryCode = categoryCode;
		this.memberNo = memberNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public Date getBoardCreateDate() {
		return boardCreateDate;
	}

	public void setBoardCreateDate(Date boardCreateDate) {
		this.boardCreateDate = boardCreateDate;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(int boardCode) {
		this.boardCode = boardCode;
	}

	public int getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "ABoard [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", boardCreateDate=" + boardCreateDate + ", boardStatus=" + boardStatus + ", readCount=" + readCount
				+ ", boardCode=" + boardCode + ", categoryCode=" + categoryCode + ", memberNo=" + memberNo + "]";
	}
	
	
	
	
}
