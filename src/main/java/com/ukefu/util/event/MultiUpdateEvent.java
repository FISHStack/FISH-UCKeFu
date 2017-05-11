package com.ukefu.util.event;

import org.springframework.data.repository.CrudRepository;

public class MultiUpdateEvent<S> implements UserEvent{
	
	private S data ;
	private CrudRepository<?, ?> crudRes ;
	private String eventype ;
	
	public MultiUpdateEvent(S data , CrudRepository<?, ?> crudRes , String eventype){
		this.data = data ;
		this.crudRes = crudRes ;
		this.eventype= eventype ;
	}
	
	public S getData() {
		return data;
	}
	public void setData(S data) {
		this.data = data;
	}
	public CrudRepository<?, ?> getCrudRes() {
		return crudRes;
	}
	public void setCrudRes(CrudRepository<?, ?> crudRes) {
		this.crudRes = crudRes;
	}
	public String getEventype() {
		return eventype;
	}
	public void setEventype(String eventype) {
		this.eventype = eventype;
	}
}
