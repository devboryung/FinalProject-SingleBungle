package com.gaji.SingleBungle.cafe.model.vo;

import java.sql.Timestamp;

public class Cafe {
	
	private int cafeNo; // 게시글번호
	private String cafeTitle; // 게시글제목
	private String cafeContent; // 게시글내용
	private String cafeName; // 맛집이름
	private Timestamp createDate; // 작성일
	private String status; // 상태여부
	private int readCount; // 조회수
	private int likeCount; // 좋아요수
	private int categoryCode; // 카테고리코드
	private int memberNo; // 회원번호
	private String nickname; // 회원닉네임
	private String memberGrade; // 회원등급코드
	private String categoryName; // 카테고리명
	private String cafeAddress; // 맛집주소
	
	public Cafe() {
	}
	
	

	public String getCafeAddress() {
		return cafeAddress;
	}



	public void setCafeAddress(String cafeAddress) {
		this.cafeAddress = cafeAddress;
	}



	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getCafeNo() {
		return cafeNo;
	}

	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}

	public String getCafeTitle() {
		return cafeTitle;
	}

	public void setCafeTitle(String cafeTitle) {
		this.cafeTitle = cafeTitle;
	}

	public String getCafeContent() {
		return cafeContent;
	}

	public void setCafeContent(String cafeContent) {
		this.cafeContent = cafeContent;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
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



	@Override
	public String toString() {
		return "Cafe [cafeNo=" + cafeNo + ", cafeTitle=" + cafeTitle + ", cafeContent=" + cafeContent + ", cafeName="
				+ cafeName + ", createDate=" + createDate + ", status=" + status + ", readCount=" + readCount
				+ ", likeCount=" + likeCount + ", categoryCode=" + categoryCode + ", memberNo=" + memberNo
				+ ", nickname=" + nickname + ", memberGrade=" + memberGrade + ", categoryName=" + categoryName
				+ ", cafeAddress=" + cafeAddress + "]";
	}






}
