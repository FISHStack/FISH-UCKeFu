package com.ukefu.webim.service.task;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Page;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.client.NettyClients;
import com.ukefu.util.es.SearchTools;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.util.freeswitch.model.CallCenterAgent;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.CallOutNamesRepository;
import com.ukefu.webim.service.repository.CallOutTaskRepository;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.MetadataRepository;
import com.ukefu.webim.web.model.CallOutNames;
import com.ukefu.webim.web.model.CallOutTask;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.MetadataTable;
import com.ukefu.webim.web.model.TableProperties;

public class NamesTask implements Runnable{
	
	private CallCenterAgent agent ;
	public NamesTask(CallCenterAgent agent) {
		this.agent = agent ;
	}
	@Override
	public void run() {
		if(agent!=null) {
			/**
			 * 更新状态
			 */
			agent.setWorkstatus(UKDataContext.WorkStatusEnum.PREVIEW.toString());
			/**
			 * 根据策略拉取名单 ，
			 * 1、拨打时间
			 * 2、允许或禁止拨打
			 * 3、优先拨打新名单/老名单/预约名单/未拨打成功的名单
			 */
			Page<UKDataBean> names = SearchTools.agentsearch(this.agent.getOrgi(), agent.getUserid(), 0, 1) ;
			/**
			 * 找到名单，生成拨打任务，工作界面上，坐席只能看到自己的名单
			 */
			if(names!=null && names.getContent().size() > 0) {
				UKDataBean name = names.getContent().get(0) ;
			
				String batid = (String) name.getValues().get("batid") ;
				String taskid = (String) name.getValues().get("taskid") ;
				JobDetail batch = UKDataContext.getContext().getBean(JobDetailRepository.class).findByIdAndOrgi(batid, this.agent.getOrgi()) ;
				CallOutTask task = UKDataContext.getContext().getBean(CallOutTaskRepository.class).findByIdAndOrgi(taskid, this.agent.getOrgi()) ;
				CallOutNames callOutName = new CallOutNames() ; 
				CallOutNamesRepository callOutNamesRes = UKDataContext.getContext().getBean(CallOutNamesRepository.class) ;
				
				List<CallOutNames> callNamesList = callOutNamesRes.findByDataidAndCreaterAndOrgi((String)name.getValues().get("id"), (String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT), this.agent.getOrgi()) ;
				if(callNamesList.size() > 0) {
					callOutName = callNamesList.get(0) ;
				}else {
					callOutName.setOrgi(this.agent.getOrgi());
					if(task!=null) {
						callOutName.setName(task.getName());	//任务名称
					}
					if(batch!=null) {
						callOutName.setBatname(batch.getName());
					}
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
					}
					
					callOutName.setActid(task.getActid());
					callOutName.setBatid(batid);
					
					callOutName.setLeavenum((int)names.getTotalElements() - 1);
					
					callOutName.setTaskid(taskid);
					
					callOutName.setMetaname(batch.getActid());
					
					callOutName.setFilterid((String) name.getValues().get("filterid"));
					callOutName.setDataid((String)name.getValues().get("id"));
					
					callOutName.setStatus(UKDataContext.NamesProcessStatus.DIS.toString());
					
					callOutName.setCreater((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
					callOutName.setOrgan((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN));
					callOutName.setCreatetime(new Date());
					callOutName.setUpdatetime(new Date());
					
					callOutName.setOwneruser((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
					callOutName.setOwnerdept((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
				}
				
				callOutNamesRes.save(callOutName) ;
				
				NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "preview", callOutName);
				agent.setNames(callOutName);
			}else {
				agent.setWorkstatus(UKDataContext.WorkStatusEnum.IDLE.toString());
				NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "error", "nonames");
				
				NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "docallout", agent);
			}
			
			CacheHelper.getCallCenterAgentCacheBean().put(agent.getUserid(), agent, agent.getOrgi());
		}
	}

}
