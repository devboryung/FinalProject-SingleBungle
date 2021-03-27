package com.gaji.SingleBungle.findFriend.model.vo;

public class FriendReport {
	
	private int reportNo; // 신고번호
	private String reportTitle; // 신고제목
	private String reportContent; // 신고내용
	private int memNo; // 신고한 회원번호
	private int categoryCd; // 신고 카테고리
	private int friendNo; // 게시글 번호
	
	public FriendReport() {
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

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public int getCategoryCd() {
		return categoryCd;
	}

	public void setCategoryCd(int categoryCd) {
		this.categoryCd = categoryCd;
	}

	public int getFriendNo() {
		return friendNo;
	}

	public void setFriendNo(int friendNo) {
		this.friendNo = friendNo;
	}

	@Override
	public String toString() {
		return "FriendReport [reportNo=" + reportNo + ", reportTitle=" + reportTitle + ", reportContent="
				+ reportContent + ", memNo=" + memNo + ", categoryCd=" + categoryCd + ", friendNo=" + friendNo + "]";
	}

}