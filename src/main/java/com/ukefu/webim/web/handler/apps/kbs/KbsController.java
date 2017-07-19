package com.ukefu.webim.web.handler.apps.kbs;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.web.handler.Handler;

@Controller
@RequestMapping({"/apps/kbs"})
public class KbsController extends Handler{
	
	@Autowired
	private UserRepository userRes;
	
	@RequestMapping({"/index"})
	@Menu(type="apps", subtype="kbs")
	public ModelAndView index(ModelMap map , HttpServletRequest request){
		return request(super.createAppsTempletResponse("/apps/business/kbs/index"));
	}
}
