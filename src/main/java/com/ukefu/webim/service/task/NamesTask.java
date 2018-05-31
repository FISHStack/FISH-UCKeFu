package com.ukefu.webim.service.task;

import org.springframework.data.domain.Page;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.es.SearchTools;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.util.freeswitch.model.CallCenterAgent;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.MetadataRepository;
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
			agent.setWorkstatus(UKDataContext.WorkStatusEnum.INPROCESS.toString());
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
				
			}
		}
	}

}
