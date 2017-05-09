package com.ukefu.webim.web.handler.apps.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.AgentServiceRepository;
import com.ukefu.webim.service.repository.AgentStatusRepository;
import com.ukefu.webim.service.repository.AgentUserRepository;
import com.ukefu.webim.service.repository.LeaveMsgRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AgentStatus;
import com.ukefu.webim.web.model.AgentUser;
import com.ukefu.webim.web.model.LeaveMsg;
import com.ukefu.webim.web.model.User;

@Controller
@RequestMapping("/service")
public class ChatServiceController extends Handler{
	
	@Autowired
	private AgentServiceRepository agentServiceRes ;
	
	@Autowired
	private AgentUserRepository agentUserRes ;
	
	@Autowired
	private AgentStatusRepository agentStatusRepository ;
	
	@Autowired
	private LeaveMsgRepository leaveMsgRes ;
	
	@Autowired
	private UserRepository userRes ;
	
	@RequestMapping("/history/index")
    @Menu(type = "service" , subtype = "history" , admin= true)
    public ModelAndView index(ModelMap map , HttpServletRequest request) {
		map.put("agentServiceList", agentServiceRes.findByOrgiAndStatus(super.getOrgi(request), UKDataContext.AgentUserStatusEnum.END.toString() ,new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "createtime"))) ;
        return request(super.createAppsTempletResponse("/apps/service/history/index"));
    }
	
	@RequestMapping("/current/index")
    @Menu(type = "service" , subtype = "current" , admin= true)
    public ModelAndView current(ModelMap map , HttpServletRequest request) {
		map.put("agentServiceList", agentServiceRes.findByOrgiAndStatus(super.getOrgi(request), UKDataContext.AgentUserStatusEnum.INSERVICE.toString() ,new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "createtime"))) ;
        return request(super.createAppsTempletResponse("/apps/service/current/index"));
    }
	@RequestMapping("/quene/index")
    @Menu(type = "service" , subtype = "quene" , admin= true)
    public ModelAndView quene(ModelMap map , HttpServletRequest request) {
		Page<AgentUser> agentUserList = agentUserRes.findByOrgiAndStatus(super.getOrgi(request), UKDataContext.AgentUserStatusEnum.INQUENE.toString() ,new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "createtime")) ;
		for(AgentUser agentUser : agentUserList.getContent()){
			agentUser.setWaittingtime((int) (System.currentTimeMillis() - agentUser.getCreatetime().getTime()));
		}
		map.put("agentUserList", agentUserList) ;
        return request(super.createAppsTempletResponse("/apps/service/quene/index"));
    }
	
	@RequestMapping("/agent/index")
    @Menu(type = "service" , subtype = "onlineagent" , admin= true)
    public ModelAndView agent(ModelMap map , HttpServletRequest request) {
		List<AgentStatus> agentStatusList = agentStatusRepository.findByOrgi(super.getOrgi(request)) ;
		for(int i=0 ; i<agentStatusList.size() ; ){
			AgentStatus agentStatus = agentStatusList.get(i) ;
			if(CacheHelper.getAgentStatusCacheBean().getCacheObject(agentStatus.getAgentno(), super.getOrgi(request))==null) {
				agentStatusRepository.delete(agentStatus); 
				agentStatusList.remove(i) ;
				continue ;
			}else{
				agentStatusList.set(i, (AgentStatus) CacheHelper.getAgentStatusCacheBean().getCacheObject(agentStatus.getAgentno(), super.getOrgi(request))) ;	
			}
			i++ ;
		}
		map.put("agentStatusList", agentStatusList) ;
        return request(super.createAppsTempletResponse("/apps/service/agent/index"));
    }
	
	@RequestMapping("/agent/offline")
    @Menu(type = "service" , subtype = "offline" , admin= true)
    public ModelAndView offline(ModelMap map , HttpServletRequest request , @Valid String id) {
		
		AgentStatus agentStatus = agentStatusRepository.findByIdAndOrgi(id, super.getOrgi(request));
		if(agentStatus!=null){
			agentStatusRepository.delete(agentStatus);
		}
    	CacheHelper.getAgentStatusCacheBean().delete(agentStatus.getAgentno(), super.getOrgi(request));;
    	ServiceQuene.publishMessage(super.getOrgi(request));
    	
		
        return request(super.createRequestPageTempletResponse("redirect:/service/agent/index.html"));
    }
	
	@RequestMapping("/user/index")
    @Menu(type = "service" , subtype = "userlist" , admin= true)
    public ModelAndView user(ModelMap map , HttpServletRequest request) {
		Page<User> userList = userRes.findByOrgiAndAgent(super.getOrgi(request), true,  new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "createtime")) ;
		for(User user : userList.getContent()){
			if(CacheHelper.getAgentStatusCacheBean().getCacheObject(user.getId(), super.getOrgi(request))!=null){
				user.setOnline(true);
			}
		}
		map.put("userList", userList) ;
        return request(super.createAppsTempletResponse("/apps/service/user/index"));
    }
	
	@RequestMapping("/leavemsg/index")
    @Menu(type = "service" , subtype = "leavemsg" , admin= true)
    public ModelAndView leavemsg(ModelMap map , HttpServletRequest request) {
		Page<LeaveMsg> leaveMsgList = leaveMsgRes.findByOrgi(super.getOrgi(request),new PageRequest(super.getP(request), super.getPs(request), Direction.DESC , "createtime")) ;
		map.put("leaveMsgList", leaveMsgList) ;
        return request(super.createAppsTempletResponse("/apps/service/leavemsg/index"));
    }
	
	@RequestMapping("/leavemsg/delete")
    @Menu(type = "service" , subtype = "leavemsg" , admin= true)
    public ModelAndView leavemsg(ModelMap map , HttpServletRequest request , @Valid String id) {
		if(!StringUtils.isBlank(id)){
			leaveMsgRes.delete(id);
		}
		return request(super.createRequestPageTempletResponse("redirect:/service/leavemsg/index.html"));
    }
}
