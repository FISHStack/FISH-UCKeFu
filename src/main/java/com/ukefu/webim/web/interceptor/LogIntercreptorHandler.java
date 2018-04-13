package com.ukefu.webim.web.interceptor;

import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ukefu.core.UKDataContext;
import com.ukefu.util.Menu;
import com.ukefu.util.UKTools;
import com.ukefu.webim.web.model.RequestLog;
import com.ukefu.webim.web.model.User;

/**
 * 系统访问记录
 * @author admin
 *
 */
public class LogIntercreptorHandler implements org.springframework.web.servlet.HandlerInterceptor{
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	    
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		HandlerMethod  handlerMethod = (HandlerMethod ) arg2 ;
	    Object hander = handlerMethod.getBean() ;
	    RequestMapping obj = handlerMethod.getMethod().getAnnotation(RequestMapping.class) ;
	    if(true){
	    	RequestLog log = new RequestLog();
		    log.setStarttime(new Date()) ;
		    
			log.setClassname(hander.getClass().toString()) ;
			log.setName(obj.name());
			log.setMethodname(handlerMethod.toString()) ;
			log.setIp(request.getRemoteAddr()) ;
			
			log.setUrl(request.getRequestURI());
			
			log.setHostname(request.getRemoteHost()) ;
			log.setEndtime(new Date());
			log.setType(UKDataContext.LogTypeEnum.REQUEST.toString()) ;
			log.setQuerytime(log.getEndtime().getTime()-log.getStarttime().getTime()) ;
			User user = (User) request.getSession(true).getAttribute(UKDataContext.USER_SESSION_NAME) ;
			if(user!=null){
				log.setUserid(user.getId()) ;
				log.setUsername(user.getUsername()) ;
				log.setUsermail(user.getEmail()) ;
				log.setOrgi(user.getOrgi());
			}
			StringBuffer str = new StringBuffer();
			Enumeration<String> names = request.getParameterNames();
			while(names.hasMoreElements()){
				String paraName=(String)names.nextElement();
				str.append(paraName).append("=").append(request.getParameter(paraName)).append(",");
			}
			
			Menu menu = handlerMethod.getMethod().getAnnotation(Menu.class) ;
			if(menu!=null){
				log.setFuntype(menu.type());
				log.setFundesc(menu.subtype());
				log.setName(menu.name());
			}
			
			log.setParameters(str.toString());
			UKTools.published(log);
	    }
		return true;
	}
}
