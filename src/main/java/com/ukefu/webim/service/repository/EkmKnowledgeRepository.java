package com.ukefu.webim.service.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ukefu.webim.web.model.EkmKnowledge;

public abstract interface EkmKnowledgeRepository  extends JpaRepository<EkmKnowledge, String>
{
	
	public abstract EkmKnowledge findByTitleAndOrgi(String title , String orgi );
	
	public abstract EkmKnowledge findByIdAndOrgi(String id , String orgi);
	
	public abstract Page<EkmKnowledge> findAll(Specification<EkmKnowledge> spec, Pageable page) ;
	
	public abstract List<EkmKnowledge> findByDatastatusAndOrgi(boolean datastatus ,String orgi);
	
	public abstract List<EkmKnowledge> findByKnowbaseidAndOrgi(String knowbaseid,String orgi);
	
	public abstract List<EkmKnowledge> findByKnowledgetypeidAndOrgi(String knowledgetypeid,String orgi);
	
}

