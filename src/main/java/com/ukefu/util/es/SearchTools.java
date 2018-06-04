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
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("orgi", orgi)) ;
		
		for(FormFilterItem formFilterItem : itemList) {
			if(formFilterItem.getField().equals("q")) {
				queryBuilder.must(new QueryStringQueryBuilder(formFilterItem.getValue()).defaultOperator(Operator.AND)) ;
			}else {
				switch(formFilterItem.getCond()) {
					case "01" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).from(formFilterItem.getValue()).includeLower(false)) ;
						break ;
					case "02" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).from(formFilterItem.getValue()).includeLower(true)) ;
						break ;
					case "03" : 
						queryBuilder.must(rangeQuery(formFilterItem.getField()).to(formFilterItem.getValue()).includeUpper(false)) ;
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
		return search(queryBuilder, metadataTable, loadRef, p, ps);
	}
	
	public static PageImpl<UKDataBean> dissearch(String orgi , FormFilter formFilter , List<FormFilterItem> itemList , MetadataTable metadataTable , int p, int ps){
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("orgi", orgi)) ;
		queryBuilder.must(termQuery("status", UKDataContext.NamesDisStatusType.NOT.toString())) ;
		queryBuilder.must(termQuery("validresult", "valid")) ;
		
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
		return search(queryBuilder, metadataTable, false, p, ps);
	}
	
	public static PageImpl<UKDataBean> recoversearch(String orgi , String cmd ,String id, MetadataTable metadataTable , int p, int ps){
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("orgi", orgi)) ;
		queryBuilder.mustNot(termQuery("status", UKDataContext.NamesDisStatusType.NOT.toString())) ;
		queryBuilder.must(termQuery("validresult", "valid")) ;
		
		switch(cmd) {
			case "actid" : queryBuilder.must(termQuery("actid", id)) ; break ;
			case "batid" : queryBuilder.must(termQuery("batid", id)) ; break ;
			case "taskid" : queryBuilder.must(termQuery("taskid", id)) ; break ;
			case "filterid" : queryBuilder.must(termQuery("filterid", id)) ; break ;
			case "agent" : queryBuilder.must(termQuery(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, id)) ; break ;
			case "skill" : queryBuilder.must(termQuery(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, id)) ; break ;
			case "taskskill" : queryBuilder.must(termQuery("taskid", id)).must(termQuery("status", UKDataContext.NamesDisStatusType.DISAGENT.toString())) ; break ;
			case "filterskill" : queryBuilder.must(termQuery("filterid", id)).must(termQuery("status", UKDataContext.NamesDisStatusType.DISAGENT.toString())) ; break ;
			default : queryBuilder.must(termQuery("actid", "NOT_EXIST_KEY")) ;  //必须传入一个进来;
		}
		
		return search(queryBuilder, metadataTable, false, p, ps);
	}
	/**
	 * 
	 * @param orgi
	 * @param agent
	 * @param p
	 * @param ps
	 * @return
	 */
	public static PageImpl<UKDataBean> agentsearch(String orgi , String agent , int p, int ps){
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("orgi", orgi)) ;
		queryBuilder.must(termQuery("callstatus", UKDataContext.NameStatusTypeEnum.NOTCALL.toString())) ;
		queryBuilder.must(termQuery("validresult", "valid")) ;
		queryBuilder.must(termQuery(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, agent)) ;
		queryBuilder.must(termQuery("status", UKDataContext.NamesDisStatusType.DISAGENT.toString())) ;
		
		return search(queryBuilder, p, ps);
	}
	
	/**
	 * 
	 * @param orgi
	 * @param agent
	 * @param p
	 * @param ps
	 * @return
	 */
	public static PageImpl<UKDataBean> search(BoolQueryBuilder queryBuilder, int p, int ps){
		return search(queryBuilder, null, true, p, ps);
	}
	/**
	 * 
	 * @param queryBuilder
	 * @param metadataTable
	 * @param loadRef
	 * @param p
	 * @param ps
	 * @return
	 */
	private static PageImpl<UKDataBean> search(BoolQueryBuilder queryBuilder , MetadataTable metadataTable , boolean loadRef , int p, int ps){
		ESDataExchangeImpl esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		return esDataExchange.findPageResult(queryBuilder, UKDataContext.SYSTEM_INDEX, metadataTable, new PageRequest(p, ps) , loadRef) ;
	}
	
	/**
	 * 
	 * @param queryBuilder
	 * @param metadataTable
	 * @param loadRef
	 * @param p
	 * @param ps
	 * @return
	 */
	public static UKDataBean get(UKDataBean dataBean){
		ESDataExchangeImpl esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		return esDataExchange.getIObjectByPK(dataBean, dataBean.getId());
	}
	
	/**
	 * 
	 * @param queryBuilder
	 * @param metadataTable
	 * @param loadRef
	 * @param p
	 * @param ps
	 * @return
	 */
	public static UKDataBean get(String type, String id){
		ESDataExchangeImpl esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		return esDataExchange.getIObjectByPK(type, id);
	}
	
	/**
	 * 
	 * @param queryBuilder
	 * @param metadataTable
	 * @param loadRef
	 * @param p
	 * @param ps
	 * @return
	 */
	public static void save(UKDataBean dataBean){
		ESDataExchangeImpl esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		try {
			esDataExchange.saveIObject(dataBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
