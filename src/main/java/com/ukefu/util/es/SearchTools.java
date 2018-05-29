package com.ukefu.util.es;

import static org.elasticsearch.index.query.QueryBuilders.rangeQuery;
import static org.elasticsearch.index.query.QueryBuilders.termQuery;

import java.util.List;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryStringQueryBuilder;
import org.elasticsearch.index.query.QueryStringQueryBuilder.Operator;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.service.impl.ESDataExchangeImpl;
import com.ukefu.webim.web.model.FormFilter;
import com.ukefu.webim.web.model.FormFilterItem;
import com.ukefu.webim.web.model.MetadataTable;

public class SearchTools {
	
	public static PageImpl<UKDataBean> search(String orgi , FormFilter formFilter , List<FormFilterItem> itemList , MetadataTable metadataTable , boolean loadRef , int p, int ps){
		ESDataExchangeImpl esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("orgi", orgi)) ;
		for(FormFilterItem formFilterItem : itemList) {
			if(formFilterItem.getField().equals("q")) {
				queryBuilder.must(new QueryStringQueryBuilder(formFilterItem.getValue()).defaultOperator(Operator.AND)) ;
			}else {
				switch(formFilterItem.getCond()) {
					case "01" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).from(formFilterItem.getValue())) ;
						break ;
					case "02" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).from(formFilterItem.getValue()).includeLower(true)) ;
						break ;
					case "03" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).to(formFilterItem.getValue())) ;
						break ;
					case "04" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).to(formFilterItem.getValue()).includeUpper(true)) ;
						break ;
					case "05" : 
						queryBuilder.must(termQuery(formFilterItem.getField() , formFilterItem.getValue())) ;
						break ;
					case "06" : 
						queryBuilder.mustNot(termQuery(formFilterItem.getField() , formFilterItem.getValue())) ;
						break ;
					case "07" : 
						queryBuilder.must(new QueryStringQueryBuilder(formFilterItem.getValue()).field(formFilterItem.getField()).defaultOperator(Operator.AND)) ;
						break ;
					default :
						break ;
				}
			}
		}
		return esDataExchange.findPageResult(queryBuilder, UKDataContext.SYSTEM_INDEX, metadataTable, new PageRequest(p, ps) , loadRef) ;
	}
}
