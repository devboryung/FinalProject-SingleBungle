package com.gaji.SingleBungle.review.model.vo;

import java.sql.Timestamp;

public class ReviewReply {
	
	private int replyNo;
	private String replyContent;
	private Timestamp replyCreateDt;
	private String replyStatus;
	private int replyDepth;
	private int memberNo;
	private String nickName;
	private int parentBoardNo;
	private int parentReplyNo;
	private String memberGrade;
	
	public ReviewReply() {}

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
		return "ReviewReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyCreateDt=" + replyCreateDt
				+ ", replyStatus=" + replyStatus + ", replyDepth=" + replyDepth + ", memberNo=" + memberNo
				+ ", nickName=" + nickName + ", parentBoardNo=" + parentBoardNo + ", parentReplyNo=" + parentReplyNo
				+ ", memberGrade=" + memberGrade + "]";
	}
	


	

	
	
	
	

}
