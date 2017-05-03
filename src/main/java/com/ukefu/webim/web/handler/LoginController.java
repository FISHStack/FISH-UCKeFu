package com.ukefu.webim.web.handler;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.UserRoleRepository;
import com.ukefu.webim.web.model.User;
import com.ukefu.webim.web.model.UserRole;

/**
 *
 * @author UK
 * @version 1.0.0
 *
 */
@Controller
public class LoginController extends Handler{
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserRoleRepository userRoleRes ;

    @RequestMapping(value = "/login" , method=RequestMethod.GET)
    @Menu(type = "apps" , subtype = "user" , access = true)
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response  , @RequestHeader(value = "referer", required = false) String referer , @Valid String msg) {
    	ModelAndView view = request(super.createRequestPageTempletResponse("redirect:/"));
    	if(request.getSession(true).getAttribute(UKDataContext.USER_SESSION_NAME) ==null){
    		view = request(super.createRequestPageTempletResponse("/login"));
	    	if(!StringUtils.isBlank(request.getParameter("referer"))){
	    		referer = request.getParameter("referer") ;
	    	}
	    	if(!StringUtils.isBlank(referer)){
	    		view.addObject("referer", referer) ;
	    	}
    	}
    	if(!StringUtils.isBlank(msg)){
    		view.addObject("msg", msg) ;
    	}
        return view;
    }
    
    @RequestMapping(value = "/login" , method=RequestMethod.POST)
    @Menu(type = "apps" , subtype = "user" , access = true)
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response , @Valid User user ,@Valid String referer) {
    	ModelAndView view = request(super.createRequestPageTempletResponse("redirect:/"));
    	if(request.getSession(true).getAttribute(UKDataContext.USER_SESSION_NAME) ==null){
	        if(user!=null && user.getUsername()!=null){
		    	User loginUser = userRepository.findByUsernameAndPassword(user.getUsername() , UKTools.md5(user.getPassword())) ;
		        if(loginUser!=null){
		        	loginUser.setLogin(true);
		        	super.setUser(request, loginUser);
		        	if(!StringUtils.isBlank(referer)){
		        		view = request(super.createRequestPageTempletResponse("redirect:"+referer));
			    	}
		        	List<UserRole> userRoleList = userRoleRes.findByOrgiAndUser(loginUser.getOrgi(), loginUser);
		        	if(userRoleList!=null & userRoleList.size()>0){
		        		for(UserRole userRole : userRoleList){
		        			loginUser.getRoleList().add(userRole.getRole()) ;
		        		}
		        	}
		        	loginUser.setLastlogintime(new Date());
		        	if(!StringUtils.isBlank(loginUser.getId())){
		        		userRepository.save(loginUser) ;
		        	}
		        }else{
		        	view = request(super.createRequestPageTempletResponse("/login"));
		        	if(!StringUtils.isBlank(referer)){
			    		view.addObject("referer", referer) ;
			    	}
		        	view.addObject("msg", "0") ;
		        }
	        }
    	}
    	return view;
    }
    
    @RequestMapping("/logout")  
    public String logout(HttpServletRequest request  ){  
    	request.getSession().removeAttribute(UKDataContext.USER_SESSION_NAME) ;
         return "redirect:/";
    }  
    
}