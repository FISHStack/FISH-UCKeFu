package com.ukefu.webim.web.handler.apps.tenant;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.webim.service.acd.ServiceQuene;
import com.ukefu.webim.service.cache.CacheHelper;
import com.ukefu.webim.service.repository.OrganRepository;
import com.ukefu.webim.service.repository.OrgiSkillRelRepository;
import com.ukefu.webim.service.repository.TenantRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.AgentStatus;
import com.ukefu.webim.web.model.Organ;
import com.ukefu.webim.web.model.OrgiSkillRel;
import com.ukefu.webim.web.model.Tenant;

@Controller
@RequestMapping("/apps/tenant")
public class TenantController extends Handler{
	
	@Autowired
	private TenantRepository tenantRes;
	
	@Autowired
	private OrgiSkillRelRepository orgiSkillRelRes;
	
	@Autowired
	private OrganRepository organRes;
	
	@Value("${web.upload-path}")
    private String path;
    @RequestMapping("/index")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView index(ModelMap map , HttpServletRequest request,@Valid String msg) throws FileNotFoundException, IOException {
    	if(super.isTenantshare()) {
    		if("0".equals(super.getUser(request).getUsertype())) {
    			map.addAttribute("tenantList", tenantRes.findAll());
    		}else {
    			List<OrgiSkillRel> orgiSkillRelList = orgiSkillRelRes.findBySkillid((super.getUser(request)).getOrgan());
    			List<Tenant> tenantList = null;
    			if(!orgiSkillRelList.isEmpty()) {
    				tenantList = new ArrayList<Tenant>();
    				for(OrgiSkillRel orgiSkillRel:orgiSkillRelList) {
    					Tenant t = tenantRes.findById(orgiSkillRel.getOrgi());
    					if(t!=null) {
    						tenantList.add(t);
    					}
    				}
    			}
    			map.addAttribute("tenantList", tenantList);
    		}
    	}else{
    		map.addAttribute("tenantList", tenantRes.findById(super.getOrgi(request)));
    	}
    	map.addAttribute("msg",msg);
    	return request(super.createAppsTempletResponse("/apps/tenant/index"));
    }
    
    @RequestMapping("/add")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView add(ModelMap map , HttpServletRequest request) {
    	if(super.isTenantshare()) {
    		map.addAttribute("isShowSkillList",true);
    		List<Organ> organList = organRes.findByOrgiAndSkill(super.getOrgiByTenantshare(request), true);
        	map.addAttribute("skillList",organList);
    	}
        return request(super.createRequestPageTempletResponse("/apps/tenant/add"));
    }
    
    @RequestMapping("/save")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView save(HttpServletRequest request ,@Valid Tenant tenant, @RequestParam(value = "tenantpic", required = false) MultipartFile tenantpic,@Valid String skills) throws NoSuchAlgorithmException, IOException {
    	tenantRes.save(tenant) ;
    	if(tenantpic!=null && tenantpic.getOriginalFilename().lastIndexOf(".") > 0){
    		File logoDir = new File(path , "tenantpic");
    		if(!logoDir.exists()){
    			logoDir.mkdirs() ;
    		}
    		String fileName = "tenantpic/"+tenant.getId()+tenantpic.getOriginalFilename().substring(tenantpic.getOriginalFilename().lastIndexOf(".")) ;
    		FileCopyUtils.copy(tenantpic.getBytes(), new File(path , fileName));
    		tenant.setTenantlogo(fileName);
    	}
    	String tenantid = tenant.getId();
    	List<OrgiSkillRel>  orgiSkillRelList = orgiSkillRelRes.findByOrgi(tenantid) ;
    	orgiSkillRelRes.delete(orgiSkillRelList);
    	if(!StringUtils.isBlank(skills)){
    		String[] skillsarray = skills.split(",") ;
    		for(String skill : skillsarray){
    			OrgiSkillRel rel = new OrgiSkillRel();
    			rel.setOrgi(tenant.getId());
    			rel.setSkillid(skill);
    			rel.setCreater(super.getUser(request).getId());
    			rel.setCreatetime(new Date());
    			orgiSkillRelRes.save(rel) ;
    		}
    	}
    	
    	if(!StringUtils.isBlank(super.getUser(request).getOrgid())) {
    		tenant.setOrgid(super.getUser(request).getOrgid());
		}else {
			tenant.setOrgid(UKDataContext.SYSTEM_ORGI);
		}
    	tenantRes.save(tenant) ;
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index"));
    }
    
    @RequestMapping("/edit")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView edit(ModelMap map , HttpServletRequest request , @Valid String id) {
    	if(super.isTenantshare()) {
    		map.addAttribute("isShowSkillList",true);
    		List<Organ> organList = organRes.findByOrgiAndSkill(super.getOrgiByTenantshare(request), true);
        	map.addAttribute("skillList",organList);
        	List<OrgiSkillRel>  orgiSkillRelList = orgiSkillRelRes.findByOrgi(id) ;
        	map.addAttribute("orgiSkillRelList",orgiSkillRelList);
    	}
    	map.addAttribute("tenant", tenantRes.findById(id)) ;
        return request(super.createRequestPageTempletResponse("/apps/tenant/edit"));
    }
    
    @RequestMapping("/update")
    @Menu(type = "apps" , subtype = "tenant" , admin = true)
    public ModelAndView update(HttpServletRequest request ,@Valid Tenant tenant, @RequestParam(value = "tenantpic", required = false) MultipartFile tenantpic,@Valid String skills) throws NoSuchAlgorithmException, IOException {
    	Tenant temp = tenantRes.findById(tenant.getId()) ;
    	if(tenant!=null) {
    		tenant.setCreatetime(temp.getCreatetime());
    		if(tenantpic!=null && tenantpic.getOriginalFilename().lastIndexOf(".") > 0){
        		File logoDir = new File(path , "tenantpic");
        		if(!logoDir.exists()){
        			logoDir.mkdirs() ;
        		}
        		String fileName = "tenantpic/"+tenant.getId()+tenantpic.getOriginalFilename().substring(tenantpic.getOriginalFilename().lastIndexOf(".")) ;
        		FileCopyUtils.copy(tenantpic.getBytes(), new File(path , fileName));
        		tenant.setTenantlogo(fileName);
        	}else {
        		tenant.setTenantlogo(temp.getTenantlogo());
        	}
    		if(!StringUtils.isBlank(super.getUser(request).getOrgid())) {
        		tenant.setOrgid(super.getUser(request).getOrgid());
    		}else {
    			tenant.setOrgid(UKDataContext.SYSTEM_ORGI);
    		}
    		tenantRes.save(tenant) ;
    		List<OrgiSkillRel>  orgiSkillRelList = orgiSkillRelRes.findByOrgi(tenant.getId()) ;
        	orgiSkillRelRes.delete(orgiSkillRelList);
        	if(!StringUtils.isBlank(skills)){
        		String[] skillsarray = skills.split(",") ;
        		for(String skill : skillsarray){
        			OrgiSkillRel rel = new OrgiSkillRel();
        			rel.setOrgi(tenant.getId());
        			rel.setSkillid(skill);
        			rel.setCreater(super.getUser(request).getId());
        			rel.setCreatetime(new Date());
        			orgiSkillRelRes.save(rel) ;
        		}
        	}
    	}
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index"));
    }
    
    @RequestMapping("/delete")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView delete(HttpServletRequest request ,@Valid Tenant tenant) {
    	Tenant temp = tenantRes.findById(tenant.getId()) ;
    	if(tenant!=null) {
    		tenantRes.delete(temp);
    	}
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index"));
    }
    
    @RequestMapping("/switch")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView switchTenant(HttpServletRequest request ,@Valid Tenant tenant) {
    	ModelAndView view = request(super.createRequestPageTempletResponse("redirect:/"));
    	AgentStatus agentStatus = (AgentStatus)CacheHelper.getAgentStatusCacheBean().getCacheObject((super.getUser(request)).getId(), super.getOrgi(request));
    	if(agentStatus==null && ServiceQuene.getAgentUsers(super.getUser(request).getId(), super.getOrgi(request))==0) {
    		Tenant temp = tenantRes.findById(tenant.getId()) ;
        	if(temp!=null) {
        		request.getSession(true).setAttribute(UKDataContext.USER_CURRENT_ORGI_SESSION, temp.getId());
        	}
        	return view;
    	}
    	return request(super.createRequestPageTempletResponse("redirect:/?vt=orgi&msg=t0"));
    }
}