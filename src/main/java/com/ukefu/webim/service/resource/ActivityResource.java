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
import com.ukefu.webim.service.impl.BatchDataProcess;
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
	
	
	private CallAgent current ;
	
	private CallOutTask task ;
	private CallOutFilter filter ;
	
	private CallOutTaskRepository callOutTaskRes ;
	
	private CallOutFilterRepository callOutFilterRes ;
	
	private JobDetailRepository batchRes;
	
	private MetadataRepository metadataRes ;
	
	private JobDetail batch ;
	
	private AtomicInteger assignorganInt = new AtomicInteger() /***分配到坐席***/, assignInt = new AtomicInteger() /***分配到部门***/ , assignAiInt = new AtomicInteger() /***分配到AI***/ ,atomInt = new AtomicInteger() ;
	
	private BatchDataProcess batchDataProcess ;
	
	public ActivityResource(JobDetail jobDetail) {
		this.jobDetail = jobDetail ;
		this.formFilterRes = UKDataContext.getContext().getBean(FormFilterRepository.class) ;
		this.formFilterItemRes = UKDataContext.getContext().getBean(FormFilterItemRepository.class) ;
		this.callOutTaskRes = UKDataContext.getContext().getBean(CallOutTaskRepository.class);
		this.callOutFilterRes = UKDataContext.getContext().getBean(CallOutFilterRepository.class);
		this.batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class);
		this.metadataRes =  UKDataContext.getContext().getBean(MetadataRepository.class);
		this.batchDataProcess = new BatchDataProcess(null , UKDataContext.getContext().getBean(ESDataExchangeImpl.class)) ;
	}
	
	@Override
	public void begin() throws Exception {
		if(!StringUtils.isBlank(jobDetail.getFilterid())) {
			formFilter = formFilterRes.findByIdAndOrgi(jobDetail.getFilterid(), this.jobDetail.getOrgi()) ;
			List<FormFilterItem> formFilterList = formFilterItemRes.findByOrgiAndFormfilterid(this.jobDetail.getOrgi(), jobDetail.getFilterid()) ;
			if(formFilter!=null && !StringUtils.isBlank(formFilter.getFiltertype())) {
				if(formFilter.getFiltertype().equals(UKDataContext.FormFilterTypeEnum.BATCH.toString())) {
					batch = batchRes.findByIdAndOrgi(formFilter.getBatid(), this.jobDetail.getOrgi()) ;
					if(batch!=null && !StringUtils.isBlank(batch.getActid())) {
						metadataTable = metadataRes.findByTablename(batch.getActid()) ;
					}
				}else {	//业务表
					if(!StringUtils.isBlank(formFilter.getTableid())) {
						metadataTable = metadataRes.findById(formFilter.getTableid()) ;
					}
				}
			}
			if(metadataTable!=null) {
				/**
				 * 只加载 未分配的有效名单数据
				 */
				if(isRecovery()) {
					//回收数据 , 需要传入回收的目标  ： 包括 批次ID，任务ID，筛选ID，活动ID
					dataList = SearchTools.recoversearch(this.jobDetail.getOrgi(), this.jobDetail.getExectype(), this.jobDetail.getExectarget() , metadataTable ,(int) Math.ceil(this.jobDetail.getStartindex()/50000), 50000) ;
				}else {
					dataList = SearchTools.dissearch(this.jobDetail.getOrgi(), formFilter, formFilterList , metadataTable ,(int) Math.ceil(this.jobDetail.getStartindex()/50000), 50000) ;
				}
			}
			this.callAgentList = UKDataContext.getContext().getBean(CallAgentRepository.class).findByActidAndOrgi(this.jobDetail.getId() , this.jobDetail.getOrgi()) ;
			/**
			 * 生成 活动任务， 然后完成分配 , 同时还需要生成 筛选表单的筛选记录 ， 在后台管理界面上可以看到
			 */
			if(this.callAgentList!=null && this.callAgentList.size() > 0) {
				this.current = this.callAgentList.remove(0) ;
			}
			
			this.jobDetail.setExecnum(this.jobDetail.getExecnum() + 1);
			
			if(this.isRecovery() && !StringUtils.isBlank(this.jobDetail.getExectype()) && (this.jobDetail.getExectype().equals("filterid") || this.jobDetail.getExectype().equals("filterskill") || this.jobDetail.getExectype().equals("taskskill") || this.jobDetail.getExectype().equals("taskid"))) {
				if(this.jobDetail.getExectype().equals("filterid") || this.jobDetail.getExectype().equals("filterskill")) {
					this.filter = this.callOutFilterRes.findByIdAndOrgi(this.jobDetail.getExectarget(), this.jobDetail.getOrgi()) ;
				}else if(this.jobDetail.getExectype().equals("taskid") || this.jobDetail.getExectype().equals("taskskill") ) {
					this.task = this.callOutTaskRes.findByIdAndOrgi(this.jobDetail.getExectarget(), this.jobDetail.getOrgi()) ;
				}
			}else {
				task = new CallOutTask() ;
				task.setName(this.jobDetail.getName() + "_" + UKTools.dateFormate.format(new Date()));
				task.setBatid(formFilter.getBatid());
				
				task.setOrgi(this.jobDetail.getOrgi());
				
				if(this.isRecovery()) {
					task.setExectype(UKDataContext.ActivityExecType.RECOVERY.toString());
				}else {
					task.setExectype(UKDataContext.ActivityExecType.DEFAULT.toString());
				}
				
				task.setFilterid(formFilter.getId());
				task.setActid(this.jobDetail.getId());
				
				task.setExecnum(this.jobDetail.getExecnum());
				
				task.setOrgan(this.jobDetail.getOrgan());
				
				task.setCreatetime(new Date());
				if(this.dataList!=null) {
					task.setNamenum((int) this.dataList.getTotalElements());
					task.setNotassigned((int) this.dataList.getTotalElements());
				}
				
				this.callOutTaskRes.save(task) ;
				
				filter = new CallOutFilter() ;
				
				formFilter.setExecnum(formFilter.getExecnum() + 1);
				
				UKTools.copyProperties(task, filter);
				filter.setName(this.formFilter.getName()  + "_" + UKTools.dateFormate.format(new Date()));
				filter.setExecnum(formFilter.getExecnum());
				this.callOutFilterRes.save(filter) ;
			}
		}
	}

	@Override
	public void end(boolean clear) throws Exception {
		if(this.atomInt.intValue() > 0) {
			this.batchDataProcess.end();
		}
		//doNothing
		/**
		 * FormFilter的执行信息更新，执行次数
		 */
		if(formFilterRes!=null && this.formFilter != null) {
			this.formFilter.setFilternum(this.formFilter.getFilternum()+1);
			formFilterRes.save(this.formFilter) ;
		}
		/**
		 * 批次的信息更新，批次剩余未分配的名单总数 ， 已分配的名单总数
		 */
		if(this.batchRes!=null && this.batch != null) {
			if(this.isRecovery()) {
				batch.setAssigned(batch.getAssigned() - this.atomInt.intValue());
			}else {
				batch.setAssigned(batch.getAssigned() + this.atomInt.intValue());
			}
			batch.setNotassigned(batch.getNamenum() - batch.getAssigned());
			this.batchRes.save(batch) ;
		}
		if(this.task!=null) {
			if(this.isRecovery()) {
				if(!StringUtils.isBlank(this.jobDetail.getExecto())) {
					this.task.setReorgannum(this.atomInt.intValue());
				}else {
					this.task.setRenum(this.atomInt.intValue());
				}
			}else {
				this.task.setAssigned(this.assignInt.intValue());
				this.task.setAssignedorgan(this.assignorganInt.intValue());
				this.task.setAssignedai(this.assignAiInt.intValue());
				this.task.setNotassigned(this.task.getNamenum() - this.assignInt.intValue() - this.assignorganInt.intValue() - this.assignAiInt.intValue());
			}
			this.callOutTaskRes.save(this.task) ;
		}
		if(this.filter!=null) {
			if(this.isRecovery()) {
				if(!StringUtils.isBlank(this.jobDetail.getExecto())) {
					this.filter.setReorgannum(this.atomInt.intValue());
				}else {
					this.filter.setRenum(this.atomInt.intValue());
				}
			}else {
				this.filter.setAssigned(this.assignInt.intValue());
				this.filter.setAssignedorgan(this.assignorganInt.intValue());
				this.filter.setAssignedai(this.assignAiInt.intValue());
				this.filter.setNotassigned(this.task.getNamenum() - this.assignInt.intValue() - this.assignorganInt.intValue() - this.assignAiInt.intValue());
			}
			this.callOutFilterRes.save(this.filter) ;
		}
		
		/**
		 * 更新任务状态，记录生成的任务信息
		 */
		this.jobDetail.setExecmd(null);
		this.jobDetail.setExectype(null);
		this.jobDetail.setExectarget(null);
		this.jobDetail.setExecto(null);
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
		if(this.isRecovery()) {
			if(!StringUtils.isBlank(this.jobDetail.getExecto())) {
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, null) ;
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AI, null) ;
//				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, this.jobDetail.getExecto()) ;
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_TIME, System.currentTimeMillis()) ;
				meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISORGAN.toString()) ;
			}else {
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AI, null) ;
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, null) ;
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, null) ;
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_TIME, null) ;
				meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.NOT.toString()) ;
			}
		}else {
			if(this.current!=null && meta!=null && meta.getDataBean()!=null) {
				this.current.getDisnames().incrementAndGet() ;
				/**
				 * 
				 */
				meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_TIME, System.currentTimeMillis()) ;
				
				meta.getDataBean().getValues().put("actid", this.jobDetail.getId()) ;
				meta.getDataBean().getValues().put("metaid", this.metadataTable.getTablename()) ;
				meta.getDataBean().getValues().put("batid", this.formFilter.getBatid()) ;
				
				meta.getDataBean().getValues().put("taskid", this.task.getId()) ;
				meta.getDataBean().getValues().put("filterid", this.formFilter.getId()) ;
				meta.getDataBean().getValues().put("calloutfilid", this.filter.getId()) ;
				
				meta.getDataBean().getValues().put("taskid", this.task.getId()) ;
				
				
				if(!StringUtils.isBlank(this.jobDetail.getUserid())){
					meta.getDataBean().getValues().put("assuser", this.jobDetail.getUserid()) ;
				}else{
					meta.getDataBean().getValues().put("assuser", this.jobDetail.getCreater()) ;
				}
				/**
				 * 任务ID
				 */
				
				if("agent".equals(this.current.getDistype())) {
					meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISAGENT.toString()) ;
					meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AGENT, this.current.getDistarget()) ;
					meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, this.current.getOrgan()) ;
					this.assignInt.incrementAndGet() ;
				}else if("skill".equals(this.current.getDistype())) {
					meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISORGAN.toString()) ;
					meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, this.current.getDistarget()) ;
					this.assignorganInt.incrementAndGet() ;
				}else if("ai".equals(this.current.getDistype())) {
					meta.getDataBean().getValues().put("status", UKDataContext.NamesDisStatusType.DISAI.toString()) ;
					meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_AI, this.current.getDistarget()) ;
					meta.getDataBean().getValues().put(UKDataContext.UKEFU_SYSTEM_DIS_ORGAN, this.current.getOrgan()) ;
					this.assignAiInt.incrementAndGet() ;
				}
			}
		}
		meta.getDataBean().getValues().put("updatetime", System.currentTimeMillis()) ;
		
		/**
		 * 更新记录（是否同时保存分配信息，以便于查看分配历史？）
		 */
		batchDataProcess.process(meta.getDataBean());
	}

	@Override
	public OutputTextFormat next() throws Exception {
		OutputTextFormat outputTextFormat = null;
		if(this.dataList!=null && this.current!=null) {
			synchronized (this.dataList) {
				if(atomInt.intValue() < this.dataList.getContent().size()) {
					if(this.isRecovery()) {
						UKDataBean dataBean = this.dataList.getContent().get(atomInt.intValue()) ;
						outputTextFormat = new OutputTextFormat(this.jobDetail);
						if(this.formFilter!=null) {
							outputTextFormat.setTitle(this.formFilter.getName());
						}
						outputTextFormat.setDataBean(dataBean);
						atomInt.incrementAndGet() ;
					}else if(this.dataList!=null) {
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
							
							/**
							 * 修改为平均分配的方式 ， 每个坐席或者部门评价分配
							 */
							this.callAgentList.add(this.current) ;
							if(this.callAgentList.size() > 0) {
								this.current = this.callAgentList.remove(0) ;
							}
						}
					}
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
		this.jobDetail.setExecmd(null);
		this.jobDetail.setExectype(null);
		this.jobDetail.setExectarget(null);
		this.jobDetail.setExecto(null);
	}
	
	private boolean isRecovery() {
		return !StringUtils.isBlank(this.jobDetail.getExecmd()) && this.jobDetail.getExecmd().equals("recovery") ;
	}
}
