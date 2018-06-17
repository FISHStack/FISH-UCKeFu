package com.ukefu.util.callout;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.client.NettyClients;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.util.freeswitch.model.CallCenterAgent;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.CallOutConfigRepository;
import com.ukefu.webim.service.repository.CallOutNamesRepository;
import com.ukefu.webim.service.repository.CallOutTaskRepository;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.MetadataRepository;
import com.ukefu.webim.web.model.CallOutConfig;
import com.ukefu.webim.web.model.CallOutNames;
import com.ukefu.webim.web.model.CallOutTask;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.MetadataTable;
import com.ukefu.webim.web.model.TableProperties;

public class CallOutUtils {
	/**
	 * AI配置
	 * @param orgi
	 * @return
	 */
	public static CallOutConfig initCallOutConfig(String dataid,String orgi){
		CallOutConfig callOutConfig = (CallOutConfig) CacheHelper.getSystemCacheBean().getCacheObject(UKDataContext.SYSTEM_CACHE_CALLOUT_CONFIG+"_"+dataid, orgi);
		if(UKDataContext.getContext() != null && callOutConfig == null){
			CallOutConfigRepository callOutConfigRepository = UKDataContext.getContext().getBean(CallOutConfigRepository.class) ;
			List<CallOutConfig> callOutConfigList = callOutConfigRepository.findByDataidAndOrgi(dataid,orgi) ;
			if(callOutConfigList.size() == 0){
				callOutConfig = new CallOutConfig() ;
			}else{
				callOutConfig = callOutConfigList.get(0) ;
				CacheHelper.getSystemCacheBean().put(UKDataContext.SYSTEM_CACHE_CALLOUT_CONFIG+"_"+callOutConfig.getDataid(),callOutConfig, orgi) ;
			}
		}
		return callOutConfig ;
	}
	
	/**
	 * AI配置
	 * @param orgi
	 * @return
	 */
	public static CallOutConfig initCallOutConfig(String orgi){
		CallOutConfig callOutConfig = (CallOutConfig) CacheHelper.getSystemCacheBean().getCacheObject(UKDataContext.SYSTEM_CACHE_CALLOUT_CONFIG+"_"+orgi, orgi);
		if(UKDataContext.getContext() != null && callOutConfig == null){
			CallOutConfigRepository callOutConfigRepository = UKDataContext.getContext().getBean(CallOutConfigRepository.class) ;
			List<CallOutConfig> callOutConfigList = callOutConfigRepository.findByOrgi(orgi) ;
			if(callOutConfigList.size() == 0){
				callOutConfig = new CallOutConfig() ;
			}else{
				callOutConfig = callOutConfigList.get(0) ;
				CacheHelper.getSystemCacheBean().put(UKDataContext.SYSTEM_CACHE_CALLOUT_CONFIG+"_"+orgi,callOutConfig, orgi) ;
			}
		}
		return callOutConfig ;
	}
	
	public static CallOutNames processNames(UKDataBean name, CallCenterAgent agent , String orgi , int leavenames) {
		String batid = (String) name.getValues().get("batid") ;
		String taskid = (String) name.getValues().get("taskid") ;
		JobDetail batch = UKDataContext.getContext().getBean(JobDetailRepository.class).findByIdAndOrgi(batid, orgi) ;
		CallOutTask task = UKDataContext.getContext().getBean(CallOutTaskRepository.class).findByIdAndOrgi(taskid, orgi) ;
		CallOutNames callOutName = new CallOutNames() ; 
		CallOutNamesRepository callOutNamesRes = UKDataContext.getContext().getBean(CallOutNamesRepository.class) ;
		
		List<CallOutNames> callNamesList = callOutNamesRes.findByDataidAndCreaterAndOrgi((String)name.getValues().get("id"), (String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT), orgi) ;
		if(callNamesList.size() > 0) {
			callOutName = callNamesList.get(0) ;
		}else {
			callOutName.setOrgi(orgi);
			if(task!=null) {
				callOutName.setName(task.getName());	//任务名称
			}
			if(batch!=null) {
				callOutName.setBatname(batch.getName());
			}
			
			
			callOutName.setActid(task.getActid());
			callOutName.setBatid(batid);
			
			callOutName.setTaskid(taskid);
			
			callOutName.setMetaname(batch.getActid());
			
			callOutName.setFilterid((String) name.getValues().get("filterid"));
			callOutName.setDataid((String)name.getValues().get("id"));
			
			callOutName.setStatus(UKDataContext.NamesProcessStatus.DIS.toString());
			
			callOutName.setCreater((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
			callOutName.setOrgan((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN));
			callOutName.setCreatetime(new Date());
			callOutName.setUpdatetime(new Date());
			String apstatus = (String) name.getValues().get("apstatus") ;
			if(!StringUtils.isBlank(apstatus) && apstatus.equals("true")) {
				callOutName.setReservation(true);
			}else {
				callOutName.setReservation(false);
			}
			callOutName.setMemo((String) name.getValues().get("apmemo"));
			
			callOutName.setOwneruser((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
			callOutName.setOwnerdept((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
		}
		
		callOutName.setLeavenum(leavenames);
		
		String dial_number = null ;
		boolean disphonenum = false ;
		String distype = null;
		
		if(batch!=null && !StringUtils.isBlank(batch.getActid())) {
			MetadataTable table = UKDataContext.getContext().getBean(MetadataRepository.class).findByTablename(batch.getActid()) ;
			for(TableProperties tp : table.getTableproperty()) {
				if(tp.isPhonenumber()) {
					dial_number = (String) name.getValues().get(tp.getFieldname()) ; 
					disphonenum = tp.isSecfield() ;
					distype = tp.getSecdistype() ;
					break ;
				}
			}
		}
		
		if(!StringUtils.isBlank(dial_number)) {
			callOutName.setPhonenumber(dial_number);
			if(disphonenum) {
				callOutName.setDistype(distype);
			}
			if(agent!=null) {
				NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "preview", callOutName);
			}
		}else if(agent!=null){
			agent.setWorkstatus(UKDataContext.WorkStatusEnum.IDLE.toString());
			NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "error", "nophonenumber");
			
			NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "docallout", agent);
		}
		callOutNamesRes.save(callOutName) ;
		agent.setNameid(callOutName.getId());
		return callOutName ;
	}
}
