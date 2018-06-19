package com.ukefu.webim.web.handler.apps.callcenter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.util.mobile.MobileAddress;
import com.ukefu.util.mobile.MobileNumberUtils;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.SipTrunkRepository;
import com.ukefu.webim.util.CallCenterUtils;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.SipTrunk;
import com.ukefu.webim.web.model.SysDic;
import com.ukefu.webim.web.model.UKeFuDic;

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
    public ModelAndView detail(ModelMap map , HttpServletRequest request , HttpServletResponse response ,@Valid String extno,@Valid String dial) throws IOException, TemplateException {
		SipTrunk sipTrunk = CallCenterUtils.siptrunk(extno, sipTrunkRes, extentionRes) ;
		map.addAttribute("siptrunk" , sipTrunk);
		String prefix = "" ;
		if(sipTrunk!=null && !StringUtils.isBlank(dial) && "1".equals(sipTrunk.getPrefix()) && !StringUtils.isBlank(sipTrunk.getCity())) {  //启用了异地号码前加拨0
			MobileAddress address = MobileNumberUtils.getAddress(dial) ;
			SysDic dic = UKeFuDic.getInstance().getDicItem(sipTrunk.getCity()) ;
			if(!(dic!= null && (dic.getName().equals(address.getCity()) || dic.getName().indexOf(address.getCity()) > 0))) {
				prefix = "0" ;
					
			}
			map.addAttribute("prefix" , prefix);
		}
		response.setContentType("Content-type: text/plain; charset=utf-8"); 
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/siptrunk"));
    }
}
