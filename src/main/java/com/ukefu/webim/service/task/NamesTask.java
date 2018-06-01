package com.ukefu.webim.service.task;

import java.util.Date;

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
import com.ukefu.webim.web.model.CallOutNames;
import com.ukefu.webim.web.model.CallOutTask;
import com.ukefu.webim.web.model.JobDetail;

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
			CacheHelper.getCallCenterAgentCacheBean().put(agent.getUserid(), agent, agent.getOrgi());
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
				callOutName.setOrgi(this.agent.getOrgi());
				if(task!=null) {
					callOutName.setName(task.getName());	//任务名称
				}
				if(batch!=null) {
					callOutName.setBatname(batch.getName());
				}
				callOutName.setBatid(batid);
				callOutName.setTaskid(taskid);
				callOutName.setFilterid((String) name.getValues().get("filterid"));
				callOutName.setDataid((String)name.getValues().get("id"));
				
				callOutName.setCreater((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_AGENT));
				callOutName.setOrgan((String) name.getValues().get(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN));
				callOutName.setCreatetime(new Date());
				callOutName.setUpdatetime(new Date());
				
				UKDataContext.getContext().getBean(CallOutNamesRepository.class).save(callOutName) ;
				
				NettyClients.getInstance().sendCallCenterMessage(agent.getExtno(), "preview", callOutName);
			}
		}
	}

}
