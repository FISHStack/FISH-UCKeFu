package com.ukefu.webim.util;

import java.util.ArrayList;


import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.ui.ModelMap;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.CallAgentRepository;
import com.ukefu.webim.service.repository.CallOutRoleRepository;
import com.ukefu.webim.service.repository.CallOutTaskRepository;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.FormFilterRepository;
import com.ukefu.webim.service.repository.JobDetailRepository;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.SipTrunkRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.UserRoleRepository;
import com.ukefu.webim.web.model.CallAgent;
import com.ukefu.webim.web.model.CallOutRole;
import com.ukefu.webim.web.model.Extention;
import com.ukefu.webim.web.model.FormFilter;
import com.ukefu.webim.web.model.JobDetail;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.SipTrunk;
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
	
	public static void getAllCallOutList(ModelMap map, User user,String ownerdept, String actid){
		JobDetailRepository batchRes = UKDataContext.getContext().getBean(JobDetailRepository.class) ;
		UserRoleRepository userRoleRes = UKDataContext.getContext().getBean(UserRoleRepository.class) ;
		CallOutRoleRepository callOutRoleRes = UKDataContext.getContext().getBean(CallOutRoleRepository.class) ;
		FormFilterRepository filterRes = UKDataContext.getContext().getBean(FormFilterRepository.class) ;
		OrganRepository organRes = UKDataContext.getContext().getBean(OrganRepository.class) ;
		
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
		
	}
	
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
}
