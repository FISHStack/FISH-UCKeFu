package com.ukefu.webim.service.es;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.ukefu.webim.web.model.EkmKnowledge;

public abstract interface EkmKnowledgeESRepository  extends ElasticsearchRepository<EkmKnowledge, String>
{
	
	public abstract EkmKnowledge findByTitleAndOrgi(String title , String orgi );
	
	public abstract EkmKnowledge findByIdAndOrgi(String id , String orgi);
	
	public abstract Page<EkmKnowledge> findByDatastatusAndOrgi(boolean datastatus ,String orgi,Pageable page);
	
	public abstract List<EkmKnowledge> findByOrgiAndDatastatus(String orgi,boolean datastatus);
	
	public abstract Page<EkmKnowledge> findByKnowbaseidAndKnowledgetypeidAndDatastatusAndOrgi(String knowbaseid,String knowledgetypeid,boolean datastatus ,String orgi,Pageable page);
	
	public abstract List<EkmKnowledge> findByKnowbaseidAndDatastatusAndOrgi(String knowbaseid,boolean datastatus ,String orgi);
	
	public abstract List<EkmKnowledge> findByCreaterAndDatastatusAndOrgi(String creater,boolean datastatus ,String orgi);
	
	public abstract Page<EkmKnowledge> findByPubstatusAndDatastatusAndOrgi(String pubstatus, boolean datastatus ,String orgi, Pageable pageable);
	

}

