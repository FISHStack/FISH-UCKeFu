package com.ukefu.webim.util;

public enum RestResultType {
	OK(200, "OK") ,
	USER_DELETE(400, "ADMIN USER"),
	ORGAN_DELETE(500, "NOT EXIST"), 
	WORKORDERS_DELETE(600 , "WORKORDERS NOT EXIST"),
	WORKORDERS_NOTEXIST(601 , "WORKORDERS NOT EXIST");
	
	public int status ;
	private String message ;
	
	RestResultType(int status, String message) {
		this.status = status;
		this.message = message;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
