package com.gaji.SingleBungle.member.model.vo;

import java.sql.Date;

public class Member {
	private int memberNo; // 회원번호 
	private String memberId; // 아이디
	private String memberPwd; // 비밀번호
	private String memberName; // 이름
	private String memberNickname; // 닉네임
	private String memberPhone; // 전화번호
	private String memberEmail; // 이메일
	private String memberGender; // 성별
	private String memberScsnFl; // 탈퇴 여부
	private Date memberSignDt; // 가입일
	//private int memberRating; // 매너온도
	private String memberGrade; // 등급
	private String memberCertifiedFl; // 동네인증 여부
	private String address; // 
	
	
	// 기본 생성자
	public Member() { }


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getMemberPwd() {
		return memberPwd;
	}


	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getMemberNickname() {
		return memberNickname;
	}


	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}


	public String getMemberPhone() {
		return memberPhone;
	}


	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}


	public String getMemberEmail() {
		return memberEmail;
	}


	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}


	public String getMemberGender() {
		return memberGender;
	}


	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}


	public String getMemberScsnFl() {
		return memberScsnFl;
	}


	public void setMemberScsnFl(String memberScsnFl) {
		this.memberScsnFl = memberScsnFl;
	}


	public Date getMemberSignDt() {
		return memberSignDt;
	}


	public void setMemberSignDt(Date memberSignDt) {
		this.memberSignDt = memberSignDt;
	}


	public String getMemberGrade() {
		return memberGrade;
	}


	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}


	public String getMemberCertifiedFl() {
		return memberCertifiedFl;
	}


	public void setMemberCertifiedFl(String memberCertifiedFl) {
		this.memberCertifiedFl = memberCertifiedFl;
	}


	public String getAddress() {
		return address;
	}

 
	public void setAddress(String address) {
		this.address = address;
	}




	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPwd=" + memberPwd + ", memberName="
				+ memberName + ", memberNickname=" + memberNickname + ", memberPhone=" + memberPhone + ", memberEmail="
				+ memberEmail + ", memberGender=" + memberGender + ", memberScsnFl=" + memberScsnFl + ", memberSignDt="
				+ memberSignDt + ", memberGrade=" + memberGrade + ", memberCertifiedFl=" + memberCertifiedFl
				+ ", address=" + address + "]";
	}


	public Member(int memberNo, String memberId, String memberPwd, String memberName, String memberNickname,
			String memberPhone, String memberEmail, String memberGender, String memberScsnFl, Date memberSignDt,
			String memberGrade, String memberCertifiedFl, String address) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPwd = memberPwd;
		this.memberName = memberName;
		this.memberNickname = memberNickname;
		this.memberPhone = memberPhone;
		this.memberEmail = memberEmail;
		this.memberGender = memberGender;
		this.memberScsnFl = memberScsnFl;
		this.memberSignDt = memberSignDt;
		this.memberGrade = memberGrade;
		this.memberCertifiedFl = memberCertifiedFl;
		this.address = address;
	}


	
	// alt + shift + s
	// toString 

	
	// getter setter
}
