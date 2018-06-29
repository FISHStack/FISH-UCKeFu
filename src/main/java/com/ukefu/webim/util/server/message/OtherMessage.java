package com.ukefu.webim.util.server.message;

import java.util.List;

public class OtherMessage implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3520656734252136303L;
	
	private String msgtype ;
	private String title;
	private String message ;
	private String id ;
	private boolean detail ;
	
	private List<OtherMessageItem> items ;
	
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
	public List<OtherMessageItem> getItems() {
		return items;
	}
	public void setItems(List<OtherMessageItem> items) {
		this.items = items;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public boolean isDetail() {
		return detail;
	}
	public void setDetail(boolean detail) {
		this.detail = detail;
	}
}
