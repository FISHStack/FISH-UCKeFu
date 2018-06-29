package com.ukefu.webim.util.server.message;

public class OtherMessageItem implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3520656734252136303L;
	
	private String msgtype ;
	private String title;
	private String id ;
	private String content ;
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
