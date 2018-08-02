package com.ukefu.webim.web.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
/**
 * EKM-知识表
 *
 */
@Entity
@Table(name = "uk_ekm_knowledge")
@org.hibernate.annotations.Proxy(lazy = false)
public class EkmKnowledge implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1115593425069549681L;
	
	private String id ;
	private String title ;//名称
	private String summary;//摘要
	private String content;//内容
	private String tags;//标签
	private String keyword;//关键字
	private String dismenid;//所属维度ID（根级目录）
	private String dismentypeid;//所属维度分类ID（分支ID）
	private String organ ;//所属部门ID
	private String knowledgetypeid ;//所属知识分类ID
	private String knowbaseid ;//所属知识库ID
	private String pubstatus ;//知识状态（新建 new/审核中 wait/发布成功 pass/被驳回 rejected /已下架 down）
	private boolean datastatus;//数据状态
	private String version;//版本号

	private Date begintime ;//有效期-开始
	private Date endtime ;//有效期-结束
	
	private Date createtime ;
	private String creater;
	private String orgi ;
	

	
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
	
	
	
}
