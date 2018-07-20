package com.ukefu.webim.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.hazelcast.core.IMap;
import com.hazelcast.mapreduce.aggregation.Aggregations;
import com.hazelcast.mapreduce.aggregation.Supplier;
import com.hazelcast.query.PagingPredicate;
import com.hazelcast.query.SqlPredicate;
import com.ukefu.util.freeswitch.model.CallCenterAgent;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.quene.AgentCallOutFilter;
import com.ukefu.webim.service.quene.AiCallOutFilter;
import com.ukefu.webim.web.model.CallOutNames;

@SuppressWarnings("deprecation")
@Service("calloutquene")
public class CallOutQuene {
	/**
	 * 为外呼坐席分配名单
	 * @param agentStatus
	 */
	@SuppressWarnings("unchecked")
	public static List<CallCenterAgent> service(){
		List<CallCenterAgent> agentList = new ArrayList<CallCenterAgent>();
		if(CacheHelper.getCallCenterAgentCacheBean()!=null && CacheHelper.getCallCenterAgentCacheBean().getCache()!=null) {
			PagingPredicate<String, CallCenterAgent> pagingPredicate = new PagingPredicate<String, CallCenterAgent>(  new SqlPredicate( "workstatus = 'callout'") , 10 ) ;
			agentList.addAll(((IMap<String , CallCenterAgent>) CacheHelper.getCallCenterAgentCacheBean().getCache()).values(pagingPredicate)) ;
		}
		return agentList ;
	}
	
	/**
	 * 为外呼坐席分配名单
	 * @param agentStatus
	 */
	@SuppressWarnings("unchecked")
	public static List<CallCenterAgent> service(String sip){
		List<CallCenterAgent> agentList = new ArrayList<CallCenterAgent>();
		if(CacheHelper.getCallCenterAgentCacheBean()!=null && CacheHelper.getCallCenterAgentCacheBean().getCache()!=null) {
			PagingPredicate<String, CallCenterAgent> pagingPredicate = new PagingPredicate<String, CallCenterAgent>(  new SqlPredicate( "siptrunk = '"+sip+"'") , 10 ) ;
			agentList.addAll(((IMap<String , CallCenterAgent>) CacheHelper.getCallCenterAgentCacheBean().getCache()).values(pagingPredicate)) ;
		}
		return agentList ;
	}
	
	/**
	 * 为外呼坐席分配名单
	 * @param agentStatus
	 */
	@SuppressWarnings("unchecked")
	public static List<CallCenterAgent> extention(String extno){
		List<CallCenterAgent> agentList = new ArrayList<CallCenterAgent>();
		if(CacheHelper.getCallCenterAgentCacheBean()!=null && CacheHelper.getCallCenterAgentCacheBean().getCache()!=null) {
			PagingPredicate<String, CallCenterAgent> pagingPredicate = new PagingPredicate<String, CallCenterAgent>(  new SqlPredicate( "extno = '"+extno+"'") , 10 ) ;
			agentList.addAll(((IMap<String , CallCenterAgent>) CacheHelper.getCallCenterAgentCacheBean().getCache()).values(pagingPredicate)) ;
		}
		return agentList ;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static int countAiCallOut(String orgi) {
		/**
		 * 统计当前在线的坐席数量
		 */
		IMap callOutMap = (IMap<String, Object>) CacheHelper.getCallOutCacheBean().getCache() ;
		AiCallOutFilter filter = new AiCallOutFilter(orgi) ;
		Long names = (Long) callOutMap.aggregate(Supplier.fromKeyPredicate(filter), Aggregations.count()) ;
		return names!=null ? names.intValue() : 0 ;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static int countAgentCallOut(String orgi) {
		/**
		 * 统计当前在线的坐席数量
		 */
		IMap callOutMap = (IMap<String, Object>) CacheHelper.getCallOutCacheBean().getCache() ;
		AgentCallOutFilter filter = new AgentCallOutFilter(orgi) ;
		Long names = (Long) callOutMap.aggregate(Supplier.fromKeyPredicate(filter), Aggregations.count()) ;
		return names!=null ? names.intValue() : 0 ;
	}
	
	
	/**
	 * 外呼监控，包含机器人和人工两个部分
	 * @param agentStatus
	 */
	@SuppressWarnings("unchecked")
	public static List<CallOutNames> callOutNames(String calltype , int p , int ps){
		List<CallOutNames> callOutNamesList = new ArrayList<CallOutNames>();
		if(CacheHelper.getCallOutCacheBean()!=null && CacheHelper.getCallOutCacheBean().getCache()!=null) {
			PagingPredicate<String, CallOutNames> pagingPredicate = new PagingPredicate<String, CallOutNames>(  new SqlPredicate( "calltype = '"+calltype+"'") , 10 ) ;
			pagingPredicate.setPage(p);
			callOutNamesList.addAll(((IMap<String , CallOutNames>) CacheHelper.getCallOutCacheBean().getCache()).values(pagingPredicate)) ;
		}
		return callOutNamesList ;
	}
}
