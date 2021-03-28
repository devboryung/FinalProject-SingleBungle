package com.gaji.SingleBungle.board.model.vo;

public class BoardAttachment {
	
	private int fileNo; 		// 이미지번호
	private String filePath;	// 파일경로
	private String fileName;	// 파일이름
	private int parentBoardNo;		// 게시글번호
	private int fileLevel;
	
	
	public BoardAttachment() {
	}
	
	
	
	public BoardAttachment(String filePath, String fileName, int parentBoardNo, int fileLevel) {
		super();
		this.filePath = filePath;
		this.fileName = fileName;
		this.parentBoardNo = parentBoardNo;
		this.fileLevel = fileLevel;
	}



	public BoardAttachment(int fileNo, String filePath, String fileName, int parentBoardNo, int fileLevel) {
		super();
		this.fileNo = fileNo;
		this.filePath = filePath;
		this.fileName = fileName;
		this.parentBoardNo = parentBoardNo;
		this.fileLevel = fileLevel;
	}



	public BoardAttachment(String filePath, String fileName, int parentBoardNo) {
		super();
		this.filePath = filePath;
		this.fileName = fileName;
		this.parentBoardNo = parentBoardNo;
	}

	public BoardAttachment(int fileNo, String filePath, String fileName, int parentBoardNo) {
		super();
		this.fileNo = fileNo;
		this.filePath = filePath;
		this.fileName = fileName;
		this.parentBoardNo = parentBoardNo;
	}
	
	

	public int getFileLevel() {
		return fileLevel;
	}



	public void setFileLevel(int fileLevel) {
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


	public int getParentBoardNo() {
		return parentBoardNo;
	}


	public void setParentBoardNo(int parentBoardNo) {
		this.parentBoardNo = parentBoardNo;
	}



	@Override
	public String toString() {
		return "BoardAttachment [fileNo=" + fileNo + ", filePath=" + filePath + ", fileName=" + fileName
				+ ", parentBoardNo=" + parentBoardNo + ", fileLevel=" + fileLevel + "]";
	}




	

	
}
