package com.gaji.SingleBungle.cafe.model.vo;

public class CafeAttachment {
	
	private int fileNo; 		// 이미지번호
	private String filePath;	// 파일경로
	private String fileName;	// 파일이름
	private int cafeNo;			// 게시글번호
	private int fileLevel;
	
	public CafeAttachment() {
	}
	
	

	public CafeAttachment(String filePath, String fileName, int cafeNo, int fileLevel) {
		super();
		this.filePath = filePath;
		this.fileName = fileName;
		this.cafeNo = cafeNo;
		this.fileLevel = fileLevel;
	}



	public CafeAttachment(int fileNo, String filePath, String fileName, int cafeNo, int fileLevel) {
		super();
		this.fileNo = fileNo;
		this.filePath = filePath;
		this.fileName = fileName;
		this.cafeNo = cafeNo;
		this.fileLevel = fileLevel;
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

	public int getCafeNo() {
		return cafeNo;
	}

	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}

	public int getFileLevel() {
		return fileLevel;
	}

	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}

	@Override
	public String toString() {
		return "CafeAttachment [fileNo=" + fileNo + ", filePath=" + filePath + ", fileName=" + fileName + ", cafeNo="
				+ cafeNo + ", fileLevel=" + fileLevel + "]";
	}


	
	

}
