package com.ukefu.webim;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;

import com.ukefu.core.UKDataContext;

public class ServletInitializer extends SpringBootServletInitializer{
	
	@Override  
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {  
        return application.sources(Application.class);  
    }  
}
