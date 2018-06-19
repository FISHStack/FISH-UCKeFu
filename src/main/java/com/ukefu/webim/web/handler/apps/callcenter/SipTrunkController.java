package com.ukefu.webim.web.handler.apps.callcenter;

import java.util.List;

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
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.Extention;

@Controller
@RequestMapping("/apps/callcenter")
public class SipTrunkController extends Handler{
	
	@Autowired
	private ExtentionRepository extentionRes;
	
	@RequestMapping(value = "/siptrunk")
    @Menu(type = "callcenter" , subtype = "extention" , access = true)
    public ModelAndView detail(ModelMap map , HttpServletRequest request , HttpServletResponse response ,@Valid String extno) {
		List<Extention> extentionList = extentionRes.findByExtentionAndOrgi(extno, super.getOrgi(request)) ;
		if(extentionList!=null && extentionList.size() == 1){
			map.addAttribute("extention" , extentionList.get(0));
		}
		response.setContentType("Content-type: text/html; charset=utf-8"); 
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/siptrunk"));
    }
}
