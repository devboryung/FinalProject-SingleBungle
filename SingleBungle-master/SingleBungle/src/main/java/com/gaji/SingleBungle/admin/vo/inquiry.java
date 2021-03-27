package com.gaji.SingleBungle.admin.vo;

import java.sql.Date;

public class inquiry {
	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryContent;
	private Date createDate;
	private String inquiryFl;
	private int categoryCode;
	private int memberNo;
	private String categoryNm;
	
	public inquiry() {}

	public inquiry(int inquiryNo, String inquiryTitle, String inquiryContent, Date createDate, String inquiryFl,
			int categoryCode, int memberNo) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.createDate = createDate;
		this.inquiryFl = inquiryFl;
		this.categoryCode = categoryCode;
		this.memberNo = memberNo;
		this.categoryNm = categoryNm;
	}

	
	
	public String getCategoryNm() {
		return categoryNm;
	}

	public void setCategoryNm(String categoryNm) {
		this.categoryNm = categoryNm;
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getInquiryFl() {
		return inquiryFl;
	}

	public void setInquiryFl(String inquiryFl) {
		this.inquiryFl = inquiryFl;
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
		return "inquiry [inquiryNo=" + inquiryNo + ", inquiryTitle=" + inquiryTitle + ", inquiryContent="
				+ inquiryContent + ", createDate=" + createDate + ", inquiryFl=" + inquiryFl + ", categoryCode="
				+ categoryCode + ", memberNo=" + memberNo + ", categoryNm=" + categoryNm + "]";
	}

	

	
	
	
}
