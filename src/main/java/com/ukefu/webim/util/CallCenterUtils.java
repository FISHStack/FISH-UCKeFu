package com.ukefu.webim.util;

import static org.elasticsearch.index.query.QueryBuilders.termQuery;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.Valid;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang.StringUtils;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.ui.ModelMap;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.es.SearchTools;
import com.ukefu.util.es.UKDataBean;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.CallAgentRepository;
import com.ukefu.webim.service.repository.CallOutFilterRepository;
import com.ukefu.webim.service.repository.CallOutNamesHisRepository;
import com.ukefu.webim.service.repository.CallOutRoleRepository;
import com.ukefu.webim.service.repository.CallOutTaskRepository;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.FormFilterRepository;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.PbxHostRepository;
import com.ukefu.webim.service.repository.SaleStatusRepository;
import com.ukefu.webim.service.repository.SipTrunkRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.UserRoleRepository;
import com.ukefu.webim.web.model.CallAgent;
import com.ukefu.webim.web.model.CallOutFilter;
import com.ukefu.webim.web.model.CallOutNames;
import com.ukefu.webim.web.model.CallOutNamesHis;
import com.ukefu.webim.web.model.CallOutRole;
import com.ukefu.webim.web.model.CallOutTask;
import com.ukefu.webim.web.model.Extention;
import com.ukefu.webim.web.model.FormFilter;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.PbxHost;
import com.ukefu.webim.web.model.SaleStatus;
import com.ukefu.webim.web.model.SipTrunk;
import com.ukefu.webim.web.model.UKeFuDic;
import com.ukefu.webim.web.model.User;
import com.ukefu.webim.web.model.UserRole;

public class CallCenterUtils {
	
	/**
	 * 
	 * @param user
	 * @param orgi
	 * @param id
	 * @param service
	 * @return
	 * @throws Exception
	 */
	public static SipTrunk siptrunk(String extno , SipTrunkRepository sipTrunkRes, ExtentionRepository extRes){
		SipTrunk sipTrunk = null;
		List<Extention> extList = extRes.findByExtention(extno) ;
		if(extList.size() > 0){
			Extention ext = extList.get(0) ;
			if(!StringUtils.isBlank(ext.getSiptrunk())) {
				sipTrunk = (SipTrunk) CacheHelper.getSystemCacheBean().getCacheObject(ext.getSiptrunk(), ext.getOrgi()) ;
				if(sipTrunk == null) {
					sipTrunk = sipTrunkRes.findByIdAndOrgi(ext.getSiptrunk(), ext.getOrgi()) ;
					if(sipTrunk!=null) {
						CacheHelper.getSystemCacheBean().put(sipTrunk.getId() ,sipTrunk , ext.getOrgi()) ;
					}
				}
			}else {
				List<SipTrunk> sipTrunkList = sipTrunkRes.findByDefaultsipAndOrgi(true, ext.getOrgi()) ;
				if(sipTrunkList.size() > 0) {
					sipTrunk = sipTrunkList.get(0) ;
				}
			}
		}
		return sipTrunk;
	}
	
	/**
	 * 
	 * @param user
	 * @param orgi
	 * @param id
	 * @param service
	 * @return
	 * @throws Exception
	 */
	public static PbxHost pbxhost(String ip){
		PbxHost pbxHost =  (PbxHost) CacheHelper.getSystemCacheBean().getCacheObject(ip, UKDataContext.SYSTEM_ORGI) ;
		if(pbxHost == null) {
			PbxHostRepository pbxHostRes = UKDataContext.getContext().getBean(PbxHostRepository.class) ;
			List<PbxHost> pbxHostList = pbxHostRes.findByHostnameOrIpaddr(ip, ip) ;
			if(pbxHostList!=null && pbxHostList.size() > 0) {
				pbxHost = pbxHostList.get(0) ;
				CacheHelper.getSystemCacheBean().put(pbxHost.getIpaddr() ,pbxHost , pbxHost.getOrgi()) ;
			}
		}
		return pbxHost;
	}
	
	
	/**
	 * 
	 * @param user
	 * @param orgi
	 * @param id
	 * @param service
	 * @return
	 * @throws Exception
	 */
	public static SipTrunk siptrunk(String name , SipTrunkRepository sipTrunkRes){
		SipTrunk sipTrunk = null;
		List<SipTrunk> sipTrunkList = sipTrunkRes.findByName(name) ;
		if(sipTrunkList.size() > 0){
			sipTrunk = sipTrunkList.get(0) ;
		}else {
			sipTrunkList = sipTrunkRes.findByDefaultsip(true) ;
			if(sipTrunkList.size() > 0) {
				sipTrunk = sipTrunkList.get(0) ;
			}
		}
		if(sipTrunk != null) {
			CacheHelper.getSystemCacheBean().put(sipTrunk.getId() ,sipTrunk , sipTrunk.getOrgi()) ;
		}
		return sipTrunk;
	}
	
	/**
	 * 我的部门以及授权给我的部门
	 * @param userRoleRes
	 * @param callOutRoleRes
	 * @param user
	 * @return
	 */
	public static List<String> getAuthOrgan(UserRoleRepository userRoleRes , CallOutRoleRepository callOutRoleRes,User user){
		List<UserRole> userRole = userRoleRes.findByOrgiAndUser(user.getOrgi(), user);
		ArrayList<String> organList = new ArrayList<String>();
		if (userRole.size() > 0) {
			for (UserRole userTemp : userRole) {
				CallOutRole roleOrgan = callOutRoleRes.findByOrgiAndRoleid(user.getOrgi(),
						userTemp.getRole().getId());
				if (roleOrgan != null) {
					if (!StringUtils.isBlank(roleOrgan.getOrganid())) {
						String[] organ = roleOrgan.getOrganid().split(",");
						for (int i = 0; i < organ.length; i++) {
							organList.add(organ[i]);
						}
						
					}
				}
			}
		}
		
		if(user!=null && !StringUtils.isBlank(user.getOrgan())) {
			organList.add(user.getOrgan()) ;
		}
		return organList ;
	}
	/**
	 * 我的部门以及授权给我的部门 - 批次
	 * @param batchRes
	 * @param userRoleRes
	 * @param callOutRoleRes
	 * @param user
	 * @return
	 */
	public static List<JobDetail> getBatchList(JobDetailRepository batchRes,UserRoleRepository userRoleRes , CallOutRoleRepository callOutRoleRes, final User user){
		
		//final List<String> organList = CallCenterUtils.getAuthOrgan(userRoleRes, callOutRoleRes, user);
		
		final List<String> organList = CallCenterUtils.getExistOrgan(user);
		
		List<JobDetail> batchList = batchRes.findAll(new Specification<JobDetail>(){
			@Override
			public Predicate toPredicate(Root<JobDetail> root, CriteriaQuery<?> query,
					CriteriaBuilder cb) {
				List<Predicate> list = new ArrayList<Predicate>();  
				In<Object> in = cb.in(root.get("organ"));
				
				list.add(cb.equal(root.get("orgi").as(String.class), user.getOrgi()));
				list.add(cb.equal(root.get("tasktype").as(String.class), UKDataContext.TaskType.BATCH.toString()));
				
				if(organList.size() > 0){
					
					for(String id : organList){
						in.value(id) ;
					}
				}else{
					in.value(UKDataContext.UKEFU_SYSTEM_NO_DAT) ;
				}
				list.add(in) ;
				
				Predicate[] p = new Predicate[list.size()];  
				return cb.and(list.toArray(p));   
			}});
		
		return batchList;
	}
	/**
	 * 我的部门以及授权给我的部门 - 筛选表单
	 * @param filterRes
	 * @param userRoleRes
	 * @param callOutRoleRes
	 * @param user
	 * @return
	 */
	public static List<FormFilter> getFormFilterList(FormFilterRepository filterRes,UserRoleRepository userRoleRes , CallOutRoleRepository callOutRoleRes, final User user){
		
		//final List<String> organList = CallCenterUtils.getAuthOrgan(userRoleRes, callOutRoleRes, user);
		
		final List<String> organList = CallCenterUtils.getExistOrgan(user);
		
		List<FormFilter> formFilterList = filterRes.findAll(new Specification<FormFilter>(){
			@Override
			public Predicate toPredicate(Root<FormFilter> root, CriteriaQuery<?> query,
					CriteriaBuilder cb) {
				List<Predicate> list = new ArrayList<Predicate>();  
				In<Object> in = cb.in(root.get("organ"));
				
				list.add(cb.equal(root.get("orgi").as(String.class), user.getOrgi()));
				
				if(organList.size() > 0){
					
					for(String id : organList){
						in.value(id) ;
					}
				}else{
					in.value(UKDataContext.UKEFU_SYSTEM_NO_DAT) ;
				}
				list.add(in) ;
				
				Predicate[] p = new Predicate[list.size()];  
				return cb.and(list.toArray(p));   
			}});
		
		return formFilterList;
	}
	
	/**
	 * 我的部门以及授权给我的部门 - 活动
	 * @param batchRes
	 * @param userRoleRes
	 * @param callOutRoleRes
	 * @param user
	 * @return
	 */
	public static List<JobDetail> getActivityList(JobDetailRepository batchRes,UserRoleRepository userRoleRes , CallOutRoleRepository callOutRoleRes,final User user){
		
		//final List<String> organList = CallCenterUtils.getAuthOrgan(userRoleRes, callOutRoleRes, user);
		
		final List<String> organList = CallCenterUtils.getExistOrgan(user);
		
		List<JobDetail> activityList = batchRes.findAll(new Specification<JobDetail>(){
			@Override
			public Predicate toPredicate(Root<JobDetail> root, CriteriaQuery<?> query,
					CriteriaBuilder cb) {
				List<Predicate> list = new ArrayList<Predicate>();  
				In<Object> in = cb.in(root.get("organ"));
				
				list.add(cb.equal(root.get("orgi").as(String.class), user.getOrgi()));
				list.add(cb.equal(root.get("tasktype").as(String.class), UKDataContext.TaskType.ACTIVE.toString()));
				
				if(organList.size() > 0){
					
					for(String id : organList){
						in.value(id) ;
					}
				}else{
					in.value(UKDataContext.UKEFU_SYSTEM_NO_DAT) ;
				}
				list.add(in) ;
				
				Predicate[] p = new Predicate[list.size()];  
				return cb.and(list.toArray(p));   
			}});
		
		return activityList;
	}
	/**
	 * 查询条件，下拉信息返回
	 * @param map
	 * @param user
	 * @param ownerdept
	 * @param actid
	 */
	public static void getAllCallOutList(ModelMap map, User user,String ownerdept, String actid){
		JobDetailRepository batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class) ;
		UserRoleRepository userRoleRes = UKDataContext.getContext().getBean(UserRoleRepository.class) ;
		CallOutRoleRepository callOutRoleRes = UKDataContext.getContext().getBean(CallOutRoleRepository.class) ;
		FormFilterRepository filterRes = UKDataContext.getContext().getBean(FormFilterRepository.class) ;
		OrganRepository organRes = UKDataContext.getContext().getBean(OrganRepository.class) ;
		
		List<JobDetail> activityList = CallCenterUtils.getActivityList(batchRes,userRoleRes, callOutRoleRes,user);
		List<SaleStatus> salestatusList = new ArrayList<>();
		for(JobDetail act :activityList){
			List<SaleStatus> salestastus = UKDataContext.getContext().getBean(SaleStatusRepository.class).findByOrgiAndActivityid(user.getOrgi(), act.getDicid());
			salestatusList.addAll(salestastus);
			
		}
		LinkedHashSet<SaleStatus> set = new LinkedHashSet<SaleStatus>(salestatusList.size());
	    set.addAll(salestatusList);
	    salestatusList.clear();
	    salestatusList.addAll(set);
		map.put("salestatusList", salestatusList);
		map.put("batchList", CallCenterUtils.getBatchList(batchRes, userRoleRes, callOutRoleRes,user));
		map.put("activityList", CallCenterUtils.getActivityList(batchRes,userRoleRes, callOutRoleRes,user));
		map.put("formFilterList", CallCenterUtils.getFormFilterList(filterRes,userRoleRes, callOutRoleRes,user));
		if(StringUtils.isBlank(ownerdept)){
			
			map.addAttribute("owneruserList",UKDataContext.getContext().getBean(UserRepository.class).findByOrganAndDatastatusAndOrgi(UKDataContext.UKEFU_SYSTEM_NO_DAT, false, user.getOrgi()));
		}else{
			map.addAttribute("owneruserList",UKDataContext.getContext().getBean(UserRepository.class).findByOrganAndDatastatusAndOrgi(ownerdept, false, user.getOrgi()));
			
		}
		map.addAttribute("skillList", organRes.findAll(CallCenterUtils.getAuthOrgan(userRoleRes, callOutRoleRes, user)));
		map.put("taskList",UKDataContext.getContext().getBean(CallOutTaskRepository.class).findByActidAndOrgi(actid, user.getOrgi()));
		map.put("allUserList",UKDataContext.getContext().getBean(UserRepository.class).findByOrgiAndDatastatus(user.getOrgi(), false));
		//JobDetail act = batchRes.findByIdAndOrgi(actid, user.getOrgi());
		//if(act != null){
		//	map.put("salestatusList",UKDataContext.getContext().getBean(SaleStatusRepository.class).findByOrgiAndActivityid(user.getOrgi(), act.getDicid()));
		//}
		map.addAttribute("statusList",UKeFuDic.getInstance().getDic("com.dic.callout.activity"));
	}
	/**
	 * 指定活动，已设置的分配数
	 * @param map
	 * @param activityid
	 * @param user
	 */
	public static void getNamenum(ModelMap map,String activityid,User user){
		
		CallAgentRepository callAgentRes = UKDataContext.getContext().getBean(CallAgentRepository.class);
		
		List<CallAgent> actList = callAgentRes.findByOrgiAndActid(user.getOrgi(), activityid);
    	int namenum = 0;
    	if(actList.size() > 0 ){
    		for(CallAgent callAgent : actList){
    			if(callAgent.getDisnum() > 0){
    				namenum = namenum + callAgent.getDisnum();
    			}
    		}
    	}
    	map.put("namenum", namenum);
	}
	/**
	 * 查询目前存在的部门
	 * 已分配部门的坐席，如果部门被删之后，这个方法可以把这些用户过滤掉
	 * @param user
	 * @return
	 */
	public static List<String> getExistOrgan(User user){
		
		UserRoleRepository userRoleRes = UKDataContext.getContext().getBean(UserRoleRepository.class) ;
		CallOutRoleRepository callOutRoleRes = UKDataContext.getContext().getBean(CallOutRoleRepository.class) ;
		OrganRepository organRes = UKDataContext.getContext().getBean(OrganRepository.class) ;
		
		final List<String> organList = CallCenterUtils.getAuthOrgan(userRoleRes, callOutRoleRes, user);
		
		List<Organ> organAllList = organRes.findByOrgi(user.getOrgi());
		
		final List<String> tempList = new ArrayList<String>();
		
		for(String organid : organList){
			for(Organ organ : organAllList){
				if(organid.equals(organ.getId())){
					tempList.add(organid);
				}
			}
		}
		return tempList ;
	}
	/**
	 * 分配给坐席的名单，单个名单，回收到池子
	 * @param task
	 * @param batch
	 * @param callOutFilter
	 */
	public static void getAgentRenum(CallOutTask task, JobDetail batch, CallOutFilter callOutFilter){
		
		CallOutTaskRepository callOutTaskRes = UKDataContext.getContext().getBean(CallOutTaskRepository.class) ;
		JobDetailRepository batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class) ;
		CallOutFilterRepository callOutFilterRes = UKDataContext.getContext().getBean(CallOutFilterRepository.class) ;
		
		//修改，拨打任务
		if(task != null){
			task.setAssigned(task.getAssigned() - 1);//分配到坐席数
			task.setNotassigned(task.getNotassigned() + 1);//未分配数 
			task.setRenum(task.getRenum() + 1);//回收到池子数
			callOutTaskRes.save(task);
		}
		
		//修改，批次
		if(batch != null){
			batch.setAssigned(batch.getAssigned() - 1);//已分配
			batch.setNotassigned(batch.getNotassigned() + 1);//未分配
			batchRes.save(batch);
		}
		
		//修改，筛选记录
		if(callOutFilter != null){
			callOutFilter.setAssigned(callOutFilter.getAssigned() - 1);//分配给坐席数
			callOutFilter.setRenum(callOutFilter.getRenum() + 1);//回收到池子数
			callOutFilter.setNotassigned(callOutFilter.getNotassigned() + 1);//未分配数
			callOutFilterRes.save(callOutFilter);
		}
	} 
	
	/**
	 * 分配给坐席的名单，单个名单，回收到部门
	 * @param task
	 * @param callOutFilter
	 */
	public static void getAgentReorgannum(CallOutTask task, CallOutFilter callOutFilter){
		
		CallOutTaskRepository callOutTaskRes = UKDataContext.getContext().getBean(CallOutTaskRepository.class) ;
		CallOutFilterRepository callOutFilterRes = UKDataContext.getContext().getBean(CallOutFilterRepository.class) ;
		
		//修改，拨打任务
		if(task != null){
			task.setNotassigned(task.getNotassigned() + 1);//未分配数 
			task.setAssignedorgan(task.getAssignedorgan() - 1);//分配到部门数
			task.setReorgannum(task.getReorgannum() + 1);//回收到部门数
			callOutTaskRes.save(task);
		}
		
		
		//修改，筛选记录
		if(callOutFilter != null){
			callOutFilter.setAssigned(callOutFilter.getAssigned() - 1);//分配给坐席数
			callOutFilter.setReorgannum(callOutFilter.getReorgannum() + 1);//回收到部门数
			callOutFilterRes.save(callOutFilter);
		}
	}
	
	/**
	 * 分配给部门的名单，单个名单，回收到池子
	 * @param task
	 * @param batch
	 * @param callOutFilter
	 */
	public static void getOrganRenum(CallOutTask task, JobDetail batch, CallOutFilter callOutFilter){
		
		CallOutTaskRepository callOutTaskRes = UKDataContext.getContext().getBean(CallOutTaskRepository.class) ;
		JobDetailRepository batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class) ;
		CallOutFilterRepository callOutFilterRes = UKDataContext.getContext().getBean(CallOutFilterRepository.class) ;
		
		//修改，拨打任务
		if(task != null){
			task.setAssignedorgan(task.getAssignedorgan() - 1);//分配到部门数
			task.setNotassigned(task.getNotassigned() + 1);//未分配数 
			task.setRenum(task.getRenum() + 1);//回收到池子数
			callOutTaskRes.save(task);
		}
		
		//修改，批次
		if(batch != null){
			batch.setAssigned(batch.getAssigned() - 1);//已分配
			batch.setNotassigned(batch.getNotassigned() + 1);//未分配
			batchRes.save(batch);
		}
		
		//修改，筛选记录
		if(callOutFilter != null){
			callOutFilter.setAssignedorgan(callOutFilter.getAssignedorgan() - 1);//分配到部门数
			callOutFilter.setRenum(callOutFilter.getRenum() + 1);//回收到池子数
			callOutFilter.setNotassigned(callOutFilter.getNotassigned() + 1);//未分配数
			callOutFilterRes.save(callOutFilter);
		}
	} 
	
	/**
	 * 获取指定活动，已分配的名单数
	 * @param actid
	 * @param user
	 * @return
	 */
	public static int getActDisnum(@Valid String actid,User user, @Valid int p, @Valid int ps){
		BoolQueryBuilder queryBuilder = new BoolQueryBuilder();
		queryBuilder.must(termQuery("actid", actid));// 活动ID
		queryBuilder.mustNot(termQuery("status", UKDataContext.NamesDisStatusType.NOT.toString()));
		PageImpl<UKDataBean> dataList = SearchTools.search(queryBuilder,p, ps);
		return dataList.getContent().size();
	}
	/**
	 * 获取语音渠道中的查询条件
	 * @param map
	 * @param orgi
	 */
	public static void getCallCenterSearch(ModelMap map,@Valid String orgi){
		UserRepository userRes = UKDataContext.getContext().getBean(UserRepository.class) ;
		OrganRepository organRes = UKDataContext.getContext().getBean(OrganRepository.class) ;
		
		map.put("allUserList",userRes.findByOrgi(orgi));
		map.put("skillList",organRes.findByOrgi(orgi));
	}
	
	public static void saveCallOutNamesHis(@Valid CallOutNames callOutNames) {
		CallOutNamesHisRepository calloutRes = UKDataContext.getContext().getBean(CallOutNamesHisRepository.class);
		CallOutNamesHis callOutNamesHis = new CallOutNamesHis();
		callOutNamesHis.setActid(callOutNames.getActid());
		callOutNamesHis.setBatid(callOutNames.getBatid());
		callOutNamesHis.setBatname(callOutNames.getBatname());
		callOutNamesHis.setCalls(callOutNames.getCalls());
		callOutNamesHis.setCalltype(callOutNames.getCalltype());
		callOutNamesHis.setCreater(callOutNames.getCreater());
		callOutNamesHis.setCreatetime(new Date());
		callOutNamesHis.setDataid(callOutNames.getDataid());
		callOutNamesHis.setDatastatus(callOutNames.getDatastatus());
		callOutNamesHis.setDistype(callOutNames.getDistype());
		callOutNamesHis.setFaildcalls(callOutNames.getFaildcalls());
		callOutNamesHis.setFailed(callOutNames.isFailed());
		callOutNamesHis.setFilterid(callOutNames.getFilterid());
		callOutNamesHis.setFirstcallstatus(callOutNames.getFirstcallstatus());
		callOutNamesHis.setFirstcalltime(callOutNames.getFirstcalltime());
		callOutNamesHis.setInvalid(callOutNames.isInvalid());
		callOutNamesHis.setLeavenum(callOutNames.getLeavenum());
		callOutNamesHis.setMemo(callOutNames.getMemo());
		callOutNamesHis.setMetaname(callOutNames.getMetaname());
		callOutNamesHis.setName(callOutNames.getName());
		callOutNamesHis.setOptime(callOutNames.getOptime());
		callOutNamesHis.setOrgan(callOutNames.getOrgan());
		callOutNamesHis.setOrgi(callOutNames.getOrgi());
		callOutNamesHis.setOwnerdept(callOutNames.getOwnerdept());
		callOutNamesHis.setOwneruser(callOutNames.getOwneruser());
		callOutNamesHis.setPhonenumber(callOutNames.getPhonenumber());
		callOutNamesHis.setPreviewtime(callOutNames.getPreviewtime());
		callOutNamesHis.setPreviewtimes(callOutNames.getPreviewtimes());
		callOutNamesHis.setReservation(callOutNames.isReservation());
		callOutNamesHis.setServicetype(callOutNames.getServicetype());
		callOutNamesHis.setStatus(callOutNames.getStatus());
		callOutNamesHis.setTaskid(callOutNames.getTaskid());
		callOutNamesHis.setTaskname(callOutNames.getTaskname());
		callOutNamesHis.setUpdatetime(callOutNames.getUpdatetime());
		callOutNamesHis.setWorkstatus(callOutNames.getWorkstatus());
		
		calloutRes.save(callOutNamesHis);
	}
}
