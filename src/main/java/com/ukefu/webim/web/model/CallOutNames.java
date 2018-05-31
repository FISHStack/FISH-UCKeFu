package com.ukefu.webim.web.model;

import java.util.Date;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.ukefu.util.UKTools;

@Entity
@Table(name = "uk_act_callnames")
@org.hibernate.annotations.Proxy(lazy = false)
public class CallOutNames implements java.io.Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id  = UKTools.getUUID();
	private String orgi ;		//租户ID
	private String organ ;		//创建部门
	private String creater ;	//创建人
	private String batid ;		//导入 批次ID
	
	private Date createtime = new Date();	//创建时间
	
	private Date updatetime = new Date();
	
	private String datastatus;	//数据状态（逻辑删除）
	private String status ;		//状态
	private int calls;			//拨打次数
	
	private boolean invalid ;	//多次未接通名单（6次以上）
	private boolean failed ;	//无效名单
	
	private String workstatus ;	//名单状态， 预约
	private Date optime ;		//预约的下次拨打时间
	
	
	private String owneruser ;	//分配 坐席
	private String ownerdept ;	//分配 部门
	
	private String dataid ;		//UKDataBean对象ID
	private String taskid ;		//任务ID
	private String filterid;	//筛选ID
	private String actid ;		//活动ID
	
	private String name ;		//名单名称	
	private String phonenumber;	//电话号码
	
	private Map<String,Object> properties ;

	@Id
	@Column(length = 32)
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "assigned")	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOrgi() {
		return orgi;
	}

	public void setOrgi(String orgi) {
		this.orgi = orgi;
	}

	public String getOrgan() {
		return organ;
	}

	public void setOrgan(String organ) {
		this.organ = organ;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getDatastatus() {
		return datastatus;
	}

	public void setDatastatus(String datastatus) {
		this.datastatus = datastatus;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCalls() {
		return calls;
	}

	public void setCalls(int calls) {
		this.calls = calls;
	}

	public boolean isInvalid() {
		return invalid;
	}

	public void setInvalid(boolean invalid) {
		this.invalid = invalid;
	}

	public boolean isFailed() {
		return failed;
	}

	public void setFailed(boolean failed) {
		this.failed = failed;
	}

	public String getBatid() {
		return batid;
	}

	public void setBatid(String batid) {
		this.batid = batid;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getOwneruser() {
		return owneruser;
	}

	public void setOwneruser(String owneruser) {
		this.owneruser = owneruser;
	}

	public String getOwnerdept() {
		return ownerdept;
	}

	public void setOwnerdept(String ownerdept) {
		this.ownerdept = ownerdept;
	}

	public String getDataid() {
		return dataid;
	}

	public void setDataid(String dataid) {
		this.dataid = dataid;
	}

	public String getTaskid() {
		return taskid;
	}

	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}

	public String getFilterid() {
		return filterid;
	}

	public void setFilterid(String filterid) {
		this.filterid = filterid;
	}

	public String getActid() {
		return actid;
	}

	public void setActid(String actid) {
		this.actid = actid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public Map<String, Object> getProperties() {
		return properties;
	}

	public void setProperties(Map<String, Object> properties) {
		this.properties = properties;
	}

	public String getWorkstatus() {
		return workstatus;
	}

	public void setWorkstatus(String workstatus) {
		this.workstatus = workstatus;
	}

	public Date getOptime() {
		return optime;
	}

	public void setOptime(Date optime) {
		this.optime = optime;
	}
}
