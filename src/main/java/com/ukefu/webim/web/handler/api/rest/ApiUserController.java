package com.ukefu.webim.web.handler.api.rest;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ukefu.util.Menu;
import com.ukefu.webim.service.repository.UserRepository;
import com.ukefu.webim.service.repository.UserRoleRepository;
import com.ukefu.webim.web.handler.Handler;
import com.ukefu.webim.web.model.User;

@RestController
@RequestMapping("/api/user")
public class ApiUserController extends Handler{

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserRoleRepository userRoleRes ;


	@RequestMapping(method = RequestMethod.GET)
	@Menu(type = "apps" , subtype = "user" , access = true)
    public ResponseEntity<User> get(HttpServletRequest request , @RequestParam String id) {
    	User user = null ;
    	if(!StringUtils.isBlank(id)){
    		user = userRepository.findByIdAndOrgi(id, super.getOrgi(request)) ;
    	}
        return new ResponseEntity<>(user, HttpStatus.OK);
    }
}