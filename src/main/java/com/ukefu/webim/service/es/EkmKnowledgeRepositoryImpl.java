package com.ukefu.webim.service.es;

import static org.elasticsearch.index.query.QueryBuilders.termQuery;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Component;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.web.model.EkmKnowledge;

@Component
public class EkmKnowledgeRepositoryImpl implements EkmKnowledgeESRepository{
	
	private ElasticsearchTemplate elasticsearchTemplate;

	@Autowired
	public void setElasticsearchTemplate(ElasticsearchTemplate elasticsearchTemplate) {
		this.elasticsearchTemplate = elasticsearchTemplate;
    }

	@Override
	public EkmKnowledge findByTitleAndOrgi(String title, String orgi) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder bq = QueryBuilders.boolQuery() ; 
		bq.must(QueryBuilders.termQuery("title", title)) ;
		bq.must(QueryBuilders.termQuery("orgi", orgi)) ;
		boolQueryBuilder.must(bq); 
		
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder) ;
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class ) ;
	    }
		
		return knowledgeList.getContent().get(0);
	}

	@Override
	public EkmKnowledge findByIdAndOrgi(String id, String orgi) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder bq = QueryBuilders.boolQuery() ; 
		bq.must(QueryBuilders.termQuery("id", id)) ;
		bq.must(QueryBuilders.termQuery("orgi", orgi)) ;
		boolQueryBuilder.must(bq); 
		
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder) ;
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class ) ;
	    }
		
		return knowledgeList.getContent().get(0);
	}

	@Override
	public Page<EkmKnowledge> findByDatastatusAndOrgi(boolean datastatus, String orgi, Pageable pageable) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder boolQueryBuilder1 = new BoolQueryBuilder();
		boolQueryBuilder1.should(termQuery("datastatus" , datastatus)) ;
		boolQueryBuilder.must(boolQueryBuilder1) ;
		boolQueryBuilder.must(termQuery("orgi" ,orgi)) ;
		
		return processQuery(boolQueryBuilder , pageable);
	}

	@Override
	public List<EkmKnowledge> findByOrgiAndDatastatus(String orgi, boolean datastatus) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder bq = QueryBuilders.boolQuery() ; 
		bq.must(QueryBuilders.termQuery("datastatus", datastatus)) ;
		bq.must(QueryBuilders.termQuery("orgi", orgi)) ;
		boolQueryBuilder.must(bq); 
		
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder) ;
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class ) ;
	    }
		
		return knowledgeList.getContent();
	}

	@Override
	public Page<EkmKnowledge> findByKnowbaseidAndKnowledgetypeidAndDatastatusAndOrgi(String knowbaseid,
			String knowledgetypeid, boolean datastatus, String orgi, Pageable page) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder boolQueryBuilder1 = new BoolQueryBuilder();
		boolQueryBuilder1.must(termQuery("datastatus" , datastatus)) ;
		boolQueryBuilder.must(boolQueryBuilder1) ;
		boolQueryBuilder.must(termQuery("orgi" ,orgi)) ;
		if(!StringUtils.isBlank(knowbaseid)){
			boolQueryBuilder.must(termQuery("knowbaseid" , knowbaseid)) ;
		}else{
			boolQueryBuilder.must(termQuery("knowbaseid" , UKDataContext.UKEFU_SYSTEM_NO_DAT)) ;
		}
		if(!StringUtils.isBlank(knowledgetypeid)){
			
			boolQueryBuilder.must(termQuery("knowledgetypeid" , knowledgetypeid)) ;
		}else{
			boolQueryBuilder.must(termQuery("knowledgetypeid" , UKDataContext.UKEFU_SYSTEM_NO_DAT)) ;
			
		}
		
		return processQuery(boolQueryBuilder , page);
	}

	@Override
	public List<EkmKnowledge> findByKnowbaseidAndDatastatusAndOrgi(String knowbaseid, boolean datastatus, String orgi) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder bq = QueryBuilders.boolQuery() ; 
		bq.must(QueryBuilders.termQuery("datastatus", datastatus)) ;
		bq.must(QueryBuilders.termQuery("orgi", orgi)) ;
		if(!StringUtils.isBlank(knowbaseid)){
			bq.must(termQuery("knowbaseid" , knowbaseid)) ;
		}else{
			bq.must(termQuery("knowbaseid" , UKDataContext.UKEFU_SYSTEM_NO_DAT)) ;
		}
		boolQueryBuilder.must(bq); 
		
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder) ;
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class ) ;
	    }
		
		return knowledgeList.getContent();
	}

	@Override
	public List<EkmKnowledge> findByCreaterAndDatastatusAndOrgi(String creater, boolean datastatus, String orgi) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder bq = QueryBuilders.boolQuery() ; 
		bq.must(QueryBuilders.termQuery("creater", creater)) ;
		bq.must(QueryBuilders.termQuery("datastatus", datastatus)) ;
		bq.must(QueryBuilders.termQuery("orgi", orgi)) ;
		boolQueryBuilder.must(bq); 
		
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder) ;
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class ) ;
	    }
		
		return knowledgeList.getContent();
	}

	@Override
	public Page<EkmKnowledge> findByPubstatusAndDatastatusAndOrgi(String pubstatus, boolean datastatus, String orgi,
			Pageable pageable) {
		
		BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
		BoolQueryBuilder boolQueryBuilder1 = new BoolQueryBuilder();
		boolQueryBuilder1.must(termQuery("pubstatus" , pubstatus)) ;
		boolQueryBuilder1.must(termQuery("datastatus" , datastatus)) ;
		boolQueryBuilder.must(boolQueryBuilder1) ;
		boolQueryBuilder.must(termQuery("orgi" ,orgi)) ;
		
		return processQuery(boolQueryBuilder , pageable);
	}
	
	private Page<EkmKnowledge> processQuery(BoolQueryBuilder boolQueryBuilder, Pageable page){
		NativeSearchQueryBuilder searchQueryBuilder = new NativeSearchQueryBuilder().withQuery(boolQueryBuilder).withSort(new FieldSortBuilder("createtime").unmappedType("date").order(SortOrder.DESC));
		
		searchQueryBuilder.withPageable(page) ;
		
		Page<EkmKnowledge> knowledgeList = null ;
		if(elasticsearchTemplate.indexExists(EkmKnowledge.class)){
			knowledgeList = elasticsearchTemplate.queryForPage(searchQueryBuilder.build() , EkmKnowledge.class) ;
		}
		return knowledgeList;
	}
}
