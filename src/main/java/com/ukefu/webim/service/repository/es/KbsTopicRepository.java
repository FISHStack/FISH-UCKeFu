package com.ukefu.webim.service.repository.es;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import com.ukefu.webim.web.model.Topic;

public interface KbsTopicRepository extends  ElasticsearchRepository<Topic, String> , KbsTopicEsCommonRepository {
	
}
