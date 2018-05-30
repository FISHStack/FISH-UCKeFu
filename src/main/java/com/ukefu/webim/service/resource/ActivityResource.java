package com.ukefu.webim.service.resource;

import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.PageImpl;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.UKTools;
import com.ukefu.util.es.SearchTools;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.webim.service.impl.ESDataExchangeImpl;
import com.ukefu.webim.service.repository.CallAgentRepository;
import com.ukefu.webim.service.repository.CallOutFilterRepository;
import com.ukefu.webim.service.repository.CallOutTaskRepository;
import com.ukefu.webim.service.repository.FormFilterItemRepository;
import com.ukefu.webim.service.repository.FormFilterRepository;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.MetadataRepository;
import com.ukefu.webim.web.model.CallAgent;
import com.ukefu.webim.web.model.CallOutFilter;
import com.ukefu.webim.web.model.CallOutTask;
import com.ukefu.webim.web.model.FormFilter;
import com.ukefu.webim.web.model.FormFilterItem;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.MetadataTable;

public class ActivityResource extends Resource{

	private JobDetail jobDetail ;
	private FormFilterRepository formFilterRes ;
	private FormFilterItemRepository formFilterItemRes ;
	private PageImpl<UKDataBean> dataList ;
	private MetadataTable metadataTable ;
	private FormFilter formFilter = null ;
	private List<CallAgent> callAgentList ;
	
	private ESDataExchangeImpl esDataExchange = null ;
	
	private CallAgent current ;
	
	private CallOutTask task ;
	private CallOutFilter filter ;
	
	private CallOutTaskRepository callOutTaskRes ;
	
	private CallOutFilterRepository callOutFilterRes ;
	
	private JobDetailRepository batchRes;
	
	private MetadataRepository metadataRes ;
	
	private JobDetail batch ;
	
	private AtomicInteger atomInt = new AtomicInteger();
	
	public ActivityResource(JobDetail jobDetail) {
		this.jobDetail = jobDetail ;
		this.formFilterRes = UKDataContext.getContext().getBean(FormFilterRepository.class) ;
		this.formFilterItemRes = UKDataContext.getContext().getBean(FormFilterItemRepository.class) ;
		this.esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
		this.callOutTaskRes = UKDataContext.getContext().getBean(CallOutTaskRepository.class);
		this.callOutFilterRes = UKDataContext.getContext().getBean(CallOutFilterRepository.class);
		this.batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class);
		this.metadataRes =  UKDataContext.getContext().getBean(MetadataRepository.class);
	}
	
	@Override
	public void begin() throws Exception {
		if(!StringUtils.isBlank(jobDetail.getFilterid())) {
			formFilter = formFilterRes.findByIdAndOrgi(jobDetail.getFilterid(), this.jobDetail.getOrgi()) ;
			List<FormFilterItem> formFilterList = formFilterItemRes.findByOrgiAndFormfilterid(this.jobDetail.getOrgi(), jobDetail.getFilterid()) ;
			if(formFilter!=null && !StringUtils.isBlank(formFilter.getFiltertype())) {
				if(formFilter.getFiltertype().equals(UKDataContext.FormFilterTypeEnum.BATCH.toString())) {
					batch = batchRes.findByIdAndOrgi(formFilter.getBatid(), this.jobDetail.getOrgi()) ;
					if(!StringUtils.isBlank(batch.getActid())) {
						metadataTable = metadataRes.findByTablename(batch.getActid()) ;
					}
				}else {	//业务表
					if(!StringUtils.isBlank(formFilter.getTableid())) {
						metadataTable = metadataRes.findById(formFilter.getTableid()) ;
					}
				}
			}
			if(metadataTable!=null) {
				dataList = SearchTools.search(this.jobDetail.getOrgi(), formFilter, formFilterList , metadataTable , false ,(int) Math.ceil(this.jobDetail.getStartindex()/50000), 50000) ;
			}
			this.callAgentList = UKDataContext.getContext().getBean(CallAgentRepository.class).findByActidAndOrgi(this.jobDetail.getId() , this.jobDetail.getOrgi()) ;
			/**
			 * 生成 活动任务， 然后完成分配 , 同时还需要生成 筛选表单的筛选记录 ， 在后台管理界面上可以看到
			 */
			if(this.callAgentList!=null && this.callAgentList.size() > 0) {
				this.current = this.callAgentList.remove(0) ;
			}
			
			this.jobDetail.setExecnum(this.jobDetail.getExecnum() + 1);
			
			task = new CallOutTask() ;
			task.setName(this.jobDetail.getName() + "_" + UKTools.dateFormate.format(new Date()));
			task.setBatid(formFilter.getBatid());
			
			task.setOrgi(this.jobDetail.getOrgi());
			
			task.setFilterid(formFilter.getId());
			task.setActid(this.jobDetail.getId());
			task.setNamenum((int) this.dataList.getTotalElements());
			
			task.setExecnum(this.jobDetail.getExecnum());
			
			task.setCreatetime(new Date());
			task.setNotassigned((int) this.dataList.getTotalElements());
			
			this.callOutTaskRes.save(task) ;
			
			filter = new CallOutFilter() ;
			
			formFilter.setExecnum(formFilter.getExecnum() + 1);
			
			UKTools.copyProperties(task, filter);
			filter.setName(this.formFilter.getName()  + "_" + UKTools.dateFormate.format(new Date()));
			filter.setExecnum(formFilter.getExecnum());
			this.callOutFilterRes.save(filter) ;
		}
	}

	@Override
	public void end(boolean clear) throws Exception {
		//doNothing
		/**
		 * FormFilter的执行信息更新，执行次数
		 */
		if(formFilterRes!=null && this.formFilter != null) {
			formFilterRes.save(this.formFilter) ;
		}
		/**
		 * 批次的信息更新，批次剩余未分配的名单总数 ， 已分配的名单总数
		 */
		if(this.batchRes!=null && this.batch != null) {
			this.batchRes.save(batch) ;
		}
		
		this.task.setAssigned(this.atomInt.intValue());
		this.task.setNotassigned(this.task.getNamenum() - this.atomInt.intValue());
		
		this.callOutTaskRes.save(this.task) ;
		
		this.filter.setAssigned(this.atomInt.intValue());
		this.filter.setNotassigned(this.filter.getNamenum() - this.atomInt.intValue());
		
		this.callOutFilterRes.save(this.filter) ;
	}

	@Override
	public JobDetail getJob() {
		return this.jobDetail;
	}

	@Override
	public void process(OutputTextFormat meta, JobDetail job) throws Exception {
		/**
		 * 执行分配
		 */
		if(this.current!=null && meta!=null && meta.getDataBean()!=null) {
			this.current.getDisnames().incrementAndGet() ;
			/**
			 * 
			 */
			meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, this.current.getDistarget()) ;
			meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, this.current.getOrgan()) ;
			meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_TIME, new Date()) ;
			
			meta.getDataBean().getValues().put("actid", this.jobDetail.getId()) ;
			meta.getDataBean().getValues().put("metaid", this.metadataTable.getTablename()) ;
			meta.getDataBean().getValues().put("batid", this.formFilter.getBatid()) ;
			/**
			 * 任务ID
			 */
			
			if("agent".equals(this.current.getDistype())) {
				meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISAGENT.toString()) ;
			}else if("organ".equals(this.current.getDistype())) {
				meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISORGAN.toString()) ;
			}
			meta.getDataBean().getValues().put("updatetime", new Date()) ;
			
			/**
			 * 更新记录（是否同时保存分配信息，以便于查看分配历史？）
			 */
			esDataExchange.saveIObject(meta.getDataBean());
		}
	}

	@Override
	public OutputTextFormat next() throws Exception {
		OutputTextFormat outputTextFormat = null;
		synchronized (this.dataList) {
			if(this.dataList!=null && atomInt.intValue() < this.dataList.getSize() ) {
				if(this.current.getDisnames().intValue() >= this.current.getDisnum() ) {
					if(this.callAgentList.size() > 0) {
						this.current = this.callAgentList.remove(0) ;
					}else {
						this.current = null ;
					}
				}
				if(this.current != null) {
					UKDataBean dataBean = this.dataList.getContent().get(atomInt.intValue()) ;
					outputTextFormat = new OutputTextFormat(this.jobDetail);
					if(this.formFilter!=null) {
						outputTextFormat.setTitle(this.formFilter.getName());
					}
					outputTextFormat.setDataBean(dataBean);
					
					atomInt.incrementAndGet() ;
				}
			}
		}
		return outputTextFormat;
	}

	@Override
	public boolean isAvailable() {
		return true;
	}

	@Override
	public OutputTextFormat getText(OutputTextFormat object) throws Exception {
		return object;
	}

	@Override
	public void rmResource() {
		/**
		 * 啥也不做
		 */
	}

	@Override
	public void updateTask() throws Exception {
		/**
		 * 更新任务状态，记录生成的任务信息
		 */
	}
}
