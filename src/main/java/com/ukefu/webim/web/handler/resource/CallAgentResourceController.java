package com.ukefu.webim.web.handler.resource;

import java.util.List;



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
import com.ukefu.webim.util.CallCenterUtils;
import com.ukefu.webim.web.handler.Handler;

@Controller
public class CallAgentResourceController extends Handler{
	
	@Autowired
	private UserRepository userRes ;
	
	@RequestMapping("/res/agent")
    @Menu(type = "res" , subtype = "agent")
    public ModelAndView add(ModelMap map , HttpServletRequest request , @Valid String q) {
		if(q==null){
			q = "" ;
		}
		List<String> organIdList = CallCenterUtils.getExistOrgan(super.getUser(request));
    	map.addAttribute("owneruserList", userRes.findByOrganInAndDatastatusAndUsernameLikeOrUnameLike(organIdList, false, q, q,  new PageRequest(0, 5))) ;
    	return request(super.createRequestPageTempletResponse("/public/agent"));
    }
}