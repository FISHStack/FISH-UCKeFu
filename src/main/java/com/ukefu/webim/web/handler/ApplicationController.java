package com.ukefu.webim.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.web.model.User;

@Controller
public class ApplicationController extends Handler{
	
	@RequestMapping("/")
    public ModelAndView admin(HttpServletRequest request,@Valid String vt) {
		ModelAndView view = request(super.createRequestPageTempletResponse("/apps/index"));
		User user = super.getUser(request) ;
        view.addObject("agentStatusReport",ServiceQuene.getAgentReport(user.getOrgi())) ;
        if(!StringUtils.isBlank(vt)) {
        	 view.addObject("vt",true) ;
        }
        view.addObject("tenant",super.getTenant(request));
        view.addObject("istenantshare",super.isTenantshare());
		view.addObject("agentStatus",CacheHelper.getAgentStatusCacheBean().getCacheObject(user.getId(), user.getOrgi())) ;
        return view;
    }
}