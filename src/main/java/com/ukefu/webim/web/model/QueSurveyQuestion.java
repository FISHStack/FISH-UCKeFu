package com.ukefu.webim.web.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name = "uk_que_survey_question")
@org.hibernate.annotations.Proxy(lazy = false)
public class QueSurveyQuestion implements java.io.Serializable{

	/**
	 * 问卷问题表
	 */
	private static final long serialVersionUID = 1115593425069549681L;
	
	private String id ;
	private String name;//问题名称
	private String sortindex;//问题序号
	private int quetype;//问题类型
	private String orgi;//租户ID
	private String creater;//创建人
	private Date createtime;//创建时间
	private Date updatetime;//更新时间
	
	private String description;//描述
	private String memo;//备注
	private int score;//问题分值
	private String processid;//问卷ID

	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSortindex() {
		return sortindex;
	}
	public void setSortindex(String sortindex) {
		this.sortindex = sortindex;
	}
	
	public String getOrgi() {
		return orgi;
	}
	public void setOrgi(String orgi) {
		this.orgi = orgi;
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
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public int getQuetype() {
		return quetype;
	}
	public void setQuetype(int quetype) {
		this.quetype = quetype;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getProcessid() {
		return processid;
	}
	public void setProcessid(String processid) {
		this.processid = processid;
	}
	
	
}
