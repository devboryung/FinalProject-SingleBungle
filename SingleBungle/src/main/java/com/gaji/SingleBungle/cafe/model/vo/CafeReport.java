package com.gaji.SingleBungle.cafe.model.vo;

public class CafeReport {
	
	private int reportNo; // 신고번호
	private String reportTitle; // 신고제목
	private String reportContent; // 신고내용
	private int memberNo; // 신고한 회원번호
	private int categoryCode; // 신고 카테고리
	private int cafeNo; // 게시글 번호
	
	public CafeReport() {
	}

	

	public int getReportNo() {
		return reportNo;
	}



	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}



	public String getReportTitle() {
		return reportTitle;
	}



	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}



	public String getReportContent() {
		return reportContent;
	}



	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}



	public int getMemberNo() {
		return memberNo;
	}



	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}



	public int getCategoryCode() {
		return categoryCode;
	}



	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}



	public int getCafeNo() {
		return cafeNo;
	}



	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}



	@Override
	public String toString() {
		return "CafeReport [reportNo=" + reportNo + ", reportTitle=" + reportTitle + ", reportContent=" + reportContent
				+ ", memberNo=" + memberNo + ", categoryCode=" + categoryCode + ", cafeNo=" + cafeNo + "]";
	}
	
	

}
