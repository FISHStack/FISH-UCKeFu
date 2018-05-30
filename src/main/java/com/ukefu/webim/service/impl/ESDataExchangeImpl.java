package com.ukefu.webim.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.web.model.MetadataTable;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.TableProperties;
import com.ukefu.webim.web.model.User;

@Repository("esdataservice")
public class ESDataExchangeImpl{

	@Autowired
	private UserRepository userRes ;
	
	@Autowired
	private OrganRepository organRes ;
	
	public void saveIObject(UKDataBean dataBean) throws Exception {
		if(dataBean.getId() == null) {
			dataBean.setId((String) dataBean.getValues().get("id"));
		}
		UKDataContext.getTemplet().getClient().prepareIndex(UKDataContext.SYSTEM_INDEX,
						dataBean.getTable().getTablename(), dataBean.getId())
				.setSource(processValues(dataBean)).execute().actionGet();
	}
	/**
	 * 处理数据，包含 自然语言处理算法计算 智能处理字段
	 * @param dataBean
	 * @return
	 * @throws Exception 
	 */
	private Map<String , Object> processValues(UKDataBean dataBean) throws Exception{
		Map<String , Object> values = new HashMap<String , Object>() ;
		for(TableProperties tp : dataBean.getTable().getTableproperty()){
			if(dataBean.getValues().get(tp.getFieldname())!=null){
				values.put(tp.getFieldname(), dataBean.getValues().get(tp.getFieldname())) ;
			}else if(tp.getDatatypename().equals("nlp") && dataBean.getValues()!=null){
				//智能处理， 需要计算过滤HTML内容，自动获取关键词、摘要、实体识别、情感分析、信息指纹 等功能
				values.put(tp.getFieldname(), dataBean.getValues().get(tp.getFieldname())) ;
			}else{
				values.put(tp.getFieldname(), dataBean.getValues().get(tp.getFieldname())) ;
			}
		}
		return values ;
	}

	public void deleteIObject(UKDataBean dataBean ) throws Exception {
		if(dataBean.getTable()!=null){
			UKDataContext.getTemplet().getClient().prepareDelete(UKDataContext.SYSTEM_INDEX, dataBean.getTable().getTablename(), dataBean.getId()).setRefresh(true).execute().actionGet();
		}
	}
	/**
	 * 批量删除，单次最大删除 10000条
	 * @param query
	 * @param index
	 * @param type
	 * @throws Exception
	 */
	public void deleteByCon(QueryBuilder query ,String type) throws Exception {
		BulkRequestBuilder bulkRequest = UKDataContext.getTemplet().getClient().prepareBulk();  
	    SearchResponse response = UKDataContext.getTemplet().getClient().prepareSearch(UKDataContext.SYSTEM_INDEX).setTypes(type)  
	            .setSearchType(SearchType.DFS_QUERY_THEN_FETCH)  
	            .setQuery(query)  
	            .setFrom(0).setSize(10000).setExplain(true).execute().actionGet();  
	    for(SearchHit hit : response.getHits()){  
	        String id = hit.getId();  
	        bulkRequest.add(UKDataContext.getTemplet().getClient().prepareDelete(UKDataContext.SYSTEM_INDEX, type, id).request());  
	    }  
	    bulkRequest.get();  
	}

	public void deleteById(String type , String id){
		if(!StringUtils.isBlank(type) && !StringUtils.isBlank(id)){
			UKDataContext.getTemplet().getClient()
			.prepareDelete(UKDataContext.SYSTEM_INDEX, type, id).execute().actionGet();
		}
	}
	
	
	public UKDataBean getIObjectByPK(UKDataBean dataBean , String id) {
		if(dataBean.getTable()!=null){
			GetResponse getResponse = UKDataContext.getTemplet().getClient()
					.prepareGet(UKDataContext.SYSTEM_INDEX,
							dataBean.getTable().getTablename(), dataBean.getId())
					.execute().actionGet();
			dataBean.setValues(getResponse.getSource());
		}else{
			dataBean.setValues(new HashMap<String,Object>());
		}
		
		return dataBean;
	}
	
	public void updateIObject(UKDataBean dataBean) throws Exception {
		if(dataBean.getId() == null) {
			dataBean.setId((String) dataBean.getValues().get("id"));
		}
		UKDataBean oldDataBean = (UKDataBean) this.getIObjectByPK(dataBean , dataBean.getId()) ;
		
		for(TableProperties tp : dataBean.getTable().getTableproperty()){
			if(oldDataBean.getValues()!=null&&oldDataBean.getValues().get(tp.getFieldname())!=null){
				if(dataBean.getValues().get(tp.getFieldname())==null){
					dataBean.getValues().put(tp.getFieldname(), oldDataBean.getValues().get(tp.getFieldname())) ;
				}
			}
		}
		UKDataContext.getTemplet().getClient()
				.prepareUpdate(UKDataContext.SYSTEM_INDEX,
						dataBean.getTable().getTablename(), dataBean.getId()).setDoc(processValues(dataBean)).execute().actionGet();
	}

	/**
	 * 
	 * @param dataBean
	 * @param ps
	 * @param start
	 * @return
	 */
	public PageImpl<UKDataBean> findPageResult(QueryBuilder query,String index ,MetadataTable metadata, Pageable page , boolean loadRef) {
		List<UKDataBean> dataBeanList = new ArrayList<UKDataBean>() ;
		SearchRequestBuilder searchBuilder = UKDataContext.getTemplet().getClient().prepareSearch(UKDataContext.SYSTEM_INDEX).setTypes(metadata.getTablename()) ;
	
		int start = page.getPageSize() * page.getPageNumber();
		searchBuilder.setFrom(start).setSize(page.getPageSize()) ;
		
		SearchResponse response = searchBuilder.setQuery(query).execute().actionGet();
		List<String> users = new ArrayList<String>() , organs = new ArrayList<String>();
		for(SearchHit hit : response.getHits().getHits()){
			UKDataBean temp = new UKDataBean() ;
			temp.setTable(metadata);
			temp.setValues(hit.getSource());
			dataBeanList.add(temp) ;
			
			if(!StringUtils.isBlank((String)temp.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT))) {
				users.add((String)temp.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT)) ;
			}
			if(!StringUtils.isBlank((String)temp.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN))) {
				organs.add((String)temp.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN)) ;
			}
		}
		
		if(users.size() > 0) {
			List<User> userList = userRes.findAll(users) ;
			for(UKDataBean dataBean : dataBeanList) {
				String userid = (String)dataBean.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT) ;
				if(!StringUtils.isBlank(userid)) {
					for(User user : userList) {
						if(user.getId().equals(userid)) {
							dataBean.setUser(user);
							break ;
						}
					}
				}
			}
		}
		if(organs.size() > 0) {
			List<Organ> organList = organRes.findAll(organs) ;
			for(UKDataBean dataBean : dataBeanList) {
				String organid = (String)dataBean.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN) ;
				if(!StringUtils.isBlank(organid)) {
					for(Organ organ : organList) {
						if(organ.getId().equals(organid)) {
							dataBean.setOrgan(organ);
							break ;
						}
					}
				}
			}
		}
		return new PageImpl<UKDataBean>(dataBeanList,page , (int)response.getHits().getTotalHits());
	}
}
