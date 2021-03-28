package com.gaji.SingleBungle.market.model.vo;

import java.sql.Timestamp;

public class MarketReply {
	private int replyNo;			// 댓글 번호
	private String replyContent;	// 댓글 내용
	private Timestamp replyCreateDt;		// 댓글 작성일
	private String replyStatus;		// 댓글 상태
	private int replyDepth;			// 댓글 깊이
	private int parentMarketNo;		// 댓글이 작성된 게시글 번호
	private int memNo;				// 댓글 작성 회원 번호
	private int parentReplyNo;		// 부모 댓글 번호
	private String nickname;		// 닉네임
	private String memberGrade;

	 public MarketReply() {
		// TODO Auto-generated constructor stub
	}


	public String getMemberGrade() {
		return memberGrade;
	}


	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
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

	public int getParentMarketNo() {
		return parentMarketNo;
	}

	public void setParentMarketNo(int parentMarketNo) {
		this.parentMarketNo = parentMarketNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public int getParentReplyNo() {
		return parentReplyNo;
	}

	public void setParentReplyNo(int parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	@Override
	public String toString() {
		return "MarketReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyCreateDt=" + replyCreateDt
				+ ", replyStatus=" + replyStatus + ", replyDepth=" + replyDepth + ", parentMarketNo=" + parentMarketNo
				+ ", memNo=" + memNo + ", parentReplyNo=" + parentReplyNo + ", nickname=" + nickname + ", memberGrade="
				+ memberGrade + "]";
	}


}
