package com.ukefu.webim.web.handler.apps.callcenter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.AclRepository;
import com.ukefu.webim.service.repository.CallCenterSkillRepository;
import com.ukefu.webim.service.repository.ExtentionRepository;
import com.ukefu.webim.service.repository.PbxHostRepository;
import com.ukefu.webim.service.repository.RouterRulesRepository;
import com.ukefu.webim.service.repository.SkillExtentionRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.Extention;
import com.ukefu.webim.web.model.PbxHost;

@Controller
@RequestMapping("/apps/callcenter")
public class ExtentionController extends Handler{
	
	@Autowired
	private PbxHostRepository pbxHostRes ;
	
	@Autowired
	private ExtentionRepository extentionRes;
	
	@Autowired
	private AclRepository aclRes;
	
	@Autowired
	private RouterRulesRepository routerRes;
	
	@Autowired
	private SkillExtentionRepository skillExtentionRes ;
	
	@Autowired
	private CallCenterSkillRepository skillRes ;
	
	@RequestMapping(value = "/extention" , method = RequestMethod.POST)
    @Menu(type = "callcenter" , subtype = "extention" , access = true)
    public ModelAndView index(ModelMap map , HttpServletRequest request , @Valid String hostname , @Valid String key_value) {
		List<PbxHost> pbxHostList = pbxHostRes.findByHostnameOrIpaddrAndOrgi(hostname, hostname, super.getOrgi(request)) ;
		PbxHost pbxHost = null ;
		if(pbxHostList!=null && pbxHostList.size() > 0){
			pbxHost = pbxHostList.get(0) ;
			map.addAttribute("pbxHost" , pbxHost);
			map.addAttribute("skillList" , skillRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
			map.addAttribute("extentionList" , extentionRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
		}
		
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/index"));
    }
	
	@RequestMapping(value = "/configuration" , method = RequestMethod.POST)
    @Menu(type = "callcenter" , subtype = "configuration" , access = true)
    public ModelAndView configuration(ModelMap map , HttpServletRequest request , @Valid String hostname , @Valid String key_value) {
		
		List<PbxHost> pbxHostList = pbxHostRes.findByHostnameOrIpaddrAndOrgi(hostname, hostname, super.getOrgi(request)) ;
		PbxHost pbxHost = null ;
		if(pbxHostList!=null && pbxHostList.size() > 0){
			pbxHost = pbxHostList.get(0) ;
			map.addAttribute("pbxHost" , pbxHost);
			map.addAttribute("skillList" , skillRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
			map.addAttribute("skillExtentionList" , skillExtentionRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
			map.addAttribute("extentionList" , extentionRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
			map.addAttribute("aclList" , aclRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
		}
		
		ModelAndView view = request(super.createRequestPageTempletResponse("/apps/business/callcenter/notfound"));
		if(key_value!=null && key_value.equals("callcenter.conf")){
			view = request(super.createRequestPageTempletResponse("/apps/business/callcenter/configure/callcenter"));
		}else if(key_value!=null && key_value.equals("acl.conf")){
			view = request(super.createRequestPageTempletResponse("/apps/business/callcenter/configure/acl"));
		}else if(key_value!=null && key_value.equals("ivr.conf")){
			view = request(super.createRequestPageTempletResponse("/apps/business/callcenter/configure/ivr"));
		}
    	return view;
    }
	
	@RequestMapping(value = "/dialplan" , method = RequestMethod.POST)
    @Menu(type = "callcenter" , subtype = "dialplan" , access = true)
    public ModelAndView dialplan(ModelMap map , HttpServletRequest request , @Valid String hostname , @Valid String key_value) {
		
		List<PbxHost> pbxHostList = pbxHostRes.findByHostnameOrIpaddrAndOrgi(hostname, hostname, super.getOrgi(request)) ;
		PbxHost pbxHost = null ;
		if(pbxHostList!=null && pbxHostList.size() > 0){
			pbxHost = pbxHostList.get(0) ;
			map.addAttribute("pbxHost" , pbxHost);
			map.addAttribute("routerList" , routerRes.findByHostidAndOrgi(pbxHost.getId() , super.getOrgi(request)));
		}
		
		return request(super.createRequestPageTempletResponse("/apps/business/callcenter/dialplan/index"));
    }
	
	@RequestMapping(value = "/extention/detail" , method = RequestMethod.GET)
    @Menu(type = "callcenter" , subtype = "extention" , access = false)
    public ModelAndView detail(ModelMap map , HttpServletRequest request , HttpServletResponse response ,@Valid String extno) {
		List<Extention> extentionList = extentionRes.findByExtentionAndOrgi(extno, super.getOrgi(request)) ;
		if(extentionList!=null && extentionList.size() == 1){
			map.addAttribute("extention" , extentionList.get(0));
		}
		response.setContentType("Content-type: text/json; charset=utf-8"); 
    	return request(super.createRequestPageTempletResponse("/apps/business/callcenter/extention/detail"));
    }
	
}
