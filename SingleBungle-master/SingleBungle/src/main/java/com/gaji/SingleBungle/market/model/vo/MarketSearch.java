package com.gaji.SingleBungle.market.model.vo;

public class MarketSearch {
	private String sk;
	private String sv;
	private String ct;
	private String sort;
	public MarketSearch(String sk, String sv, String ct, String sort) {
		super();
		this.sk = sk;
		this.ct = ct;
		this.sort = sort;
	}
	public String getSv() {
		return sv;
	}
	public void setSv(String sv) {
		this.sv = sv;
	}
	public String getCt() {
		return ct;
	}
	public void setCt(String ct) {
		this.ct = ct;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	@Override
	public String toString() {
		return "MarketSearch [sk=" + sk + ", sv=" + sv + ", ct=" + ct + ", sort=" + sort + "]";
	}

	
}
