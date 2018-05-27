package com.ukefu.webim.web.model;

public class FormFilterRequest {
	private String[] field;
	private String[] cond;
	private String[] value;
	
	public String[] getField() {
		return field;
	}

	public void setField(String[] field) {
		this.field = field;
	}

	public String[] getValue() {
		return value;
	}

	public void setValue(String[] value) {
		this.value = value;
	}

	public String[] getCond() {
		return cond;
	}

	public void setCond(String[] cond) {
		this.cond = cond;
	}

}
