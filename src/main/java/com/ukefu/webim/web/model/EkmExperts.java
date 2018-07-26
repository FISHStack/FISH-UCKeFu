package com.ukefu.webim.web.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "uk_ekm_experts")
@org.hibernate.annotations.Proxy(lazy = false)
public class EkmExperts implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1115593425069549681L;
	
	private String id ;
	private String userid ;//用户ID
	private String roleid ;//角色ID
	private String organ ;//用户所属部门ID
	private String bustype ;//业务类型（知识库专家experts/）
	private Date createtime ;
	private String creater;
	private String orgi ;
	
	private String auditimes;//审核知识总条数
	private String auditpass;//审核知识通过总条数
	private String auditreject;//审核知识驳回总条数
	
	@Id
	@Column(length = 32)
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getOrgan() {
		return organ;
	}
	public void setOrgan(String organ) {
		this.organ = organ;
	}
	public String getBustype() {
		return bustype;
	}
	public void setBustype(String bustype) {
		this.bustype = bustype;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getOrgi() {
		return orgi;
	}
	public void setOrgi(String orgi) {
		this.orgi = orgi;
	}
	public String getAuditimes() {
		return auditimes;
	}
	public void setAuditimes(String auditimes) {
		this.auditimes = auditimes;
	}
	public String getAuditpass() {
		return auditpass;
	}
	public void setAuditpass(String auditpass) {
		this.auditpass = auditpass;
	}
	public String getAuditreject() {
		return auditreject;
	}
	public void setAuditreject(String auditreject) {
		this.auditreject = auditreject;
	}
	
}
