package com.gaji.SingleBungle.findFriend.model.vo;

public class FindFriendLike {
	private int memberNo;	// 회원 번호
	private int friendNo;	// 게시글 번호
	
	public FindFriendLike() { }

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getFriendNo() {
		return friendNo;
	}

	public void setFriendNo(int friendNo) {
		this.friendNo = friendNo;
	}

	@Override
	public String toString() {
		return "FindFriendLike [memberNo=" + memberNo + ", friendNo=" + friendNo + "]";
	}

}
