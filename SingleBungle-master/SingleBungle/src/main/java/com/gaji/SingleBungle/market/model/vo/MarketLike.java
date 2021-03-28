package com.gaji.SingleBungle.market.model.vo;

public class MarketLike {
	private int memberNo; 	// 회원번호
	private int marketNo; 	// 게시글번호
	
	public MarketLike() {
	}

	
	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	public int getMarketNo() {
		return marketNo;
	}


	public void setMarketNo(int marketNo) {
		this.marketNo = marketNo;
	}


	@Override
	public String toString() {
		return "Like [memberNo=" + memberNo + ", marketNo=" + marketNo + "]";
	}
	
	
}