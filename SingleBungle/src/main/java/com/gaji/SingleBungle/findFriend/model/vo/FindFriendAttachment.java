package com.gaji.SingleBungle.findFriend.model.vo;

public class FindFriendAttachment {
	
	private int fileNo;			// 파일 번호
	private String filePath;	// 파일 경로
	private String fileName;	// 파일 이름
	private int friendNo;		// 게시글 번호
	
	public FindFriendAttachment() { }

	public FindFriendAttachment(String filePath, String fileName, int friendNo) {
		super();
		this.filePath = filePath;
		this.fileName = fileName;
		this.friendNo = friendNo;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getFriendNo() {
		return friendNo;
	}

	public void setFriendNo(int friendNo) {
		this.friendNo = friendNo;
	}

	@Override
	public String toString() {
		return "Attachment [fileNo=" + fileNo + ", filePath=" + filePath + ", fileName=" + fileName + ", friendNo="
				+ friendNo + "]";
	}
	
}
