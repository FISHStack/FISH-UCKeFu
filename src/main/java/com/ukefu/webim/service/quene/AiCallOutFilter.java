package com.ukefu.webim.service.quene;

import org.apache.commons.lang.StringUtils;

import com.hazelcast.mapreduce.KeyPredicate;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.web.model.CallOutNames;

@SuppressWarnings("deprecation")
public class AiCallOutFilter implements KeyPredicate<String>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1236581634096258855L;
	private String orgi ;
	/**
	 * 
	 */
	public AiCallOutFilter(String orgi){
		this.orgi = orgi ;
	}
	public boolean evaluate(String key) {
		CallOutNames callOutNames = (CallOutNames) CacheHelper.getCallOutCacheBean().getCacheObject(key, orgi);
		return callOutNames!=null && !StringUtils.isBlank(orgi) && orgi.equals(callOutNames.getOrgi());
	}
}