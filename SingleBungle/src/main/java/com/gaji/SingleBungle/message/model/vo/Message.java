package com.gaji.SingleBungle.message.model.vo;

import java.sql.Timestamp;

public class Message {
	
	private int messageNo;
	private int sendMember;
	private int receiveMember;
	private String sendNickName;
	private String receiveNickName;
	private String messageContent;
	private Timestamp createDt;
	private String messageStatus;
	private String readMessage;
	private String receiveStatus;
	private String readStatus;
	
	
	
	public int getMessageNo() {
		return messageNo;
	}
	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}
	public int getSendMember() {
		return sendMember;
	}
	public void setSendMember(int sendMember) {
		this.sendMember = sendMember;
	}
	public int getReceiveMember() {
		return receiveMember;
	}
	public void setReceiveMember(int receiveMember) {
		this.receiveMember = receiveMember;
	}
	public String getSendNickName() {
		return sendNickName;
	}
	public void setSendNickName(String sendNickName) {
		this.sendNickName = sendNickName;
	}
	public String getReceiveNickName() {
		return receiveNickName;
	}
	public void setReceiveNickName(String receiveNickName) {
		this.receiveNickName = receiveNickName;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public Timestamp getCreateDt() {
		return createDt;
	}
	public void setCreateDt(Timestamp createDt) {
		this.createDt = createDt;
	}
	public String getMessageStatus() {
		return messageStatus;
	}
	public void setMessageStatus(String messageStatus) {
		this.messageStatus = messageStatus;
	}
	public String getReadMessage() {
		return readMessage;
	}
	public void setReadMessage(String readMessage) {
		this.readMessage = readMessage;
	}
	public String getReceiveStatus() {
		return receiveStatus;
	}
	public void setReceiveStatus(String receiveStatus) {
		this.receiveStatus = receiveStatus;
	}
	public String getReadStatus() {
		return readStatus;
	}
	public void setReadStatus(String readStatus) {
		this.readStatus = readStatus;
	}
	@Override
	public String toString() {
		return "Message [messageNo=" + messageNo + ", sendMember=" + sendMember + ", receiveMember=" + receiveMember
				+ ", sendNickName=" + sendNickName + ", receiveNickName=" + receiveNickName + ", messageContent="
				+ messageContent + ", createDt=" + createDt + ", messageStatus=" + messageStatus + ", readMessage="
				+ readMessage + ", receiveStatus=" + receiveStatus + ", readStatus=" + readStatus + "]";
	}
	
	
	
	
}
