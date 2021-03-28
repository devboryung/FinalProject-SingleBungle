package com.gaji.SingleBungle.admin.vo;

import java.sql.Timestamp;

public class inquiryReply {
	

	private int inquiryNo;
	private String inquiryContent;
	private Timestamp createDt;
	private int memberNo;

	
	public inquiryReply() {}


	public inquiryReply(int inquiryNo, String inquiryContent, Timestamp createDt, int memberNo) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryContent = inquiryContent;
		this.createDt = createDt;
		this.memberNo = memberNo;
	}


	public int getInquiryNo() {
		return inquiryNo;
	}


	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}


	public String getInquiryContent() {
		return inquiryContent;
	}


	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}


	public Timestamp getCreateDt() {
		return createDt;
	}


	public void setCreateDt(Timestamp createDt) {
		this.createDt = createDt;
	}


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	@Override
	public String toString() {
		return "inquiryReply [inquiryNo=" + inquiryNo + ", inquiryContent=" + inquiryContent + ", createDt=" + createDt
				+ ", memberNo=" + memberNo + "]";
	}

	
	

}
