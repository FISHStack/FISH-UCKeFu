package com.ukefu.webim.service.resource;

import java.io.File;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.UKTools;
import com.ukefu.util.task.DSData;
import com.ukefu.util.task.DSDataEvent;
import com.ukefu.util.task.ExcelImportProecess;
import com.ukefu.webim.service.impl.BatchDataProcess;
import com.ukefu.webim.service.impl.ESDataExchangeImpl;
import com.ukefu.webim.service.repository.MetadataRepository;
import com.ukefu.webim.service.repository.ReporterRepository;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.MetadataTable;

public class BatchResource extends Resource{

	private JobDetail jobDetail ;
	private MetadataTable metadataTable ;
	private ESDataExchangeImpl esDataExchange = null ;
	
	private MetadataRepository metadataRes ;
	
	private ReporterRepository reporterRes ;
	
	public BatchResource(JobDetail jobDetail) {
		this.jobDetail = jobDetail ;
		this.metadataRes =  UKDataContext.getContext().getBean(MetadataRepository.class);
		this.reporterRes =  UKDataContext.getContext().getBean(ReporterRepository.class);
		this.esDataExchange = UKDataContext.getContext().getBean(ESDataExchangeImpl.class);
	}
	
	@Override
	public void begin() throws Exception {
		if(!StringUtils.isBlank(jobDetail.getActid())) {
			metadataTable = metadataRes.findByTablename(jobDetail.getActid()) ;
		}
		DSDataEvent event = new DSDataEvent();
		String path = UKDataContext.getContext().getEnvironment().getProperty("web.upload-path") ;
		File tempFile = null ;
		if(metadataTable!=null && !StringUtils.isBlank(this.jobDetail.getBatchtype()) && this.jobDetail.getBatchtype().equals("plan")) {
			if(!StringUtils.isBlank(this.jobDetail.getImptype())) {
				if(this.jobDetail.getImptype().equals("local")) {
					tempFile = new File(UKTools.getTemplet(this.jobDetail.getImpurl(), new HashMap<String,Object>()));
				}else if(this.jobDetail.getImptype().equals("remote")){
					FileUtils.copyURLToFile(new URL(UKTools.getTemplet(this.jobDetail.getImpurl(), new HashMap<String,Object>())), tempFile = File.createTempFile("UKeFu-CallOut-Temp", ".xls"));
				}
			}
			if(tempFile.exists()) {
				String fileName = "callout/batch/"+UKTools.getUUID() + tempFile.getName().substring(tempFile.getName().lastIndexOf(".")) ;
		    	File excelFile = new File(path , fileName) ;
		    	if(!excelFile.getParentFile().exists()){
		    		excelFile.getParentFile().mkdirs() ;
		    	}
				
				event.setTablename(metadataTable.getTablename());
		    	event.setDSData(new DSData(null ,excelFile , tempFile.getName(), null));
		    	event.setOrgi(this.jobDetail.getOrgi());
		    	event.getValues().put("creater", this.jobDetail.getCreater()) ;
		    	
		    	FileUtils.copyFile(tempFile, new File(path , fileName));
		    	
		    	event.getDSData().setTask(metadataTable);
		    	event.getDSData().setProcess(new BatchDataProcess(metadataTable, esDataExchange));
		    	event.setOrgi(this.jobDetail.getOrgi());
		    	event.setBatid(this.jobDetail.getId());
		    	event.getDSData().setJobDetail(this.jobDetail);
		    	
		    	event.getDSData().getReport().setOrgi(this.jobDetail.getOrgi());
		    	event.getDSData().getReport().setDataid(this.jobDetail.getId());
		    	event.getDSData().getReport().setTitle(this.jobDetail.getName() + "_" + UKTools.dateFormate.format(new Date()));
			}else {
				event.getDSData().getReport().setError(true);
				if(tempFile!=null) {
					event.getDSData().getReport().setErrormsg(tempFile.getAbsolutePath() + " Not Exist!");
				}
			}
			reporterRes.save(event.getDSData().getReport()) ;
	    	new ExcelImportProecess(event).process() ;		//启动导入任务
		}
	}

	@Override
	public void end(boolean clear) throws Exception {
		
	}

	@Override
	public JobDetail getJob() {
		return this.jobDetail;
	}

	@Override
	public void process(OutputTextFormat meta, JobDetail job) throws Exception {
		
	}

	@Override
	public OutputTextFormat next() throws Exception {
		return null ;
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
		
	}
}
