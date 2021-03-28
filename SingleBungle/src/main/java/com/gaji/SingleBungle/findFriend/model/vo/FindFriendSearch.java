package com.gaji.SingleBungle.findFriend.model.vo;

public class FindFriendSearch {
	private String sk;
	private String sv;
	private String ct;
	private String sort;
	
	
	public FindFriendSearch() {	}


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
		return "FindFriendSearch [sk=" + sk + ", sv=" + sv + ", ct=" + ct + ", sort=" + sort + "]";
	}
	
	
	
}
