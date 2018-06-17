package com.ukefu.webim.service.impl;

import java.util.Map;

import org.elasticsearch.action.bulk.BulkRequestBuilder;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.util.task.process.JPAProcess;
import com.ukefu.webim.web.model.MetadataTable;

public class BatchDataProcess implements JPAProcess{
	
	private MetadataTable metadata;
	private ESDataExchangeImpl esDataExchangeImpl ;
	private BulkRequestBuilder builder ;
	private long start ;
	
	public BatchDataProcess(MetadataTable metadata , ESDataExchangeImpl esDataExchangeImpl) {
		this.metadata = metadata ;
		this.esDataExchangeImpl = esDataExchangeImpl ;
		builder = UKDataContext.getTemplet().getClient().prepareBulk() ;
		start = System.currentTimeMillis() ;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void process(Object data) {
		UKDataBean dataBean = new UKDataBean();
		dataBean.setTable(this.metadata);
		try {
			dataBean.setValues((Map<String, Object>) data);
			if(builder!=null) {
				builder.add(esDataExchangeImpl.saveBulk(dataBean)) ;
			}else {
				esDataExchangeImpl.saveIObject(dataBean);
			}
			if(builder.numberOfActions() % 1000 ==0) {
				builder.execute().actionGet();
				System.out.println(System.currentTimeMillis() - start);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void end() {
		if(builder!=null) {
			builder.execute().actionGet();
		}
		System.out.println(System.currentTimeMillis() - start);
	}
}
