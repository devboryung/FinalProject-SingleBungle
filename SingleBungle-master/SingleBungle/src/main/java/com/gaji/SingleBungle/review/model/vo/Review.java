package com.gaji.SingleBungle.review.model.vo;

import java.sql.Timestamp;

public class Review {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Timestamp createDate;
	private String status;
	private int readCount;
	private int boardCode;
	private int categoryCode;
	private String categoryName;
	private int memberNo;
	private String nickName;
	private int likeCount;
	private String memeberGrade;
	
	public Review() {}

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

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	

	public String getMemeberGrade() {
		return memeberGrade;
	}

	public void setMemeberGrade(String memeberGrade) {
		this.memeberGrade = memeberGrade;
	}

	@Override
	public String toString() {
		return "Review [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", createDate=" + createDate + ", status=" + status + ", readCount=" + readCount + ", boardCode="
				+ boardCode + ", categoryCode=" + categoryCode + ", categoryName=" + categoryName + ", memberNo="
				+ memberNo + ", nickName=" + nickName + ", likeCount=" + likeCount + ", memeberGrade=" + memeberGrade
				+ "]";
	}


	
	
	

	
	
	


	
	
}
