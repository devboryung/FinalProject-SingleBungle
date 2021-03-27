package com.gaji.SingleBungle.admin.vo;

public class AAttachment {
	private int fileNo;
	private String filePath;
	private String fileName;
	private int parentBoardNo;
	private int fileLevel;
	
	public AAttachment() {}

	

	public AAttachment(int fileNo, String filePath, String fileName, int parentBoardNo, int fileLevel) {
		super();
		this.fileNo = fileNo;
		this.filePath = filePath;
		this.fileName = fileName;
		this.parentBoardNo = parentBoardNo;
		this.fileLevel = fileLevel;
	}



	public AAttachment(String filePath, String fileName, int fileLevel, int parentBoardNo) {
		super();
		this.filePath = filePath;
		this.fileName = fileName;
		this.fileLevel = fileLevel;
		this.parentBoardNo = parentBoardNo;
		
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



	public int getParentBoardNo() {
		return parentBoardNo;
	}



	public void setParentBoardNo(int parentBoardNo) {
		this.parentBoardNo = parentBoardNo;
	}



	public int getFileLevel() {
		return fileLevel;
	}



	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}



	@Override
	public String toString() {
		return "AAttachment [fileNo=" + fileNo + ", filePath=" + filePath + ", fileName=" + fileName
				+ ", parentBoardNo=" + parentBoardNo + ", fileLevel=" + fileLevel + "]";
	}

	
	
	
	
}
