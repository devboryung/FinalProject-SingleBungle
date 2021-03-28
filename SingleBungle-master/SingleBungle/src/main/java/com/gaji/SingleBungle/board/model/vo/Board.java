package com.gaji.SingleBungle.board.model.vo;

import java.sql.Timestamp;

public class Board {
	
	private int boardNo; 			// 게시글번호
	private String boardTitle; 		// 게시글제목
	private String boardContent; 	// 게시글내용
	private Timestamp createDate; 	// 작성일
	private String status; 			// 상태여부
	private int readCount; 			// 조회수
	private int likeCount; 			// 좋아요수
	private int boardCode; 			// 게시판코드
	private int categoryCode; 		// 카테고리코드
	private int memberNo; 			// 회원번호
	private String nickname; 		// 회원닉네임
	private String memberGrade; 	// 회원등급코드
	private String categoryName;	// 카테고리명
	
	public Board() {
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

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMemberGrade() {
		return memberGrade;
	}

	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", createDate=" + createDate + ", status=" + status + ", readCount=" + readCount + ", likeCount="
				+ likeCount + ", boardCode=" + boardCode + ", categoryCode=" + categoryCode + ", memberNo=" + memberNo
				+ ", nickname=" + nickname + ", memberGrade=" + memberGrade + ", categoryName=" + categoryName + "]";
	}

	
	


}
