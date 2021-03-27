package com.gaji.SingleBungle.review.model.vo;

public class ReviewReplyReport {
	
	private int reportNo;
	private String reportTitle;
	private String reportContent;
	private int memberNo;
	private int categoryCode;
	private int replyNo;
	private int boardNo;
	
	
	public ReviewReplyReport() {
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


	public int getReplyNo() {
		return replyNo;
	}


	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}


	public int getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	@Override
	public String toString() {
		return "ReviewReplyReport [reportNo=" + reportNo + ", reportTitle=" + reportTitle + ", reportContent="
				+ reportContent + ", memberNo=" + memberNo + ", categoryCode=" + categoryCode + ", replyNo=" + replyNo
				+ ", boardNo=" + boardNo + "]";
	}
	
	

}
