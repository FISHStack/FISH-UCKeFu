package com.ukefu.webim.web.handler.resource;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.web.handler.Handler;

@Controller
@RequestMapping("/res")
public class UsersResourceController extends Handler {
	@Autowired
	private UserRepository userRes ;
	
	@RequestMapping("/users")
    @Menu(type = "res" , subtype = "users")
    public ModelAndView add(ModelMap map , HttpServletRequest request , @Valid String q , @Valid String id) {
		if(q==null){
			q = "" ;
		}
    	map.addAttribute("usersList", userRes.findByDatastatusAndOrgiAndUsernameLike(false , super.getOrgi(request), "%"+q+"%" , new PageRequest(0, 10))) ;
        return request(super.createRequestPageTempletResponse("/public/users"));
    }
}
