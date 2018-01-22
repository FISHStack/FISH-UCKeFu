package com.ukefu.webim.web.handler.apps.tenant;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.TenantRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.Tenant;

@Controller
@RequestMapping("/apps/tenant")
public class TenantController extends Handler{
	
	@Autowired
	private TenantRepository tenantRes;
	
    @RequestMapping("/index")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView index(ModelMap map , HttpServletRequest request) throws FileNotFoundException, IOException {
    	map.addAttribute("tenantList", tenantRes.findAll());
    	return request(super.createAdminTempletResponse("/apps/tenant/index"));
    }
    
    @RequestMapping("/add")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView add(ModelMap map , HttpServletRequest request) {
        return request(super.createRequestPageTempletResponse("/apps/tenant/add"));
    }
    
    @RequestMapping("/save")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView save(HttpServletRequest request ,@Valid Tenant tenant) throws NoSuchAlgorithmException {
    	tenantRes.save(tenant) ;
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index.html"));
    }
    
    @RequestMapping("/edit")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView edit(ModelMap map , HttpServletRequest request , @Valid String id) {
    	map.addAttribute("email", tenantRes.findById(id)) ;
        return request(super.createRequestPageTempletResponse("/apps/tenant/edit"));
    }
    
    @RequestMapping("/update")
    @Menu(type = "apps" , subtype = "tenant" , admin = true)
    public ModelAndView update(HttpServletRequest request ,@Valid Tenant tenant) throws NoSuchAlgorithmException {
    	Tenant temp = tenantRes.findById(tenant.getId()) ;
    	if(tenant!=null) {
    		tenant.setCreatetime(temp.getCreatetime());
    		tenantRes.save(tenant) ;
    	}
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index.html"));
    }
    
    @RequestMapping("/delete")
    @Menu(type = "apps" , subtype = "tenant")
    public ModelAndView delete(HttpServletRequest request ,@Valid Tenant tenant) {
    	Tenant temp = tenantRes.findById(tenant.getId()) ;
    	if(tenant!=null) {
    		tenantRes.delete(temp);
    	}
    	return request(super.createRequestPageTempletResponse("redirect:/apps/tenant/index.html"));
    }
}