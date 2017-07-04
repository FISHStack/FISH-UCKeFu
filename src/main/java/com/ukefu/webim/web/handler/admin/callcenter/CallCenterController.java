package com.ukefu.webim.web.handler.admin.callcenter;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.elasticsearch.common.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.util.extra.CallCenterInterface;
import com.ukefu.webim.service.repository.PbxHostRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.PbxHost;

@Controller
@RequestMapping("/admin/callcenter")
public class CallCenterController extends Handler{
	
	@Autowired
	private PbxHostRepository pbxHostRes ;
	
	@RequestMapping(value = "/index")
    @Menu(type = "callcenter" , subtype = "callcenter" , access = false , admin = true)
    public ModelAndView index(ModelMap map , HttpServletRequest request) {
		map.addAttribute("pbxHostList" , pbxHostRes.findByOrgi(super.getOrgi(request)));
    	return request(super.createAdminTempletResponse("/admin/callcenter/index"));
    }
	
	@RequestMapping(value = "/pbxhost")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView pbxhost(ModelMap map , HttpServletRequest request) {
		map.addAttribute("pbxHostList" , pbxHostRes.findByOrgi(super.getOrgi(request)));
    	return request(super.createRequestPageTempletResponse("/admin/callcenter/pbxhost/index"));
    }
	
	@RequestMapping(value = "/pbxhost/add")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView pbxhostadd(ModelMap map , HttpServletRequest request) {
    	return request(super.createRequestPageTempletResponse("/admin/callcenter/pbxhost/add"));
    }
	
	@RequestMapping(value = "/pbxhost/save")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView pbxhostsave(ModelMap map , HttpServletRequest request , @Valid PbxHost pbxHost) {
		if(!StringUtils.isBlank(pbxHost.getName()) && !StringUtils.isBlank(pbxHost.getName())){
			int count = pbxHostRes.countByHostnameAndOrgi(pbxHost.getHostname(), super.getOrgi(request)) ;
			if(count == 0){	
				pbxHost.setOrgi(super.getOrgi(request));
				pbxHost.setCreater(super.getUser(request).getId());
				pbxHostRes.save(pbxHost) ;
				CallCenterInterface callCenterImpl = (CallCenterInterface) UKDataContext.getContext().getBean("callcenter") ;
				if(callCenterImpl!=null){
					callCenterImpl.init(pbxHost);
				}
			}
		}
		return request(super.createRequestPageTempletResponse("redirect:/admin/callcenter/pbxhost.html"));
    }
	
	@RequestMapping(value = "/pbxhost/edit")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView pbxhostedit(ModelMap map , HttpServletRequest request , @Valid String id) {
		map.addAttribute("pbxHost" , pbxHostRes.findByIdAndOrgi(id, super.getOrgi(request)));
    	return request(super.createRequestPageTempletResponse("/admin/callcenter/pbxhost/edit"));
    }
	
	@RequestMapping(value = "/pbxhost/update")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView pbxhostupdate(ModelMap map , HttpServletRequest request , @Valid PbxHost pbxHost) {
		if(!StringUtils.isBlank(pbxHost.getId())){
			PbxHost destHost = pbxHostRes.findByIdAndOrgi(pbxHost.getId(), super.getOrgi(request)) ;
			destHost.setHostname(pbxHost.getHostname());
			destHost.setIpaddr(pbxHost.getIpaddr());
			destHost.setName(pbxHost.getName());
			destHost.setPort(pbxHost.getPort());
			if(!StringUtils.isBlank(pbxHost.getPassword())){
				destHost.setPassword(pbxHost.getPassword());
			}
			pbxHostRes.save(destHost) ;

			CallCenterInterface callCenterImpl = (CallCenterInterface) UKDataContext.getContext().getBean("callcenter") ;
			if(callCenterImpl!=null){
				callCenterImpl.init(destHost);
			}
		}
		return request(super.createRequestPageTempletResponse("redirect:/admin/callcenter/pbxhost.html"));
    }
	
	@RequestMapping(value = "/pbxhost/delete")
    @Menu(type = "callcenter" , subtype = "pbxhost" , access = false , admin = true)
    public ModelAndView mediadelete(ModelMap map , HttpServletRequest request , @Valid String id) {
		if(!StringUtils.isBlank(id)){
			pbxHostRes.delete(id);
			
			CallCenterInterface callCenterImpl = (CallCenterInterface) UKDataContext.getContext().getBean("callcenter") ;
			if(callCenterImpl!=null){
				callCenterImpl.remove(id);
			}
		}
		return request(super.createRequestPageTempletResponse("redirect:/admin/callcenter/pbxhost.html"));
    }
}
