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
	private int quetype;//问题类型（选择题/问答题）
	private String orgi;//租户ID
	private String creater;//创建人
	private Date createtime;//创建时间
	private Date updatetime;//更新时间
	
	private String description;//描述
	private String memo;//备注
	private int score;//问题分值
	private String processid;//问卷ID
	private String wvtype;//类型（文字/语音）
	private String quevoice;//问题语音ID
	
	private String confirmtype;//答案确认语类型
	private String confirmword;//答案确认语文字
	private String confirmvoice;//答案确认语语音
	
	private String overtimetype;//回答超时语
	private String overtimeword;//回答超时语文字
	private String overtimevoice;//回答超时语语音
	
	private String errortype;//回答错误语
	private String errorword;//回答错误语文字
	private String errorvoice;//回答错误语语音

	
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
	
	public String getWvtype() {
		return wvtype;
	}
	public void setWvtype(String wvtype) {
		this.wvtype = wvtype;
	}
	public String getQuevoice() {
		return quevoice;
	}
	public void setQuevoice(String quevoice) {
		this.quevoice = quevoice;
	}
	public String getConfirmtype() {
		return confirmtype;
	}
	public void setConfirmtype(String confirmtype) {
		this.confirmtype = confirmtype;
	}
	public String getConfirmword() {
		return confirmword;
	}
	public void setConfirmword(String confirmword) {
		this.confirmword = confirmword;
	}
	public String getConfirmvoice() {
		return confirmvoice;
	}
	public void setConfirmvoice(String confirmvoice) {
		this.confirmvoice = confirmvoice;
	}
	public String getOvertimetype() {
		return overtimetype;
	}
	public void setOvertimetype(String overtimetype) {
		this.overtimetype = overtimetype;
	}
	public String getOvertimeword() {
		return overtimeword;
	}
	public void setOvertimeword(String overtimeword) {
		this.overtimeword = overtimeword;
	}
	public String getOvertimevoice() {
		return overtimevoice;
	}
	public void setOvertimevoice(String overtimevoice) {
		this.overtimevoice = overtimevoice;
	}
	public String getErrortype() {
		return errortype;
	}
	public void setErrortype(String errortype) {
		this.errortype = errortype;
	}
	public String getErrorword() {
		return errorword;
	}
	public void setErrorword(String errorword) {
		this.errorword = errorword;
	}
	public String getErrorvoice() {
		return errorvoice;
	}
	public void setErrorvoice(String errorvoice) {
		this.errorvoice = errorvoice;
	}
	
	
}
