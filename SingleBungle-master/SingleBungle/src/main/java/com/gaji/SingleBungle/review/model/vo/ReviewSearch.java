package com.gaji.SingleBungle.review.model.vo;

public class ReviewSearch {
	private String sk;
	private String sv;
	private String ct;
	private String sort;
	
	
	public ReviewSearch() {	}


	public String getSk() {
		return sk;
	}


	public void setSk(String sk) {
		this.sk = sk;
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
		return "ReviewSearch [sk=" + sk + ", sv=" + sv + ", ct=" + ct + ", sort=" + sort + "]";
	}
	
	
	
}
