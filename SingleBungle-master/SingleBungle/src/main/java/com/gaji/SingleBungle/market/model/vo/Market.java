package com.gaji.SingleBungle.market.model.vo;

import java.sql.Timestamp;

public class Market {
	
	private int marketNo;
	private String marketTitle;
	private String marketContent;
	private Timestamp createDt;
	private int readCount;
	private String marketFl;
	private int price;
	private String status;
	private String deliveryCharge;
	private int memNo;
	private int categoryCd;
	private int transactionCategory;
	private int transactionStatus;
	private int itemCount;
	private String nickname;
	private String certifiedFl;
	private String address;
	private String categoryNm;
	private int likes;

	
	
	public Market() {}

	
	
	public int getItemCount() {
		return itemCount;
	}



	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}


	public int getLikes() { 
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getMarketNo() {
		return marketNo;
	}

	public void setMarketNo(int marketNo) {
		this.marketNo = marketNo;
	}

	public String getMarketTitle() {
		return marketTitle;
	}

	public void setMarketTitle(String marketTitle) {
		this.marketTitle = marketTitle;
	}

	public String getMarketContent() {
		return marketContent;
	}

	public void setMarketContent(String marketContent) {
		this.marketContent = marketContent;
	}

	public Timestamp getCreateDt() {
		return createDt;
	}

	public void setCreateDt(Timestamp createDt) {
		this.createDt = createDt;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getMarketFl() {
		return marketFl;
	}

	public void setMarketFl(String marketFl) {
		this.marketFl = marketFl;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDeliveryCharge() {
		return deliveryCharge;
	}

	public void setDeliveryCharge(String deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
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

	public int getTransactionCategory() {
		return transactionCategory;
	}

	public void setTransactionCategory(int transactionCategory) {
		this.transactionCategory = transactionCategory;
	}

	public int getTransactionStatus() {
		return transactionStatus;
	}

	public void setTransactionStatus(int transactionStatus) {
		this.transactionStatus = transactionStatus;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getCertifiedFl() {
		return certifiedFl;
	}

	public void setCertifiedFl(String certifiedFl) {
		this.certifiedFl = certifiedFl;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCategoryNm() {
		return categoryNm;
	}

	public void setCategoryNm(String categoryNm) {
		this.categoryNm = categoryNm;
	}



	@Override
	public String toString() {
		return "Market [marketNo=" + marketNo + ", marketTitle=" + marketTitle + ", marketContent=" + marketContent
				+ ", createDt=" + createDt + ", readCount=" + readCount + ", marketFl=" + marketFl + ", price=" + price
				+ ", status=" + status + ", deliveryCharge=" + deliveryCharge + ", memNo=" + memNo + ", categoryCd="
				+ categoryCd + ", transactionCategory=" + transactionCategory + ", transactionStatus="
				+ transactionStatus + ", nickname=" + nickname + ", certifiedFl=" + certifiedFl + ", address=" + address
				+ ", categoryNm=" + categoryNm + ", likes=" + likes + ", itemCount=" + itemCount
				+ "]";
	}


}
