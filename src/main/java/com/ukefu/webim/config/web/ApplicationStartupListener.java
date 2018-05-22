package com.ukefu.webim.config.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.data.elasticsearch.ElasticsearchException;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.stereotype.Component;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.web.model.Favorites;
import com.ukefu.webim.web.model.WorkOrders;

@Component
public class ApplicationStartupListener implements ApplicationListener<ContextRefreshedEvent> {
	
    @Autowired ElasticsearchTemplate elasticSearchTemplate;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
    	if (!elasticSearchTemplate.indexExists(WorkOrders.class)) {
            elasticSearchTemplate.createIndex(WorkOrders.class);
        }
    	if (!elasticSearchTemplate.indexExists(Favorites.class)) {
            elasticSearchTemplate.createIndex(Favorites.class);
        }
    	try {
    		elasticSearchTemplate.getMapping(WorkOrders.class);
        } catch (ElasticsearchException e) {
        	elasticSearchTemplate.putMapping(Favorites.class);
        	elasticSearchTemplate.putMapping(WorkOrders.class);
        }
    	UKDataContext.setTemplet(elasticSearchTemplate);
    }
}