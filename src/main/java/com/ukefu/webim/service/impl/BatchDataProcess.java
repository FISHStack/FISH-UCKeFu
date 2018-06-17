package com.ukefu.webim.service.impl;

import java.util.Map;

import com.ukefu.util.es.UKDataBean;
import com.ukefu.util.task.process.JPAProcess;
import com.ukefu.webim.web.model.MetadataTable;

public class BatchDataProcess implements JPAProcess{
	
	private MetadataTable metadata;
	private ESDataExchangeImpl esDataExchangeImpl ;
	
	public BatchDataProcess(MetadataTable metadata , ESDataExchangeImpl esDataExchangeImpl) {
		this.metadata = metadata ;
		this.esDataExchangeImpl = esDataExchangeImpl ;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void process(Object data) {
		UKDataBean dataBean = new UKDataBean();
		dataBean.setTable(this.metadata);
		try {
			dataBean.setValues((Map<String, Object>) data);
			esDataExchangeImpl.saveIObject(dataBean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
