package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmKnowledgeTypeAuth;

public abstract interface EkmKnowledgeTypeAuthRepository  extends JpaRepository<EkmKnowledgeTypeAuth, String>
{
	//查询我的分类按钮授权
	public abstract EkmKnowledgeTypeAuth findByUseridAndOrgi(String userid ,String orgi );
	
	public abstract List<EkmKnowledgeTypeAuth> findByKnowledgetypeidAndOrgi(String knowledgetypeid,String orgi );
	
	public abstract EkmKnowledgeTypeAuth findByIdAndOrgi(String id , String orgi );
	
}

