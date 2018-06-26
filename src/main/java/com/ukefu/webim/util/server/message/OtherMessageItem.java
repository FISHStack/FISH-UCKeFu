package com.ukefu.webim.util.server.message;

public class OtherMessageItem implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3520656734252136303L;
	
	private String msgtype ;
	private String title;
	public String getMsgtype() {
		return msgtype;
	}
	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
