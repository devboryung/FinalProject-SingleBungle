package com.gaji.SingleBungle.review.model.vo;

public class ReviewLike {
	
	private int memberNo;
	private int boardNo;
	
	public ReviewLike() {
		// TODO Auto-generated constructor stub
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	@Override
	public String toString() {
		return "ReviewLike [memberNo=" + memberNo + ", boardNo=" + boardNo + "]";
	}
	

}
