package com.ukefu.webim.service.es;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Repository;

import com.ukefu.webim.service.repository.EkmKnowledgeRepository;
import com.ukefu.webim.web.model.EkmKnowledge;

@Repository
public class EkmKnowledgeRepositoryImpl implements EkmKnowledgeRepository{
	
	private ElasticsearchTemplate elasticsearchTemplate;

	@Autowired
	public void setElasticsearchTemplate(ElasticsearchTemplate elasticsearchTemplate) {
		this.elasticsearchTemplate = elasticsearchTemplate;
    }
	
	private Page<EkmKnowledge> processQuery(BoolQueryBuilder boolQueryBuilder, Pageable page){
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder).withSort(new FieldSortBuilder("createtime").unmappedType("date").order(SortOrder.DESC));
		
		searchQueryBuilder.withPageable(page) ;
		
		
		Page<EkmKnowledge> workOrdersList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			workOrdersList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class) ;
		}
		
		return workOrdersList;
	}
}
