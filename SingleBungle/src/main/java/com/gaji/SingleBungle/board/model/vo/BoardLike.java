package com.gaji.SingleBungle.board.model.vo;

public class BoardLike {
	private int memberNo; 	// 회원번호
	private int boardNo; 	// 게시글번호
	
	public BoardLike() {
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
		return "Like [memberNo=" + memberNo + ", boardNo=" + boardNo + "]";
	}
	
	
}
