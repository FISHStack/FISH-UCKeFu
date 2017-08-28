package com.ukefu.webim.web.handler.apps.service;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.AgentServiceRepository;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.WeiXinUserRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AgentService;

@Controller
@RequestMapping("/service")
public class StatsController extends Handler{
	@Autowired
	private AgentServiceRepository agentServiceRes ;
	
	@Autowired
	private UserRepository userRes ;
	
	@Autowired
	private WeiXinUserRepository weiXinUserRes;
	
	
	@RequestMapping("/stats/coment")
    @Menu(type = "service" , subtype = "statcoment" , admin= true)
    public ModelAndView statcoment(ModelMap map , HttpServletRequest request , String userid , String agentservice , @Valid String channel) {
		Page<AgentService> agentServiceList = agentServiceRes.findByOrgiAndSatisfaction(super.getOrgi(request) , true ,new PageRequest(super.getP(request), super.getPs(request))) ;
		map.addAttribute("serviceList", agentServiceList) ;
		return request(super.createAppsTempletResponse("/apps/service/stats/comment"));
    }
	
	@RequestMapping("/stats/agent")
    @Menu(type = "service" , subtype = "statagent" , admin= true)
    public ModelAndView statagent(ModelMap map , HttpServletRequest request , String userid , String agentservice , @Valid String channel) {
		Page<AgentService> agentServiceList = agentServiceRes.findByOrgiAndSatisfaction(super.getOrgi(request) , true ,new PageRequest(super.getP(request), super.getPs(request))) ;
		map.addAttribute("serviceList", agentServiceList) ;
		return request(super.createAppsTempletResponse("/apps/service/stats/agent"));
    }
}
