package com.ukefu.webim.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.web.model.User;

@Controller
public class ApplicationController extends Handler{
	
	@RequestMapping("/")
    public ModelAndView admin(HttpServletRequest request) {
		ModelAndView view = request(super.createRequestPageTempletResponse("/apps/index"));
		User user = super.getUser(request) ;
        view.addObject("agentStatusReport",ServiceQuene.getAgentReport(user.getOrgi())) ;
        view.addObject("tenant",super.getTenant(request));
        view.addObject("istenantshare",super.isEnabletneant());
        if(super.isEnabletneant()) {
        	//多租户启用 非超级管理员 一定要选择租户才能进入界面
        	if(!user.isSuperuser() && !StringUtils.isBlank(user.getOrgid()) && super.isTenantconsole() &&UKDataContext.SYSTEM_ORGI.equals(user.getOrgi())) {
        		view = request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index"));
        	}
        	if(StringUtils.isBlank(user.getOrgid())) {
        		view = request(super.createRequestPageTempletResponse("redirect:/apps/organization/add.html"));
        	}
        }
		view.addObject("agentStatus",CacheHelper.getAgentStatusCacheBean().getCacheObject(user.getId(), user.getOrgi())) ;
        return view;
    }
}