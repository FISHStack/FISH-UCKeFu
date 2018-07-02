package com.ukefu.webim.web.handler.apps.callcenter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.SipTrunkRepository;
import com.ukefu.webim.util.CallCenterUtils;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.SipTrunk;

import freemarker.template.TemplateException;

@Controller
@RequestMapping("/apps/callcenter")
public class SipTrunkController extends Handler{
	
	@Autowired
	private ExtentionRepository extentionRes;
	
	@Autowired
	private SipTrunkRepository sipTrunkRes ;
	
	@RequestMapping(value = "/siptrunk")
    @Menu(type = "callcenter" , subtype = "extention" , access = true)
    public ModelAndView detail(ModelMap map , HttpServletRequest request , HttpServletResponse response ,@Valid String extno) throws IOException, TemplateException {
		SipTrunk sipTrunk = CallCenterUtils.siptrunk(extno, sipTrunkRes, extentionRes) ;
		map.addAttribute("siptrunk" , sipTrunk);
		response.setContentType("Content-type: text/plain; charset=utf-8"); 
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/siptrunk"));
    }
	
	@RequestMapping(value = "/agent")
    @Menu(type = "callcenter" , subtype = "agent" , access = true)
    public ModelAndView agent(ModelMap map , HttpServletRequest request , HttpServletResponse response ,@Valid String ani ,@Valid String called,@Valid String extno) throws IOException, TemplateException {
		SipTrunk sipTrunk = CallCenterUtils.siptrunk(extno, sipTrunkRes, extentionRes) ;
		map.addAttribute("siptrunk" , sipTrunk);
		response.setContentType("Content-type: text/plain; charset=utf-8"); 
		if(sipTrunk!=null) {
			
		}
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/siptrunk"));
    }
}
