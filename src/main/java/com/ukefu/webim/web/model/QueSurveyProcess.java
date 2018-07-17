package com.ukefu.webim.web.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "uk_que_survey_process")
@org.hibernate.annotations.Proxy(lazy = false)
public class QueSurveyProcess implements java.io.Serializable{

	/**
	 * 问卷调查表
	 */
	private static final long serialVersionUID = 1115593425069549681L;
	
	private String id ;
	private String name;    //问卷名称
	private String scene;   //问卷适用场景（机器人呼出/坐席手动）
	private String welword; //问卷欢迎语（文字）
	private String welvoice;//问卷欢迎语ID（语音）
	private String weltype; //问卷欢迎语类型
	private String endword; //问卷结束语（文字）
	private String endvoice;//问卷结束语ID（语音）
	private String endtype; //问卷结束语类型
	private String totalscore;//参考评分值
	private String score;     //是否评分（0否1是）
	private String memo;      //问卷描述
	private String orgi;      //租户ID
	private String creater;   //创建人
	private Date createtime;  //创建时间
	private String updater;   //更新人
	private Date updatetime;  //更新时间
	
	private String prostatus;//问卷状态（0未发布/1发布）
	private String sumscore;//总评分
	private String description;//描述
	
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
	public String getScene() {
		return scene;
	}
	public void setScene(String scene) {
		this.scene = scene;
	}
	public String getWelword() {
		return welword;
	}
	public void setWelword(String welword) {
		this.welword = welword;
	}
	public String getWelvoice() {
		return welvoice;
	}
	public void setWelvoice(String welvoice) {
		this.welvoice = welvoice;
	}
	public String getWeltype() {
		return weltype;
	}
	public void setWeltype(String weltype) {
		this.weltype = weltype;
	}
	public String getEndword() {
		return endword;
	}
	public void setEndword(String endword) {
		this.endword = endword;
	}
	public String getEndvoice() {
		return endvoice;
	}
	public void setEndvoice(String endvoice) {
		this.endvoice = endvoice;
	}
	public String getEndtype() {
		return endtype;
	}
	public void setEndtype(String endtype) {
		this.endtype = endtype;
	}
	public String getTotalscore() {
		return totalscore;
	}
	public void setTotalscore(String totalscore) {
		this.totalscore = totalscore;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
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
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getProstatus() {
		return prostatus;
	}
	public void setProstatus(String prostatus) {
		this.prostatus = prostatus;
	}
	public String getSumscore() {
		return sumscore;
	}
	public void setSumscore(String sumscore) {
		this.sumscore = sumscore;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
