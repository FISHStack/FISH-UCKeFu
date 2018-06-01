package com.ukefu.util.es;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.ukefu.webim.web.model.MetadataTable;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.User;

public class UKDataBean implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8610410476273340864L;
	
	public String id ;
	private String creater ;	//创建人
	private String username;	//创建人用户名
	private String orgi ;		//租户ID
	private Date createtime ;	//创建时间
	private Date updatetime ;	//修改时间
	private MetadataTable table ;
	
	private String type ;
	
	private User user ;
	private Organ organ;
	
	private Map<String , Object> values = new HashMap<String , Object>();

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getOrgi() {
		return orgi;
	}

	public void setOrgi(String orgi) {
		this.orgi = orgi;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public MetadataTable getTable() {
		return table;
	}

	public void setTable(MetadataTable table) {
		this.table = table;
	}

	public Map<String, Object> getValues() {
		return values;
	}

	public void setValues(Map<String, Object> values) {
		this.values = values;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Organ getOrgan() {
		return organ;
	}

	public void setOrgan(Organ organ) {
		this.organ = organ;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
