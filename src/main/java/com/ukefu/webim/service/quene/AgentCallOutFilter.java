package com.ukefu.webim.service.quene;

import org.apache.commons.lang.StringUtils;

import com.hazelcast.mapreduce.KeyPredicate;
import com.ukefu.core.UKDataContext;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.web.model.CallOutNames;

@SuppressWarnings("deprecation")
public class AgentCallOutFilter implements KeyPredicate<String>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1236581634096258855L;
	private String orgi ;
	/**
	 * 
	 */
	public AgentCallOutFilter(String orgi){
		this.orgi = orgi ;
	}
	public boolean evaluate(String key) {
		CallOutNames callOutNames = (CallOutNames) CacheHelper.getCallOutCacheBean().getCacheObject(key, orgi);
		return callOutNames!=null && !StringUtils.isBlank(orgi) && orgi.equals(callOutNames.getOrgi()) && UKDataContext.CallOutType.AGENT.toString().equals(callOutNames.getCalltype());
	}
}