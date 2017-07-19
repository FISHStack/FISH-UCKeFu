package com.ukefu.webim.service.repository.es;

import java.util.List;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.springframework.data.domain.Page;

import com.ukefu.webim.web.model.Topic;

public interface KbsTopicEsCommonRepository {
	public Page<Topic> getTopicByCate(String cate ,String q, int p, int ps) ;
	
	public Page<Topic> getTopicByTop(boolean top , int p, int ps) ;
	
	public List<Topic> getTopicByOrgi(String orgi, String type , String q) ;
	
	public Page<Topic> getTopicByCateAndUser(String cate , String q ,String user , int p, int ps) ;
	
	public Page<Topic> getTopicByCon(BoolQueryBuilder booleanQueryBuilder , int p, int ps) ;
}
