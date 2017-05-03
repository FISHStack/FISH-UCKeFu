package com.ukefu.util.task;


public class DSDataEvent {
	public DSData dsData ;
	
	private boolean failures;
	
	private long times ;
	
	private String message ;
	
	public DSData getDSData() {
		return dsData;
	}

	public void setDSData(DSData dsData) {
		this.dsData = dsData;
	}

	public boolean isFailures() {
		return failures;
	}

	public void setFailures(boolean failures) {
		this.failures = failures;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public long getTimes() {
		return times;
	}

	public void setTimes(long times) {
		this.times = times;
	}

}
