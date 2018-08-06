package com.ukefu.webim.service.es;

import java.util.List;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.ukefu.webim.web.model.EkmKnowledgeTimes;

public abstract interface EkmKnowledgeTimesESRepository  extends ElasticsearchRepository<EkmKnowledgeTimes, String>
{
	
	public abstract List<EkmKnowledgeTimes> findByKnowledgeidAndOrgi(String knowledgeid , String orgi );
	
}

