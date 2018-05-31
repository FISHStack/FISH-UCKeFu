package com.ukefu.webim.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.hazelcast.core.IMap;
import com.hazelcast.query.PagingPredicate;
import com.hazelcast.query.SqlPredicate;
import com.ukefu.util.freeswitch.model.CallCenterAgent;
import com.ukefu.webim.service.cache.CacheHelper;

@Service("calloutquene")
public class CallOutQuene {
	/**
	 * 为外呼坐席分配名单
	 * @param agentStatus
	 */
	@SuppressWarnings("unchecked")
	public static List<CallCenterAgent> service(){
		List<CallCenterAgent> agentList = new ArrayList<CallCenterAgent>();
		PagingPredicate<String, CallCenterAgent> pagingPredicate = new PagingPredicate<String, CallCenterAgent>(  new SqlPredicate( "workstatus = 'callout'") , 10 ) ;
		agentList.addAll(((IMap<String , CallCenterAgent>) CacheHelper.getCallCenterAgentCacheBean()).values(pagingPredicate)) ;
		return agentList ;
	}
}
